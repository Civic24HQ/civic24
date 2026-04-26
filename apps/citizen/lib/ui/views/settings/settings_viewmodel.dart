import 'dart:async';

import 'package:citizen/app/app.dialogs.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:constants/constants.dart';
import 'package:localization/localization.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:utils/utils.dart';

class SettingsViewModel extends ReactiveViewModel {
  final _log = getLogger('SettingsViewModel');
  final _navigationService = locator<RouterService>();
  final _dialogService = locator<DialogService>();
  final _authService = locator<AuthenticationService>();
  final _userService = locator<UserService>();
  final _analyticsService = locator<AnalyticsService>();
  final _appInfoService = locator<AppInfoService>();
  final _notificationService = locator<NotificationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  UserModel? get currentUser => _userService.user;

  String get appVersion => _appInfoService.displayVersion;

  Future<void> navigateToProfile() async {
    await _navigationService.navigateToProfileView();
  }

  Future<void> navigateToLanguageSettings() async {
    await _navigationService.navigateToLanguageSettingsView();
  }

  Future<void> navigateToAppearanceSettings() async {
    await _navigationService.navigateToAppearanceSettingsView();
  }

  Future<void> navigateToSignInSecuritySettings() async {
    await _navigationService.navigateToSignInSecurityView();
  }

  void navigateToAboutSettings() {}

  Future<void> logout() async {
    Future<bool> showLogoutConfirmationDialog() async {
      final response = await _dialogService.showCustomDialog(variant: DialogType.logout, barrierDismissible: true);

      if (response != null && response.confirmed) {
        return response.data == DialogActionType.main;
      }
      return false;
    }

    _analyticsService
      ..logButtonClick(kAnalyticButtonAuthLogout)
      ..logScreenView(screenClass: kAnalyticOverlayClass, screenName: kAnalyticDialogLogoutConfirmation);

    final shouldLogout = await showLogoutConfirmationDialog();
    if (!shouldLogout) return;

    unawaited(_dialogService.showCustomDialog(variant: DialogType.loading, title: l10n.featureSettingsLoggingOut));

    try {
      await _userService.clearUserSessionData().timeout(
        const Duration(seconds: 50),
        onTimeout: () {
          _log.w('User session data clearing timed out');
        },
      );
    } catch (e) {
      _log.e('Error signing out: $e');
    } finally {
      await _authService.signOut();
      await _notificationService.stopListening();
      _log.i('Logged out successfully');
      _dialogService.completeDialog(DialogResponse(confirmed: true));
      await _navigationService.clearStackAndShow(LoginViewRoute());
    }
  }
}
