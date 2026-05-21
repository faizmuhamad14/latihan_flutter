import 'package:flutter/material.dart';

class Latihan7Flutter extends StatefulWidget {
  const Latihan7Flutter({super.key});
  static const String routeName = '/tugas7';

  @override
  State<Latihan7Flutter> createState() => _Latihan7FlutterState();
}

class _Latihan7FlutterState extends State<Latihan7Flutter> {
  int _selectedIndex = 0;
  bool isOn = false;
  bool isCheck = false;
  bool isDrop = false;
  String? selected;
  DateTime? selectedDate;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Setting'),
    Text('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); //close drawer
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  "data",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("home"),
                selected: _selectedIndex == 0,
                onTap: () {
                  _onItemTapped(0);
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: Text("Dark Mode"),
              ),
            ],
          ),
        ),
        appBar: AppBar(title: Text("Tugas 7 Flutter"), centerTitle: true),
        body: Column(
          children: [
            Checkbox(
              value: isCheck,
              onChanged: (bool? newValue) {
                setState(() {
                  isCheck = newValue ?? false;
                });
              },
            ),
            Text(
              isCheck
                  ? 'Pendaftaran diperbolehkan'
                  : 'Pendaftaran belum tersedia',
            ),
            DropdownButton<String>(
              value: selected,
              hint: Text("Pilih Jenis Hewan"),
              items: ['kucing', 'anjing'].map((String val) {
                return DropdownMenuItem(value: val, child: Text(val));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selected = val;
                });
              },
            ),
            Text("Anda Memilih Jenis Hewan $selected"),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              child: Text("Pilih Tanggal"),
            ),
            Text(
              selectedDate == null
                  ? "belum memilih tanggal"
                  : "Tanggal yang Anda pilih : ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
            ),
          ],
        ),
      ),
    );
  }
}
