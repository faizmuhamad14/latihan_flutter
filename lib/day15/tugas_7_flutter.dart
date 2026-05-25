import 'package:flutter/material.dart';

class Latihan7Flutter extends StatefulWidget {
  const Latihan7Flutter({super.key});
  static const String routeName = '/tugas7';

  @override
  State<Latihan7Flutter> createState() => _Latihan7FlutterState();
}

class _Latihan7FlutterState extends State<Latihan7Flutter> {
  bool isDark = false;
  bool isOn = false;
  bool isCheck = false;
  bool isDrop = false;
  String? selected;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        Expanded(
                          child: Text("Anda Setuju dengan ketentuan PetShop"),
                        ),

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
                        return DropdownMenuItem(value: val, child: Text(val));
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
        ],
      ),
    );
  }
}
