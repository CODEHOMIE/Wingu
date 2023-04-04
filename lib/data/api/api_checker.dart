import '../../util/export_files.dart';
import 'dart:io';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
    } else if (response.statusCode == 429) {
    } else if (response.statusCode == -1) {
    } else {}
  }

  static Future<bool> isVpnActive() async {
    bool isVpnActive;
    List<NetworkInterface> interfaces = await NetworkInterface.list(
        includeLoopback: false, type: InternetAddressType.any);
    interfaces.isNotEmpty
        ? isVpnActive = interfaces.any((interface) =>
            interface.name.contains("tun") ||
            interface.name.contains("ppp") ||
            interface.name.contains("pptp"))
        : isVpnActive = false;

    return isVpnActive;
  }
}
