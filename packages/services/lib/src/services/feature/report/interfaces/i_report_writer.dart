import 'package:models/models.dart';

abstract interface class IReportWriterService {
  Future<void> addReport(Report report);
  Future<void> updateReport(Report report);
}
