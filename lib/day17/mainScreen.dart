import 'package:flutter/material.dart';
import 'package:latihan_flutter/day17/list.dart';
import 'package:latihan_flutter/day17/list_map.dart';
import 'package:latihan_flutter/day17/list_with_model.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});
  static const String routeName = '/main';

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ListDay17(),
    ListWithModel(),
    ListMapDay17(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List Model"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List Map"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
