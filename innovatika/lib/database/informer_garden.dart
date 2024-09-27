import 'package:realm/realm.dart';

part 'informer_garden.realm.dart';

@RealmModel()
class _GardenInformer {
  @PrimaryKey()
  @MapTo('_idG')
  late int id;
  late int noOfPlants;
  late List<int> plantAssoc;
}

class Garden {
  late int id;
  late int noOfPlants;
  late List<int> plantAssoc;
  Garden(
      {required this.id, required this.noOfPlants, this.plantAssoc = const []});

  factory Garden.fromJson(Map<String, dynamic> json) {
    return Garden(
        id: json['id'],
        noOfPlants: json['noOfPlants'],
        plantAssoc: json['plantAssoc']);
  }
}
