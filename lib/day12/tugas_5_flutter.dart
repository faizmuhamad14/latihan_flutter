import 'package:flutter/material.dart';

class Latihan5Flutter extends StatefulWidget {
  const Latihan5Flutter({super.key});

  @override
  State<Latihan5Flutter> createState() => _Latihan5FlutterState();
}

class _Latihan5FlutterState extends State<Latihan5Flutter> {
  String teks1 = "Halo nama saya Muhamad Faiz";
  String teks2 = "Saya peserta pelatihan PPKD Jakpus";
  bool showTeks = false;
  bool showTeks2 = false;
  bool like = false;
  int angka = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCFECF3),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFDAF9DE),
        onPressed: () {
          angka--;
          setState(() {
            print("Angka sekarang adalah = $angka setelah dikurang satu");
          });
        },
        child: Icon(Icons.exposure_minus_1),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text("Tugas Day 12"),
        centerTitle: true,
        backgroundColor: Color(0xFFF9B2D7),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFDAF9DE)),
            onPressed: () {
              setState(() {
                showTeks = !showTeks;
              });
              // ignore: dead_code
            },
            child: Text(
              showTeks
                  // ignore: dead_code
                  ? "sembunyikan teks"
                  : "munculkan teks",
              style: TextStyle(color: Colors.black),
            ),
          ),
          showTeks
              ? Text(teks1, style: TextStyle(fontSize: 20))
              : Container(alignment: Alignment.center),
          showTeks2
              ? Text(teks2, style: TextStyle(fontSize: 20))
              : Container(alignment: Alignment.center),
          IconButton(
            onPressed: () {
              setState(() {
                like = !like;
              });
            },
            icon: Icon(
              Icons.favorite,
              size: 50,
              color: like ? Colors.red : Colors.black,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                showTeks2 = !showTeks2;
              });
            },
            child: Text("More Detail"),
          ),
          InkWell(
            splashColor: Colors.red,
            onTap: () {
              print("kicau");
            },
            onDoubleTap: () {
              print("Kicau Kicau");
            },
            onLongPress: () {
              print("Kicau Kicau Kicau Mania");
            },
            child: Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image.asset("assets/images/kicaw.jpg", height: 200),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              angka++;
              setState(() {
                print("Angka sekarang adalah = $angka setelah ditekan sekali");
              });
            },
            onDoubleTap: () {
              angka += 2;
              setState(() {
                print(
                  "Angka sekarang adalah = $angka setelah ditekan dua kali",
                );
              });
            },
            onLongPress: () {
              angka += 3;
              setState(() {
                print("Angka sekarang adalah = $angka setelah ditekan lama");
              });
            },
            child: Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Container(
                height: 20,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFFDAF9DE),
                  border: Border.all(color: Colors.black),
                ),
                child: Center(child: Icon(Icons.plus_one)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
