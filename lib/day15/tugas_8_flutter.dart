import 'package:flutter/material.dart';

class Latihan7Flutter extends StatefulWidget {
  const Latihan7Flutter({super.key});
  static const String routeName = '/tugas7';

  @override
  State<Latihan7Flutter> createState() => _Latihan7FlutterState();
}

class _Latihan7FlutterState extends State<Latihan7Flutter> {
  int _selectedIndex = 0;
  bool isDark = false;
  bool isOn = false;
  bool isCheck = false;
  bool isDrop = false;
  String? selected;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  static const List<Widget> _widgetOptions = <Widget>[Text('')];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); //close drawer
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),

        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF111417),
        scaffoldBackgroundColor: Color(0xFF111417),
        appBarTheme: AppBarTheme(
          foregroundColor: Color(0xFFE1E2E7),
          backgroundColor: Color(0xFF111417),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
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
            ],
          ),
        ),
        appBar: AppBar(title: Text("Form PetShop"), centerTitle: true),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                alignment: Alignment.topLeft,
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: _widgetOptions.elementAt(_selectedIndex)),
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.asset('assets/images/kucing2.jpg'),
                    ),
                    Column(
                      spacing: 3,
                      children: [
                        Switch(
                          value: isDark,
                          onChanged: (value) {
                            setState(() {
                              isDark = value;
                            });
                          },
                        ),
                        Text(isDark ? 'Dark Mode' : 'Light Mode'),
                      ],
                    ),

                    Column(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Anda Setuju dengan ketentuan PetShop"),
                            Checkbox(
                              value: isCheck,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  isCheck = newValue ?? false;
                                });
                              },
                            ),
                          ],
                        ),

                        Text(
                          isCheck
                              ? 'Pendaftaran diperbolehkan'
                              : 'Pendaftaran belum dibolehkan',
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        DropdownButton<String>(
                          value: selected,
                          hint: Text("Pilih Jenis Hewan"),
                          items: ['kucing', 'anjing'].map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selected = val;
                            });
                          },
                        ),
                        Text("Anda Memilih Jenis Hewan $selected"),
                      ],
                    ),
                    Column(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              : "Tanggal yang Anda pilih : ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                        ),
                      ],
                    ),

                    Column(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final TimeOfDay? waktu = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (waktu != null) {
                              setState(() {
                                selectedTime = waktu;
                              });
                            }
                          },
                          child: Text("Pilih Waktu"),
                        ),
                        Text(
                          selectedTime == null
                              ? "anda belum memilih waktu"
                              : "Waktu yang anda pilih adalah ${selectedTime!.format(context)}",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Center(child: _widgetOptions.elementAt(_selectedIndex)),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'profile'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
