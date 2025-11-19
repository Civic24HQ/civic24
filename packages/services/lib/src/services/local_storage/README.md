# Adding a Local Storage Service

This service is responsible for storing and retrieving data from the local storage of the device.

## Setup new Storage Service

1. Create a new box for the service in `local_storage_service.dart`

```dart
late Box<dynamic> serviceNameBox;
```

2. Register inside the initializer of the `boxInitializers`.

```dart
final boxInitializers = <String, BoxInitialiser>{
  'serviceName': (box) => serviceNameBox = box,
};
```

3. Create a new service class using the following command.

```bash
melos services:create ServiceNameStorage
```

4. Move the generated service to the `services/src/local_storage/src` directory.
5. Extend the `LocalStorageService` class.

```dart
class ServiceNameStorage extends LocalStorageService {
  ServiceNameStorage() : super(serviceNameBox, 'ServiceNameStorage');
}
```

## Usage

1. Add the key-value pair to the storage service

```dart
const String _kNameKey = 'nameKey';
```

2. Use any of the following methods to interact with the local storage.

```dart
void saveName(String name) => saveData(_kNameKey, name);

String? get name => getData(_kNameKey);

void deleteName() => deleteData(_kNameKey);
```

3. Call the service using the `ServiceLocator`.

```dart
final storageService = serviceLocator<ServiceNameStorage>();
```

4. Use the service to interact with the local storage.

```dart
storageService.saveName('John Doe');
```
