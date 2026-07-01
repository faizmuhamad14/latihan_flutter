import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/training_model.dart';
import '../models/batch_model.dart';
import '../utils/constants.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  static Exception _handleNetworkError(dynamic e) {
    debugPrint('Network/API Error caught: $e');
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout || 
          e.type == DioExceptionType.receiveTimeout || 
          e.type == DioExceptionType.connectionError) {
        return Exception(
          'Gagal terhubung ke server di ${AppConstants.baseUrl}.\n\n'
          '1. Pastikan server lokal Anda sudah dijalankan.\n'
          '2. Pastikan komputer dan perangkat Anda terhubung ke jaringan yang sama.'
        );
      }
      
      if (e.response != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          return Exception(data['message']);
        }
        return Exception('Server error: ${e.response?.statusCode}');
      }
    }
    
    return Exception(e.toString().replaceFirst('Exception: ', ''));
  }

  /// Handles parsing generic Dio responses
  static dynamic _processResponse(Response response) {
    debugPrint('API Response [${response.statusCode}]: ${response.data}');
    final data = response.data;
    
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return data;
    } else {
      final message = (data is Map<String, dynamic>) ? (data['message'] ?? 'Request failed') : 'Request failed';
      throw Exception(message);
    }
  }

  /// Register User
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String gender,
    String? profilePhotoBase64,
    required int batchId,
    required int trainingId,
  }) async {
    try {
      final body = {
        'name': name,
        'email': email,
        'password': password,
        'jenis_kelamin': gender,
        'profile_photo': profilePhotoBase64 ?? '',
        'batch_id': batchId,
        'training_id': trainingId,
      };

      debugPrint('POST Register request: ${AppConstants.registerEndpoint}');
      
      final response = await _dio.post(
        AppConstants.registerEndpoint,
        data: body,
      );

      return _processResponse(response);
    } catch (e) {
      throw _handleNetworkError(e);
    }
  }

  /// Login User
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final body = {
        'email': email,
        'password': password,
      };

      debugPrint('POST Login request to ${AppConstants.loginEndpoint}');
      final response = await _dio.post(
        AppConstants.loginEndpoint,
        data: body,
      );

      return _processResponse(response);
    } catch (e) {
      throw _handleNetworkError(e);
    }
  }

  /// Fetch User Profile
  static Future<UserModel> getProfile(String token) async {
    try {
      debugPrint('GET Profile request to ${AppConstants.profileEndpoint}');
      final response = await _dio.get(
        AppConstants.profileEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final result = _processResponse(response);
      return UserModel.fromJson(result['data']);
    } catch (e) {
      throw _handleNetworkError(e);
    }
  }

  /// Update User Profile (Name)
  static Future<UserModel> updateProfile({
    required String token,
    required String name,
  }) async {
    try {
      final body = {
        'name': name,
      };

      debugPrint('PUT Update Profile request to ${AppConstants.editProfileEndpoint}');
      final response = await _dio.put(
        AppConstants.editProfileEndpoint,
        data: body,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final result = _processResponse(response);
      return UserModel.fromJson(result['data']);
    } catch (e) {
      throw _handleNetworkError(e);
    }
  }

  /// Update User Profile Photo (base64 string)
  static Future<String> updateProfilePhoto({
    required String token,
    required String profilePhotoBase64,
  }) async {
    try {
      final body = {
        'profile_photo': profilePhotoBase64,
      };

      debugPrint('PUT Update Photo request to ${AppConstants.editProfilePhotoEndpoint}');
      final response = await _dio.put(
        AppConstants.editProfilePhotoEndpoint,
        data: body,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final result = _processResponse(response);
      // Returns the profile photo URL string
      return result['data']['profile_photo'];
    } catch (e) {
      throw _handleNetworkError(e);
    }
  }

  /// Fetch Trainings List (Public)
  static Future<List<TrainingModel>> getTrainings() async {
    try {
      debugPrint('GET Trainings request to ${AppConstants.trainingsEndpoint}');
      final response = await _dio.get(
        AppConstants.trainingsEndpoint,
      );

      final result = _processResponse(response);
      final List<dynamic> data = result['data'] ?? [];
      return data.map((json) => TrainingModel.fromJson(json)).toList();
    } catch (e) {
      throw _handleNetworkError(e);
    }
  }

  /// Fetch Batches List (Authenticated)
  static Future<List<BatchModel>> getBatches(String token) async {
    try {
      debugPrint('GET Batches request to ${AppConstants.batchesEndpoint}');
      final response = await _dio.get(
        AppConstants.batchesEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final result = _processResponse(response);
      final List<dynamic> data = result['data'] ?? [];
      return data.map((json) => BatchModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 || e.response?.statusCode == 500) {
        debugPrint('GET Batches failed with status ${e.response?.statusCode}, using fallback');
        return _getMockBatches();
      }
      debugPrint('Get Batches API Error: $e, using mock batches fallback');
      return _getMockBatches();
    } catch (e) {
      debugPrint('Get Batches API Error: $e, using mock batches fallback');
      return _getMockBatches();
    }
  }

  /// Fetch All Users (Authenticated)
  static Future<List<dynamic>> getAllUsers(String token) async {
    try {
      debugPrint('GET All Users request to ${AppConstants.allUsersEndpoint}');
      final response = await _dio.get(
        AppConstants.allUsersEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final result = _processResponse(response);
      return result['data'] ?? [];
    } catch (e) {
      throw _handleNetworkError(e);
    }
  }

  /// Fallback Mock Batches if endpoint batches is not set up correctly in local server
  static List<BatchModel> _getMockBatches() {
    return [
      BatchModel(id: 1, title: 'Batch 1 - Tahun 2024'),
      BatchModel(id: 2, title: 'Batch 2 - Tahun 2024'),
      BatchModel(id: 3, title: 'Batch 3 - Tahun 2025'),
      BatchModel(id: 4, title: 'Batch 4 - Tahun 2025'),
      BatchModel(id: 5, title: 'Batch 5 - Tahun 2026'),
      BatchModel(id: 6, title: 'Batch 6 - Tahun 2026'),
    ];
  }
}
