import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:latihan_flutter/database/preference.dart';
import 'package:latihan_flutter/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await Preference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
