// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RolUserTable extends RolUser with TableInfo<$RolUserTable, RolUserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RolUserTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rol_user';
  @override
  VerificationContext validateIntegrity(Insertable<RolUserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RolUserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RolUserData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $RolUserTable createAlias(String alias) {
    return $RolUserTable(attachedDatabase, alias);
  }
}

class RolUserData extends DataClass implements Insertable<RolUserData> {
  final int id;
  final String description;
  const RolUserData({required this.id, required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['description'] = Variable<String>(description);
    return map;
  }

  RolUserCompanion toCompanion(bool nullToAbsent) {
    return RolUserCompanion(
      id: Value(id),
      description: Value(description),
    );
  }

  factory RolUserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RolUserData(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String>(description),
    };
  }

  RolUserData copyWith({int? id, String? description}) => RolUserData(
        id: id ?? this.id,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('RolUserData(')
          ..write('id: $id, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RolUserData &&
          other.id == this.id &&
          other.description == this.description);
}

class RolUserCompanion extends UpdateCompanion<RolUserData> {
  final Value<int> id;
  final Value<String> description;
  const RolUserCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
  });
  RolUserCompanion.insert({
    this.id = const Value.absent(),
    required String description,
  }) : description = Value(description);
  static Insertable<RolUserData> custom({
    Expression<int>? id,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
    });
  }

  RolUserCompanion copyWith({Value<int>? id, Value<String>? description}) {
    return RolUserCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RolUserCompanion(')
          ..write('id: $id, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

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
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<int> rol = GeneratedColumn<int>(
      'rol', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES rol_user (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, name, password, rol];
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
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('rol')) {
      context.handle(
          _rolMeta, rol.isAcceptableOrUnknown(data['rol']!, _rolMeta));
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
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      rol: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rol']),
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
  final String password;
  final int? rol;
  const User(
      {required this.id, required this.name, required this.password, this.rol});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || rol != null) {
      map['rol'] = Variable<int>(rol);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      password: Value(password),
      rol: rol == null && nullToAbsent ? const Value.absent() : Value(rol),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      password: serializer.fromJson<String>(json['password']),
      rol: serializer.fromJson<int?>(json['rol']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'password': serializer.toJson<String>(password),
      'rol': serializer.toJson<int?>(rol),
    };
  }

  User copyWith(
          {int? id,
          String? name,
          String? password,
          Value<int?> rol = const Value.absent()}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        password: password ?? this.password,
        rol: rol.present ? rol.value : this.rol,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('password: $password, ')
          ..write('rol: $rol')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, password, rol);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.password == this.password &&
          other.rol == this.rol);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> password;
  final Value<int?> rol;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.password = const Value.absent(),
    this.rol = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String password,
    this.rol = const Value.absent(),
  })  : name = Value(name),
        password = Value(password);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? password,
    Expression<int>? rol,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (password != null) 'password': password,
      if (rol != null) 'rol': rol,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? password,
      Value<int?>? rol}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      rol: rol ?? this.rol,
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
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (rol.present) {
      map['rol'] = Variable<int>(rol.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('password: $password, ')
          ..write('rol: $rol')
          ..write(')'))
        .toString();
  }
}

