import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartssh2/dartssh2.dart';

class LGConnection {
  late SSHClient client;
  late SSHSocket socket;
  late dynamic credencials;
  late int screenAmount;

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
    int screen = preferences.getInt('screen') ?? 5;

    screenAmount = screen;

    return {"ip": ip, "pass": password, "user": user, 'screen': screen};
  }

  Future<String?> getScreenAmount() async {
    credencials = await _getCredencials();
    socket = await SSHSocket.connect('${credencials['ip']}', 22,
        timeout: const Duration(seconds: 10));

    client = SSHClient(socket,
        username: '${credencials['user']}',
        onPasswordRequest: () => '${credencials['pass']}');
    client.execute("grep -oP '(?<=DHCP_LG_FRAMES_MAX=).*' personavars.txt");
    return '3';
  }

  Future openLogos() async {
    credencials = await _getCredencials();
    socket = await SSHSocket.connect('${credencials['ip']}', 22,
        timeout: const Duration(seconds: 10));

    client = SSHClient(socket,
        username: '${credencials['user']}',
        onPasswordRequest: () => '${credencials['pass']}');
    try {
      await client
          .execute("echo '$logoKML' > /var/www/html/kml/slave_$leftScreen.kml");
    } catch (e) {
      print('ERROR ON SEND LOGOS ==>> $e');
    }
  }

  connect() async {
    credencials = await _getCredencials();
    try {
      socket = await SSHSocket.connect('${credencials['ip']}', 22,
          timeout: const Duration(seconds: 10));

      client = SSHClient(socket,
          username: '${credencials['user']}',
          onPasswordRequest: () => '${credencials['pass']}');
      await openLogos();
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
    await client.execute("echo '' > /var/www/html/kml/slave_$leftScreen.kml");
    cleanKML();
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
      client.close();
    } catch (e) {
      throw ('ERROR ON SEND KML FILE: $e');
    }
  }

  sendBalloon(balloon, balloonName) async {
    credencials = await _getCredencials();
    try {
      socket = await SSHSocket.connect('${credencials['ip']}', 22,
          timeout: const Duration(seconds: 10));
      client = SSHClient(socket,
          username: '${credencials['user']}',
          onPasswordRequest: () => '${credencials['pass']}');
      await client.execute(
          "echo '$balloon' > /var/www/html/kml/slave_$rightScreen.kml");
      print('SLAVE RIGHT ==>> $rightScreen');
      client.close();
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
      client.close();
    } catch (e) {
      throw ('ERROR ON CLEAN VISUALIZATION: $e');
    }
  }

  Future<void> relaunchLg() async {
    credencials = await _getCredencials();

    socket = await SSHSocket.connect('${credencials['ip']}', 22,
        timeout: const Duration(seconds: 10));

    client = SSHClient(socket,
        username: '${credencials['user']}',
        onPasswordRequest: () => '${credencials['pass']}');

    for (var i = screenAmount; i >= 1; i--) {
      try {
        final relaunchCommand = """RELAUNCH_CMD="\\
      if [ -f /etc/init/lxdm.conf ]; then
        export SERVICE=lxdm
      elif [ -f /etc/init/lightdm.conf ]; then
        export SERVICE=lightdm
      else
        exit 1
      fi
      if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
        echo ${credencials['pass']} | sudo -S service \\\${SERVICE} start
      else
        echo ${credencials['pass']} | sudo -S service \\\${SERVICE} restart
      fi
      " && sshpass -p ${credencials['pass']} ssh -x -t lg@lg$i "\$RELAUNCH_CMD\"""";
        await client.run('"/home/lg/bin/lg-relaunch" > /home/lg/log.txt');
        await client.run(relaunchCommand);
      } catch (e) {
        print('Could not connect to host LG');
        return Future.error(e);
      }
    }
  }

  Future<void> shutdownLg() async {
    credencials = await _getCredencials();

    socket = await SSHSocket.connect('${credencials['ip']}', 22,
        timeout: const Duration(seconds: 10));

    client = SSHClient(socket,
        username: '${credencials['user']}',
        onPasswordRequest: () => '${credencials['pass']}');

    for (var i = screenAmount; i >= 1; i--) {
      try {
        await client.run(
            'sshpass -p ${credencials['pass']} ssh -t lg$i "echo ${credencials['pass']} | sudo -S poweroff"');
      } catch (e) {
        print('Could not connect to host LG');
        return Future.error(e);
      }
    }
  }

  sendOrbit(String filename, String orbit) async {
    credencials = await _getCredencials();
    try {
      socket = await SSHSocket.connect('${credencials['ip']}', 22,
          timeout: const Duration(seconds: 10));
      client = SSHClient(socket,
          username: '${credencials['user']}',
          onPasswordRequest: () => '${credencials['pass']}');
      await client.run("echo '$orbit' > /var/www/html/$filename.kml");
      await client
          .run('echo "http://lg1:81/$filename.kml" >> /var/www/html/kmls.txt');
      await client.run("echo 'playtour=$filename' > /tmp/query.txt");
      client.close();
    } catch (e) {
      throw ('ERROR ON SEND ORBIT KML FILE: $e');
    }
  }

  stopTour() async {
    credencials = await _getCredencials();
    try {
      socket = await SSHSocket.connect('${credencials['ip']}', 22,
          timeout: const Duration(seconds: 10));
      client = SSHClient(socket,
          username: '${credencials['user']}',
          onPasswordRequest: () => '${credencials['pass']}');
      await client.run("echo 'exittour=true' > /tmp/query.txt");
      client.close();
    } catch (e) {
      throw ('ERROR ON STO P TOUR: $e');
    }
  }

  String logoKML = '''
<?xml version="1.0" encoding="UTF-8"?>
  <kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
    <Document id ="logo">
      <name>COVID19 data explorer</name>
        <Folder>
        <name>Logos</name>
        <ScreenOverlay>
        <name>Logo</name>
        <Icon>
        <href>https://i.imgur.com/HGUUSHb.png</href>
        </Icon>
        <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
        <screenXY x="0.02" y="0.95" xunits="fraction" yunits="fraction"/>
        <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
        <size x="0.6" y="0.8" xunits="fraction" yunits="fraction"/>
        </ScreenOverlay>
        </Folder>
    </Document>
  </kml>
''';

/*   String flyToKML =
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
 '''; */
}
