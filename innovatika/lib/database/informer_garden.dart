import 'package:realm/realm.dart';

part 'informer_garden.realm.dart';

@RealmModel()
class _GardenInformer {
  @PrimaryKey()
  @MapTo('_idG')
  late int id;
  late String imgURL;
  late String dateTime;
  late List<int> plantAssoc;
}

// Garden Model
class Garden {
  late int id;
  late String imgURL;
  late String dateTime;
  late List<int> plantAssoc;
  Garden({
    required this.id,
    this.imgURL = "",
    this.dateTime = "",
    this.plantAssoc = const [],
  });

  factory Garden.fromJson(Map<String, dynamic> json) {
    return Garden(
      id: json['id'],
      imgURL: json["imgURL"],
      dateTime: json["dateTime"],
      plantAssoc: json['plantAssoc'],
    );
  }
}
