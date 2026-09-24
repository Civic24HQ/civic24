import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() => setupLocator(stackedRouter: stackedRouter));
  tearDownAll(locator.reset);
}