class $ReceiptQuoteTable extends ReceiptQuote
    with TableInfo<$ReceiptQuoteTable, ReceiptQuoteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptQuoteTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameCustomerMeta =
      const VerificationMeta('nameCustomer');
  @override
  late final GeneratedColumn<String> nameCustomer = GeneratedColumn<String>(
      'name_customer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numPhoneMeta =
      const VerificationMeta('numPhone');
  @override
  late final GeneratedColumn<String> numPhone = GeneratedColumn<String>(
      'num_phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mailMeta = const VerificationMeta('mail');
  @override
  late final GeneratedColumn<String> mail = GeneratedColumn<String>(
      'mail', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _folioQuotesMeta =
      const VerificationMeta('folioQuotes');
  @override
  late final GeneratedColumn<String> folioQuotes = GeneratedColumn<String>(
      'folio_quotes', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nameCustomer, numPhone, mail, folioQuotes, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipt_quote';
  @override
  VerificationContext validateIntegrity(Insertable<ReceiptQuoteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_customer')) {
      context.handle(
          _nameCustomerMeta,
          nameCustomer.isAcceptableOrUnknown(
              data['name_customer']!, _nameCustomerMeta));
    } else if (isInserting) {
      context.missing(_nameCustomerMeta);
    }
    if (data.containsKey('num_phone')) {
      context.handle(_numPhoneMeta,
          numPhone.isAcceptableOrUnknown(data['num_phone']!, _numPhoneMeta));
    } else if (isInserting) {
      context.missing(_numPhoneMeta);
    }
    if (data.containsKey('mail')) {
      context.handle(
          _mailMeta, mail.isAcceptableOrUnknown(data['mail']!, _mailMeta));
    } else if (isInserting) {
      context.missing(_mailMeta);
    }
    if (data.containsKey('folio_quotes')) {
      context.handle(
          _folioQuotesMeta,
          folioQuotes.isAcceptableOrUnknown(
              data['folio_quotes']!, _folioQuotesMeta));
    } else if (isInserting) {
      context.missing(_folioQuotesMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReceiptQuoteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReceiptQuoteData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nameCustomer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_customer'])!,
      numPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}num_phone'])!,
      mail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mail'])!,
      folioQuotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}folio_quotes'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $ReceiptQuoteTable createAlias(String alias) {
    return $ReceiptQuoteTable(attachedDatabase, alias);
  }
}

class ReceiptQuoteData extends DataClass
    implements Insertable<ReceiptQuoteData> {
  final int id;
  final String nameCustomer;
  final String numPhone;
  final String mail;
  final String folioQuotes;
  final int userId;
  const ReceiptQuoteData(
      {required this.id,
      required this.nameCustomer,
      required this.numPhone,
      required this.mail,
      required this.folioQuotes,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_customer'] = Variable<String>(nameCustomer);
    map['num_phone'] = Variable<String>(numPhone);
    map['mail'] = Variable<String>(mail);
    map['folio_quotes'] = Variable<String>(folioQuotes);
    map['user_id'] = Variable<int>(userId);
    return map;
  }

  ReceiptQuoteCompanion toCompanion(bool nullToAbsent) {
    return ReceiptQuoteCompanion(
      id: Value(id),
      nameCustomer: Value(nameCustomer),
      numPhone: Value(numPhone),
      mail: Value(mail),
      folioQuotes: Value(folioQuotes),
      userId: Value(userId),
    );
  }

  factory ReceiptQuoteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReceiptQuoteData(
      id: serializer.fromJson<int>(json['id']),
      nameCustomer: serializer.fromJson<String>(json['nameCustomer']),
      numPhone: serializer.fromJson<String>(json['numPhone']),
      mail: serializer.fromJson<String>(json['mail']),
      folioQuotes: serializer.fromJson<String>(json['folioQuotes']),
      userId: serializer.fromJson<int>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameCustomer': serializer.toJson<String>(nameCustomer),
      'numPhone': serializer.toJson<String>(numPhone),
      'mail': serializer.toJson<String>(mail),
      'folioQuotes': serializer.toJson<String>(folioQuotes),
      'userId': serializer.toJson<int>(userId),
    };
  }

  ReceiptQuoteData copyWith(
          {int? id,
          String? nameCustomer,
          String? numPhone,
          String? mail,
          String? folioQuotes,
          int? userId}) =>
      ReceiptQuoteData(
        id: id ?? this.id,
        nameCustomer: nameCustomer ?? this.nameCustomer,
        numPhone: numPhone ?? this.numPhone,
        mail: mail ?? this.mail,
        folioQuotes: folioQuotes ?? this.folioQuotes,
        userId: userId ?? this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('ReceiptQuoteData(')
          ..write('id: $id, ')
          ..write('nameCustomer: $nameCustomer, ')
          ..write('numPhone: $numPhone, ')
          ..write('mail: $mail, ')
          ..write('folioQuotes: $folioQuotes, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nameCustomer, numPhone, mail, folioQuotes, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReceiptQuoteData &&
          other.id == this.id &&
          other.nameCustomer == this.nameCustomer &&
          other.numPhone == this.numPhone &&
          other.mail == this.mail &&
          other.folioQuotes == this.folioQuotes &&
          other.userId == this.userId);
}

class ReceiptQuoteCompanion extends UpdateCompanion<ReceiptQuoteData> {
  final Value<int> id;
  final Value<String> nameCustomer;
  final Value<String> numPhone;
  final Value<String> mail;
  final Value<String> folioQuotes;
  final Value<int> userId;
  const ReceiptQuoteCompanion({
    this.id = const Value.absent(),
    this.nameCustomer = const Value.absent(),
    this.numPhone = const Value.absent(),
    this.mail = const Value.absent(),
    this.folioQuotes = const Value.absent(),
    this.userId = const Value.absent(),
  });
  ReceiptQuoteCompanion.insert({
    this.id = const Value.absent(),
    required String nameCustomer,
    required String numPhone,
    required String mail,
    required String folioQuotes,
    required int userId,
  })  : nameCustomer = Value(nameCustomer),
        numPhone = Value(numPhone),
        mail = Value(mail),
        folioQuotes = Value(folioQuotes),
        userId = Value(userId);
  static Insertable<ReceiptQuoteData> custom({
    Expression<int>? id,
    Expression<String>? nameCustomer,
    Expression<String>? numPhone,
    Expression<String>? mail,
    Expression<String>? folioQuotes,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameCustomer != null) 'name_customer': nameCustomer,
      if (numPhone != null) 'num_phone': numPhone,
      if (mail != null) 'mail': mail,
      if (folioQuotes != null) 'folio_quotes': folioQuotes,
      if (userId != null) 'user_id': userId,
    });
  }

  ReceiptQuoteCompanion copyWith(
      {Value<int>? id,
      Value<String>? nameCustomer,
      Value<String>? numPhone,
      Value<String>? mail,
      Value<String>? folioQuotes,
      Value<int>? userId}) {
    return ReceiptQuoteCompanion(
      id: id ?? this.id,
      nameCustomer: nameCustomer ?? this.nameCustomer,
      numPhone: numPhone ?? this.numPhone,
      mail: mail ?? this.mail,
      folioQuotes: folioQuotes ?? this.folioQuotes,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameCustomer.present) {
      map['name_customer'] = Variable<String>(nameCustomer.value);
    }
    if (numPhone.present) {
      map['num_phone'] = Variable<String>(numPhone.value);
    }
    if (mail.present) {
      map['mail'] = Variable<String>(mail.value);
    }
    if (folioQuotes.present) {
      map['folio_quotes'] = Variable<String>(folioQuotes.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptQuoteCompanion(')
          ..write('id: $id, ')
          ..write('nameCustomer: $nameCustomer, ')
          ..write('numPhone: $numPhone, ')
          ..write('mail: $mail, ')
          ..write('folioQuotes: $folioQuotes, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $QuoteTable extends Quote with TableInfo<$QuoteTable, QuoteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuoteTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _isGroupMeta =
      const VerificationMeta('isGroup');
  @override
  late final GeneratedColumn<bool> isGroup = GeneratedColumn<bool>(
      'is_group', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_group" IN (0, 1))'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _planMeta = const VerificationMeta('plan');
  @override
  late final GeneratedColumn<String> plan = GeneratedColumn<String>(
      'plan', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _enterDateMeta =
      const VerificationMeta('enterDate');
  @override
  late final GeneratedColumn<String> enterDate = GeneratedColumn<String>(
      'enter_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _outDateMeta =
      const VerificationMeta('outDate');
  @override
  late final GeneratedColumn<String> outDate = GeneratedColumn<String>(
      'out_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _adultsMeta = const VerificationMeta('adults');
  @override
  late final GeneratedColumn<int> adults = GeneratedColumn<int>(
      'adults', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _minor0a6Meta =
      const VerificationMeta('minor0a6');
  @override
  late final GeneratedColumn<int> minor0a6 = GeneratedColumn<int>(
      'minor0a6', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _minor7a12Meta =
      const VerificationMeta('minor7a12');
  @override
  late final GeneratedColumn<int> minor7a12 = GeneratedColumn<int>(
      'minor7a12', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _rateRealAdultMeta =
      const VerificationMeta('rateRealAdult');
  @override
  late final GeneratedColumn<double> rateRealAdult = GeneratedColumn<double>(
      'rate_real_adult', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _ratePresaleAdultMeta =
      const VerificationMeta('ratePresaleAdult');
  @override
  late final GeneratedColumn<double> ratePresaleAdult = GeneratedColumn<double>(
      'rate_presale_adult', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _rateRealMinorMeta =
      const VerificationMeta('rateRealMinor');
  @override
  late final GeneratedColumn<double> rateRealMinor = GeneratedColumn<double>(
      'rate_real_minor', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _ratePresaleMinorMeta =
      const VerificationMeta('ratePresaleMinor');
  @override
  late final GeneratedColumn<double> ratePresaleMinor = GeneratedColumn<double>(
      'rate_presale_minor', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        isGroup,
        category,
        plan,
        enterDate,
        outDate,
        adults,
        minor0a6,
        minor7a12,
        rateRealAdult,
        ratePresaleAdult,
        rateRealMinor,
        ratePresaleMinor
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quote';
  @override
  VerificationContext validateIntegrity(Insertable<QuoteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_group')) {
      context.handle(_isGroupMeta,
          isGroup.isAcceptableOrUnknown(data['is_group']!, _isGroupMeta));
    } else if (isInserting) {
      context.missing(_isGroupMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('plan')) {
      context.handle(
          _planMeta, plan.isAcceptableOrUnknown(data['plan']!, _planMeta));
    } else if (isInserting) {
      context.missing(_planMeta);
    }
    if (data.containsKey('enter_date')) {
      context.handle(_enterDateMeta,
          enterDate.isAcceptableOrUnknown(data['enter_date']!, _enterDateMeta));
    } else if (isInserting) {
      context.missing(_enterDateMeta);
    }
    if (data.containsKey('out_date')) {
      context.handle(_outDateMeta,
          outDate.isAcceptableOrUnknown(data['out_date']!, _outDateMeta));
    } else if (isInserting) {
      context.missing(_outDateMeta);
    }
    if (data.containsKey('adults')) {
      context.handle(_adultsMeta,
          adults.isAcceptableOrUnknown(data['adults']!, _adultsMeta));
    } else if (isInserting) {
      context.missing(_adultsMeta);
    }
    if (data.containsKey('minor0a6')) {
      context.handle(_minor0a6Meta,
          minor0a6.isAcceptableOrUnknown(data['minor0a6']!, _minor0a6Meta));
    } else if (isInserting) {
      context.missing(_minor0a6Meta);
    }
    if (data.containsKey('minor7a12')) {
      context.handle(_minor7a12Meta,
          minor7a12.isAcceptableOrUnknown(data['minor7a12']!, _minor7a12Meta));
    } else if (isInserting) {
      context.missing(_minor7a12Meta);
    }
    if (data.containsKey('rate_real_adult')) {
      context.handle(
          _rateRealAdultMeta,
          rateRealAdult.isAcceptableOrUnknown(
              data['rate_real_adult']!, _rateRealAdultMeta));
    } else if (isInserting) {
      context.missing(_rateRealAdultMeta);
    }
    if (data.containsKey('rate_presale_adult')) {
      context.handle(
          _ratePresaleAdultMeta,
          ratePresaleAdult.isAcceptableOrUnknown(
              data['rate_presale_adult']!, _ratePresaleAdultMeta));
    } else if (isInserting) {
      context.missing(_ratePresaleAdultMeta);
    }
    if (data.containsKey('rate_real_minor')) {
      context.handle(
          _rateRealMinorMeta,
          rateRealMinor.isAcceptableOrUnknown(
              data['rate_real_minor']!, _rateRealMinorMeta));
    } else if (isInserting) {
      context.missing(_rateRealMinorMeta);
    }
    if (data.containsKey('rate_presale_minor')) {
      context.handle(
          _ratePresaleMinorMeta,
          ratePresaleMinor.isAcceptableOrUnknown(
              data['rate_presale_minor']!, _ratePresaleMinorMeta));
    } else if (isInserting) {
      context.missing(_ratePresaleMinorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuoteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuoteData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      isGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_group'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      plan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan'])!,
      enterDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}enter_date'])!,
      outDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}out_date'])!,
      adults: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}adults'])!,
      minor0a6: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}minor0a6'])!,
      minor7a12: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}minor7a12'])!,
      rateRealAdult: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}rate_real_adult'])!,
      ratePresaleAdult: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}rate_presale_adult'])!,
      rateRealMinor: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}rate_real_minor'])!,
      ratePresaleMinor: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}rate_presale_minor'])!,
    );
  }

  @override
  $QuoteTable createAlias(String alias) {
    return $QuoteTable(attachedDatabase, alias);
  }
}

class QuoteData extends DataClass implements Insertable<QuoteData> {
  final int id;
  final bool isGroup;
  final String category;
  final String plan;
  final String enterDate;
  final String outDate;
  final int adults;
  final int minor0a6;
  final int minor7a12;
  final double rateRealAdult;
  final double ratePresaleAdult;
  final double rateRealMinor;
  final double ratePresaleMinor;
  const QuoteData(
      {required this.id,
      required this.isGroup,
      required this.category,
      required this.plan,
      required this.enterDate,
      required this.outDate,
      required this.adults,
      required this.minor0a6,
      required this.minor7a12,
      required this.rateRealAdult,
      required this.ratePresaleAdult,
      required this.rateRealMinor,
      required this.ratePresaleMinor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_group'] = Variable<bool>(isGroup);
    map['category'] = Variable<String>(category);
    map['plan'] = Variable<String>(plan);
    map['enter_date'] = Variable<String>(enterDate);
    map['out_date'] = Variable<String>(outDate);
    map['adults'] = Variable<int>(adults);
    map['minor0a6'] = Variable<int>(minor0a6);
    map['minor7a12'] = Variable<int>(minor7a12);
    map['rate_real_adult'] = Variable<double>(rateRealAdult);
    map['rate_presale_adult'] = Variable<double>(ratePresaleAdult);
    map['rate_real_minor'] = Variable<double>(rateRealMinor);
    map['rate_presale_minor'] = Variable<double>(ratePresaleMinor);
    return map;
  }

  QuoteCompanion toCompanion(bool nullToAbsent) {
    return QuoteCompanion(
      id: Value(id),
      isGroup: Value(isGroup),
      category: Value(category),
      plan: Value(plan),
      enterDate: Value(enterDate),
      outDate: Value(outDate),
      adults: Value(adults),
      minor0a6: Value(minor0a6),
      minor7a12: Value(minor7a12),
      rateRealAdult: Value(rateRealAdult),
      ratePresaleAdult: Value(ratePresaleAdult),
      rateRealMinor: Value(rateRealMinor),
      ratePresaleMinor: Value(ratePresaleMinor),
    );
  }

  factory QuoteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuoteData(
      id: serializer.fromJson<int>(json['id']),
      isGroup: serializer.fromJson<bool>(json['isGroup']),
      category: serializer.fromJson<String>(json['category']),
      plan: serializer.fromJson<String>(json['plan']),
      enterDate: serializer.fromJson<String>(json['enterDate']),
      outDate: serializer.fromJson<String>(json['outDate']),
      adults: serializer.fromJson<int>(json['adults']),
      minor0a6: serializer.fromJson<int>(json['minor0a6']),
      minor7a12: serializer.fromJson<int>(json['minor7a12']),
      rateRealAdult: serializer.fromJson<double>(json['rateRealAdult']),
      ratePresaleAdult: serializer.fromJson<double>(json['ratePresaleAdult']),
      rateRealMinor: serializer.fromJson<double>(json['rateRealMinor']),
      ratePresaleMinor: serializer.fromJson<double>(json['ratePresaleMinor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isGroup': serializer.toJson<bool>(isGroup),
      'category': serializer.toJson<String>(category),
      'plan': serializer.toJson<String>(plan),
      'enterDate': serializer.toJson<String>(enterDate),
      'outDate': serializer.toJson<String>(outDate),
      'adults': serializer.toJson<int>(adults),
      'minor0a6': serializer.toJson<int>(minor0a6),
      'minor7a12': serializer.toJson<int>(minor7a12),
      'rateRealAdult': serializer.toJson<double>(rateRealAdult),
      'ratePresaleAdult': serializer.toJson<double>(ratePresaleAdult),
      'rateRealMinor': serializer.toJson<double>(rateRealMinor),
      'ratePresaleMinor': serializer.toJson<double>(ratePresaleMinor),
    };
  }

  QuoteData copyWith(
          {int? id,
          bool? isGroup,
          String? category,
          String? plan,
          String? enterDate,
          String? outDate,
          int? adults,
          int? minor0a6,
          int? minor7a12,
          double? rateRealAdult,
          double? ratePresaleAdult,
          double? rateRealMinor,
          double? ratePresaleMinor}) =>
      QuoteData(
        id: id ?? this.id,
        isGroup: isGroup ?? this.isGroup,
        category: category ?? this.category,
        plan: plan ?? this.plan,
        enterDate: enterDate ?? this.enterDate,
        outDate: outDate ?? this.outDate,
        adults: adults ?? this.adults,
        minor0a6: minor0a6 ?? this.minor0a6,
        minor7a12: minor7a12 ?? this.minor7a12,
        rateRealAdult: rateRealAdult ?? this.rateRealAdult,
        ratePresaleAdult: ratePresaleAdult ?? this.ratePresaleAdult,
        rateRealMinor: rateRealMinor ?? this.rateRealMinor,
        ratePresaleMinor: ratePresaleMinor ?? this.ratePresaleMinor,
      );
  @override
  String toString() {
    return (StringBuffer('QuoteData(')
          ..write('id: $id, ')
          ..write('isGroup: $isGroup, ')
          ..write('category: $category, ')
          ..write('plan: $plan, ')
          ..write('enterDate: $enterDate, ')
          ..write('outDate: $outDate, ')
          ..write('adults: $adults, ')
          ..write('minor0a6: $minor0a6, ')
          ..write('minor7a12: $minor7a12, ')
          ..write('rateRealAdult: $rateRealAdult, ')
          ..write('ratePresaleAdult: $ratePresaleAdult, ')
          ..write('rateRealMinor: $rateRealMinor, ')
          ..write('ratePresaleMinor: $ratePresaleMinor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      isGroup,
      category,
      plan,
      enterDate,
      outDate,
      adults,
      minor0a6,
      minor7a12,
      rateRealAdult,
      ratePresaleAdult,
      rateRealMinor,
      ratePresaleMinor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuoteData &&
          other.id == this.id &&
          other.isGroup == this.isGroup &&
          other.category == this.category &&
          other.plan == this.plan &&
          other.enterDate == this.enterDate &&
          other.outDate == this.outDate &&
          other.adults == this.adults &&
          other.minor0a6 == this.minor0a6 &&
          other.minor7a12 == this.minor7a12 &&
          other.rateRealAdult == this.rateRealAdult &&
          other.ratePresaleAdult == this.ratePresaleAdult &&
          other.rateRealMinor == this.rateRealMinor &&
          other.ratePresaleMinor == this.ratePresaleMinor);
}

class QuoteCompanion extends UpdateCompanion<QuoteData> {
  final Value<int> id;
  final Value<bool> isGroup;
  final Value<String> category;
  final Value<String> plan;
  final Value<String> enterDate;
  final Value<String> outDate;
  final Value<int> adults;
  final Value<int> minor0a6;
  final Value<int> minor7a12;
  final Value<double> rateRealAdult;
  final Value<double> ratePresaleAdult;
  final Value<double> rateRealMinor;
  final Value<double> ratePresaleMinor;
  const QuoteCompanion({
    this.id = const Value.absent(),
    this.isGroup = const Value.absent(),
    this.category = const Value.absent(),
    this.plan = const Value.absent(),
    this.enterDate = const Value.absent(),
    this.outDate = const Value.absent(),
    this.adults = const Value.absent(),
    this.minor0a6 = const Value.absent(),
    this.minor7a12 = const Value.absent(),
    this.rateRealAdult = const Value.absent(),
    this.ratePresaleAdult = const Value.absent(),
    this.rateRealMinor = const Value.absent(),
    this.ratePresaleMinor = const Value.absent(),
  });
  QuoteCompanion.insert({
    this.id = const Value.absent(),
    required bool isGroup,
    required String category,
    required String plan,
    required String enterDate,
    required String outDate,
    required int adults,
    required int minor0a6,
    required int minor7a12,
    required double rateRealAdult,
    required double ratePresaleAdult,
    required double rateRealMinor,
    required double ratePresaleMinor,
  })  : isGroup = Value(isGroup),
        category = Value(category),
        plan = Value(plan),
        enterDate = Value(enterDate),
        outDate = Value(outDate),
        adults = Value(adults),
        minor0a6 = Value(minor0a6),
        minor7a12 = Value(minor7a12),
        rateRealAdult = Value(rateRealAdult),
        ratePresaleAdult = Value(ratePresaleAdult),
        rateRealMinor = Value(rateRealMinor),
        ratePresaleMinor = Value(ratePresaleMinor);
  static Insertable<QuoteData> custom({
    Expression<int>? id,
    Expression<bool>? isGroup,
    Expression<String>? category,
    Expression<String>? plan,
    Expression<String>? enterDate,
    Expression<String>? outDate,
    Expression<int>? adults,
    Expression<int>? minor0a6,
    Expression<int>? minor7a12,
    Expression<double>? rateRealAdult,
    Expression<double>? ratePresaleAdult,
    Expression<double>? rateRealMinor,
    Expression<double>? ratePresaleMinor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isGroup != null) 'is_group': isGroup,
      if (category != null) 'category': category,
      if (plan != null) 'plan': plan,
      if (enterDate != null) 'enter_date': enterDate,
      if (outDate != null) 'out_date': outDate,
      if (adults != null) 'adults': adults,
      if (minor0a6 != null) 'minor0a6': minor0a6,
      if (minor7a12 != null) 'minor7a12': minor7a12,
      if (rateRealAdult != null) 'rate_real_adult': rateRealAdult,
      if (ratePresaleAdult != null) 'rate_presale_adult': ratePresaleAdult,
      if (rateRealMinor != null) 'rate_real_minor': rateRealMinor,
      if (ratePresaleMinor != null) 'rate_presale_minor': ratePresaleMinor,
    });
  }

  QuoteCompanion copyWith(
      {Value<int>? id,
      Value<bool>? isGroup,
      Value<String>? category,
      Value<String>? plan,
      Value<String>? enterDate,
      Value<String>? outDate,
      Value<int>? adults,
      Value<int>? minor0a6,
      Value<int>? minor7a12,
      Value<double>? rateRealAdult,
      Value<double>? ratePresaleAdult,
      Value<double>? rateRealMinor,
      Value<double>? ratePresaleMinor}) {
    return QuoteCompanion(
      id: id ?? this.id,
      isGroup: isGroup ?? this.isGroup,
      category: category ?? this.category,
      plan: plan ?? this.plan,
      enterDate: enterDate ?? this.enterDate,
      outDate: outDate ?? this.outDate,
      adults: adults ?? this.adults,
      minor0a6: minor0a6 ?? this.minor0a6,
      minor7a12: minor7a12 ?? this.minor7a12,
      rateRealAdult: rateRealAdult ?? this.rateRealAdult,
      ratePresaleAdult: ratePresaleAdult ?? this.ratePresaleAdult,
      rateRealMinor: rateRealMinor ?? this.rateRealMinor,
      ratePresaleMinor: ratePresaleMinor ?? this.ratePresaleMinor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isGroup.present) {
      map['is_group'] = Variable<bool>(isGroup.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (plan.present) {
      map['plan'] = Variable<String>(plan.value);
    }
    if (enterDate.present) {
      map['enter_date'] = Variable<String>(enterDate.value);
    }
    if (outDate.present) {
      map['out_date'] = Variable<String>(outDate.value);
    }
    if (adults.present) {
      map['adults'] = Variable<int>(adults.value);
    }
    if (minor0a6.present) {
      map['minor0a6'] = Variable<int>(minor0a6.value);
    }
    if (minor7a12.present) {
      map['minor7a12'] = Variable<int>(minor7a12.value);
    }
    if (rateRealAdult.present) {
      map['rate_real_adult'] = Variable<double>(rateRealAdult.value);
    }
    if (ratePresaleAdult.present) {
      map['rate_presale_adult'] = Variable<double>(ratePresaleAdult.value);
    }
    if (rateRealMinor.present) {
      map['rate_real_minor'] = Variable<double>(rateRealMinor.value);
    }
    if (ratePresaleMinor.present) {
      map['rate_presale_minor'] = Variable<double>(ratePresaleMinor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuoteCompanion(')
          ..write('id: $id, ')
          ..write('isGroup: $isGroup, ')
          ..write('category: $category, ')
          ..write('plan: $plan, ')
          ..write('enterDate: $enterDate, ')
          ..write('outDate: $outDate, ')
          ..write('adults: $adults, ')
          ..write('minor0a6: $minor0a6, ')
          ..write('minor7a12: $minor7a12, ')
          ..write('rateRealAdult: $rateRealAdult, ')
          ..write('ratePresaleAdult: $ratePresaleAdult, ')
          ..write('rateRealMinor: $rateRealMinor, ')
          ..write('ratePresaleMinor: $ratePresaleMinor')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $RolUserTable rolUser = $RolUserTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ReceiptQuoteTable receiptQuote = $ReceiptQuoteTable(this);
  late final $QuoteTable quote = $QuoteTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [rolUser, users, receiptQuote, quote];
}

typedef $$RolUserTableInsertCompanionBuilder = RolUserCompanion Function({
  Value<int> id,
  required String description,
});
typedef $$RolUserTableUpdateCompanionBuilder = RolUserCompanion Function({
  Value<int> id,
  Value<String> description,
});

class $$RolUserTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RolUserTable,
    RolUserData,
    $$RolUserTableFilterComposer,
    $$RolUserTableOrderingComposer,
    $$RolUserTableProcessedTableManager,
    $$RolUserTableInsertCompanionBuilder,
    $$RolUserTableUpdateCompanionBuilder> {
  $$RolUserTableTableManager(_$AppDatabase db, $RolUserTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RolUserTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RolUserTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$RolUserTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> description = const Value.absent(),
          }) =>
              RolUserCompanion(
            id: id,
            description: description,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String description,
          }) =>
              RolUserCompanion.insert(
            id: id,
            description: description,
          ),
        ));
}

class $$RolUserTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $RolUserTable,
    RolUserData,
    $$RolUserTableFilterComposer,
    $$RolUserTableOrderingComposer,
    $$RolUserTableProcessedTableManager,
    $$RolUserTableInsertCompanionBuilder,
    $$RolUserTableUpdateCompanionBuilder> {
  $$RolUserTableProcessedTableManager(super.$state);
}

class $$RolUserTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RolUserTable> {
  $$RolUserTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter usersRefs(
      ComposableFilter Function($$UsersTableFilterComposer f) f) {
    final $$UsersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.users,
        getReferencedColumn: (t) => t.rol,
        builder: (joinBuilder, parentComposers) => $$UsersTableFilterComposer(
            ComposerState(
                $state.db, $state.db.users, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$RolUserTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RolUserTable> {
  $$RolUserTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$UsersTableInsertCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String name,
  required String password,
  Value<int?> rol,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> password,
  Value<int?> rol,
});

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableProcessedTableManager,
    $$UsersTableInsertCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsersTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$UsersTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<int?> rol = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            name: name,
            password: password,
            rol: rol,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String password,
            Value<int?> rol = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            name: name,
            password: password,
            rol: rol,
          ),
        ));
}

class $$UsersTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableProcessedTableManager,
    $$UsersTableInsertCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder> {
  $$UsersTableProcessedTableManager(super.$state);
}

class $$UsersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$RolUserTableFilterComposer get rol {
    final $$RolUserTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.rol,
        referencedTable: $state.db.rolUser,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$RolUserTableFilterComposer(
            ComposerState(
                $state.db, $state.db.rolUser, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$UsersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$RolUserTableOrderingComposer get rol {
    final $$RolUserTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.rol,
        referencedTable: $state.db.rolUser,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RolUserTableOrderingComposer(ComposerState(
                $state.db, $state.db.rolUser, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ReceiptQuoteTableInsertCompanionBuilder = ReceiptQuoteCompanion
    Function({
  Value<int> id,
  required String nameCustomer,
  required String numPhone,
  required String mail,
  required String folioQuotes,
  required int userId,
});
typedef $$ReceiptQuoteTableUpdateCompanionBuilder = ReceiptQuoteCompanion
    Function({
  Value<int> id,
  Value<String> nameCustomer,
  Value<String> numPhone,
  Value<String> mail,
  Value<String> folioQuotes,
  Value<int> userId,
});

class $$ReceiptQuoteTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReceiptQuoteTable,
    ReceiptQuoteData,
    $$ReceiptQuoteTableFilterComposer,
    $$ReceiptQuoteTableOrderingComposer,
    $$ReceiptQuoteTableProcessedTableManager,
    $$ReceiptQuoteTableInsertCompanionBuilder,
    $$ReceiptQuoteTableUpdateCompanionBuilder> {
  $$ReceiptQuoteTableTableManager(_$AppDatabase db, $ReceiptQuoteTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ReceiptQuoteTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ReceiptQuoteTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$ReceiptQuoteTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> nameCustomer = const Value.absent(),
            Value<String> numPhone = const Value.absent(),
            Value<String> mail = const Value.absent(),
            Value<String> folioQuotes = const Value.absent(),
            Value<int> userId = const Value.absent(),
          }) =>
              ReceiptQuoteCompanion(
            id: id,
            nameCustomer: nameCustomer,
            numPhone: numPhone,
            mail: mail,
            folioQuotes: folioQuotes,
            userId: userId,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String nameCustomer,
            required String numPhone,
            required String mail,
            required String folioQuotes,
            required int userId,
          }) =>
              ReceiptQuoteCompanion.insert(
            id: id,
            nameCustomer: nameCustomer,
            numPhone: numPhone,
            mail: mail,
            folioQuotes: folioQuotes,
            userId: userId,
          ),
        ));
}

class $$ReceiptQuoteTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $ReceiptQuoteTable,
    ReceiptQuoteData,
    $$ReceiptQuoteTableFilterComposer,
    $$ReceiptQuoteTableOrderingComposer,
    $$ReceiptQuoteTableProcessedTableManager,
    $$ReceiptQuoteTableInsertCompanionBuilder,
    $$ReceiptQuoteTableUpdateCompanionBuilder> {
  $$ReceiptQuoteTableProcessedTableManager(super.$state);
}

class $$ReceiptQuoteTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ReceiptQuoteTable> {
  $$ReceiptQuoteTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nameCustomer => $state.composableBuilder(
      column: $state.table.nameCustomer,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get numPhone => $state.composableBuilder(
      column: $state.table.numPhone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mail => $state.composableBuilder(
      column: $state.table.mail,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get folioQuotes => $state.composableBuilder(
      column: $state.table.folioQuotes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ReceiptQuoteTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ReceiptQuoteTable> {
  $$ReceiptQuoteTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nameCustomer => $state.composableBuilder(
      column: $state.table.nameCustomer,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get numPhone => $state.composableBuilder(
      column: $state.table.numPhone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mail => $state.composableBuilder(
      column: $state.table.mail,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get folioQuotes => $state.composableBuilder(
      column: $state.table.folioQuotes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$QuoteTableInsertCompanionBuilder = QuoteCompanion Function({
  Value<int> id,
  required bool isGroup,
  required String category,
  required String plan,
  required String enterDate,
  required String outDate,
  required int adults,
  required int minor0a6,
  required int minor7a12,
  required double rateRealAdult,
  required double ratePresaleAdult,
  required double rateRealMinor,
  required double ratePresaleMinor,
});
typedef $$QuoteTableUpdateCompanionBuilder = QuoteCompanion Function({
  Value<int> id,
  Value<bool> isGroup,
  Value<String> category,
  Value<String> plan,
  Value<String> enterDate,
  Value<String> outDate,
  Value<int> adults,
  Value<int> minor0a6,
  Value<int> minor7a12,
  Value<double> rateRealAdult,
  Value<double> ratePresaleAdult,
  Value<double> rateRealMinor,
  Value<double> ratePresaleMinor,
});

class $$QuoteTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuoteTable,
    QuoteData,
    $$QuoteTableFilterComposer,
    $$QuoteTableOrderingComposer,
    $$QuoteTableProcessedTableManager,
    $$QuoteTableInsertCompanionBuilder,
    $$QuoteTableUpdateCompanionBuilder> {
  $$QuoteTableTableManager(_$AppDatabase db, $QuoteTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$QuoteTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$QuoteTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$QuoteTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<bool> isGroup = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> plan = const Value.absent(),
            Value<String> enterDate = const Value.absent(),
            Value<String> outDate = const Value.absent(),
            Value<int> adults = const Value.absent(),
            Value<int> minor0a6 = const Value.absent(),
            Value<int> minor7a12 = const Value.absent(),
            Value<double> rateRealAdult = const Value.absent(),
            Value<double> ratePresaleAdult = const Value.absent(),
            Value<double> rateRealMinor = const Value.absent(),
            Value<double> ratePresaleMinor = const Value.absent(),
          }) =>
              QuoteCompanion(
            id: id,
            isGroup: isGroup,
            category: category,
            plan: plan,
            enterDate: enterDate,
            outDate: outDate,
            adults: adults,
            minor0a6: minor0a6,
            minor7a12: minor7a12,
            rateRealAdult: rateRealAdult,
            ratePresaleAdult: ratePresaleAdult,
            rateRealMinor: rateRealMinor,
            ratePresaleMinor: ratePresaleMinor,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required bool isGroup,
            required String category,
            required String plan,
            required String enterDate,
            required String outDate,
            required int adults,
            required int minor0a6,
            required int minor7a12,
            required double rateRealAdult,
            required double ratePresaleAdult,
            required double rateRealMinor,
            required double ratePresaleMinor,
          }) =>
              QuoteCompanion.insert(
            id: id,
            isGroup: isGroup,
            category: category,
            plan: plan,
            enterDate: enterDate,
            outDate: outDate,
            adults: adults,
            minor0a6: minor0a6,
            minor7a12: minor7a12,
            rateRealAdult: rateRealAdult,
            ratePresaleAdult: ratePresaleAdult,
            rateRealMinor: rateRealMinor,
            ratePresaleMinor: ratePresaleMinor,
          ),
        ));
}

class $$QuoteTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $QuoteTable,
    QuoteData,
    $$QuoteTableFilterComposer,
    $$QuoteTableOrderingComposer,
    $$QuoteTableProcessedTableManager,
    $$QuoteTableInsertCompanionBuilder,
    $$QuoteTableUpdateCompanionBuilder> {
  $$QuoteTableProcessedTableManager(super.$state);
}

class $$QuoteTableFilterComposer
    extends FilterComposer<_$AppDatabase, $QuoteTable> {
  $$QuoteTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isGroup => $state.composableBuilder(
      column: $state.table.isGroup,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get plan => $state.composableBuilder(
      column: $state.table.plan,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get enterDate => $state.composableBuilder(
      column: $state.table.enterDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get outDate => $state.composableBuilder(
      column: $state.table.outDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get adults => $state.composableBuilder(
      column: $state.table.adults,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get minor0a6 => $state.composableBuilder(
      column: $state.table.minor0a6,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get minor7a12 => $state.composableBuilder(
      column: $state.table.minor7a12,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get rateRealAdult => $state.composableBuilder(
      column: $state.table.rateRealAdult,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get ratePresaleAdult => $state.composableBuilder(
      column: $state.table.ratePresaleAdult,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get rateRealMinor => $state.composableBuilder(
      column: $state.table.rateRealMinor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get ratePresaleMinor => $state.composableBuilder(
      column: $state.table.ratePresaleMinor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$QuoteTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $QuoteTable> {
  $$QuoteTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isGroup => $state.composableBuilder(
      column: $state.table.isGroup,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get plan => $state.composableBuilder(
      column: $state.table.plan,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get enterDate => $state.composableBuilder(
      column: $state.table.enterDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get outDate => $state.composableBuilder(
      column: $state.table.outDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get adults => $state.composableBuilder(
      column: $state.table.adults,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get minor0a6 => $state.composableBuilder(
      column: $state.table.minor0a6,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get minor7a12 => $state.composableBuilder(
      column: $state.table.minor7a12,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get rateRealAdult => $state.composableBuilder(
      column: $state.table.rateRealAdult,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get ratePresaleAdult => $state.composableBuilder(
      column: $state.table.ratePresaleAdult,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get rateRealMinor => $state.composableBuilder(
      column: $state.table.rateRealMinor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get ratePresaleMinor => $state.composableBuilder(
      column: $state.table.ratePresaleMinor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$RolUserTableTableManager get rolUser =>
      $$RolUserTableTableManager(_db, _db.rolUser);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ReceiptQuoteTableTableManager get receiptQuote =>
      $$ReceiptQuoteTableTableManager(_db, _db.receiptQuote);
  $$QuoteTableTableManager get quote =>
      $$QuoteTableTableManager(_db, _db.quote);
}
