// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TipoHabitacionTableTable extends TipoHabitacionTable
    with TableInfo<$TipoHabitacionTableTable, TipoHabitacionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TipoHabitacionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
      'orden', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [idInt, id, codigo, orden, descripcion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tipo_habitacion_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TipoHabitacionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('orden')) {
      context.handle(
          _ordenMeta, orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta));
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  TipoHabitacionTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TipoHabitacionTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo']),
      orden: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orden']),
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion']),
    );
  }

  @override
  $TipoHabitacionTableTable createAlias(String alias) {
    return $TipoHabitacionTableTable(attachedDatabase, alias);
  }
}

class TipoHabitacionTableData extends DataClass
    implements Insertable<TipoHabitacionTableData> {
  final int idInt;
  final String? id;
  final String? codigo;
  final int? orden;
  final String? descripcion;
  const TipoHabitacionTableData(
      {required this.idInt,
      this.id,
      this.codigo,
      this.orden,
      this.descripcion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<String>(codigo);
    }
    if (!nullToAbsent || orden != null) {
      map['orden'] = Variable<int>(orden);
    }
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    return map;
  }

  TipoHabitacionTableCompanion toCompanion(bool nullToAbsent) {
    return TipoHabitacionTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      orden:
          orden == null && nullToAbsent ? const Value.absent() : Value(orden),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
    );
  }

  factory TipoHabitacionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TipoHabitacionTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      codigo: serializer.fromJson<String?>(json['codigo']),
      orden: serializer.fromJson<int?>(json['orden']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'codigo': serializer.toJson<String?>(codigo),
      'orden': serializer.toJson<int?>(orden),
      'descripcion': serializer.toJson<String?>(descripcion),
    };
  }

  TipoHabitacionTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<String?> codigo = const Value.absent(),
          Value<int?> orden = const Value.absent(),
          Value<String?> descripcion = const Value.absent()}) =>
      TipoHabitacionTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        codigo: codigo.present ? codigo.value : this.codigo,
        orden: orden.present ? orden.value : this.orden,
        descripcion: descripcion.present ? descripcion.value : this.descripcion,
      );
  TipoHabitacionTableData copyWithCompanion(TipoHabitacionTableCompanion data) {
    return TipoHabitacionTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      orden: data.orden.present ? data.orden.value : this.orden,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TipoHabitacionTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('orden: $orden, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idInt, id, codigo, orden, descripcion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TipoHabitacionTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.orden == this.orden &&
          other.descripcion == this.descripcion);
}

class TipoHabitacionTableCompanion
    extends UpdateCompanion<TipoHabitacionTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<String?> codigo;
  final Value<int?> orden;
  final Value<String?> descripcion;
  const TipoHabitacionTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.orden = const Value.absent(),
    this.descripcion = const Value.absent(),
  });
  TipoHabitacionTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.orden = const Value.absent(),
    this.descripcion = const Value.absent(),
  });
  static Insertable<TipoHabitacionTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<String>? codigo,
    Expression<int>? orden,
    Expression<String>? descripcion,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (codigo != null) 'codigo': codigo,
      if (orden != null) 'orden': orden,
      if (descripcion != null) 'descripcion': descripcion,
    });
  }

  TipoHabitacionTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<String?>? codigo,
      Value<int?>? orden,
      Value<String?>? descripcion}) {
    return TipoHabitacionTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      orden: orden ?? this.orden,
      descripcion: descripcion ?? this.descripcion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TipoHabitacionTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('orden: $orden, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }
}

class $ImagenTableTable extends ImagenTable
    with TableInfo<$ImagenTableTable, ImagenTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImagenTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rutaMeta = const VerificationMeta('ruta');
  @override
  late final GeneratedColumn<String> ruta = GeneratedColumn<String>(
      'ruta', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [idInt, id, nombre, ruta, url, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'imagen_table';
  @override
  VerificationContext validateIntegrity(Insertable<ImagenTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    }
    if (data.containsKey('ruta')) {
      context.handle(
          _rutaMeta, ruta.isAcceptableOrUnknown(data['ruta']!, _rutaMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  ImagenTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImagenTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre']),
      ruta: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ruta']),
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $ImagenTableTable createAlias(String alias) {
    return $ImagenTableTable(attachedDatabase, alias);
  }
}

class ImagenTableData extends DataClass implements Insertable<ImagenTableData> {
  final int idInt;
  final String? id;
  final String? nombre;
  final String? ruta;
  final String? url;
  final DateTime? createdAt;
  const ImagenTableData(
      {required this.idInt,
      this.id,
      this.nombre,
      this.ruta,
      this.url,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || nombre != null) {
      map['nombre'] = Variable<String>(nombre);
    }
    if (!nullToAbsent || ruta != null) {
      map['ruta'] = Variable<String>(ruta);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  ImagenTableCompanion toCompanion(bool nullToAbsent) {
    return ImagenTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      ruta: ruta == null && nullToAbsent ? const Value.absent() : Value(ruta),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory ImagenTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImagenTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      nombre: serializer.fromJson<String?>(json['nombre']),
      ruta: serializer.fromJson<String?>(json['ruta']),
      url: serializer.fromJson<String?>(json['url']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'nombre': serializer.toJson<String?>(nombre),
      'ruta': serializer.toJson<String?>(ruta),
      'url': serializer.toJson<String?>(url),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  ImagenTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<String?> nombre = const Value.absent(),
          Value<String?> ruta = const Value.absent(),
          Value<String?> url = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent()}) =>
      ImagenTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        nombre: nombre.present ? nombre.value : this.nombre,
        ruta: ruta.present ? ruta.value : this.ruta,
        url: url.present ? url.value : this.url,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  ImagenTableData copyWithCompanion(ImagenTableCompanion data) {
    return ImagenTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      ruta: data.ruta.present ? data.ruta.value : this.ruta,
      url: data.url.present ? data.url.value : this.url,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImagenTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('ruta: $ruta, ')
          ..write('url: $url, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idInt, id, nombre, ruta, url, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImagenTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.ruta == this.ruta &&
          other.url == this.url &&
          other.createdAt == this.createdAt);
}

class ImagenTableCompanion extends UpdateCompanion<ImagenTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<String?> nombre;
  final Value<String?> ruta;
  final Value<String?> url;
  final Value<DateTime?> createdAt;
  const ImagenTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.ruta = const Value.absent(),
    this.url = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ImagenTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.ruta = const Value.absent(),
    this.url = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<ImagenTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? ruta,
    Expression<String>? url,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (ruta != null) 'ruta': ruta,
      if (url != null) 'url': url,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ImagenTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<String?>? nombre,
      Value<String?>? ruta,
      Value<String?>? url,
      Value<DateTime?>? createdAt}) {
    return ImagenTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      ruta: ruta ?? this.ruta,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (ruta.present) {
      map['ruta'] = Variable<String>(ruta.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImagenTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('ruta: $ruta, ')
          ..write('url: $url, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RolTableTable extends RolTable
    with TableInfo<$RolTableTable, RolTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RolTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _permisosMeta =
      const VerificationMeta('permisos');
  @override
  late final GeneratedColumn<String> permisos = GeneratedColumn<String>(
      'permisos', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [idInt, id, nombre, color, descripcion, permisos];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rol_table';
  @override
  VerificationContext validateIntegrity(Insertable<RolTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    }
    if (data.containsKey('permisos')) {
      context.handle(_permisosMeta,
          permisos.isAcceptableOrUnknown(data['permisos']!, _permisosMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  RolTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RolTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion']),
      permisos: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}permisos']),
    );
  }

  @override
  $RolTableTable createAlias(String alias) {
    return $RolTableTable(attachedDatabase, alias);
  }
}

class RolTableData extends DataClass implements Insertable<RolTableData> {
  final int idInt;
  final String? id;
  final String? nombre;
  final String? color;
  final String? descripcion;
  final String? permisos;
  const RolTableData(
      {required this.idInt,
      this.id,
      this.nombre,
      this.color,
      this.descripcion,
      this.permisos});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || nombre != null) {
      map['nombre'] = Variable<String>(nombre);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || permisos != null) {
      map['permisos'] = Variable<String>(permisos);
    }
    return map;
  }

  RolTableCompanion toCompanion(bool nullToAbsent) {
    return RolTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      permisos: permisos == null && nullToAbsent
          ? const Value.absent()
          : Value(permisos),
    );
  }

  factory RolTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RolTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      nombre: serializer.fromJson<String?>(json['nombre']),
      color: serializer.fromJson<String?>(json['color']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      permisos: serializer.fromJson<String?>(json['permisos']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'nombre': serializer.toJson<String?>(nombre),
      'color': serializer.toJson<String?>(color),
      'descripcion': serializer.toJson<String?>(descripcion),
      'permisos': serializer.toJson<String?>(permisos),
    };
  }

  RolTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<String?> nombre = const Value.absent(),
          Value<String?> color = const Value.absent(),
          Value<String?> descripcion = const Value.absent(),
          Value<String?> permisos = const Value.absent()}) =>
      RolTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        nombre: nombre.present ? nombre.value : this.nombre,
        color: color.present ? color.value : this.color,
        descripcion: descripcion.present ? descripcion.value : this.descripcion,
        permisos: permisos.present ? permisos.value : this.permisos,
      );
  RolTableData copyWithCompanion(RolTableCompanion data) {
    return RolTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      color: data.color.present ? data.color.value : this.color,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      permisos: data.permisos.present ? data.permisos.value : this.permisos,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RolTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('color: $color, ')
          ..write('descripcion: $descripcion, ')
          ..write('permisos: $permisos')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(idInt, id, nombre, color, descripcion, permisos);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RolTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.color == this.color &&
          other.descripcion == this.descripcion &&
          other.permisos == this.permisos);
}

class RolTableCompanion extends UpdateCompanion<RolTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<String?> nombre;
  final Value<String?> color;
  final Value<String?> descripcion;
  final Value<String?> permisos;
  const RolTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.color = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.permisos = const Value.absent(),
  });
  RolTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.color = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.permisos = const Value.absent(),
  });
  static Insertable<RolTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? color,
    Expression<String>? descripcion,
    Expression<String>? permisos,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (color != null) 'color': color,
      if (descripcion != null) 'descripcion': descripcion,
      if (permisos != null) 'permisos': permisos,
    });
  }

  RolTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<String?>? nombre,
      Value<String?>? color,
      Value<String?>? descripcion,
      Value<String?>? permisos}) {
    return RolTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      color: color ?? this.color,
      descripcion: descripcion ?? this.descripcion,
      permisos: permisos ?? this.permisos,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (permisos.present) {
      map['permisos'] = Variable<String>(permisos.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RolTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('color: $color, ')
          ..write('descripcion: $descripcion, ')
          ..write('permisos: $permisos')
          ..write(')'))
        .toString();
  }
}

class $UsuarioTableTable extends UsuarioTable
    with TableInfo<$UsuarioTableTable, UsuarioTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuarioTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _estatusMeta =
      const VerificationMeta('estatus');
  @override
  late final GeneratedColumn<String> estatus = GeneratedColumn<String>(
      'estatus', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Variable("registrado"));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _correoElectronicoMeta =
      const VerificationMeta('correoElectronico');
  @override
  late final GeneratedColumn<String> correoElectronico =
      GeneratedColumn<String>('correo_electronico', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _telefonoMeta =
      const VerificationMeta('telefono');
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
      'telefono', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaNacimientoMeta =
      const VerificationMeta('fechaNacimiento');
  @override
  late final GeneratedColumn<DateTime> fechaNacimiento =
      GeneratedColumn<DateTime>('fecha_nacimiento', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _apellidoMeta =
      const VerificationMeta('apellido');
  @override
  late final GeneratedColumn<String> apellido = GeneratedColumn<String>(
      'apellido', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imagenIntMeta =
      const VerificationMeta('imagenInt');
  @override
  late final GeneratedColumn<int> imagenInt = GeneratedColumn<int>(
      'imagen_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES imagen_table (id)'));
  static const VerificationMeta _imagenMeta = const VerificationMeta('imagen');
  @override
  late final GeneratedColumn<String> imagen = GeneratedColumn<String>(
      'imagen', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rolIntMeta = const VerificationMeta('rolInt');
  @override
  late final GeneratedColumn<int> rolInt = GeneratedColumn<int>(
      'rol_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES rol_table (id)'));
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<String> rol = GeneratedColumn<String>(
      'rol', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        username,
        password,
        estatus,
        createdAt,
        correoElectronico,
        telefono,
        fechaNacimiento,
        nombre,
        apellido,
        imagenInt,
        imagen,
        rolInt,
        rol
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuario_table';
  @override
  VerificationContext validateIntegrity(Insertable<UsuarioTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    }
    if (data.containsKey('estatus')) {
      context.handle(_estatusMeta,
          estatus.isAcceptableOrUnknown(data['estatus']!, _estatusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('correo_electronico')) {
      context.handle(
          _correoElectronicoMeta,
          correoElectronico.isAcceptableOrUnknown(
              data['correo_electronico']!, _correoElectronicoMeta));
    }
    if (data.containsKey('telefono')) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta));
    }
    if (data.containsKey('fecha_nacimiento')) {
      context.handle(
          _fechaNacimientoMeta,
          fechaNacimiento.isAcceptableOrUnknown(
              data['fecha_nacimiento']!, _fechaNacimientoMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    }
    if (data.containsKey('apellido')) {
      context.handle(_apellidoMeta,
          apellido.isAcceptableOrUnknown(data['apellido']!, _apellidoMeta));
    }
    if (data.containsKey('imagen_int')) {
      context.handle(_imagenIntMeta,
          imagenInt.isAcceptableOrUnknown(data['imagen_int']!, _imagenIntMeta));
    }
    if (data.containsKey('imagen')) {
      context.handle(_imagenMeta,
          imagen.isAcceptableOrUnknown(data['imagen']!, _imagenMeta));
    }
    if (data.containsKey('rol_int')) {
      context.handle(_rolIntMeta,
          rolInt.isAcceptableOrUnknown(data['rol_int']!, _rolIntMeta));
    }
    if (data.containsKey('rol')) {
      context.handle(
          _rolMeta, rol.isAcceptableOrUnknown(data['rol']!, _rolMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  UsuarioTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsuarioTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password']),
      estatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estatus']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      correoElectronico: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}correo_electronico']),
      telefono: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefono']),
      fechaNacimiento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_nacimiento']),
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre']),
      apellido: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}apellido']),
      imagenInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}imagen_int']),
      imagen: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}imagen']),
      rolInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rol_int']),
      rol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rol']),
    );
  }

  @override
  $UsuarioTableTable createAlias(String alias) {
    return $UsuarioTableTable(attachedDatabase, alias);
  }
}

class UsuarioTableData extends DataClass
    implements Insertable<UsuarioTableData> {
  final int idInt;
  final String? id;
  final String? username;
  final String? password;
  final String? estatus;
  final DateTime? createdAt;
  final String? correoElectronico;
  final String? telefono;
  final DateTime? fechaNacimiento;
  final String? nombre;
  final String? apellido;
  final int? imagenInt;
  final String? imagen;
  final int? rolInt;
  final String? rol;
  const UsuarioTableData(
      {required this.idInt,
      this.id,
      this.username,
      this.password,
      this.estatus,
      this.createdAt,
      this.correoElectronico,
      this.telefono,
      this.fechaNacimiento,
      this.nombre,
      this.apellido,
      this.imagenInt,
      this.imagen,
      this.rolInt,
      this.rol});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || estatus != null) {
      map['estatus'] = Variable<String>(estatus);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || correoElectronico != null) {
      map['correo_electronico'] = Variable<String>(correoElectronico);
    }
    if (!nullToAbsent || telefono != null) {
      map['telefono'] = Variable<String>(telefono);
    }
    if (!nullToAbsent || fechaNacimiento != null) {
      map['fecha_nacimiento'] = Variable<DateTime>(fechaNacimiento);
    }
    if (!nullToAbsent || nombre != null) {
      map['nombre'] = Variable<String>(nombre);
    }
    if (!nullToAbsent || apellido != null) {
      map['apellido'] = Variable<String>(apellido);
    }
    if (!nullToAbsent || imagenInt != null) {
      map['imagen_int'] = Variable<int>(imagenInt);
    }
    if (!nullToAbsent || imagen != null) {
      map['imagen'] = Variable<String>(imagen);
    }
    if (!nullToAbsent || rolInt != null) {
      map['rol_int'] = Variable<int>(rolInt);
    }
    if (!nullToAbsent || rol != null) {
      map['rol'] = Variable<String>(rol);
    }
    return map;
  }

  UsuarioTableCompanion toCompanion(bool nullToAbsent) {
    return UsuarioTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      estatus: estatus == null && nullToAbsent
          ? const Value.absent()
          : Value(estatus),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      correoElectronico: correoElectronico == null && nullToAbsent
          ? const Value.absent()
          : Value(correoElectronico),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      fechaNacimiento: fechaNacimiento == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaNacimiento),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      apellido: apellido == null && nullToAbsent
          ? const Value.absent()
          : Value(apellido),
      imagenInt: imagenInt == null && nullToAbsent
          ? const Value.absent()
          : Value(imagenInt),
      imagen:
          imagen == null && nullToAbsent ? const Value.absent() : Value(imagen),
      rolInt:
          rolInt == null && nullToAbsent ? const Value.absent() : Value(rolInt),
      rol: rol == null && nullToAbsent ? const Value.absent() : Value(rol),
    );
  }

  factory UsuarioTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsuarioTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      username: serializer.fromJson<String?>(json['username']),
      password: serializer.fromJson<String?>(json['password']),
      estatus: serializer.fromJson<String?>(json['estatus']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      correoElectronico:
          serializer.fromJson<String?>(json['correoElectronico']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      fechaNacimiento: serializer.fromJson<DateTime?>(json['fechaNacimiento']),
      nombre: serializer.fromJson<String?>(json['nombre']),
      apellido: serializer.fromJson<String?>(json['apellido']),
      imagenInt: serializer.fromJson<int?>(json['imagenInt']),
      imagen: serializer.fromJson<String?>(json['imagen']),
      rolInt: serializer.fromJson<int?>(json['rolInt']),
      rol: serializer.fromJson<String?>(json['rol']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'username': serializer.toJson<String?>(username),
      'password': serializer.toJson<String?>(password),
      'estatus': serializer.toJson<String?>(estatus),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'correoElectronico': serializer.toJson<String?>(correoElectronico),
      'telefono': serializer.toJson<String?>(telefono),
      'fechaNacimiento': serializer.toJson<DateTime?>(fechaNacimiento),
      'nombre': serializer.toJson<String?>(nombre),
      'apellido': serializer.toJson<String?>(apellido),
      'imagenInt': serializer.toJson<int?>(imagenInt),
      'imagen': serializer.toJson<String?>(imagen),
      'rolInt': serializer.toJson<int?>(rolInt),
      'rol': serializer.toJson<String?>(rol),
    };
  }

  UsuarioTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<String?> username = const Value.absent(),
          Value<String?> password = const Value.absent(),
          Value<String?> estatus = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<String?> correoElectronico = const Value.absent(),
          Value<String?> telefono = const Value.absent(),
          Value<DateTime?> fechaNacimiento = const Value.absent(),
          Value<String?> nombre = const Value.absent(),
          Value<String?> apellido = const Value.absent(),
          Value<int?> imagenInt = const Value.absent(),
          Value<String?> imagen = const Value.absent(),
          Value<int?> rolInt = const Value.absent(),
          Value<String?> rol = const Value.absent()}) =>
      UsuarioTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        username: username.present ? username.value : this.username,
        password: password.present ? password.value : this.password,
        estatus: estatus.present ? estatus.value : this.estatus,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        correoElectronico: correoElectronico.present
            ? correoElectronico.value
            : this.correoElectronico,
        telefono: telefono.present ? telefono.value : this.telefono,
        fechaNacimiento: fechaNacimiento.present
            ? fechaNacimiento.value
            : this.fechaNacimiento,
        nombre: nombre.present ? nombre.value : this.nombre,
        apellido: apellido.present ? apellido.value : this.apellido,
        imagenInt: imagenInt.present ? imagenInt.value : this.imagenInt,
        imagen: imagen.present ? imagen.value : this.imagen,
        rolInt: rolInt.present ? rolInt.value : this.rolInt,
        rol: rol.present ? rol.value : this.rol,
      );
  UsuarioTableData copyWithCompanion(UsuarioTableCompanion data) {
    return UsuarioTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      estatus: data.estatus.present ? data.estatus.value : this.estatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      correoElectronico: data.correoElectronico.present
          ? data.correoElectronico.value
          : this.correoElectronico,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      fechaNacimiento: data.fechaNacimiento.present
          ? data.fechaNacimiento.value
          : this.fechaNacimiento,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      apellido: data.apellido.present ? data.apellido.value : this.apellido,
      imagenInt: data.imagenInt.present ? data.imagenInt.value : this.imagenInt,
      imagen: data.imagen.present ? data.imagen.value : this.imagen,
      rolInt: data.rolInt.present ? data.rolInt.value : this.rolInt,
      rol: data.rol.present ? data.rol.value : this.rol,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsuarioTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('estatus: $estatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('correoElectronico: $correoElectronico, ')
          ..write('telefono: $telefono, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('nombre: $nombre, ')
          ..write('apellido: $apellido, ')
          ..write('imagenInt: $imagenInt, ')
          ..write('imagen: $imagen, ')
          ..write('rolInt: $rolInt, ')
          ..write('rol: $rol')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      idInt,
      id,
      username,
      password,
      estatus,
      createdAt,
      correoElectronico,
      telefono,
      fechaNacimiento,
      nombre,
      apellido,
      imagenInt,
      imagen,
      rolInt,
      rol);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuarioTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.estatus == this.estatus &&
          other.createdAt == this.createdAt &&
          other.correoElectronico == this.correoElectronico &&
          other.telefono == this.telefono &&
          other.fechaNacimiento == this.fechaNacimiento &&
          other.nombre == this.nombre &&
          other.apellido == this.apellido &&
          other.imagenInt == this.imagenInt &&
          other.imagen == this.imagen &&
          other.rolInt == this.rolInt &&
          other.rol == this.rol);
}

class UsuarioTableCompanion extends UpdateCompanion<UsuarioTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<String?> username;
  final Value<String?> password;
  final Value<String?> estatus;
  final Value<DateTime?> createdAt;
  final Value<String?> correoElectronico;
  final Value<String?> telefono;
  final Value<DateTime?> fechaNacimiento;
  final Value<String?> nombre;
  final Value<String?> apellido;
  final Value<int?> imagenInt;
  final Value<String?> imagen;
  final Value<int?> rolInt;
  final Value<String?> rol;
  const UsuarioTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.estatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.correoElectronico = const Value.absent(),
    this.telefono = const Value.absent(),
    this.fechaNacimiento = const Value.absent(),
    this.nombre = const Value.absent(),
    this.apellido = const Value.absent(),
    this.imagenInt = const Value.absent(),
    this.imagen = const Value.absent(),
    this.rolInt = const Value.absent(),
    this.rol = const Value.absent(),
  });
  UsuarioTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.estatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.correoElectronico = const Value.absent(),
    this.telefono = const Value.absent(),
    this.fechaNacimiento = const Value.absent(),
    this.nombre = const Value.absent(),
    this.apellido = const Value.absent(),
    this.imagenInt = const Value.absent(),
    this.imagen = const Value.absent(),
    this.rolInt = const Value.absent(),
    this.rol = const Value.absent(),
  });
  static Insertable<UsuarioTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? estatus,
    Expression<DateTime>? createdAt,
    Expression<String>? correoElectronico,
    Expression<String>? telefono,
    Expression<DateTime>? fechaNacimiento,
    Expression<String>? nombre,
    Expression<String>? apellido,
    Expression<int>? imagenInt,
    Expression<String>? imagen,
    Expression<int>? rolInt,
    Expression<String>? rol,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (estatus != null) 'estatus': estatus,
      if (createdAt != null) 'created_at': createdAt,
      if (correoElectronico != null) 'correo_electronico': correoElectronico,
      if (telefono != null) 'telefono': telefono,
      if (fechaNacimiento != null) 'fecha_nacimiento': fechaNacimiento,
      if (nombre != null) 'nombre': nombre,
      if (apellido != null) 'apellido': apellido,
      if (imagenInt != null) 'imagen_int': imagenInt,
      if (imagen != null) 'imagen': imagen,
      if (rolInt != null) 'rol_int': rolInt,
      if (rol != null) 'rol': rol,
    });
  }

  UsuarioTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<String?>? username,
      Value<String?>? password,
      Value<String?>? estatus,
      Value<DateTime?>? createdAt,
      Value<String?>? correoElectronico,
      Value<String?>? telefono,
      Value<DateTime?>? fechaNacimiento,
      Value<String?>? nombre,
      Value<String?>? apellido,
      Value<int?>? imagenInt,
      Value<String?>? imagen,
      Value<int?>? rolInt,
      Value<String?>? rol}) {
    return UsuarioTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      estatus: estatus ?? this.estatus,
      createdAt: createdAt ?? this.createdAt,
      correoElectronico: correoElectronico ?? this.correoElectronico,
      telefono: telefono ?? this.telefono,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      imagenInt: imagenInt ?? this.imagenInt,
      imagen: imagen ?? this.imagen,
      rolInt: rolInt ?? this.rolInt,
      rol: rol ?? this.rol,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (estatus.present) {
      map['estatus'] = Variable<String>(estatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (correoElectronico.present) {
      map['correo_electronico'] = Variable<String>(correoElectronico.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (fechaNacimiento.present) {
      map['fecha_nacimiento'] = Variable<DateTime>(fechaNacimiento.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (apellido.present) {
      map['apellido'] = Variable<String>(apellido.value);
    }
    if (imagenInt.present) {
      map['imagen_int'] = Variable<int>(imagenInt.value);
    }
    if (imagen.present) {
      map['imagen'] = Variable<String>(imagen.value);
    }
    if (rolInt.present) {
      map['rol_int'] = Variable<int>(rolInt.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(rol.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuarioTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('estatus: $estatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('correoElectronico: $correoElectronico, ')
          ..write('telefono: $telefono, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('nombre: $nombre, ')
          ..write('apellido: $apellido, ')
          ..write('imagenInt: $imagenInt, ')
          ..write('imagen: $imagen, ')
          ..write('rolInt: $rolInt, ')
          ..write('rol: $rol')
          ..write(')'))
        .toString();
  }
}

class $CategoriaTableTable extends CategoriaTable
    with TableInfo<$CategoriaTableTable, CategoriaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tipoHabitacionIntMeta =
      const VerificationMeta('tipoHabitacionInt');
  @override
  late final GeneratedColumn<int> tipoHabitacionInt = GeneratedColumn<int>(
      'tipo_habitacion_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tipo_habitacion_table (id)'));
  static const VerificationMeta _tipoHabitacionMeta =
      const VerificationMeta('tipoHabitacion');
  @override
  late final GeneratedColumn<String> tipoHabitacion = GeneratedColumn<String>(
      'tipo_habitacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creadoPorIntMeta =
      const VerificationMeta('creadoPorInt');
  @override
  late final GeneratedColumn<int> creadoPorInt = GeneratedColumn<int>(
      'creado_por_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario_table (id)'));
  static const VerificationMeta _creadoPorMeta =
      const VerificationMeta('creadoPor');
  @override
  late final GeneratedColumn<String> creadoPor = GeneratedColumn<String>(
      'creado_por', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        createdAt,
        nombre,
        color,
        tipoHabitacionInt,
        tipoHabitacion,
        creadoPorInt,
        creadoPor
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categoria_table';
  @override
  VerificationContext validateIntegrity(Insertable<CategoriaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('tipo_habitacion_int')) {
      context.handle(
          _tipoHabitacionIntMeta,
          tipoHabitacionInt.isAcceptableOrUnknown(
              data['tipo_habitacion_int']!, _tipoHabitacionIntMeta));
    }
    if (data.containsKey('tipo_habitacion')) {
      context.handle(
          _tipoHabitacionMeta,
          tipoHabitacion.isAcceptableOrUnknown(
              data['tipo_habitacion']!, _tipoHabitacionMeta));
    }
    if (data.containsKey('creado_por_int')) {
      context.handle(
          _creadoPorIntMeta,
          creadoPorInt.isAcceptableOrUnknown(
              data['creado_por_int']!, _creadoPorIntMeta));
    }
    if (data.containsKey('creado_por')) {
      context.handle(_creadoPorMeta,
          creadoPor.isAcceptableOrUnknown(data['creado_por']!, _creadoPorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  CategoriaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriaTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      tipoHabitacionInt: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}tipo_habitacion_int']),
      tipoHabitacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo_habitacion']),
      creadoPorInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}creado_por_int']),
      creadoPor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creado_por']),
    );
  }

  @override
  $CategoriaTableTable createAlias(String alias) {
    return $CategoriaTableTable(attachedDatabase, alias);
  }
}

class CategoriaTableData extends DataClass
    implements Insertable<CategoriaTableData> {
  final int idInt;
  final String? id;
  final DateTime? createdAt;
  final String? nombre;
  final String? color;
  final int? tipoHabitacionInt;
  final String? tipoHabitacion;
  final int? creadoPorInt;
  final String? creadoPor;
  const CategoriaTableData(
      {required this.idInt,
      this.id,
      this.createdAt,
      this.nombre,
      this.color,
      this.tipoHabitacionInt,
      this.tipoHabitacion,
      this.creadoPorInt,
      this.creadoPor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || nombre != null) {
      map['nombre'] = Variable<String>(nombre);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || tipoHabitacionInt != null) {
      map['tipo_habitacion_int'] = Variable<int>(tipoHabitacionInt);
    }
    if (!nullToAbsent || tipoHabitacion != null) {
      map['tipo_habitacion'] = Variable<String>(tipoHabitacion);
    }
    if (!nullToAbsent || creadoPorInt != null) {
      map['creado_por_int'] = Variable<int>(creadoPorInt);
    }
    if (!nullToAbsent || creadoPor != null) {
      map['creado_por'] = Variable<String>(creadoPor);
    }
    return map;
  }

  CategoriaTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriaTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      tipoHabitacionInt: tipoHabitacionInt == null && nullToAbsent
          ? const Value.absent()
          : Value(tipoHabitacionInt),
      tipoHabitacion: tipoHabitacion == null && nullToAbsent
          ? const Value.absent()
          : Value(tipoHabitacion),
      creadoPorInt: creadoPorInt == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPorInt),
      creadoPor: creadoPor == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPor),
    );
  }

  factory CategoriaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriaTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      nombre: serializer.fromJson<String?>(json['nombre']),
      color: serializer.fromJson<String?>(json['color']),
      tipoHabitacionInt: serializer.fromJson<int?>(json['tipoHabitacionInt']),
      tipoHabitacion: serializer.fromJson<String?>(json['tipoHabitacion']),
      creadoPorInt: serializer.fromJson<int?>(json['creadoPorInt']),
      creadoPor: serializer.fromJson<String?>(json['creadoPor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'nombre': serializer.toJson<String?>(nombre),
      'color': serializer.toJson<String?>(color),
      'tipoHabitacionInt': serializer.toJson<int?>(tipoHabitacionInt),
      'tipoHabitacion': serializer.toJson<String?>(tipoHabitacion),
      'creadoPorInt': serializer.toJson<int?>(creadoPorInt),
      'creadoPor': serializer.toJson<String?>(creadoPor),
    };
  }

  CategoriaTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<String?> nombre = const Value.absent(),
          Value<String?> color = const Value.absent(),
          Value<int?> tipoHabitacionInt = const Value.absent(),
          Value<String?> tipoHabitacion = const Value.absent(),
          Value<int?> creadoPorInt = const Value.absent(),
          Value<String?> creadoPor = const Value.absent()}) =>
      CategoriaTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        nombre: nombre.present ? nombre.value : this.nombre,
        color: color.present ? color.value : this.color,
        tipoHabitacionInt: tipoHabitacionInt.present
            ? tipoHabitacionInt.value
            : this.tipoHabitacionInt,
        tipoHabitacion:
            tipoHabitacion.present ? tipoHabitacion.value : this.tipoHabitacion,
        creadoPorInt:
            creadoPorInt.present ? creadoPorInt.value : this.creadoPorInt,
        creadoPor: creadoPor.present ? creadoPor.value : this.creadoPor,
      );
  CategoriaTableData copyWithCompanion(CategoriaTableCompanion data) {
    return CategoriaTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      color: data.color.present ? data.color.value : this.color,
      tipoHabitacionInt: data.tipoHabitacionInt.present
          ? data.tipoHabitacionInt.value
          : this.tipoHabitacionInt,
      tipoHabitacion: data.tipoHabitacion.present
          ? data.tipoHabitacion.value
          : this.tipoHabitacion,
      creadoPorInt: data.creadoPorInt.present
          ? data.creadoPorInt.value
          : this.creadoPorInt,
      creadoPor: data.creadoPor.present ? data.creadoPor.value : this.creadoPor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriaTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('nombre: $nombre, ')
          ..write('color: $color, ')
          ..write('tipoHabitacionInt: $tipoHabitacionInt, ')
          ..write('tipoHabitacion: $tipoHabitacion, ')
          ..write('creadoPorInt: $creadoPorInt, ')
          ..write('creadoPor: $creadoPor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idInt, id, createdAt, nombre, color,
      tipoHabitacionInt, tipoHabitacion, creadoPorInt, creadoPor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriaTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.nombre == this.nombre &&
          other.color == this.color &&
          other.tipoHabitacionInt == this.tipoHabitacionInt &&
          other.tipoHabitacion == this.tipoHabitacion &&
          other.creadoPorInt == this.creadoPorInt &&
          other.creadoPor == this.creadoPor);
}

class CategoriaTableCompanion extends UpdateCompanion<CategoriaTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<DateTime?> createdAt;
  final Value<String?> nombre;
  final Value<String?> color;
  final Value<int?> tipoHabitacionInt;
  final Value<String?> tipoHabitacion;
  final Value<int?> creadoPorInt;
  final Value<String?> creadoPor;
  const CategoriaTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.nombre = const Value.absent(),
    this.color = const Value.absent(),
    this.tipoHabitacionInt = const Value.absent(),
    this.tipoHabitacion = const Value.absent(),
    this.creadoPorInt = const Value.absent(),
    this.creadoPor = const Value.absent(),
  });
  CategoriaTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.nombre = const Value.absent(),
    this.color = const Value.absent(),
    this.tipoHabitacionInt = const Value.absent(),
    this.tipoHabitacion = const Value.absent(),
    this.creadoPorInt = const Value.absent(),
    this.creadoPor = const Value.absent(),
  });
  static Insertable<CategoriaTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? nombre,
    Expression<String>? color,
    Expression<int>? tipoHabitacionInt,
    Expression<String>? tipoHabitacion,
    Expression<int>? creadoPorInt,
    Expression<String>? creadoPor,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (nombre != null) 'nombre': nombre,
      if (color != null) 'color': color,
      if (tipoHabitacionInt != null) 'tipo_habitacion_int': tipoHabitacionInt,
      if (tipoHabitacion != null) 'tipo_habitacion': tipoHabitacion,
      if (creadoPorInt != null) 'creado_por_int': creadoPorInt,
      if (creadoPor != null) 'creado_por': creadoPor,
    });
  }

  CategoriaTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<DateTime?>? createdAt,
      Value<String?>? nombre,
      Value<String?>? color,
      Value<int?>? tipoHabitacionInt,
      Value<String?>? tipoHabitacion,
      Value<int?>? creadoPorInt,
      Value<String?>? creadoPor}) {
    return CategoriaTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      nombre: nombre ?? this.nombre,
      color: color ?? this.color,
      tipoHabitacionInt: tipoHabitacionInt ?? this.tipoHabitacionInt,
      tipoHabitacion: tipoHabitacion ?? this.tipoHabitacion,
      creadoPorInt: creadoPorInt ?? this.creadoPorInt,
      creadoPor: creadoPor ?? this.creadoPor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (tipoHabitacionInt.present) {
      map['tipo_habitacion_int'] = Variable<int>(tipoHabitacionInt.value);
    }
    if (tipoHabitacion.present) {
      map['tipo_habitacion'] = Variable<String>(tipoHabitacion.value);
    }
    if (creadoPorInt.present) {
      map['creado_por_int'] = Variable<int>(creadoPorInt.value);
    }
    if (creadoPor.present) {
      map['creado_por'] = Variable<String>(creadoPor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriaTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('nombre: $nombre, ')
          ..write('color: $color, ')
          ..write('tipoHabitacionInt: $tipoHabitacionInt, ')
          ..write('tipoHabitacion: $tipoHabitacion, ')
          ..write('creadoPorInt: $creadoPorInt, ')
          ..write('creadoPor: $creadoPor')
          ..write(')'))
        .toString();
  }
}

class $ClienteTableTable extends ClienteTable
    with TableInfo<$ClienteTableTable, ClienteTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClienteTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nombresMeta =
      const VerificationMeta('nombres');
  @override
  late final GeneratedColumn<String> nombres = GeneratedColumn<String>(
      'nombres', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _apellidosMeta =
      const VerificationMeta('apellidos');
  @override
  late final GeneratedColumn<String> apellidos = GeneratedColumn<String>(
      'apellidos', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _numeroTelefonicoMeta =
      const VerificationMeta('numeroTelefonico');
  @override
  late final GeneratedColumn<String> numeroTelefonico = GeneratedColumn<String>(
      'numero_telefonico', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _correoElectronicoMeta =
      const VerificationMeta('correoElectronico');
  @override
  late final GeneratedColumn<String> correoElectronico =
      GeneratedColumn<String>('correo_electronico', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _paisMeta = const VerificationMeta('pais');
  @override
  late final GeneratedColumn<String> pais = GeneratedColumn<String>(
      'pais', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Variable("Mexico"));
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ciudadMeta = const VerificationMeta('ciudad');
  @override
  late final GeneratedColumn<String> ciudad = GeneratedColumn<String>(
      'ciudad', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _direccionMeta =
      const VerificationMeta('direccion');
  @override
  late final GeneratedColumn<String> direccion = GeneratedColumn<String>(
      'direccion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notasMeta = const VerificationMeta('notas');
  @override
  late final GeneratedColumn<String> notas = GeneratedColumn<String>(
      'notas', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        nombres,
        apellidos,
        numeroTelefonico,
        correoElectronico,
        pais,
        estado,
        ciudad,
        direccion,
        notas,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cliente_table';
  @override
  VerificationContext validateIntegrity(Insertable<ClienteTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombres')) {
      context.handle(_nombresMeta,
          nombres.isAcceptableOrUnknown(data['nombres']!, _nombresMeta));
    }
    if (data.containsKey('apellidos')) {
      context.handle(_apellidosMeta,
          apellidos.isAcceptableOrUnknown(data['apellidos']!, _apellidosMeta));
    }
    if (data.containsKey('numero_telefonico')) {
      context.handle(
          _numeroTelefonicoMeta,
          numeroTelefonico.isAcceptableOrUnknown(
              data['numero_telefonico']!, _numeroTelefonicoMeta));
    }
    if (data.containsKey('correo_electronico')) {
      context.handle(
          _correoElectronicoMeta,
          correoElectronico.isAcceptableOrUnknown(
              data['correo_electronico']!, _correoElectronicoMeta));
    }
    if (data.containsKey('pais')) {
      context.handle(
          _paisMeta, pais.isAcceptableOrUnknown(data['pais']!, _paisMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('ciudad')) {
      context.handle(_ciudadMeta,
          ciudad.isAcceptableOrUnknown(data['ciudad']!, _ciudadMeta));
    }
    if (data.containsKey('direccion')) {
      context.handle(_direccionMeta,
          direccion.isAcceptableOrUnknown(data['direccion']!, _direccionMeta));
    }
    if (data.containsKey('notas')) {
      context.handle(
          _notasMeta, notas.isAcceptableOrUnknown(data['notas']!, _notasMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  ClienteTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClienteTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      nombres: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombres']),
      apellidos: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}apellidos']),
      numeroTelefonico: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}numero_telefonico']),
      correoElectronico: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}correo_electronico']),
      pais: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pais']),
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado']),
      ciudad: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ciudad']),
      direccion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}direccion']),
      notas: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notas']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $ClienteTableTable createAlias(String alias) {
    return $ClienteTableTable(attachedDatabase, alias);
  }
}

class ClienteTableData extends DataClass
    implements Insertable<ClienteTableData> {
  final int idInt;
  final String? id;
  final String? nombres;
  final String? apellidos;
  final String? numeroTelefonico;
  final String? correoElectronico;
  final String? pais;
  final String? estado;
  final String? ciudad;
  final String? direccion;
  final String? notas;
  final DateTime? createdAt;
  const ClienteTableData(
      {required this.idInt,
      this.id,
      this.nombres,
      this.apellidos,
      this.numeroTelefonico,
      this.correoElectronico,
      this.pais,
      this.estado,
      this.ciudad,
      this.direccion,
      this.notas,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || nombres != null) {
      map['nombres'] = Variable<String>(nombres);
    }
    if (!nullToAbsent || apellidos != null) {
      map['apellidos'] = Variable<String>(apellidos);
    }
    if (!nullToAbsent || numeroTelefonico != null) {
      map['numero_telefonico'] = Variable<String>(numeroTelefonico);
    }
    if (!nullToAbsent || correoElectronico != null) {
      map['correo_electronico'] = Variable<String>(correoElectronico);
    }
    if (!nullToAbsent || pais != null) {
      map['pais'] = Variable<String>(pais);
    }
    if (!nullToAbsent || estado != null) {
      map['estado'] = Variable<String>(estado);
    }
    if (!nullToAbsent || ciudad != null) {
      map['ciudad'] = Variable<String>(ciudad);
    }
    if (!nullToAbsent || direccion != null) {
      map['direccion'] = Variable<String>(direccion);
    }
    if (!nullToAbsent || notas != null) {
      map['notas'] = Variable<String>(notas);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  ClienteTableCompanion toCompanion(bool nullToAbsent) {
    return ClienteTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nombres: nombres == null && nullToAbsent
          ? const Value.absent()
          : Value(nombres),
      apellidos: apellidos == null && nullToAbsent
          ? const Value.absent()
          : Value(apellidos),
      numeroTelefonico: numeroTelefonico == null && nullToAbsent
          ? const Value.absent()
          : Value(numeroTelefonico),
      correoElectronico: correoElectronico == null && nullToAbsent
          ? const Value.absent()
          : Value(correoElectronico),
      pais: pais == null && nullToAbsent ? const Value.absent() : Value(pais),
      estado:
          estado == null && nullToAbsent ? const Value.absent() : Value(estado),
      ciudad:
          ciudad == null && nullToAbsent ? const Value.absent() : Value(ciudad),
      direccion: direccion == null && nullToAbsent
          ? const Value.absent()
          : Value(direccion),
      notas:
          notas == null && nullToAbsent ? const Value.absent() : Value(notas),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory ClienteTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClienteTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      nombres: serializer.fromJson<String?>(json['nombres']),
      apellidos: serializer.fromJson<String?>(json['apellidos']),
      numeroTelefonico: serializer.fromJson<String?>(json['numeroTelefonico']),
      correoElectronico:
          serializer.fromJson<String?>(json['correoElectronico']),
      pais: serializer.fromJson<String?>(json['pais']),
      estado: serializer.fromJson<String?>(json['estado']),
      ciudad: serializer.fromJson<String?>(json['ciudad']),
      direccion: serializer.fromJson<String?>(json['direccion']),
      notas: serializer.fromJson<String?>(json['notas']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'nombres': serializer.toJson<String?>(nombres),
      'apellidos': serializer.toJson<String?>(apellidos),
      'numeroTelefonico': serializer.toJson<String?>(numeroTelefonico),
      'correoElectronico': serializer.toJson<String?>(correoElectronico),
      'pais': serializer.toJson<String?>(pais),
      'estado': serializer.toJson<String?>(estado),
      'ciudad': serializer.toJson<String?>(ciudad),
      'direccion': serializer.toJson<String?>(direccion),
      'notas': serializer.toJson<String?>(notas),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  ClienteTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<String?> nombres = const Value.absent(),
          Value<String?> apellidos = const Value.absent(),
          Value<String?> numeroTelefonico = const Value.absent(),
          Value<String?> correoElectronico = const Value.absent(),
          Value<String?> pais = const Value.absent(),
          Value<String?> estado = const Value.absent(),
          Value<String?> ciudad = const Value.absent(),
          Value<String?> direccion = const Value.absent(),
          Value<String?> notas = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent()}) =>
      ClienteTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        nombres: nombres.present ? nombres.value : this.nombres,
        apellidos: apellidos.present ? apellidos.value : this.apellidos,
        numeroTelefonico: numeroTelefonico.present
            ? numeroTelefonico.value
            : this.numeroTelefonico,
        correoElectronico: correoElectronico.present
            ? correoElectronico.value
            : this.correoElectronico,
        pais: pais.present ? pais.value : this.pais,
        estado: estado.present ? estado.value : this.estado,
        ciudad: ciudad.present ? ciudad.value : this.ciudad,
        direccion: direccion.present ? direccion.value : this.direccion,
        notas: notas.present ? notas.value : this.notas,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  ClienteTableData copyWithCompanion(ClienteTableCompanion data) {
    return ClienteTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      nombres: data.nombres.present ? data.nombres.value : this.nombres,
      apellidos: data.apellidos.present ? data.apellidos.value : this.apellidos,
      numeroTelefonico: data.numeroTelefonico.present
          ? data.numeroTelefonico.value
          : this.numeroTelefonico,
      correoElectronico: data.correoElectronico.present
          ? data.correoElectronico.value
          : this.correoElectronico,
      pais: data.pais.present ? data.pais.value : this.pais,
      estado: data.estado.present ? data.estado.value : this.estado,
      ciudad: data.ciudad.present ? data.ciudad.value : this.ciudad,
      direccion: data.direccion.present ? data.direccion.value : this.direccion,
      notas: data.notas.present ? data.notas.value : this.notas,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClienteTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('nombres: $nombres, ')
          ..write('apellidos: $apellidos, ')
          ..write('numeroTelefonico: $numeroTelefonico, ')
          ..write('correoElectronico: $correoElectronico, ')
          ..write('pais: $pais, ')
          ..write('estado: $estado, ')
          ..write('ciudad: $ciudad, ')
          ..write('direccion: $direccion, ')
          ..write('notas: $notas, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      idInt,
      id,
      nombres,
      apellidos,
      numeroTelefonico,
      correoElectronico,
      pais,
      estado,
      ciudad,
      direccion,
      notas,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClienteTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.nombres == this.nombres &&
          other.apellidos == this.apellidos &&
          other.numeroTelefonico == this.numeroTelefonico &&
          other.correoElectronico == this.correoElectronico &&
          other.pais == this.pais &&
          other.estado == this.estado &&
          other.ciudad == this.ciudad &&
          other.direccion == this.direccion &&
          other.notas == this.notas &&
          other.createdAt == this.createdAt);
}

class ClienteTableCompanion extends UpdateCompanion<ClienteTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<String?> nombres;
  final Value<String?> apellidos;
  final Value<String?> numeroTelefonico;
  final Value<String?> correoElectronico;
  final Value<String?> pais;
  final Value<String?> estado;
  final Value<String?> ciudad;
  final Value<String?> direccion;
  final Value<String?> notas;
  final Value<DateTime?> createdAt;
  const ClienteTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.nombres = const Value.absent(),
    this.apellidos = const Value.absent(),
    this.numeroTelefonico = const Value.absent(),
    this.correoElectronico = const Value.absent(),
    this.pais = const Value.absent(),
    this.estado = const Value.absent(),
    this.ciudad = const Value.absent(),
    this.direccion = const Value.absent(),
    this.notas = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ClienteTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.nombres = const Value.absent(),
    this.apellidos = const Value.absent(),
    this.numeroTelefonico = const Value.absent(),
    this.correoElectronico = const Value.absent(),
    this.pais = const Value.absent(),
    this.estado = const Value.absent(),
    this.ciudad = const Value.absent(),
    this.direccion = const Value.absent(),
    this.notas = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<ClienteTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<String>? nombres,
    Expression<String>? apellidos,
    Expression<String>? numeroTelefonico,
    Expression<String>? correoElectronico,
    Expression<String>? pais,
    Expression<String>? estado,
    Expression<String>? ciudad,
    Expression<String>? direccion,
    Expression<String>? notas,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (nombres != null) 'nombres': nombres,
      if (apellidos != null) 'apellidos': apellidos,
      if (numeroTelefonico != null) 'numero_telefonico': numeroTelefonico,
      if (correoElectronico != null) 'correo_electronico': correoElectronico,
      if (pais != null) 'pais': pais,
      if (estado != null) 'estado': estado,
      if (ciudad != null) 'ciudad': ciudad,
      if (direccion != null) 'direccion': direccion,
      if (notas != null) 'notas': notas,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ClienteTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<String?>? nombres,
      Value<String?>? apellidos,
      Value<String?>? numeroTelefonico,
      Value<String?>? correoElectronico,
      Value<String?>? pais,
      Value<String?>? estado,
      Value<String?>? ciudad,
      Value<String?>? direccion,
      Value<String?>? notas,
      Value<DateTime?>? createdAt}) {
    return ClienteTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      nombres: nombres ?? this.nombres,
      apellidos: apellidos ?? this.apellidos,
      numeroTelefonico: numeroTelefonico ?? this.numeroTelefonico,
      correoElectronico: correoElectronico ?? this.correoElectronico,
      pais: pais ?? this.pais,
      estado: estado ?? this.estado,
      ciudad: ciudad ?? this.ciudad,
      direccion: direccion ?? this.direccion,
      notas: notas ?? this.notas,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombres.present) {
      map['nombres'] = Variable<String>(nombres.value);
    }
    if (apellidos.present) {
      map['apellidos'] = Variable<String>(apellidos.value);
    }
    if (numeroTelefonico.present) {
      map['numero_telefonico'] = Variable<String>(numeroTelefonico.value);
    }
    if (correoElectronico.present) {
      map['correo_electronico'] = Variable<String>(correoElectronico.value);
    }
    if (pais.present) {
      map['pais'] = Variable<String>(pais.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (ciudad.present) {
      map['ciudad'] = Variable<String>(ciudad.value);
    }
    if (direccion.present) {
      map['direccion'] = Variable<String>(direccion.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClienteTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('nombres: $nombres, ')
          ..write('apellidos: $apellidos, ')
          ..write('numeroTelefonico: $numeroTelefonico, ')
          ..write('correoElectronico: $correoElectronico, ')
          ..write('pais: $pais, ')
          ..write('estado: $estado, ')
          ..write('ciudad: $ciudad, ')
          ..write('direccion: $direccion, ')
          ..write('notas: $notas, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CotizacionTableTable extends CotizacionTable
    with TableInfo<$CotizacionTableTable, CotizacionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CotizacionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _folioMeta = const VerificationMeta('folio');
  @override
  late final GeneratedColumn<String> folio = GeneratedColumn<String>(
      'folio', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clienteIntMeta =
      const VerificationMeta('clienteInt');
  @override
  late final GeneratedColumn<int> clienteInt = GeneratedColumn<int>(
      'cliente_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cliente_table (id)'));
  static const VerificationMeta _clienteMeta =
      const VerificationMeta('cliente');
  @override
  late final GeneratedColumn<String> cliente = GeneratedColumn<String>(
      'cliente', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _fechaLimiteMeta =
      const VerificationMeta('fechaLimite');
  @override
  late final GeneratedColumn<DateTime> fechaLimite = GeneratedColumn<DateTime>(
      'fecha_limite', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _estatusMeta =
      const VerificationMeta('estatus');
  @override
  late final GeneratedColumn<String> estatus = GeneratedColumn<String>(
      'estatus', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _esGrupoMeta =
      const VerificationMeta('esGrupo');
  @override
  late final GeneratedColumn<bool> esGrupo = GeneratedColumn<bool>(
      'es_grupo', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("es_grupo" IN (0, 1))'));
  static const VerificationMeta _creadoPorIntMeta =
      const VerificationMeta('creadoPorInt');
  @override
  late final GeneratedColumn<int> creadoPorInt = GeneratedColumn<int>(
      'creado_por_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario_table (id)'));
  static const VerificationMeta _creadoPorMeta =
      const VerificationMeta('creadoPor');
  @override
  late final GeneratedColumn<String> creadoPor = GeneratedColumn<String>(
      'creado_por', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cerradoPorIntMeta =
      const VerificationMeta('cerradoPorInt');
  @override
  late final GeneratedColumn<int> cerradoPorInt = GeneratedColumn<int>(
      'cerrado_por_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario_table (id)'));
  static const VerificationMeta _cerradoPorMeta =
      const VerificationMeta('cerradoPor');
  @override
  late final GeneratedColumn<String> cerradoPor = GeneratedColumn<String>(
      'cerrado_por', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _descuentoMeta =
      const VerificationMeta('descuento');
  @override
  late final GeneratedColumn<double> descuento = GeneratedColumn<double>(
      'descuento', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _impuestosMeta =
      const VerificationMeta('impuestos');
  @override
  late final GeneratedColumn<double> impuestos = GeneratedColumn<double>(
      'impuestos', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _comentariosMeta =
      const VerificationMeta('comentarios');
  @override
  late final GeneratedColumn<String> comentarios = GeneratedColumn<String>(
      'comentarios', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cotizacionIntMeta =
      const VerificationMeta('cotizacionInt');
  @override
  late final GeneratedColumn<int> cotizacionInt = GeneratedColumn<int>(
      'cotizacion_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES cotizacion_table (id)'));
  static const VerificationMeta _cotizacionMeta =
      const VerificationMeta('cotizacion');
  @override
  late final GeneratedColumn<String> cotizacion = GeneratedColumn<String>(
      'cotizacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        folio,
        clienteInt,
        cliente,
        createdAt,
        fechaLimite,
        estatus,
        esGrupo,
        creadoPorInt,
        creadoPor,
        cerradoPorInt,
        cerradoPor,
        subtotal,
        descuento,
        impuestos,
        total,
        comentarios,
        cotizacionInt,
        cotizacion
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cotizacion_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<CotizacionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('folio')) {
      context.handle(
          _folioMeta, folio.isAcceptableOrUnknown(data['folio']!, _folioMeta));
    }
    if (data.containsKey('cliente_int')) {
      context.handle(
          _clienteIntMeta,
          clienteInt.isAcceptableOrUnknown(
              data['cliente_int']!, _clienteIntMeta));
    }
    if (data.containsKey('cliente')) {
      context.handle(_clienteMeta,
          cliente.isAcceptableOrUnknown(data['cliente']!, _clienteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('fecha_limite')) {
      context.handle(
          _fechaLimiteMeta,
          fechaLimite.isAcceptableOrUnknown(
              data['fecha_limite']!, _fechaLimiteMeta));
    }
    if (data.containsKey('estatus')) {
      context.handle(_estatusMeta,
          estatus.isAcceptableOrUnknown(data['estatus']!, _estatusMeta));
    }
    if (data.containsKey('es_grupo')) {
      context.handle(_esGrupoMeta,
          esGrupo.isAcceptableOrUnknown(data['es_grupo']!, _esGrupoMeta));
    }
    if (data.containsKey('creado_por_int')) {
      context.handle(
          _creadoPorIntMeta,
          creadoPorInt.isAcceptableOrUnknown(
              data['creado_por_int']!, _creadoPorIntMeta));
    }
    if (data.containsKey('creado_por')) {
      context.handle(_creadoPorMeta,
          creadoPor.isAcceptableOrUnknown(data['creado_por']!, _creadoPorMeta));
    }
    if (data.containsKey('cerrado_por_int')) {
      context.handle(
          _cerradoPorIntMeta,
          cerradoPorInt.isAcceptableOrUnknown(
              data['cerrado_por_int']!, _cerradoPorIntMeta));
    }
    if (data.containsKey('cerrado_por')) {
      context.handle(
          _cerradoPorMeta,
          cerradoPor.isAcceptableOrUnknown(
              data['cerrado_por']!, _cerradoPorMeta));
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    }
    if (data.containsKey('descuento')) {
      context.handle(_descuentoMeta,
          descuento.isAcceptableOrUnknown(data['descuento']!, _descuentoMeta));
    }
    if (data.containsKey('impuestos')) {
      context.handle(_impuestosMeta,
          impuestos.isAcceptableOrUnknown(data['impuestos']!, _impuestosMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    }
    if (data.containsKey('comentarios')) {
      context.handle(
          _comentariosMeta,
          comentarios.isAcceptableOrUnknown(
              data['comentarios']!, _comentariosMeta));
    }
    if (data.containsKey('cotizacion_int')) {
      context.handle(
          _cotizacionIntMeta,
          cotizacionInt.isAcceptableOrUnknown(
              data['cotizacion_int']!, _cotizacionIntMeta));
    }
    if (data.containsKey('cotizacion')) {
      context.handle(
          _cotizacionMeta,
          cotizacion.isAcceptableOrUnknown(
              data['cotizacion']!, _cotizacionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  CotizacionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CotizacionTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      folio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}folio']),
      clienteInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cliente_int']),
      cliente: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cliente']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      fechaLimite: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_limite']),
      estatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estatus']),
      esGrupo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}es_grupo']),
      creadoPorInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}creado_por_int']),
      creadoPor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creado_por']),
      cerradoPorInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cerrado_por_int']),
      cerradoPor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cerrado_por']),
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      descuento: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}descuento'])!,
      impuestos: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}impuestos'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      comentarios: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comentarios']),
      cotizacionInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cotizacion_int']),
      cotizacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cotizacion']),
    );
  }

  @override
  $CotizacionTableTable createAlias(String alias) {
    return $CotizacionTableTable(attachedDatabase, alias);
  }
}

class CotizacionTableData extends DataClass
    implements Insertable<CotizacionTableData> {
  final int idInt;
  final String? id;
  final String? folio;
  final int? clienteInt;
  final String? cliente;
  final DateTime? createdAt;
  final DateTime? fechaLimite;
  final String? estatus;
  final bool? esGrupo;
  final int? creadoPorInt;
  final String? creadoPor;
  final int? cerradoPorInt;
  final String? cerradoPor;
  final double subtotal;
  final double descuento;
  final double impuestos;
  final double total;
  final String? comentarios;
  final int? cotizacionInt;
  final String? cotizacion;
  const CotizacionTableData(
      {required this.idInt,
      this.id,
      this.folio,
      this.clienteInt,
      this.cliente,
      this.createdAt,
      this.fechaLimite,
      this.estatus,
      this.esGrupo,
      this.creadoPorInt,
      this.creadoPor,
      this.cerradoPorInt,
      this.cerradoPor,
      required this.subtotal,
      required this.descuento,
      required this.impuestos,
      required this.total,
      this.comentarios,
      this.cotizacionInt,
      this.cotizacion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || folio != null) {
      map['folio'] = Variable<String>(folio);
    }
    if (!nullToAbsent || clienteInt != null) {
      map['cliente_int'] = Variable<int>(clienteInt);
    }
    if (!nullToAbsent || cliente != null) {
      map['cliente'] = Variable<String>(cliente);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || fechaLimite != null) {
      map['fecha_limite'] = Variable<DateTime>(fechaLimite);
    }
    if (!nullToAbsent || estatus != null) {
      map['estatus'] = Variable<String>(estatus);
    }
    if (!nullToAbsent || esGrupo != null) {
      map['es_grupo'] = Variable<bool>(esGrupo);
    }
    if (!nullToAbsent || creadoPorInt != null) {
      map['creado_por_int'] = Variable<int>(creadoPorInt);
    }
    if (!nullToAbsent || creadoPor != null) {
      map['creado_por'] = Variable<String>(creadoPor);
    }
    if (!nullToAbsent || cerradoPorInt != null) {
      map['cerrado_por_int'] = Variable<int>(cerradoPorInt);
    }
    if (!nullToAbsent || cerradoPor != null) {
      map['cerrado_por'] = Variable<String>(cerradoPor);
    }
    map['subtotal'] = Variable<double>(subtotal);
    map['descuento'] = Variable<double>(descuento);
    map['impuestos'] = Variable<double>(impuestos);
    map['total'] = Variable<double>(total);
    if (!nullToAbsent || comentarios != null) {
      map['comentarios'] = Variable<String>(comentarios);
    }
    if (!nullToAbsent || cotizacionInt != null) {
      map['cotizacion_int'] = Variable<int>(cotizacionInt);
    }
    if (!nullToAbsent || cotizacion != null) {
      map['cotizacion'] = Variable<String>(cotizacion);
    }
    return map;
  }

  CotizacionTableCompanion toCompanion(bool nullToAbsent) {
    return CotizacionTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      folio:
          folio == null && nullToAbsent ? const Value.absent() : Value(folio),
      clienteInt: clienteInt == null && nullToAbsent
          ? const Value.absent()
          : Value(clienteInt),
      cliente: cliente == null && nullToAbsent
          ? const Value.absent()
          : Value(cliente),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      fechaLimite: fechaLimite == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaLimite),
      estatus: estatus == null && nullToAbsent
          ? const Value.absent()
          : Value(estatus),
      esGrupo: esGrupo == null && nullToAbsent
          ? const Value.absent()
          : Value(esGrupo),
      creadoPorInt: creadoPorInt == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPorInt),
      creadoPor: creadoPor == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPor),
      cerradoPorInt: cerradoPorInt == null && nullToAbsent
          ? const Value.absent()
          : Value(cerradoPorInt),
      cerradoPor: cerradoPor == null && nullToAbsent
          ? const Value.absent()
          : Value(cerradoPor),
      subtotal: Value(subtotal),
      descuento: Value(descuento),
      impuestos: Value(impuestos),
      total: Value(total),
      comentarios: comentarios == null && nullToAbsent
          ? const Value.absent()
          : Value(comentarios),
      cotizacionInt: cotizacionInt == null && nullToAbsent
          ? const Value.absent()
          : Value(cotizacionInt),
      cotizacion: cotizacion == null && nullToAbsent
          ? const Value.absent()
          : Value(cotizacion),
    );
  }

  factory CotizacionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CotizacionTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      folio: serializer.fromJson<String?>(json['folio']),
      clienteInt: serializer.fromJson<int?>(json['clienteInt']),
      cliente: serializer.fromJson<String?>(json['cliente']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      fechaLimite: serializer.fromJson<DateTime?>(json['fechaLimite']),
      estatus: serializer.fromJson<String?>(json['estatus']),
      esGrupo: serializer.fromJson<bool?>(json['esGrupo']),
      creadoPorInt: serializer.fromJson<int?>(json['creadoPorInt']),
      creadoPor: serializer.fromJson<String?>(json['creadoPor']),
      cerradoPorInt: serializer.fromJson<int?>(json['cerradoPorInt']),
      cerradoPor: serializer.fromJson<String?>(json['cerradoPor']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      descuento: serializer.fromJson<double>(json['descuento']),
      impuestos: serializer.fromJson<double>(json['impuestos']),
      total: serializer.fromJson<double>(json['total']),
      comentarios: serializer.fromJson<String?>(json['comentarios']),
      cotizacionInt: serializer.fromJson<int?>(json['cotizacionInt']),
      cotizacion: serializer.fromJson<String?>(json['cotizacion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'folio': serializer.toJson<String?>(folio),
      'clienteInt': serializer.toJson<int?>(clienteInt),
      'cliente': serializer.toJson<String?>(cliente),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'fechaLimite': serializer.toJson<DateTime?>(fechaLimite),
      'estatus': serializer.toJson<String?>(estatus),
      'esGrupo': serializer.toJson<bool?>(esGrupo),
      'creadoPorInt': serializer.toJson<int?>(creadoPorInt),
      'creadoPor': serializer.toJson<String?>(creadoPor),
      'cerradoPorInt': serializer.toJson<int?>(cerradoPorInt),
      'cerradoPor': serializer.toJson<String?>(cerradoPor),
      'subtotal': serializer.toJson<double>(subtotal),
      'descuento': serializer.toJson<double>(descuento),
      'impuestos': serializer.toJson<double>(impuestos),
      'total': serializer.toJson<double>(total),
      'comentarios': serializer.toJson<String?>(comentarios),
      'cotizacionInt': serializer.toJson<int?>(cotizacionInt),
      'cotizacion': serializer.toJson<String?>(cotizacion),
    };
  }

  CotizacionTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<String?> folio = const Value.absent(),
          Value<int?> clienteInt = const Value.absent(),
          Value<String?> cliente = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> fechaLimite = const Value.absent(),
          Value<String?> estatus = const Value.absent(),
          Value<bool?> esGrupo = const Value.absent(),
          Value<int?> creadoPorInt = const Value.absent(),
          Value<String?> creadoPor = const Value.absent(),
          Value<int?> cerradoPorInt = const Value.absent(),
          Value<String?> cerradoPor = const Value.absent(),
          double? subtotal,
          double? descuento,
          double? impuestos,
          double? total,
          Value<String?> comentarios = const Value.absent(),
          Value<int?> cotizacionInt = const Value.absent(),
          Value<String?> cotizacion = const Value.absent()}) =>
      CotizacionTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        folio: folio.present ? folio.value : this.folio,
        clienteInt: clienteInt.present ? clienteInt.value : this.clienteInt,
        cliente: cliente.present ? cliente.value : this.cliente,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        fechaLimite: fechaLimite.present ? fechaLimite.value : this.fechaLimite,
        estatus: estatus.present ? estatus.value : this.estatus,
        esGrupo: esGrupo.present ? esGrupo.value : this.esGrupo,
        creadoPorInt:
            creadoPorInt.present ? creadoPorInt.value : this.creadoPorInt,
        creadoPor: creadoPor.present ? creadoPor.value : this.creadoPor,
        cerradoPorInt:
            cerradoPorInt.present ? cerradoPorInt.value : this.cerradoPorInt,
        cerradoPor: cerradoPor.present ? cerradoPor.value : this.cerradoPor,
        subtotal: subtotal ?? this.subtotal,
        descuento: descuento ?? this.descuento,
        impuestos: impuestos ?? this.impuestos,
        total: total ?? this.total,
        comentarios: comentarios.present ? comentarios.value : this.comentarios,
        cotizacionInt:
            cotizacionInt.present ? cotizacionInt.value : this.cotizacionInt,
        cotizacion: cotizacion.present ? cotizacion.value : this.cotizacion,
      );
  CotizacionTableData copyWithCompanion(CotizacionTableCompanion data) {
    return CotizacionTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      folio: data.folio.present ? data.folio.value : this.folio,
      clienteInt:
          data.clienteInt.present ? data.clienteInt.value : this.clienteInt,
      cliente: data.cliente.present ? data.cliente.value : this.cliente,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      fechaLimite:
          data.fechaLimite.present ? data.fechaLimite.value : this.fechaLimite,
      estatus: data.estatus.present ? data.estatus.value : this.estatus,
      esGrupo: data.esGrupo.present ? data.esGrupo.value : this.esGrupo,
      creadoPorInt: data.creadoPorInt.present
          ? data.creadoPorInt.value
          : this.creadoPorInt,
      creadoPor: data.creadoPor.present ? data.creadoPor.value : this.creadoPor,
      cerradoPorInt: data.cerradoPorInt.present
          ? data.cerradoPorInt.value
          : this.cerradoPorInt,
      cerradoPor:
          data.cerradoPor.present ? data.cerradoPor.value : this.cerradoPor,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      descuento: data.descuento.present ? data.descuento.value : this.descuento,
      impuestos: data.impuestos.present ? data.impuestos.value : this.impuestos,
      total: data.total.present ? data.total.value : this.total,
      comentarios:
          data.comentarios.present ? data.comentarios.value : this.comentarios,
      cotizacionInt: data.cotizacionInt.present
          ? data.cotizacionInt.value
          : this.cotizacionInt,
      cotizacion:
          data.cotizacion.present ? data.cotizacion.value : this.cotizacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CotizacionTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('folio: $folio, ')
          ..write('clienteInt: $clienteInt, ')
          ..write('cliente: $cliente, ')
          ..write('createdAt: $createdAt, ')
          ..write('fechaLimite: $fechaLimite, ')
          ..write('estatus: $estatus, ')
          ..write('esGrupo: $esGrupo, ')
          ..write('creadoPorInt: $creadoPorInt, ')
          ..write('creadoPor: $creadoPor, ')
          ..write('cerradoPorInt: $cerradoPorInt, ')
          ..write('cerradoPor: $cerradoPor, ')
          ..write('subtotal: $subtotal, ')
          ..write('descuento: $descuento, ')
          ..write('impuestos: $impuestos, ')
          ..write('total: $total, ')
          ..write('comentarios: $comentarios, ')
          ..write('cotizacionInt: $cotizacionInt, ')
          ..write('cotizacion: $cotizacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      idInt,
      id,
      folio,
      clienteInt,
      cliente,
      createdAt,
      fechaLimite,
      estatus,
      esGrupo,
      creadoPorInt,
      creadoPor,
      cerradoPorInt,
      cerradoPor,
      subtotal,
      descuento,
      impuestos,
      total,
      comentarios,
      cotizacionInt,
      cotizacion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CotizacionTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.folio == this.folio &&
          other.clienteInt == this.clienteInt &&
          other.cliente == this.cliente &&
          other.createdAt == this.createdAt &&
          other.fechaLimite == this.fechaLimite &&
          other.estatus == this.estatus &&
          other.esGrupo == this.esGrupo &&
          other.creadoPorInt == this.creadoPorInt &&
          other.creadoPor == this.creadoPor &&
          other.cerradoPorInt == this.cerradoPorInt &&
          other.cerradoPor == this.cerradoPor &&
          other.subtotal == this.subtotal &&
          other.descuento == this.descuento &&
          other.impuestos == this.impuestos &&
          other.total == this.total &&
          other.comentarios == this.comentarios &&
          other.cotizacionInt == this.cotizacionInt &&
          other.cotizacion == this.cotizacion);
}

class CotizacionTableCompanion extends UpdateCompanion<CotizacionTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<String?> folio;
  final Value<int?> clienteInt;
  final Value<String?> cliente;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> fechaLimite;
  final Value<String?> estatus;
  final Value<bool?> esGrupo;
  final Value<int?> creadoPorInt;
  final Value<String?> creadoPor;
  final Value<int?> cerradoPorInt;
  final Value<String?> cerradoPor;
  final Value<double> subtotal;
  final Value<double> descuento;
  final Value<double> impuestos;
  final Value<double> total;
  final Value<String?> comentarios;
  final Value<int?> cotizacionInt;
  final Value<String?> cotizacion;
  const CotizacionTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.folio = const Value.absent(),
    this.clienteInt = const Value.absent(),
    this.cliente = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.fechaLimite = const Value.absent(),
    this.estatus = const Value.absent(),
    this.esGrupo = const Value.absent(),
    this.creadoPorInt = const Value.absent(),
    this.creadoPor = const Value.absent(),
    this.cerradoPorInt = const Value.absent(),
    this.cerradoPor = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.descuento = const Value.absent(),
    this.impuestos = const Value.absent(),
    this.total = const Value.absent(),
    this.comentarios = const Value.absent(),
    this.cotizacionInt = const Value.absent(),
    this.cotizacion = const Value.absent(),
  });
  CotizacionTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.folio = const Value.absent(),
    this.clienteInt = const Value.absent(),
    this.cliente = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.fechaLimite = const Value.absent(),
    this.estatus = const Value.absent(),
    this.esGrupo = const Value.absent(),
    this.creadoPorInt = const Value.absent(),
    this.creadoPor = const Value.absent(),
    this.cerradoPorInt = const Value.absent(),
    this.cerradoPor = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.descuento = const Value.absent(),
    this.impuestos = const Value.absent(),
    this.total = const Value.absent(),
    this.comentarios = const Value.absent(),
    this.cotizacionInt = const Value.absent(),
    this.cotizacion = const Value.absent(),
  });
  static Insertable<CotizacionTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<String>? folio,
    Expression<int>? clienteInt,
    Expression<String>? cliente,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? fechaLimite,
    Expression<String>? estatus,
    Expression<bool>? esGrupo,
    Expression<int>? creadoPorInt,
    Expression<String>? creadoPor,
    Expression<int>? cerradoPorInt,
    Expression<String>? cerradoPor,
    Expression<double>? subtotal,
    Expression<double>? descuento,
    Expression<double>? impuestos,
    Expression<double>? total,
    Expression<String>? comentarios,
    Expression<int>? cotizacionInt,
    Expression<String>? cotizacion,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (folio != null) 'folio': folio,
      if (clienteInt != null) 'cliente_int': clienteInt,
      if (cliente != null) 'cliente': cliente,
      if (createdAt != null) 'created_at': createdAt,
      if (fechaLimite != null) 'fecha_limite': fechaLimite,
      if (estatus != null) 'estatus': estatus,
      if (esGrupo != null) 'es_grupo': esGrupo,
      if (creadoPorInt != null) 'creado_por_int': creadoPorInt,
      if (creadoPor != null) 'creado_por': creadoPor,
      if (cerradoPorInt != null) 'cerrado_por_int': cerradoPorInt,
      if (cerradoPor != null) 'cerrado_por': cerradoPor,
      if (subtotal != null) 'subtotal': subtotal,
      if (descuento != null) 'descuento': descuento,
      if (impuestos != null) 'impuestos': impuestos,
      if (total != null) 'total': total,
      if (comentarios != null) 'comentarios': comentarios,
      if (cotizacionInt != null) 'cotizacion_int': cotizacionInt,
      if (cotizacion != null) 'cotizacion': cotizacion,
    });
  }

  CotizacionTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<String?>? folio,
      Value<int?>? clienteInt,
      Value<String?>? cliente,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? fechaLimite,
      Value<String?>? estatus,
      Value<bool?>? esGrupo,
      Value<int?>? creadoPorInt,
      Value<String?>? creadoPor,
      Value<int?>? cerradoPorInt,
      Value<String?>? cerradoPor,
      Value<double>? subtotal,
      Value<double>? descuento,
      Value<double>? impuestos,
      Value<double>? total,
      Value<String?>? comentarios,
      Value<int?>? cotizacionInt,
      Value<String?>? cotizacion}) {
    return CotizacionTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      folio: folio ?? this.folio,
      clienteInt: clienteInt ?? this.clienteInt,
      cliente: cliente ?? this.cliente,
      createdAt: createdAt ?? this.createdAt,
      fechaLimite: fechaLimite ?? this.fechaLimite,
      estatus: estatus ?? this.estatus,
      esGrupo: esGrupo ?? this.esGrupo,
      creadoPorInt: creadoPorInt ?? this.creadoPorInt,
      creadoPor: creadoPor ?? this.creadoPor,
      cerradoPorInt: cerradoPorInt ?? this.cerradoPorInt,
      cerradoPor: cerradoPor ?? this.cerradoPor,
      subtotal: subtotal ?? this.subtotal,
      descuento: descuento ?? this.descuento,
      impuestos: impuestos ?? this.impuestos,
      total: total ?? this.total,
      comentarios: comentarios ?? this.comentarios,
      cotizacionInt: cotizacionInt ?? this.cotizacionInt,
      cotizacion: cotizacion ?? this.cotizacion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (folio.present) {
      map['folio'] = Variable<String>(folio.value);
    }
    if (clienteInt.present) {
      map['cliente_int'] = Variable<int>(clienteInt.value);
    }
    if (cliente.present) {
      map['cliente'] = Variable<String>(cliente.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (fechaLimite.present) {
      map['fecha_limite'] = Variable<DateTime>(fechaLimite.value);
    }
    if (estatus.present) {
      map['estatus'] = Variable<String>(estatus.value);
    }
    if (esGrupo.present) {
      map['es_grupo'] = Variable<bool>(esGrupo.value);
    }
    if (creadoPorInt.present) {
      map['creado_por_int'] = Variable<int>(creadoPorInt.value);
    }
    if (creadoPor.present) {
      map['creado_por'] = Variable<String>(creadoPor.value);
    }
    if (cerradoPorInt.present) {
      map['cerrado_por_int'] = Variable<int>(cerradoPorInt.value);
    }
    if (cerradoPor.present) {
      map['cerrado_por'] = Variable<String>(cerradoPor.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (descuento.present) {
      map['descuento'] = Variable<double>(descuento.value);
    }
    if (impuestos.present) {
      map['impuestos'] = Variable<double>(impuestos.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (comentarios.present) {
      map['comentarios'] = Variable<String>(comentarios.value);
    }
    if (cotizacionInt.present) {
      map['cotizacion_int'] = Variable<int>(cotizacionInt.value);
    }
    if (cotizacion.present) {
      map['cotizacion'] = Variable<String>(cotizacion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CotizacionTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('folio: $folio, ')
          ..write('clienteInt: $clienteInt, ')
          ..write('cliente: $cliente, ')
          ..write('createdAt: $createdAt, ')
          ..write('fechaLimite: $fechaLimite, ')
          ..write('estatus: $estatus, ')
          ..write('esGrupo: $esGrupo, ')
          ..write('creadoPorInt: $creadoPorInt, ')
          ..write('creadoPor: $creadoPor, ')
          ..write('cerradoPorInt: $cerradoPorInt, ')
          ..write('cerradoPor: $cerradoPor, ')
          ..write('subtotal: $subtotal, ')
          ..write('descuento: $descuento, ')
          ..write('impuestos: $impuestos, ')
          ..write('total: $total, ')
          ..write('comentarios: $comentarios, ')
          ..write('cotizacionInt: $cotizacionInt, ')
          ..write('cotizacion: $cotizacion')
          ..write(')'))
        .toString();
  }
}

class $HabitacionTableTable extends HabitacionTable
    with TableInfo<$HabitacionTableTable, HabitacionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitacionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _cotizacionIntMeta =
      const VerificationMeta('cotizacionInt');
  @override
  late final GeneratedColumn<int> cotizacionInt = GeneratedColumn<int>(
      'cotizacion_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES cotizacion_table (id)'));
  static const VerificationMeta _cotizacionMeta =
      const VerificationMeta('cotizacion');
  @override
  late final GeneratedColumn<String> cotizacion = GeneratedColumn<String>(
      'cotizacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _checkInMeta =
      const VerificationMeta('checkIn');
  @override
  late final GeneratedColumn<DateTime> checkIn = GeneratedColumn<DateTime>(
      'check_in', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _checkOutMeta =
      const VerificationMeta('checkOut');
  @override
  late final GeneratedColumn<DateTime> checkOut = GeneratedColumn<DateTime>(
      'check_out', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _adultosMeta =
      const VerificationMeta('adultos');
  @override
  late final GeneratedColumn<int> adultos = GeneratedColumn<int>(
      'adultos', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _menores0a6Meta =
      const VerificationMeta('menores0a6');
  @override
  late final GeneratedColumn<int> menores0a6 = GeneratedColumn<int>(
      'menores0a6', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _menores7a12Meta =
      const VerificationMeta('menores7a12');
  @override
  late final GeneratedColumn<int> menores7a12 = GeneratedColumn<int>(
      'menores7a12', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _paxAdicMeta =
      const VerificationMeta('paxAdic');
  @override
  late final GeneratedColumn<int> paxAdic = GeneratedColumn<int>(
      'pax_adic', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _esCortesiaMeta =
      const VerificationMeta('esCortesia');
  @override
  late final GeneratedColumn<bool> esCortesia = GeneratedColumn<bool>(
      'es_cortesia', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("es_cortesia" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        createdAt,
        cotizacionInt,
        cotizacion,
        checkIn,
        checkOut,
        adultos,
        menores0a6,
        menores7a12,
        paxAdic,
        count,
        esCortesia
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habitacion_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<HabitacionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('cotizacion_int')) {
      context.handle(
          _cotizacionIntMeta,
          cotizacionInt.isAcceptableOrUnknown(
              data['cotizacion_int']!, _cotizacionIntMeta));
    }
    if (data.containsKey('cotizacion')) {
      context.handle(
          _cotizacionMeta,
          cotizacion.isAcceptableOrUnknown(
              data['cotizacion']!, _cotizacionMeta));
    }
    if (data.containsKey('check_in')) {
      context.handle(_checkInMeta,
          checkIn.isAcceptableOrUnknown(data['check_in']!, _checkInMeta));
    }
    if (data.containsKey('check_out')) {
      context.handle(_checkOutMeta,
          checkOut.isAcceptableOrUnknown(data['check_out']!, _checkOutMeta));
    }
    if (data.containsKey('adultos')) {
      context.handle(_adultosMeta,
          adultos.isAcceptableOrUnknown(data['adultos']!, _adultosMeta));
    }
    if (data.containsKey('menores0a6')) {
      context.handle(
          _menores0a6Meta,
          menores0a6.isAcceptableOrUnknown(
              data['menores0a6']!, _menores0a6Meta));
    }
    if (data.containsKey('menores7a12')) {
      context.handle(
          _menores7a12Meta,
          menores7a12.isAcceptableOrUnknown(
              data['menores7a12']!, _menores7a12Meta));
    }
    if (data.containsKey('pax_adic')) {
      context.handle(_paxAdicMeta,
          paxAdic.isAcceptableOrUnknown(data['pax_adic']!, _paxAdicMeta));
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    }
    if (data.containsKey('es_cortesia')) {
      context.handle(
          _esCortesiaMeta,
          esCortesia.isAcceptableOrUnknown(
              data['es_cortesia']!, _esCortesiaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  HabitacionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitacionTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      cotizacionInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cotizacion_int']),
      cotizacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cotizacion']),
      checkIn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}check_in']),
      checkOut: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}check_out']),
      adultos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}adultos']),
      menores0a6: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}menores0a6']),
      menores7a12: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}menores7a12']),
      paxAdic: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pax_adic']),
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count']),
      esCortesia: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}es_cortesia']),
    );
  }

  @override
  $HabitacionTableTable createAlias(String alias) {
    return $HabitacionTableTable(attachedDatabase, alias);
  }
}

class HabitacionTableData extends DataClass
    implements Insertable<HabitacionTableData> {
  final int idInt;
  final String? id;
  final DateTime? createdAt;
  final int? cotizacionInt;
  final String? cotizacion;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int? adultos;
  final int? menores0a6;
  final int? menores7a12;
  final int? paxAdic;
  final int? count;
  final bool? esCortesia;
  const HabitacionTableData(
      {required this.idInt,
      this.id,
      this.createdAt,
      this.cotizacionInt,
      this.cotizacion,
      this.checkIn,
      this.checkOut,
      this.adultos,
      this.menores0a6,
      this.menores7a12,
      this.paxAdic,
      this.count,
      this.esCortesia});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || cotizacionInt != null) {
      map['cotizacion_int'] = Variable<int>(cotizacionInt);
    }
    if (!nullToAbsent || cotizacion != null) {
      map['cotizacion'] = Variable<String>(cotizacion);
    }
    if (!nullToAbsent || checkIn != null) {
      map['check_in'] = Variable<DateTime>(checkIn);
    }
    if (!nullToAbsent || checkOut != null) {
      map['check_out'] = Variable<DateTime>(checkOut);
    }
    if (!nullToAbsent || adultos != null) {
      map['adultos'] = Variable<int>(adultos);
    }
    if (!nullToAbsent || menores0a6 != null) {
      map['menores0a6'] = Variable<int>(menores0a6);
    }
    if (!nullToAbsent || menores7a12 != null) {
      map['menores7a12'] = Variable<int>(menores7a12);
    }
    if (!nullToAbsent || paxAdic != null) {
      map['pax_adic'] = Variable<int>(paxAdic);
    }
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int>(count);
    }
    if (!nullToAbsent || esCortesia != null) {
      map['es_cortesia'] = Variable<bool>(esCortesia);
    }
    return map;
  }

  HabitacionTableCompanion toCompanion(bool nullToAbsent) {
    return HabitacionTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      cotizacionInt: cotizacionInt == null && nullToAbsent
          ? const Value.absent()
          : Value(cotizacionInt),
      cotizacion: cotizacion == null && nullToAbsent
          ? const Value.absent()
          : Value(cotizacion),
      checkIn: checkIn == null && nullToAbsent
          ? const Value.absent()
          : Value(checkIn),
      checkOut: checkOut == null && nullToAbsent
          ? const Value.absent()
          : Value(checkOut),
      adultos: adultos == null && nullToAbsent
          ? const Value.absent()
          : Value(adultos),
      menores0a6: menores0a6 == null && nullToAbsent
          ? const Value.absent()
          : Value(menores0a6),
      menores7a12: menores7a12 == null && nullToAbsent
          ? const Value.absent()
          : Value(menores7a12),
      paxAdic: paxAdic == null && nullToAbsent
          ? const Value.absent()
          : Value(paxAdic),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      esCortesia: esCortesia == null && nullToAbsent
          ? const Value.absent()
          : Value(esCortesia),
    );
  }

  factory HabitacionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitacionTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      cotizacionInt: serializer.fromJson<int?>(json['cotizacionInt']),
      cotizacion: serializer.fromJson<String?>(json['cotizacion']),
      checkIn: serializer.fromJson<DateTime?>(json['checkIn']),
      checkOut: serializer.fromJson<DateTime?>(json['checkOut']),
      adultos: serializer.fromJson<int?>(json['adultos']),
      menores0a6: serializer.fromJson<int?>(json['menores0a6']),
      menores7a12: serializer.fromJson<int?>(json['menores7a12']),
      paxAdic: serializer.fromJson<int?>(json['paxAdic']),
      count: serializer.fromJson<int?>(json['count']),
      esCortesia: serializer.fromJson<bool?>(json['esCortesia']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'cotizacionInt': serializer.toJson<int?>(cotizacionInt),
      'cotizacion': serializer.toJson<String?>(cotizacion),
      'checkIn': serializer.toJson<DateTime?>(checkIn),
      'checkOut': serializer.toJson<DateTime?>(checkOut),
      'adultos': serializer.toJson<int?>(adultos),
      'menores0a6': serializer.toJson<int?>(menores0a6),
      'menores7a12': serializer.toJson<int?>(menores7a12),
      'paxAdic': serializer.toJson<int?>(paxAdic),
      'count': serializer.toJson<int?>(count),
      'esCortesia': serializer.toJson<bool?>(esCortesia),
    };
  }

  HabitacionTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<int?> cotizacionInt = const Value.absent(),
          Value<String?> cotizacion = const Value.absent(),
          Value<DateTime?> checkIn = const Value.absent(),
          Value<DateTime?> checkOut = const Value.absent(),
          Value<int?> adultos = const Value.absent(),
          Value<int?> menores0a6 = const Value.absent(),
          Value<int?> menores7a12 = const Value.absent(),
          Value<int?> paxAdic = const Value.absent(),
          Value<int?> count = const Value.absent(),
          Value<bool?> esCortesia = const Value.absent()}) =>
      HabitacionTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        cotizacionInt:
            cotizacionInt.present ? cotizacionInt.value : this.cotizacionInt,
        cotizacion: cotizacion.present ? cotizacion.value : this.cotizacion,
        checkIn: checkIn.present ? checkIn.value : this.checkIn,
        checkOut: checkOut.present ? checkOut.value : this.checkOut,
        adultos: adultos.present ? adultos.value : this.adultos,
        menores0a6: menores0a6.present ? menores0a6.value : this.menores0a6,
        menores7a12: menores7a12.present ? menores7a12.value : this.menores7a12,
        paxAdic: paxAdic.present ? paxAdic.value : this.paxAdic,
        count: count.present ? count.value : this.count,
        esCortesia: esCortesia.present ? esCortesia.value : this.esCortesia,
      );
  HabitacionTableData copyWithCompanion(HabitacionTableCompanion data) {
    return HabitacionTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      cotizacionInt: data.cotizacionInt.present
          ? data.cotizacionInt.value
          : this.cotizacionInt,
      cotizacion:
          data.cotizacion.present ? data.cotizacion.value : this.cotizacion,
      checkIn: data.checkIn.present ? data.checkIn.value : this.checkIn,
      checkOut: data.checkOut.present ? data.checkOut.value : this.checkOut,
      adultos: data.adultos.present ? data.adultos.value : this.adultos,
      menores0a6:
          data.menores0a6.present ? data.menores0a6.value : this.menores0a6,
      menores7a12:
          data.menores7a12.present ? data.menores7a12.value : this.menores7a12,
      paxAdic: data.paxAdic.present ? data.paxAdic.value : this.paxAdic,
      count: data.count.present ? data.count.value : this.count,
      esCortesia:
          data.esCortesia.present ? data.esCortesia.value : this.esCortesia,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitacionTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('cotizacionInt: $cotizacionInt, ')
          ..write('cotizacion: $cotizacion, ')
          ..write('checkIn: $checkIn, ')
          ..write('checkOut: $checkOut, ')
          ..write('adultos: $adultos, ')
          ..write('menores0a6: $menores0a6, ')
          ..write('menores7a12: $menores7a12, ')
          ..write('paxAdic: $paxAdic, ')
          ..write('count: $count, ')
          ..write('esCortesia: $esCortesia')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      idInt,
      id,
      createdAt,
      cotizacionInt,
      cotizacion,
      checkIn,
      checkOut,
      adultos,
      menores0a6,
      menores7a12,
      paxAdic,
      count,
      esCortesia);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitacionTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.cotizacionInt == this.cotizacionInt &&
          other.cotizacion == this.cotizacion &&
          other.checkIn == this.checkIn &&
          other.checkOut == this.checkOut &&
          other.adultos == this.adultos &&
          other.menores0a6 == this.menores0a6 &&
          other.menores7a12 == this.menores7a12 &&
          other.paxAdic == this.paxAdic &&
          other.count == this.count &&
          other.esCortesia == this.esCortesia);
}

class HabitacionTableCompanion extends UpdateCompanion<HabitacionTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<DateTime?> createdAt;
  final Value<int?> cotizacionInt;
  final Value<String?> cotizacion;
  final Value<DateTime?> checkIn;
  final Value<DateTime?> checkOut;
  final Value<int?> adultos;
  final Value<int?> menores0a6;
  final Value<int?> menores7a12;
  final Value<int?> paxAdic;
  final Value<int?> count;
  final Value<bool?> esCortesia;
  const HabitacionTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.cotizacionInt = const Value.absent(),
    this.cotizacion = const Value.absent(),
    this.checkIn = const Value.absent(),
    this.checkOut = const Value.absent(),
    this.adultos = const Value.absent(),
    this.menores0a6 = const Value.absent(),
    this.menores7a12 = const Value.absent(),
    this.paxAdic = const Value.absent(),
    this.count = const Value.absent(),
    this.esCortesia = const Value.absent(),
  });
  HabitacionTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.cotizacionInt = const Value.absent(),
    this.cotizacion = const Value.absent(),
    this.checkIn = const Value.absent(),
    this.checkOut = const Value.absent(),
    this.adultos = const Value.absent(),
    this.menores0a6 = const Value.absent(),
    this.menores7a12 = const Value.absent(),
    this.paxAdic = const Value.absent(),
    this.count = const Value.absent(),
    this.esCortesia = const Value.absent(),
  });
  static Insertable<HabitacionTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<int>? cotizacionInt,
    Expression<String>? cotizacion,
    Expression<DateTime>? checkIn,
    Expression<DateTime>? checkOut,
    Expression<int>? adultos,
    Expression<int>? menores0a6,
    Expression<int>? menores7a12,
    Expression<int>? paxAdic,
    Expression<int>? count,
    Expression<bool>? esCortesia,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (cotizacionInt != null) 'cotizacion_int': cotizacionInt,
      if (cotizacion != null) 'cotizacion': cotizacion,
      if (checkIn != null) 'check_in': checkIn,
      if (checkOut != null) 'check_out': checkOut,
      if (adultos != null) 'adultos': adultos,
      if (menores0a6 != null) 'menores0a6': menores0a6,
      if (menores7a12 != null) 'menores7a12': menores7a12,
      if (paxAdic != null) 'pax_adic': paxAdic,
      if (count != null) 'count': count,
      if (esCortesia != null) 'es_cortesia': esCortesia,
    });
  }

  HabitacionTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<DateTime?>? createdAt,
      Value<int?>? cotizacionInt,
      Value<String?>? cotizacion,
      Value<DateTime?>? checkIn,
      Value<DateTime?>? checkOut,
      Value<int?>? adultos,
      Value<int?>? menores0a6,
      Value<int?>? menores7a12,
      Value<int?>? paxAdic,
      Value<int?>? count,
      Value<bool?>? esCortesia}) {
    return HabitacionTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      cotizacionInt: cotizacionInt ?? this.cotizacionInt,
      cotizacion: cotizacion ?? this.cotizacion,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      adultos: adultos ?? this.adultos,
      menores0a6: menores0a6 ?? this.menores0a6,
      menores7a12: menores7a12 ?? this.menores7a12,
      paxAdic: paxAdic ?? this.paxAdic,
      count: count ?? this.count,
      esCortesia: esCortesia ?? this.esCortesia,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (cotizacionInt.present) {
      map['cotizacion_int'] = Variable<int>(cotizacionInt.value);
    }
    if (cotizacion.present) {
      map['cotizacion'] = Variable<String>(cotizacion.value);
    }
    if (checkIn.present) {
      map['check_in'] = Variable<DateTime>(checkIn.value);
    }
    if (checkOut.present) {
      map['check_out'] = Variable<DateTime>(checkOut.value);
    }
    if (adultos.present) {
      map['adultos'] = Variable<int>(adultos.value);
    }
    if (menores0a6.present) {
      map['menores0a6'] = Variable<int>(menores0a6.value);
    }
    if (menores7a12.present) {
      map['menores7a12'] = Variable<int>(menores7a12.value);
    }
    if (paxAdic.present) {
      map['pax_adic'] = Variable<int>(paxAdic.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (esCortesia.present) {
      map['es_cortesia'] = Variable<bool>(esCortesia.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitacionTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('cotizacionInt: $cotizacionInt, ')
          ..write('cotizacion: $cotizacion, ')
          ..write('checkIn: $checkIn, ')
          ..write('checkOut: $checkOut, ')
          ..write('adultos: $adultos, ')
          ..write('menores0a6: $menores0a6, ')
          ..write('menores7a12: $menores7a12, ')
          ..write('paxAdic: $paxAdic, ')
          ..write('count: $count, ')
          ..write('esCortesia: $esCortesia')
          ..write(')'))
        .toString();
  }
}

class $NotificacionTableTable extends NotificacionTable
    with TableInfo<$NotificacionTableTable, NotificacionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificacionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _mensajeMeta =
      const VerificationMeta('mensaje');
  @override
  late final GeneratedColumn<String> mensaje = GeneratedColumn<String>(
      'mensaje', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rutaMeta = const VerificationMeta('ruta');
  @override
  late final GeneratedColumn<int> ruta = GeneratedColumn<int>(
      'ruta', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _usuarioIntMeta =
      const VerificationMeta('usuarioInt');
  @override
  late final GeneratedColumn<int> usuarioInt = GeneratedColumn<int>(
      'usuario_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario_table (id)'));
  static const VerificationMeta _usuarioMeta =
      const VerificationMeta('usuario');
  @override
  late final GeneratedColumn<String> usuario = GeneratedColumn<String>(
      'usuario', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [idInt, id, createdAt, mensaje, tipo, ruta, usuarioInt, usuario];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notificacion_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<NotificacionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('mensaje')) {
      context.handle(_mensajeMeta,
          mensaje.isAcceptableOrUnknown(data['mensaje']!, _mensajeMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    }
    if (data.containsKey('ruta')) {
      context.handle(
          _rutaMeta, ruta.isAcceptableOrUnknown(data['ruta']!, _rutaMeta));
    }
    if (data.containsKey('usuario_int')) {
      context.handle(
          _usuarioIntMeta,
          usuarioInt.isAcceptableOrUnknown(
              data['usuario_int']!, _usuarioIntMeta));
    }
    if (data.containsKey('usuario')) {
      context.handle(_usuarioMeta,
          usuario.isAcceptableOrUnknown(data['usuario']!, _usuarioMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  NotificacionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificacionTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      mensaje: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mensaje']),
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo']),
      ruta: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ruta']),
      usuarioInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usuario_int']),
      usuario: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}usuario']),
    );
  }

  @override
  $NotificacionTableTable createAlias(String alias) {
    return $NotificacionTableTable(attachedDatabase, alias);
  }
}

class NotificacionTableData extends DataClass
    implements Insertable<NotificacionTableData> {
  final int idInt;
  final String? id;
  final DateTime? createdAt;
  final String? mensaje;
  final String? tipo;
  final int? ruta;
  final int? usuarioInt;
  final String? usuario;
  const NotificacionTableData(
      {required this.idInt,
      this.id,
      this.createdAt,
      this.mensaje,
      this.tipo,
      this.ruta,
      this.usuarioInt,
      this.usuario});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || mensaje != null) {
      map['mensaje'] = Variable<String>(mensaje);
    }
    if (!nullToAbsent || tipo != null) {
      map['tipo'] = Variable<String>(tipo);
    }
    if (!nullToAbsent || ruta != null) {
      map['ruta'] = Variable<int>(ruta);
    }
    if (!nullToAbsent || usuarioInt != null) {
      map['usuario_int'] = Variable<int>(usuarioInt);
    }
    if (!nullToAbsent || usuario != null) {
      map['usuario'] = Variable<String>(usuario);
    }
    return map;
  }

  NotificacionTableCompanion toCompanion(bool nullToAbsent) {
    return NotificacionTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      mensaje: mensaje == null && nullToAbsent
          ? const Value.absent()
          : Value(mensaje),
      tipo: tipo == null && nullToAbsent ? const Value.absent() : Value(tipo),
      ruta: ruta == null && nullToAbsent ? const Value.absent() : Value(ruta),
      usuarioInt: usuarioInt == null && nullToAbsent
          ? const Value.absent()
          : Value(usuarioInt),
      usuario: usuario == null && nullToAbsent
          ? const Value.absent()
          : Value(usuario),
    );
  }

  factory NotificacionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificacionTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      mensaje: serializer.fromJson<String?>(json['mensaje']),
      tipo: serializer.fromJson<String?>(json['tipo']),
      ruta: serializer.fromJson<int?>(json['ruta']),
      usuarioInt: serializer.fromJson<int?>(json['usuarioInt']),
      usuario: serializer.fromJson<String?>(json['usuario']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'mensaje': serializer.toJson<String?>(mensaje),
      'tipo': serializer.toJson<String?>(tipo),
      'ruta': serializer.toJson<int?>(ruta),
      'usuarioInt': serializer.toJson<int?>(usuarioInt),
      'usuario': serializer.toJson<String?>(usuario),
    };
  }

  NotificacionTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<String?> mensaje = const Value.absent(),
          Value<String?> tipo = const Value.absent(),
          Value<int?> ruta = const Value.absent(),
          Value<int?> usuarioInt = const Value.absent(),
          Value<String?> usuario = const Value.absent()}) =>
      NotificacionTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        mensaje: mensaje.present ? mensaje.value : this.mensaje,
        tipo: tipo.present ? tipo.value : this.tipo,
        ruta: ruta.present ? ruta.value : this.ruta,
        usuarioInt: usuarioInt.present ? usuarioInt.value : this.usuarioInt,
        usuario: usuario.present ? usuario.value : this.usuario,
      );
  NotificacionTableData copyWithCompanion(NotificacionTableCompanion data) {
    return NotificacionTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      mensaje: data.mensaje.present ? data.mensaje.value : this.mensaje,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      ruta: data.ruta.present ? data.ruta.value : this.ruta,
      usuarioInt:
          data.usuarioInt.present ? data.usuarioInt.value : this.usuarioInt,
      usuario: data.usuario.present ? data.usuario.value : this.usuario,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificacionTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('mensaje: $mensaje, ')
          ..write('tipo: $tipo, ')
          ..write('ruta: $ruta, ')
          ..write('usuarioInt: $usuarioInt, ')
          ..write('usuario: $usuario')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      idInt, id, createdAt, mensaje, tipo, ruta, usuarioInt, usuario);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificacionTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.mensaje == this.mensaje &&
          other.tipo == this.tipo &&
          other.ruta == this.ruta &&
          other.usuarioInt == this.usuarioInt &&
          other.usuario == this.usuario);
}

class NotificacionTableCompanion
    extends UpdateCompanion<NotificacionTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<DateTime?> createdAt;
  final Value<String?> mensaje;
  final Value<String?> tipo;
  final Value<int?> ruta;
  final Value<int?> usuarioInt;
  final Value<String?> usuario;
  const NotificacionTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.mensaje = const Value.absent(),
    this.tipo = const Value.absent(),
    this.ruta = const Value.absent(),
    this.usuarioInt = const Value.absent(),
    this.usuario = const Value.absent(),
  });
  NotificacionTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.mensaje = const Value.absent(),
    this.tipo = const Value.absent(),
    this.ruta = const Value.absent(),
    this.usuarioInt = const Value.absent(),
    this.usuario = const Value.absent(),
  });
  static Insertable<NotificacionTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? mensaje,
    Expression<String>? tipo,
    Expression<int>? ruta,
    Expression<int>? usuarioInt,
    Expression<String>? usuario,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (mensaje != null) 'mensaje': mensaje,
      if (tipo != null) 'tipo': tipo,
      if (ruta != null) 'ruta': ruta,
      if (usuarioInt != null) 'usuario_int': usuarioInt,
      if (usuario != null) 'usuario': usuario,
    });
  }

  NotificacionTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<DateTime?>? createdAt,
      Value<String?>? mensaje,
      Value<String?>? tipo,
      Value<int?>? ruta,
      Value<int?>? usuarioInt,
      Value<String?>? usuario}) {
    return NotificacionTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      mensaje: mensaje ?? this.mensaje,
      tipo: tipo ?? this.tipo,
      ruta: ruta ?? this.ruta,
      usuarioInt: usuarioInt ?? this.usuarioInt,
      usuario: usuario ?? this.usuario,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (mensaje.present) {
      map['mensaje'] = Variable<String>(mensaje.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (ruta.present) {
      map['ruta'] = Variable<int>(ruta.value);
    }
    if (usuarioInt.present) {
      map['usuario_int'] = Variable<int>(usuarioInt.value);
    }
    if (usuario.present) {
      map['usuario'] = Variable<String>(usuario.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificacionTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('mensaje: $mensaje, ')
          ..write('tipo: $tipo, ')
          ..write('ruta: $ruta, ')
          ..write('usuarioInt: $usuarioInt, ')
          ..write('usuario: $usuario')
          ..write(')'))
        .toString();
  }
}

class $TarifaRackTableTable extends TarifaRackTable
    with TableInfo<$TarifaRackTableTable, TarifaRackTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarifaRackTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creadoPorIntMeta =
      const VerificationMeta('creadoPorInt');
  @override
  late final GeneratedColumn<int> creadoPorInt = GeneratedColumn<int>(
      'creado_por_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario_table (id)'));
  static const VerificationMeta _creadoPorMeta =
      const VerificationMeta('creadoPor');
  @override
  late final GeneratedColumn<String> creadoPor = GeneratedColumn<String>(
      'creado_por', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [idInt, id, createdAt, nombre, color, creadoPorInt, creadoPor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarifa_rack_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TarifaRackTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('creado_por_int')) {
      context.handle(
          _creadoPorIntMeta,
          creadoPorInt.isAcceptableOrUnknown(
              data['creado_por_int']!, _creadoPorIntMeta));
    }
    if (data.containsKey('creado_por')) {
      context.handle(_creadoPorMeta,
          creadoPor.isAcceptableOrUnknown(data['creado_por']!, _creadoPorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  TarifaRackTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarifaRackTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      creadoPorInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}creado_por_int']),
      creadoPor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creado_por']),
    );
  }

  @override
  $TarifaRackTableTable createAlias(String alias) {
    return $TarifaRackTableTable(attachedDatabase, alias);
  }
}

class TarifaRackTableData extends DataClass
    implements Insertable<TarifaRackTableData> {
  final int idInt;
  final String? id;
  final DateTime? createdAt;
  final String? nombre;
  final String? color;
  final int? creadoPorInt;
  final String? creadoPor;
  const TarifaRackTableData(
      {required this.idInt,
      this.id,
      this.createdAt,
      this.nombre,
      this.color,
      this.creadoPorInt,
      this.creadoPor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || nombre != null) {
      map['nombre'] = Variable<String>(nombre);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || creadoPorInt != null) {
      map['creado_por_int'] = Variable<int>(creadoPorInt);
    }
    if (!nullToAbsent || creadoPor != null) {
      map['creado_por'] = Variable<String>(creadoPor);
    }
    return map;
  }

  TarifaRackTableCompanion toCompanion(bool nullToAbsent) {
    return TarifaRackTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      creadoPorInt: creadoPorInt == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPorInt),
      creadoPor: creadoPor == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPor),
    );
  }

  factory TarifaRackTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaRackTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      nombre: serializer.fromJson<String?>(json['nombre']),
      color: serializer.fromJson<String?>(json['color']),
      creadoPorInt: serializer.fromJson<int?>(json['creadoPorInt']),
      creadoPor: serializer.fromJson<String?>(json['creadoPor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'nombre': serializer.toJson<String?>(nombre),
      'color': serializer.toJson<String?>(color),
      'creadoPorInt': serializer.toJson<int?>(creadoPorInt),
      'creadoPor': serializer.toJson<String?>(creadoPor),
    };
  }

  TarifaRackTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<String?> nombre = const Value.absent(),
          Value<String?> color = const Value.absent(),
          Value<int?> creadoPorInt = const Value.absent(),
          Value<String?> creadoPor = const Value.absent()}) =>
      TarifaRackTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        nombre: nombre.present ? nombre.value : this.nombre,
        color: color.present ? color.value : this.color,
        creadoPorInt:
            creadoPorInt.present ? creadoPorInt.value : this.creadoPorInt,
        creadoPor: creadoPor.present ? creadoPor.value : this.creadoPor,
      );
  TarifaRackTableData copyWithCompanion(TarifaRackTableCompanion data) {
    return TarifaRackTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      color: data.color.present ? data.color.value : this.color,
      creadoPorInt: data.creadoPorInt.present
          ? data.creadoPorInt.value
          : this.creadoPorInt,
      creadoPor: data.creadoPor.present ? data.creadoPor.value : this.creadoPor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TarifaRackTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('nombre: $nombre, ')
          ..write('color: $color, ')
          ..write('creadoPorInt: $creadoPorInt, ')
          ..write('creadoPor: $creadoPor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(idInt, id, createdAt, nombre, color, creadoPorInt, creadoPor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaRackTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.nombre == this.nombre &&
          other.color == this.color &&
          other.creadoPorInt == this.creadoPorInt &&
          other.creadoPor == this.creadoPor);
}

class TarifaRackTableCompanion extends UpdateCompanion<TarifaRackTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<DateTime?> createdAt;
  final Value<String?> nombre;
  final Value<String?> color;
  final Value<int?> creadoPorInt;
  final Value<String?> creadoPor;
  const TarifaRackTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.nombre = const Value.absent(),
    this.color = const Value.absent(),
    this.creadoPorInt = const Value.absent(),
    this.creadoPor = const Value.absent(),
  });
  TarifaRackTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.nombre = const Value.absent(),
    this.color = const Value.absent(),
    this.creadoPorInt = const Value.absent(),
    this.creadoPor = const Value.absent(),
  });
  static Insertable<TarifaRackTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? nombre,
    Expression<String>? color,
    Expression<int>? creadoPorInt,
    Expression<String>? creadoPor,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (nombre != null) 'nombre': nombre,
      if (color != null) 'color': color,
      if (creadoPorInt != null) 'creado_por_int': creadoPorInt,
      if (creadoPor != null) 'creado_por': creadoPor,
    });
  }

  TarifaRackTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<DateTime?>? createdAt,
      Value<String?>? nombre,
      Value<String?>? color,
      Value<int?>? creadoPorInt,
      Value<String?>? creadoPor}) {
    return TarifaRackTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      nombre: nombre ?? this.nombre,
      color: color ?? this.color,
      creadoPorInt: creadoPorInt ?? this.creadoPorInt,
      creadoPor: creadoPor ?? this.creadoPor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (creadoPorInt.present) {
      map['creado_por_int'] = Variable<int>(creadoPorInt.value);
    }
    if (creadoPor.present) {
      map['creado_por'] = Variable<String>(creadoPor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaRackTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('nombre: $nombre, ')
          ..write('color: $color, ')
          ..write('creadoPorInt: $creadoPorInt, ')
          ..write('creadoPor: $creadoPor')
          ..write(')'))
        .toString();
  }
}

class $PeriodoTableTable extends PeriodoTable
    with TableInfo<$PeriodoTableTable, PeriodoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeriodoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _fechaInicialMeta =
      const VerificationMeta('fechaInicial');
  @override
  late final GeneratedColumn<DateTime> fechaInicial = GeneratedColumn<DateTime>(
      'fecha_inicial', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _fechaFinalMeta =
      const VerificationMeta('fechaFinal');
  @override
  late final GeneratedColumn<DateTime> fechaFinal = GeneratedColumn<DateTime>(
      'fecha_final', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _diasActivoMeta =
      const VerificationMeta('diasActivo');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> diasActivo =
      GeneratedColumn<String>('dias_activo', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($PeriodoTableTable.$converterdiasActivo);
  static const VerificationMeta _tarifaRackIntMeta =
      const VerificationMeta('tarifaRackInt');
  @override
  late final GeneratedColumn<int> tarifaRackInt = GeneratedColumn<int>(
      'tarifa_rack_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tarifa_rack_table (id)'));
  static const VerificationMeta _tarifaRackMeta =
      const VerificationMeta('tarifaRack');
  @override
  late final GeneratedColumn<String> tarifaRack = GeneratedColumn<String>(
      'tarifa_rack', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        createdAt,
        fechaInicial,
        fechaFinal,
        diasActivo,
        tarifaRackInt,
        tarifaRack
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'periodo_table';
  @override
  VerificationContext validateIntegrity(Insertable<PeriodoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('fecha_inicial')) {
      context.handle(
          _fechaInicialMeta,
          fechaInicial.isAcceptableOrUnknown(
              data['fecha_inicial']!, _fechaInicialMeta));
    }
    if (data.containsKey('fecha_final')) {
      context.handle(
          _fechaFinalMeta,
          fechaFinal.isAcceptableOrUnknown(
              data['fecha_final']!, _fechaFinalMeta));
    }
    context.handle(_diasActivoMeta, const VerificationResult.success());
    if (data.containsKey('tarifa_rack_int')) {
      context.handle(
          _tarifaRackIntMeta,
          tarifaRackInt.isAcceptableOrUnknown(
              data['tarifa_rack_int']!, _tarifaRackIntMeta));
    }
    if (data.containsKey('tarifa_rack')) {
      context.handle(
          _tarifaRackMeta,
          tarifaRack.isAcceptableOrUnknown(
              data['tarifa_rack']!, _tarifaRackMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  PeriodoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeriodoTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      fechaInicial: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_inicial']),
      fechaFinal: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_final']),
      diasActivo: $PeriodoTableTable.$converterdiasActivo.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}dias_activo'])!),
      tarifaRackInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tarifa_rack_int']),
      tarifaRack: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarifa_rack']),
    );
  }

  @override
  $PeriodoTableTable createAlias(String alias) {
    return $PeriodoTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterdiasActivo =
      const StringListConverter();
}

class PeriodoTableData extends DataClass
    implements Insertable<PeriodoTableData> {
  final int idInt;
  final String? id;
  final DateTime? createdAt;
  final DateTime? fechaInicial;
  final DateTime? fechaFinal;
  final List<String> diasActivo;
  final int? tarifaRackInt;
  final String? tarifaRack;
  const PeriodoTableData(
      {required this.idInt,
      this.id,
      this.createdAt,
      this.fechaInicial,
      this.fechaFinal,
      required this.diasActivo,
      this.tarifaRackInt,
      this.tarifaRack});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || fechaInicial != null) {
      map['fecha_inicial'] = Variable<DateTime>(fechaInicial);
    }
    if (!nullToAbsent || fechaFinal != null) {
      map['fecha_final'] = Variable<DateTime>(fechaFinal);
    }
    {
      map['dias_activo'] = Variable<String>(
          $PeriodoTableTable.$converterdiasActivo.toSql(diasActivo));
    }
    if (!nullToAbsent || tarifaRackInt != null) {
      map['tarifa_rack_int'] = Variable<int>(tarifaRackInt);
    }
    if (!nullToAbsent || tarifaRack != null) {
      map['tarifa_rack'] = Variable<String>(tarifaRack);
    }
    return map;
  }

  PeriodoTableCompanion toCompanion(bool nullToAbsent) {
    return PeriodoTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      fechaInicial: fechaInicial == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaInicial),
      fechaFinal: fechaFinal == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaFinal),
      diasActivo: Value(diasActivo),
      tarifaRackInt: tarifaRackInt == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaRackInt),
      tarifaRack: tarifaRack == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaRack),
    );
  }

  factory PeriodoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeriodoTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      fechaInicial: serializer.fromJson<DateTime?>(json['fechaInicial']),
      fechaFinal: serializer.fromJson<DateTime?>(json['fechaFinal']),
      diasActivo: serializer.fromJson<List<String>>(json['diasActivo']),
      tarifaRackInt: serializer.fromJson<int?>(json['tarifaRackInt']),
      tarifaRack: serializer.fromJson<String?>(json['tarifaRack']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'fechaInicial': serializer.toJson<DateTime?>(fechaInicial),
      'fechaFinal': serializer.toJson<DateTime?>(fechaFinal),
      'diasActivo': serializer.toJson<List<String>>(diasActivo),
      'tarifaRackInt': serializer.toJson<int?>(tarifaRackInt),
      'tarifaRack': serializer.toJson<String?>(tarifaRack),
    };
  }

  PeriodoTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> fechaInicial = const Value.absent(),
          Value<DateTime?> fechaFinal = const Value.absent(),
          List<String>? diasActivo,
          Value<int?> tarifaRackInt = const Value.absent(),
          Value<String?> tarifaRack = const Value.absent()}) =>
      PeriodoTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        fechaInicial:
            fechaInicial.present ? fechaInicial.value : this.fechaInicial,
        fechaFinal: fechaFinal.present ? fechaFinal.value : this.fechaFinal,
        diasActivo: diasActivo ?? this.diasActivo,
        tarifaRackInt:
            tarifaRackInt.present ? tarifaRackInt.value : this.tarifaRackInt,
        tarifaRack: tarifaRack.present ? tarifaRack.value : this.tarifaRack,
      );
  PeriodoTableData copyWithCompanion(PeriodoTableCompanion data) {
    return PeriodoTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      fechaInicial: data.fechaInicial.present
          ? data.fechaInicial.value
          : this.fechaInicial,
      fechaFinal:
          data.fechaFinal.present ? data.fechaFinal.value : this.fechaFinal,
      diasActivo:
          data.diasActivo.present ? data.diasActivo.value : this.diasActivo,
      tarifaRackInt: data.tarifaRackInt.present
          ? data.tarifaRackInt.value
          : this.tarifaRackInt,
      tarifaRack:
          data.tarifaRack.present ? data.tarifaRack.value : this.tarifaRack,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeriodoTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('fechaInicial: $fechaInicial, ')
          ..write('fechaFinal: $fechaFinal, ')
          ..write('diasActivo: $diasActivo, ')
          ..write('tarifaRackInt: $tarifaRackInt, ')
          ..write('tarifaRack: $tarifaRack')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idInt, id, createdAt, fechaInicial,
      fechaFinal, diasActivo, tarifaRackInt, tarifaRack);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeriodoTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.fechaInicial == this.fechaInicial &&
          other.fechaFinal == this.fechaFinal &&
          other.diasActivo == this.diasActivo &&
          other.tarifaRackInt == this.tarifaRackInt &&
          other.tarifaRack == this.tarifaRack);
}

class PeriodoTableCompanion extends UpdateCompanion<PeriodoTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> fechaInicial;
  final Value<DateTime?> fechaFinal;
  final Value<List<String>> diasActivo;
  final Value<int?> tarifaRackInt;
  final Value<String?> tarifaRack;
  const PeriodoTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.fechaInicial = const Value.absent(),
    this.fechaFinal = const Value.absent(),
    this.diasActivo = const Value.absent(),
    this.tarifaRackInt = const Value.absent(),
    this.tarifaRack = const Value.absent(),
  });
  PeriodoTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.fechaInicial = const Value.absent(),
    this.fechaFinal = const Value.absent(),
    required List<String> diasActivo,
    this.tarifaRackInt = const Value.absent(),
    this.tarifaRack = const Value.absent(),
  }) : diasActivo = Value(diasActivo);
  static Insertable<PeriodoTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? fechaInicial,
    Expression<DateTime>? fechaFinal,
    Expression<String>? diasActivo,
    Expression<int>? tarifaRackInt,
    Expression<String>? tarifaRack,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (fechaInicial != null) 'fecha_inicial': fechaInicial,
      if (fechaFinal != null) 'fecha_final': fechaFinal,
      if (diasActivo != null) 'dias_activo': diasActivo,
      if (tarifaRackInt != null) 'tarifa_rack_int': tarifaRackInt,
      if (tarifaRack != null) 'tarifa_rack': tarifaRack,
    });
  }

  PeriodoTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? fechaInicial,
      Value<DateTime?>? fechaFinal,
      Value<List<String>>? diasActivo,
      Value<int?>? tarifaRackInt,
      Value<String?>? tarifaRack}) {
    return PeriodoTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      fechaInicial: fechaInicial ?? this.fechaInicial,
      fechaFinal: fechaFinal ?? this.fechaFinal,
      diasActivo: diasActivo ?? this.diasActivo,
      tarifaRackInt: tarifaRackInt ?? this.tarifaRackInt,
      tarifaRack: tarifaRack ?? this.tarifaRack,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (fechaInicial.present) {
      map['fecha_inicial'] = Variable<DateTime>(fechaInicial.value);
    }
    if (fechaFinal.present) {
      map['fecha_final'] = Variable<DateTime>(fechaFinal.value);
    }
    if (diasActivo.present) {
      map['dias_activo'] = Variable<String>(
          $PeriodoTableTable.$converterdiasActivo.toSql(diasActivo.value));
    }
    if (tarifaRackInt.present) {
      map['tarifa_rack_int'] = Variable<int>(tarifaRackInt.value);
    }
    if (tarifaRack.present) {
      map['tarifa_rack'] = Variable<String>(tarifaRack.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeriodoTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('fechaInicial: $fechaInicial, ')
          ..write('fechaFinal: $fechaFinal, ')
          ..write('diasActivo: $diasActivo, ')
          ..write('tarifaRackInt: $tarifaRackInt, ')
          ..write('tarifaRack: $tarifaRack')
          ..write(')'))
        .toString();
  }
}

class $PoliticaTarifarioTableTable extends PoliticaTarifarioTable
    with TableInfo<$PoliticaTarifarioTableTable, PoliticaTarifarioTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PoliticaTarifarioTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _claveMeta = const VerificationMeta('clave');
  @override
  late final GeneratedColumn<String> clave = GeneratedColumn<String>(
      'clave', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<String> valor = GeneratedColumn<String>(
      'valor', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creadoPorIntMeta =
      const VerificationMeta('creadoPorInt');
  @override
  late final GeneratedColumn<int> creadoPorInt = GeneratedColumn<int>(
      'creado_por_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario_table (id)'));
  static const VerificationMeta _creadoPorMeta =
      const VerificationMeta('creadoPor');
  @override
  late final GeneratedColumn<String> creadoPor = GeneratedColumn<String>(
      'creado_por', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        createdAt,
        updatedAt,
        clave,
        valor,
        descripcion,
        creadoPorInt,
        creadoPor
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'politica_tarifario_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PoliticaTarifarioTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('clave')) {
      context.handle(
          _claveMeta, clave.isAcceptableOrUnknown(data['clave']!, _claveMeta));
    }
    if (data.containsKey('valor')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['valor']!, _valorMeta));
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    }
    if (data.containsKey('creado_por_int')) {
      context.handle(
          _creadoPorIntMeta,
          creadoPorInt.isAcceptableOrUnknown(
              data['creado_por_int']!, _creadoPorIntMeta));
    }
    if (data.containsKey('creado_por')) {
      context.handle(_creadoPorMeta,
          creadoPor.isAcceptableOrUnknown(data['creado_por']!, _creadoPorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  PoliticaTarifarioTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PoliticaTarifarioTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      clave: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}clave']),
      valor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}valor']),
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion']),
      creadoPorInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}creado_por_int']),
      creadoPor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creado_por']),
    );
  }

  @override
  $PoliticaTarifarioTableTable createAlias(String alias) {
    return $PoliticaTarifarioTableTable(attachedDatabase, alias);
  }
}

class PoliticaTarifarioTableData extends DataClass
    implements Insertable<PoliticaTarifarioTableData> {
  final int idInt;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? clave;
  final String? valor;
  final String? descripcion;
  final int? creadoPorInt;
  final String? creadoPor;
  const PoliticaTarifarioTableData(
      {required this.idInt,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.clave,
      this.valor,
      this.descripcion,
      this.creadoPorInt,
      this.creadoPor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || clave != null) {
      map['clave'] = Variable<String>(clave);
    }
    if (!nullToAbsent || valor != null) {
      map['valor'] = Variable<String>(valor);
    }
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || creadoPorInt != null) {
      map['creado_por_int'] = Variable<int>(creadoPorInt);
    }
    if (!nullToAbsent || creadoPor != null) {
      map['creado_por'] = Variable<String>(creadoPor);
    }
    return map;
  }

  PoliticaTarifarioTableCompanion toCompanion(bool nullToAbsent) {
    return PoliticaTarifarioTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      clave:
          clave == null && nullToAbsent ? const Value.absent() : Value(clave),
      valor:
          valor == null && nullToAbsent ? const Value.absent() : Value(valor),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      creadoPorInt: creadoPorInt == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPorInt),
      creadoPor: creadoPor == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPor),
    );
  }

  factory PoliticaTarifarioTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PoliticaTarifarioTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      clave: serializer.fromJson<String?>(json['clave']),
      valor: serializer.fromJson<String?>(json['valor']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      creadoPorInt: serializer.fromJson<int?>(json['creadoPorInt']),
      creadoPor: serializer.fromJson<String?>(json['creadoPor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'clave': serializer.toJson<String?>(clave),
      'valor': serializer.toJson<String?>(valor),
      'descripcion': serializer.toJson<String?>(descripcion),
      'creadoPorInt': serializer.toJson<int?>(creadoPorInt),
      'creadoPor': serializer.toJson<String?>(creadoPor),
    };
  }

  PoliticaTarifarioTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<String?> clave = const Value.absent(),
          Value<String?> valor = const Value.absent(),
          Value<String?> descripcion = const Value.absent(),
          Value<int?> creadoPorInt = const Value.absent(),
          Value<String?> creadoPor = const Value.absent()}) =>
      PoliticaTarifarioTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        clave: clave.present ? clave.value : this.clave,
        valor: valor.present ? valor.value : this.valor,
        descripcion: descripcion.present ? descripcion.value : this.descripcion,
        creadoPorInt:
            creadoPorInt.present ? creadoPorInt.value : this.creadoPorInt,
        creadoPor: creadoPor.present ? creadoPor.value : this.creadoPor,
      );
  PoliticaTarifarioTableData copyWithCompanion(
      PoliticaTarifarioTableCompanion data) {
    return PoliticaTarifarioTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      clave: data.clave.present ? data.clave.value : this.clave,
      valor: data.valor.present ? data.valor.value : this.valor,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      creadoPorInt: data.creadoPorInt.present
          ? data.creadoPorInt.value
          : this.creadoPorInt,
      creadoPor: data.creadoPor.present ? data.creadoPor.value : this.creadoPor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PoliticaTarifarioTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('clave: $clave, ')
          ..write('valor: $valor, ')
          ..write('descripcion: $descripcion, ')
          ..write('creadoPorInt: $creadoPorInt, ')
          ..write('creadoPor: $creadoPor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idInt, id, createdAt, updatedAt, clave, valor,
      descripcion, creadoPorInt, creadoPor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PoliticaTarifarioTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.clave == this.clave &&
          other.valor == this.valor &&
          other.descripcion == this.descripcion &&
          other.creadoPorInt == this.creadoPorInt &&
          other.creadoPor == this.creadoPor);
}

class PoliticaTarifarioTableCompanion
    extends UpdateCompanion<PoliticaTarifarioTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String?> clave;
  final Value<String?> valor;
  final Value<String?> descripcion;
  final Value<int?> creadoPorInt;
  final Value<String?> creadoPor;
  const PoliticaTarifarioTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.clave = const Value.absent(),
    this.valor = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.creadoPorInt = const Value.absent(),
    this.creadoPor = const Value.absent(),
  });
  PoliticaTarifarioTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.clave = const Value.absent(),
    this.valor = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.creadoPorInt = const Value.absent(),
    this.creadoPor = const Value.absent(),
  });
  static Insertable<PoliticaTarifarioTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? clave,
    Expression<String>? valor,
    Expression<String>? descripcion,
    Expression<int>? creadoPorInt,
    Expression<String>? creadoPor,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (clave != null) 'clave': clave,
      if (valor != null) 'valor': valor,
      if (descripcion != null) 'descripcion': descripcion,
      if (creadoPorInt != null) 'creado_por_int': creadoPorInt,
      if (creadoPor != null) 'creado_por': creadoPor,
    });
  }

  PoliticaTarifarioTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String?>? clave,
      Value<String?>? valor,
      Value<String?>? descripcion,
      Value<int?>? creadoPorInt,
      Value<String?>? creadoPor}) {
    return PoliticaTarifarioTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      clave: clave ?? this.clave,
      valor: valor ?? this.valor,
      descripcion: descripcion ?? this.descripcion,
      creadoPorInt: creadoPorInt ?? this.creadoPorInt,
      creadoPor: creadoPor ?? this.creadoPor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (clave.present) {
      map['clave'] = Variable<String>(clave.value);
    }
    if (valor.present) {
      map['valor'] = Variable<String>(valor.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (creadoPorInt.present) {
      map['creado_por_int'] = Variable<int>(creadoPorInt.value);
    }
    if (creadoPor.present) {
      map['creado_por'] = Variable<String>(creadoPor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PoliticaTarifarioTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('clave: $clave, ')
          ..write('valor: $valor, ')
          ..write('descripcion: $descripcion, ')
          ..write('creadoPorInt: $creadoPorInt, ')
          ..write('creadoPor: $creadoPor')
          ..write(')'))
        .toString();
  }
}

class $ReservacionTableTable extends ReservacionTable
    with TableInfo<$ReservacionTableTable, ReservacionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReservacionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cotizacionIntMeta =
      const VerificationMeta('cotizacionInt');
  @override
  late final GeneratedColumn<int> cotizacionInt = GeneratedColumn<int>(
      'cotizacion_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES cotizacion_table (id)'));
  static const VerificationMeta _cotizacionMeta =
      const VerificationMeta('cotizacion');
  @override
  late final GeneratedColumn<String> cotizacion = GeneratedColumn<String>(
      'cotizacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _folioMeta = const VerificationMeta('folio');
  @override
  late final GeneratedColumn<String> folio = GeneratedColumn<String>(
      'folio', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _estatusMeta =
      const VerificationMeta('estatus');
  @override
  late final GeneratedColumn<String> estatus = GeneratedColumn<String>(
      'estatus', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _reservacionZabiaIdMeta =
      const VerificationMeta('reservacionZabiaId');
  @override
  late final GeneratedColumn<String> reservacionZabiaId =
      GeneratedColumn<String>('reservacion_zabia_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _depositoMeta =
      const VerificationMeta('deposito');
  @override
  late final GeneratedColumn<double> deposito = GeneratedColumn<double>(
      'deposito', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _creadoPorIntMeta =
      const VerificationMeta('creadoPorInt');
  @override
  late final GeneratedColumn<int> creadoPorInt = GeneratedColumn<int>(
      'creado_por_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario_table (id)'));
  static const VerificationMeta _creadoPorMeta =
      const VerificationMeta('creadoPor');
  @override
  late final GeneratedColumn<String> creadoPor = GeneratedColumn<String>(
      'creado_por', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        cotizacionInt,
        cotizacion,
        sku,
        folio,
        estatus,
        createdAt,
        reservacionZabiaId,
        deposito,
        creadoPorInt,
        creadoPor
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reservacion_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ReservacionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cotizacion_int')) {
      context.handle(
          _cotizacionIntMeta,
          cotizacionInt.isAcceptableOrUnknown(
              data['cotizacion_int']!, _cotizacionIntMeta));
    }
    if (data.containsKey('cotizacion')) {
      context.handle(
          _cotizacionMeta,
          cotizacion.isAcceptableOrUnknown(
              data['cotizacion']!, _cotizacionMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('folio')) {
      context.handle(
          _folioMeta, folio.isAcceptableOrUnknown(data['folio']!, _folioMeta));
    }
    if (data.containsKey('estatus')) {
      context.handle(_estatusMeta,
          estatus.isAcceptableOrUnknown(data['estatus']!, _estatusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('reservacion_zabia_id')) {
      context.handle(
          _reservacionZabiaIdMeta,
          reservacionZabiaId.isAcceptableOrUnknown(
              data['reservacion_zabia_id']!, _reservacionZabiaIdMeta));
    }
    if (data.containsKey('deposito')) {
      context.handle(_depositoMeta,
          deposito.isAcceptableOrUnknown(data['deposito']!, _depositoMeta));
    }
    if (data.containsKey('creado_por_int')) {
      context.handle(
          _creadoPorIntMeta,
          creadoPorInt.isAcceptableOrUnknown(
              data['creado_por_int']!, _creadoPorIntMeta));
    }
    if (data.containsKey('creado_por')) {
      context.handle(_creadoPorMeta,
          creadoPor.isAcceptableOrUnknown(data['creado_por']!, _creadoPorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  ReservacionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReservacionTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      cotizacionInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cotizacion_int']),
      cotizacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cotizacion']),
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      folio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}folio']),
      estatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estatus']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      reservacionZabiaId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}reservacion_zabia_id']),
      deposito: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}deposito']),
      creadoPorInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}creado_por_int']),
      creadoPor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creado_por']),
    );
  }

  @override
  $ReservacionTableTable createAlias(String alias) {
    return $ReservacionTableTable(attachedDatabase, alias);
  }
}

class ReservacionTableData extends DataClass
    implements Insertable<ReservacionTableData> {
  final int idInt;
  final String? id;
  final int? cotizacionInt;
  final String? cotizacion;
  final String? sku;
  final String? folio;
  final String? estatus;
  final DateTime? createdAt;
  final String? reservacionZabiaId;
  final double? deposito;
  final int? creadoPorInt;
  final String? creadoPor;
  const ReservacionTableData(
      {required this.idInt,
      this.id,
      this.cotizacionInt,
      this.cotizacion,
      this.sku,
      this.folio,
      this.estatus,
      this.createdAt,
      this.reservacionZabiaId,
      this.deposito,
      this.creadoPorInt,
      this.creadoPor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || cotizacionInt != null) {
      map['cotizacion_int'] = Variable<int>(cotizacionInt);
    }
    if (!nullToAbsent || cotizacion != null) {
      map['cotizacion'] = Variable<String>(cotizacion);
    }
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || folio != null) {
      map['folio'] = Variable<String>(folio);
    }
    if (!nullToAbsent || estatus != null) {
      map['estatus'] = Variable<String>(estatus);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || reservacionZabiaId != null) {
      map['reservacion_zabia_id'] = Variable<String>(reservacionZabiaId);
    }
    if (!nullToAbsent || deposito != null) {
      map['deposito'] = Variable<double>(deposito);
    }
    if (!nullToAbsent || creadoPorInt != null) {
      map['creado_por_int'] = Variable<int>(creadoPorInt);
    }
    if (!nullToAbsent || creadoPor != null) {
      map['creado_por'] = Variable<String>(creadoPor);
    }
    return map;
  }

  ReservacionTableCompanion toCompanion(bool nullToAbsent) {
    return ReservacionTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      cotizacionInt: cotizacionInt == null && nullToAbsent
          ? const Value.absent()
          : Value(cotizacionInt),
      cotizacion: cotizacion == null && nullToAbsent
          ? const Value.absent()
          : Value(cotizacion),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      folio:
          folio == null && nullToAbsent ? const Value.absent() : Value(folio),
      estatus: estatus == null && nullToAbsent
          ? const Value.absent()
          : Value(estatus),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      reservacionZabiaId: reservacionZabiaId == null && nullToAbsent
          ? const Value.absent()
          : Value(reservacionZabiaId),
      deposito: deposito == null && nullToAbsent
          ? const Value.absent()
          : Value(deposito),
      creadoPorInt: creadoPorInt == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPorInt),
      creadoPor: creadoPor == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPor),
    );
  }

  factory ReservacionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReservacionTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      cotizacionInt: serializer.fromJson<int?>(json['cotizacionInt']),
      cotizacion: serializer.fromJson<String?>(json['cotizacion']),
      sku: serializer.fromJson<String?>(json['sku']),
      folio: serializer.fromJson<String?>(json['folio']),
      estatus: serializer.fromJson<String?>(json['estatus']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      reservacionZabiaId:
          serializer.fromJson<String?>(json['reservacionZabiaId']),
      deposito: serializer.fromJson<double?>(json['deposito']),
      creadoPorInt: serializer.fromJson<int?>(json['creadoPorInt']),
      creadoPor: serializer.fromJson<String?>(json['creadoPor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'cotizacionInt': serializer.toJson<int?>(cotizacionInt),
      'cotizacion': serializer.toJson<String?>(cotizacion),
      'sku': serializer.toJson<String?>(sku),
      'folio': serializer.toJson<String?>(folio),
      'estatus': serializer.toJson<String?>(estatus),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'reservacionZabiaId': serializer.toJson<String?>(reservacionZabiaId),
      'deposito': serializer.toJson<double?>(deposito),
      'creadoPorInt': serializer.toJson<int?>(creadoPorInt),
      'creadoPor': serializer.toJson<String?>(creadoPor),
    };
  }

  ReservacionTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<int?> cotizacionInt = const Value.absent(),
          Value<String?> cotizacion = const Value.absent(),
          Value<String?> sku = const Value.absent(),
          Value<String?> folio = const Value.absent(),
          Value<String?> estatus = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<String?> reservacionZabiaId = const Value.absent(),
          Value<double?> deposito = const Value.absent(),
          Value<int?> creadoPorInt = const Value.absent(),
          Value<String?> creadoPor = const Value.absent()}) =>
      ReservacionTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        cotizacionInt:
            cotizacionInt.present ? cotizacionInt.value : this.cotizacionInt,
        cotizacion: cotizacion.present ? cotizacion.value : this.cotizacion,
        sku: sku.present ? sku.value : this.sku,
        folio: folio.present ? folio.value : this.folio,
        estatus: estatus.present ? estatus.value : this.estatus,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        reservacionZabiaId: reservacionZabiaId.present
            ? reservacionZabiaId.value
            : this.reservacionZabiaId,
        deposito: deposito.present ? deposito.value : this.deposito,
        creadoPorInt:
            creadoPorInt.present ? creadoPorInt.value : this.creadoPorInt,
        creadoPor: creadoPor.present ? creadoPor.value : this.creadoPor,
      );
  ReservacionTableData copyWithCompanion(ReservacionTableCompanion data) {
    return ReservacionTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      cotizacionInt: data.cotizacionInt.present
          ? data.cotizacionInt.value
          : this.cotizacionInt,
      cotizacion:
          data.cotizacion.present ? data.cotizacion.value : this.cotizacion,
      sku: data.sku.present ? data.sku.value : this.sku,
      folio: data.folio.present ? data.folio.value : this.folio,
      estatus: data.estatus.present ? data.estatus.value : this.estatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      reservacionZabiaId: data.reservacionZabiaId.present
          ? data.reservacionZabiaId.value
          : this.reservacionZabiaId,
      deposito: data.deposito.present ? data.deposito.value : this.deposito,
      creadoPorInt: data.creadoPorInt.present
          ? data.creadoPorInt.value
          : this.creadoPorInt,
      creadoPor: data.creadoPor.present ? data.creadoPor.value : this.creadoPor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReservacionTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('cotizacionInt: $cotizacionInt, ')
          ..write('cotizacion: $cotizacion, ')
          ..write('sku: $sku, ')
          ..write('folio: $folio, ')
          ..write('estatus: $estatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('reservacionZabiaId: $reservacionZabiaId, ')
          ..write('deposito: $deposito, ')
          ..write('creadoPorInt: $creadoPorInt, ')
          ..write('creadoPor: $creadoPor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      idInt,
      id,
      cotizacionInt,
      cotizacion,
      sku,
      folio,
      estatus,
      createdAt,
      reservacionZabiaId,
      deposito,
      creadoPorInt,
      creadoPor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReservacionTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.cotizacionInt == this.cotizacionInt &&
          other.cotizacion == this.cotizacion &&
          other.sku == this.sku &&
          other.folio == this.folio &&
          other.estatus == this.estatus &&
          other.createdAt == this.createdAt &&
          other.reservacionZabiaId == this.reservacionZabiaId &&
          other.deposito == this.deposito &&
          other.creadoPorInt == this.creadoPorInt &&
          other.creadoPor == this.creadoPor);
}

class ReservacionTableCompanion extends UpdateCompanion<ReservacionTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<int?> cotizacionInt;
  final Value<String?> cotizacion;
  final Value<String?> sku;
  final Value<String?> folio;
  final Value<String?> estatus;
  final Value<DateTime?> createdAt;
  final Value<String?> reservacionZabiaId;
  final Value<double?> deposito;
  final Value<int?> creadoPorInt;
  final Value<String?> creadoPor;
  const ReservacionTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.cotizacionInt = const Value.absent(),
    this.cotizacion = const Value.absent(),
    this.sku = const Value.absent(),
    this.folio = const Value.absent(),
    this.estatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.reservacionZabiaId = const Value.absent(),
    this.deposito = const Value.absent(),
    this.creadoPorInt = const Value.absent(),
    this.creadoPor = const Value.absent(),
  });
  ReservacionTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.cotizacionInt = const Value.absent(),
    this.cotizacion = const Value.absent(),
    this.sku = const Value.absent(),
    this.folio = const Value.absent(),
    this.estatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.reservacionZabiaId = const Value.absent(),
    this.deposito = const Value.absent(),
    this.creadoPorInt = const Value.absent(),
    this.creadoPor = const Value.absent(),
  });
  static Insertable<ReservacionTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<int>? cotizacionInt,
    Expression<String>? cotizacion,
    Expression<String>? sku,
    Expression<String>? folio,
    Expression<String>? estatus,
    Expression<DateTime>? createdAt,
    Expression<String>? reservacionZabiaId,
    Expression<double>? deposito,
    Expression<int>? creadoPorInt,
    Expression<String>? creadoPor,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (cotizacionInt != null) 'cotizacion_int': cotizacionInt,
      if (cotizacion != null) 'cotizacion': cotizacion,
      if (sku != null) 'sku': sku,
      if (folio != null) 'folio': folio,
      if (estatus != null) 'estatus': estatus,
      if (createdAt != null) 'created_at': createdAt,
      if (reservacionZabiaId != null)
        'reservacion_zabia_id': reservacionZabiaId,
      if (deposito != null) 'deposito': deposito,
      if (creadoPorInt != null) 'creado_por_int': creadoPorInt,
      if (creadoPor != null) 'creado_por': creadoPor,
    });
  }

  ReservacionTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<int?>? cotizacionInt,
      Value<String?>? cotizacion,
      Value<String?>? sku,
      Value<String?>? folio,
      Value<String?>? estatus,
      Value<DateTime?>? createdAt,
      Value<String?>? reservacionZabiaId,
      Value<double?>? deposito,
      Value<int?>? creadoPorInt,
      Value<String?>? creadoPor}) {
    return ReservacionTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      cotizacionInt: cotizacionInt ?? this.cotizacionInt,
      cotizacion: cotizacion ?? this.cotizacion,
      sku: sku ?? this.sku,
      folio: folio ?? this.folio,
      estatus: estatus ?? this.estatus,
      createdAt: createdAt ?? this.createdAt,
      reservacionZabiaId: reservacionZabiaId ?? this.reservacionZabiaId,
      deposito: deposito ?? this.deposito,
      creadoPorInt: creadoPorInt ?? this.creadoPorInt,
      creadoPor: creadoPor ?? this.creadoPor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cotizacionInt.present) {
      map['cotizacion_int'] = Variable<int>(cotizacionInt.value);
    }
    if (cotizacion.present) {
      map['cotizacion'] = Variable<String>(cotizacion.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (folio.present) {
      map['folio'] = Variable<String>(folio.value);
    }
    if (estatus.present) {
      map['estatus'] = Variable<String>(estatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (reservacionZabiaId.present) {
      map['reservacion_zabia_id'] = Variable<String>(reservacionZabiaId.value);
    }
    if (deposito.present) {
      map['deposito'] = Variable<double>(deposito.value);
    }
    if (creadoPorInt.present) {
      map['creado_por_int'] = Variable<int>(creadoPorInt.value);
    }
    if (creadoPor.present) {
      map['creado_por'] = Variable<String>(creadoPor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReservacionTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('cotizacionInt: $cotizacionInt, ')
          ..write('cotizacion: $cotizacion, ')
          ..write('sku: $sku, ')
          ..write('folio: $folio, ')
          ..write('estatus: $estatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('reservacionZabiaId: $reservacionZabiaId, ')
          ..write('deposito: $deposito, ')
          ..write('creadoPorInt: $creadoPorInt, ')
          ..write('creadoPor: $creadoPor')
          ..write(')'))
        .toString();
  }
}

class $ResumenHabitacionTableTable extends ResumenOperacionTable
    with TableInfo<$ResumenHabitacionTableTable, ResumenHabitacionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResumenHabitacionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _descuentoMeta =
      const VerificationMeta('descuento');
  @override
  late final GeneratedColumn<double> descuento = GeneratedColumn<double>(
      'descuento', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _impuestosMeta =
      const VerificationMeta('impuestos');
  @override
  late final GeneratedColumn<double> impuestos = GeneratedColumn<double>(
      'impuestos', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _habitacionIntMeta =
      const VerificationMeta('habitacionInt');
  @override
  late final GeneratedColumn<int> habitacionInt = GeneratedColumn<int>(
      'habitacion_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES habitacion_table (id)'));
  static const VerificationMeta _habitacionMeta =
      const VerificationMeta('habitacion');
  @override
  late final GeneratedColumn<String> habitacion = GeneratedColumn<String>(
      'habitacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoriaIntMeta =
      const VerificationMeta('categoriaInt');
  @override
  late final GeneratedColumn<int> categoriaInt = GeneratedColumn<int>(
      'categoria_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categoria_table (id)'));
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        subtotal,
        descuento,
        impuestos,
        total,
        habitacionInt,
        habitacion,
        categoriaInt,
        categoria
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'resumen_habitacion_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ResumenHabitacionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    }
    if (data.containsKey('descuento')) {
      context.handle(_descuentoMeta,
          descuento.isAcceptableOrUnknown(data['descuento']!, _descuentoMeta));
    }
    if (data.containsKey('impuestos')) {
      context.handle(_impuestosMeta,
          impuestos.isAcceptableOrUnknown(data['impuestos']!, _impuestosMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    }
    if (data.containsKey('habitacion_int')) {
      context.handle(
          _habitacionIntMeta,
          habitacionInt.isAcceptableOrUnknown(
              data['habitacion_int']!, _habitacionIntMeta));
    }
    if (data.containsKey('habitacion')) {
      context.handle(
          _habitacionMeta,
          habitacion.isAcceptableOrUnknown(
              data['habitacion']!, _habitacionMeta));
    }
    if (data.containsKey('categoria_int')) {
      context.handle(
          _categoriaIntMeta,
          categoriaInt.isAcceptableOrUnknown(
              data['categoria_int']!, _categoriaIntMeta));
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  ResumenHabitacionTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ResumenHabitacionTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      descuento: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}descuento'])!,
      impuestos: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}impuestos'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      habitacionInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}habitacion_int']),
      habitacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habitacion']),
      categoriaInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}categoria_int']),
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria']),
    );
  }

  @override
  $ResumenHabitacionTableTable createAlias(String alias) {
    return $ResumenHabitacionTableTable(attachedDatabase, alias);
  }
}

class ResumenHabitacionTableData extends DataClass
    implements Insertable<ResumenHabitacionTableData> {
  final int idInt;
  final String? id;
  final double subtotal;
  final double descuento;
  final double impuestos;
  final double total;
  final int? habitacionInt;
  final String? habitacion;
  final int? categoriaInt;
  final String? categoria;
  const ResumenHabitacionTableData(
      {required this.idInt,
      this.id,
      required this.subtotal,
      required this.descuento,
      required this.impuestos,
      required this.total,
      this.habitacionInt,
      this.habitacion,
      this.categoriaInt,
      this.categoria});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    map['subtotal'] = Variable<double>(subtotal);
    map['descuento'] = Variable<double>(descuento);
    map['impuestos'] = Variable<double>(impuestos);
    map['total'] = Variable<double>(total);
    if (!nullToAbsent || habitacionInt != null) {
      map['habitacion_int'] = Variable<int>(habitacionInt);
    }
    if (!nullToAbsent || habitacion != null) {
      map['habitacion'] = Variable<String>(habitacion);
    }
    if (!nullToAbsent || categoriaInt != null) {
      map['categoria_int'] = Variable<int>(categoriaInt);
    }
    if (!nullToAbsent || categoria != null) {
      map['categoria'] = Variable<String>(categoria);
    }
    return map;
  }

  ResumenHabitacionTableCompanion toCompanion(bool nullToAbsent) {
    return ResumenHabitacionTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      subtotal: Value(subtotal),
      descuento: Value(descuento),
      impuestos: Value(impuestos),
      total: Value(total),
      habitacionInt: habitacionInt == null && nullToAbsent
          ? const Value.absent()
          : Value(habitacionInt),
      habitacion: habitacion == null && nullToAbsent
          ? const Value.absent()
          : Value(habitacion),
      categoriaInt: categoriaInt == null && nullToAbsent
          ? const Value.absent()
          : Value(categoriaInt),
      categoria: categoria == null && nullToAbsent
          ? const Value.absent()
          : Value(categoria),
    );
  }

  factory ResumenHabitacionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ResumenHabitacionTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      descuento: serializer.fromJson<double>(json['descuento']),
      impuestos: serializer.fromJson<double>(json['impuestos']),
      total: serializer.fromJson<double>(json['total']),
      habitacionInt: serializer.fromJson<int?>(json['habitacionInt']),
      habitacion: serializer.fromJson<String?>(json['habitacion']),
      categoriaInt: serializer.fromJson<int?>(json['categoriaInt']),
      categoria: serializer.fromJson<String?>(json['categoria']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'subtotal': serializer.toJson<double>(subtotal),
      'descuento': serializer.toJson<double>(descuento),
      'impuestos': serializer.toJson<double>(impuestos),
      'total': serializer.toJson<double>(total),
      'habitacionInt': serializer.toJson<int?>(habitacionInt),
      'habitacion': serializer.toJson<String?>(habitacion),
      'categoriaInt': serializer.toJson<int?>(categoriaInt),
      'categoria': serializer.toJson<String?>(categoria),
    };
  }

  ResumenHabitacionTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          double? subtotal,
          double? descuento,
          double? impuestos,
          double? total,
          Value<int?> habitacionInt = const Value.absent(),
          Value<String?> habitacion = const Value.absent(),
          Value<int?> categoriaInt = const Value.absent(),
          Value<String?> categoria = const Value.absent()}) =>
      ResumenHabitacionTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        subtotal: subtotal ?? this.subtotal,
        descuento: descuento ?? this.descuento,
        impuestos: impuestos ?? this.impuestos,
        total: total ?? this.total,
        habitacionInt:
            habitacionInt.present ? habitacionInt.value : this.habitacionInt,
        habitacion: habitacion.present ? habitacion.value : this.habitacion,
        categoriaInt:
            categoriaInt.present ? categoriaInt.value : this.categoriaInt,
        categoria: categoria.present ? categoria.value : this.categoria,
      );
  ResumenHabitacionTableData copyWithCompanion(
      ResumenHabitacionTableCompanion data) {
    return ResumenHabitacionTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      descuento: data.descuento.present ? data.descuento.value : this.descuento,
      impuestos: data.impuestos.present ? data.impuestos.value : this.impuestos,
      total: data.total.present ? data.total.value : this.total,
      habitacionInt: data.habitacionInt.present
          ? data.habitacionInt.value
          : this.habitacionInt,
      habitacion:
          data.habitacion.present ? data.habitacion.value : this.habitacion,
      categoriaInt: data.categoriaInt.present
          ? data.categoriaInt.value
          : this.categoriaInt,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ResumenHabitacionTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('subtotal: $subtotal, ')
          ..write('descuento: $descuento, ')
          ..write('impuestos: $impuestos, ')
          ..write('total: $total, ')
          ..write('habitacionInt: $habitacionInt, ')
          ..write('habitacion: $habitacion, ')
          ..write('categoriaInt: $categoriaInt, ')
          ..write('categoria: $categoria')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idInt, id, subtotal, descuento, impuestos,
      total, habitacionInt, habitacion, categoriaInt, categoria);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResumenHabitacionTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.subtotal == this.subtotal &&
          other.descuento == this.descuento &&
          other.impuestos == this.impuestos &&
          other.total == this.total &&
          other.habitacionInt == this.habitacionInt &&
          other.habitacion == this.habitacion &&
          other.categoriaInt == this.categoriaInt &&
          other.categoria == this.categoria);
}

class ResumenHabitacionTableCompanion
    extends UpdateCompanion<ResumenHabitacionTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<double> subtotal;
  final Value<double> descuento;
  final Value<double> impuestos;
  final Value<double> total;
  final Value<int?> habitacionInt;
  final Value<String?> habitacion;
  final Value<int?> categoriaInt;
  final Value<String?> categoria;
  const ResumenHabitacionTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.descuento = const Value.absent(),
    this.impuestos = const Value.absent(),
    this.total = const Value.absent(),
    this.habitacionInt = const Value.absent(),
    this.habitacion = const Value.absent(),
    this.categoriaInt = const Value.absent(),
    this.categoria = const Value.absent(),
  });
  ResumenHabitacionTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.descuento = const Value.absent(),
    this.impuestos = const Value.absent(),
    this.total = const Value.absent(),
    this.habitacionInt = const Value.absent(),
    this.habitacion = const Value.absent(),
    this.categoriaInt = const Value.absent(),
    this.categoria = const Value.absent(),
  });
  static Insertable<ResumenHabitacionTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<double>? subtotal,
    Expression<double>? descuento,
    Expression<double>? impuestos,
    Expression<double>? total,
    Expression<int>? habitacionInt,
    Expression<String>? habitacion,
    Expression<int>? categoriaInt,
    Expression<String>? categoria,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (subtotal != null) 'subtotal': subtotal,
      if (descuento != null) 'descuento': descuento,
      if (impuestos != null) 'impuestos': impuestos,
      if (total != null) 'total': total,
      if (habitacionInt != null) 'habitacion_int': habitacionInt,
      if (habitacion != null) 'habitacion': habitacion,
      if (categoriaInt != null) 'categoria_int': categoriaInt,
      if (categoria != null) 'categoria': categoria,
    });
  }

  ResumenHabitacionTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<double>? subtotal,
      Value<double>? descuento,
      Value<double>? impuestos,
      Value<double>? total,
      Value<int?>? habitacionInt,
      Value<String?>? habitacion,
      Value<int?>? categoriaInt,
      Value<String?>? categoria}) {
    return ResumenHabitacionTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      subtotal: subtotal ?? this.subtotal,
      descuento: descuento ?? this.descuento,
      impuestos: impuestos ?? this.impuestos,
      total: total ?? this.total,
      habitacionInt: habitacionInt ?? this.habitacionInt,
      habitacion: habitacion ?? this.habitacion,
      categoriaInt: categoriaInt ?? this.categoriaInt,
      categoria: categoria ?? this.categoria,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (descuento.present) {
      map['descuento'] = Variable<double>(descuento.value);
    }
    if (impuestos.present) {
      map['impuestos'] = Variable<double>(impuestos.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (habitacionInt.present) {
      map['habitacion_int'] = Variable<int>(habitacionInt.value);
    }
    if (habitacion.present) {
      map['habitacion'] = Variable<String>(habitacion.value);
    }
    if (categoriaInt.present) {
      map['categoria_int'] = Variable<int>(categoriaInt.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResumenHabitacionTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('subtotal: $subtotal, ')
          ..write('descuento: $descuento, ')
          ..write('impuestos: $impuestos, ')
          ..write('total: $total, ')
          ..write('habitacionInt: $habitacionInt, ')
          ..write('habitacion: $habitacion, ')
          ..write('categoriaInt: $categoriaInt, ')
          ..write('categoria: $categoria')
          ..write(')'))
        .toString();
  }
}

class $TarifaBaseTableTable extends TarifaBaseTable
    with TableInfo<$TarifaBaseTableTable, TarifaBaseTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarifaBaseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _aumentoIntegradoMeta =
      const VerificationMeta('aumentoIntegrado');
  @override
  late final GeneratedColumn<double> aumentoIntegrado = GeneratedColumn<double>(
      'aumento_integrado', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _conAutocalculacionMeta =
      const VerificationMeta('conAutocalculacion');
  @override
  late final GeneratedColumn<bool> conAutocalculacion = GeneratedColumn<bool>(
      'con_autocalculacion', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("con_autocalculacion" IN (0, 1))'));
  static const VerificationMeta _upgradeCategoriaMeta =
      const VerificationMeta('upgradeCategoria');
  @override
  late final GeneratedColumn<double> upgradeCategoria = GeneratedColumn<double>(
      'upgrade_categoria', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _upgradeMenorMeta =
      const VerificationMeta('upgradeMenor');
  @override
  late final GeneratedColumn<double> upgradeMenor = GeneratedColumn<double>(
      'upgrade_menor', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _upgradePaxAdicMeta =
      const VerificationMeta('upgradePaxAdic');
  @override
  late final GeneratedColumn<double> upgradePaxAdic = GeneratedColumn<double>(
      'upgrade_pax_adic', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaBaseIntMeta =
      const VerificationMeta('tarifaBaseInt');
  @override
  late final GeneratedColumn<int> tarifaBaseInt = GeneratedColumn<int>(
      'tarifa_base_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tarifa_base_table (id)'));
  static const VerificationMeta _tarifaBaseMeta =
      const VerificationMeta('tarifaBase');
  @override
  late final GeneratedColumn<String> tarifaBase = GeneratedColumn<String>(
      'tarifa_base', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creadoPorIntMeta =
      const VerificationMeta('creadoPorInt');
  @override
  late final GeneratedColumn<int> creadoPorInt = GeneratedColumn<int>(
      'creado_por_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario_table (id)'));
  static const VerificationMeta _creadoPorMeta =
      const VerificationMeta('creadoPor');
  @override
  late final GeneratedColumn<String> creadoPor = GeneratedColumn<String>(
      'creado_por', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        codigo,
        nombre,
        aumentoIntegrado,
        conAutocalculacion,
        upgradeCategoria,
        upgradeMenor,
        upgradePaxAdic,
        tarifaBaseInt,
        tarifaBase,
        creadoPorInt,
        creadoPor
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarifa_base_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TarifaBaseTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    }
    if (data.containsKey('aumento_integrado')) {
      context.handle(
          _aumentoIntegradoMeta,
          aumentoIntegrado.isAcceptableOrUnknown(
              data['aumento_integrado']!, _aumentoIntegradoMeta));
    }
    if (data.containsKey('con_autocalculacion')) {
      context.handle(
          _conAutocalculacionMeta,
          conAutocalculacion.isAcceptableOrUnknown(
              data['con_autocalculacion']!, _conAutocalculacionMeta));
    }
    if (data.containsKey('upgrade_categoria')) {
      context.handle(
          _upgradeCategoriaMeta,
          upgradeCategoria.isAcceptableOrUnknown(
              data['upgrade_categoria']!, _upgradeCategoriaMeta));
    }
    if (data.containsKey('upgrade_menor')) {
      context.handle(
          _upgradeMenorMeta,
          upgradeMenor.isAcceptableOrUnknown(
              data['upgrade_menor']!, _upgradeMenorMeta));
    }
    if (data.containsKey('upgrade_pax_adic')) {
      context.handle(
          _upgradePaxAdicMeta,
          upgradePaxAdic.isAcceptableOrUnknown(
              data['upgrade_pax_adic']!, _upgradePaxAdicMeta));
    }
    if (data.containsKey('tarifa_base_int')) {
      context.handle(
          _tarifaBaseIntMeta,
          tarifaBaseInt.isAcceptableOrUnknown(
              data['tarifa_base_int']!, _tarifaBaseIntMeta));
    }
    if (data.containsKey('tarifa_base')) {
      context.handle(
          _tarifaBaseMeta,
          tarifaBase.isAcceptableOrUnknown(
              data['tarifa_base']!, _tarifaBaseMeta));
    }
    if (data.containsKey('creado_por_int')) {
      context.handle(
          _creadoPorIntMeta,
          creadoPorInt.isAcceptableOrUnknown(
              data['creado_por_int']!, _creadoPorIntMeta));
    }
    if (data.containsKey('creado_por')) {
      context.handle(_creadoPorMeta,
          creadoPor.isAcceptableOrUnknown(data['creado_por']!, _creadoPorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  TarifaBaseTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarifaBaseTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo']),
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre']),
      aumentoIntegrado: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}aumento_integrado']),
      conAutocalculacion: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}con_autocalculacion']),
      upgradeCategoria: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}upgrade_categoria']),
      upgradeMenor: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}upgrade_menor']),
      upgradePaxAdic: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}upgrade_pax_adic']),
      tarifaBaseInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tarifa_base_int']),
      tarifaBase: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarifa_base']),
      creadoPorInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}creado_por_int']),
      creadoPor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creado_por']),
    );
  }

  @override
  $TarifaBaseTableTable createAlias(String alias) {
    return $TarifaBaseTableTable(attachedDatabase, alias);
  }
}

class TarifaBaseTableData extends DataClass
    implements Insertable<TarifaBaseTableData> {
  final int idInt;
  final String? id;
  final String? codigo;
  final String? nombre;
  final double? aumentoIntegrado;
  final bool? conAutocalculacion;
  final double? upgradeCategoria;
  final double? upgradeMenor;
  final double? upgradePaxAdic;
  final int? tarifaBaseInt;
  final String? tarifaBase;
  final int? creadoPorInt;
  final String? creadoPor;
  const TarifaBaseTableData(
      {required this.idInt,
      this.id,
      this.codigo,
      this.nombre,
      this.aumentoIntegrado,
      this.conAutocalculacion,
      this.upgradeCategoria,
      this.upgradeMenor,
      this.upgradePaxAdic,
      this.tarifaBaseInt,
      this.tarifaBase,
      this.creadoPorInt,
      this.creadoPor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<String>(codigo);
    }
    if (!nullToAbsent || nombre != null) {
      map['nombre'] = Variable<String>(nombre);
    }
    if (!nullToAbsent || aumentoIntegrado != null) {
      map['aumento_integrado'] = Variable<double>(aumentoIntegrado);
    }
    if (!nullToAbsent || conAutocalculacion != null) {
      map['con_autocalculacion'] = Variable<bool>(conAutocalculacion);
    }
    if (!nullToAbsent || upgradeCategoria != null) {
      map['upgrade_categoria'] = Variable<double>(upgradeCategoria);
    }
    if (!nullToAbsent || upgradeMenor != null) {
      map['upgrade_menor'] = Variable<double>(upgradeMenor);
    }
    if (!nullToAbsent || upgradePaxAdic != null) {
      map['upgrade_pax_adic'] = Variable<double>(upgradePaxAdic);
    }
    if (!nullToAbsent || tarifaBaseInt != null) {
      map['tarifa_base_int'] = Variable<int>(tarifaBaseInt);
    }
    if (!nullToAbsent || tarifaBase != null) {
      map['tarifa_base'] = Variable<String>(tarifaBase);
    }
    if (!nullToAbsent || creadoPorInt != null) {
      map['creado_por_int'] = Variable<int>(creadoPorInt);
    }
    if (!nullToAbsent || creadoPor != null) {
      map['creado_por'] = Variable<String>(creadoPor);
    }
    return map;
  }

  TarifaBaseTableCompanion toCompanion(bool nullToAbsent) {
    return TarifaBaseTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      aumentoIntegrado: aumentoIntegrado == null && nullToAbsent
          ? const Value.absent()
          : Value(aumentoIntegrado),
      conAutocalculacion: conAutocalculacion == null && nullToAbsent
          ? const Value.absent()
          : Value(conAutocalculacion),
      upgradeCategoria: upgradeCategoria == null && nullToAbsent
          ? const Value.absent()
          : Value(upgradeCategoria),
      upgradeMenor: upgradeMenor == null && nullToAbsent
          ? const Value.absent()
          : Value(upgradeMenor),
      upgradePaxAdic: upgradePaxAdic == null && nullToAbsent
          ? const Value.absent()
          : Value(upgradePaxAdic),
      tarifaBaseInt: tarifaBaseInt == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaBaseInt),
      tarifaBase: tarifaBase == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaBase),
      creadoPorInt: creadoPorInt == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPorInt),
      creadoPor: creadoPor == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPor),
    );
  }

  factory TarifaBaseTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaBaseTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      codigo: serializer.fromJson<String?>(json['codigo']),
      nombre: serializer.fromJson<String?>(json['nombre']),
      aumentoIntegrado: serializer.fromJson<double?>(json['aumentoIntegrado']),
      conAutocalculacion:
          serializer.fromJson<bool?>(json['conAutocalculacion']),
      upgradeCategoria: serializer.fromJson<double?>(json['upgradeCategoria']),
      upgradeMenor: serializer.fromJson<double?>(json['upgradeMenor']),
      upgradePaxAdic: serializer.fromJson<double?>(json['upgradePaxAdic']),
      tarifaBaseInt: serializer.fromJson<int?>(json['tarifaBaseInt']),
      tarifaBase: serializer.fromJson<String?>(json['tarifaBase']),
      creadoPorInt: serializer.fromJson<int?>(json['creadoPorInt']),
      creadoPor: serializer.fromJson<String?>(json['creadoPor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'codigo': serializer.toJson<String?>(codigo),
      'nombre': serializer.toJson<String?>(nombre),
      'aumentoIntegrado': serializer.toJson<double?>(aumentoIntegrado),
      'conAutocalculacion': serializer.toJson<bool?>(conAutocalculacion),
      'upgradeCategoria': serializer.toJson<double?>(upgradeCategoria),
      'upgradeMenor': serializer.toJson<double?>(upgradeMenor),
      'upgradePaxAdic': serializer.toJson<double?>(upgradePaxAdic),
      'tarifaBaseInt': serializer.toJson<int?>(tarifaBaseInt),
      'tarifaBase': serializer.toJson<String?>(tarifaBase),
      'creadoPorInt': serializer.toJson<int?>(creadoPorInt),
      'creadoPor': serializer.toJson<String?>(creadoPor),
    };
  }

  TarifaBaseTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<String?> codigo = const Value.absent(),
          Value<String?> nombre = const Value.absent(),
          Value<double?> aumentoIntegrado = const Value.absent(),
          Value<bool?> conAutocalculacion = const Value.absent(),
          Value<double?> upgradeCategoria = const Value.absent(),
          Value<double?> upgradeMenor = const Value.absent(),
          Value<double?> upgradePaxAdic = const Value.absent(),
          Value<int?> tarifaBaseInt = const Value.absent(),
          Value<String?> tarifaBase = const Value.absent(),
          Value<int?> creadoPorInt = const Value.absent(),
          Value<String?> creadoPor = const Value.absent()}) =>
      TarifaBaseTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        codigo: codigo.present ? codigo.value : this.codigo,
        nombre: nombre.present ? nombre.value : this.nombre,
        aumentoIntegrado: aumentoIntegrado.present
            ? aumentoIntegrado.value
            : this.aumentoIntegrado,
        conAutocalculacion: conAutocalculacion.present
            ? conAutocalculacion.value
            : this.conAutocalculacion,
        upgradeCategoria: upgradeCategoria.present
            ? upgradeCategoria.value
            : this.upgradeCategoria,
        upgradeMenor:
            upgradeMenor.present ? upgradeMenor.value : this.upgradeMenor,
        upgradePaxAdic:
            upgradePaxAdic.present ? upgradePaxAdic.value : this.upgradePaxAdic,
        tarifaBaseInt:
            tarifaBaseInt.present ? tarifaBaseInt.value : this.tarifaBaseInt,
        tarifaBase: tarifaBase.present ? tarifaBase.value : this.tarifaBase,
        creadoPorInt:
            creadoPorInt.present ? creadoPorInt.value : this.creadoPorInt,
        creadoPor: creadoPor.present ? creadoPor.value : this.creadoPor,
      );
  TarifaBaseTableData copyWithCompanion(TarifaBaseTableCompanion data) {
    return TarifaBaseTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      aumentoIntegrado: data.aumentoIntegrado.present
          ? data.aumentoIntegrado.value
          : this.aumentoIntegrado,
      conAutocalculacion: data.conAutocalculacion.present
          ? data.conAutocalculacion.value
          : this.conAutocalculacion,
      upgradeCategoria: data.upgradeCategoria.present
          ? data.upgradeCategoria.value
          : this.upgradeCategoria,
      upgradeMenor: data.upgradeMenor.present
          ? data.upgradeMenor.value
          : this.upgradeMenor,
      upgradePaxAdic: data.upgradePaxAdic.present
          ? data.upgradePaxAdic.value
          : this.upgradePaxAdic,
      tarifaBaseInt: data.tarifaBaseInt.present
          ? data.tarifaBaseInt.value
          : this.tarifaBaseInt,
      tarifaBase:
          data.tarifaBase.present ? data.tarifaBase.value : this.tarifaBase,
      creadoPorInt: data.creadoPorInt.present
          ? data.creadoPorInt.value
          : this.creadoPorInt,
      creadoPor: data.creadoPor.present ? data.creadoPor.value : this.creadoPor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TarifaBaseTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('aumentoIntegrado: $aumentoIntegrado, ')
          ..write('conAutocalculacion: $conAutocalculacion, ')
          ..write('upgradeCategoria: $upgradeCategoria, ')
          ..write('upgradeMenor: $upgradeMenor, ')
          ..write('upgradePaxAdic: $upgradePaxAdic, ')
          ..write('tarifaBaseInt: $tarifaBaseInt, ')
          ..write('tarifaBase: $tarifaBase, ')
          ..write('creadoPorInt: $creadoPorInt, ')
          ..write('creadoPor: $creadoPor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      idInt,
      id,
      codigo,
      nombre,
      aumentoIntegrado,
      conAutocalculacion,
      upgradeCategoria,
      upgradeMenor,
      upgradePaxAdic,
      tarifaBaseInt,
      tarifaBase,
      creadoPorInt,
      creadoPor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaBaseTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.nombre == this.nombre &&
          other.aumentoIntegrado == this.aumentoIntegrado &&
          other.conAutocalculacion == this.conAutocalculacion &&
          other.upgradeCategoria == this.upgradeCategoria &&
          other.upgradeMenor == this.upgradeMenor &&
          other.upgradePaxAdic == this.upgradePaxAdic &&
          other.tarifaBaseInt == this.tarifaBaseInt &&
          other.tarifaBase == this.tarifaBase &&
          other.creadoPorInt == this.creadoPorInt &&
          other.creadoPor == this.creadoPor);
}

class TarifaBaseTableCompanion extends UpdateCompanion<TarifaBaseTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<String?> codigo;
  final Value<String?> nombre;
  final Value<double?> aumentoIntegrado;
  final Value<bool?> conAutocalculacion;
  final Value<double?> upgradeCategoria;
  final Value<double?> upgradeMenor;
  final Value<double?> upgradePaxAdic;
  final Value<int?> tarifaBaseInt;
  final Value<String?> tarifaBase;
  final Value<int?> creadoPorInt;
  final Value<String?> creadoPor;
  const TarifaBaseTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.nombre = const Value.absent(),
    this.aumentoIntegrado = const Value.absent(),
    this.conAutocalculacion = const Value.absent(),
    this.upgradeCategoria = const Value.absent(),
    this.upgradeMenor = const Value.absent(),
    this.upgradePaxAdic = const Value.absent(),
    this.tarifaBaseInt = const Value.absent(),
    this.tarifaBase = const Value.absent(),
    this.creadoPorInt = const Value.absent(),
    this.creadoPor = const Value.absent(),
  });
  TarifaBaseTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.nombre = const Value.absent(),
    this.aumentoIntegrado = const Value.absent(),
    this.conAutocalculacion = const Value.absent(),
    this.upgradeCategoria = const Value.absent(),
    this.upgradeMenor = const Value.absent(),
    this.upgradePaxAdic = const Value.absent(),
    this.tarifaBaseInt = const Value.absent(),
    this.tarifaBase = const Value.absent(),
    this.creadoPorInt = const Value.absent(),
    this.creadoPor = const Value.absent(),
  });
  static Insertable<TarifaBaseTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<String>? codigo,
    Expression<String>? nombre,
    Expression<double>? aumentoIntegrado,
    Expression<bool>? conAutocalculacion,
    Expression<double>? upgradeCategoria,
    Expression<double>? upgradeMenor,
    Expression<double>? upgradePaxAdic,
    Expression<int>? tarifaBaseInt,
    Expression<String>? tarifaBase,
    Expression<int>? creadoPorInt,
    Expression<String>? creadoPor,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (codigo != null) 'codigo': codigo,
      if (nombre != null) 'nombre': nombre,
      if (aumentoIntegrado != null) 'aumento_integrado': aumentoIntegrado,
      if (conAutocalculacion != null) 'con_autocalculacion': conAutocalculacion,
      if (upgradeCategoria != null) 'upgrade_categoria': upgradeCategoria,
      if (upgradeMenor != null) 'upgrade_menor': upgradeMenor,
      if (upgradePaxAdic != null) 'upgrade_pax_adic': upgradePaxAdic,
      if (tarifaBaseInt != null) 'tarifa_base_int': tarifaBaseInt,
      if (tarifaBase != null) 'tarifa_base': tarifaBase,
      if (creadoPorInt != null) 'creado_por_int': creadoPorInt,
      if (creadoPor != null) 'creado_por': creadoPor,
    });
  }

  TarifaBaseTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<String?>? codigo,
      Value<String?>? nombre,
      Value<double?>? aumentoIntegrado,
      Value<bool?>? conAutocalculacion,
      Value<double?>? upgradeCategoria,
      Value<double?>? upgradeMenor,
      Value<double?>? upgradePaxAdic,
      Value<int?>? tarifaBaseInt,
      Value<String?>? tarifaBase,
      Value<int?>? creadoPorInt,
      Value<String?>? creadoPor}) {
    return TarifaBaseTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nombre: nombre ?? this.nombre,
      aumentoIntegrado: aumentoIntegrado ?? this.aumentoIntegrado,
      conAutocalculacion: conAutocalculacion ?? this.conAutocalculacion,
      upgradeCategoria: upgradeCategoria ?? this.upgradeCategoria,
      upgradeMenor: upgradeMenor ?? this.upgradeMenor,
      upgradePaxAdic: upgradePaxAdic ?? this.upgradePaxAdic,
      tarifaBaseInt: tarifaBaseInt ?? this.tarifaBaseInt,
      tarifaBase: tarifaBase ?? this.tarifaBase,
      creadoPorInt: creadoPorInt ?? this.creadoPorInt,
      creadoPor: creadoPor ?? this.creadoPor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (aumentoIntegrado.present) {
      map['aumento_integrado'] = Variable<double>(aumentoIntegrado.value);
    }
    if (conAutocalculacion.present) {
      map['con_autocalculacion'] = Variable<bool>(conAutocalculacion.value);
    }
    if (upgradeCategoria.present) {
      map['upgrade_categoria'] = Variable<double>(upgradeCategoria.value);
    }
    if (upgradeMenor.present) {
      map['upgrade_menor'] = Variable<double>(upgradeMenor.value);
    }
    if (upgradePaxAdic.present) {
      map['upgrade_pax_adic'] = Variable<double>(upgradePaxAdic.value);
    }
    if (tarifaBaseInt.present) {
      map['tarifa_base_int'] = Variable<int>(tarifaBaseInt.value);
    }
    if (tarifaBase.present) {
      map['tarifa_base'] = Variable<String>(tarifaBase.value);
    }
    if (creadoPorInt.present) {
      map['creado_por_int'] = Variable<int>(creadoPorInt.value);
    }
    if (creadoPor.present) {
      map['creado_por'] = Variable<String>(creadoPor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaBaseTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('aumentoIntegrado: $aumentoIntegrado, ')
          ..write('conAutocalculacion: $conAutocalculacion, ')
          ..write('upgradeCategoria: $upgradeCategoria, ')
          ..write('upgradeMenor: $upgradeMenor, ')
          ..write('upgradePaxAdic: $upgradePaxAdic, ')
          ..write('tarifaBaseInt: $tarifaBaseInt, ')
          ..write('tarifaBase: $tarifaBase, ')
          ..write('creadoPorInt: $creadoPorInt, ')
          ..write('creadoPor: $creadoPor')
          ..write(')'))
        .toString();
  }
}

class $TarifaTableTable extends TarifaTable
    with TableInfo<$TarifaTableTable, TarifaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarifaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _categoriaIntMeta =
      const VerificationMeta('categoriaInt');
  @override
  late final GeneratedColumn<int> categoriaInt = GeneratedColumn<int>(
      'categoria_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categoria_table (id)'));
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tarifaAdulto1a2Meta =
      const VerificationMeta('tarifaAdulto1a2');
  @override
  late final GeneratedColumn<double> tarifaAdulto1a2 = GeneratedColumn<double>(
      'tarifa_adulto1a2', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaAdulto3Meta =
      const VerificationMeta('tarifaAdulto3');
  @override
  late final GeneratedColumn<double> tarifaAdulto3 = GeneratedColumn<double>(
      'tarifa_adulto3', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaAdulto4Meta =
      const VerificationMeta('tarifaAdulto4');
  @override
  late final GeneratedColumn<double> tarifaAdulto4 = GeneratedColumn<double>(
      'tarifa_adulto4', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaMenores7a12Meta =
      const VerificationMeta('tarifaMenores7a12');
  @override
  late final GeneratedColumn<double> tarifaMenores7a12 =
      GeneratedColumn<double>('tarifa_menores7a12', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaMenores0a6Meta =
      const VerificationMeta('tarifaMenores0a6');
  @override
  late final GeneratedColumn<double> tarifaMenores0a6 = GeneratedColumn<double>(
      'tarifa_menores0a6', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaPaxAdicionalMeta =
      const VerificationMeta('tarifaPaxAdicional');
  @override
  late final GeneratedColumn<double> tarifaPaxAdicional =
      GeneratedColumn<double>('tarifa_pax_adicional', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaBaseIntMeta =
      const VerificationMeta('tarifaBaseInt');
  @override
  late final GeneratedColumn<int> tarifaBaseInt = GeneratedColumn<int>(
      'tarifa_base_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tarifa_base_table (id)'));
  static const VerificationMeta _tarifaBaseMeta =
      const VerificationMeta('tarifaBase');
  @override
  late final GeneratedColumn<String> tarifaBase = GeneratedColumn<String>(
      'tarifa_base', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        createdAt,
        categoriaInt,
        categoria,
        tarifaAdulto1a2,
        tarifaAdulto3,
        tarifaAdulto4,
        tarifaMenores7a12,
        tarifaMenores0a6,
        tarifaPaxAdicional,
        tarifaBaseInt,
        tarifaBase
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarifa_table';
  @override
  VerificationContext validateIntegrity(Insertable<TarifaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('categoria_int')) {
      context.handle(
          _categoriaIntMeta,
          categoriaInt.isAcceptableOrUnknown(
              data['categoria_int']!, _categoriaIntMeta));
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    }
    if (data.containsKey('tarifa_adulto1a2')) {
      context.handle(
          _tarifaAdulto1a2Meta,
          tarifaAdulto1a2.isAcceptableOrUnknown(
              data['tarifa_adulto1a2']!, _tarifaAdulto1a2Meta));
    }
    if (data.containsKey('tarifa_adulto3')) {
      context.handle(
          _tarifaAdulto3Meta,
          tarifaAdulto3.isAcceptableOrUnknown(
              data['tarifa_adulto3']!, _tarifaAdulto3Meta));
    }
    if (data.containsKey('tarifa_adulto4')) {
      context.handle(
          _tarifaAdulto4Meta,
          tarifaAdulto4.isAcceptableOrUnknown(
              data['tarifa_adulto4']!, _tarifaAdulto4Meta));
    }
    if (data.containsKey('tarifa_menores7a12')) {
      context.handle(
          _tarifaMenores7a12Meta,
          tarifaMenores7a12.isAcceptableOrUnknown(
              data['tarifa_menores7a12']!, _tarifaMenores7a12Meta));
    }
    if (data.containsKey('tarifa_menores0a6')) {
      context.handle(
          _tarifaMenores0a6Meta,
          tarifaMenores0a6.isAcceptableOrUnknown(
              data['tarifa_menores0a6']!, _tarifaMenores0a6Meta));
    }
    if (data.containsKey('tarifa_pax_adicional')) {
      context.handle(
          _tarifaPaxAdicionalMeta,
          tarifaPaxAdicional.isAcceptableOrUnknown(
              data['tarifa_pax_adicional']!, _tarifaPaxAdicionalMeta));
    }
    if (data.containsKey('tarifa_base_int')) {
      context.handle(
          _tarifaBaseIntMeta,
          tarifaBaseInt.isAcceptableOrUnknown(
              data['tarifa_base_int']!, _tarifaBaseIntMeta));
    }
    if (data.containsKey('tarifa_base')) {
      context.handle(
          _tarifaBaseMeta,
          tarifaBase.isAcceptableOrUnknown(
              data['tarifa_base']!, _tarifaBaseMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  TarifaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarifaTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      categoriaInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}categoria_int']),
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria']),
      tarifaAdulto1a2: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}tarifa_adulto1a2']),
      tarifaAdulto3: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tarifa_adulto3']),
      tarifaAdulto4: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tarifa_adulto4']),
      tarifaMenores7a12: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}tarifa_menores7a12']),
      tarifaMenores0a6: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}tarifa_menores0a6']),
      tarifaPaxAdicional: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}tarifa_pax_adicional']),
      tarifaBaseInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tarifa_base_int']),
      tarifaBase: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarifa_base']),
    );
  }

  @override
  $TarifaTableTable createAlias(String alias) {
    return $TarifaTableTable(attachedDatabase, alias);
  }
}

class TarifaTableData extends DataClass implements Insertable<TarifaTableData> {
  final int idInt;
  final String? id;
  final DateTime? createdAt;
  final int? categoriaInt;
  final String? categoria;
  final double? tarifaAdulto1a2;
  final double? tarifaAdulto3;
  final double? tarifaAdulto4;
  final double? tarifaMenores7a12;
  final double? tarifaMenores0a6;
  final double? tarifaPaxAdicional;
  final int? tarifaBaseInt;
  final String? tarifaBase;
  const TarifaTableData(
      {required this.idInt,
      this.id,
      this.createdAt,
      this.categoriaInt,
      this.categoria,
      this.tarifaAdulto1a2,
      this.tarifaAdulto3,
      this.tarifaAdulto4,
      this.tarifaMenores7a12,
      this.tarifaMenores0a6,
      this.tarifaPaxAdicional,
      this.tarifaBaseInt,
      this.tarifaBase});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || categoriaInt != null) {
      map['categoria_int'] = Variable<int>(categoriaInt);
    }
    if (!nullToAbsent || categoria != null) {
      map['categoria'] = Variable<String>(categoria);
    }
    if (!nullToAbsent || tarifaAdulto1a2 != null) {
      map['tarifa_adulto1a2'] = Variable<double>(tarifaAdulto1a2);
    }
    if (!nullToAbsent || tarifaAdulto3 != null) {
      map['tarifa_adulto3'] = Variable<double>(tarifaAdulto3);
    }
    if (!nullToAbsent || tarifaAdulto4 != null) {
      map['tarifa_adulto4'] = Variable<double>(tarifaAdulto4);
    }
    if (!nullToAbsent || tarifaMenores7a12 != null) {
      map['tarifa_menores7a12'] = Variable<double>(tarifaMenores7a12);
    }
    if (!nullToAbsent || tarifaMenores0a6 != null) {
      map['tarifa_menores0a6'] = Variable<double>(tarifaMenores0a6);
    }
    if (!nullToAbsent || tarifaPaxAdicional != null) {
      map['tarifa_pax_adicional'] = Variable<double>(tarifaPaxAdicional);
    }
    if (!nullToAbsent || tarifaBaseInt != null) {
      map['tarifa_base_int'] = Variable<int>(tarifaBaseInt);
    }
    if (!nullToAbsent || tarifaBase != null) {
      map['tarifa_base'] = Variable<String>(tarifaBase);
    }
    return map;
  }

  TarifaTableCompanion toCompanion(bool nullToAbsent) {
    return TarifaTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      categoriaInt: categoriaInt == null && nullToAbsent
          ? const Value.absent()
          : Value(categoriaInt),
      categoria: categoria == null && nullToAbsent
          ? const Value.absent()
          : Value(categoria),
      tarifaAdulto1a2: tarifaAdulto1a2 == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaAdulto1a2),
      tarifaAdulto3: tarifaAdulto3 == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaAdulto3),
      tarifaAdulto4: tarifaAdulto4 == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaAdulto4),
      tarifaMenores7a12: tarifaMenores7a12 == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaMenores7a12),
      tarifaMenores0a6: tarifaMenores0a6 == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaMenores0a6),
      tarifaPaxAdicional: tarifaPaxAdicional == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaPaxAdicional),
      tarifaBaseInt: tarifaBaseInt == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaBaseInt),
      tarifaBase: tarifaBase == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaBase),
    );
  }

  factory TarifaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      categoriaInt: serializer.fromJson<int?>(json['categoriaInt']),
      categoria: serializer.fromJson<String?>(json['categoria']),
      tarifaAdulto1a2: serializer.fromJson<double?>(json['tarifaAdulto1a2']),
      tarifaAdulto3: serializer.fromJson<double?>(json['tarifaAdulto3']),
      tarifaAdulto4: serializer.fromJson<double?>(json['tarifaAdulto4']),
      tarifaMenores7a12:
          serializer.fromJson<double?>(json['tarifaMenores7a12']),
      tarifaMenores0a6: serializer.fromJson<double?>(json['tarifaMenores0a6']),
      tarifaPaxAdicional:
          serializer.fromJson<double?>(json['tarifaPaxAdicional']),
      tarifaBaseInt: serializer.fromJson<int?>(json['tarifaBaseInt']),
      tarifaBase: serializer.fromJson<String?>(json['tarifaBase']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'categoriaInt': serializer.toJson<int?>(categoriaInt),
      'categoria': serializer.toJson<String?>(categoria),
      'tarifaAdulto1a2': serializer.toJson<double?>(tarifaAdulto1a2),
      'tarifaAdulto3': serializer.toJson<double?>(tarifaAdulto3),
      'tarifaAdulto4': serializer.toJson<double?>(tarifaAdulto4),
      'tarifaMenores7a12': serializer.toJson<double?>(tarifaMenores7a12),
      'tarifaMenores0a6': serializer.toJson<double?>(tarifaMenores0a6),
      'tarifaPaxAdicional': serializer.toJson<double?>(tarifaPaxAdicional),
      'tarifaBaseInt': serializer.toJson<int?>(tarifaBaseInt),
      'tarifaBase': serializer.toJson<String?>(tarifaBase),
    };
  }

  TarifaTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<int?> categoriaInt = const Value.absent(),
          Value<String?> categoria = const Value.absent(),
          Value<double?> tarifaAdulto1a2 = const Value.absent(),
          Value<double?> tarifaAdulto3 = const Value.absent(),
          Value<double?> tarifaAdulto4 = const Value.absent(),
          Value<double?> tarifaMenores7a12 = const Value.absent(),
          Value<double?> tarifaMenores0a6 = const Value.absent(),
          Value<double?> tarifaPaxAdicional = const Value.absent(),
          Value<int?> tarifaBaseInt = const Value.absent(),
          Value<String?> tarifaBase = const Value.absent()}) =>
      TarifaTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        categoriaInt:
            categoriaInt.present ? categoriaInt.value : this.categoriaInt,
        categoria: categoria.present ? categoria.value : this.categoria,
        tarifaAdulto1a2: tarifaAdulto1a2.present
            ? tarifaAdulto1a2.value
            : this.tarifaAdulto1a2,
        tarifaAdulto3:
            tarifaAdulto3.present ? tarifaAdulto3.value : this.tarifaAdulto3,
        tarifaAdulto4:
            tarifaAdulto4.present ? tarifaAdulto4.value : this.tarifaAdulto4,
        tarifaMenores7a12: tarifaMenores7a12.present
            ? tarifaMenores7a12.value
            : this.tarifaMenores7a12,
        tarifaMenores0a6: tarifaMenores0a6.present
            ? tarifaMenores0a6.value
            : this.tarifaMenores0a6,
        tarifaPaxAdicional: tarifaPaxAdicional.present
            ? tarifaPaxAdicional.value
            : this.tarifaPaxAdicional,
        tarifaBaseInt:
            tarifaBaseInt.present ? tarifaBaseInt.value : this.tarifaBaseInt,
        tarifaBase: tarifaBase.present ? tarifaBase.value : this.tarifaBase,
      );
  TarifaTableData copyWithCompanion(TarifaTableCompanion data) {
    return TarifaTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      categoriaInt: data.categoriaInt.present
          ? data.categoriaInt.value
          : this.categoriaInt,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      tarifaAdulto1a2: data.tarifaAdulto1a2.present
          ? data.tarifaAdulto1a2.value
          : this.tarifaAdulto1a2,
      tarifaAdulto3: data.tarifaAdulto3.present
          ? data.tarifaAdulto3.value
          : this.tarifaAdulto3,
      tarifaAdulto4: data.tarifaAdulto4.present
          ? data.tarifaAdulto4.value
          : this.tarifaAdulto4,
      tarifaMenores7a12: data.tarifaMenores7a12.present
          ? data.tarifaMenores7a12.value
          : this.tarifaMenores7a12,
      tarifaMenores0a6: data.tarifaMenores0a6.present
          ? data.tarifaMenores0a6.value
          : this.tarifaMenores0a6,
      tarifaPaxAdicional: data.tarifaPaxAdicional.present
          ? data.tarifaPaxAdicional.value
          : this.tarifaPaxAdicional,
      tarifaBaseInt: data.tarifaBaseInt.present
          ? data.tarifaBaseInt.value
          : this.tarifaBaseInt,
      tarifaBase:
          data.tarifaBase.present ? data.tarifaBase.value : this.tarifaBase,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TarifaTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('categoriaInt: $categoriaInt, ')
          ..write('categoria: $categoria, ')
          ..write('tarifaAdulto1a2: $tarifaAdulto1a2, ')
          ..write('tarifaAdulto3: $tarifaAdulto3, ')
          ..write('tarifaAdulto4: $tarifaAdulto4, ')
          ..write('tarifaMenores7a12: $tarifaMenores7a12, ')
          ..write('tarifaMenores0a6: $tarifaMenores0a6, ')
          ..write('tarifaPaxAdicional: $tarifaPaxAdicional, ')
          ..write('tarifaBaseInt: $tarifaBaseInt, ')
          ..write('tarifaBase: $tarifaBase')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      idInt,
      id,
      createdAt,
      categoriaInt,
      categoria,
      tarifaAdulto1a2,
      tarifaAdulto3,
      tarifaAdulto4,
      tarifaMenores7a12,
      tarifaMenores0a6,
      tarifaPaxAdicional,
      tarifaBaseInt,
      tarifaBase);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.categoriaInt == this.categoriaInt &&
          other.categoria == this.categoria &&
          other.tarifaAdulto1a2 == this.tarifaAdulto1a2 &&
          other.tarifaAdulto3 == this.tarifaAdulto3 &&
          other.tarifaAdulto4 == this.tarifaAdulto4 &&
          other.tarifaMenores7a12 == this.tarifaMenores7a12 &&
          other.tarifaMenores0a6 == this.tarifaMenores0a6 &&
          other.tarifaPaxAdicional == this.tarifaPaxAdicional &&
          other.tarifaBaseInt == this.tarifaBaseInt &&
          other.tarifaBase == this.tarifaBase);
}

class TarifaTableCompanion extends UpdateCompanion<TarifaTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<DateTime?> createdAt;
  final Value<int?> categoriaInt;
  final Value<String?> categoria;
  final Value<double?> tarifaAdulto1a2;
  final Value<double?> tarifaAdulto3;
  final Value<double?> tarifaAdulto4;
  final Value<double?> tarifaMenores7a12;
  final Value<double?> tarifaMenores0a6;
  final Value<double?> tarifaPaxAdicional;
  final Value<int?> tarifaBaseInt;
  final Value<String?> tarifaBase;
  const TarifaTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.categoriaInt = const Value.absent(),
    this.categoria = const Value.absent(),
    this.tarifaAdulto1a2 = const Value.absent(),
    this.tarifaAdulto3 = const Value.absent(),
    this.tarifaAdulto4 = const Value.absent(),
    this.tarifaMenores7a12 = const Value.absent(),
    this.tarifaMenores0a6 = const Value.absent(),
    this.tarifaPaxAdicional = const Value.absent(),
    this.tarifaBaseInt = const Value.absent(),
    this.tarifaBase = const Value.absent(),
  });
  TarifaTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.categoriaInt = const Value.absent(),
    this.categoria = const Value.absent(),
    this.tarifaAdulto1a2 = const Value.absent(),
    this.tarifaAdulto3 = const Value.absent(),
    this.tarifaAdulto4 = const Value.absent(),
    this.tarifaMenores7a12 = const Value.absent(),
    this.tarifaMenores0a6 = const Value.absent(),
    this.tarifaPaxAdicional = const Value.absent(),
    this.tarifaBaseInt = const Value.absent(),
    this.tarifaBase = const Value.absent(),
  });
  static Insertable<TarifaTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<int>? categoriaInt,
    Expression<String>? categoria,
    Expression<double>? tarifaAdulto1a2,
    Expression<double>? tarifaAdulto3,
    Expression<double>? tarifaAdulto4,
    Expression<double>? tarifaMenores7a12,
    Expression<double>? tarifaMenores0a6,
    Expression<double>? tarifaPaxAdicional,
    Expression<int>? tarifaBaseInt,
    Expression<String>? tarifaBase,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (categoriaInt != null) 'categoria_int': categoriaInt,
      if (categoria != null) 'categoria': categoria,
      if (tarifaAdulto1a2 != null) 'tarifa_adulto1a2': tarifaAdulto1a2,
      if (tarifaAdulto3 != null) 'tarifa_adulto3': tarifaAdulto3,
      if (tarifaAdulto4 != null) 'tarifa_adulto4': tarifaAdulto4,
      if (tarifaMenores7a12 != null) 'tarifa_menores7a12': tarifaMenores7a12,
      if (tarifaMenores0a6 != null) 'tarifa_menores0a6': tarifaMenores0a6,
      if (tarifaPaxAdicional != null)
        'tarifa_pax_adicional': tarifaPaxAdicional,
      if (tarifaBaseInt != null) 'tarifa_base_int': tarifaBaseInt,
      if (tarifaBase != null) 'tarifa_base': tarifaBase,
    });
  }

  TarifaTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<DateTime?>? createdAt,
      Value<int?>? categoriaInt,
      Value<String?>? categoria,
      Value<double?>? tarifaAdulto1a2,
      Value<double?>? tarifaAdulto3,
      Value<double?>? tarifaAdulto4,
      Value<double?>? tarifaMenores7a12,
      Value<double?>? tarifaMenores0a6,
      Value<double?>? tarifaPaxAdicional,
      Value<int?>? tarifaBaseInt,
      Value<String?>? tarifaBase}) {
    return TarifaTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      categoriaInt: categoriaInt ?? this.categoriaInt,
      categoria: categoria ?? this.categoria,
      tarifaAdulto1a2: tarifaAdulto1a2 ?? this.tarifaAdulto1a2,
      tarifaAdulto3: tarifaAdulto3 ?? this.tarifaAdulto3,
      tarifaAdulto4: tarifaAdulto4 ?? this.tarifaAdulto4,
      tarifaMenores7a12: tarifaMenores7a12 ?? this.tarifaMenores7a12,
      tarifaMenores0a6: tarifaMenores0a6 ?? this.tarifaMenores0a6,
      tarifaPaxAdicional: tarifaPaxAdicional ?? this.tarifaPaxAdicional,
      tarifaBaseInt: tarifaBaseInt ?? this.tarifaBaseInt,
      tarifaBase: tarifaBase ?? this.tarifaBase,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (categoriaInt.present) {
      map['categoria_int'] = Variable<int>(categoriaInt.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (tarifaAdulto1a2.present) {
      map['tarifa_adulto1a2'] = Variable<double>(tarifaAdulto1a2.value);
    }
    if (tarifaAdulto3.present) {
      map['tarifa_adulto3'] = Variable<double>(tarifaAdulto3.value);
    }
    if (tarifaAdulto4.present) {
      map['tarifa_adulto4'] = Variable<double>(tarifaAdulto4.value);
    }
    if (tarifaMenores7a12.present) {
      map['tarifa_menores7a12'] = Variable<double>(tarifaMenores7a12.value);
    }
    if (tarifaMenores0a6.present) {
      map['tarifa_menores0a6'] = Variable<double>(tarifaMenores0a6.value);
    }
    if (tarifaPaxAdicional.present) {
      map['tarifa_pax_adicional'] = Variable<double>(tarifaPaxAdicional.value);
    }
    if (tarifaBaseInt.present) {
      map['tarifa_base_int'] = Variable<int>(tarifaBaseInt.value);
    }
    if (tarifaBase.present) {
      map['tarifa_base'] = Variable<String>(tarifaBase.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('categoriaInt: $categoriaInt, ')
          ..write('categoria: $categoria, ')
          ..write('tarifaAdulto1a2: $tarifaAdulto1a2, ')
          ..write('tarifaAdulto3: $tarifaAdulto3, ')
          ..write('tarifaAdulto4: $tarifaAdulto4, ')
          ..write('tarifaMenores7a12: $tarifaMenores7a12, ')
          ..write('tarifaMenores0a6: $tarifaMenores0a6, ')
          ..write('tarifaPaxAdicional: $tarifaPaxAdicional, ')
          ..write('tarifaBaseInt: $tarifaBaseInt, ')
          ..write('tarifaBase: $tarifaBase')
          ..write(')'))
        .toString();
  }
}

class $TarifaXDiaTableTable extends TarifaXDiaTable
    with TableInfo<$TarifaXDiaTableTable, TarifaXDiaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarifaXDiaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tarifaRackIntMeta =
      const VerificationMeta('tarifaRackInt');
  @override
  late final GeneratedColumn<int> tarifaRackInt = GeneratedColumn<int>(
      'tarifa_rack_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tarifa_rack_table (id)'));
  static const VerificationMeta _tarifaRackMeta =
      const VerificationMeta('tarifaRack');
  @override
  late final GeneratedColumn<String> tarifaRack = GeneratedColumn<String>(
      'tarifa_rack', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descIntegradoMeta =
      const VerificationMeta('descIntegrado');
  @override
  late final GeneratedColumn<double> descIntegrado = GeneratedColumn<double>(
      'desc_integrado', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _esLibreMeta =
      const VerificationMeta('esLibre');
  @override
  late final GeneratedColumn<bool> esLibre = GeneratedColumn<bool>(
      'es_libre', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("es_libre" IN (0, 1))'));
  static const VerificationMeta _tarifaRackJsonMeta =
      const VerificationMeta('tarifaRackJson');
  @override
  late final GeneratedColumn<String> tarifaRackJson = GeneratedColumn<String>(
      'tarifa_rack_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        tarifaRackInt,
        tarifaRack,
        descIntegrado,
        esLibre,
        tarifaRackJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarifa_x_dia_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TarifaXDiaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tarifa_rack_int')) {
      context.handle(
          _tarifaRackIntMeta,
          tarifaRackInt.isAcceptableOrUnknown(
              data['tarifa_rack_int']!, _tarifaRackIntMeta));
    }
    if (data.containsKey('tarifa_rack')) {
      context.handle(
          _tarifaRackMeta,
          tarifaRack.isAcceptableOrUnknown(
              data['tarifa_rack']!, _tarifaRackMeta));
    }
    if (data.containsKey('desc_integrado')) {
      context.handle(
          _descIntegradoMeta,
          descIntegrado.isAcceptableOrUnknown(
              data['desc_integrado']!, _descIntegradoMeta));
    }
    if (data.containsKey('es_libre')) {
      context.handle(_esLibreMeta,
          esLibre.isAcceptableOrUnknown(data['es_libre']!, _esLibreMeta));
    }
    if (data.containsKey('tarifa_rack_json')) {
      context.handle(
          _tarifaRackJsonMeta,
          tarifaRackJson.isAcceptableOrUnknown(
              data['tarifa_rack_json']!, _tarifaRackJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  TarifaXDiaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarifaXDiaTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      tarifaRackInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tarifa_rack_int']),
      tarifaRack: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarifa_rack']),
      descIntegrado: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}desc_integrado']),
      esLibre: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}es_libre']),
      tarifaRackJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}tarifa_rack_json']),
    );
  }

  @override
  $TarifaXDiaTableTable createAlias(String alias) {
    return $TarifaXDiaTableTable(attachedDatabase, alias);
  }
}

class TarifaXDiaTableData extends DataClass
    implements Insertable<TarifaXDiaTableData> {
  final int idInt;
  final String? id;
  final int? tarifaRackInt;
  final String? tarifaRack;
  final double? descIntegrado;
  final bool? esLibre;
  final String? tarifaRackJson;
  const TarifaXDiaTableData(
      {required this.idInt,
      this.id,
      this.tarifaRackInt,
      this.tarifaRack,
      this.descIntegrado,
      this.esLibre,
      this.tarifaRackJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || tarifaRackInt != null) {
      map['tarifa_rack_int'] = Variable<int>(tarifaRackInt);
    }
    if (!nullToAbsent || tarifaRack != null) {
      map['tarifa_rack'] = Variable<String>(tarifaRack);
    }
    if (!nullToAbsent || descIntegrado != null) {
      map['desc_integrado'] = Variable<double>(descIntegrado);
    }
    if (!nullToAbsent || esLibre != null) {
      map['es_libre'] = Variable<bool>(esLibre);
    }
    if (!nullToAbsent || tarifaRackJson != null) {
      map['tarifa_rack_json'] = Variable<String>(tarifaRackJson);
    }
    return map;
  }

  TarifaXDiaTableCompanion toCompanion(bool nullToAbsent) {
    return TarifaXDiaTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      tarifaRackInt: tarifaRackInt == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaRackInt),
      tarifaRack: tarifaRack == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaRack),
      descIntegrado: descIntegrado == null && nullToAbsent
          ? const Value.absent()
          : Value(descIntegrado),
      esLibre: esLibre == null && nullToAbsent
          ? const Value.absent()
          : Value(esLibre),
      tarifaRackJson: tarifaRackJson == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaRackJson),
    );
  }

  factory TarifaXDiaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaXDiaTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      tarifaRackInt: serializer.fromJson<int?>(json['tarifaRackInt']),
      tarifaRack: serializer.fromJson<String?>(json['tarifaRack']),
      descIntegrado: serializer.fromJson<double?>(json['descIntegrado']),
      esLibre: serializer.fromJson<bool?>(json['esLibre']),
      tarifaRackJson: serializer.fromJson<String?>(json['tarifaRackJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'tarifaRackInt': serializer.toJson<int?>(tarifaRackInt),
      'tarifaRack': serializer.toJson<String?>(tarifaRack),
      'descIntegrado': serializer.toJson<double?>(descIntegrado),
      'esLibre': serializer.toJson<bool?>(esLibre),
      'tarifaRackJson': serializer.toJson<String?>(tarifaRackJson),
    };
  }

  TarifaXDiaTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<int?> tarifaRackInt = const Value.absent(),
          Value<String?> tarifaRack = const Value.absent(),
          Value<double?> descIntegrado = const Value.absent(),
          Value<bool?> esLibre = const Value.absent(),
          Value<String?> tarifaRackJson = const Value.absent()}) =>
      TarifaXDiaTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        tarifaRackInt:
            tarifaRackInt.present ? tarifaRackInt.value : this.tarifaRackInt,
        tarifaRack: tarifaRack.present ? tarifaRack.value : this.tarifaRack,
        descIntegrado:
            descIntegrado.present ? descIntegrado.value : this.descIntegrado,
        esLibre: esLibre.present ? esLibre.value : this.esLibre,
        tarifaRackJson:
            tarifaRackJson.present ? tarifaRackJson.value : this.tarifaRackJson,
      );
  TarifaXDiaTableData copyWithCompanion(TarifaXDiaTableCompanion data) {
    return TarifaXDiaTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      tarifaRackInt: data.tarifaRackInt.present
          ? data.tarifaRackInt.value
          : this.tarifaRackInt,
      tarifaRack:
          data.tarifaRack.present ? data.tarifaRack.value : this.tarifaRack,
      descIntegrado: data.descIntegrado.present
          ? data.descIntegrado.value
          : this.descIntegrado,
      esLibre: data.esLibre.present ? data.esLibre.value : this.esLibre,
      tarifaRackJson: data.tarifaRackJson.present
          ? data.tarifaRackJson.value
          : this.tarifaRackJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TarifaXDiaTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('tarifaRackInt: $tarifaRackInt, ')
          ..write('tarifaRack: $tarifaRack, ')
          ..write('descIntegrado: $descIntegrado, ')
          ..write('esLibre: $esLibre, ')
          ..write('tarifaRackJson: $tarifaRackJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idInt, id, tarifaRackInt, tarifaRack,
      descIntegrado, esLibre, tarifaRackJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaXDiaTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.tarifaRackInt == this.tarifaRackInt &&
          other.tarifaRack == this.tarifaRack &&
          other.descIntegrado == this.descIntegrado &&
          other.esLibre == this.esLibre &&
          other.tarifaRackJson == this.tarifaRackJson);
}

class TarifaXDiaTableCompanion extends UpdateCompanion<TarifaXDiaTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<int?> tarifaRackInt;
  final Value<String?> tarifaRack;
  final Value<double?> descIntegrado;
  final Value<bool?> esLibre;
  final Value<String?> tarifaRackJson;
  const TarifaXDiaTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.tarifaRackInt = const Value.absent(),
    this.tarifaRack = const Value.absent(),
    this.descIntegrado = const Value.absent(),
    this.esLibre = const Value.absent(),
    this.tarifaRackJson = const Value.absent(),
  });
  TarifaXDiaTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.tarifaRackInt = const Value.absent(),
    this.tarifaRack = const Value.absent(),
    this.descIntegrado = const Value.absent(),
    this.esLibre = const Value.absent(),
    this.tarifaRackJson = const Value.absent(),
  });
  static Insertable<TarifaXDiaTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<int>? tarifaRackInt,
    Expression<String>? tarifaRack,
    Expression<double>? descIntegrado,
    Expression<bool>? esLibre,
    Expression<String>? tarifaRackJson,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (tarifaRackInt != null) 'tarifa_rack_int': tarifaRackInt,
      if (tarifaRack != null) 'tarifa_rack': tarifaRack,
      if (descIntegrado != null) 'desc_integrado': descIntegrado,
      if (esLibre != null) 'es_libre': esLibre,
      if (tarifaRackJson != null) 'tarifa_rack_json': tarifaRackJson,
    });
  }

  TarifaXDiaTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<int?>? tarifaRackInt,
      Value<String?>? tarifaRack,
      Value<double?>? descIntegrado,
      Value<bool?>? esLibre,
      Value<String?>? tarifaRackJson}) {
    return TarifaXDiaTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      tarifaRackInt: tarifaRackInt ?? this.tarifaRackInt,
      tarifaRack: tarifaRack ?? this.tarifaRack,
      descIntegrado: descIntegrado ?? this.descIntegrado,
      esLibre: esLibre ?? this.esLibre,
      tarifaRackJson: tarifaRackJson ?? this.tarifaRackJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tarifaRackInt.present) {
      map['tarifa_rack_int'] = Variable<int>(tarifaRackInt.value);
    }
    if (tarifaRack.present) {
      map['tarifa_rack'] = Variable<String>(tarifaRack.value);
    }
    if (descIntegrado.present) {
      map['desc_integrado'] = Variable<double>(descIntegrado.value);
    }
    if (esLibre.present) {
      map['es_libre'] = Variable<bool>(esLibre.value);
    }
    if (tarifaRackJson.present) {
      map['tarifa_rack_json'] = Variable<String>(tarifaRackJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaXDiaTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('tarifaRackInt: $tarifaRackInt, ')
          ..write('tarifaRack: $tarifaRack, ')
          ..write('descIntegrado: $descIntegrado, ')
          ..write('esLibre: $esLibre, ')
          ..write('tarifaRackJson: $tarifaRackJson')
          ..write(')'))
        .toString();
  }
}

class $TarifaXHabitacionTableTable extends TarifaXHabitacionTable
    with TableInfo<$TarifaXHabitacionTableTable, TarifaXHabitacionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarifaXHabitacionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _habitacionIntMeta =
      const VerificationMeta('habitacionInt');
  @override
  late final GeneratedColumn<int> habitacionInt = GeneratedColumn<int>(
      'habitacion_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES habitacion_table (id)'));
  static const VerificationMeta _habitacionMeta =
      const VerificationMeta('habitacion');
  @override
  late final GeneratedColumn<String> habitacion = GeneratedColumn<String>(
      'habitacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tarifaXDiaIntMeta =
      const VerificationMeta('tarifaXDiaInt');
  @override
  late final GeneratedColumn<int> tarifaXDiaInt = GeneratedColumn<int>(
      'tarifa_x_dia_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tarifa_x_dia_table (id)'));
  static const VerificationMeta _tarifaXDiaMeta =
      const VerificationMeta('tarifaXDia');
  @override
  late final GeneratedColumn<String> tarifaXDia = GeneratedColumn<String>(
      'tarifa_x_dia', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _diaMeta = const VerificationMeta('dia');
  @override
  late final GeneratedColumn<int> dia = GeneratedColumn<int>(
      'dia', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _esGrupalMeta =
      const VerificationMeta('esGrupal');
  @override
  late final GeneratedColumn<bool> esGrupal = GeneratedColumn<bool>(
      'es_grupal', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("es_grupal" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        habitacionInt,
        habitacion,
        tarifaXDiaInt,
        tarifaXDia,
        dia,
        fecha,
        esGrupal
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarifa_x_habitacion_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TarifaXHabitacionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habitacion_int')) {
      context.handle(
          _habitacionIntMeta,
          habitacionInt.isAcceptableOrUnknown(
              data['habitacion_int']!, _habitacionIntMeta));
    }
    if (data.containsKey('habitacion')) {
      context.handle(
          _habitacionMeta,
          habitacion.isAcceptableOrUnknown(
              data['habitacion']!, _habitacionMeta));
    }
    if (data.containsKey('tarifa_x_dia_int')) {
      context.handle(
          _tarifaXDiaIntMeta,
          tarifaXDiaInt.isAcceptableOrUnknown(
              data['tarifa_x_dia_int']!, _tarifaXDiaIntMeta));
    }
    if (data.containsKey('tarifa_x_dia')) {
      context.handle(
          _tarifaXDiaMeta,
          tarifaXDia.isAcceptableOrUnknown(
              data['tarifa_x_dia']!, _tarifaXDiaMeta));
    }
    if (data.containsKey('dia')) {
      context.handle(
          _diaMeta, dia.isAcceptableOrUnknown(data['dia']!, _diaMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    }
    if (data.containsKey('es_grupal')) {
      context.handle(_esGrupalMeta,
          esGrupal.isAcceptableOrUnknown(data['es_grupal']!, _esGrupalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  TarifaXHabitacionTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarifaXHabitacionTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      habitacionInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}habitacion_int']),
      habitacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habitacion']),
      tarifaXDiaInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tarifa_x_dia_int']),
      tarifaXDia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarifa_x_dia']),
      dia: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dia']),
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha']),
      esGrupal: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}es_grupal']),
    );
  }

  @override
  $TarifaXHabitacionTableTable createAlias(String alias) {
    return $TarifaXHabitacionTableTable(attachedDatabase, alias);
  }
}

class TarifaXHabitacionTableData extends DataClass
    implements Insertable<TarifaXHabitacionTableData> {
  final int idInt;
  final String? id;
  final int? habitacionInt;
  final String? habitacion;
  final int? tarifaXDiaInt;
  final String? tarifaXDia;
  final int? dia;
  final DateTime? fecha;
  final bool? esGrupal;
  const TarifaXHabitacionTableData(
      {required this.idInt,
      this.id,
      this.habitacionInt,
      this.habitacion,
      this.tarifaXDiaInt,
      this.tarifaXDia,
      this.dia,
      this.fecha,
      this.esGrupal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || habitacionInt != null) {
      map['habitacion_int'] = Variable<int>(habitacionInt);
    }
    if (!nullToAbsent || habitacion != null) {
      map['habitacion'] = Variable<String>(habitacion);
    }
    if (!nullToAbsent || tarifaXDiaInt != null) {
      map['tarifa_x_dia_int'] = Variable<int>(tarifaXDiaInt);
    }
    if (!nullToAbsent || tarifaXDia != null) {
      map['tarifa_x_dia'] = Variable<String>(tarifaXDia);
    }
    if (!nullToAbsent || dia != null) {
      map['dia'] = Variable<int>(dia);
    }
    if (!nullToAbsent || fecha != null) {
      map['fecha'] = Variable<DateTime>(fecha);
    }
    if (!nullToAbsent || esGrupal != null) {
      map['es_grupal'] = Variable<bool>(esGrupal);
    }
    return map;
  }

  TarifaXHabitacionTableCompanion toCompanion(bool nullToAbsent) {
    return TarifaXHabitacionTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      habitacionInt: habitacionInt == null && nullToAbsent
          ? const Value.absent()
          : Value(habitacionInt),
      habitacion: habitacion == null && nullToAbsent
          ? const Value.absent()
          : Value(habitacion),
      tarifaXDiaInt: tarifaXDiaInt == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaXDiaInt),
      tarifaXDia: tarifaXDia == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaXDia),
      dia: dia == null && nullToAbsent ? const Value.absent() : Value(dia),
      fecha:
          fecha == null && nullToAbsent ? const Value.absent() : Value(fecha),
      esGrupal: esGrupal == null && nullToAbsent
          ? const Value.absent()
          : Value(esGrupal),
    );
  }

  factory TarifaXHabitacionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaXHabitacionTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      habitacionInt: serializer.fromJson<int?>(json['habitacionInt']),
      habitacion: serializer.fromJson<String?>(json['habitacion']),
      tarifaXDiaInt: serializer.fromJson<int?>(json['tarifaXDiaInt']),
      tarifaXDia: serializer.fromJson<String?>(json['tarifaXDia']),
      dia: serializer.fromJson<int?>(json['dia']),
      fecha: serializer.fromJson<DateTime?>(json['fecha']),
      esGrupal: serializer.fromJson<bool?>(json['esGrupal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'habitacionInt': serializer.toJson<int?>(habitacionInt),
      'habitacion': serializer.toJson<String?>(habitacion),
      'tarifaXDiaInt': serializer.toJson<int?>(tarifaXDiaInt),
      'tarifaXDia': serializer.toJson<String?>(tarifaXDia),
      'dia': serializer.toJson<int?>(dia),
      'fecha': serializer.toJson<DateTime?>(fecha),
      'esGrupal': serializer.toJson<bool?>(esGrupal),
    };
  }

  TarifaXHabitacionTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<int?> habitacionInt = const Value.absent(),
          Value<String?> habitacion = const Value.absent(),
          Value<int?> tarifaXDiaInt = const Value.absent(),
          Value<String?> tarifaXDia = const Value.absent(),
          Value<int?> dia = const Value.absent(),
          Value<DateTime?> fecha = const Value.absent(),
          Value<bool?> esGrupal = const Value.absent()}) =>
      TarifaXHabitacionTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        habitacionInt:
            habitacionInt.present ? habitacionInt.value : this.habitacionInt,
        habitacion: habitacion.present ? habitacion.value : this.habitacion,
        tarifaXDiaInt:
            tarifaXDiaInt.present ? tarifaXDiaInt.value : this.tarifaXDiaInt,
        tarifaXDia: tarifaXDia.present ? tarifaXDia.value : this.tarifaXDia,
        dia: dia.present ? dia.value : this.dia,
        fecha: fecha.present ? fecha.value : this.fecha,
        esGrupal: esGrupal.present ? esGrupal.value : this.esGrupal,
      );
  TarifaXHabitacionTableData copyWithCompanion(
      TarifaXHabitacionTableCompanion data) {
    return TarifaXHabitacionTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      habitacionInt: data.habitacionInt.present
          ? data.habitacionInt.value
          : this.habitacionInt,
      habitacion:
          data.habitacion.present ? data.habitacion.value : this.habitacion,
      tarifaXDiaInt: data.tarifaXDiaInt.present
          ? data.tarifaXDiaInt.value
          : this.tarifaXDiaInt,
      tarifaXDia:
          data.tarifaXDia.present ? data.tarifaXDia.value : this.tarifaXDia,
      dia: data.dia.present ? data.dia.value : this.dia,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      esGrupal: data.esGrupal.present ? data.esGrupal.value : this.esGrupal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TarifaXHabitacionTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('habitacionInt: $habitacionInt, ')
          ..write('habitacion: $habitacion, ')
          ..write('tarifaXDiaInt: $tarifaXDiaInt, ')
          ..write('tarifaXDia: $tarifaXDia, ')
          ..write('dia: $dia, ')
          ..write('fecha: $fecha, ')
          ..write('esGrupal: $esGrupal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idInt, id, habitacionInt, habitacion,
      tarifaXDiaInt, tarifaXDia, dia, fecha, esGrupal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaXHabitacionTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.habitacionInt == this.habitacionInt &&
          other.habitacion == this.habitacion &&
          other.tarifaXDiaInt == this.tarifaXDiaInt &&
          other.tarifaXDia == this.tarifaXDia &&
          other.dia == this.dia &&
          other.fecha == this.fecha &&
          other.esGrupal == this.esGrupal);
}

class TarifaXHabitacionTableCompanion
    extends UpdateCompanion<TarifaXHabitacionTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<int?> habitacionInt;
  final Value<String?> habitacion;
  final Value<int?> tarifaXDiaInt;
  final Value<String?> tarifaXDia;
  final Value<int?> dia;
  final Value<DateTime?> fecha;
  final Value<bool?> esGrupal;
  const TarifaXHabitacionTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.habitacionInt = const Value.absent(),
    this.habitacion = const Value.absent(),
    this.tarifaXDiaInt = const Value.absent(),
    this.tarifaXDia = const Value.absent(),
    this.dia = const Value.absent(),
    this.fecha = const Value.absent(),
    this.esGrupal = const Value.absent(),
  });
  TarifaXHabitacionTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.habitacionInt = const Value.absent(),
    this.habitacion = const Value.absent(),
    this.tarifaXDiaInt = const Value.absent(),
    this.tarifaXDia = const Value.absent(),
    this.dia = const Value.absent(),
    this.fecha = const Value.absent(),
    this.esGrupal = const Value.absent(),
  });
  static Insertable<TarifaXHabitacionTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<int>? habitacionInt,
    Expression<String>? habitacion,
    Expression<int>? tarifaXDiaInt,
    Expression<String>? tarifaXDia,
    Expression<int>? dia,
    Expression<DateTime>? fecha,
    Expression<bool>? esGrupal,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (habitacionInt != null) 'habitacion_int': habitacionInt,
      if (habitacion != null) 'habitacion': habitacion,
      if (tarifaXDiaInt != null) 'tarifa_x_dia_int': tarifaXDiaInt,
      if (tarifaXDia != null) 'tarifa_x_dia': tarifaXDia,
      if (dia != null) 'dia': dia,
      if (fecha != null) 'fecha': fecha,
      if (esGrupal != null) 'es_grupal': esGrupal,
    });
  }

  TarifaXHabitacionTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<int?>? habitacionInt,
      Value<String?>? habitacion,
      Value<int?>? tarifaXDiaInt,
      Value<String?>? tarifaXDia,
      Value<int?>? dia,
      Value<DateTime?>? fecha,
      Value<bool?>? esGrupal}) {
    return TarifaXHabitacionTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      habitacionInt: habitacionInt ?? this.habitacionInt,
      habitacion: habitacion ?? this.habitacion,
      tarifaXDiaInt: tarifaXDiaInt ?? this.tarifaXDiaInt,
      tarifaXDia: tarifaXDia ?? this.tarifaXDia,
      dia: dia ?? this.dia,
      fecha: fecha ?? this.fecha,
      esGrupal: esGrupal ?? this.esGrupal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitacionInt.present) {
      map['habitacion_int'] = Variable<int>(habitacionInt.value);
    }
    if (habitacion.present) {
      map['habitacion'] = Variable<String>(habitacion.value);
    }
    if (tarifaXDiaInt.present) {
      map['tarifa_x_dia_int'] = Variable<int>(tarifaXDiaInt.value);
    }
    if (tarifaXDia.present) {
      map['tarifa_x_dia'] = Variable<String>(tarifaXDia.value);
    }
    if (dia.present) {
      map['dia'] = Variable<int>(dia.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (esGrupal.present) {
      map['es_grupal'] = Variable<bool>(esGrupal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaXHabitacionTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('habitacionInt: $habitacionInt, ')
          ..write('habitacion: $habitacion, ')
          ..write('tarifaXDiaInt: $tarifaXDiaInt, ')
          ..write('tarifaXDia: $tarifaXDia, ')
          ..write('dia: $dia, ')
          ..write('fecha: $fecha, ')
          ..write('esGrupal: $esGrupal')
          ..write(')'))
        .toString();
  }
}

class $TemporadaTableTable extends TemporadaTable
    with TableInfo<$TemporadaTableTable, TemporadaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemporadaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estanciaMinimaMeta =
      const VerificationMeta('estanciaMinima');
  @override
  late final GeneratedColumn<int> estanciaMinima = GeneratedColumn<int>(
      'estancia_minima', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _descuentoMeta =
      const VerificationMeta('descuento');
  @override
  late final GeneratedColumn<double> descuento = GeneratedColumn<double>(
      'descuento', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _ocupMinMeta =
      const VerificationMeta('ocupMin');
  @override
  late final GeneratedColumn<double> ocupMin = GeneratedColumn<double>(
      'ocup_min', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _ocupMaxMeta =
      const VerificationMeta('ocupMax');
  @override
  late final GeneratedColumn<double> ocupMax = GeneratedColumn<double>(
      'ocup_max', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaRackIntMeta =
      const VerificationMeta('tarifaRackInt');
  @override
  late final GeneratedColumn<int> tarifaRackInt = GeneratedColumn<int>(
      'tarifa_rack_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tarifa_rack_table (id)'));
  static const VerificationMeta _tarifaRackMeta =
      const VerificationMeta('tarifaRack');
  @override
  late final GeneratedColumn<String> tarifaRack = GeneratedColumn<String>(
      'tarifa_rack', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        idInt,
        id,
        tipo,
        createdAt,
        nombre,
        estanciaMinima,
        descuento,
        ocupMin,
        ocupMax,
        tarifaRackInt,
        tarifaRack
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'temporada_table';
  @override
  VerificationContext validateIntegrity(Insertable<TemporadaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('estancia_minima')) {
      context.handle(
          _estanciaMinimaMeta,
          estanciaMinima.isAcceptableOrUnknown(
              data['estancia_minima']!, _estanciaMinimaMeta));
    }
    if (data.containsKey('descuento')) {
      context.handle(_descuentoMeta,
          descuento.isAcceptableOrUnknown(data['descuento']!, _descuentoMeta));
    }
    if (data.containsKey('ocup_min')) {
      context.handle(_ocupMinMeta,
          ocupMin.isAcceptableOrUnknown(data['ocup_min']!, _ocupMinMeta));
    }
    if (data.containsKey('ocup_max')) {
      context.handle(_ocupMaxMeta,
          ocupMax.isAcceptableOrUnknown(data['ocup_max']!, _ocupMaxMeta));
    }
    if (data.containsKey('tarifa_rack_int')) {
      context.handle(
          _tarifaRackIntMeta,
          tarifaRackInt.isAcceptableOrUnknown(
              data['tarifa_rack_int']!, _tarifaRackIntMeta));
    }
    if (data.containsKey('tarifa_rack')) {
      context.handle(
          _tarifaRackMeta,
          tarifaRack.isAcceptableOrUnknown(
              data['tarifa_rack']!, _tarifaRackMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  TemporadaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemporadaTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      estanciaMinima: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}estancia_minima']),
      descuento: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}descuento']),
      ocupMin: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ocup_min']),
      ocupMax: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ocup_max']),
      tarifaRackInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tarifa_rack_int']),
      tarifaRack: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarifa_rack']),
    );
  }

  @override
  $TemporadaTableTable createAlias(String alias) {
    return $TemporadaTableTable(attachedDatabase, alias);
  }
}

class TemporadaTableData extends DataClass
    implements Insertable<TemporadaTableData> {
  final int idInt;
  final String? id;
  final String? tipo;
  final DateTime? createdAt;
  final String nombre;
  final int? estanciaMinima;
  final double? descuento;
  final double? ocupMin;
  final double? ocupMax;
  final int? tarifaRackInt;
  final String? tarifaRack;
  const TemporadaTableData(
      {required this.idInt,
      this.id,
      this.tipo,
      this.createdAt,
      required this.nombre,
      this.estanciaMinima,
      this.descuento,
      this.ocupMin,
      this.ocupMax,
      this.tarifaRackInt,
      this.tarifaRack});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || tipo != null) {
      map['tipo'] = Variable<String>(tipo);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || estanciaMinima != null) {
      map['estancia_minima'] = Variable<int>(estanciaMinima);
    }
    if (!nullToAbsent || descuento != null) {
      map['descuento'] = Variable<double>(descuento);
    }
    if (!nullToAbsent || ocupMin != null) {
      map['ocup_min'] = Variable<double>(ocupMin);
    }
    if (!nullToAbsent || ocupMax != null) {
      map['ocup_max'] = Variable<double>(ocupMax);
    }
    if (!nullToAbsent || tarifaRackInt != null) {
      map['tarifa_rack_int'] = Variable<int>(tarifaRackInt);
    }
    if (!nullToAbsent || tarifaRack != null) {
      map['tarifa_rack'] = Variable<String>(tarifaRack);
    }
    return map;
  }

  TemporadaTableCompanion toCompanion(bool nullToAbsent) {
    return TemporadaTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      tipo: tipo == null && nullToAbsent ? const Value.absent() : Value(tipo),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      nombre: Value(nombre),
      estanciaMinima: estanciaMinima == null && nullToAbsent
          ? const Value.absent()
          : Value(estanciaMinima),
      descuento: descuento == null && nullToAbsent
          ? const Value.absent()
          : Value(descuento),
      ocupMin: ocupMin == null && nullToAbsent
          ? const Value.absent()
          : Value(ocupMin),
      ocupMax: ocupMax == null && nullToAbsent
          ? const Value.absent()
          : Value(ocupMax),
      tarifaRackInt: tarifaRackInt == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaRackInt),
      tarifaRack: tarifaRack == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaRack),
    );
  }

  factory TemporadaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemporadaTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      tipo: serializer.fromJson<String?>(json['tipo']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      nombre: serializer.fromJson<String>(json['nombre']),
      estanciaMinima: serializer.fromJson<int?>(json['estanciaMinima']),
      descuento: serializer.fromJson<double?>(json['descuento']),
      ocupMin: serializer.fromJson<double?>(json['ocupMin']),
      ocupMax: serializer.fromJson<double?>(json['ocupMax']),
      tarifaRackInt: serializer.fromJson<int?>(json['tarifaRackInt']),
      tarifaRack: serializer.fromJson<String?>(json['tarifaRack']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'tipo': serializer.toJson<String?>(tipo),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'nombre': serializer.toJson<String>(nombre),
      'estanciaMinima': serializer.toJson<int?>(estanciaMinima),
      'descuento': serializer.toJson<double?>(descuento),
      'ocupMin': serializer.toJson<double?>(ocupMin),
      'ocupMax': serializer.toJson<double?>(ocupMax),
      'tarifaRackInt': serializer.toJson<int?>(tarifaRackInt),
      'tarifaRack': serializer.toJson<String?>(tarifaRack),
    };
  }

  TemporadaTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<String?> tipo = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          String? nombre,
          Value<int?> estanciaMinima = const Value.absent(),
          Value<double?> descuento = const Value.absent(),
          Value<double?> ocupMin = const Value.absent(),
          Value<double?> ocupMax = const Value.absent(),
          Value<int?> tarifaRackInt = const Value.absent(),
          Value<String?> tarifaRack = const Value.absent()}) =>
      TemporadaTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        tipo: tipo.present ? tipo.value : this.tipo,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        nombre: nombre ?? this.nombre,
        estanciaMinima:
            estanciaMinima.present ? estanciaMinima.value : this.estanciaMinima,
        descuento: descuento.present ? descuento.value : this.descuento,
        ocupMin: ocupMin.present ? ocupMin.value : this.ocupMin,
        ocupMax: ocupMax.present ? ocupMax.value : this.ocupMax,
        tarifaRackInt:
            tarifaRackInt.present ? tarifaRackInt.value : this.tarifaRackInt,
        tarifaRack: tarifaRack.present ? tarifaRack.value : this.tarifaRack,
      );
  TemporadaTableData copyWithCompanion(TemporadaTableCompanion data) {
    return TemporadaTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      estanciaMinima: data.estanciaMinima.present
          ? data.estanciaMinima.value
          : this.estanciaMinima,
      descuento: data.descuento.present ? data.descuento.value : this.descuento,
      ocupMin: data.ocupMin.present ? data.ocupMin.value : this.ocupMin,
      ocupMax: data.ocupMax.present ? data.ocupMax.value : this.ocupMax,
      tarifaRackInt: data.tarifaRackInt.present
          ? data.tarifaRackInt.value
          : this.tarifaRackInt,
      tarifaRack:
          data.tarifaRack.present ? data.tarifaRack.value : this.tarifaRack,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemporadaTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('createdAt: $createdAt, ')
          ..write('nombre: $nombre, ')
          ..write('estanciaMinima: $estanciaMinima, ')
          ..write('descuento: $descuento, ')
          ..write('ocupMin: $ocupMin, ')
          ..write('ocupMax: $ocupMax, ')
          ..write('tarifaRackInt: $tarifaRackInt, ')
          ..write('tarifaRack: $tarifaRack')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idInt, id, tipo, createdAt, nombre,
      estanciaMinima, descuento, ocupMin, ocupMax, tarifaRackInt, tarifaRack);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemporadaTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.tipo == this.tipo &&
          other.createdAt == this.createdAt &&
          other.nombre == this.nombre &&
          other.estanciaMinima == this.estanciaMinima &&
          other.descuento == this.descuento &&
          other.ocupMin == this.ocupMin &&
          other.ocupMax == this.ocupMax &&
          other.tarifaRackInt == this.tarifaRackInt &&
          other.tarifaRack == this.tarifaRack);
}

class TemporadaTableCompanion extends UpdateCompanion<TemporadaTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<String?> tipo;
  final Value<DateTime?> createdAt;
  final Value<String> nombre;
  final Value<int?> estanciaMinima;
  final Value<double?> descuento;
  final Value<double?> ocupMin;
  final Value<double?> ocupMax;
  final Value<int?> tarifaRackInt;
  final Value<String?> tarifaRack;
  const TemporadaTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.nombre = const Value.absent(),
    this.estanciaMinima = const Value.absent(),
    this.descuento = const Value.absent(),
    this.ocupMin = const Value.absent(),
    this.ocupMax = const Value.absent(),
    this.tarifaRackInt = const Value.absent(),
    this.tarifaRack = const Value.absent(),
  });
  TemporadaTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String nombre,
    this.estanciaMinima = const Value.absent(),
    this.descuento = const Value.absent(),
    this.ocupMin = const Value.absent(),
    this.ocupMax = const Value.absent(),
    this.tarifaRackInt = const Value.absent(),
    this.tarifaRack = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<TemporadaTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<String>? tipo,
    Expression<DateTime>? createdAt,
    Expression<String>? nombre,
    Expression<int>? estanciaMinima,
    Expression<double>? descuento,
    Expression<double>? ocupMin,
    Expression<double>? ocupMax,
    Expression<int>? tarifaRackInt,
    Expression<String>? tarifaRack,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (tipo != null) 'tipo': tipo,
      if (createdAt != null) 'created_at': createdAt,
      if (nombre != null) 'nombre': nombre,
      if (estanciaMinima != null) 'estancia_minima': estanciaMinima,
      if (descuento != null) 'descuento': descuento,
      if (ocupMin != null) 'ocup_min': ocupMin,
      if (ocupMax != null) 'ocup_max': ocupMax,
      if (tarifaRackInt != null) 'tarifa_rack_int': tarifaRackInt,
      if (tarifaRack != null) 'tarifa_rack': tarifaRack,
    });
  }

  TemporadaTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<String?>? tipo,
      Value<DateTime?>? createdAt,
      Value<String>? nombre,
      Value<int?>? estanciaMinima,
      Value<double?>? descuento,
      Value<double?>? ocupMin,
      Value<double?>? ocupMax,
      Value<int?>? tarifaRackInt,
      Value<String?>? tarifaRack}) {
    return TemporadaTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      createdAt: createdAt ?? this.createdAt,
      nombre: nombre ?? this.nombre,
      estanciaMinima: estanciaMinima ?? this.estanciaMinima,
      descuento: descuento ?? this.descuento,
      ocupMin: ocupMin ?? this.ocupMin,
      ocupMax: ocupMax ?? this.ocupMax,
      tarifaRackInt: tarifaRackInt ?? this.tarifaRackInt,
      tarifaRack: tarifaRack ?? this.tarifaRack,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (estanciaMinima.present) {
      map['estancia_minima'] = Variable<int>(estanciaMinima.value);
    }
    if (descuento.present) {
      map['descuento'] = Variable<double>(descuento.value);
    }
    if (ocupMin.present) {
      map['ocup_min'] = Variable<double>(ocupMin.value);
    }
    if (ocupMax.present) {
      map['ocup_max'] = Variable<double>(ocupMax.value);
    }
    if (tarifaRackInt.present) {
      map['tarifa_rack_int'] = Variable<int>(tarifaRackInt.value);
    }
    if (tarifaRack.present) {
      map['tarifa_rack'] = Variable<String>(tarifaRack.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemporadaTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('createdAt: $createdAt, ')
          ..write('nombre: $nombre, ')
          ..write('estanciaMinima: $estanciaMinima, ')
          ..write('descuento: $descuento, ')
          ..write('ocupMin: $ocupMin, ')
          ..write('ocupMax: $ocupMax, ')
          ..write('tarifaRackInt: $tarifaRackInt, ')
          ..write('tarifaRack: $tarifaRack')
          ..write(')'))
        .toString();
  }
}

class $TarifaTemporadaTableTable extends TarifaTemporadaTable
    with TableInfo<$TarifaTemporadaTableTable, TarifaTemporadaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarifaTemporadaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idIntMeta = const VerificationMeta('idInt');
  @override
  late final GeneratedColumn<int> idInt = GeneratedColumn<int>(
      'id_int', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _temporadaIntMeta =
      const VerificationMeta('temporadaInt');
  @override
  late final GeneratedColumn<int> temporadaInt = GeneratedColumn<int>(
      'temporada_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES temporada_table (id)'));
  static const VerificationMeta _temporadaMeta =
      const VerificationMeta('temporada');
  @override
  late final GeneratedColumn<String> temporada = GeneratedColumn<String>(
      'temporada', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tarifaIntMeta =
      const VerificationMeta('tarifaInt');
  @override
  late final GeneratedColumn<int> tarifaInt = GeneratedColumn<int>(
      'tarifa_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tarifa_table (id)'));
  static const VerificationMeta _tarifaMeta = const VerificationMeta('tarifa');
  @override
  late final GeneratedColumn<String> tarifa = GeneratedColumn<String>(
      'tarifa', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [idInt, id, temporadaInt, temporada, tarifaInt, tarifa];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarifa_temporada_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TarifaTemporadaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_int')) {
      context.handle(
          _idIntMeta, idInt.isAcceptableOrUnknown(data['id_int']!, _idIntMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('temporada_int')) {
      context.handle(
          _temporadaIntMeta,
          temporadaInt.isAcceptableOrUnknown(
              data['temporada_int']!, _temporadaIntMeta));
    }
    if (data.containsKey('temporada')) {
      context.handle(_temporadaMeta,
          temporada.isAcceptableOrUnknown(data['temporada']!, _temporadaMeta));
    }
    if (data.containsKey('tarifa_int')) {
      context.handle(_tarifaIntMeta,
          tarifaInt.isAcceptableOrUnknown(data['tarifa_int']!, _tarifaIntMeta));
    }
    if (data.containsKey('tarifa')) {
      context.handle(_tarifaMeta,
          tarifa.isAcceptableOrUnknown(data['tarifa']!, _tarifaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idInt};
  @override
  TarifaTemporadaTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarifaTemporadaTableData(
      idInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_int'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      temporadaInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}temporada_int']),
      temporada: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}temporada']),
      tarifaInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tarifa_int']),
      tarifa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarifa']),
    );
  }

  @override
  $TarifaTemporadaTableTable createAlias(String alias) {
    return $TarifaTemporadaTableTable(attachedDatabase, alias);
  }
}

class TarifaTemporadaTableData extends DataClass
    implements Insertable<TarifaTemporadaTableData> {
  final int idInt;
  final String? id;
  final int? temporadaInt;
  final String? temporada;
  final int? tarifaInt;
  final String? tarifa;
  const TarifaTemporadaTableData(
      {required this.idInt,
      this.id,
      this.temporadaInt,
      this.temporada,
      this.tarifaInt,
      this.tarifa});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_int'] = Variable<int>(idInt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || temporadaInt != null) {
      map['temporada_int'] = Variable<int>(temporadaInt);
    }
    if (!nullToAbsent || temporada != null) {
      map['temporada'] = Variable<String>(temporada);
    }
    if (!nullToAbsent || tarifaInt != null) {
      map['tarifa_int'] = Variable<int>(tarifaInt);
    }
    if (!nullToAbsent || tarifa != null) {
      map['tarifa'] = Variable<String>(tarifa);
    }
    return map;
  }

  TarifaTemporadaTableCompanion toCompanion(bool nullToAbsent) {
    return TarifaTemporadaTableCompanion(
      idInt: Value(idInt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      temporadaInt: temporadaInt == null && nullToAbsent
          ? const Value.absent()
          : Value(temporadaInt),
      temporada: temporada == null && nullToAbsent
          ? const Value.absent()
          : Value(temporada),
      tarifaInt: tarifaInt == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaInt),
      tarifa:
          tarifa == null && nullToAbsent ? const Value.absent() : Value(tarifa),
    );
  }

  factory TarifaTemporadaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaTemporadaTableData(
      idInt: serializer.fromJson<int>(json['idInt']),
      id: serializer.fromJson<String?>(json['id']),
      temporadaInt: serializer.fromJson<int?>(json['temporadaInt']),
      temporada: serializer.fromJson<String?>(json['temporada']),
      tarifaInt: serializer.fromJson<int?>(json['tarifaInt']),
      tarifa: serializer.fromJson<String?>(json['tarifa']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idInt': serializer.toJson<int>(idInt),
      'id': serializer.toJson<String?>(id),
      'temporadaInt': serializer.toJson<int?>(temporadaInt),
      'temporada': serializer.toJson<String?>(temporada),
      'tarifaInt': serializer.toJson<int?>(tarifaInt),
      'tarifa': serializer.toJson<String?>(tarifa),
    };
  }

  TarifaTemporadaTableData copyWith(
          {int? idInt,
          Value<String?> id = const Value.absent(),
          Value<int?> temporadaInt = const Value.absent(),
          Value<String?> temporada = const Value.absent(),
          Value<int?> tarifaInt = const Value.absent(),
          Value<String?> tarifa = const Value.absent()}) =>
      TarifaTemporadaTableData(
        idInt: idInt ?? this.idInt,
        id: id.present ? id.value : this.id,
        temporadaInt:
            temporadaInt.present ? temporadaInt.value : this.temporadaInt,
        temporada: temporada.present ? temporada.value : this.temporada,
        tarifaInt: tarifaInt.present ? tarifaInt.value : this.tarifaInt,
        tarifa: tarifa.present ? tarifa.value : this.tarifa,
      );
  TarifaTemporadaTableData copyWithCompanion(
      TarifaTemporadaTableCompanion data) {
    return TarifaTemporadaTableData(
      idInt: data.idInt.present ? data.idInt.value : this.idInt,
      id: data.id.present ? data.id.value : this.id,
      temporadaInt: data.temporadaInt.present
          ? data.temporadaInt.value
          : this.temporadaInt,
      temporada: data.temporada.present ? data.temporada.value : this.temporada,
      tarifaInt: data.tarifaInt.present ? data.tarifaInt.value : this.tarifaInt,
      tarifa: data.tarifa.present ? data.tarifa.value : this.tarifa,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TarifaTemporadaTableData(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('temporadaInt: $temporadaInt, ')
          ..write('temporada: $temporada, ')
          ..write('tarifaInt: $tarifaInt, ')
          ..write('tarifa: $tarifa')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(idInt, id, temporadaInt, temporada, tarifaInt, tarifa);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaTemporadaTableData &&
          other.idInt == this.idInt &&
          other.id == this.id &&
          other.temporadaInt == this.temporadaInt &&
          other.temporada == this.temporada &&
          other.tarifaInt == this.tarifaInt &&
          other.tarifa == this.tarifa);
}

class TarifaTemporadaTableCompanion
    extends UpdateCompanion<TarifaTemporadaTableData> {
  final Value<int> idInt;
  final Value<String?> id;
  final Value<int?> temporadaInt;
  final Value<String?> temporada;
  final Value<int?> tarifaInt;
  final Value<String?> tarifa;
  const TarifaTemporadaTableCompanion({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.temporadaInt = const Value.absent(),
    this.temporada = const Value.absent(),
    this.tarifaInt = const Value.absent(),
    this.tarifa = const Value.absent(),
  });
  TarifaTemporadaTableCompanion.insert({
    this.idInt = const Value.absent(),
    this.id = const Value.absent(),
    this.temporadaInt = const Value.absent(),
    this.temporada = const Value.absent(),
    this.tarifaInt = const Value.absent(),
    this.tarifa = const Value.absent(),
  });
  static Insertable<TarifaTemporadaTableData> custom({
    Expression<int>? idInt,
    Expression<String>? id,
    Expression<int>? temporadaInt,
    Expression<String>? temporada,
    Expression<int>? tarifaInt,
    Expression<String>? tarifa,
  }) {
    return RawValuesInsertable({
      if (idInt != null) 'id_int': idInt,
      if (id != null) 'id': id,
      if (temporadaInt != null) 'temporada_int': temporadaInt,
      if (temporada != null) 'temporada': temporada,
      if (tarifaInt != null) 'tarifa_int': tarifaInt,
      if (tarifa != null) 'tarifa': tarifa,
    });
  }

  TarifaTemporadaTableCompanion copyWith(
      {Value<int>? idInt,
      Value<String?>? id,
      Value<int?>? temporadaInt,
      Value<String?>? temporada,
      Value<int?>? tarifaInt,
      Value<String?>? tarifa}) {
    return TarifaTemporadaTableCompanion(
      idInt: idInt ?? this.idInt,
      id: id ?? this.id,
      temporadaInt: temporadaInt ?? this.temporadaInt,
      temporada: temporada ?? this.temporada,
      tarifaInt: tarifaInt ?? this.tarifaInt,
      tarifa: tarifa ?? this.tarifa,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idInt.present) {
      map['id_int'] = Variable<int>(idInt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (temporadaInt.present) {
      map['temporada_int'] = Variable<int>(temporadaInt.value);
    }
    if (temporada.present) {
      map['temporada'] = Variable<String>(temporada.value);
    }
    if (tarifaInt.present) {
      map['tarifa_int'] = Variable<int>(tarifaInt.value);
    }
    if (tarifa.present) {
      map['tarifa'] = Variable<String>(tarifa.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaTemporadaTableCompanion(')
          ..write('idInt: $idInt, ')
          ..write('id: $id, ')
          ..write('temporadaInt: $temporadaInt, ')
          ..write('temporada: $temporada, ')
          ..write('tarifaInt: $tarifaInt, ')
          ..write('tarifa: $tarifa')
          ..write(')'))
        .toString();
  }
}

class $ReservacionBrazaleteTableTable extends ReservacionBrazaleteTable
    with
        TableInfo<$ReservacionBrazaleteTableTable,
            ReservacionBrazaleteTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReservacionBrazaleteTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _reservacionIntMeta =
      const VerificationMeta('reservacionInt');
  @override
  late final GeneratedColumn<int> reservacionInt = GeneratedColumn<int>(
      'reservacion_int', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES reservacion_table (id)'));
  static const VerificationMeta _reservacionMeta =
      const VerificationMeta('reservacion');
  @override
  late final GeneratedColumn<String> reservacion = GeneratedColumn<String>(
      'reservacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _folioReservacionMeta =
      const VerificationMeta('folioReservacion');
  @override
  late final GeneratedColumn<String> folioReservacion = GeneratedColumn<String>(
      'folio_reservacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [reservacionInt, reservacion, codigo, folioReservacion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reservacion_brazalete_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ReservacionBrazaleteTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('reservacion_int')) {
      context.handle(
          _reservacionIntMeta,
          reservacionInt.isAcceptableOrUnknown(
              data['reservacion_int']!, _reservacionIntMeta));
    }
    if (data.containsKey('reservacion')) {
      context.handle(
          _reservacionMeta,
          reservacion.isAcceptableOrUnknown(
              data['reservacion']!, _reservacionMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('folio_reservacion')) {
      context.handle(
          _folioReservacionMeta,
          folioReservacion.isAcceptableOrUnknown(
              data['folio_reservacion']!, _folioReservacionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ReservacionBrazaleteTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReservacionBrazaleteTableData(
      reservacionInt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reservacion_int']),
      reservacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reservacion']),
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo']),
      folioReservacion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}folio_reservacion']),
    );
  }

  @override
  $ReservacionBrazaleteTableTable createAlias(String alias) {
    return $ReservacionBrazaleteTableTable(attachedDatabase, alias);
  }
}

class ReservacionBrazaleteTableData extends DataClass
    implements Insertable<ReservacionBrazaleteTableData> {
  final int? reservacionInt;
  final String? reservacion;
  final String? codigo;
  final String? folioReservacion;
  const ReservacionBrazaleteTableData(
      {this.reservacionInt,
      this.reservacion,
      this.codigo,
      this.folioReservacion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || reservacionInt != null) {
      map['reservacion_int'] = Variable<int>(reservacionInt);
    }
    if (!nullToAbsent || reservacion != null) {
      map['reservacion'] = Variable<String>(reservacion);
    }
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<String>(codigo);
    }
    if (!nullToAbsent || folioReservacion != null) {
      map['folio_reservacion'] = Variable<String>(folioReservacion);
    }
    return map;
  }

  ReservacionBrazaleteTableCompanion toCompanion(bool nullToAbsent) {
    return ReservacionBrazaleteTableCompanion(
      reservacionInt: reservacionInt == null && nullToAbsent
          ? const Value.absent()
          : Value(reservacionInt),
      reservacion: reservacion == null && nullToAbsent
          ? const Value.absent()
          : Value(reservacion),
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      folioReservacion: folioReservacion == null && nullToAbsent
          ? const Value.absent()
          : Value(folioReservacion),
    );
  }

  factory ReservacionBrazaleteTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReservacionBrazaleteTableData(
      reservacionInt: serializer.fromJson<int?>(json['reservacionInt']),
      reservacion: serializer.fromJson<String?>(json['reservacion']),
      codigo: serializer.fromJson<String?>(json['codigo']),
      folioReservacion: serializer.fromJson<String?>(json['folioReservacion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'reservacionInt': serializer.toJson<int?>(reservacionInt),
      'reservacion': serializer.toJson<String?>(reservacion),
      'codigo': serializer.toJson<String?>(codigo),
      'folioReservacion': serializer.toJson<String?>(folioReservacion),
    };
  }

  ReservacionBrazaleteTableData copyWith(
          {Value<int?> reservacionInt = const Value.absent(),
          Value<String?> reservacion = const Value.absent(),
          Value<String?> codigo = const Value.absent(),
          Value<String?> folioReservacion = const Value.absent()}) =>
      ReservacionBrazaleteTableData(
        reservacionInt:
            reservacionInt.present ? reservacionInt.value : this.reservacionInt,
        reservacion: reservacion.present ? reservacion.value : this.reservacion,
        codigo: codigo.present ? codigo.value : this.codigo,
        folioReservacion: folioReservacion.present
            ? folioReservacion.value
            : this.folioReservacion,
      );
  ReservacionBrazaleteTableData copyWithCompanion(
      ReservacionBrazaleteTableCompanion data) {
    return ReservacionBrazaleteTableData(
      reservacionInt: data.reservacionInt.present
          ? data.reservacionInt.value
          : this.reservacionInt,
      reservacion:
          data.reservacion.present ? data.reservacion.value : this.reservacion,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      folioReservacion: data.folioReservacion.present
          ? data.folioReservacion.value
          : this.folioReservacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReservacionBrazaleteTableData(')
          ..write('reservacionInt: $reservacionInt, ')
          ..write('reservacion: $reservacion, ')
          ..write('codigo: $codigo, ')
          ..write('folioReservacion: $folioReservacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(reservacionInt, reservacion, codigo, folioReservacion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReservacionBrazaleteTableData &&
          other.reservacionInt == this.reservacionInt &&
          other.reservacion == this.reservacion &&
          other.codigo == this.codigo &&
          other.folioReservacion == this.folioReservacion);
}

class ReservacionBrazaleteTableCompanion
    extends UpdateCompanion<ReservacionBrazaleteTableData> {
  final Value<int?> reservacionInt;
  final Value<String?> reservacion;
  final Value<String?> codigo;
  final Value<String?> folioReservacion;
  final Value<int> rowid;
  const ReservacionBrazaleteTableCompanion({
    this.reservacionInt = const Value.absent(),
    this.reservacion = const Value.absent(),
    this.codigo = const Value.absent(),
    this.folioReservacion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReservacionBrazaleteTableCompanion.insert({
    this.reservacionInt = const Value.absent(),
    this.reservacion = const Value.absent(),
    this.codigo = const Value.absent(),
    this.folioReservacion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<ReservacionBrazaleteTableData> custom({
    Expression<int>? reservacionInt,
    Expression<String>? reservacion,
    Expression<String>? codigo,
    Expression<String>? folioReservacion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (reservacionInt != null) 'reservacion_int': reservacionInt,
      if (reservacion != null) 'reservacion': reservacion,
      if (codigo != null) 'codigo': codigo,
      if (folioReservacion != null) 'folio_reservacion': folioReservacion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReservacionBrazaleteTableCompanion copyWith(
      {Value<int?>? reservacionInt,
      Value<String?>? reservacion,
      Value<String?>? codigo,
      Value<String?>? folioReservacion,
      Value<int>? rowid}) {
    return ReservacionBrazaleteTableCompanion(
      reservacionInt: reservacionInt ?? this.reservacionInt,
      reservacion: reservacion ?? this.reservacion,
      codigo: codigo ?? this.codigo,
      folioReservacion: folioReservacion ?? this.folioReservacion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (reservacionInt.present) {
      map['reservacion_int'] = Variable<int>(reservacionInt.value);
    }
    if (reservacion.present) {
      map['reservacion'] = Variable<String>(reservacion.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (folioReservacion.present) {
      map['folio_reservacion'] = Variable<String>(folioReservacion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReservacionBrazaleteTableCompanion(')
          ..write('reservacionInt: $reservacionInt, ')
          ..write('reservacion: $reservacion, ')
          ..write('codigo: $codigo, ')
          ..write('folioReservacion: $folioReservacion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TipoHabitacionTableTable tipoHabitacionTable =
      $TipoHabitacionTableTable(this);
  late final $ImagenTableTable imagenTable = $ImagenTableTable(this);
  late final $RolTableTable rolTable = $RolTableTable(this);
  late final $UsuarioTableTable usuarioTable = $UsuarioTableTable(this);
  late final $CategoriaTableTable categoriaTable = $CategoriaTableTable(this);
  late final $ClienteTableTable clienteTable = $ClienteTableTable(this);
  late final $CotizacionTableTable cotizacionTable =
      $CotizacionTableTable(this);
  late final $HabitacionTableTable habitacionTable =
      $HabitacionTableTable(this);
  late final $NotificacionTableTable notificacionTable =
      $NotificacionTableTable(this);
  late final $TarifaRackTableTable tarifaRackTable =
      $TarifaRackTableTable(this);
  late final $PeriodoTableTable periodoTable = $PeriodoTableTable(this);
  late final $PoliticaTarifarioTableTable politicaTarifarioTable =
      $PoliticaTarifarioTableTable(this);
  late final $ReservacionTableTable reservacionTable =
      $ReservacionTableTable(this);
  late final $ResumenHabitacionTableTable resumenHabitacionTable =
      $ResumenHabitacionTableTable(this);
  late final $TarifaBaseTableTable tarifaBaseTable =
      $TarifaBaseTableTable(this);
  late final $TarifaTableTable tarifaTable = $TarifaTableTable(this);
  late final $TarifaXDiaTableTable tarifaXDiaTable =
      $TarifaXDiaTableTable(this);
  late final $TarifaXHabitacionTableTable tarifaXHabitacionTable =
      $TarifaXHabitacionTableTable(this);
  late final $TemporadaTableTable temporadaTable = $TemporadaTableTable(this);
  late final $TarifaTemporadaTableTable tarifaTemporadaTable =
      $TarifaTemporadaTableTable(this);
  late final $ReservacionBrazaleteTableTable reservacionBrazaleteTable =
      $ReservacionBrazaleteTableTable(this);
  late final TarifaBaseDao tarifaBaseDao = TarifaBaseDao(this as AppDatabase);
  late final TarifaDao tarifaDao = TarifaDao(this as AppDatabase);
  late final TarifaRackDao tarifaRackDao = TarifaRackDao(this as AppDatabase);
  late final CotizacionDao cotizacionDao = CotizacionDao(this as AppDatabase);
  late final UsuarioDao usuarioDao = UsuarioDao(this as AppDatabase);
  late final ClienteDao clienteDao = ClienteDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        tipoHabitacionTable,
        imagenTable,
        rolTable,
        usuarioTable,
        categoriaTable,
        clienteTable,
        cotizacionTable,
        habitacionTable,
        notificacionTable,
        tarifaRackTable,
        periodoTable,
        politicaTarifarioTable,
        reservacionTable,
        resumenHabitacionTable,
        tarifaBaseTable,
        tarifaTable,
        tarifaXDiaTable,
        tarifaXHabitacionTable,
        temporadaTable,
        tarifaTemporadaTable,
        reservacionBrazaleteTable
      ];
}

typedef $$TipoHabitacionTableTableCreateCompanionBuilder
    = TipoHabitacionTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> codigo,
  Value<int?> orden,
  Value<String?> descripcion,
});
typedef $$TipoHabitacionTableTableUpdateCompanionBuilder
    = TipoHabitacionTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> codigo,
  Value<int?> orden,
  Value<String?> descripcion,
});

class $$TipoHabitacionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TipoHabitacionTableTable,
    TipoHabitacionTableData,
    $$TipoHabitacionTableTableFilterComposer,
    $$TipoHabitacionTableTableOrderingComposer,
    $$TipoHabitacionTableTableCreateCompanionBuilder,
    $$TipoHabitacionTableTableUpdateCompanionBuilder> {
  $$TipoHabitacionTableTableTableManager(
      _$AppDatabase db, $TipoHabitacionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$TipoHabitacionTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$TipoHabitacionTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<int?> orden = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
          }) =>
              TipoHabitacionTableCompanion(
            idInt: idInt,
            id: id,
            codigo: codigo,
            orden: orden,
            descripcion: descripcion,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<int?> orden = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
          }) =>
              TipoHabitacionTableCompanion.insert(
            idInt: idInt,
            id: id,
            codigo: codigo,
            orden: orden,
            descripcion: descripcion,
          ),
        ));
}

class $$TipoHabitacionTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TipoHabitacionTableTable> {
  $$TipoHabitacionTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orden => $state.composableBuilder(
      column: $state.table.orden,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get descripcion => $state.composableBuilder(
      column: $state.table.descripcion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter categoriaTableRefs(
      ComposableFilter Function($$CategoriaTableTableFilterComposer f) f) {
    final $$CategoriaTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.categoriaTable,
        getReferencedColumn: (t) => t.tipoHabitacionInt,
        builder: (joinBuilder, parentComposers) =>
            $$CategoriaTableTableFilterComposer(ComposerState($state.db,
                $state.db.categoriaTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$TipoHabitacionTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TipoHabitacionTableTable> {
  $$TipoHabitacionTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orden => $state.composableBuilder(
      column: $state.table.orden,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get descripcion => $state.composableBuilder(
      column: $state.table.descripcion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ImagenTableTableCreateCompanionBuilder = ImagenTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> nombre,
  Value<String?> ruta,
  Value<String?> url,
  Value<DateTime?> createdAt,
});
typedef $$ImagenTableTableUpdateCompanionBuilder = ImagenTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> nombre,
  Value<String?> ruta,
  Value<String?> url,
  Value<DateTime?> createdAt,
});

class $$ImagenTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ImagenTableTable,
    ImagenTableData,
    $$ImagenTableTableFilterComposer,
    $$ImagenTableTableOrderingComposer,
    $$ImagenTableTableCreateCompanionBuilder,
    $$ImagenTableTableUpdateCompanionBuilder> {
  $$ImagenTableTableTableManager(_$AppDatabase db, $ImagenTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ImagenTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ImagenTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> ruta = const Value.absent(),
            Value<String?> url = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              ImagenTableCompanion(
            idInt: idInt,
            id: id,
            nombre: nombre,
            ruta: ruta,
            url: url,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> ruta = const Value.absent(),
            Value<String?> url = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              ImagenTableCompanion.insert(
            idInt: idInt,
            id: id,
            nombre: nombre,
            ruta: ruta,
            url: url,
            createdAt: createdAt,
          ),
        ));
}

class $$ImagenTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ImagenTableTable> {
  $$ImagenTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get ruta => $state.composableBuilder(
      column: $state.table.ruta,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter usuarioTableRefs(
      ComposableFilter Function($$UsuarioTableTableFilterComposer f) f) {
    final $$UsuarioTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.imagenInt,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableFilterComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ImagenTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ImagenTableTable> {
  $$ImagenTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get ruta => $state.composableBuilder(
      column: $state.table.ruta,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$RolTableTableCreateCompanionBuilder = RolTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> nombre,
  Value<String?> color,
  Value<String?> descripcion,
  Value<String?> permisos,
});
typedef $$RolTableTableUpdateCompanionBuilder = RolTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> nombre,
  Value<String?> color,
  Value<String?> descripcion,
  Value<String?> permisos,
});

class $$RolTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RolTableTable,
    RolTableData,
    $$RolTableTableFilterComposer,
    $$RolTableTableOrderingComposer,
    $$RolTableTableCreateCompanionBuilder,
    $$RolTableTableUpdateCompanionBuilder> {
  $$RolTableTableTableManager(_$AppDatabase db, $RolTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RolTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RolTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
            Value<String?> permisos = const Value.absent(),
          }) =>
              RolTableCompanion(
            idInt: idInt,
            id: id,
            nombre: nombre,
            color: color,
            descripcion: descripcion,
            permisos: permisos,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
            Value<String?> permisos = const Value.absent(),
          }) =>
              RolTableCompanion.insert(
            idInt: idInt,
            id: id,
            nombre: nombre,
            color: color,
            descripcion: descripcion,
            permisos: permisos,
          ),
        ));
}

class $$RolTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RolTableTable> {
  $$RolTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get descripcion => $state.composableBuilder(
      column: $state.table.descripcion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get permisos => $state.composableBuilder(
      column: $state.table.permisos,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter usuarioTableRefs(
      ComposableFilter Function($$UsuarioTableTableFilterComposer f) f) {
    final $$UsuarioTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.rolInt,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableFilterComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$RolTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RolTableTable> {
  $$RolTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get descripcion => $state.composableBuilder(
      column: $state.table.descripcion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get permisos => $state.composableBuilder(
      column: $state.table.permisos,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$UsuarioTableTableCreateCompanionBuilder = UsuarioTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> username,
  Value<String?> password,
  Value<String?> estatus,
  Value<DateTime?> createdAt,
  Value<String?> correoElectronico,
  Value<String?> telefono,
  Value<DateTime?> fechaNacimiento,
  Value<String?> nombre,
  Value<String?> apellido,
  Value<int?> imagenInt,
  Value<String?> imagen,
  Value<int?> rolInt,
  Value<String?> rol,
});
typedef $$UsuarioTableTableUpdateCompanionBuilder = UsuarioTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> username,
  Value<String?> password,
  Value<String?> estatus,
  Value<DateTime?> createdAt,
  Value<String?> correoElectronico,
  Value<String?> telefono,
  Value<DateTime?> fechaNacimiento,
  Value<String?> nombre,
  Value<String?> apellido,
  Value<int?> imagenInt,
  Value<String?> imagen,
  Value<int?> rolInt,
  Value<String?> rol,
});

class $$UsuarioTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsuarioTableTable,
    UsuarioTableData,
    $$UsuarioTableTableFilterComposer,
    $$UsuarioTableTableOrderingComposer,
    $$UsuarioTableTableCreateCompanionBuilder,
    $$UsuarioTableTableUpdateCompanionBuilder> {
  $$UsuarioTableTableTableManager(_$AppDatabase db, $UsuarioTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsuarioTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsuarioTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> password = const Value.absent(),
            Value<String?> estatus = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> correoElectronico = const Value.absent(),
            Value<String?> telefono = const Value.absent(),
            Value<DateTime?> fechaNacimiento = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> apellido = const Value.absent(),
            Value<int?> imagenInt = const Value.absent(),
            Value<String?> imagen = const Value.absent(),
            Value<int?> rolInt = const Value.absent(),
            Value<String?> rol = const Value.absent(),
          }) =>
              UsuarioTableCompanion(
            idInt: idInt,
            id: id,
            username: username,
            password: password,
            estatus: estatus,
            createdAt: createdAt,
            correoElectronico: correoElectronico,
            telefono: telefono,
            fechaNacimiento: fechaNacimiento,
            nombre: nombre,
            apellido: apellido,
            imagenInt: imagenInt,
            imagen: imagen,
            rolInt: rolInt,
            rol: rol,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> password = const Value.absent(),
            Value<String?> estatus = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> correoElectronico = const Value.absent(),
            Value<String?> telefono = const Value.absent(),
            Value<DateTime?> fechaNacimiento = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> apellido = const Value.absent(),
            Value<int?> imagenInt = const Value.absent(),
            Value<String?> imagen = const Value.absent(),
            Value<int?> rolInt = const Value.absent(),
            Value<String?> rol = const Value.absent(),
          }) =>
              UsuarioTableCompanion.insert(
            idInt: idInt,
            id: id,
            username: username,
            password: password,
            estatus: estatus,
            createdAt: createdAt,
            correoElectronico: correoElectronico,
            telefono: telefono,
            fechaNacimiento: fechaNacimiento,
            nombre: nombre,
            apellido: apellido,
            imagenInt: imagenInt,
            imagen: imagen,
            rolInt: rolInt,
            rol: rol,
          ),
        ));
}

class $$UsuarioTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UsuarioTableTable> {
  $$UsuarioTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get username => $state.composableBuilder(
      column: $state.table.username,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get estatus => $state.composableBuilder(
      column: $state.table.estatus,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get correoElectronico => $state.composableBuilder(
      column: $state.table.correoElectronico,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get telefono => $state.composableBuilder(
      column: $state.table.telefono,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fechaNacimiento => $state.composableBuilder(
      column: $state.table.fechaNacimiento,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get apellido => $state.composableBuilder(
      column: $state.table.apellido,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get imagen => $state.composableBuilder(
      column: $state.table.imagen,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get rol => $state.composableBuilder(
      column: $state.table.rol,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ImagenTableTableFilterComposer get imagenInt {
    final $$ImagenTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.imagenInt,
        referencedTable: $state.db.imagenTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ImagenTableTableFilterComposer(ComposerState($state.db,
                $state.db.imagenTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$RolTableTableFilterComposer get rolInt {
    final $$RolTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.rolInt,
        referencedTable: $state.db.rolTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RolTableTableFilterComposer(ComposerState(
                $state.db, $state.db.rolTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter categoriaTableRefs(
      ComposableFilter Function($$CategoriaTableTableFilterComposer f) f) {
    final $$CategoriaTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.categoriaTable,
        getReferencedColumn: (t) => t.creadoPorInt,
        builder: (joinBuilder, parentComposers) =>
            $$CategoriaTableTableFilterComposer(ComposerState($state.db,
                $state.db.categoriaTable, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter notificacionTableRefs(
      ComposableFilter Function($$NotificacionTableTableFilterComposer f) f) {
    final $$NotificacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.notificacionTable,
            getReferencedColumn: (t) => t.usuarioInt,
            builder: (joinBuilder, parentComposers) =>
                $$NotificacionTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.notificacionTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter tarifaRackTableRefs(
      ComposableFilter Function($$TarifaRackTableTableFilterComposer f) f) {
    final $$TarifaRackTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.tarifaRackTable,
            getReferencedColumn: (t) => t.creadoPorInt,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaRackTableTableFilterComposer(ComposerState($state.db,
                    $state.db.tarifaRackTable, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter politicaTarifarioTableRefs(
      ComposableFilter Function($$PoliticaTarifarioTableTableFilterComposer f)
          f) {
    final $$PoliticaTarifarioTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.politicaTarifarioTable,
            getReferencedColumn: (t) => t.creadoPorInt,
            builder: (joinBuilder, parentComposers) =>
                $$PoliticaTarifarioTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.politicaTarifarioTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter reservacionTableRefs(
      ComposableFilter Function($$ReservacionTableTableFilterComposer f) f) {
    final $$ReservacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.reservacionTable,
            getReferencedColumn: (t) => t.creadoPorInt,
            builder: (joinBuilder, parentComposers) =>
                $$ReservacionTableTableFilterComposer(ComposerState($state.db,
                    $state.db.reservacionTable, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter tarifaBaseTableRefs(
      ComposableFilter Function($$TarifaBaseTableTableFilterComposer f) f) {
    final $$TarifaBaseTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.tarifaBaseTable,
            getReferencedColumn: (t) => t.creadoPorInt,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaBaseTableTableFilterComposer(ComposerState($state.db,
                    $state.db.tarifaBaseTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$UsuarioTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UsuarioTableTable> {
  $$UsuarioTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get username => $state.composableBuilder(
      column: $state.table.username,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get estatus => $state.composableBuilder(
      column: $state.table.estatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get correoElectronico => $state.composableBuilder(
      column: $state.table.correoElectronico,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get telefono => $state.composableBuilder(
      column: $state.table.telefono,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fechaNacimiento => $state.composableBuilder(
      column: $state.table.fechaNacimiento,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get apellido => $state.composableBuilder(
      column: $state.table.apellido,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get imagen => $state.composableBuilder(
      column: $state.table.imagen,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get rol => $state.composableBuilder(
      column: $state.table.rol,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ImagenTableTableOrderingComposer get imagenInt {
    final $$ImagenTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.imagenInt,
        referencedTable: $state.db.imagenTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ImagenTableTableOrderingComposer(ComposerState($state.db,
                $state.db.imagenTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$RolTableTableOrderingComposer get rolInt {
    final $$RolTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.rolInt,
        referencedTable: $state.db.rolTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RolTableTableOrderingComposer(ComposerState(
                $state.db, $state.db.rolTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$CategoriaTableTableCreateCompanionBuilder = CategoriaTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<String?> nombre,
  Value<String?> color,
  Value<int?> tipoHabitacionInt,
  Value<String?> tipoHabitacion,
  Value<int?> creadoPorInt,
  Value<String?> creadoPor,
});
typedef $$CategoriaTableTableUpdateCompanionBuilder = CategoriaTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<String?> nombre,
  Value<String?> color,
  Value<int?> tipoHabitacionInt,
  Value<String?> tipoHabitacion,
  Value<int?> creadoPorInt,
  Value<String?> creadoPor,
});

class $$CategoriaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriaTableTable,
    CategoriaTableData,
    $$CategoriaTableTableFilterComposer,
    $$CategoriaTableTableOrderingComposer,
    $$CategoriaTableTableCreateCompanionBuilder,
    $$CategoriaTableTableUpdateCompanionBuilder> {
  $$CategoriaTableTableTableManager(
      _$AppDatabase db, $CategoriaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CategoriaTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CategoriaTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<int?> tipoHabitacionInt = const Value.absent(),
            Value<String?> tipoHabitacion = const Value.absent(),
            Value<int?> creadoPorInt = const Value.absent(),
            Value<String?> creadoPor = const Value.absent(),
          }) =>
              CategoriaTableCompanion(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            nombre: nombre,
            color: color,
            tipoHabitacionInt: tipoHabitacionInt,
            tipoHabitacion: tipoHabitacion,
            creadoPorInt: creadoPorInt,
            creadoPor: creadoPor,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<int?> tipoHabitacionInt = const Value.absent(),
            Value<String?> tipoHabitacion = const Value.absent(),
            Value<int?> creadoPorInt = const Value.absent(),
            Value<String?> creadoPor = const Value.absent(),
          }) =>
              CategoriaTableCompanion.insert(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            nombre: nombre,
            color: color,
            tipoHabitacionInt: tipoHabitacionInt,
            tipoHabitacion: tipoHabitacion,
            creadoPorInt: creadoPorInt,
            creadoPor: creadoPor,
          ),
        ));
}

class $$CategoriaTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CategoriaTableTable> {
  $$CategoriaTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tipoHabitacion => $state.composableBuilder(
      column: $state.table.tipoHabitacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get creadoPor => $state.composableBuilder(
      column: $state.table.creadoPor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$TipoHabitacionTableTableFilterComposer get tipoHabitacionInt {
    final $$TipoHabitacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tipoHabitacionInt,
            referencedTable: $state.db.tipoHabitacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TipoHabitacionTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.tipoHabitacionTable,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }

  $$UsuarioTableTableFilterComposer get creadoPorInt {
    final $$UsuarioTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creadoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableFilterComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter resumenHabitacionTableRefs(
      ComposableFilter Function($$ResumenHabitacionTableTableFilterComposer f)
          f) {
    final $$ResumenHabitacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.resumenHabitacionTable,
            getReferencedColumn: (t) => t.categoriaInt,
            builder: (joinBuilder, parentComposers) =>
                $$ResumenHabitacionTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.resumenHabitacionTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter tarifaTableRefs(
      ComposableFilter Function($$TarifaTableTableFilterComposer f) f) {
    final $$TarifaTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.tarifaTable,
        getReferencedColumn: (t) => t.categoriaInt,
        builder: (joinBuilder, parentComposers) =>
            $$TarifaTableTableFilterComposer(ComposerState($state.db,
                $state.db.tarifaTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CategoriaTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CategoriaTableTable> {
  $$CategoriaTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tipoHabitacion => $state.composableBuilder(
      column: $state.table.tipoHabitacion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get creadoPor => $state.composableBuilder(
      column: $state.table.creadoPor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$TipoHabitacionTableTableOrderingComposer get tipoHabitacionInt {
    final $$TipoHabitacionTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tipoHabitacionInt,
            referencedTable: $state.db.tipoHabitacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TipoHabitacionTableTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.tipoHabitacionTable,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }

  $$UsuarioTableTableOrderingComposer get creadoPorInt {
    final $$UsuarioTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creadoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableOrderingComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ClienteTableTableCreateCompanionBuilder = ClienteTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> nombres,
  Value<String?> apellidos,
  Value<String?> numeroTelefonico,
  Value<String?> correoElectronico,
  Value<String?> pais,
  Value<String?> estado,
  Value<String?> ciudad,
  Value<String?> direccion,
  Value<String?> notas,
  Value<DateTime?> createdAt,
});
typedef $$ClienteTableTableUpdateCompanionBuilder = ClienteTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> nombres,
  Value<String?> apellidos,
  Value<String?> numeroTelefonico,
  Value<String?> correoElectronico,
  Value<String?> pais,
  Value<String?> estado,
  Value<String?> ciudad,
  Value<String?> direccion,
  Value<String?> notas,
  Value<DateTime?> createdAt,
});

class $$ClienteTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClienteTableTable,
    ClienteTableData,
    $$ClienteTableTableFilterComposer,
    $$ClienteTableTableOrderingComposer,
    $$ClienteTableTableCreateCompanionBuilder,
    $$ClienteTableTableUpdateCompanionBuilder> {
  $$ClienteTableTableTableManager(_$AppDatabase db, $ClienteTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ClienteTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ClienteTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> nombres = const Value.absent(),
            Value<String?> apellidos = const Value.absent(),
            Value<String?> numeroTelefonico = const Value.absent(),
            Value<String?> correoElectronico = const Value.absent(),
            Value<String?> pais = const Value.absent(),
            Value<String?> estado = const Value.absent(),
            Value<String?> ciudad = const Value.absent(),
            Value<String?> direccion = const Value.absent(),
            Value<String?> notas = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              ClienteTableCompanion(
            idInt: idInt,
            id: id,
            nombres: nombres,
            apellidos: apellidos,
            numeroTelefonico: numeroTelefonico,
            correoElectronico: correoElectronico,
            pais: pais,
            estado: estado,
            ciudad: ciudad,
            direccion: direccion,
            notas: notas,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> nombres = const Value.absent(),
            Value<String?> apellidos = const Value.absent(),
            Value<String?> numeroTelefonico = const Value.absent(),
            Value<String?> correoElectronico = const Value.absent(),
            Value<String?> pais = const Value.absent(),
            Value<String?> estado = const Value.absent(),
            Value<String?> ciudad = const Value.absent(),
            Value<String?> direccion = const Value.absent(),
            Value<String?> notas = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              ClienteTableCompanion.insert(
            idInt: idInt,
            id: id,
            nombres: nombres,
            apellidos: apellidos,
            numeroTelefonico: numeroTelefonico,
            correoElectronico: correoElectronico,
            pais: pais,
            estado: estado,
            ciudad: ciudad,
            direccion: direccion,
            notas: notas,
            createdAt: createdAt,
          ),
        ));
}

class $$ClienteTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ClienteTableTable> {
  $$ClienteTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nombres => $state.composableBuilder(
      column: $state.table.nombres,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get apellidos => $state.composableBuilder(
      column: $state.table.apellidos,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get numeroTelefonico => $state.composableBuilder(
      column: $state.table.numeroTelefonico,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get correoElectronico => $state.composableBuilder(
      column: $state.table.correoElectronico,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get pais => $state.composableBuilder(
      column: $state.table.pais,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get estado => $state.composableBuilder(
      column: $state.table.estado,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get ciudad => $state.composableBuilder(
      column: $state.table.ciudad,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get direccion => $state.composableBuilder(
      column: $state.table.direccion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notas => $state.composableBuilder(
      column: $state.table.notas,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter cotizacionTableRefs(
      ComposableFilter Function($$CotizacionTableTableFilterComposer f) f) {
    final $$CotizacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.cotizacionTable,
            getReferencedColumn: (t) => t.clienteInt,
            builder: (joinBuilder, parentComposers) =>
                $$CotizacionTableTableFilterComposer(ComposerState($state.db,
                    $state.db.cotizacionTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ClienteTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ClienteTableTable> {
  $$ClienteTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nombres => $state.composableBuilder(
      column: $state.table.nombres,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get apellidos => $state.composableBuilder(
      column: $state.table.apellidos,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get numeroTelefonico => $state.composableBuilder(
      column: $state.table.numeroTelefonico,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get correoElectronico => $state.composableBuilder(
      column: $state.table.correoElectronico,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get pais => $state.composableBuilder(
      column: $state.table.pais,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get estado => $state.composableBuilder(
      column: $state.table.estado,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get ciudad => $state.composableBuilder(
      column: $state.table.ciudad,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get direccion => $state.composableBuilder(
      column: $state.table.direccion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notas => $state.composableBuilder(
      column: $state.table.notas,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CotizacionTableTableCreateCompanionBuilder = CotizacionTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> folio,
  Value<int?> clienteInt,
  Value<String?> cliente,
  Value<DateTime?> createdAt,
  Value<DateTime?> fechaLimite,
  Value<String?> estatus,
  Value<bool?> esGrupo,
  Value<int?> creadoPorInt,
  Value<String?> creadoPor,
  Value<int?> cerradoPorInt,
  Value<String?> cerradoPor,
  Value<double> subtotal,
  Value<double> descuento,
  Value<double> impuestos,
  Value<double> total,
  Value<String?> comentarios,
  Value<int?> cotizacionInt,
  Value<String?> cotizacion,
});
typedef $$CotizacionTableTableUpdateCompanionBuilder = CotizacionTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> folio,
  Value<int?> clienteInt,
  Value<String?> cliente,
  Value<DateTime?> createdAt,
  Value<DateTime?> fechaLimite,
  Value<String?> estatus,
  Value<bool?> esGrupo,
  Value<int?> creadoPorInt,
  Value<String?> creadoPor,
  Value<int?> cerradoPorInt,
  Value<String?> cerradoPor,
  Value<double> subtotal,
  Value<double> descuento,
  Value<double> impuestos,
  Value<double> total,
  Value<String?> comentarios,
  Value<int?> cotizacionInt,
  Value<String?> cotizacion,
});

class $$CotizacionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CotizacionTableTable,
    CotizacionTableData,
    $$CotizacionTableTableFilterComposer,
    $$CotizacionTableTableOrderingComposer,
    $$CotizacionTableTableCreateCompanionBuilder,
    $$CotizacionTableTableUpdateCompanionBuilder> {
  $$CotizacionTableTableTableManager(
      _$AppDatabase db, $CotizacionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CotizacionTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CotizacionTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> folio = const Value.absent(),
            Value<int?> clienteInt = const Value.absent(),
            Value<String?> cliente = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> fechaLimite = const Value.absent(),
            Value<String?> estatus = const Value.absent(),
            Value<bool?> esGrupo = const Value.absent(),
            Value<int?> creadoPorInt = const Value.absent(),
            Value<String?> creadoPor = const Value.absent(),
            Value<int?> cerradoPorInt = const Value.absent(),
            Value<String?> cerradoPor = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> descuento = const Value.absent(),
            Value<double> impuestos = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<String?> comentarios = const Value.absent(),
            Value<int?> cotizacionInt = const Value.absent(),
            Value<String?> cotizacion = const Value.absent(),
          }) =>
              CotizacionTableCompanion(
            idInt: idInt,
            id: id,
            folio: folio,
            clienteInt: clienteInt,
            cliente: cliente,
            createdAt: createdAt,
            fechaLimite: fechaLimite,
            estatus: estatus,
            esGrupo: esGrupo,
            creadoPorInt: creadoPorInt,
            creadoPor: creadoPor,
            cerradoPorInt: cerradoPorInt,
            cerradoPor: cerradoPor,
            subtotal: subtotal,
            descuento: descuento,
            impuestos: impuestos,
            total: total,
            comentarios: comentarios,
            cotizacionInt: cotizacionInt,
            cotizacion: cotizacion,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> folio = const Value.absent(),
            Value<int?> clienteInt = const Value.absent(),
            Value<String?> cliente = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> fechaLimite = const Value.absent(),
            Value<String?> estatus = const Value.absent(),
            Value<bool?> esGrupo = const Value.absent(),
            Value<int?> creadoPorInt = const Value.absent(),
            Value<String?> creadoPor = const Value.absent(),
            Value<int?> cerradoPorInt = const Value.absent(),
            Value<String?> cerradoPor = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> descuento = const Value.absent(),
            Value<double> impuestos = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<String?> comentarios = const Value.absent(),
            Value<int?> cotizacionInt = const Value.absent(),
            Value<String?> cotizacion = const Value.absent(),
          }) =>
              CotizacionTableCompanion.insert(
            idInt: idInt,
            id: id,
            folio: folio,
            clienteInt: clienteInt,
            cliente: cliente,
            createdAt: createdAt,
            fechaLimite: fechaLimite,
            estatus: estatus,
            esGrupo: esGrupo,
            creadoPorInt: creadoPorInt,
            creadoPor: creadoPor,
            cerradoPorInt: cerradoPorInt,
            cerradoPor: cerradoPor,
            subtotal: subtotal,
            descuento: descuento,
            impuestos: impuestos,
            total: total,
            comentarios: comentarios,
            cotizacionInt: cotizacionInt,
            cotizacion: cotizacion,
          ),
        ));
}

class $$CotizacionTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CotizacionTableTable> {
  $$CotizacionTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get folio => $state.composableBuilder(
      column: $state.table.folio,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cliente => $state.composableBuilder(
      column: $state.table.cliente,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fechaLimite => $state.composableBuilder(
      column: $state.table.fechaLimite,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get estatus => $state.composableBuilder(
      column: $state.table.estatus,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get esGrupo => $state.composableBuilder(
      column: $state.table.esGrupo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get creadoPor => $state.composableBuilder(
      column: $state.table.creadoPor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cerradoPor => $state.composableBuilder(
      column: $state.table.cerradoPor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get subtotal => $state.composableBuilder(
      column: $state.table.subtotal,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get descuento => $state.composableBuilder(
      column: $state.table.descuento,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get impuestos => $state.composableBuilder(
      column: $state.table.impuestos,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get comentarios => $state.composableBuilder(
      column: $state.table.comentarios,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cotizacion => $state.composableBuilder(
      column: $state.table.cotizacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ClienteTableTableFilterComposer get clienteInt {
    final $$ClienteTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteInt,
        referencedTable: $state.db.clienteTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ClienteTableTableFilterComposer(ComposerState($state.db,
                $state.db.clienteTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$UsuarioTableTableFilterComposer get creadoPorInt {
    final $$UsuarioTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creadoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableFilterComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$UsuarioTableTableFilterComposer get cerradoPorInt {
    final $$UsuarioTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cerradoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableFilterComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$CotizacionTableTableFilterComposer get cotizacionInt {
    final $$CotizacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.cotizacionInt,
            referencedTable: $state.db.cotizacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$CotizacionTableTableFilterComposer(ComposerState($state.db,
                    $state.db.cotizacionTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter habitacionTableRefs(
      ComposableFilter Function($$HabitacionTableTableFilterComposer f) f) {
    final $$HabitacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.habitacionTable,
            getReferencedColumn: (t) => t.cotizacionInt,
            builder: (joinBuilder, parentComposers) =>
                $$HabitacionTableTableFilterComposer(ComposerState($state.db,
                    $state.db.habitacionTable, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter reservacionTableRefs(
      ComposableFilter Function($$ReservacionTableTableFilterComposer f) f) {
    final $$ReservacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.reservacionTable,
            getReferencedColumn: (t) => t.cotizacionInt,
            builder: (joinBuilder, parentComposers) =>
                $$ReservacionTableTableFilterComposer(ComposerState($state.db,
                    $state.db.reservacionTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CotizacionTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CotizacionTableTable> {
  $$CotizacionTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get folio => $state.composableBuilder(
      column: $state.table.folio,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cliente => $state.composableBuilder(
      column: $state.table.cliente,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fechaLimite => $state.composableBuilder(
      column: $state.table.fechaLimite,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get estatus => $state.composableBuilder(
      column: $state.table.estatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get esGrupo => $state.composableBuilder(
      column: $state.table.esGrupo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get creadoPor => $state.composableBuilder(
      column: $state.table.creadoPor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cerradoPor => $state.composableBuilder(
      column: $state.table.cerradoPor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get subtotal => $state.composableBuilder(
      column: $state.table.subtotal,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get descuento => $state.composableBuilder(
      column: $state.table.descuento,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get impuestos => $state.composableBuilder(
      column: $state.table.impuestos,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get comentarios => $state.composableBuilder(
      column: $state.table.comentarios,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cotizacion => $state.composableBuilder(
      column: $state.table.cotizacion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ClienteTableTableOrderingComposer get clienteInt {
    final $$ClienteTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteInt,
        referencedTable: $state.db.clienteTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ClienteTableTableOrderingComposer(ComposerState($state.db,
                $state.db.clienteTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$UsuarioTableTableOrderingComposer get creadoPorInt {
    final $$UsuarioTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creadoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableOrderingComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$UsuarioTableTableOrderingComposer get cerradoPorInt {
    final $$UsuarioTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cerradoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableOrderingComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$CotizacionTableTableOrderingComposer get cotizacionInt {
    final $$CotizacionTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.cotizacionInt,
            referencedTable: $state.db.cotizacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$CotizacionTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.cotizacionTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$HabitacionTableTableCreateCompanionBuilder = HabitacionTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<int?> cotizacionInt,
  Value<String?> cotizacion,
  Value<DateTime?> checkIn,
  Value<DateTime?> checkOut,
  Value<int?> adultos,
  Value<int?> menores0a6,
  Value<int?> menores7a12,
  Value<int?> paxAdic,
  Value<int?> count,
  Value<bool?> esCortesia,
});
typedef $$HabitacionTableTableUpdateCompanionBuilder = HabitacionTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<int?> cotizacionInt,
  Value<String?> cotizacion,
  Value<DateTime?> checkIn,
  Value<DateTime?> checkOut,
  Value<int?> adultos,
  Value<int?> menores0a6,
  Value<int?> menores7a12,
  Value<int?> paxAdic,
  Value<int?> count,
  Value<bool?> esCortesia,
});

class $$HabitacionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitacionTableTable,
    HabitacionTableData,
    $$HabitacionTableTableFilterComposer,
    $$HabitacionTableTableOrderingComposer,
    $$HabitacionTableTableCreateCompanionBuilder,
    $$HabitacionTableTableUpdateCompanionBuilder> {
  $$HabitacionTableTableTableManager(
      _$AppDatabase db, $HabitacionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$HabitacionTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$HabitacionTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int?> cotizacionInt = const Value.absent(),
            Value<String?> cotizacion = const Value.absent(),
            Value<DateTime?> checkIn = const Value.absent(),
            Value<DateTime?> checkOut = const Value.absent(),
            Value<int?> adultos = const Value.absent(),
            Value<int?> menores0a6 = const Value.absent(),
            Value<int?> menores7a12 = const Value.absent(),
            Value<int?> paxAdic = const Value.absent(),
            Value<int?> count = const Value.absent(),
            Value<bool?> esCortesia = const Value.absent(),
          }) =>
              HabitacionTableCompanion(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            cotizacionInt: cotizacionInt,
            cotizacion: cotizacion,
            checkIn: checkIn,
            checkOut: checkOut,
            adultos: adultos,
            menores0a6: menores0a6,
            menores7a12: menores7a12,
            paxAdic: paxAdic,
            count: count,
            esCortesia: esCortesia,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int?> cotizacionInt = const Value.absent(),
            Value<String?> cotizacion = const Value.absent(),
            Value<DateTime?> checkIn = const Value.absent(),
            Value<DateTime?> checkOut = const Value.absent(),
            Value<int?> adultos = const Value.absent(),
            Value<int?> menores0a6 = const Value.absent(),
            Value<int?> menores7a12 = const Value.absent(),
            Value<int?> paxAdic = const Value.absent(),
            Value<int?> count = const Value.absent(),
            Value<bool?> esCortesia = const Value.absent(),
          }) =>
              HabitacionTableCompanion.insert(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            cotizacionInt: cotizacionInt,
            cotizacion: cotizacion,
            checkIn: checkIn,
            checkOut: checkOut,
            adultos: adultos,
            menores0a6: menores0a6,
            menores7a12: menores7a12,
            paxAdic: paxAdic,
            count: count,
            esCortesia: esCortesia,
          ),
        ));
}

class $$HabitacionTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $HabitacionTableTable> {
  $$HabitacionTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cotizacion => $state.composableBuilder(
      column: $state.table.cotizacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get checkIn => $state.composableBuilder(
      column: $state.table.checkIn,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get checkOut => $state.composableBuilder(
      column: $state.table.checkOut,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get adultos => $state.composableBuilder(
      column: $state.table.adultos,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get menores0a6 => $state.composableBuilder(
      column: $state.table.menores0a6,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get menores7a12 => $state.composableBuilder(
      column: $state.table.menores7a12,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get paxAdic => $state.composableBuilder(
      column: $state.table.paxAdic,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get count => $state.composableBuilder(
      column: $state.table.count,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get esCortesia => $state.composableBuilder(
      column: $state.table.esCortesia,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CotizacionTableTableFilterComposer get cotizacionInt {
    final $$CotizacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.cotizacionInt,
            referencedTable: $state.db.cotizacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$CotizacionTableTableFilterComposer(ComposerState($state.db,
                    $state.db.cotizacionTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter resumenHabitacionTableRefs(
      ComposableFilter Function($$ResumenHabitacionTableTableFilterComposer f)
          f) {
    final $$ResumenHabitacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.resumenHabitacionTable,
            getReferencedColumn: (t) => t.habitacionInt,
            builder: (joinBuilder, parentComposers) =>
                $$ResumenHabitacionTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.resumenHabitacionTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter tarifaXHabitacionTableRefs(
      ComposableFilter Function($$TarifaXHabitacionTableTableFilterComposer f)
          f) {
    final $$TarifaXHabitacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.tarifaXHabitacionTable,
            getReferencedColumn: (t) => t.habitacionInt,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaXHabitacionTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.tarifaXHabitacionTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$HabitacionTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $HabitacionTableTable> {
  $$HabitacionTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cotizacion => $state.composableBuilder(
      column: $state.table.cotizacion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get checkIn => $state.composableBuilder(
      column: $state.table.checkIn,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get checkOut => $state.composableBuilder(
      column: $state.table.checkOut,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get adultos => $state.composableBuilder(
      column: $state.table.adultos,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get menores0a6 => $state.composableBuilder(
      column: $state.table.menores0a6,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get menores7a12 => $state.composableBuilder(
      column: $state.table.menores7a12,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get paxAdic => $state.composableBuilder(
      column: $state.table.paxAdic,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get count => $state.composableBuilder(
      column: $state.table.count,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get esCortesia => $state.composableBuilder(
      column: $state.table.esCortesia,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CotizacionTableTableOrderingComposer get cotizacionInt {
    final $$CotizacionTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.cotizacionInt,
            referencedTable: $state.db.cotizacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$CotizacionTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.cotizacionTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$NotificacionTableTableCreateCompanionBuilder
    = NotificacionTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<String?> mensaje,
  Value<String?> tipo,
  Value<int?> ruta,
  Value<int?> usuarioInt,
  Value<String?> usuario,
});
typedef $$NotificacionTableTableUpdateCompanionBuilder
    = NotificacionTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<String?> mensaje,
  Value<String?> tipo,
  Value<int?> ruta,
  Value<int?> usuarioInt,
  Value<String?> usuario,
});

class $$NotificacionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificacionTableTable,
    NotificacionTableData,
    $$NotificacionTableTableFilterComposer,
    $$NotificacionTableTableOrderingComposer,
    $$NotificacionTableTableCreateCompanionBuilder,
    $$NotificacionTableTableUpdateCompanionBuilder> {
  $$NotificacionTableTableTableManager(
      _$AppDatabase db, $NotificacionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$NotificacionTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$NotificacionTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> mensaje = const Value.absent(),
            Value<String?> tipo = const Value.absent(),
            Value<int?> ruta = const Value.absent(),
            Value<int?> usuarioInt = const Value.absent(),
            Value<String?> usuario = const Value.absent(),
          }) =>
              NotificacionTableCompanion(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            mensaje: mensaje,
            tipo: tipo,
            ruta: ruta,
            usuarioInt: usuarioInt,
            usuario: usuario,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> mensaje = const Value.absent(),
            Value<String?> tipo = const Value.absent(),
            Value<int?> ruta = const Value.absent(),
            Value<int?> usuarioInt = const Value.absent(),
            Value<String?> usuario = const Value.absent(),
          }) =>
              NotificacionTableCompanion.insert(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            mensaje: mensaje,
            tipo: tipo,
            ruta: ruta,
            usuarioInt: usuarioInt,
            usuario: usuario,
          ),
        ));
}

class $$NotificacionTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $NotificacionTableTable> {
  $$NotificacionTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mensaje => $state.composableBuilder(
      column: $state.table.mensaje,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tipo => $state.composableBuilder(
      column: $state.table.tipo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get ruta => $state.composableBuilder(
      column: $state.table.ruta,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get usuario => $state.composableBuilder(
      column: $state.table.usuario,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$UsuarioTableTableFilterComposer get usuarioInt {
    final $$UsuarioTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableFilterComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$NotificacionTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $NotificacionTableTable> {
  $$NotificacionTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mensaje => $state.composableBuilder(
      column: $state.table.mensaje,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tipo => $state.composableBuilder(
      column: $state.table.tipo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get ruta => $state.composableBuilder(
      column: $state.table.ruta,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get usuario => $state.composableBuilder(
      column: $state.table.usuario,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$UsuarioTableTableOrderingComposer get usuarioInt {
    final $$UsuarioTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableOrderingComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$TarifaRackTableTableCreateCompanionBuilder = TarifaRackTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<String?> nombre,
  Value<String?> color,
  Value<int?> creadoPorInt,
  Value<String?> creadoPor,
});
typedef $$TarifaRackTableTableUpdateCompanionBuilder = TarifaRackTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<String?> nombre,
  Value<String?> color,
  Value<int?> creadoPorInt,
  Value<String?> creadoPor,
});

class $$TarifaRackTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarifaRackTableTable,
    TarifaRackTableData,
    $$TarifaRackTableTableFilterComposer,
    $$TarifaRackTableTableOrderingComposer,
    $$TarifaRackTableTableCreateCompanionBuilder,
    $$TarifaRackTableTableUpdateCompanionBuilder> {
  $$TarifaRackTableTableTableManager(
      _$AppDatabase db, $TarifaRackTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TarifaRackTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TarifaRackTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<int?> creadoPorInt = const Value.absent(),
            Value<String?> creadoPor = const Value.absent(),
          }) =>
              TarifaRackTableCompanion(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            nombre: nombre,
            color: color,
            creadoPorInt: creadoPorInt,
            creadoPor: creadoPor,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<int?> creadoPorInt = const Value.absent(),
            Value<String?> creadoPor = const Value.absent(),
          }) =>
              TarifaRackTableCompanion.insert(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            nombre: nombre,
            color: color,
            creadoPorInt: creadoPorInt,
            creadoPor: creadoPor,
          ),
        ));
}

class $$TarifaRackTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaRackTableTable> {
  $$TarifaRackTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get creadoPor => $state.composableBuilder(
      column: $state.table.creadoPor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$UsuarioTableTableFilterComposer get creadoPorInt {
    final $$UsuarioTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creadoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableFilterComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter periodoTableRefs(
      ComposableFilter Function($$PeriodoTableTableFilterComposer f) f) {
    final $$PeriodoTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.periodoTable,
        getReferencedColumn: (t) => t.tarifaRackInt,
        builder: (joinBuilder, parentComposers) =>
            $$PeriodoTableTableFilterComposer(ComposerState($state.db,
                $state.db.periodoTable, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter tarifaXDiaTableRefs(
      ComposableFilter Function($$TarifaXDiaTableTableFilterComposer f) f) {
    final $$TarifaXDiaTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.tarifaXDiaTable,
            getReferencedColumn: (t) => t.tarifaRackInt,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaXDiaTableTableFilterComposer(ComposerState($state.db,
                    $state.db.tarifaXDiaTable, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter temporadaTableRefs(
      ComposableFilter Function($$TemporadaTableTableFilterComposer f) f) {
    final $$TemporadaTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.temporadaTable,
        getReferencedColumn: (t) => t.tarifaRackInt,
        builder: (joinBuilder, parentComposers) =>
            $$TemporadaTableTableFilterComposer(ComposerState($state.db,
                $state.db.temporadaTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$TarifaRackTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaRackTableTable> {
  $$TarifaRackTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get creadoPor => $state.composableBuilder(
      column: $state.table.creadoPor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$UsuarioTableTableOrderingComposer get creadoPorInt {
    final $$UsuarioTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creadoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableOrderingComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$PeriodoTableTableCreateCompanionBuilder = PeriodoTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<DateTime?> fechaInicial,
  Value<DateTime?> fechaFinal,
  required List<String> diasActivo,
  Value<int?> tarifaRackInt,
  Value<String?> tarifaRack,
});
typedef $$PeriodoTableTableUpdateCompanionBuilder = PeriodoTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<DateTime?> fechaInicial,
  Value<DateTime?> fechaFinal,
  Value<List<String>> diasActivo,
  Value<int?> tarifaRackInt,
  Value<String?> tarifaRack,
});

class $$PeriodoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PeriodoTableTable,
    PeriodoTableData,
    $$PeriodoTableTableFilterComposer,
    $$PeriodoTableTableOrderingComposer,
    $$PeriodoTableTableCreateCompanionBuilder,
    $$PeriodoTableTableUpdateCompanionBuilder> {
  $$PeriodoTableTableTableManager(_$AppDatabase db, $PeriodoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PeriodoTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PeriodoTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> fechaInicial = const Value.absent(),
            Value<DateTime?> fechaFinal = const Value.absent(),
            Value<List<String>> diasActivo = const Value.absent(),
            Value<int?> tarifaRackInt = const Value.absent(),
            Value<String?> tarifaRack = const Value.absent(),
          }) =>
              PeriodoTableCompanion(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            fechaInicial: fechaInicial,
            fechaFinal: fechaFinal,
            diasActivo: diasActivo,
            tarifaRackInt: tarifaRackInt,
            tarifaRack: tarifaRack,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> fechaInicial = const Value.absent(),
            Value<DateTime?> fechaFinal = const Value.absent(),
            required List<String> diasActivo,
            Value<int?> tarifaRackInt = const Value.absent(),
            Value<String?> tarifaRack = const Value.absent(),
          }) =>
              PeriodoTableCompanion.insert(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            fechaInicial: fechaInicial,
            fechaFinal: fechaFinal,
            diasActivo: diasActivo,
            tarifaRackInt: tarifaRackInt,
            tarifaRack: tarifaRack,
          ),
        ));
}

class $$PeriodoTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PeriodoTableTable> {
  $$PeriodoTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fechaInicial => $state.composableBuilder(
      column: $state.table.fechaInicial,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fechaFinal => $state.composableBuilder(
      column: $state.table.fechaFinal,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get diasActivo => $state.composableBuilder(
          column: $state.table.diasActivo,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get tarifaRack => $state.composableBuilder(
      column: $state.table.tarifaRack,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$TarifaRackTableTableFilterComposer get tarifaRackInt {
    final $$TarifaRackTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tarifaRackInt,
            referencedTable: $state.db.tarifaRackTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaRackTableTableFilterComposer(ComposerState($state.db,
                    $state.db.tarifaRackTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PeriodoTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PeriodoTableTable> {
  $$PeriodoTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fechaInicial => $state.composableBuilder(
      column: $state.table.fechaInicial,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fechaFinal => $state.composableBuilder(
      column: $state.table.fechaFinal,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get diasActivo => $state.composableBuilder(
      column: $state.table.diasActivo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tarifaRack => $state.composableBuilder(
      column: $state.table.tarifaRack,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$TarifaRackTableTableOrderingComposer get tarifaRackInt {
    final $$TarifaRackTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tarifaRackInt,
            referencedTable: $state.db.tarifaRackTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaRackTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.tarifaRackTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$PoliticaTarifarioTableTableCreateCompanionBuilder
    = PoliticaTarifarioTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<String?> clave,
  Value<String?> valor,
  Value<String?> descripcion,
  Value<int?> creadoPorInt,
  Value<String?> creadoPor,
});
typedef $$PoliticaTarifarioTableTableUpdateCompanionBuilder
    = PoliticaTarifarioTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<String?> clave,
  Value<String?> valor,
  Value<String?> descripcion,
  Value<int?> creadoPorInt,
  Value<String?> creadoPor,
});

class $$PoliticaTarifarioTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PoliticaTarifarioTableTable,
    PoliticaTarifarioTableData,
    $$PoliticaTarifarioTableTableFilterComposer,
    $$PoliticaTarifarioTableTableOrderingComposer,
    $$PoliticaTarifarioTableTableCreateCompanionBuilder,
    $$PoliticaTarifarioTableTableUpdateCompanionBuilder> {
  $$PoliticaTarifarioTableTableTableManager(
      _$AppDatabase db, $PoliticaTarifarioTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$PoliticaTarifarioTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$PoliticaTarifarioTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String?> clave = const Value.absent(),
            Value<String?> valor = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
            Value<int?> creadoPorInt = const Value.absent(),
            Value<String?> creadoPor = const Value.absent(),
          }) =>
              PoliticaTarifarioTableCompanion(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            clave: clave,
            valor: valor,
            descripcion: descripcion,
            creadoPorInt: creadoPorInt,
            creadoPor: creadoPor,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String?> clave = const Value.absent(),
            Value<String?> valor = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
            Value<int?> creadoPorInt = const Value.absent(),
            Value<String?> creadoPor = const Value.absent(),
          }) =>
              PoliticaTarifarioTableCompanion.insert(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            clave: clave,
            valor: valor,
            descripcion: descripcion,
            creadoPorInt: creadoPorInt,
            creadoPor: creadoPor,
          ),
        ));
}

class $$PoliticaTarifarioTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PoliticaTarifarioTableTable> {
  $$PoliticaTarifarioTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get clave => $state.composableBuilder(
      column: $state.table.clave,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get valor => $state.composableBuilder(
      column: $state.table.valor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get descripcion => $state.composableBuilder(
      column: $state.table.descripcion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get creadoPor => $state.composableBuilder(
      column: $state.table.creadoPor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$UsuarioTableTableFilterComposer get creadoPorInt {
    final $$UsuarioTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creadoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableFilterComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PoliticaTarifarioTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PoliticaTarifarioTableTable> {
  $$PoliticaTarifarioTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get clave => $state.composableBuilder(
      column: $state.table.clave,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get valor => $state.composableBuilder(
      column: $state.table.valor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get descripcion => $state.composableBuilder(
      column: $state.table.descripcion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get creadoPor => $state.composableBuilder(
      column: $state.table.creadoPor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$UsuarioTableTableOrderingComposer get creadoPorInt {
    final $$UsuarioTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creadoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableOrderingComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ReservacionTableTableCreateCompanionBuilder
    = ReservacionTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<int?> cotizacionInt,
  Value<String?> cotizacion,
  Value<String?> sku,
  Value<String?> folio,
  Value<String?> estatus,
  Value<DateTime?> createdAt,
  Value<String?> reservacionZabiaId,
  Value<double?> deposito,
  Value<int?> creadoPorInt,
  Value<String?> creadoPor,
});
typedef $$ReservacionTableTableUpdateCompanionBuilder
    = ReservacionTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<int?> cotizacionInt,
  Value<String?> cotizacion,
  Value<String?> sku,
  Value<String?> folio,
  Value<String?> estatus,
  Value<DateTime?> createdAt,
  Value<String?> reservacionZabiaId,
  Value<double?> deposito,
  Value<int?> creadoPorInt,
  Value<String?> creadoPor,
});

class $$ReservacionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReservacionTableTable,
    ReservacionTableData,
    $$ReservacionTableTableFilterComposer,
    $$ReservacionTableTableOrderingComposer,
    $$ReservacionTableTableCreateCompanionBuilder,
    $$ReservacionTableTableUpdateCompanionBuilder> {
  $$ReservacionTableTableTableManager(
      _$AppDatabase db, $ReservacionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ReservacionTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ReservacionTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<int?> cotizacionInt = const Value.absent(),
            Value<String?> cotizacion = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String?> folio = const Value.absent(),
            Value<String?> estatus = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> reservacionZabiaId = const Value.absent(),
            Value<double?> deposito = const Value.absent(),
            Value<int?> creadoPorInt = const Value.absent(),
            Value<String?> creadoPor = const Value.absent(),
          }) =>
              ReservacionTableCompanion(
            idInt: idInt,
            id: id,
            cotizacionInt: cotizacionInt,
            cotizacion: cotizacion,
            sku: sku,
            folio: folio,
            estatus: estatus,
            createdAt: createdAt,
            reservacionZabiaId: reservacionZabiaId,
            deposito: deposito,
            creadoPorInt: creadoPorInt,
            creadoPor: creadoPor,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<int?> cotizacionInt = const Value.absent(),
            Value<String?> cotizacion = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String?> folio = const Value.absent(),
            Value<String?> estatus = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> reservacionZabiaId = const Value.absent(),
            Value<double?> deposito = const Value.absent(),
            Value<int?> creadoPorInt = const Value.absent(),
            Value<String?> creadoPor = const Value.absent(),
          }) =>
              ReservacionTableCompanion.insert(
            idInt: idInt,
            id: id,
            cotizacionInt: cotizacionInt,
            cotizacion: cotizacion,
            sku: sku,
            folio: folio,
            estatus: estatus,
            createdAt: createdAt,
            reservacionZabiaId: reservacionZabiaId,
            deposito: deposito,
            creadoPorInt: creadoPorInt,
            creadoPor: creadoPor,
          ),
        ));
}

class $$ReservacionTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ReservacionTableTable> {
  $$ReservacionTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cotizacion => $state.composableBuilder(
      column: $state.table.cotizacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sku => $state.composableBuilder(
      column: $state.table.sku,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get folio => $state.composableBuilder(
      column: $state.table.folio,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get estatus => $state.composableBuilder(
      column: $state.table.estatus,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get reservacionZabiaId => $state.composableBuilder(
      column: $state.table.reservacionZabiaId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get deposito => $state.composableBuilder(
      column: $state.table.deposito,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get creadoPor => $state.composableBuilder(
      column: $state.table.creadoPor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CotizacionTableTableFilterComposer get cotizacionInt {
    final $$CotizacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.cotizacionInt,
            referencedTable: $state.db.cotizacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$CotizacionTableTableFilterComposer(ComposerState($state.db,
                    $state.db.cotizacionTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$UsuarioTableTableFilterComposer get creadoPorInt {
    final $$UsuarioTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creadoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableFilterComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter reservacionBrazaleteTableRefs(
      ComposableFilter Function(
              $$ReservacionBrazaleteTableTableFilterComposer f)
          f) {
    final $$ReservacionBrazaleteTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.reservacionBrazaleteTable,
            getReferencedColumn: (t) => t.reservacionInt,
            builder: (joinBuilder, parentComposers) =>
                $$ReservacionBrazaleteTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.reservacionBrazaleteTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$ReservacionTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ReservacionTableTable> {
  $$ReservacionTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cotizacion => $state.composableBuilder(
      column: $state.table.cotizacion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sku => $state.composableBuilder(
      column: $state.table.sku,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get folio => $state.composableBuilder(
      column: $state.table.folio,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get estatus => $state.composableBuilder(
      column: $state.table.estatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get reservacionZabiaId => $state.composableBuilder(
      column: $state.table.reservacionZabiaId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get deposito => $state.composableBuilder(
      column: $state.table.deposito,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get creadoPor => $state.composableBuilder(
      column: $state.table.creadoPor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CotizacionTableTableOrderingComposer get cotizacionInt {
    final $$CotizacionTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.cotizacionInt,
            referencedTable: $state.db.cotizacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$CotizacionTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.cotizacionTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$UsuarioTableTableOrderingComposer get creadoPorInt {
    final $$UsuarioTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creadoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableOrderingComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ResumenHabitacionTableTableCreateCompanionBuilder
    = ResumenHabitacionTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<double> subtotal,
  Value<double> descuento,
  Value<double> impuestos,
  Value<double> total,
  Value<int?> habitacionInt,
  Value<String?> habitacion,
  Value<int?> categoriaInt,
  Value<String?> categoria,
});
typedef $$ResumenHabitacionTableTableUpdateCompanionBuilder
    = ResumenHabitacionTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<double> subtotal,
  Value<double> descuento,
  Value<double> impuestos,
  Value<double> total,
  Value<int?> habitacionInt,
  Value<String?> habitacion,
  Value<int?> categoriaInt,
  Value<String?> categoria,
});

class $$ResumenHabitacionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ResumenHabitacionTableTable,
    ResumenHabitacionTableData,
    $$ResumenHabitacionTableTableFilterComposer,
    $$ResumenHabitacionTableTableOrderingComposer,
    $$ResumenHabitacionTableTableCreateCompanionBuilder,
    $$ResumenHabitacionTableTableUpdateCompanionBuilder> {
  $$ResumenHabitacionTableTableTableManager(
      _$AppDatabase db, $ResumenHabitacionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ResumenHabitacionTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ResumenHabitacionTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> descuento = const Value.absent(),
            Value<double> impuestos = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<int?> habitacionInt = const Value.absent(),
            Value<String?> habitacion = const Value.absent(),
            Value<int?> categoriaInt = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
          }) =>
              ResumenHabitacionTableCompanion(
            idInt: idInt,
            id: id,
            subtotal: subtotal,
            descuento: descuento,
            impuestos: impuestos,
            total: total,
            habitacionInt: habitacionInt,
            habitacion: habitacion,
            categoriaInt: categoriaInt,
            categoria: categoria,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> descuento = const Value.absent(),
            Value<double> impuestos = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<int?> habitacionInt = const Value.absent(),
            Value<String?> habitacion = const Value.absent(),
            Value<int?> categoriaInt = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
          }) =>
              ResumenHabitacionTableCompanion.insert(
            idInt: idInt,
            id: id,
            subtotal: subtotal,
            descuento: descuento,
            impuestos: impuestos,
            total: total,
            habitacionInt: habitacionInt,
            habitacion: habitacion,
            categoriaInt: categoriaInt,
            categoria: categoria,
          ),
        ));
}

class $$ResumenHabitacionTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ResumenHabitacionTableTable> {
  $$ResumenHabitacionTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get subtotal => $state.composableBuilder(
      column: $state.table.subtotal,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get descuento => $state.composableBuilder(
      column: $state.table.descuento,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get impuestos => $state.composableBuilder(
      column: $state.table.impuestos,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get habitacion => $state.composableBuilder(
      column: $state.table.habitacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get categoria => $state.composableBuilder(
      column: $state.table.categoria,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$HabitacionTableTableFilterComposer get habitacionInt {
    final $$HabitacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.habitacionInt,
            referencedTable: $state.db.habitacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$HabitacionTableTableFilterComposer(ComposerState($state.db,
                    $state.db.habitacionTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$CategoriaTableTableFilterComposer get categoriaInt {
    final $$CategoriaTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoriaInt,
        referencedTable: $state.db.categoriaTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CategoriaTableTableFilterComposer(ComposerState($state.db,
                $state.db.categoriaTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ResumenHabitacionTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ResumenHabitacionTableTable> {
  $$ResumenHabitacionTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get subtotal => $state.composableBuilder(
      column: $state.table.subtotal,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get descuento => $state.composableBuilder(
      column: $state.table.descuento,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get impuestos => $state.composableBuilder(
      column: $state.table.impuestos,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get habitacion => $state.composableBuilder(
      column: $state.table.habitacion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get categoria => $state.composableBuilder(
      column: $state.table.categoria,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$HabitacionTableTableOrderingComposer get habitacionInt {
    final $$HabitacionTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.habitacionInt,
            referencedTable: $state.db.habitacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$HabitacionTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.habitacionTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$CategoriaTableTableOrderingComposer get categoriaInt {
    final $$CategoriaTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoriaInt,
            referencedTable: $state.db.categoriaTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$CategoriaTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.categoriaTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$TarifaBaseTableTableCreateCompanionBuilder = TarifaBaseTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> codigo,
  Value<String?> nombre,
  Value<double?> aumentoIntegrado,
  Value<bool?> conAutocalculacion,
  Value<double?> upgradeCategoria,
  Value<double?> upgradeMenor,
  Value<double?> upgradePaxAdic,
  Value<int?> tarifaBaseInt,
  Value<String?> tarifaBase,
  Value<int?> creadoPorInt,
  Value<String?> creadoPor,
});
typedef $$TarifaBaseTableTableUpdateCompanionBuilder = TarifaBaseTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> codigo,
  Value<String?> nombre,
  Value<double?> aumentoIntegrado,
  Value<bool?> conAutocalculacion,
  Value<double?> upgradeCategoria,
  Value<double?> upgradeMenor,
  Value<double?> upgradePaxAdic,
  Value<int?> tarifaBaseInt,
  Value<String?> tarifaBase,
  Value<int?> creadoPorInt,
  Value<String?> creadoPor,
});

class $$TarifaBaseTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarifaBaseTableTable,
    TarifaBaseTableData,
    $$TarifaBaseTableTableFilterComposer,
    $$TarifaBaseTableTableOrderingComposer,
    $$TarifaBaseTableTableCreateCompanionBuilder,
    $$TarifaBaseTableTableUpdateCompanionBuilder> {
  $$TarifaBaseTableTableTableManager(
      _$AppDatabase db, $TarifaBaseTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TarifaBaseTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TarifaBaseTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<double?> aumentoIntegrado = const Value.absent(),
            Value<bool?> conAutocalculacion = const Value.absent(),
            Value<double?> upgradeCategoria = const Value.absent(),
            Value<double?> upgradeMenor = const Value.absent(),
            Value<double?> upgradePaxAdic = const Value.absent(),
            Value<int?> tarifaBaseInt = const Value.absent(),
            Value<String?> tarifaBase = const Value.absent(),
            Value<int?> creadoPorInt = const Value.absent(),
            Value<String?> creadoPor = const Value.absent(),
          }) =>
              TarifaBaseTableCompanion(
            idInt: idInt,
            id: id,
            codigo: codigo,
            nombre: nombre,
            aumentoIntegrado: aumentoIntegrado,
            conAutocalculacion: conAutocalculacion,
            upgradeCategoria: upgradeCategoria,
            upgradeMenor: upgradeMenor,
            upgradePaxAdic: upgradePaxAdic,
            tarifaBaseInt: tarifaBaseInt,
            tarifaBase: tarifaBase,
            creadoPorInt: creadoPorInt,
            creadoPor: creadoPor,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<double?> aumentoIntegrado = const Value.absent(),
            Value<bool?> conAutocalculacion = const Value.absent(),
            Value<double?> upgradeCategoria = const Value.absent(),
            Value<double?> upgradeMenor = const Value.absent(),
            Value<double?> upgradePaxAdic = const Value.absent(),
            Value<int?> tarifaBaseInt = const Value.absent(),
            Value<String?> tarifaBase = const Value.absent(),
            Value<int?> creadoPorInt = const Value.absent(),
            Value<String?> creadoPor = const Value.absent(),
          }) =>
              TarifaBaseTableCompanion.insert(
            idInt: idInt,
            id: id,
            codigo: codigo,
            nombre: nombre,
            aumentoIntegrado: aumentoIntegrado,
            conAutocalculacion: conAutocalculacion,
            upgradeCategoria: upgradeCategoria,
            upgradeMenor: upgradeMenor,
            upgradePaxAdic: upgradePaxAdic,
            tarifaBaseInt: tarifaBaseInt,
            tarifaBase: tarifaBase,
            creadoPorInt: creadoPorInt,
            creadoPor: creadoPor,
          ),
        ));
}

class $$TarifaBaseTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaBaseTableTable> {
  $$TarifaBaseTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get aumentoIntegrado => $state.composableBuilder(
      column: $state.table.aumentoIntegrado,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get conAutocalculacion => $state.composableBuilder(
      column: $state.table.conAutocalculacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get upgradeCategoria => $state.composableBuilder(
      column: $state.table.upgradeCategoria,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get upgradeMenor => $state.composableBuilder(
      column: $state.table.upgradeMenor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get upgradePaxAdic => $state.composableBuilder(
      column: $state.table.upgradePaxAdic,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tarifaBase => $state.composableBuilder(
      column: $state.table.tarifaBase,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get creadoPor => $state.composableBuilder(
      column: $state.table.creadoPor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$TarifaBaseTableTableFilterComposer get tarifaBaseInt {
    final $$TarifaBaseTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tarifaBaseInt,
            referencedTable: $state.db.tarifaBaseTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaBaseTableTableFilterComposer(ComposerState($state.db,
                    $state.db.tarifaBaseTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$UsuarioTableTableFilterComposer get creadoPorInt {
    final $$UsuarioTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creadoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableFilterComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter tarifaTableRefs(
      ComposableFilter Function($$TarifaTableTableFilterComposer f) f) {
    final $$TarifaTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.tarifaTable,
        getReferencedColumn: (t) => t.tarifaBaseInt,
        builder: (joinBuilder, parentComposers) =>
            $$TarifaTableTableFilterComposer(ComposerState($state.db,
                $state.db.tarifaTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$TarifaBaseTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaBaseTableTable> {
  $$TarifaBaseTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get aumentoIntegrado => $state.composableBuilder(
      column: $state.table.aumentoIntegrado,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get conAutocalculacion => $state.composableBuilder(
      column: $state.table.conAutocalculacion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get upgradeCategoria => $state.composableBuilder(
      column: $state.table.upgradeCategoria,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get upgradeMenor => $state.composableBuilder(
      column: $state.table.upgradeMenor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get upgradePaxAdic => $state.composableBuilder(
      column: $state.table.upgradePaxAdic,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tarifaBase => $state.composableBuilder(
      column: $state.table.tarifaBase,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get creadoPor => $state.composableBuilder(
      column: $state.table.creadoPor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$TarifaBaseTableTableOrderingComposer get tarifaBaseInt {
    final $$TarifaBaseTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tarifaBaseInt,
            referencedTable: $state.db.tarifaBaseTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaBaseTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.tarifaBaseTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$UsuarioTableTableOrderingComposer get creadoPorInt {
    final $$UsuarioTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creadoPorInt,
        referencedTable: $state.db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableTableOrderingComposer(ComposerState($state.db,
                $state.db.usuarioTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$TarifaTableTableCreateCompanionBuilder = TarifaTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<int?> categoriaInt,
  Value<String?> categoria,
  Value<double?> tarifaAdulto1a2,
  Value<double?> tarifaAdulto3,
  Value<double?> tarifaAdulto4,
  Value<double?> tarifaMenores7a12,
  Value<double?> tarifaMenores0a6,
  Value<double?> tarifaPaxAdicional,
  Value<int?> tarifaBaseInt,
  Value<String?> tarifaBase,
});
typedef $$TarifaTableTableUpdateCompanionBuilder = TarifaTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<DateTime?> createdAt,
  Value<int?> categoriaInt,
  Value<String?> categoria,
  Value<double?> tarifaAdulto1a2,
  Value<double?> tarifaAdulto3,
  Value<double?> tarifaAdulto4,
  Value<double?> tarifaMenores7a12,
  Value<double?> tarifaMenores0a6,
  Value<double?> tarifaPaxAdicional,
  Value<int?> tarifaBaseInt,
  Value<String?> tarifaBase,
});

class $$TarifaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarifaTableTable,
    TarifaTableData,
    $$TarifaTableTableFilterComposer,
    $$TarifaTableTableOrderingComposer,
    $$TarifaTableTableCreateCompanionBuilder,
    $$TarifaTableTableUpdateCompanionBuilder> {
  $$TarifaTableTableTableManager(_$AppDatabase db, $TarifaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TarifaTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TarifaTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int?> categoriaInt = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
            Value<double?> tarifaAdulto1a2 = const Value.absent(),
            Value<double?> tarifaAdulto3 = const Value.absent(),
            Value<double?> tarifaAdulto4 = const Value.absent(),
            Value<double?> tarifaMenores7a12 = const Value.absent(),
            Value<double?> tarifaMenores0a6 = const Value.absent(),
            Value<double?> tarifaPaxAdicional = const Value.absent(),
            Value<int?> tarifaBaseInt = const Value.absent(),
            Value<String?> tarifaBase = const Value.absent(),
          }) =>
              TarifaTableCompanion(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            categoriaInt: categoriaInt,
            categoria: categoria,
            tarifaAdulto1a2: tarifaAdulto1a2,
            tarifaAdulto3: tarifaAdulto3,
            tarifaAdulto4: tarifaAdulto4,
            tarifaMenores7a12: tarifaMenores7a12,
            tarifaMenores0a6: tarifaMenores0a6,
            tarifaPaxAdicional: tarifaPaxAdicional,
            tarifaBaseInt: tarifaBaseInt,
            tarifaBase: tarifaBase,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int?> categoriaInt = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
            Value<double?> tarifaAdulto1a2 = const Value.absent(),
            Value<double?> tarifaAdulto3 = const Value.absent(),
            Value<double?> tarifaAdulto4 = const Value.absent(),
            Value<double?> tarifaMenores7a12 = const Value.absent(),
            Value<double?> tarifaMenores0a6 = const Value.absent(),
            Value<double?> tarifaPaxAdicional = const Value.absent(),
            Value<int?> tarifaBaseInt = const Value.absent(),
            Value<String?> tarifaBase = const Value.absent(),
          }) =>
              TarifaTableCompanion.insert(
            idInt: idInt,
            id: id,
            createdAt: createdAt,
            categoriaInt: categoriaInt,
            categoria: categoria,
            tarifaAdulto1a2: tarifaAdulto1a2,
            tarifaAdulto3: tarifaAdulto3,
            tarifaAdulto4: tarifaAdulto4,
            tarifaMenores7a12: tarifaMenores7a12,
            tarifaMenores0a6: tarifaMenores0a6,
            tarifaPaxAdicional: tarifaPaxAdicional,
            tarifaBaseInt: tarifaBaseInt,
            tarifaBase: tarifaBase,
          ),
        ));
}

class $$TarifaTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaTableTable> {
  $$TarifaTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get categoria => $state.composableBuilder(
      column: $state.table.categoria,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaAdulto1a2 => $state.composableBuilder(
      column: $state.table.tarifaAdulto1a2,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaAdulto3 => $state.composableBuilder(
      column: $state.table.tarifaAdulto3,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaAdulto4 => $state.composableBuilder(
      column: $state.table.tarifaAdulto4,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaMenores7a12 => $state.composableBuilder(
      column: $state.table.tarifaMenores7a12,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaMenores0a6 => $state.composableBuilder(
      column: $state.table.tarifaMenores0a6,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaPaxAdicional => $state.composableBuilder(
      column: $state.table.tarifaPaxAdicional,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tarifaBase => $state.composableBuilder(
      column: $state.table.tarifaBase,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CategoriaTableTableFilterComposer get categoriaInt {
    final $$CategoriaTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoriaInt,
        referencedTable: $state.db.categoriaTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CategoriaTableTableFilterComposer(ComposerState($state.db,
                $state.db.categoriaTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$TarifaBaseTableTableFilterComposer get tarifaBaseInt {
    final $$TarifaBaseTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tarifaBaseInt,
            referencedTable: $state.db.tarifaBaseTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaBaseTableTableFilterComposer(ComposerState($state.db,
                    $state.db.tarifaBaseTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter tarifaTemporadaTableRefs(
      ComposableFilter Function($$TarifaTemporadaTableTableFilterComposer f)
          f) {
    final $$TarifaTemporadaTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.tarifaTemporadaTable,
            getReferencedColumn: (t) => t.tarifaInt,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaTemporadaTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.tarifaTemporadaTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$TarifaTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaTableTable> {
  $$TarifaTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get categoria => $state.composableBuilder(
      column: $state.table.categoria,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaAdulto1a2 => $state.composableBuilder(
      column: $state.table.tarifaAdulto1a2,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaAdulto3 => $state.composableBuilder(
      column: $state.table.tarifaAdulto3,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaAdulto4 => $state.composableBuilder(
      column: $state.table.tarifaAdulto4,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaMenores7a12 => $state.composableBuilder(
      column: $state.table.tarifaMenores7a12,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaMenores0a6 => $state.composableBuilder(
      column: $state.table.tarifaMenores0a6,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaPaxAdicional => $state.composableBuilder(
      column: $state.table.tarifaPaxAdicional,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tarifaBase => $state.composableBuilder(
      column: $state.table.tarifaBase,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CategoriaTableTableOrderingComposer get categoriaInt {
    final $$CategoriaTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoriaInt,
            referencedTable: $state.db.categoriaTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$CategoriaTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.categoriaTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$TarifaBaseTableTableOrderingComposer get tarifaBaseInt {
    final $$TarifaBaseTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tarifaBaseInt,
            referencedTable: $state.db.tarifaBaseTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaBaseTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.tarifaBaseTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$TarifaXDiaTableTableCreateCompanionBuilder = TarifaXDiaTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<int?> tarifaRackInt,
  Value<String?> tarifaRack,
  Value<double?> descIntegrado,
  Value<bool?> esLibre,
  Value<String?> tarifaRackJson,
});
typedef $$TarifaXDiaTableTableUpdateCompanionBuilder = TarifaXDiaTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<int?> tarifaRackInt,
  Value<String?> tarifaRack,
  Value<double?> descIntegrado,
  Value<bool?> esLibre,
  Value<String?> tarifaRackJson,
});

class $$TarifaXDiaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarifaXDiaTableTable,
    TarifaXDiaTableData,
    $$TarifaXDiaTableTableFilterComposer,
    $$TarifaXDiaTableTableOrderingComposer,
    $$TarifaXDiaTableTableCreateCompanionBuilder,
    $$TarifaXDiaTableTableUpdateCompanionBuilder> {
  $$TarifaXDiaTableTableTableManager(
      _$AppDatabase db, $TarifaXDiaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TarifaXDiaTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TarifaXDiaTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<int?> tarifaRackInt = const Value.absent(),
            Value<String?> tarifaRack = const Value.absent(),
            Value<double?> descIntegrado = const Value.absent(),
            Value<bool?> esLibre = const Value.absent(),
            Value<String?> tarifaRackJson = const Value.absent(),
          }) =>
              TarifaXDiaTableCompanion(
            idInt: idInt,
            id: id,
            tarifaRackInt: tarifaRackInt,
            tarifaRack: tarifaRack,
            descIntegrado: descIntegrado,
            esLibre: esLibre,
            tarifaRackJson: tarifaRackJson,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<int?> tarifaRackInt = const Value.absent(),
            Value<String?> tarifaRack = const Value.absent(),
            Value<double?> descIntegrado = const Value.absent(),
            Value<bool?> esLibre = const Value.absent(),
            Value<String?> tarifaRackJson = const Value.absent(),
          }) =>
              TarifaXDiaTableCompanion.insert(
            idInt: idInt,
            id: id,
            tarifaRackInt: tarifaRackInt,
            tarifaRack: tarifaRack,
            descIntegrado: descIntegrado,
            esLibre: esLibre,
            tarifaRackJson: tarifaRackJson,
          ),
        ));
}

class $$TarifaXDiaTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaXDiaTableTable> {
  $$TarifaXDiaTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tarifaRack => $state.composableBuilder(
      column: $state.table.tarifaRack,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get descIntegrado => $state.composableBuilder(
      column: $state.table.descIntegrado,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get esLibre => $state.composableBuilder(
      column: $state.table.esLibre,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tarifaRackJson => $state.composableBuilder(
      column: $state.table.tarifaRackJson,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$TarifaRackTableTableFilterComposer get tarifaRackInt {
    final $$TarifaRackTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tarifaRackInt,
            referencedTable: $state.db.tarifaRackTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaRackTableTableFilterComposer(ComposerState($state.db,
                    $state.db.tarifaRackTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter tarifaXHabitacionTableRefs(
      ComposableFilter Function($$TarifaXHabitacionTableTableFilterComposer f)
          f) {
    final $$TarifaXHabitacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.tarifaXHabitacionTable,
            getReferencedColumn: (t) => t.tarifaXDiaInt,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaXHabitacionTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.tarifaXHabitacionTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$TarifaXDiaTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaXDiaTableTable> {
  $$TarifaXDiaTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tarifaRack => $state.composableBuilder(
      column: $state.table.tarifaRack,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get descIntegrado => $state.composableBuilder(
      column: $state.table.descIntegrado,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get esLibre => $state.composableBuilder(
      column: $state.table.esLibre,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tarifaRackJson => $state.composableBuilder(
      column: $state.table.tarifaRackJson,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$TarifaRackTableTableOrderingComposer get tarifaRackInt {
    final $$TarifaRackTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tarifaRackInt,
            referencedTable: $state.db.tarifaRackTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaRackTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.tarifaRackTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$TarifaXHabitacionTableTableCreateCompanionBuilder
    = TarifaXHabitacionTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<int?> habitacionInt,
  Value<String?> habitacion,
  Value<int?> tarifaXDiaInt,
  Value<String?> tarifaXDia,
  Value<int?> dia,
  Value<DateTime?> fecha,
  Value<bool?> esGrupal,
});
typedef $$TarifaXHabitacionTableTableUpdateCompanionBuilder
    = TarifaXHabitacionTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<int?> habitacionInt,
  Value<String?> habitacion,
  Value<int?> tarifaXDiaInt,
  Value<String?> tarifaXDia,
  Value<int?> dia,
  Value<DateTime?> fecha,
  Value<bool?> esGrupal,
});

class $$TarifaXHabitacionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarifaXHabitacionTableTable,
    TarifaXHabitacionTableData,
    $$TarifaXHabitacionTableTableFilterComposer,
    $$TarifaXHabitacionTableTableOrderingComposer,
    $$TarifaXHabitacionTableTableCreateCompanionBuilder,
    $$TarifaXHabitacionTableTableUpdateCompanionBuilder> {
  $$TarifaXHabitacionTableTableTableManager(
      _$AppDatabase db, $TarifaXHabitacionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$TarifaXHabitacionTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$TarifaXHabitacionTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<int?> habitacionInt = const Value.absent(),
            Value<String?> habitacion = const Value.absent(),
            Value<int?> tarifaXDiaInt = const Value.absent(),
            Value<String?> tarifaXDia = const Value.absent(),
            Value<int?> dia = const Value.absent(),
            Value<DateTime?> fecha = const Value.absent(),
            Value<bool?> esGrupal = const Value.absent(),
          }) =>
              TarifaXHabitacionTableCompanion(
            idInt: idInt,
            id: id,
            habitacionInt: habitacionInt,
            habitacion: habitacion,
            tarifaXDiaInt: tarifaXDiaInt,
            tarifaXDia: tarifaXDia,
            dia: dia,
            fecha: fecha,
            esGrupal: esGrupal,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<int?> habitacionInt = const Value.absent(),
            Value<String?> habitacion = const Value.absent(),
            Value<int?> tarifaXDiaInt = const Value.absent(),
            Value<String?> tarifaXDia = const Value.absent(),
            Value<int?> dia = const Value.absent(),
            Value<DateTime?> fecha = const Value.absent(),
            Value<bool?> esGrupal = const Value.absent(),
          }) =>
              TarifaXHabitacionTableCompanion.insert(
            idInt: idInt,
            id: id,
            habitacionInt: habitacionInt,
            habitacion: habitacion,
            tarifaXDiaInt: tarifaXDiaInt,
            tarifaXDia: tarifaXDia,
            dia: dia,
            fecha: fecha,
            esGrupal: esGrupal,
          ),
        ));
}

class $$TarifaXHabitacionTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaXHabitacionTableTable> {
  $$TarifaXHabitacionTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get habitacion => $state.composableBuilder(
      column: $state.table.habitacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tarifaXDia => $state.composableBuilder(
      column: $state.table.tarifaXDia,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get dia => $state.composableBuilder(
      column: $state.table.dia,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get esGrupal => $state.composableBuilder(
      column: $state.table.esGrupal,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$HabitacionTableTableFilterComposer get habitacionInt {
    final $$HabitacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.habitacionInt,
            referencedTable: $state.db.habitacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$HabitacionTableTableFilterComposer(ComposerState($state.db,
                    $state.db.habitacionTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$TarifaXDiaTableTableFilterComposer get tarifaXDiaInt {
    final $$TarifaXDiaTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tarifaXDiaInt,
            referencedTable: $state.db.tarifaXDiaTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaXDiaTableTableFilterComposer(ComposerState($state.db,
                    $state.db.tarifaXDiaTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$TarifaXHabitacionTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaXHabitacionTableTable> {
  $$TarifaXHabitacionTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get habitacion => $state.composableBuilder(
      column: $state.table.habitacion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tarifaXDia => $state.composableBuilder(
      column: $state.table.tarifaXDia,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get dia => $state.composableBuilder(
      column: $state.table.dia,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get esGrupal => $state.composableBuilder(
      column: $state.table.esGrupal,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$HabitacionTableTableOrderingComposer get habitacionInt {
    final $$HabitacionTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.habitacionInt,
            referencedTable: $state.db.habitacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$HabitacionTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.habitacionTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$TarifaXDiaTableTableOrderingComposer get tarifaXDiaInt {
    final $$TarifaXDiaTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tarifaXDiaInt,
            referencedTable: $state.db.tarifaXDiaTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaXDiaTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.tarifaXDiaTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$TemporadaTableTableCreateCompanionBuilder = TemporadaTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> tipo,
  Value<DateTime?> createdAt,
  required String nombre,
  Value<int?> estanciaMinima,
  Value<double?> descuento,
  Value<double?> ocupMin,
  Value<double?> ocupMax,
  Value<int?> tarifaRackInt,
  Value<String?> tarifaRack,
});
typedef $$TemporadaTableTableUpdateCompanionBuilder = TemporadaTableCompanion
    Function({
  Value<int> idInt,
  Value<String?> id,
  Value<String?> tipo,
  Value<DateTime?> createdAt,
  Value<String> nombre,
  Value<int?> estanciaMinima,
  Value<double?> descuento,
  Value<double?> ocupMin,
  Value<double?> ocupMax,
  Value<int?> tarifaRackInt,
  Value<String?> tarifaRack,
});

class $$TemporadaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TemporadaTableTable,
    TemporadaTableData,
    $$TemporadaTableTableFilterComposer,
    $$TemporadaTableTableOrderingComposer,
    $$TemporadaTableTableCreateCompanionBuilder,
    $$TemporadaTableTableUpdateCompanionBuilder> {
  $$TemporadaTableTableTableManager(
      _$AppDatabase db, $TemporadaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TemporadaTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TemporadaTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> tipo = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<int?> estanciaMinima = const Value.absent(),
            Value<double?> descuento = const Value.absent(),
            Value<double?> ocupMin = const Value.absent(),
            Value<double?> ocupMax = const Value.absent(),
            Value<int?> tarifaRackInt = const Value.absent(),
            Value<String?> tarifaRack = const Value.absent(),
          }) =>
              TemporadaTableCompanion(
            idInt: idInt,
            id: id,
            tipo: tipo,
            createdAt: createdAt,
            nombre: nombre,
            estanciaMinima: estanciaMinima,
            descuento: descuento,
            ocupMin: ocupMin,
            ocupMax: ocupMax,
            tarifaRackInt: tarifaRackInt,
            tarifaRack: tarifaRack,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<String?> tipo = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            required String nombre,
            Value<int?> estanciaMinima = const Value.absent(),
            Value<double?> descuento = const Value.absent(),
            Value<double?> ocupMin = const Value.absent(),
            Value<double?> ocupMax = const Value.absent(),
            Value<int?> tarifaRackInt = const Value.absent(),
            Value<String?> tarifaRack = const Value.absent(),
          }) =>
              TemporadaTableCompanion.insert(
            idInt: idInt,
            id: id,
            tipo: tipo,
            createdAt: createdAt,
            nombre: nombre,
            estanciaMinima: estanciaMinima,
            descuento: descuento,
            ocupMin: ocupMin,
            ocupMax: ocupMax,
            tarifaRackInt: tarifaRackInt,
            tarifaRack: tarifaRack,
          ),
        ));
}

class $$TemporadaTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TemporadaTableTable> {
  $$TemporadaTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tipo => $state.composableBuilder(
      column: $state.table.tipo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get estanciaMinima => $state.composableBuilder(
      column: $state.table.estanciaMinima,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get descuento => $state.composableBuilder(
      column: $state.table.descuento,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get ocupMin => $state.composableBuilder(
      column: $state.table.ocupMin,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get ocupMax => $state.composableBuilder(
      column: $state.table.ocupMax,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tarifaRack => $state.composableBuilder(
      column: $state.table.tarifaRack,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$TarifaRackTableTableFilterComposer get tarifaRackInt {
    final $$TarifaRackTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tarifaRackInt,
            referencedTable: $state.db.tarifaRackTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaRackTableTableFilterComposer(ComposerState($state.db,
                    $state.db.tarifaRackTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter tarifaTemporadaTableRefs(
      ComposableFilter Function($$TarifaTemporadaTableTableFilterComposer f)
          f) {
    final $$TarifaTemporadaTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.tarifaTemporadaTable,
            getReferencedColumn: (t) => t.temporadaInt,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaTemporadaTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.tarifaTemporadaTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$TemporadaTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TemporadaTableTable> {
  $$TemporadaTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tipo => $state.composableBuilder(
      column: $state.table.tipo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get estanciaMinima => $state.composableBuilder(
      column: $state.table.estanciaMinima,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get descuento => $state.composableBuilder(
      column: $state.table.descuento,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get ocupMin => $state.composableBuilder(
      column: $state.table.ocupMin,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get ocupMax => $state.composableBuilder(
      column: $state.table.ocupMax,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tarifaRack => $state.composableBuilder(
      column: $state.table.tarifaRack,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$TarifaRackTableTableOrderingComposer get tarifaRackInt {
    final $$TarifaRackTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tarifaRackInt,
            referencedTable: $state.db.tarifaRackTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TarifaRackTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.tarifaRackTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$TarifaTemporadaTableTableCreateCompanionBuilder
    = TarifaTemporadaTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<int?> temporadaInt,
  Value<String?> temporada,
  Value<int?> tarifaInt,
  Value<String?> tarifa,
});
typedef $$TarifaTemporadaTableTableUpdateCompanionBuilder
    = TarifaTemporadaTableCompanion Function({
  Value<int> idInt,
  Value<String?> id,
  Value<int?> temporadaInt,
  Value<String?> temporada,
  Value<int?> tarifaInt,
  Value<String?> tarifa,
});

class $$TarifaTemporadaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarifaTemporadaTableTable,
    TarifaTemporadaTableData,
    $$TarifaTemporadaTableTableFilterComposer,
    $$TarifaTemporadaTableTableOrderingComposer,
    $$TarifaTemporadaTableTableCreateCompanionBuilder,
    $$TarifaTemporadaTableTableUpdateCompanionBuilder> {
  $$TarifaTemporadaTableTableTableManager(
      _$AppDatabase db, $TarifaTemporadaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$TarifaTemporadaTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$TarifaTemporadaTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<int?> temporadaInt = const Value.absent(),
            Value<String?> temporada = const Value.absent(),
            Value<int?> tarifaInt = const Value.absent(),
            Value<String?> tarifa = const Value.absent(),
          }) =>
              TarifaTemporadaTableCompanion(
            idInt: idInt,
            id: id,
            temporadaInt: temporadaInt,
            temporada: temporada,
            tarifaInt: tarifaInt,
            tarifa: tarifa,
          ),
          createCompanionCallback: ({
            Value<int> idInt = const Value.absent(),
            Value<String?> id = const Value.absent(),
            Value<int?> temporadaInt = const Value.absent(),
            Value<String?> temporada = const Value.absent(),
            Value<int?> tarifaInt = const Value.absent(),
            Value<String?> tarifa = const Value.absent(),
          }) =>
              TarifaTemporadaTableCompanion.insert(
            idInt: idInt,
            id: id,
            temporadaInt: temporadaInt,
            temporada: temporada,
            tarifaInt: tarifaInt,
            tarifa: tarifa,
          ),
        ));
}

class $$TarifaTemporadaTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaTemporadaTableTable> {
  $$TarifaTemporadaTableTableFilterComposer(super.$state);
  ColumnFilters<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get temporada => $state.composableBuilder(
      column: $state.table.temporada,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tarifa => $state.composableBuilder(
      column: $state.table.tarifa,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$TemporadaTableTableFilterComposer get temporadaInt {
    final $$TemporadaTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.temporadaInt,
        referencedTable: $state.db.temporadaTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$TemporadaTableTableFilterComposer(ComposerState($state.db,
                $state.db.temporadaTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$TarifaTableTableFilterComposer get tarifaInt {
    final $$TarifaTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tarifaInt,
        referencedTable: $state.db.tarifaTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$TarifaTableTableFilterComposer(ComposerState($state.db,
                $state.db.tarifaTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$TarifaTemporadaTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaTemporadaTableTable> {
  $$TarifaTemporadaTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get idInt => $state.composableBuilder(
      column: $state.table.idInt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get temporada => $state.composableBuilder(
      column: $state.table.temporada,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tarifa => $state.composableBuilder(
      column: $state.table.tarifa,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$TemporadaTableTableOrderingComposer get temporadaInt {
    final $$TemporadaTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.temporadaInt,
            referencedTable: $state.db.temporadaTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TemporadaTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.temporadaTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$TarifaTableTableOrderingComposer get tarifaInt {
    final $$TarifaTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tarifaInt,
        referencedTable: $state.db.tarifaTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$TarifaTableTableOrderingComposer(ComposerState($state.db,
                $state.db.tarifaTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ReservacionBrazaleteTableTableCreateCompanionBuilder
    = ReservacionBrazaleteTableCompanion Function({
  Value<int?> reservacionInt,
  Value<String?> reservacion,
  Value<String?> codigo,
  Value<String?> folioReservacion,
  Value<int> rowid,
});
typedef $$ReservacionBrazaleteTableTableUpdateCompanionBuilder
    = ReservacionBrazaleteTableCompanion Function({
  Value<int?> reservacionInt,
  Value<String?> reservacion,
  Value<String?> codigo,
  Value<String?> folioReservacion,
  Value<int> rowid,
});

class $$ReservacionBrazaleteTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReservacionBrazaleteTableTable,
    ReservacionBrazaleteTableData,
    $$ReservacionBrazaleteTableTableFilterComposer,
    $$ReservacionBrazaleteTableTableOrderingComposer,
    $$ReservacionBrazaleteTableTableCreateCompanionBuilder,
    $$ReservacionBrazaleteTableTableUpdateCompanionBuilder> {
  $$ReservacionBrazaleteTableTableTableManager(
      _$AppDatabase db, $ReservacionBrazaleteTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ReservacionBrazaleteTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ReservacionBrazaleteTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> reservacionInt = const Value.absent(),
            Value<String?> reservacion = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<String?> folioReservacion = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReservacionBrazaleteTableCompanion(
            reservacionInt: reservacionInt,
            reservacion: reservacion,
            codigo: codigo,
            folioReservacion: folioReservacion,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<int?> reservacionInt = const Value.absent(),
            Value<String?> reservacion = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<String?> folioReservacion = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReservacionBrazaleteTableCompanion.insert(
            reservacionInt: reservacionInt,
            reservacion: reservacion,
            codigo: codigo,
            folioReservacion: folioReservacion,
            rowid: rowid,
          ),
        ));
}

class $$ReservacionBrazaleteTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ReservacionBrazaleteTableTable> {
  $$ReservacionBrazaleteTableTableFilterComposer(super.$state);
  ColumnFilters<String> get reservacion => $state.composableBuilder(
      column: $state.table.reservacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get folioReservacion => $state.composableBuilder(
      column: $state.table.folioReservacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ReservacionTableTableFilterComposer get reservacionInt {
    final $$ReservacionTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.reservacionInt,
            referencedTable: $state.db.reservacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ReservacionTableTableFilterComposer(ComposerState($state.db,
                    $state.db.reservacionTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ReservacionBrazaleteTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ReservacionBrazaleteTableTable> {
  $$ReservacionBrazaleteTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get reservacion => $state.composableBuilder(
      column: $state.table.reservacion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get folioReservacion => $state.composableBuilder(
      column: $state.table.folioReservacion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ReservacionTableTableOrderingComposer get reservacionInt {
    final $$ReservacionTableTableOrderingComposer composer = $state
        .composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.reservacionInt,
            referencedTable: $state.db.reservacionTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ReservacionTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.reservacionTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TipoHabitacionTableTableTableManager get tipoHabitacionTable =>
      $$TipoHabitacionTableTableTableManager(_db, _db.tipoHabitacionTable);
  $$ImagenTableTableTableManager get imagenTable =>
      $$ImagenTableTableTableManager(_db, _db.imagenTable);
  $$RolTableTableTableManager get rolTable =>
      $$RolTableTableTableManager(_db, _db.rolTable);
  $$UsuarioTableTableTableManager get usuarioTable =>
      $$UsuarioTableTableTableManager(_db, _db.usuarioTable);
  $$CategoriaTableTableTableManager get categoriaTable =>
      $$CategoriaTableTableTableManager(_db, _db.categoriaTable);
  $$ClienteTableTableTableManager get clienteTable =>
      $$ClienteTableTableTableManager(_db, _db.clienteTable);
  $$CotizacionTableTableTableManager get cotizacionTable =>
      $$CotizacionTableTableTableManager(_db, _db.cotizacionTable);
  $$HabitacionTableTableTableManager get habitacionTable =>
      $$HabitacionTableTableTableManager(_db, _db.habitacionTable);
  $$NotificacionTableTableTableManager get notificacionTable =>
      $$NotificacionTableTableTableManager(_db, _db.notificacionTable);
  $$TarifaRackTableTableTableManager get tarifaRackTable =>
      $$TarifaRackTableTableTableManager(_db, _db.tarifaRackTable);
  $$PeriodoTableTableTableManager get periodoTable =>
      $$PeriodoTableTableTableManager(_db, _db.periodoTable);
  $$PoliticaTarifarioTableTableTableManager get politicaTarifarioTable =>
      $$PoliticaTarifarioTableTableTableManager(
          _db, _db.politicaTarifarioTable);
  $$ReservacionTableTableTableManager get reservacionTable =>
      $$ReservacionTableTableTableManager(_db, _db.reservacionTable);
  $$ResumenHabitacionTableTableTableManager get resumenHabitacionTable =>
      $$ResumenHabitacionTableTableTableManager(
          _db, _db.resumenHabitacionTable);
  $$TarifaBaseTableTableTableManager get tarifaBaseTable =>
      $$TarifaBaseTableTableTableManager(_db, _db.tarifaBaseTable);
  $$TarifaTableTableTableManager get tarifaTable =>
      $$TarifaTableTableTableManager(_db, _db.tarifaTable);
  $$TarifaXDiaTableTableTableManager get tarifaXDiaTable =>
      $$TarifaXDiaTableTableTableManager(_db, _db.tarifaXDiaTable);
  $$TarifaXHabitacionTableTableTableManager get tarifaXHabitacionTable =>
      $$TarifaXHabitacionTableTableTableManager(
          _db, _db.tarifaXHabitacionTable);
  $$TemporadaTableTableTableManager get temporadaTable =>
      $$TemporadaTableTableTableManager(_db, _db.temporadaTable);
  $$TarifaTemporadaTableTableTableManager get tarifaTemporadaTable =>
      $$TarifaTemporadaTableTableTableManager(_db, _db.tarifaTemporadaTable);
  $$ReservacionBrazaleteTableTableTableManager get reservacionBrazaleteTable =>
      $$ReservacionBrazaleteTableTableTableManager(
          _db, _db.reservacionBrazaleteTable);
}
