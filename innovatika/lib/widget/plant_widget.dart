// No of gardens
import 'package:realm/realm.dart';
import 'package:innovatika/database/informer_plant.dart';

class PlantManager {
  Future<List> listPlant() async {
    final realm =
        await Realm.open(Configuration.local([PlantInformer.schema]));
    var plant = realm.all<PlantInformer>().toList();
    if (plant.isEmpty) {
      return [];
    }
    return plant;
  }

  Future<void> addPlant(Plant plant) async {
    final realm =
        await Realm.open(Configuration.local([PlantInformer.schema]));
    var garData = PlantInformer(plant.id, plant.name, plant.image, plant.shortDesc,
        plant.longDesc, plant.timeToGrow);
    realm.write(() {
      realm.add(garData);
    });
  }
  Future<void> addPromptHistory(int id, String prompt) async {
    final realm =
        await Realm.open(Configuration.local([PlantInformer.schema]));
    var garData = realm.find<PlantInformer>(id);
    if (garData != null) {
      realm.write(() {
        garData.promptHist.add(prompt);
      });
    }
  }
  Future<void> removePlant(int id) async {
    final realm =
        await Realm.open(Configuration.local([PlantInformer.schema]));
    var garData = realm.find<PlantInformer>(id);
    if (garData != null) {
      realm.write(() {
        realm.delete(garData);
      });
    }
  }
}
