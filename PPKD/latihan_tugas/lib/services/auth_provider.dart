import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'api_service.dart';
import 'local_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  String? _token;
  bool _isLoading = false;

  UserModel? get user => _user;
  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;

  /// Check local storage for existing session
  Future<void> tryAutoLogin() async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await LocalStorageService.getToken();
      var user = await LocalStorageService.getUser();

      if (token != null && user != null) {
        _token = token;
        
        // Check for local profile photo fallback
        final localPhoto = await LocalStorageService.getLocalProfilePhoto(user.email);
        if (localPhoto != null && (user.profilePhoto == null || user.profilePhoto!.isEmpty)) {
          user = UserModel(
            id: user.id,
            name: user.name,
            email: user.email,
            jenisKelamin: user.jenisKelamin,
            profilePhoto: localPhoto,
            batchId: user.batchId,
            trainingId: user.trainingId,
          );
        }
        
        _user = user;
        
        // Attempt to refresh profile silently in background
        refreshProfile();
      }
    } catch (e) {
      debugPrint('Auto-login failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Login User
  Future<String?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await ApiService.login(email: email, password: password);
      
      final token = result['data']['token'];
      final userJson = result['data']['user'];
      
      _token = token;
      var tempUser = UserModel.fromJson(userJson);

      // Check for local profile photo fallback
      final localPhoto = await LocalStorageService.getLocalProfilePhoto(tempUser.email);
      if (localPhoto != null && (tempUser.profilePhoto == null || tempUser.profilePhoto!.isEmpty)) {
        tempUser = UserModel(
          id: tempUser.id,
          name: tempUser.name,
          email: tempUser.email,
          jenisKelamin: tempUser.jenisKelamin,
          profilePhoto: localPhoto,
          batchId: tempUser.batchId,
          trainingId: tempUser.trainingId,
        );
      } else if (tempUser.profilePhoto != null && tempUser.profilePhoto!.isNotEmpty) {
        // Save the profile photo URL locally
        await LocalStorageService.saveLocalProfilePhoto(tempUser.email, tempUser.profilePhoto!);
      }
      
      _user = tempUser;

      // Save session locally
      await LocalStorageService.saveToken(_token!);
      await LocalStorageService.saveUser(_user!);
      
      _isLoading = false;
      notifyListeners();
      return null; // Return null means success
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString().replaceFirst('Exception: ', ''); // Return error message
    }
  }

  /// Register User
  Future<String?> register({
    required String name,
    required String email,
    required String password,
    required String gender,
    String? profilePhotoBase64,
    required int batchId,
    required int trainingId,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await ApiService.register(
        name: name,
        email: email,
        password: password,
        gender: gender,
        profilePhotoBase64: profilePhotoBase64,
        batchId: batchId,
        trainingId: trainingId,
      );

      final token = result['data']['token'];
      final userJson = result['data']['user'];

      _token = token;
      var tempUser = UserModel.fromJson(userJson);

      // If user uploaded a profile photo on registration, save it locally
      if (profilePhotoBase64 != null && profilePhotoBase64.isNotEmpty) {
        await LocalStorageService.saveLocalProfilePhoto(tempUser.email, profilePhotoBase64);
        tempUser = UserModel(
          id: tempUser.id,
          name: tempUser.name,
          email: tempUser.email,
          jenisKelamin: tempUser.jenisKelamin,
          profilePhoto: profilePhotoBase64,
          batchId: tempUser.batchId,
          trainingId: tempUser.trainingId,
        );
      } else if (tempUser.profilePhoto != null && tempUser.profilePhoto!.isNotEmpty) {
        await LocalStorageService.saveLocalProfilePhoto(tempUser.email, tempUser.profilePhoto!);
      }

      _user = tempUser;

      // Save session locally
      await LocalStorageService.saveToken(_token!);
      await LocalStorageService.saveUser(_user!);

      _isLoading = false;
      notifyListeners();
      return null; // Return null means success
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  /// Refresh user profile details from server
  Future<void> refreshProfile() async {
    if (_token == null) return;
    try {
      final profile = await ApiService.getProfile(_token!);
      var tempUser = profile;
      
      // Fallback to local profile photo if server photo is empty
      final localPhoto = await LocalStorageService.getLocalProfilePhoto(tempUser.email);
      if (localPhoto != null && (tempUser.profilePhoto == null || tempUser.profilePhoto!.isEmpty)) {
        tempUser = UserModel(
          id: tempUser.id,
          name: tempUser.name,
          email: tempUser.email,
          jenisKelamin: tempUser.jenisKelamin,
          profilePhoto: localPhoto,
          batchId: tempUser.batchId,
          trainingId: tempUser.trainingId,
        );
      } else if (tempUser.profilePhoto != null && tempUser.profilePhoto!.isNotEmpty) {
        await LocalStorageService.saveLocalProfilePhoto(tempUser.email, tempUser.profilePhoto!);
      }
      
      _user = tempUser;
      await LocalStorageService.saveUser(_user!);
      notifyListeners();
    } catch (e) {
      debugPrint('Silent profile refresh failed: $e');
    }
  }

  /// Update User profile name
  Future<String?> updateProfileName(String name) async {
    if (_token == null) return 'No auth token found';
    
    _isLoading = true;
    notifyListeners();

    try {
      final updatedUser = await ApiService.updateProfile(token: _token!, name: name);
      var tempUser = updatedUser;

      // Fallback to local profile photo
      final localPhoto = await LocalStorageService.getLocalProfilePhoto(tempUser.email);
      if (localPhoto != null && (tempUser.profilePhoto == null || tempUser.profilePhoto!.isEmpty)) {
        tempUser = UserModel(
          id: tempUser.id,
          name: tempUser.name,
          email: tempUser.email,
          jenisKelamin: tempUser.jenisKelamin,
          profilePhoto: localPhoto,
          batchId: tempUser.batchId,
          trainingId: tempUser.trainingId,
        );
      }
      
      _user = tempUser;
      await LocalStorageService.saveUser(_user!);
      
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  /// Update profile photo
  Future<String?> updateProfilePhoto(String base64Photo) async {
    if (_token == null) return 'No auth token found';

    _isLoading = true;
    notifyListeners();

    try {
      final newPhotoUrl = await ApiService.updateProfilePhoto(
        token: _token!,
        profilePhotoBase64: base64Photo,
      );
      
      // Save locally to persist across logouts
      if (_user != null) {
        await LocalStorageService.saveLocalProfilePhoto(_user!.email, base64Photo);
        _user = UserModel(
          id: _user!.id,
          name: _user!.name,
          email: _user!.email,
          jenisKelamin: _user!.jenisKelamin,
          profilePhoto: base64Photo, // Use the base64 string directly as local cache
          batchId: _user!.batchId,
          trainingId: _user!.trainingId,
        );
        await LocalStorageService.saveUser(_user!);
      }

      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  /// Logout User
  Future<void> logout() async {
    _token = null;
    _user = null;
    await LocalStorageService.clearAll();
    notifyListeners();
  }
}
