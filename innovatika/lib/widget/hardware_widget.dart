// No of gardens
import 'package:realm/realm.dart';
import 'package:innovatika/database/informer_hardware.dart';

class HardwareManager {
  Future<List> listDevices() async {
    final realm =
        await Realm.open(Configuration.local([HardwareInformer.schema]));
    var devices = realm.all<HardwareInformer>().toList();
    if (devices.isEmpty) {
      return [];
    }
    return devices;
  }

  Future<void> addHardware(Hardware hardware) async {
    final realm =
        await Realm.open(Configuration.local([HardwareInformer.schema]));
    var garData = HardwareInformer(
      hardware.name,
      hardware.ip,
      hardware.ssid,
      hardware.passwd,
      hardware.plantAssociated,
      hardware.id,
    );
    realm.write(() {
      realm.add(garData);
    });
  }

  Future<void> addGarden(int id, int plantID) async {
    final realm =
        await Realm.open(Configuration.local([HardwareInformer.schema]));
    var garData = realm.find<HardwareInformer>(id);
    if (garData != null) {
      realm.write(() {
        garData.plantAssociated = plantID;
      });
    }
  }

  Future<void> removeHardware(int id) async {
    final realm =
        await Realm.open(Configuration.local([HardwareInformer.schema]));
    var garData = realm.find<HardwareInformer>(id);
    if (garData != null) {
      realm.write(() {
        realm.delete(garData);
      });
    }
  }
}
