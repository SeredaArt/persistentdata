// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lastnameMeta =
      const VerificationMeta('lastname');
  @override
  late final GeneratedColumn<String> lastname = GeneratedColumn<String>(
      'lastname', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _yearsMeta = const VerificationMeta('years');
  @override
  late final GeneratedColumn<int> years = GeneratedColumn<int>(
      'years', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<int> phone = GeneratedColumn<int>(
      'phone', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _cardMeta = const VerificationMeta('card');
  @override
  late final GeneratedColumn<int> card = GeneratedColumn<int>(
      'card', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, lastname, years, image, phone, card];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('lastname')) {
      context.handle(_lastnameMeta,
          lastname.isAcceptableOrUnknown(data['lastname']!, _lastnameMeta));
    } else if (isInserting) {
      context.missing(_lastnameMeta);
    }
    if (data.containsKey('years')) {
      context.handle(
          _yearsMeta, years.isAcceptableOrUnknown(data['years']!, _yearsMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('card')) {
      context.handle(
          _cardMeta, card.isAcceptableOrUnknown(data['card']!, _cardMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      lastname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lastname'])!,
      years: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}years']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}phone']),
      card: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}card']),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String lastname;
  final int? years;
  final String image;
  final int? phone;
  final int? card;
  const User(
      {required this.id,
      required this.name,
      required this.lastname,
      this.years,
      required this.image,
      this.phone,
      this.card});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['lastname'] = Variable<String>(lastname);
    if (!nullToAbsent || years != null) {
      map['years'] = Variable<int>(years);
    }
    map['image'] = Variable<String>(image);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<int>(phone);
    }
    if (!nullToAbsent || card != null) {
      map['card'] = Variable<int>(card);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      lastname: Value(lastname),
      years:
          years == null && nullToAbsent ? const Value.absent() : Value(years),
      image: Value(image),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      card: card == null && nullToAbsent ? const Value.absent() : Value(card),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lastname: serializer.fromJson<String>(json['lastname']),
      years: serializer.fromJson<int?>(json['years']),
      image: serializer.fromJson<String>(json['image']),
      phone: serializer.fromJson<int?>(json['phone']),
      card: serializer.fromJson<int?>(json['card']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lastname': serializer.toJson<String>(lastname),
      'years': serializer.toJson<int?>(years),
      'image': serializer.toJson<String>(image),
      'phone': serializer.toJson<int?>(phone),
      'card': serializer.toJson<int?>(card),
    };
  }

  User copyWith(
          {int? id,
          String? name,
          String? lastname,
          Value<int?> years = const Value.absent(),
          String? image,
          Value<int?> phone = const Value.absent(),
          Value<int?> card = const Value.absent()}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        years: years.present ? years.value : this.years,
        image: image ?? this.image,
        phone: phone.present ? phone.value : this.phone,
        card: card.present ? card.value : this.card,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastname: $lastname, ')
          ..write('years: $years, ')
          ..write('image: $image, ')
          ..write('phone: $phone, ')
          ..write('card: $card')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, lastname, years, image, phone, card);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastname == this.lastname &&
          other.years == this.years &&
          other.image == this.image &&
          other.phone == this.phone &&
          other.card == this.card);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> lastname;
  final Value<int?> years;
  final Value<String> image;
  final Value<int?> phone;
  final Value<int?> card;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastname = const Value.absent(),
    this.years = const Value.absent(),
    this.image = const Value.absent(),
    this.phone = const Value.absent(),
    this.card = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String lastname,
    this.years = const Value.absent(),
    required String image,
    this.phone = const Value.absent(),
    this.card = const Value.absent(),
  })  : name = Value(name),
        lastname = Value(lastname),
        image = Value(image);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? lastname,
    Expression<int>? years,
    Expression<String>? image,
    Expression<int>? phone,
    Expression<int>? card,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastname != null) 'lastname': lastname,
      if (years != null) 'years': years,
      if (image != null) 'image': image,
      if (phone != null) 'phone': phone,
      if (card != null) 'card': card,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? lastname,
      Value<int?>? years,
      Value<String>? image,
      Value<int?>? phone,
      Value<int?>? card}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      years: years ?? this.years,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      card: card ?? this.card,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lastname.present) {
      map['lastname'] = Variable<String>(lastname.value);
    }
    if (years.present) {
      map['years'] = Variable<int>(years.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (phone.present) {
      map['phone'] = Variable<int>(phone.value);
    }
    if (card.present) {
      map['card'] = Variable<int>(card.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastname: $lastname, ')
          ..write('years: $years, ')
          ..write('image: $image, ')
          ..write('phone: $phone, ')
          ..write('card: $card')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDataBase extends GeneratedDatabase {
  _$MyDataBase(QueryExecutor e) : super(e);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}
