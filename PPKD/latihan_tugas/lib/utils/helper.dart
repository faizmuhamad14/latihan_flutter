import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class AppHelpers {
  /// Converts a File to a base64 string formatted as a Data URL (e.g. data:image/png;base64,...)
  static Future<String?> fileToBase64(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final base64Str = base64Encode(bytes);
      
      // Determine file extension
      final extension = file.path.split('.').last.toLowerCase();
      String mimeType = 'image/png'; // Default
      if (extension == 'jpg' || extension == 'jpeg') {
        mimeType = 'image/jpeg';
      } else if (extension == 'gif') {
        mimeType = 'image/gif';
      } else if (extension == 'webp') {
        mimeType = 'image/webp';
      }
      
      return 'data:$mimeType;base64,$base64Str';
    } catch (e) {
      debugPrint('Error converting file to base64: $e');
      return null;
    }
  }

  /// Show standard snackbar message
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
