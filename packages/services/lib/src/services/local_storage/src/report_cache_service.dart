import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models.dart';
import 'package:services/src/services/local_storage/local_storage_service.dart';

class ReportCacheService extends LocalStorageService {
  ReportCacheService() : super(reportsBox, 'ReportCacheService');

  static const _feedPrefix = 'feed_';

  String _key(String feedKey) => '$_feedPrefix$feedKey';

  /// Converts Firestore Timestamps into ISO8601 strings recursively
  dynamic _sanitize(dynamic value) {
    if (value is Timestamp) {
      return value.toDate().toIso8601String();
    }

    if (value is Map) {
      return value.map((key, val) => MapEntry(key, _sanitize(val)));
    }

    if (value is List) {
      return value.map(_sanitize).toList();
    }

    return value;
  }

  /// Save reports for a Feed with error handling and logging
  Future<void> saveFeed(String feedKey, List<Report> reports) async {
    try {
      final jsonList = reports.map((report) => _sanitize(report.toJson())).toList();

      saveData(_key(feedKey), jsonList);

      logger.i('Saved ${reports.length} reports to cache: $feedKey');
    } catch (e, stack) {
      logger.e('Failed to save feed cache', error: e, stackTrace: stack);
    }
  }

  /// Recursively converts Hive maps into Map<String, dynamic>
  Map<String, dynamic> _normalizeMap(Map<dynamic, dynamic> map) {
    return map.map((key, value) {
      if (value is Map<dynamic, dynamic>) {
        return MapEntry(key.toString(), _normalizeMap(value));
      }

      if (value is List) {
        return MapEntry(
          key.toString(),
          value.map((e) {
            if (e is Map<dynamic, dynamic>) {
              return _normalizeMap(e);
            }
            return e;
          }).toList(),
        );
      }

      return MapEntry(key.toString(), value);
    });
  }

  /// Load cached reports safely
  List<Report>? loadFeed(String feedKey) {
    final jsonList = getData<dynamic>(_key(feedKey));

    if (jsonList == null || jsonList is! List) return null;

    try {
      return jsonList.whereType<Map<dynamic, dynamic>>().map((map) => Report.fromJson(_normalizeMap(map))).toList();
    } catch (e, stack) {
      logger.e('Failed to deserialize cached reports for key: $feedKey', error: e, stackTrace: stack);
      return null;
    }
  }

  Future<void> clearFeed(String feedKey) async {
    await deleteData(_key(feedKey));
    logger.i('Cleared cache for feed: $feedKey');
  }
}
