import 'package:models/models.dart';

abstract interface class IReportInteractionService {
  Future<void> likeReportOptimistic(Report report, String userId);
  Future<void> dislikeReportOptimistic(Report report, String userId);
  Future<void> bookmarkReportOptimistic(Report report, String userId);
}
