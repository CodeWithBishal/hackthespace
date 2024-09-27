// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'informer_garden.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class GardenInformer extends _GardenInformer
    with RealmEntity, RealmObjectBase, RealmObject {
  GardenInformer(
    int id,
    String imgURL,
    String dateTime, {
    Iterable<int> plantAssoc = const [],
  }) {
    RealmObjectBase.set(this, '_idG', id);
    RealmObjectBase.set(this, 'imgURL', imgURL);
    RealmObjectBase.set(this, 'dateTime', dateTime);
    RealmObjectBase.set<RealmList<int>>(
        this, 'plantAssoc', RealmList<int>(plantAssoc));
  }

  GardenInformer._();

  @override
  int get id => RealmObjectBase.get<int>(this, '_idG') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, '_idG', value);

  @override
  String get imgURL => RealmObjectBase.get<String>(this, 'imgURL') as String;
  @override
  set imgURL(String value) => RealmObjectBase.set(this, 'imgURL', value);

  @override
  String get dateTime =>
      RealmObjectBase.get<String>(this, 'dateTime') as String;
  @override
  set dateTime(String value) => RealmObjectBase.set(this, 'dateTime', value);

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
      '_idG': id.toEJson(),
      'imgURL': imgURL.toEJson(),
      'dateTime': dateTime.toEJson(),
      'plantAssoc': plantAssoc.toEJson(),
    };
  }

  static EJsonValue _toEJson(GardenInformer value) => value.toEJson();
  static GardenInformer _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_idG': EJsonValue id,
        'imgURL': EJsonValue imgURL,
        'dateTime': EJsonValue dateTime,
      } =>
        GardenInformer(
          fromEJson(id),
          fromEJson(imgURL),
          fromEJson(dateTime),
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
          mapTo: '_idG', primaryKey: true),
      SchemaProperty('imgURL', RealmPropertyType.string),
      SchemaProperty('dateTime', RealmPropertyType.string),
      SchemaProperty('plantAssoc', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
