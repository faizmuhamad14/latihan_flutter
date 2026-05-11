import 'package:flutter/material.dart';

class LatihanWidget2 extends StatelessWidget {
  const LatihanWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          actions: [Icon(Icons.back_hand)],
          leading: Icon(Icons.arrow_back_ios_new_sharp),
          backgroundColor: Colors.grey[400],
          title: Text("FLutter day 8"),
          centerTitle: true,
        ),
        body: Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/kicaw.jpg"),
            ),
            color: Colors.grey,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.blue,
                    child: Text("Masukkan Nama"),
                  ),
                  Container(height: 100, width: 100, color: Colors.amber),
                  Container(height: 100, width: 100, color: Colors.red),
                ],
              ),
              Column(
                children: [
                  Container(height: 100, width: 100, color: Colors.black),
                  Container(
                    height: 100,
                    width: 100,
                    // color: Colors.amber,
                    child: Text("Nama Saya"),
                  ),
                  Container(height: 100, width: 100, color: Colors.red),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.green,
                    child: Text("Faiz"),
                  ),
                  Container(height: 100, width: 100, color: Colors.amber),
                  Container(height: 100, width: 100, color: Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
