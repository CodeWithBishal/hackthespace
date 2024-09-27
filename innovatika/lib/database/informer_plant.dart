import 'package:realm/realm.dart';

part 'informer_plant.realm.dart';

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

class Plant {
  late int id;
  late String name;
  late String shortDesc;
  late String longDesc;
  late int timeToGrow;
  late int attensionTime;
  late List<String> promptHist;

  Plant(
      {required this.id,
      required this.name,
      required this.shortDesc,
      required this.longDesc,
      required this.timeToGrow,
      required this.attensionTime,
      this.promptHist = const []});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
        id: json['_idP'],
        name: json['name'],
        shortDesc: json['shortDesc'],
        longDesc: json['longDesc'],
        timeToGrow: json['timeToGrow'],
        attensionTime: json['attensionTime'],
        promptHist: json['promptHist']);
  }
}
