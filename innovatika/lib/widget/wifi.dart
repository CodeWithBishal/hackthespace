import 'package:innovatika/widget/urls.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:http/http.dart' as http;

Future<bool> connectWifi(String ssid, String pass) async {
  late bool isConnected = false;

  // bool alreadyConnected = await WiFiForIoTPlugin.isConnected();
  // if (alreadyConnected) {
  //   await WiFiForIoTPlugin.disconnect();
  // }
  await WiFiForIoTPlugin.connect(
    ssid,
    password: pass,
    joinOnce: false,
    security: NetworkSecurity.WPA,
    withInternet: false,
    timeoutInSeconds: 10,
  ).then((onValue) {
    isConnected = onValue;
  });
  await WiFiForIoTPlugin.forceWifiUsage(true);
  return isConnected;
}

Future<bool> isPingSuccessful(String ipAddr) async {
  late bool isSuccess = false;
  try {
    final response = await http.get(Uri.parse(pingURLConst(ipAddr)));
    if (response.statusCode == 200) {
      isSuccess = true;
    }
  } catch (e) {
    isSuccess = false;
  }
  return isSuccess;
}
