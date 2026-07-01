import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/auth_provider.dart';
import 'utils/constants.dart';
import 'views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi PPKD B6',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        primaryColor: AppConstants.primaryColor,
        colorScheme: const ColorScheme.dark(
          primary: AppConstants.secondaryColor,
          secondary: AppConstants.accentColor,
          surface: AppConstants.cardColor,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: AppConstants.textColorPrimary,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: AppConstants.textColorPrimary),
          bodyMedium: TextStyle(color: AppConstants.textColorSecondary),
        ),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}
