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
}
