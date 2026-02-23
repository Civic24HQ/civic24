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
    return UserModel.fromJson(Map<String, dynamic>.from(data));
  }

  void setCurrentUserModel(UserModel user) => saveData(_kCurrentUser, user.toJson());
}
