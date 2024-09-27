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
}
