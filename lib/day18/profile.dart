import 'package:flutter/material.dart';

class ProfilePage2 extends StatefulWidget {
  final String email;
  final String kota;
  const ProfilePage2({required this.email, super.key, required this.kota});

  @override
  State<ProfilePage2> createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(widget.email), Text(widget.kota)],
        ),
      ),
    );
  }
}
