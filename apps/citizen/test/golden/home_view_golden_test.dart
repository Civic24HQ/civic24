import 'package:citizen/app/app.locator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(setupLocator);
  tearDownAll(locator.reset);
}
