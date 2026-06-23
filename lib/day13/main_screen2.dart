import 'package:flutter/material.dart';
import 'package:latihan_flutter/day15/profile.dart';

class MainScreen2 extends StatefulWidget {
  const MainScreen2({super.key, required this.email, required this.kota});

  final String email;
  final String kota;

  @override
  State<MainScreen2> createState() => _MainScreen2State();
}

class _MainScreen2State extends State<MainScreen2> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ProfilePage(email: '', kota: ''),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // DRAWER KIRI
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.person, size: 50, color: Colors.white),

                  SizedBox(height: 10),

                  Text(
                    widget.email,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),

              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: Icon(Icons.task),
              title: Text("Tugas Flutter"),

              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // DRAWER KANAN
      endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Email: ${widget.email}"),
            Text("Kota: ${widget.kota}"),
          ],
        ),
      ),

      appBar: AppBar(title: Text("Drawer & Bottom Navigation")),

      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,

        onTap: _onItemTapped,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tugas"),
        ],
      ),
    );
  }
}
