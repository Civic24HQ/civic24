# Creating a new service

This document describes how to create a new service in the `packages/services` directory. This is done manually because we need to export lib/src/test/test_helpers.dart needs to be exported, so we can easily access the mock services in the apps and other packages. If you have a better idea, please the team know.

## 1. Choose the type of service

We have two types of services: `core` and `feature`. The `core` services are the ones that are essential for the application to work, such as `auth` and `user`. The `feature` services are the ones that are not essential, such as `notification` and `report`.

## 2. Create the service file

Create a new file in the `packages/services` directory with the name of the service. For example, if you are creating a new service called `report`, create a file called `feature/report_service.dart`.

## 3. Register the service

Add the service to the `lib/src/app/app.dart` file. Register the service based on the type of service you are creating. Read more about the service registration in [GetIt Service Locator](https://pub.dev/documentation/get_it/latest/get_it/GetIt-class.html)

For example, if you are creating a new service called `report`, add the following line to the `dependencies` list:

```dart
  dependencies: [
    LazySingleton(classType: ReportService),
    ],
```

## 4. Mock the service

Add a mock service in the `lib/src/test/helpers/test_helpers.dart` file.

Add the following code to the `customMocks` list:

```dart
  MockSpec<ReportService>(as: #MockReportService),
```

Add the following method to the `registerServices` method:

```dart
MockReportService getAndRegisterReportService() {
  _removeRegistrationIfExists<ReportService>();
  final service = MockReportService();
  serviceLocator.registerSingleton<ReportService>(service);
  return service;
}
```

Add the following code to the `registerServices` method:

```dart
void registerServices() {
  getAndRegisterReportService();
}
```

## 5. Add service tests

Create a new file in the `test/src/services` directory with the name of the service. For example, if you are creating a new service called `report`, create a file called `report_service_test.dart`.

Add the following code to the file:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:services/src/app/app.locator.dart';
import 'package:services/src/test/helpers/test_helpers.dart';

void main() {
  group('ReportServiceTest -', () {
    setUp(registerServices);
    tearDown(serviceLocator.reset);
  });
}
```

## 6. Finalize the service

- Run `melos services:build` to generate the service files.

- Finally, implement the service logic based on the requirements.

- Add the service relevant tests.

- Export the service in the `lib/services.dart` file.
