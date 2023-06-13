import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:ssh/ssh.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => ConfigPageState();
}

class ConfigPageState extends State<ConfigPage> {
  bool isConnected = false;
  final _usernameController = TextEditingController();
  final _ipAddressController = TextEditingController();
  final _portNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _totalMachinesController = TextEditingController();

  connect() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('ip', _ipAddressController.text);
    await preferences.setString('password', _passwordController.text);

    SSHClient client = SSHClient(
        host: _ipAddressController.text,
        port: (_portNumberController.text) as int,
        username: _usernameController.text,
        passwordOrKey: _passwordController.text);

        try {
          await client.connect();
          setState(() {
            isConnected = true;
          });
          print('connected');
        } catch (e) {
          print('not connected');
          setState(() {
            isConnected = false;
          });
        }
  }

    checkConnectionStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('ip', _ipAddressController.text);
    await preferences.setString('password', _passwordController.text);

    SSHClient client = SSHClient(
      host: _ipAddressController.text,
      port: (_portNumberController.text) as int,
      username: _usernameController.text,
      passwordOrKey: _passwordController.text,
    );

    try {
      await client.connect();
      setState(() {
        isConnected = true;
      });
      await client.disconnect();
      print('connected');
    } catch (e) {
      setState(() {
        isConnected = false;
      });
      print('ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Config LG'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50),
          children: [
            const SizedBox(height: 80),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Establish connection',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    label: Text('Master machine username'),
                    hintText: 'username',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _ipAddressController,
                  decoration: const InputDecoration(
                    label: Text('Master machine IP address'),
                    hintText: '192.168.10.21',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _portNumberController,
                  decoration: const InputDecoration(
                    label: Text('Master machine port number'),
                    hintText: '3000',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    label: Text('Master machine password'),
                    hintText: 'p@ssw0rd',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _totalMachinesController,
                  decoration: const InputDecoration(
                    label: Text('Total machines in LG rig'),
                    hintText: '5',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      connect();
                    },
                    child: const Text('Connect to LG'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
