import 'package:covid19_data_explorer/services/lg_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => ConfigPageState();
}

class ConfigPageState extends State<ConfigPage> {
  bool isConnected = false;
  bool loaded = false;
  String errorCode = '';
  String errorMessage = '';
  late bool visiblePassword;
  final _usernameController = TextEditingController();
  final _ipAddressController = TextEditingController();
  final _portNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _totalMachinesController = TextEditingController();

  clean() async {
    await LGConnection().cleanKML();
  }

  connect() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('ip', _ipAddressController.text);
    await preferences.setString('password', _passwordController.text);
    await preferences.setString('user', _usernameController.text);

    isConnected =  await LGConnection().connect();
    //await preferences.setInt('port', _portNumberController.text as int);

    /* SSHClient client = SSHClient(
        host: _ipAddressController.text,
        port: 22,
        username: _usernameController.text,
        passwordOrKey: _passwordController.text); */

/*     try {
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
    } on PlatformException catch (e) {
      errorCode = e.code;
      errorMessage = e.message!;
      print('not connected $e');
      setState(() {
        isConnected = false;
      });
    } */
  }

  checkConnectionStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('ip', _ipAddressController.text);
    await preferences.setString('password', _passwordController.text);
    await preferences.setString('host', _ipAddressController.text);

    /* SSHClient client = SSHClient(
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
      print('ERROR: $e');
    } */
  }

  init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _ipAddressController.text = preferences.getString('ip') ?? '';
    _passwordController.text = preferences.getString('password') ?? '';
    _usernameController.text = preferences.getString('user') ?? '';

    await checkConnectionStatus();

    loaded = true;
  }

  @override
  void initState() {
    visiblePassword = false;
    super.initState();
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
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    isConnected
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 25,
                          )
                        : const Icon(
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !visiblePassword,
                  decoration: InputDecoration(
                    label: const Text('Master machine password'),
                    hintText: 'p@ssw0rd',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        visiblePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          visiblePassword = !visiblePassword;
                        });
                      },
                    ),
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
                    child: const Text('Connect to LG')),
                ElevatedButton(
                    onPressed: () {
                      clean();
                    },
                    child: const Text('Clean KML'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
