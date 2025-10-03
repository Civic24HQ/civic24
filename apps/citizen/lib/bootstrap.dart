import 'package:citizen/app/firebase_config.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> connectToFirebase() async {
  // const env = EnvironmentConstants.environment;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
