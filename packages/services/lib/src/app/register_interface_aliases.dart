import 'package:services/src/app/app.locator.dart';
import 'package:services/src/services/feature/report/interfaces/i_report_feed.dart';
import 'package:services/src/services/feature/report/interfaces/i_report_interaction.dart';
import 'package:services/src/services/feature/report/interfaces/i_report_writer.dart';
import 'package:services/src/services/feature/report/report_service.dart';

void registerServiceInterfaces() {
  serviceLocator
    ..registerLazySingleton<IReportFeedService>(() => serviceLocator.call<ReportService>())
    ..registerLazySingleton<IReportInteractionService>(() => serviceLocator.call<ReportService>())
    ..registerLazySingleton<IReportWriterService>(() => serviceLocator.call<ReportService>());
}
