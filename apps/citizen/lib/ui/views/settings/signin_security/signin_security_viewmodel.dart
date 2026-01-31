import 'package:citizen/app/app.locator.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';

class SignInSecurityViewModel extends ReactiveViewModel {
  // final _log = getLogger('SignInSecurityViewModel');
  final _userService = locator<UserService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  UserModel? get currentUser => _userService.user;

  Future<void> navigateToGoogleAuth() async {}

  Future<void> navigateToAppleAuth() async {}

  Future<void> navigateToSetPassword() async {}
}
