import 'package:realm/realm.dart';

part 'informer_plant.realm.dart';

@RealmModel()
class _PlantInformer {
  @PrimaryKey()
  @MapTo('_idP')
  late int id;
  late String name;
  late String image;
  late String shortDesc;
  late String longDesc;
  late String timeToGrow;
  late List<String> promptHist;
}

class Plant {
  late int id;
  late String name;
  late String image;
  late String shortDesc;
  late String longDesc;
  late String timeToGrow;
  late List<String> promptHist;

  Plant(
      {this.id = 0,
      required this.name,
      required this.image,
      this.shortDesc = "",
      this.longDesc = "",
      required this.timeToGrow,
      this.promptHist = const []});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['_idP'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      shortDesc: json['shortDesc'] ?? '',
      longDesc: json['longDesc'] ?? '',
      timeToGrow: json['timeToGrow'] ?? "",
      promptHist: (json['promptHist'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}
