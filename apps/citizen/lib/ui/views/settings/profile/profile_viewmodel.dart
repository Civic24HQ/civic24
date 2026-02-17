import 'package:citizen/app/app.locator.dart';
import 'package:citizen/ui/views/settings/profile/profile_view.form.dart';
import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:flutter/services.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends FormViewModel {
  final _userService = locator<UserService>();
  final _alertService = locator<AlertService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  UserModel get currentUser => _userService.user!;

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  String? countryValue;
  String? stateValue;
  String? cityValue;

  List<CountryOption> countryOptions = [];
  List<StateOption> stateOptions = [];
  List<String> cityOptions = [];

  bool get isSaveButtonDisabled =>
      (firstNameValue?.trim().isEmpty ?? true) ||
      (lastNameValue?.trim().isEmpty ?? true) ||
      (countryValue?.trim().isEmpty ?? true) ||
      (stateValue?.trim().isEmpty ?? true);

  bool showCancelDialog() {
    return false;
  }

  void changeAvatar() {}

  Future<void> init() async {
    await _loadCountries();

    firstNameValue = currentUser.firstName;
    lastNameValue = currentUser.lastName;
    if (currentUser.country.isNotEmpty && currentUser.state.isNotEmpty) {
      countryValue = countryOptions.firstWhere((c) => c.name == currentUser.country).name;
      final iso2 = countryOptions.firstWhere((c) => c.name == currentUser.country).iso2;
      final states = await csc.getStatesOfCountry(iso2);
      stateOptions = states.map((s) => StateOption(s.name, s.isoCode)).toList()
        ..sort((a, b) => a.name.compareTo(b.name));
      stateValue = stateOptions.firstWhere((s) => s.name == currentUser.state).name;
      rebuildUi();
    }
  }

  Future<void> _loadCountries() async {
    try {
      setBusy(true);
      final countries = await csc.getAllCountries();
      countryOptions = countries.map((c) => CountryOption(c.name, c.isoCode)).toList()
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

  void onEdit() {
    _isEditing = true;
    rebuildUi();
  }

  void onCancel() {
    _isEditing = false;
    rebuildUi();
    init();
  }

  void deleteAccount() {}

  Future<void> onSave() async {
    if (!isFormValid) {
      return;
    }
    try {
      await runBusyFuture(
        _userService.updateUser(
          currentUser.copyWith(
            account: currentUser.account.copyWith(
              firstName: firstNameValue!,
              lastName: lastNameValue!,
              country: countryValue!,
              state: stateValue!,
            ),
          ),
        ),
        throwException: true,
      );
      _alertService.showSuccessAlert(
        title: 'Profile Updated',
        message: 'Your profile details has been updated successfully.',
      );
      await HapticFeedback.lightImpact();
      _isEditing = false;
      rebuildUi();
    } catch (e) {
      _alertService.showErrorAlert(
        title: 'Profile Update Failed',
        message: 'An error occurred while updating your profile details. Please try again.',
      );
    }
  }
}
