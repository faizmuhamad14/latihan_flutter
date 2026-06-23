import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan_flutter/models/harry_models.dart';
import 'package:latihan_flutter/services/api_services.dart';

class HarryViews extends StatefulWidget {
  const HarryViews({super.key});

  @override
  State<HarryViews> createState() => _HarryViewsState();
}

class _HarryViewsState extends State<HarryViews> {
  Future<List<Welcome>> getCharacters() async {
    final dio = Dio();
    final apiService = ApiService(dio);

    return await apiService.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Welcome>>(
        future: getCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          // Tidak ada data
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Data kosong"));
          }

          final characters = snapshot.data!;
        },
      ),
    );
  }
}
