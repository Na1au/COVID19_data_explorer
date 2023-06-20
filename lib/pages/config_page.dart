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
  bool loaded = false;
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
        port: 22,
        username: _usernameController.text,
        passwordOrKey: _passwordController.text);

    try {
      print('CLIENT ===>>> ${client.host}');
      await client.connect();
      setState(() {
        isConnected = true;
      });
      print('connected');
      String kml = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
  <name>Facens</name>
  <open>1</open>
  <Style id="PolyStyle">
    <PolyStyle>
      <color>7ff00760</color>
	<fill>true</fill>
	<outline></outline>
    </PolyStyle>
  </Style>
  <Placemark>
    <name>polygon</name>
    <styleUrl>#PolyStyle</styleUrl>
    <Polygon>
      <extrude>1</extrude>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs>
        <LinearRing>
          <coordinates>
          -47.426886,-23.470097,100
          -47.431220,-23.468501,100
          -47.432474,-23.470619,100
          -47.430268,-23.472263,100
          -47.426886,-23.470097,100
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>
</Document>
</kml>
 ''';
      print(kml);
      await client.execute("echo '$kml' > /var/www/html/Facens.kml");
      print('executou 1');

      await client
          .execute('echo "http://lg1:81/Facens.kml" > /var/www/html/kmls.txt');
      print('executou 2');
    } catch (e) {
      print('not connected $e');
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
      port: 22,
      username: 'lg',
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

  init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _ipAddressController.text = preferences.getString('master_ip') ?? '';
    _passwordController.text = preferences.getString('master_password') ?? '';

    await checkConnectionStatus();

    loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) init();

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
                Row(
                  children: [
                    const Text(
                      'Connection status: ',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    Text(
                      isConnected ? 'CONNECTED' : 'DISCONNECTED',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    isConnected
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 25,
                          )
                        : Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 25,
                          ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    label: Text('Master machine username'),
                    hintText: 'lg',
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
                /* const SizedBox(height: 20),
                TextFormField(
                  controller: _portNumberController,
                  decoration: const InputDecoration(
                    label: Text('Master machine port number'),
                    hintText: '22',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ), */
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
                    hintText: '3',
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
