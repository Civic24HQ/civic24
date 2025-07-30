import 'dart:math';

import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<RouterService>();

  bool isAnimate = false;
  double turns = 0;
  double angle = 0;

  void changeAnimationState() {
    isAnimate = !isAnimate;
    rebuildUi();
  }

  void animateLight() {
    angle = angle == 0 ? pi : 0; // toggle between 0° and 180°
    rebuildUi();
  }

  void rotate() {
    turns += 1;
    rebuildUi();
  }

  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(milliseconds: 500));
    changeAnimationState();
    rotate();
    animateLight();
    await Future.delayed(const Duration(milliseconds: 6500));
    await _navigationService.replaceWithHomeView();
  }
}
