// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'informer.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class HardwareInformer extends _HardwareInformer
    with RealmEntity, RealmObjectBase, RealmObject {
  HardwareInformer(
    int id,
    String name,
    String ip,
    String ssid,
    String passwd, {
    Iterable<int> gardenAssoc = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'ip', ip);
    RealmObjectBase.set(this, 'ssid', ssid);
    RealmObjectBase.set(this, 'passwd', passwd);
    RealmObjectBase.set<RealmList<int>>(
        this, 'gardenAssoc', RealmList<int>(gardenAssoc));
  }

  HardwareInformer._();

  @override
  int get id => RealmObjectBase.get<int>(this, '_id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get ip => RealmObjectBase.get<String>(this, 'ip') as String;
  @override
  set ip(String value) => RealmObjectBase.set(this, 'ip', value);

  @override
  String get ssid => RealmObjectBase.get<String>(this, 'ssid') as String;
  @override
  set ssid(String value) => RealmObjectBase.set(this, 'ssid', value);

  @override
  String get passwd => RealmObjectBase.get<String>(this, 'passwd') as String;
  @override
  set passwd(String value) => RealmObjectBase.set(this, 'passwd', value);

  @override
  RealmList<int> get gardenAssoc =>
      RealmObjectBase.get<int>(this, 'gardenAssoc') as RealmList<int>;
  @override
  set gardenAssoc(covariant RealmList<int> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<HardwareInformer>> get changes =>
      RealmObjectBase.getChanges<HardwareInformer>(this);

  @override
  Stream<RealmObjectChanges<HardwareInformer>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<HardwareInformer>(this, keyPaths);

  @override
  HardwareInformer freeze() =>
      RealmObjectBase.freezeObject<HardwareInformer>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'name': name.toEJson(),
      'ip': ip.toEJson(),
      'ssid': ssid.toEJson(),
      'passwd': passwd.toEJson(),
      'gardenAssoc': gardenAssoc.toEJson(),
    };
  }

  static EJsonValue _toEJson(HardwareInformer value) => value.toEJson();
  static HardwareInformer _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'name': EJsonValue name,
        'ip': EJsonValue ip,
        'ssid': EJsonValue ssid,
        'passwd': EJsonValue passwd,
      } =>
        HardwareInformer(
          fromEJson(id),
          fromEJson(name),
          fromEJson(ip),
          fromEJson(ssid),
          fromEJson(passwd),
          gardenAssoc: fromEJson(ejson['gardenAssoc']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(HardwareInformer._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, HardwareInformer, 'HardwareInformer', [
      SchemaProperty('id', RealmPropertyType.int,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('ip', RealmPropertyType.string),
      SchemaProperty('ssid', RealmPropertyType.string),
      SchemaProperty('passwd', RealmPropertyType.string),
      SchemaProperty('gardenAssoc', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class GardenInformer extends _GardenInformer
    with RealmEntity, RealmObjectBase, RealmObject {
  GardenInformer(
    int id,
    int noOfPlants, {
    Iterable<int> plantAssoc = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'noOfPlants', noOfPlants);
    RealmObjectBase.set<RealmList<int>>(
        this, 'plantAssoc', RealmList<int>(plantAssoc));
  }

  GardenInformer._();

  @override
  int get id => RealmObjectBase.get<int>(this, '_id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, '_id', value);

  @override
  int get noOfPlants => RealmObjectBase.get<int>(this, 'noOfPlants') as int;
  @override
  set noOfPlants(int value) => RealmObjectBase.set(this, 'noOfPlants', value);

  @override
  RealmList<int> get plantAssoc =>
      RealmObjectBase.get<int>(this, 'plantAssoc') as RealmList<int>;
  @override
  set plantAssoc(covariant RealmList<int> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<GardenInformer>> get changes =>
      RealmObjectBase.getChanges<GardenInformer>(this);

  @override
  Stream<RealmObjectChanges<GardenInformer>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<GardenInformer>(this, keyPaths);

  @override
  GardenInformer freeze() => RealmObjectBase.freezeObject<GardenInformer>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'noOfPlants': noOfPlants.toEJson(),
      'plantAssoc': plantAssoc.toEJson(),
    };
  }

  static EJsonValue _toEJson(GardenInformer value) => value.toEJson();
  static GardenInformer _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'noOfPlants': EJsonValue noOfPlants,
      } =>
        GardenInformer(
          fromEJson(id),
          fromEJson(noOfPlants),
          plantAssoc: fromEJson(ejson['plantAssoc']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(GardenInformer._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, GardenInformer, 'GardenInformer', [
      SchemaProperty('id', RealmPropertyType.int,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('noOfPlants', RealmPropertyType.int),
      SchemaProperty('plantAssoc', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

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
    RealmObjectBase.set(this, '_id', id);
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
  int get id => RealmObjectBase.get<int>(this, '_id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, '_id', value);

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
      '_id': id.toEJson(),
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
        '_id': EJsonValue id,
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
          mapTo: '_id', primaryKey: true),
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
