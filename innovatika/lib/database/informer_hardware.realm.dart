// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'informer_hardware.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class HardwareInformer extends _HardwareInformer
    with RealmEntity, RealmObjectBase, RealmObject {
  HardwareInformer(
    String name,
    String ip,
    String ssid,
    String passwd,
    int plantAssociated,
    int id,
  ) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'ip', ip);
    RealmObjectBase.set(this, 'ssid', ssid);
    RealmObjectBase.set(this, 'passwd', passwd);
    RealmObjectBase.set(this, 'plantAssociated', plantAssociated);
    RealmObjectBase.set(this, 'id', id);
  }

  HardwareInformer._();

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
  int get plantAssociated =>
      RealmObjectBase.get<int>(this, 'plantAssociated') as int;
  @override
  set plantAssociated(int value) =>
      RealmObjectBase.set(this, 'plantAssociated', value);

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

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
      'name': name.toEJson(),
      'ip': ip.toEJson(),
      'ssid': ssid.toEJson(),
      'passwd': passwd.toEJson(),
      'plantAssociated': plantAssociated.toEJson(),
      'id': id.toEJson(),
    };
  }

  static EJsonValue _toEJson(HardwareInformer value) => value.toEJson();
  static HardwareInformer _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'name': EJsonValue name,
        'ip': EJsonValue ip,
        'ssid': EJsonValue ssid,
        'passwd': EJsonValue passwd,
        'plantAssociated': EJsonValue plantAssociated,
        'id': EJsonValue id,
      } =>
        HardwareInformer(
          fromEJson(name),
          fromEJson(ip),
          fromEJson(ssid),
          fromEJson(passwd),
          fromEJson(plantAssociated),
          fromEJson(id),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(HardwareInformer._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, HardwareInformer, 'HardwareInformer', [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('ip', RealmPropertyType.string),
      SchemaProperty('ssid', RealmPropertyType.string),
      SchemaProperty('passwd', RealmPropertyType.string),
      SchemaProperty('plantAssociated', RealmPropertyType.int),
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
