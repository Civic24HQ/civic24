import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:services/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utils/utils.dart';

/// A service for handling URL launching, including opening web pages,
/// sending emails, making phone calls, and opening messaging apps.
class UrlLauncherService {
  final _log = getLogger('UrlLauncherService');
  final _alertService = serviceLocator<AlertService>();

  /// Sends an email using the default email client.
  ///
  /// - [email]: The recipient's email address.
  /// - [query]: Optional query parameters such as subject and body.
  ///
  /// Throws an exception if the email client cannot be opened.
  Future<void> sendEmail(String email, {String? query}) async {
    final emailLaunchUrl = Uri(scheme: 'mailto', path: email, query: query);

    if (await canLaunchUrl(emailLaunchUrl)) {
      _log.i('Sending email to $email');
      await launchUrl(emailLaunchUrl);
    } else {
      _alertService.showErrorAlert(
        title: 'Email App Not Found',
        message:
            'We couldn’t open your email app. Please check your '
            ' settings or try again later.',
      );
    }
  }

  /// Opens a URL in the browser or in an in-app web view.
  ///
  /// - [url]: The URL to open.
  /// - [openInBrowser]: If `true`, the URL opens in an external browser;
  ///   otherwise, it opens in an in-app web view.
  ///
  /// Throws an exception if the URL cannot be launched.
  Future<void> openUrl(String url, {bool openInBrowser = false}) async {
    final uri = Uri.parse(url);

    final canLaunch = await canLaunchUrl(uri);
    if (!canLaunch) _log.w('url cannot be launched: $url');

    if (canLaunch) {
      final successful = await launchUrl(
        uri,
        mode: openInBrowser ? LaunchMode.externalApplication : LaunchMode.inAppWebView,
      );
      _log.i('url launch result: $successful, $url');
    } else {
      _alertService.showErrorAlert(
        title: 'Link Unavailable',
        message:
            'We couldn’t open this link. Please check your'
            ' connection and try again.',
      );
    }
  }

  /// Opens the email app chooser to select an email app.
  ///
  /// This method is specifically designed for Android devices.
  ///
  /// If the device is not Android, it falls back to using
  /// the `mailto:` URI scheme to open the default email app.
  Future<void> openEmailAppChooser() async {
    final emailUri = Uri.parse('mailto:');

    if (isAndroid) {
      const intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.category.APP_EMAIL',
        flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();
      _log.i('Opening email app chooser on Android');
      return;
    }

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      _alertService.showErrorAlert(
        title: 'Email App Not Available',
        message:
            'We couldn’t open your email app. Please open it manually '
            'or check your settings.',
      );
    }
  }
}
