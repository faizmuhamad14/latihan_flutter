import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class LocalStorageService {
  static const _storage = FlutterSecureStorage();

  // Token storage
  static Future<void> saveToken(String token) async {
    await _storage.write(key: AppConstants.keyToken, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: AppConstants.keyToken);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: AppConstants.keyToken);
  }

  // User storage
  static Future<void> saveUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _storage.write(key: AppConstants.keyUser, value: userJson);
  }

  static Future<UserModel?> getUser() async {
    final userStr = await _storage.read(key: AppConstants.keyUser);
    if (userStr == null) return null;
    try {
      final userMap = jsonDecode(userStr) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }

  static Future<void> deleteUser() async {
    await _storage.delete(key: AppConstants.keyUser);
  }

  // Profile photo storage (persisted across logouts)
  static Future<void> saveLocalProfilePhoto(String email, String photo) async {
    await _storage.write(key: 'profile_photo_$email', value: photo);
  }

  static Future<String?> getLocalProfilePhoto(String email) async {
    return await _storage.read(key: 'profile_photo_$email');
  }

  // Clear all session
  static Future<void> clearAll() async {
    await _storage.delete(key: AppConstants.keyToken);
    await _storage.delete(key: AppConstants.keyUser);
  }
}
