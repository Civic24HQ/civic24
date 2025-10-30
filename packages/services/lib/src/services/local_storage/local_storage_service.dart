import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:utils/utils.dart';

typedef BoxInitialiser = void Function(Box<dynamic>);

// Add all the box initializers here
late Box<dynamic> settingsBox;

// Register all the box initializers here
final boxInitializers = <String, BoxInitialiser>{'settings': (box) => settingsBox = box};

abstract class LocalStorageService {
  LocalStorageService(this.box, String logString) : logger = getLogger(logString);
  final Box<dynamic> box;
  final Logger logger;

  void saveData(String key, dynamic value) {
    logger.d('Saving data to local storage');
    box.put(key, value);
  }

  T getData<T>(String key) {
    logger.d('Getting data from local storage');
    return box.get(key) as T;
  }

  Future<void> deleteData(String key) async {
    logger.d('Deleting data from local storage');
    return box.delete(key);
  }

  void deleteAllData() {
    logger.d('Deleting all data from local storage');
    box.clear();
  }

  void close() {
    logger.d('Closing local storage');
    box.close();
  }

  Stream<T> watch<T>() {
    logger.d('Watching local storage');
    return box.watch() as Stream<T>;
  }
}

Future<void> setupLocalStorage() async {
  final log = getLogger('setupLocalStorage')..d('Setting up local storage');
  await openHiveBoxes()
      .then((_) {
        log.i('Local storage setup complete');
      })
      .catchError((error) {
        log.e('Error setting up local storage: $error');
      });
}

@visibleForTesting
Future<void> openHiveBoxes() async {
  final log = getLogger('openHiveBoxes')..d('Opening Hive boxes');

  if (kIsWeb) {
    Hive.init(null); // Path is not required for web
  } else {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  final futures = <Future<void>>[];
  for (final box in boxInitializers.entries) {
    final boxName = box.key;
    log.d('Opening $boxName');

    final boxInitializer = box.value;
    futures.add(
      Hive.openBox<dynamic>(boxName).then((value) {
        boxInitializer(Hive.box<dynamic>(boxName));
      }),
    );
  }

  await Future.wait(futures);
}

void clearLocalStorage() {
  final log = getLogger('clearLocalStorage')..d('Clearing Hive boxes');
  for (final hiveBox in boxInitializers.entries) {
    final boxName = hiveBox.key;
    log.d('Clearing box $boxName');
    Hive.box<dynamic>(boxName).clear();
  }
}
