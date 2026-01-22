import 'package:flutter_test/flutter_test.dart';
import 'package:services/src/app/app.locator.dart';
import 'package:services/src/test/helpers/test_helpers.dart';

void main() {
  group('LocalNotificationServiceTest -', () {
    setUp(registerServices);
    tearDown(serviceLocator.reset);
  });
}
