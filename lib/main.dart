import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: Text("Profil Saya"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text(
              "Muhamad Faiz",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Icons.location_off), Text("Jakarta Selatan")],
            ),
            Text(
              "Saya Mahasiswa di Universitas Indraprasta PGRI",
              style: TextStyle(color: Colors.red[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
