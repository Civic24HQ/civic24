import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:citizen/ui/views/complete_profile/complete_profile_view.form.dart';
import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:utils/utils.dart';

class CompleteProfileViewModel extends FormViewModel {
  final _log = getLogger('CompleteProfileViewModel');
  final _navigationService = locator<RouterService>();
  final _userService = locator<UserService>();
  final _alertService = locator<AlertService>();

  String? countryValue;
  String? stateValue;
  String? cityValue;

  List<CountryOption> countryOptions = [];
  List<StateOption> stateOptions = [];
  List<String> cityOptions = [];

  bool get isProceedButtonDisabled =>
      (firstNameValue?.trim().isEmpty ?? true) ||
      (lastNameValue?.trim().isEmpty ?? true) ||
      (countryValue?.trim().isEmpty ?? true) ||
      (stateValue?.trim().isEmpty ?? true);

  Future<void> init() async {
    await _loadCountries();
  }

  Future<void> _loadCountries() async {
    try {
      setBusy(true);
      final countries = await csc.getAllCountries();
      countryOptions =
          countries.map((c) => CountryOption(c.name, c.isoCode)).toList()
            ..sort((a, b) => a.name.compareTo(b.name));
    } catch (e) {
      // TODO(Civic24): Implement Alert Service Dialog to display a message that countries could not be loaded
      countryOptions = [];
    } finally {
      setBusy(false);
      rebuildUi();
    }
  }

  Future<void> onCountryChanged(String? newValue) async {
    if (newValue == null || newValue == countryValue) return;

    countryValue = newValue;
    stateValue = null;
    cityValue = null;
    stateOptions = [];
    cityOptions = [];
    rebuildUi();

    final selected = countryOptions.where((c) => c.name == countryValue);
    if (selected.isEmpty) return;
    final iso2 = selected.first.iso2;

    try {
      setBusy(true);
      final states = await csc.getStatesOfCountry(iso2);
      stateOptions = states.map((s) => StateOption(s.name, s.isoCode)).toList()
        ..sort((a, b) => a.name.compareTo(b.name));
    } catch (e) {
      stateOptions = [];
    } finally {
      setBusy(false);
      rebuildUi();
    }
  }

  Future<void> onStateChanged(String? newValue) async {
    if (newValue == null || newValue == stateValue) return;

    stateValue = newValue;
    cityValue = null;
    cityOptions = [];
    rebuildUi();

    final selectedCountry = countryOptions.where((c) => c.name == countryValue);
    if (selectedCountry.isEmpty) return;
    final iso2 = selectedCountry.first.iso2;

    final selectedState = stateOptions.where((s) => s.name == stateValue);
    if (selectedState.isEmpty) return;
    final stateCode = selectedState.first.code;

    try {
      setBusy(true);
      final cities = await csc.getStateCities(iso2, stateCode);
      cityOptions = cities.map((c) => c.name).toList()..sort();
    } catch (e) {
      cityOptions = [];
    } finally {
      setBusy(false);
      rebuildUi();
    }
  }

  void onCityChanged(String? newValue) {
    cityValue = newValue;
    rebuildUi();
  }

  Future<void> getAccurateLocationData() async {
    // TODO(Civic24): Implement Geolocator/Geocoding to auto-select country and state
  }

  Future<void> onSaveData() async {
    try {
      if (!isFormValid) return;

      if (_userService.user != null) {
        // If the user is already set up, update the user data
        // and complete the onboarding process.
        await _userService.updateUser(
          _userService.user!.copyWith(
            account: _userService.user!.account.copyWith(
              firstName: firstNameValue!,
              lastName: lastNameValue!,
              country: countryValue!,
              state: stateValue!,
              city: '',
              hasCompletedOnboarding: true,
            ),
          ),
        );
        await _navigationService.clearStackAndShow(MainViewRoute());
        return;
      }
      // If the user is not set up, create a new user document
      // in Firestore and complete the onboarding process.
      await runBusyFuture(
        _userService.createUser(
          firstName: firstNameValue!,
          lastName: lastNameValue!,
          country: countryValue!,
          state: stateValue!,
          city: '',
          appSource: '',
        ),
        throwException: true,
      );
      await _navigationService.clearStackAndShow(MainViewRoute());
    } catch (e, s) {
      _log.e('Error saving user data', error: e, stackTrace: s);
      _alertService.showErrorAlert(
        title: 'Submission Error',
        message: 'An error occurred while saving your data. Please try again.',
      );
    }
  }

}
