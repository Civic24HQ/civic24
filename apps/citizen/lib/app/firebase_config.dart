import 'package:constants/constants.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return firebaseOptionsAndroid;
      case TargetPlatform.iOS:
        return firebaseOptionsIos;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for fuchsia - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }
  }

  static const firebaseOptionsAndroid = FirebaseOptions(
    apiKey: EnvironmentConstants.androidApiKey,
    appId: EnvironmentConstants.androidAppId,
    authDomain: EnvironmentConstants.authDomain,
    messagingSenderId: EnvironmentConstants.messagingSenderId,
    projectId: EnvironmentConstants.projectId,
    storageBucket: EnvironmentConstants.storageBucket,
  );

  static const FirebaseOptions firebaseOptionsIos = FirebaseOptions(
    apiKey: EnvironmentConstants.iosApiKey,
    appId: EnvironmentConstants.iosAppId,
    authDomain: EnvironmentConstants.authDomain,
    messagingSenderId: EnvironmentConstants.messagingSenderId,
    projectId: EnvironmentConstants.projectId,
    storageBucket: EnvironmentConstants.storageBucket,
    iosClientId: EnvironmentConstants.iosClientId,
    iosBundleId: EnvironmentConstants.iosBundleId,
  );

  // static const FirebaseOptions firebaseOptionsMacos = FirebaseOptions(
  //   apiKey: EnvironmentConstants.macosApiKey,
  //   appId: EnvironmentConstants.macosAppId,
  //   authDomain: EnvironmentConstants.authDomain,
  //   messagingSenderId: EnvironmentConstants.messagingSenderId,
  //   projectId: EnvironmentConstants.projectId,
  //   storageBucket: EnvironmentConstants.storageBucket,
  // );
  // static const FirebaseOptions web = FirebaseOptions(
  //   apiKey: EnvironmentConstants.webApiKey,
  //   appId: EnvironmentConstants.webAppId,
  //   messagingSenderId: EnvironmentConstants.messagingSenderId,
  //   projectId: EnvironmentConstants.projectId,
  //   authDomain:  EnvironmentConstants.authDomain,
  //   storageBucket: EnvironmentConstants.storageBucket,
  //   measurementId: EnvironmentConstants.measurementId,
  // );
}
