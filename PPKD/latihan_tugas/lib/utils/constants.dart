import 'package:flutter/material.dart';

class AppConstants {
  // Base URL for API.
  // Note: For Android emulator use http://10.0.2.2:8000, for iOS simulator use http://127.0.0.1:8000,
  // or use your server's local IP address if testing on a real device.
  static const String baseUrl = 'https://appabsensi.mobileprojp.com';

  // API Endpoints
  static const String registerEndpoint = '$baseUrl/api/register';
  static const String loginEndpoint = '$baseUrl/api/login';
  static const String profileEndpoint = '$baseUrl/api/profile';
  static const String editProfileEndpoint = '$baseUrl/api/profile';
  static const String editProfilePhotoEndpoint = '$baseUrl/api/profile/photo';
  static const String allUsersEndpoint = '$baseUrl/api/users';
  static const String trainingsEndpoint = '$baseUrl/api/trainings';
  static const String batchesEndpoint = '$baseUrl/api/batches';

  // Shared Preferences Keys
  static const String keyToken = 'auth_token';
  static const String keyUser = 'user_data';

  // UI Theme Colors (Rich Aesthetic: Dark Navy & Deep Purple Gradients)
  static const Color primaryColor = Color(0xFF1E1E2F); // Dark Navy
  static const Color secondaryColor = Color(
    0xFF6C63FF,
  ); // Violet / Purple Accent
  static const Color accentColor = Color(0xFFFF6584); // Pink Accent
  static const Color backgroundColor = Color(0xFF12121E); // Very Dark Navy
  static const Color cardColor = Color(0xFF1E1E30); // Card Background
  static const Color textColorPrimary = Colors.white;
  static const Color textColorSecondary = Colors.white70;
}
