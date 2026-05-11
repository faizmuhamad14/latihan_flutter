import 'package:flutter/material.dart';

class Latihan2flutter extends StatelessWidget {
  const Latihan2flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          title: Text("Detail Toko"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Center(
              child: Text("Toko Bang Kumis", style: TextStyle(fontSize: 30)),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(width: 20),
                  Text("tokobangkumis88@gmail.com"),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone),
                Text("0858-xxxx"),
                Spacer(flex: 2),
                Icon(Icons.location_off),
                Text("Jakarta Selatan"),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.blue[500],
                    child: Text("Terjual"),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.red[500],
                    child: Center(child: Text("Rating")),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(padding: EdgeInsetsGeometry.only(left: 20)),
            Text("Toko terpercaya 100%"),
          ],
        ),
      ),
    );
  }
}
