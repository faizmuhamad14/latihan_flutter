import 'package:flutter/material.dart';

class Latihan3Flutter extends StatelessWidget {
  const Latihan3Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[600],
        title: Text(
          "Registrasi & Katalog",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text("Masukkan Nama"),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.lightBlue[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      labelText: "Nama",
                      hintText: "Masukkan Nama",
                    ),
                  ),
                  Text("Masukkan Nomer HP"),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.lightBlue[50],
                      labelText: "Nomer HP",
                      hintText: "Masukkan Nomer HP",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  Text("Masukkan Email"),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.lightBlue[50],
                      labelText: "Email",
                      hintText: "Masukkan email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  Text("Masukkan Password"),
                  TextField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      labelText: "password",
                      filled: true,
                      fillColor: Colors.lightBlue[50],
                      hintText: "Masukkan Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 40,
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text("Register"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: Text(
              "Katalog Warna",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text("Brown Color")),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text("Yellow Color")),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text("PurpleColor")),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text("Red Color")),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text("Warna Biru")),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text("Green Color")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
