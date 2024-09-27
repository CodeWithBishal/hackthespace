import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

part 'informerHardware.realm.dart';

@RealmModel()
class _HardwareInformer {
  @PrimaryKey()
  @MapTo('_idH')
  late int id;
  late String name;
  late String ip;
  late String ssid;
  late String passwd;
  late List<int> gardenAssoc;
  late String userId;
}

class Hardware {
  late String name;
  late String ip;
  late String ssid;
  late String passwd;
  late List<int> gardenAssoc;
  late String userId;
  Hardware({
    required this.name,
    required this.ip,
    required this.ssid,
    required this.passwd,
    this.gardenAssoc = const [],
    required this.userId,
  });

  factory Hardware.fromJson(Map<String, dynamic> json) {
    return Hardware(
      name: json['name'],
      ip: json['ip'],
      ssid: json['ssid'],
      passwd: json['passwd'],
      gardenAssoc: json['gardenAssoc'] != null
          ? List<int>.from(json['gardenAssoc'])
          : [],
      userId: json['userId'],
    );
  }
}
