import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models.dart';
import 'package:services/src/services/local_storage/local_storage_service.dart';

const String _kUserId = 'userIdKey';
const String _kCurrentUser = 'currentUserKey';

class UserStorageService extends LocalStorageService {
  UserStorageService() : super(settingsBox, 'UserStorageService');

  String? get userId => getData(_kUserId);
  void setUserId(String userId) => saveData(_kUserId, userId);

  UserModel get getCurrentUserModel {
    final data = getData(_kCurrentUser) as Map<dynamic, dynamic>;
    return UserModel.fromJson(_normalizeMap(data));
  }

  void setCurrentUserModel(UserModel user) {
    saveData(_kCurrentUser, _sanitize(user.toJson()));
  }

  /// Recursively converts any Firestore [Timestamp] into an ISO-8601 string
  dynamic _sanitize(dynamic value) {
    if (value is Timestamp) {
      return value.toDate().toUtc().toIso8601String();
    }
    if (value is Map) {
      return <String, dynamic>{for (final e in value.entries) e.key.toString(): _sanitize(e.value)};
    }
    if (value is List) {
      return value.map(_sanitize).toList();
    }
    return value;
  }

  /// Recursively converts the [Map<dynamic, dynamic>] into a [Map<String, dynamic>] that [UserModel.fromJson] expects
  Map<String, dynamic> _normalizeMap(Map<dynamic, dynamic> map) {
    return {
      for (final e in map.entries)
        e.key.toString(): e.value is Map<dynamic, dynamic>
            ? _normalizeMap(e.value as Map<dynamic, dynamic>)
            : e.value is List
            ? (e.value as List).map((item) => item is Map<dynamic, dynamic> ? _normalizeMap(item) : item).toList()
            : e.value,
    };
  }
}
