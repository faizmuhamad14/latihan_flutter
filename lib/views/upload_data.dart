import 'package:flutter/material.dart';
import 'package:latihan_flutter/services/upload_location_services.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Firebase")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await UploadLocationService().uploadLocations();

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Upload selesai")));
          },
          child: const Text("Upload Locations"),
        ),
      ),
    );
  }
}
