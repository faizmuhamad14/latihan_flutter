import 'package:flutter/material.dart';

class ListDay17 extends StatefulWidget {
  const ListDay17({super.key});

  @override
  State<ListDay17> createState() => _ListDay17State();
}

class _ListDay17State extends State<ListDay17> {
  final List<String> petProduk = [
    "Royal Canin Kitten",
    "Whiskas Adult Tuna",
    "Pedigree Beef",
    "Bolt Cat Food",
    "Me-O Persian",
    "Cleo Cat Litter",
    "Pasir Wangi Kucing",
    "Shampoo Kucing Aloe Vera",
    "Vitamin Kucing",
    "Kalung Anjing Kulit",
    "Mainan Bola Kucing",
    "Kandang Hamster Mini",
    "Makanan Burung Lovebird",
    "Snack Anjing Dental",
    "Sisir Bulu Hewan",
    "Tempat Makan Hewan",
    "Minuman Vitamin Hewan",
    "Obat Kutu Kucing",
    "Harness Anjing",
    "Kasur Hewan Premium",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: petProduk.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(petProduk[index]));
        },
      ),
    );
  }
}
