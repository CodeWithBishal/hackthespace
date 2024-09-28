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
  late int id;
  late String name;
  late String ip;
  late String ssid;
  late String passwd;
  late int plantAssociated;
  Hardware({
    required this.id,
    required this.name,
    required this.ip,
    required this.ssid,
    required this.passwd,
    this.plantAssociated = -1,
  });

  factory Hardware.fromJson(Map<String, dynamic> json) {
    return Hardware(
      id: json['id'],
      name: json['name'],
      ip: json['ip'],
      ssid: json['ssid'],
      passwd: json['passwd'],
      plantAssociated: json['plantAssociated'] ?? -1,
    );
  }
}
