import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:ssh/ssh.dart';

class LGConnection {
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

  _getCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String ip = preferences.getString('ip') ?? '';
    String password = preferences.getString('password') ?? '';

    print('IP ==>> $ip');
    print('PASSWORD ==>> $password');
    return {
      "ip": ip,
      "pass": password,
    };
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<String?> getScreenAmount() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      host: '${credencials['ip']}',
      port: 22,
      username: "lg",
      passwordOrKey: '${credencials['pass']}',
    );
    return client
        .execute("grep -oP '(?<=DHCP_LG_FRAMES_MAX=).*' personavars.txt");
  }

/*   Future sendKML(String kml) async {
    var kml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"> <Placemark>
 <name>The Pentagon</name>
 <Polygon>
 <extrude>1</extrude>
 <altitudeMode>relativeToGround</altitudeMode>
 <outerBoundaryIs>
 <LinearRing>
 <coordinates>
 -77.05788457660967,38.87253259892824,100 
 -77.05465973756702,38.87291016281703,100 
 -77.05315536854791,38.87053267794386,100 
 -77.05552622493516,38.868757801256,100 
 -77.05844056290393,38.86996206506943,100 
 -77.05788457660967,38.87253259892824,100
 </coordinates>
 </LinearRing>
 </outerBoundaryIs>
 <innerBoundaryIs>
 <LinearRing>
 <coordinates>
 -77.05668055019126,38.87154239798456,100 
 -77.05542625960818,38.87167890344077,100 
 -77.05485125901024,38.87076535397792,100 
 -77.05577677433152,38.87008686581446,100 
 -77.05691162017543,38.87054446963351,100 
 -77.05668055019126,38.87154239798456,100
 </coordinates>
 </LinearRing>
 </innerBoundaryIs>
 </Polygon>
 </Placemark> </kml>''';
  } */
}
