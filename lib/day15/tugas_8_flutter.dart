import 'package:flutter/material.dart';
import 'package:latihan_flutter/day15/profile.dart';
import 'package:latihan_flutter/day15/tugas_7_flutter.dart';

class Latihan8Flutter extends StatefulWidget {
  const Latihan8Flutter({super.key});

  @override
  State<Latihan8Flutter> createState() => _MainscreenState();
}

class _MainscreenState extends State<Latihan8Flutter> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Latihan7Flutter(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "Form PetShop" : "Profile"),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "MENU",
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
              title: const Text("Home"),
              selected: _selectedIndex == 0,
              onTap: () {
                Navigator.pop(context);

                _onItemTapped(0);
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              selected: _selectedIndex == 1,
              onTap: () {
                Navigator.pop(context);

                _onItemTapped(1);
              },
            ),
          ],
        ),
      ),

      body: Material(child: _widgetOptions.elementAt(_selectedIndex)),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Form"),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
