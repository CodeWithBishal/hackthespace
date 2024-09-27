import 'package:realm/realm.dart';

part 'informerPlant.realm.dart';
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
