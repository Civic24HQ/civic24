import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads every font declared in the app's font manifest (Poppins, icon fonts
/// and so on) so that readable "platform" golden images show real text and
/// icons instead of the test framework's placeholder font.
Future<void> loadAppFonts() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final manifestJson = await rootBundle.loadString('FontManifest.json');
  final manifest = json.decode(manifestJson) as List<dynamic>;

  for (final entry in manifest.cast<Map<String, dynamic>>()) {
    final family = entry['family'] as String;
    final fonts = (entry['fonts'] as List<dynamic>).cast<Map<String, dynamic>>();

    final loader = FontLoader(family);
    for (final font in fonts) {
      loader.addFont(rootBundle.load(font['asset'] as String));
    }
    await loader.load();
  }
}
