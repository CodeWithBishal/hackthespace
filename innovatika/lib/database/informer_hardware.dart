import 'package:realm/realm.dart';
part 'informer_hardware.realm.dart';

@RealmModel()
class _HardwareInformer {
  late String name;
  late String ip;
  late String ssid;
  late String passwd;
  late int plantAssociated;
  @PrimaryKey()
  late int id;
}

class Hardware {
  late String name;
  late String ip;
  late String ssid;
  late String passwd;
  late int plantAssociated;

  late int id;
  Hardware({
    required this.name,
    required this.ip,
    required this.ssid,
    required this.passwd,
    this.plantAssociated = 0,
    required this.id,
  });

  factory Hardware.fromJson(Map<String, dynamic> json) {
    return Hardware(
      name: json['name'],
      ip: json['ip'],
      ssid: json['ssid'],
      passwd: json['passwd'],
      plantAssociated: json['plantAssociated'] ?? 0,
      id: json['id'],
    );
  }
}
