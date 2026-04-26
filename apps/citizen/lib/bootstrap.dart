import 'package:citizen/app/firebase_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constants/constants.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:utils/utils.dart';

final _log = getLogger('AppBootstrap');

Future<void> connectToFirebase() async {
  const env = EnvironmentConstants.environment;
  _log.i('Connecting to Firebase on $env');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    providerAndroid: EnvironmentConstants.environment == Environment.production.name
        ? const AndroidPlayIntegrityProvider()
        : const AndroidDebugProvider(),
    providerApple: EnvironmentConstants.environment == Environment.production.name
        ? const AppleDeviceCheckProvider()
        : const AppleDebugProvider(),
  );
  FirebaseFirestore.instance.settings = const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
}
