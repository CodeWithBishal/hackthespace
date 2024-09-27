// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'informer_plant.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class PlantInformer extends _PlantInformer
    with RealmEntity, RealmObjectBase, RealmObject {
  PlantInformer(
    int id,
    String name,
    String image,
    String shortDesc,
    String longDesc,
    String timeToGrow, {
    Iterable<String> promptHist = const [],
  }) {
    RealmObjectBase.set(this, '_idP', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'image', image);
    RealmObjectBase.set(this, 'shortDesc', shortDesc);
    RealmObjectBase.set(this, 'longDesc', longDesc);
    RealmObjectBase.set(this, 'timeToGrow', timeToGrow);
    RealmObjectBase.set<RealmList<String>>(
        this, 'promptHist', RealmList<String>(promptHist));
  }

  PlantInformer._();

  @override
  int get id => RealmObjectBase.get<int>(this, '_idP') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, '_idP', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get image => RealmObjectBase.get<String>(this, 'image') as String;
  @override
  set image(String value) => RealmObjectBase.set(this, 'image', value);

  @override
  String get shortDesc =>
      RealmObjectBase.get<String>(this, 'shortDesc') as String;
  @override
  set shortDesc(String value) => RealmObjectBase.set(this, 'shortDesc', value);

  @override
  String get longDesc =>
      RealmObjectBase.get<String>(this, 'longDesc') as String;
  @override
  set longDesc(String value) => RealmObjectBase.set(this, 'longDesc', value);

  @override
  String get timeToGrow =>
      RealmObjectBase.get<String>(this, 'timeToGrow') as String;
  @override
  set timeToGrow(String value) =>
      RealmObjectBase.set(this, 'timeToGrow', value);

  @override
  RealmList<String> get promptHist =>
      RealmObjectBase.get<String>(this, 'promptHist') as RealmList<String>;
  @override
  set promptHist(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<PlantInformer>> get changes =>
      RealmObjectBase.getChanges<PlantInformer>(this);

  @override
  Stream<RealmObjectChanges<PlantInformer>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<PlantInformer>(this, keyPaths);

  @override
  PlantInformer freeze() => RealmObjectBase.freezeObject<PlantInformer>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_idP': id.toEJson(),
      'name': name.toEJson(),
      'image': image.toEJson(),
      'shortDesc': shortDesc.toEJson(),
      'longDesc': longDesc.toEJson(),
      'timeToGrow': timeToGrow.toEJson(),
      'promptHist': promptHist.toEJson(),
    };
  }

  static EJsonValue _toEJson(PlantInformer value) => value.toEJson();
  static PlantInformer _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_idP': EJsonValue id,
        'name': EJsonValue name,
        'image': EJsonValue image,
        'shortDesc': EJsonValue shortDesc,
        'longDesc': EJsonValue longDesc,
        'timeToGrow': EJsonValue timeToGrow,
      } =>
        PlantInformer(
          fromEJson(id),
          fromEJson(name),
          fromEJson(image),
          fromEJson(shortDesc),
          fromEJson(longDesc),
          fromEJson(timeToGrow),
          promptHist: fromEJson(ejson['promptHist']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(PlantInformer._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, PlantInformer, 'PlantInformer', [
      SchemaProperty('id', RealmPropertyType.int,
          mapTo: '_idP', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('image', RealmPropertyType.string),
      SchemaProperty('shortDesc', RealmPropertyType.string),
      SchemaProperty('longDesc', RealmPropertyType.string),
      SchemaProperty('timeToGrow', RealmPropertyType.string),
      SchemaProperty('promptHist', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
