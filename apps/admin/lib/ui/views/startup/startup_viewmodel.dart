import 'package:admin/app/app.locator.dart';
import 'package:admin/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<RouterService>();

  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));
    await _navigationService.replaceWithHomeView();
  }
}
