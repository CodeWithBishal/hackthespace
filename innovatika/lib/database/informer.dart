import 'package:realm/realm.dart';

part 'informer.realm.dart';

@RealmModel()
class _Hardware {
  @PrimaryKey()
  @MapTo('_idH')
  late int id;
  late String name;
  late String ip;
  late String ssid;
  late String passwd;
  late List<int> gardenAssoc;
}

@RealmModel()
class _GardenInformer {
  @PrimaryKey()
  @MapTo('_idG')
  late int id;
  late int noOfPlants;
  late List<int> plantAssoc;
}

@RealmModel()
class _PlantInformer {
  @PrimaryKey()
  @MapTo('_idP')
  late int id;
  late String name;
  late String shortDesc;
  late String longDesc;
  late int timeToGrow;
  late int attensionTime;
  late List<String> promptHist;
}