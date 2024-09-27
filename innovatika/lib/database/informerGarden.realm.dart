// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'informerGarden.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class GardenInformer extends _GardenInformer
    with RealmEntity, RealmObjectBase, RealmObject {
  GardenInformer(
    int id,
    int noOfPlants, {
    Iterable<int> plantAssoc = const [],
  }) {
    RealmObjectBase.set(this, '_idG', id);
    RealmObjectBase.set(this, 'noOfPlants', noOfPlants);
    RealmObjectBase.set<RealmList<int>>(
        this, 'plantAssoc', RealmList<int>(plantAssoc));
  }

  GardenInformer._();

  @override
  int get id => RealmObjectBase.get<int>(this, '_idG') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, '_idG', value);

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
      '_idG': id.toEJson(),
      'noOfPlants': noOfPlants.toEJson(),
      'plantAssoc': plantAssoc.toEJson(),
    };
  }

  static EJsonValue _toEJson(GardenInformer value) => value.toEJson();
  static GardenInformer _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_idG': EJsonValue id,
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
          mapTo: '_idG', primaryKey: true),
      SchemaProperty('noOfPlants', RealmPropertyType.int),
      SchemaProperty('plantAssoc', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
