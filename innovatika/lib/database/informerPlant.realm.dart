// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'informerPlant.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class PlantInformer extends _PlantInformer
    with RealmEntity, RealmObjectBase, RealmObject {
  PlantInformer(
    int id,
    String name,
    String shortDesc,
    String longDesc,
    int timeToGrow,
    int attensionTime, {
    Iterable<String> promptHist = const [],
  }) {
    RealmObjectBase.set(this, '_idP', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'shortDesc', shortDesc);
    RealmObjectBase.set(this, 'longDesc', longDesc);
    RealmObjectBase.set(this, 'timeToGrow', timeToGrow);
    RealmObjectBase.set(this, 'attensionTime', attensionTime);
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
  int get timeToGrow => RealmObjectBase.get<int>(this, 'timeToGrow') as int;
  @override
  set timeToGrow(int value) => RealmObjectBase.set(this, 'timeToGrow', value);

  @override
  int get attensionTime =>
      RealmObjectBase.get<int>(this, 'attensionTime') as int;
  @override
  set attensionTime(int value) =>
      RealmObjectBase.set(this, 'attensionTime', value);

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
      'shortDesc': shortDesc.toEJson(),
      'longDesc': longDesc.toEJson(),
      'timeToGrow': timeToGrow.toEJson(),
      'attensionTime': attensionTime.toEJson(),
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
        'shortDesc': EJsonValue shortDesc,
        'longDesc': EJsonValue longDesc,
        'timeToGrow': EJsonValue timeToGrow,
        'attensionTime': EJsonValue attensionTime,
      } =>
        PlantInformer(
          fromEJson(id),
          fromEJson(name),
          fromEJson(shortDesc),
          fromEJson(longDesc),
          fromEJson(timeToGrow),
          fromEJson(attensionTime),
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
      SchemaProperty('shortDesc', RealmPropertyType.string),
      SchemaProperty('longDesc', RealmPropertyType.string),
      SchemaProperty('timeToGrow', RealmPropertyType.int),
      SchemaProperty('attensionTime', RealmPropertyType.int),
      SchemaProperty('promptHist', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
