import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String email;
  final String kota;
  const ProfilePage({required this.email, super.key, required this.kota});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
