import 'package:covid19_data_explorer/pages/dashboard_page.dart';
import 'package:covid19_data_explorer/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
          primary: const Color.fromARGB(255, 165, 16, 16),
          ),
      ),
      initialRoute: '/splash',
      routes: {
        '/': (context) => const DashboardPage(),
        '/splash': (context) => const SplashScreen()
      },
    );
  }
}
