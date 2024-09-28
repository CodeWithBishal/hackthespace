// No of gardens
import 'package:realm/realm.dart';
import 'package:innovatika/database/informer_hardware.dart';

class PlantManager {
  Future<List> listPlant() async {
    final realm =
        await Realm.open(Configuration.local([HardwareInformer.schema]));
    var plant = realm.all<HardwareInformer>().toList();
    if (plant.isEmpty) {
      return [];
    }
    return plant;
  }

  Future<void> addPlant(Hardware hardware) async {
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
