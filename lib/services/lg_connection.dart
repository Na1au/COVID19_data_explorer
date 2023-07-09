import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartssh2/dartssh2.dart';

class LGConnection {
  late SSHClient client;
  late SSHSocket socket;
  late dynamic credencials;

  int screenAmount = 5;

  int get leftScreen {
    if (screenAmount == 1) {
      return 1;
    }

    return (screenAmount / 2).floor() + 2;
  }

  int get rightScreen {
    if (screenAmount == 1) {
      return 1;
    }

    return (screenAmount / 2).floor() + 1;
  }

  _getCredencials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String ip = preferences.getString('ip') ?? '';
    String password = preferences.getString('password') ?? 'lq';
    String user = preferences.getString('user') ?? 'lg';

    return {"ip": ip, "pass": password, "user": user};
  }

  connect() async {
    credencials = await _getCredencials();
    try {
      socket = await SSHSocket.connect('${credencials['ip']}', 22,
          timeout: const Duration(seconds: 10));

      client = SSHClient(socket,
          username: '${credencials['user']}',
          onPasswordRequest: () => '${credencials['pass']}');

      sendTestKML();

      return true;
    } catch (e) {
      print('ERROR IN STABILISH CONNECTION ==>> $e');

      return false;
    }
  }

  disconnect() async {
    credencials = await _getCredencials();
    socket = await SSHSocket.connect('${credencials['ip']}', 22,
        timeout: const Duration(seconds: 10));
    client = SSHClient(socket,
        username: '${credencials['user']}',
        onPasswordRequest: () => '${credencials['pass']}');
    client.close();
  }

  checkConnection() async {
    credencials = await _getCredencials();
    try {
      socket = await SSHSocket.connect('${credencials['ip']}', 22,
          timeout: const Duration(seconds: 10));
      client = SSHClient(socket,
          username: '${credencials['user']}',
          onPasswordRequest: () => '${credencials['pass']}');
      return true;
    } catch (e) {
      print('ERROR IN STABILISH CONNECTION ==>> $e');
      return false;
    }
  }

  sendTestKML() async {
    try {
      await client.run("echo '$testKML' > /var/www/html/Facens.kml");
      await client
          .run('echo "http://lg1:81/Facens.kml" > /var/www/html/kmls.txt');
      await client.run("echo '$flyToKML' > /tmp/query.txt");
    } catch (e) {
      throw ('ERROR ON SEND KML FILE: $e');
    }
  }

  sendKML(String fileName, String kml, String flyTo) async {
    credencials = await _getCredencials();
    try {
      socket = await SSHSocket.connect('${credencials['ip']}', 22,
          timeout: const Duration(seconds: 10));
      client = SSHClient(socket,
          username: '${credencials['user']}',
          onPasswordRequest: () => '${credencials['pass']}');
      await client.run("echo '$kml' > /var/www/html/$fileName.kml");
      await client
          .run('echo "http://lg1:81/$fileName.kml" > /var/www/html/kmls.txt');
      await client.run("echo '$flyTo' > /tmp/query.txt");
    } catch (e) {
      throw ('ERROR ON SEND KML FILE: $e');
    }
  }

  cleanKML() async {
    credencials = await _getCredencials();
    socket = await SSHSocket.connect('${credencials['ip']}', 22,
        timeout: const Duration(seconds: 10));

    client = SSHClient(socket,
        username: '${credencials['user']}',
        onPasswordRequest: () => '${credencials['pass']}');
    try {
      await client.run("echo '' > /var/www/html/kmls.txt");
    } catch (e) {
      throw ('ERROR ON CLEAN VISUALIZATION: $e');
    }
  }

  String flyToKML =
      '''flytoview=<LookAt><longitude>-47.426886</longitude><latitude>-23.470097</latitude><altitude>1000</altitude><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>
''';

  String testKML = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
  <name>Facens</name>
  <open>1</open>
  <Style id="PolyStyle">
    <PolyStyle>
      <color>fff00760</color>
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
          -47.426886,-23.470097,1000000
          -47.431220,-23.468501,1000000
          -47.432474,-23.470619,1000000
          -47.430268,-23.472263,1000000
          -47.426886,-23.470097,1000000
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>
</Document>
</kml>
 ''';
}
