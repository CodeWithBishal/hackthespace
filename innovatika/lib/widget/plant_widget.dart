// No of gardens
import 'package:realm/realm.dart';
import 'package:innovatika/database/informer_plant.dart';

class PlantManager {
  // List of Garden
  /// Retrieves a list of all gardens from the database.
  ///
  /// Returns an empty list if the database is empty.
  Future<List> listPlant() async {
    final realm =
        await Realm.open(Configuration.local([PlantInformer.schema]));
    var plant = realm.all<PlantInformer>().toList();
    if (plant.isEmpty) {
      return [];
    }
    return plant;
  }

  // Add Garden
  /// Adds a new garden to the database.
  ///
  /// The [id] parameter is the unique identifier for the garden.
  ///
  /// The [noOfPlants] parameter is the number of plants in the garden.
  Future<void> addPlant(Plant plant) async {
    final realm =
        await Realm.open(Configuration.local([PlantInformer.schema]));
    var garData = PlantInformer(plant.id, plant.image, plant.shortDesc,
        plant.longDesc, plant.timeToGrow);
    realm.write(() {
      realm.add(garData);
    });
  }

  // Add Associates
  /// Associates a plant with a garden.
  ///
  /// The [id] parameter is the unique identifier for the garden.
  ///
  /// The [plantId] parameter is the unique identifier for the plant.
  Future<void> addAssociates(int id, int plantId) async {
    final realm =
        await Realm.open(Configuration.local([PlantInformer.schema]));
    var garData = realm.find<PlantInformer>(id);
    if (garData != null) {
      realm.write(() {
        garData.plantAssoc.add(plantId);
      });
    }
  }

  // Remove Associates
  /// Removes a plant from the associated plants of a garden.
  ///
  /// The [id] parameter is the unique identifier for the garden.
  ///
  /// The [plantId] parameter is the unique identifier for the plant.
  Future<void> removeAssociates(int id, int plantId) async {
    final realm =
        await Realm.open(Configuration.local([GardenInformer.schema]));
    var garData = realm.find<GardenInformer>(id);
    if (garData != null) {
      realm.write(() {
        garData.plantAssoc.remove(plantId);
      });
    }
  }

  // Remove Garden
  /// Deletes a garden from the Realm database.
  ///
  /// The [id] parameter is the unique identifier for the garden.
  ///
  /// Returns a [Future] that resolves when the database operation is complete.
  Future<void> removeGarden(int id) async {
    final realm =
        await Realm.open(Configuration.local([GardenInformer.schema]));
    var garData = realm.find<GardenInformer>(id);
    if (garData != null) {
      realm.write(() {
        realm.delete(garData);
      });
    }
  }
}
