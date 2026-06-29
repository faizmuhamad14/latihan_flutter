import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class UploadLocationService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> uploadLocations() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/locations.json',
      );

      final List<dynamic> data = json.decode(jsonString);

      for (var item in data) {
        await firestore.collection('location').add({
          'nama': item['nama'],
          'alamat': item['alamat'],
          'telepon': item['telepon'],
          'latitude': item['latitude'],
          'longitude': item['longitude'],
          'rating': item['rating'],
          'layanan': item['layanan'],
        });
      }

      print("==========");
      print("UPLOAD BERHASIL");
      print("==========");
    } catch (e) {
      print(e);
    }
  }
}
