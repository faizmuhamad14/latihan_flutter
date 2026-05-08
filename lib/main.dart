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
        body: Padding(
          padding: const EdgeInsets.all(23.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Muhamad Faiz",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              Row(children: [Icon(Icons.location_on), Text("Jakarta Selatan")]),
              Row(
                children: [
                  Text(
                    "Halo saya dipanggil Faiz, saya peserta PPKD Jakpus",
                    style: TextStyle(fontSize: 13, color: Colors.red[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
