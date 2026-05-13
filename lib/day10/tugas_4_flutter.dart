import 'package:flutter/material.dart';

class Latihan4Flutter extends StatelessWidget {
  const Latihan4Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dataAkun = [
      {"title": "Faiz", "subtitle": "Kepala Toko"},
      {"title": "Dafa", "subtitle": "Manager"},
      {"title": "Rakha", "subtitle": "Wakil Manager"},
      {"title": "Rakan", "subtitle": "Sekretaris"},
      {"title": "Eghy", "subtitle": "Admin"},
      {"title": "Rofiq", "subtitle": "Admin"},
      {"title": "Labib", "subtitle": "Admin"},
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffFFB399),
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          backgroundColor: Color(0xFFFF9A86),
          title: Text(
            "Form Input Akun",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text("Masukkan Nama"),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nama",
                      hintText: "abcdefgh",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("Masukkan Email"),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                      hintText: "abcdef@gmail.com",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("Masukkan Password"),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Masukkan Password",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("Masukkan Role Anda"),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Role",
                      hintText: "Admin",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Text("Tambahkan Akun")),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Akun-akun yang sudah terdaftar",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataAkun.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(50),
                            child: Icon(Icons.person_2),
                          ),
                          title: Text(dataAkun[index]["title"]!),
                          subtitle: Text(dataAkun[index]["subtitle"]!),
                          trailing: Icon(Icons.arrow_right),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
