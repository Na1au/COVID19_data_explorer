import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe
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
    //int port = preferences.getInt('port') ?? 22;
    String user = preferences.getString('user') ?? 'lg';

    print('IP ==>> $ip');
    print('PASSWORD ==>> $password');
    return {
      "ip": ip,
      "pass": password,
      "user": user
    };
  }

  connect() async {
    credencials = await _getCredencials();
    try {
      socket = await SSHSocket.connect('${credencials['ip']}', 22, timeout: const Duration(seconds: 10));
      
      client = SSHClient(socket, username: '${credencials['user']}', onPasswordRequest: () => '${credencials['pass']}');

      print('conectou');
      sendTestKML();

      return true;
    } catch (e) {
      print('ERROR IN STABILISH CONNECTION ==>> $e');

      return false;
    }
  }

  checkConnection() async {
    credencials = await _getCredencials();
    try {
      socket = await SSHSocket.connect('${credencials['ip']}', 22, timeout: const Duration(seconds: 10));
      client = SSHClient(socket, username: '${credencials['user']}', onPasswordRequest: () => '${credencials['pass']}');
      return true;
    } catch (e) {
      print('ERROR IN STABILISH CONNECTION ==>> $e');
      return false;
    }
  }

  sendTestKML() async {
    try {
      await client.run("echo '$testKML' > /var/www/html/Facens.kml");
      print('FOI 1');
      await client.run('echo "http://lg1:81/Facens.kml" > /var/www/html/kmls.txt');
      print('FOI 2');
      await client.run("echo '$flyToKML' > /tmp/query.txt");
    } catch (e) {
      print('ERROR ON SEND KML FILE ==>> $e');
    }
  }

  cleanKML() async {
    credencials = await _getCredencials();
    socket = await SSHSocket.connect('${credencials['ip']}', 22, timeout: const Duration(seconds: 10));
      
      client = SSHClient(socket, username: '${credencials['user']}', onPasswordRequest: () => '${credencials['pass']}');
    try {
      await client.run("echo '' > /var/www/html/kmls.txt");
    } catch (e) {
      print(e);
    }
  }

  String flyToKML = '''flytoview=<LookAt><longitude>-47.426886</longitude><latitude>-23.470097</latitude><altitude>1000</altitude><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>
''';

  String testKML = '''
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
          -47.426886,-23.470097,50
          -47.431220,-23.468501,50
          -47.432474,-23.470619,50
          -47.430268,-23.472263,50
          -47.426886,-23.470097,50
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>
</Document>
</kml>
 ''';
}
