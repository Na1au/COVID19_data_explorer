import 'package:flutter/material.dart';
import 'config_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() {
    return DashboardPageState();
  }
}

class DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard page'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const ConfigPage()));
              },
              icon: Icon(Icons.settings))
        ],
      ),
    );
  }
}
