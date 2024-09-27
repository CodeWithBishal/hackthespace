// No of gardens
import 'package:realm/realm.dart';
import 'package:innovatika/database/informer_garden.dart';

class GardeManager {
  // List of Garden
  /// Retrieves a list of all gardens from the database.
  ///
  /// Returns an empty list if the database is empty.
  Future<List> listGarden() async {
    final realm =
        await Realm.open(Configuration.local([GardenInformer.schema]));
    var garden = realm.all<GardenInformer>().toList();
    if (garden.isEmpty) {
      return [];
    }
    return garden;
  }

  // Add Garden
  /// Adds a new garden to the database.
  ///
  /// The [id] parameter is the unique identifier for the garden.
  ///
  /// The [noOfPlants] parameter is the number of plants in the garden.
  Future<void> addGarden(int id, int noOfPlants) async {
    final realm =
        await Realm.open(Configuration.local([GardenInformer.schema]));
    var garData = GardenInformer(id, noOfPlants);
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
        await Realm.open(Configuration.local([GardenInformer.schema]));
    var garData = realm.find<GardenInformer>(id);
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
