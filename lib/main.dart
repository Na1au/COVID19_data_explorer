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
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/': (context) => const DashboardPage(),
        '/splash': (context) => const SplashScreen()
      },
    );
  }
}
