import 'package:realm/realm.dart';

part 'informerGarden.realm.dart';

@RealmModel()
class _GardenInformer {
  @PrimaryKey()
  @MapTo('_idG')
  late int id;
  late int noOfPlants;
  late List<int> plantAssoc;
}
