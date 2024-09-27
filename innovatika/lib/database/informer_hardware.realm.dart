// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'informer_hardware.dart';

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
    String passwd,
    String userId, {
    Iterable<int> gardenAssoc = const [],
  }) {
    RealmObjectBase.set(this, '_idH', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'ip', ip);
    RealmObjectBase.set(this, 'ssid', ssid);
    RealmObjectBase.set(this, 'passwd', passwd);
    RealmObjectBase.set<RealmList<int>>(
        this, 'gardenAssoc', RealmList<int>(gardenAssoc));
    RealmObjectBase.set(this, 'userId', userId);
  }

  HardwareInformer._();

  @override
  int get id => RealmObjectBase.get<int>(this, '_idH') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, '_idH', value);

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
  String get userId => RealmObjectBase.get<String>(this, 'userId') as String;
  @override
  set userId(String value) => RealmObjectBase.set(this, 'userId', value);

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
      '_idH': id.toEJson(),
      'name': name.toEJson(),
      'ip': ip.toEJson(),
      'ssid': ssid.toEJson(),
      'passwd': passwd.toEJson(),
      'gardenAssoc': gardenAssoc.toEJson(),
      'userId': userId.toEJson(),
    };
  }

  static EJsonValue _toEJson(HardwareInformer value) => value.toEJson();
  static HardwareInformer _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_idH': EJsonValue id,
        'name': EJsonValue name,
        'ip': EJsonValue ip,
        'ssid': EJsonValue ssid,
        'passwd': EJsonValue passwd,
        'userId': EJsonValue userId,
      } =>
        HardwareInformer(
          fromEJson(id),
          fromEJson(name),
          fromEJson(ip),
          fromEJson(ssid),
          fromEJson(passwd),
          fromEJson(userId),
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
          mapTo: '_idH', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('ip', RealmPropertyType.string),
      SchemaProperty('ssid', RealmPropertyType.string),
      SchemaProperty('passwd', RealmPropertyType.string),
      SchemaProperty('gardenAssoc', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
      SchemaProperty('userId', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
