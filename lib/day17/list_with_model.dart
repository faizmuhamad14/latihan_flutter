import 'package:flutter/material.dart';
import 'package:latihan_flutter/data/list_data_model.dart';

class ListWithModel extends StatefulWidget {
  const ListWithModel({super.key});

  @override
  State<ListWithModel> createState() => _ListWithModelState();
}

class _ListWithModelState extends State<ListWithModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: produkPetshop.length,
        itemBuilder: (context, index) {
          final data = produkPetshop[index];

          return Card(
            child: Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Column(
                children: [
                  Image.asset(
                    data.gambar,
                    width: 60,
                    height: 50,
                    fit: BoxFit.cover,
                  ),

                  Column(
                    children: [
                      Text("Nama = ${data.nama}"),
                      Text("Kategori = ${data.kategori}"),
                      Text("Harga = ${data.harga}"),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
