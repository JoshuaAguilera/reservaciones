// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsuarioTable extends Usuario with TableInfo<$UsuarioTable, UsuarioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuarioTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<String> rol = GeneratedColumn<String>(
      'rol', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _correoElectronicoMeta =
      const VerificationMeta('correoElectronico');
  @override
  late final GeneratedColumn<String> correoElectronico =
      GeneratedColumn<String>('correo_electronico', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _passwordCorreoMeta =
      const VerificationMeta('passwordCorreo');
  @override
  late final GeneratedColumn<String> passwordCorreo = GeneratedColumn<String>(
      'password_correo', aliasedName, true,
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
  late final GeneratedColumn<String> fechaNacimiento = GeneratedColumn<String>(
      'fecha_nacimiento', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _numCotizacionesMeta =
      const VerificationMeta('numCotizaciones');
  @override
  late final GeneratedColumn<int> numCotizaciones = GeneratedColumn<int>(
      'num_cotizaciones', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        username,
        password,
        rol,
        correoElectronico,
        passwordCorreo,
        telefono,
        fechaNacimiento,
        nombre,
        apellido,
        numCotizaciones
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuario';
  @override
  VerificationContext validateIntegrity(Insertable<UsuarioData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    }
    if (data.containsKey('rol')) {
      context.handle(
          _rolMeta, rol.isAcceptableOrUnknown(data['rol']!, _rolMeta));
    }
    if (data.containsKey('correo_electronico')) {
      context.handle(
          _correoElectronicoMeta,
          correoElectronico.isAcceptableOrUnknown(
              data['correo_electronico']!, _correoElectronicoMeta));
    }
    if (data.containsKey('password_correo')) {
      context.handle(
          _passwordCorreoMeta,
          passwordCorreo.isAcceptableOrUnknown(
              data['password_correo']!, _passwordCorreoMeta));
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
    if (data.containsKey('num_cotizaciones')) {
      context.handle(
          _numCotizacionesMeta,
          numCotizaciones.isAcceptableOrUnknown(
              data['num_cotizaciones']!, _numCotizacionesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsuarioData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsuarioData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password']),
      rol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rol']),
      correoElectronico: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}correo_electronico']),
      passwordCorreo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_correo']),
      telefono: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefono']),
      fechaNacimiento: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}fecha_nacimiento']),
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre']),
      apellido: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}apellido']),
      numCotizaciones: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}num_cotizaciones']),
    );
  }

  @override
  $UsuarioTable createAlias(String alias) {
    return $UsuarioTable(attachedDatabase, alias);
  }
}

class UsuarioData extends DataClass implements Insertable<UsuarioData> {
  final int id;
  final String username;
  final String? password;
  final String? rol;
  final String? correoElectronico;
  final String? passwordCorreo;
  final String? telefono;
  final String? fechaNacimiento;
  final String? nombre;
  final String? apellido;
  final int? numCotizaciones;
  const UsuarioData(
      {required this.id,
      required this.username,
      this.password,
      this.rol,
      this.correoElectronico,
      this.passwordCorreo,
      this.telefono,
      this.fechaNacimiento,
      this.nombre,
      this.apellido,
      this.numCotizaciones});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || rol != null) {
      map['rol'] = Variable<String>(rol);
    }
    if (!nullToAbsent || correoElectronico != null) {
      map['correo_electronico'] = Variable<String>(correoElectronico);
    }
    if (!nullToAbsent || passwordCorreo != null) {
      map['password_correo'] = Variable<String>(passwordCorreo);
    }
    if (!nullToAbsent || telefono != null) {
      map['telefono'] = Variable<String>(telefono);
    }
    if (!nullToAbsent || fechaNacimiento != null) {
      map['fecha_nacimiento'] = Variable<String>(fechaNacimiento);
    }
    if (!nullToAbsent || nombre != null) {
      map['nombre'] = Variable<String>(nombre);
    }
    if (!nullToAbsent || apellido != null) {
      map['apellido'] = Variable<String>(apellido);
    }
    if (!nullToAbsent || numCotizaciones != null) {
      map['num_cotizaciones'] = Variable<int>(numCotizaciones);
    }
    return map;
  }

  UsuarioCompanion toCompanion(bool nullToAbsent) {
    return UsuarioCompanion(
      id: Value(id),
      username: Value(username),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      rol: rol == null && nullToAbsent ? const Value.absent() : Value(rol),
      correoElectronico: correoElectronico == null && nullToAbsent
          ? const Value.absent()
          : Value(correoElectronico),
      passwordCorreo: passwordCorreo == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordCorreo),
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
      numCotizaciones: numCotizaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(numCotizaciones),
    );
  }

  factory UsuarioData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsuarioData(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String?>(json['password']),
      rol: serializer.fromJson<String?>(json['rol']),
      correoElectronico:
          serializer.fromJson<String?>(json['correoElectronico']),
      passwordCorreo: serializer.fromJson<String?>(json['passwordCorreo']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      fechaNacimiento: serializer.fromJson<String?>(json['fechaNacimiento']),
      nombre: serializer.fromJson<String?>(json['nombre']),
      apellido: serializer.fromJson<String?>(json['apellido']),
      numCotizaciones: serializer.fromJson<int?>(json['numCotizaciones']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String?>(password),
      'rol': serializer.toJson<String?>(rol),
      'correoElectronico': serializer.toJson<String?>(correoElectronico),
      'passwordCorreo': serializer.toJson<String?>(passwordCorreo),
      'telefono': serializer.toJson<String?>(telefono),
      'fechaNacimiento': serializer.toJson<String?>(fechaNacimiento),
      'nombre': serializer.toJson<String?>(nombre),
      'apellido': serializer.toJson<String?>(apellido),
      'numCotizaciones': serializer.toJson<int?>(numCotizaciones),
    };
  }

  UsuarioData copyWith(
          {int? id,
          String? username,
          Value<String?> password = const Value.absent(),
          Value<String?> rol = const Value.absent(),
          Value<String?> correoElectronico = const Value.absent(),
          Value<String?> passwordCorreo = const Value.absent(),
          Value<String?> telefono = const Value.absent(),
          Value<String?> fechaNacimiento = const Value.absent(),
          Value<String?> nombre = const Value.absent(),
          Value<String?> apellido = const Value.absent(),
          Value<int?> numCotizaciones = const Value.absent()}) =>
      UsuarioData(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password.present ? password.value : this.password,
        rol: rol.present ? rol.value : this.rol,
        correoElectronico: correoElectronico.present
            ? correoElectronico.value
            : this.correoElectronico,
        passwordCorreo:
            passwordCorreo.present ? passwordCorreo.value : this.passwordCorreo,
        telefono: telefono.present ? telefono.value : this.telefono,
        fechaNacimiento: fechaNacimiento.present
            ? fechaNacimiento.value
            : this.fechaNacimiento,
        nombre: nombre.present ? nombre.value : this.nombre,
        apellido: apellido.present ? apellido.value : this.apellido,
        numCotizaciones: numCotizaciones.present
            ? numCotizaciones.value
            : this.numCotizaciones,
      );
  @override
  String toString() {
    return (StringBuffer('UsuarioData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('rol: $rol, ')
          ..write('correoElectronico: $correoElectronico, ')
          ..write('passwordCorreo: $passwordCorreo, ')
          ..write('telefono: $telefono, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('nombre: $nombre, ')
          ..write('apellido: $apellido, ')
          ..write('numCotizaciones: $numCotizaciones')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      username,
      password,
      rol,
      correoElectronico,
      passwordCorreo,
      telefono,
      fechaNacimiento,
      nombre,
      apellido,
      numCotizaciones);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuarioData &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.rol == this.rol &&
          other.correoElectronico == this.correoElectronico &&
          other.passwordCorreo == this.passwordCorreo &&
          other.telefono == this.telefono &&
          other.fechaNacimiento == this.fechaNacimiento &&
          other.nombre == this.nombre &&
          other.apellido == this.apellido &&
          other.numCotizaciones == this.numCotizaciones);
}

class UsuarioCompanion extends UpdateCompanion<UsuarioData> {
  final Value<int> id;
  final Value<String> username;
  final Value<String?> password;
  final Value<String?> rol;
  final Value<String?> correoElectronico;
  final Value<String?> passwordCorreo;
  final Value<String?> telefono;
  final Value<String?> fechaNacimiento;
  final Value<String?> nombre;
  final Value<String?> apellido;
  final Value<int?> numCotizaciones;
  const UsuarioCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.rol = const Value.absent(),
    this.correoElectronico = const Value.absent(),
    this.passwordCorreo = const Value.absent(),
    this.telefono = const Value.absent(),
    this.fechaNacimiento = const Value.absent(),
    this.nombre = const Value.absent(),
    this.apellido = const Value.absent(),
    this.numCotizaciones = const Value.absent(),
  });
  UsuarioCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    this.password = const Value.absent(),
    this.rol = const Value.absent(),
    this.correoElectronico = const Value.absent(),
    this.passwordCorreo = const Value.absent(),
    this.telefono = const Value.absent(),
    this.fechaNacimiento = const Value.absent(),
    this.nombre = const Value.absent(),
    this.apellido = const Value.absent(),
    this.numCotizaciones = const Value.absent(),
  }) : username = Value(username);
  static Insertable<UsuarioData> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? rol,
    Expression<String>? correoElectronico,
    Expression<String>? passwordCorreo,
    Expression<String>? telefono,
    Expression<String>? fechaNacimiento,
    Expression<String>? nombre,
    Expression<String>? apellido,
    Expression<int>? numCotizaciones,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (rol != null) 'rol': rol,
      if (correoElectronico != null) 'correo_electronico': correoElectronico,
      if (passwordCorreo != null) 'password_correo': passwordCorreo,
      if (telefono != null) 'telefono': telefono,
      if (fechaNacimiento != null) 'fecha_nacimiento': fechaNacimiento,
      if (nombre != null) 'nombre': nombre,
      if (apellido != null) 'apellido': apellido,
      if (numCotizaciones != null) 'num_cotizaciones': numCotizaciones,
    });
  }

  UsuarioCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String?>? password,
      Value<String?>? rol,
      Value<String?>? correoElectronico,
      Value<String?>? passwordCorreo,
      Value<String?>? telefono,
      Value<String?>? fechaNacimiento,
      Value<String?>? nombre,
      Value<String?>? apellido,
      Value<int?>? numCotizaciones}) {
    return UsuarioCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      rol: rol ?? this.rol,
      correoElectronico: correoElectronico ?? this.correoElectronico,
      passwordCorreo: passwordCorreo ?? this.passwordCorreo,
      telefono: telefono ?? this.telefono,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      numCotizaciones: numCotizaciones ?? this.numCotizaciones,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(rol.value);
    }
    if (correoElectronico.present) {
      map['correo_electronico'] = Variable<String>(correoElectronico.value);
    }
    if (passwordCorreo.present) {
      map['password_correo'] = Variable<String>(passwordCorreo.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (fechaNacimiento.present) {
      map['fecha_nacimiento'] = Variable<String>(fechaNacimiento.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (apellido.present) {
      map['apellido'] = Variable<String>(apellido.value);
    }
    if (numCotizaciones.present) {
      map['num_cotizaciones'] = Variable<int>(numCotizaciones.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuarioCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('rol: $rol, ')
          ..write('correoElectronico: $correoElectronico, ')
          ..write('passwordCorreo: $passwordCorreo, ')
          ..write('telefono: $telefono, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('nombre: $nombre, ')
          ..write('apellido: $apellido, ')
          ..write('numCotizaciones: $numCotizaciones')
          ..write(')'))
        .toString();
  }
}

class $CotizacionTable extends Cotizacion
    with TableInfo<$CotizacionTable, CotizacionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CotizacionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _folioPrincipalMeta =
      const VerificationMeta('folioPrincipal');
  @override
  late final GeneratedColumn<String> folioPrincipal = GeneratedColumn<String>(
      'folio_principal', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nombreHuespedMeta =
      const VerificationMeta('nombreHuesped');
  @override
  late final GeneratedColumn<String> nombreHuesped = GeneratedColumn<String>(
      'nombre_huesped', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _numeroTelefonicoMeta =
      const VerificationMeta('numeroTelefonico');
  @override
  late final GeneratedColumn<String> numeroTelefonico = GeneratedColumn<String>(
      'numero_telefonico', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _correoElectricoMeta =
      const VerificationMeta('correoElectrico');
  @override
  late final GeneratedColumn<String> correoElectrico = GeneratedColumn<String>(
      'correo_electrico', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _responsableIDMeta =
      const VerificationMeta('responsableID');
  @override
  late final GeneratedColumn<int> responsableID = GeneratedColumn<int>(
      'responsable_i_d', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _descuentoMeta =
      const VerificationMeta('descuento');
  @override
  late final GeneratedColumn<double> descuento = GeneratedColumn<double>(
      'descuento', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _esGrupoMeta =
      const VerificationMeta('esGrupo');
  @override
  late final GeneratedColumn<bool> esGrupo = GeneratedColumn<bool>(
      'es_grupo', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("es_grupo" IN (0, 1))'));
  static const VerificationMeta _esConcretadoMeta =
      const VerificationMeta('esConcretado');
  @override
  late final GeneratedColumn<bool> esConcretado = GeneratedColumn<bool>(
      'es_concretado', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("es_concretado" IN (0, 1))'));
  static const VerificationMeta _habitacionesMeta =
      const VerificationMeta('habitaciones');
  @override
  late final GeneratedColumn<int> habitaciones = GeneratedColumn<int>(
      'habitaciones', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        folioPrincipal,
        nombreHuesped,
        numeroTelefonico,
        correoElectrico,
        tipo,
        fecha,
        responsableID,
        total,
        descuento,
        esGrupo,
        esConcretado,
        habitaciones
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cotizacion';
  @override
  VerificationContext validateIntegrity(Insertable<CotizacionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('folio_principal')) {
      context.handle(
          _folioPrincipalMeta,
          folioPrincipal.isAcceptableOrUnknown(
              data['folio_principal']!, _folioPrincipalMeta));
    }
    if (data.containsKey('nombre_huesped')) {
      context.handle(
          _nombreHuespedMeta,
          nombreHuesped.isAcceptableOrUnknown(
              data['nombre_huesped']!, _nombreHuespedMeta));
    }
    if (data.containsKey('numero_telefonico')) {
      context.handle(
          _numeroTelefonicoMeta,
          numeroTelefonico.isAcceptableOrUnknown(
              data['numero_telefonico']!, _numeroTelefonicoMeta));
    }
    if (data.containsKey('correo_electrico')) {
      context.handle(
          _correoElectricoMeta,
          correoElectrico.isAcceptableOrUnknown(
              data['correo_electrico']!, _correoElectricoMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('responsable_i_d')) {
      context.handle(
          _responsableIDMeta,
          responsableID.isAcceptableOrUnknown(
              data['responsable_i_d']!, _responsableIDMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    }
    if (data.containsKey('descuento')) {
      context.handle(_descuentoMeta,
          descuento.isAcceptableOrUnknown(data['descuento']!, _descuentoMeta));
    }
    if (data.containsKey('es_grupo')) {
      context.handle(_esGrupoMeta,
          esGrupo.isAcceptableOrUnknown(data['es_grupo']!, _esGrupoMeta));
    }
    if (data.containsKey('es_concretado')) {
      context.handle(
          _esConcretadoMeta,
          esConcretado.isAcceptableOrUnknown(
              data['es_concretado']!, _esConcretadoMeta));
    }
    if (data.containsKey('habitaciones')) {
      context.handle(
          _habitacionesMeta,
          habitaciones.isAcceptableOrUnknown(
              data['habitaciones']!, _habitacionesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CotizacionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CotizacionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      folioPrincipal: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}folio_principal']),
      nombreHuesped: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre_huesped']),
      numeroTelefonico: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}numero_telefonico']),
      correoElectrico: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}correo_electrico']),
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo']),
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      responsableID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}responsable_i_d']),
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total']),
      descuento: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}descuento']),
      esGrupo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}es_grupo']),
      esConcretado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}es_concretado']),
      habitaciones: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}habitaciones']),
    );
  }

  @override
  $CotizacionTable createAlias(String alias) {
    return $CotizacionTable(attachedDatabase, alias);
  }
}

class CotizacionData extends DataClass implements Insertable<CotizacionData> {
  final int id;
  final String? folioPrincipal;
  final String? nombreHuesped;
  final String? numeroTelefonico;
  final String? correoElectrico;
  final String? tipo;
  final DateTime fecha;
  final int? responsableID;
  final double? total;
  final double? descuento;
  final bool? esGrupo;
  final bool? esConcretado;
  final int? habitaciones;
  const CotizacionData(
      {required this.id,
      this.folioPrincipal,
      this.nombreHuesped,
      this.numeroTelefonico,
      this.correoElectrico,
      this.tipo,
      required this.fecha,
      this.responsableID,
      this.total,
      this.descuento,
      this.esGrupo,
      this.esConcretado,
      this.habitaciones});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || folioPrincipal != null) {
      map['folio_principal'] = Variable<String>(folioPrincipal);
    }
    if (!nullToAbsent || nombreHuesped != null) {
      map['nombre_huesped'] = Variable<String>(nombreHuesped);
    }
    if (!nullToAbsent || numeroTelefonico != null) {
      map['numero_telefonico'] = Variable<String>(numeroTelefonico);
    }
    if (!nullToAbsent || correoElectrico != null) {
      map['correo_electrico'] = Variable<String>(correoElectrico);
    }
    if (!nullToAbsent || tipo != null) {
      map['tipo'] = Variable<String>(tipo);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    if (!nullToAbsent || responsableID != null) {
      map['responsable_i_d'] = Variable<int>(responsableID);
    }
    if (!nullToAbsent || total != null) {
      map['total'] = Variable<double>(total);
    }
    if (!nullToAbsent || descuento != null) {
      map['descuento'] = Variable<double>(descuento);
    }
    if (!nullToAbsent || esGrupo != null) {
      map['es_grupo'] = Variable<bool>(esGrupo);
    }
    if (!nullToAbsent || esConcretado != null) {
      map['es_concretado'] = Variable<bool>(esConcretado);
    }
    if (!nullToAbsent || habitaciones != null) {
      map['habitaciones'] = Variable<int>(habitaciones);
    }
    return map;
  }

  CotizacionCompanion toCompanion(bool nullToAbsent) {
    return CotizacionCompanion(
      id: Value(id),
      folioPrincipal: folioPrincipal == null && nullToAbsent
          ? const Value.absent()
          : Value(folioPrincipal),
      nombreHuesped: nombreHuesped == null && nullToAbsent
          ? const Value.absent()
          : Value(nombreHuesped),
      numeroTelefonico: numeroTelefonico == null && nullToAbsent
          ? const Value.absent()
          : Value(numeroTelefonico),
      correoElectrico: correoElectrico == null && nullToAbsent
          ? const Value.absent()
          : Value(correoElectrico),
      tipo: tipo == null && nullToAbsent ? const Value.absent() : Value(tipo),
      fecha: Value(fecha),
      responsableID: responsableID == null && nullToAbsent
          ? const Value.absent()
          : Value(responsableID),
      total:
          total == null && nullToAbsent ? const Value.absent() : Value(total),
      descuento: descuento == null && nullToAbsent
          ? const Value.absent()
          : Value(descuento),
      esGrupo: esGrupo == null && nullToAbsent
          ? const Value.absent()
          : Value(esGrupo),
      esConcretado: esConcretado == null && nullToAbsent
          ? const Value.absent()
          : Value(esConcretado),
      habitaciones: habitaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(habitaciones),
    );
  }

  factory CotizacionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CotizacionData(
      id: serializer.fromJson<int>(json['id']),
      folioPrincipal: serializer.fromJson<String?>(json['folioPrincipal']),
      nombreHuesped: serializer.fromJson<String?>(json['nombreHuesped']),
      numeroTelefonico: serializer.fromJson<String?>(json['numeroTelefonico']),
      correoElectrico: serializer.fromJson<String?>(json['correoElectrico']),
      tipo: serializer.fromJson<String?>(json['tipo']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      responsableID: serializer.fromJson<int?>(json['responsableID']),
      total: serializer.fromJson<double?>(json['total']),
      descuento: serializer.fromJson<double?>(json['descuento']),
      esGrupo: serializer.fromJson<bool?>(json['esGrupo']),
      esConcretado: serializer.fromJson<bool?>(json['esConcretado']),
      habitaciones: serializer.fromJson<int?>(json['habitaciones']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'folioPrincipal': serializer.toJson<String?>(folioPrincipal),
      'nombreHuesped': serializer.toJson<String?>(nombreHuesped),
      'numeroTelefonico': serializer.toJson<String?>(numeroTelefonico),
      'correoElectrico': serializer.toJson<String?>(correoElectrico),
      'tipo': serializer.toJson<String?>(tipo),
      'fecha': serializer.toJson<DateTime>(fecha),
      'responsableID': serializer.toJson<int?>(responsableID),
      'total': serializer.toJson<double?>(total),
      'descuento': serializer.toJson<double?>(descuento),
      'esGrupo': serializer.toJson<bool?>(esGrupo),
      'esConcretado': serializer.toJson<bool?>(esConcretado),
      'habitaciones': serializer.toJson<int?>(habitaciones),
    };
  }

  CotizacionData copyWith(
          {int? id,
          Value<String?> folioPrincipal = const Value.absent(),
          Value<String?> nombreHuesped = const Value.absent(),
          Value<String?> numeroTelefonico = const Value.absent(),
          Value<String?> correoElectrico = const Value.absent(),
          Value<String?> tipo = const Value.absent(),
          DateTime? fecha,
          Value<int?> responsableID = const Value.absent(),
          Value<double?> total = const Value.absent(),
          Value<double?> descuento = const Value.absent(),
          Value<bool?> esGrupo = const Value.absent(),
          Value<bool?> esConcretado = const Value.absent(),
          Value<int?> habitaciones = const Value.absent()}) =>
      CotizacionData(
        id: id ?? this.id,
        folioPrincipal:
            folioPrincipal.present ? folioPrincipal.value : this.folioPrincipal,
        nombreHuesped:
            nombreHuesped.present ? nombreHuesped.value : this.nombreHuesped,
        numeroTelefonico: numeroTelefonico.present
            ? numeroTelefonico.value
            : this.numeroTelefonico,
        correoElectrico: correoElectrico.present
            ? correoElectrico.value
            : this.correoElectrico,
        tipo: tipo.present ? tipo.value : this.tipo,
        fecha: fecha ?? this.fecha,
        responsableID:
            responsableID.present ? responsableID.value : this.responsableID,
        total: total.present ? total.value : this.total,
        descuento: descuento.present ? descuento.value : this.descuento,
        esGrupo: esGrupo.present ? esGrupo.value : this.esGrupo,
        esConcretado:
            esConcretado.present ? esConcretado.value : this.esConcretado,
        habitaciones:
            habitaciones.present ? habitaciones.value : this.habitaciones,
      );
  @override
  String toString() {
    return (StringBuffer('CotizacionData(')
          ..write('id: $id, ')
          ..write('folioPrincipal: $folioPrincipal, ')
          ..write('nombreHuesped: $nombreHuesped, ')
          ..write('numeroTelefonico: $numeroTelefonico, ')
          ..write('correoElectrico: $correoElectrico, ')
          ..write('tipo: $tipo, ')
          ..write('fecha: $fecha, ')
          ..write('responsableID: $responsableID, ')
          ..write('total: $total, ')
          ..write('descuento: $descuento, ')
          ..write('esGrupo: $esGrupo, ')
          ..write('esConcretado: $esConcretado, ')
          ..write('habitaciones: $habitaciones')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      folioPrincipal,
      nombreHuesped,
      numeroTelefonico,
      correoElectrico,
      tipo,
      fecha,
      responsableID,
      total,
      descuento,
      esGrupo,
      esConcretado,
      habitaciones);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CotizacionData &&
          other.id == this.id &&
          other.folioPrincipal == this.folioPrincipal &&
          other.nombreHuesped == this.nombreHuesped &&
          other.numeroTelefonico == this.numeroTelefonico &&
          other.correoElectrico == this.correoElectrico &&
          other.tipo == this.tipo &&
          other.fecha == this.fecha &&
          other.responsableID == this.responsableID &&
          other.total == this.total &&
          other.descuento == this.descuento &&
          other.esGrupo == this.esGrupo &&
          other.esConcretado == this.esConcretado &&
          other.habitaciones == this.habitaciones);
}

class CotizacionCompanion extends UpdateCompanion<CotizacionData> {
  final Value<int> id;
  final Value<String?> folioPrincipal;
  final Value<String?> nombreHuesped;
  final Value<String?> numeroTelefonico;
  final Value<String?> correoElectrico;
  final Value<String?> tipo;
  final Value<DateTime> fecha;
  final Value<int?> responsableID;
  final Value<double?> total;
  final Value<double?> descuento;
  final Value<bool?> esGrupo;
  final Value<bool?> esConcretado;
  final Value<int?> habitaciones;
  const CotizacionCompanion({
    this.id = const Value.absent(),
    this.folioPrincipal = const Value.absent(),
    this.nombreHuesped = const Value.absent(),
    this.numeroTelefonico = const Value.absent(),
    this.correoElectrico = const Value.absent(),
    this.tipo = const Value.absent(),
    this.fecha = const Value.absent(),
    this.responsableID = const Value.absent(),
    this.total = const Value.absent(),
    this.descuento = const Value.absent(),
    this.esGrupo = const Value.absent(),
    this.esConcretado = const Value.absent(),
    this.habitaciones = const Value.absent(),
  });
  CotizacionCompanion.insert({
    this.id = const Value.absent(),
    this.folioPrincipal = const Value.absent(),
    this.nombreHuesped = const Value.absent(),
    this.numeroTelefonico = const Value.absent(),
    this.correoElectrico = const Value.absent(),
    this.tipo = const Value.absent(),
    required DateTime fecha,
    this.responsableID = const Value.absent(),
    this.total = const Value.absent(),
    this.descuento = const Value.absent(),
    this.esGrupo = const Value.absent(),
    this.esConcretado = const Value.absent(),
    this.habitaciones = const Value.absent(),
  }) : fecha = Value(fecha);
  static Insertable<CotizacionData> custom({
    Expression<int>? id,
    Expression<String>? folioPrincipal,
    Expression<String>? nombreHuesped,
    Expression<String>? numeroTelefonico,
    Expression<String>? correoElectrico,
    Expression<String>? tipo,
    Expression<DateTime>? fecha,
    Expression<int>? responsableID,
    Expression<double>? total,
    Expression<double>? descuento,
    Expression<bool>? esGrupo,
    Expression<bool>? esConcretado,
    Expression<int>? habitaciones,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (folioPrincipal != null) 'folio_principal': folioPrincipal,
      if (nombreHuesped != null) 'nombre_huesped': nombreHuesped,
      if (numeroTelefonico != null) 'numero_telefonico': numeroTelefonico,
      if (correoElectrico != null) 'correo_electrico': correoElectrico,
      if (tipo != null) 'tipo': tipo,
      if (fecha != null) 'fecha': fecha,
      if (responsableID != null) 'responsable_i_d': responsableID,
      if (total != null) 'total': total,
      if (descuento != null) 'descuento': descuento,
      if (esGrupo != null) 'es_grupo': esGrupo,
      if (esConcretado != null) 'es_concretado': esConcretado,
      if (habitaciones != null) 'habitaciones': habitaciones,
    });
  }

  CotizacionCompanion copyWith(
      {Value<int>? id,
      Value<String?>? folioPrincipal,
      Value<String?>? nombreHuesped,
      Value<String?>? numeroTelefonico,
      Value<String?>? correoElectrico,
      Value<String?>? tipo,
      Value<DateTime>? fecha,
      Value<int?>? responsableID,
      Value<double?>? total,
      Value<double?>? descuento,
      Value<bool?>? esGrupo,
      Value<bool?>? esConcretado,
      Value<int?>? habitaciones}) {
    return CotizacionCompanion(
      id: id ?? this.id,
      folioPrincipal: folioPrincipal ?? this.folioPrincipal,
      nombreHuesped: nombreHuesped ?? this.nombreHuesped,
      numeroTelefonico: numeroTelefonico ?? this.numeroTelefonico,
      correoElectrico: correoElectrico ?? this.correoElectrico,
      tipo: tipo ?? this.tipo,
      fecha: fecha ?? this.fecha,
      responsableID: responsableID ?? this.responsableID,
      total: total ?? this.total,
      descuento: descuento ?? this.descuento,
      esGrupo: esGrupo ?? this.esGrupo,
      esConcretado: esConcretado ?? this.esConcretado,
      habitaciones: habitaciones ?? this.habitaciones,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (folioPrincipal.present) {
      map['folio_principal'] = Variable<String>(folioPrincipal.value);
    }
    if (nombreHuesped.present) {
      map['nombre_huesped'] = Variable<String>(nombreHuesped.value);
    }
    if (numeroTelefonico.present) {
      map['numero_telefonico'] = Variable<String>(numeroTelefonico.value);
    }
    if (correoElectrico.present) {
      map['correo_electrico'] = Variable<String>(correoElectrico.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (responsableID.present) {
      map['responsable_i_d'] = Variable<int>(responsableID.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (descuento.present) {
      map['descuento'] = Variable<double>(descuento.value);
    }
    if (esGrupo.present) {
      map['es_grupo'] = Variable<bool>(esGrupo.value);
    }
    if (esConcretado.present) {
      map['es_concretado'] = Variable<bool>(esConcretado.value);
    }
    if (habitaciones.present) {
      map['habitaciones'] = Variable<int>(habitaciones.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CotizacionCompanion(')
          ..write('id: $id, ')
          ..write('folioPrincipal: $folioPrincipal, ')
          ..write('nombreHuesped: $nombreHuesped, ')
          ..write('numeroTelefonico: $numeroTelefonico, ')
          ..write('correoElectrico: $correoElectrico, ')
          ..write('tipo: $tipo, ')
          ..write('fecha: $fecha, ')
          ..write('responsableID: $responsableID, ')
          ..write('total: $total, ')
          ..write('descuento: $descuento, ')
          ..write('esGrupo: $esGrupo, ')
          ..write('esConcretado: $esConcretado, ')
          ..write('habitaciones: $habitaciones')
          ..write(')'))
        .toString();
  }
}

class $HabitacionTable extends Habitacion
    with TableInfo<$HabitacionTable, HabitacionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitacionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _folioHabitacionMeta =
      const VerificationMeta('folioHabitacion');
  @override
  late final GeneratedColumn<String> folioHabitacion = GeneratedColumn<String>(
      'folio_habitacion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subfolioMeta =
      const VerificationMeta('subfolio');
  @override
  late final GeneratedColumn<String> subfolio = GeneratedColumn<String>(
      'subfolio', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _planMeta = const VerificationMeta('plan');
  @override
  late final GeneratedColumn<String> plan = GeneratedColumn<String>(
      'plan', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _esPreventaMeta =
      const VerificationMeta('esPreventa');
  @override
  late final GeneratedColumn<bool> esPreventa = GeneratedColumn<bool>(
      'es_preventa', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("es_preventa" IN (0, 1))'));
  static const VerificationMeta _fechaCheckInMeta =
      const VerificationMeta('fechaCheckIn');
  @override
  late final GeneratedColumn<String> fechaCheckIn = GeneratedColumn<String>(
      'fecha_check_in', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaCheckOutMeta =
      const VerificationMeta('fechaCheckOut');
  @override
  late final GeneratedColumn<String> fechaCheckOut = GeneratedColumn<String>(
      'fecha_check_out', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
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
  @override
  List<GeneratedColumn> get $columns => [
        id,
        folioHabitacion,
        subfolio,
        categoria,
        plan,
        esPreventa,
        fechaCheckIn,
        fechaCheckOut,
        fecha,
        adultos,
        menores0a6,
        menores7a12,
        paxAdic
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habitacion';
  @override
  VerificationContext validateIntegrity(Insertable<HabitacionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('folio_habitacion')) {
      context.handle(
          _folioHabitacionMeta,
          folioHabitacion.isAcceptableOrUnknown(
              data['folio_habitacion']!, _folioHabitacionMeta));
    } else if (isInserting) {
      context.missing(_folioHabitacionMeta);
    }
    if (data.containsKey('subfolio')) {
      context.handle(_subfolioMeta,
          subfolio.isAcceptableOrUnknown(data['subfolio']!, _subfolioMeta));
    } else if (isInserting) {
      context.missing(_subfolioMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    } else if (isInserting) {
      context.missing(_categoriaMeta);
    }
    if (data.containsKey('plan')) {
      context.handle(
          _planMeta, plan.isAcceptableOrUnknown(data['plan']!, _planMeta));
    } else if (isInserting) {
      context.missing(_planMeta);
    }
    if (data.containsKey('es_preventa')) {
      context.handle(
          _esPreventaMeta,
          esPreventa.isAcceptableOrUnknown(
              data['es_preventa']!, _esPreventaMeta));
    } else if (isInserting) {
      context.missing(_esPreventaMeta);
    }
    if (data.containsKey('fecha_check_in')) {
      context.handle(
          _fechaCheckInMeta,
          fechaCheckIn.isAcceptableOrUnknown(
              data['fecha_check_in']!, _fechaCheckInMeta));
    } else if (isInserting) {
      context.missing(_fechaCheckInMeta);
    }
    if (data.containsKey('fecha_check_out')) {
      context.handle(
          _fechaCheckOutMeta,
          fechaCheckOut.isAcceptableOrUnknown(
              data['fecha_check_out']!, _fechaCheckOutMeta));
    } else if (isInserting) {
      context.missing(_fechaCheckOutMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitacionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitacionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      folioHabitacion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}folio_habitacion'])!,
      subfolio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subfolio'])!,
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria'])!,
      plan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan'])!,
      esPreventa: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}es_preventa'])!,
      fechaCheckIn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fecha_check_in'])!,
      fechaCheckOut: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}fecha_check_out'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      adultos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}adultos']),
      menores0a6: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}menores0a6']),
      menores7a12: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}menores7a12']),
      paxAdic: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pax_adic']),
    );
  }

  @override
  $HabitacionTable createAlias(String alias) {
    return $HabitacionTable(attachedDatabase, alias);
  }
}

class HabitacionData extends DataClass implements Insertable<HabitacionData> {
  final int id;
  final String folioHabitacion;
  final String subfolio;
  final String categoria;
  final String plan;
  final bool esPreventa;
  final String fechaCheckIn;
  final String fechaCheckOut;
  final DateTime fecha;
  final int? adultos;
  final int? menores0a6;
  final int? menores7a12;
  final int? paxAdic;
  const HabitacionData(
      {required this.id,
      required this.folioHabitacion,
      required this.subfolio,
      required this.categoria,
      required this.plan,
      required this.esPreventa,
      required this.fechaCheckIn,
      required this.fechaCheckOut,
      required this.fecha,
      this.adultos,
      this.menores0a6,
      this.menores7a12,
      this.paxAdic});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['folio_habitacion'] = Variable<String>(folioHabitacion);
    map['subfolio'] = Variable<String>(subfolio);
    map['categoria'] = Variable<String>(categoria);
    map['plan'] = Variable<String>(plan);
    map['es_preventa'] = Variable<bool>(esPreventa);
    map['fecha_check_in'] = Variable<String>(fechaCheckIn);
    map['fecha_check_out'] = Variable<String>(fechaCheckOut);
    map['fecha'] = Variable<DateTime>(fecha);
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
    return map;
  }

  HabitacionCompanion toCompanion(bool nullToAbsent) {
    return HabitacionCompanion(
      id: Value(id),
      folioHabitacion: Value(folioHabitacion),
      subfolio: Value(subfolio),
      categoria: Value(categoria),
      plan: Value(plan),
      esPreventa: Value(esPreventa),
      fechaCheckIn: Value(fechaCheckIn),
      fechaCheckOut: Value(fechaCheckOut),
      fecha: Value(fecha),
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
    );
  }

  factory HabitacionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitacionData(
      id: serializer.fromJson<int>(json['id']),
      folioHabitacion: serializer.fromJson<String>(json['folioHabitacion']),
      subfolio: serializer.fromJson<String>(json['subfolio']),
      categoria: serializer.fromJson<String>(json['categoria']),
      plan: serializer.fromJson<String>(json['plan']),
      esPreventa: serializer.fromJson<bool>(json['esPreventa']),
      fechaCheckIn: serializer.fromJson<String>(json['fechaCheckIn']),
      fechaCheckOut: serializer.fromJson<String>(json['fechaCheckOut']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      adultos: serializer.fromJson<int?>(json['adultos']),
      menores0a6: serializer.fromJson<int?>(json['menores0a6']),
      menores7a12: serializer.fromJson<int?>(json['menores7a12']),
      paxAdic: serializer.fromJson<int?>(json['paxAdic']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'folioHabitacion': serializer.toJson<String>(folioHabitacion),
      'subfolio': serializer.toJson<String>(subfolio),
      'categoria': serializer.toJson<String>(categoria),
      'plan': serializer.toJson<String>(plan),
      'esPreventa': serializer.toJson<bool>(esPreventa),
      'fechaCheckIn': serializer.toJson<String>(fechaCheckIn),
      'fechaCheckOut': serializer.toJson<String>(fechaCheckOut),
      'fecha': serializer.toJson<DateTime>(fecha),
      'adultos': serializer.toJson<int?>(adultos),
      'menores0a6': serializer.toJson<int?>(menores0a6),
      'menores7a12': serializer.toJson<int?>(menores7a12),
      'paxAdic': serializer.toJson<int?>(paxAdic),
    };
  }

  HabitacionData copyWith(
          {int? id,
          String? folioHabitacion,
          String? subfolio,
          String? categoria,
          String? plan,
          bool? esPreventa,
          String? fechaCheckIn,
          String? fechaCheckOut,
          DateTime? fecha,
          Value<int?> adultos = const Value.absent(),
          Value<int?> menores0a6 = const Value.absent(),
          Value<int?> menores7a12 = const Value.absent(),
          Value<int?> paxAdic = const Value.absent()}) =>
      HabitacionData(
        id: id ?? this.id,
        folioHabitacion: folioHabitacion ?? this.folioHabitacion,
        subfolio: subfolio ?? this.subfolio,
        categoria: categoria ?? this.categoria,
        plan: plan ?? this.plan,
        esPreventa: esPreventa ?? this.esPreventa,
        fechaCheckIn: fechaCheckIn ?? this.fechaCheckIn,
        fechaCheckOut: fechaCheckOut ?? this.fechaCheckOut,
        fecha: fecha ?? this.fecha,
        adultos: adultos.present ? adultos.value : this.adultos,
        menores0a6: menores0a6.present ? menores0a6.value : this.menores0a6,
        menores7a12: menores7a12.present ? menores7a12.value : this.menores7a12,
        paxAdic: paxAdic.present ? paxAdic.value : this.paxAdic,
      );
  @override
  String toString() {
    return (StringBuffer('HabitacionData(')
          ..write('id: $id, ')
          ..write('folioHabitacion: $folioHabitacion, ')
          ..write('subfolio: $subfolio, ')
          ..write('categoria: $categoria, ')
          ..write('plan: $plan, ')
          ..write('esPreventa: $esPreventa, ')
          ..write('fechaCheckIn: $fechaCheckIn, ')
          ..write('fechaCheckOut: $fechaCheckOut, ')
          ..write('fecha: $fecha, ')
          ..write('adultos: $adultos, ')
          ..write('menores0a6: $menores0a6, ')
          ..write('menores7a12: $menores7a12, ')
          ..write('paxAdic: $paxAdic')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      folioHabitacion,
      subfolio,
      categoria,
      plan,
      esPreventa,
      fechaCheckIn,
      fechaCheckOut,
      fecha,
      adultos,
      menores0a6,
      menores7a12,
      paxAdic);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitacionData &&
          other.id == this.id &&
          other.folioHabitacion == this.folioHabitacion &&
          other.subfolio == this.subfolio &&
          other.categoria == this.categoria &&
          other.plan == this.plan &&
          other.esPreventa == this.esPreventa &&
          other.fechaCheckIn == this.fechaCheckIn &&
          other.fechaCheckOut == this.fechaCheckOut &&
          other.fecha == this.fecha &&
          other.adultos == this.adultos &&
          other.menores0a6 == this.menores0a6 &&
          other.menores7a12 == this.menores7a12 &&
          other.paxAdic == this.paxAdic);
}

class HabitacionCompanion extends UpdateCompanion<HabitacionData> {
  final Value<int> id;
  final Value<String> folioHabitacion;
  final Value<String> subfolio;
  final Value<String> categoria;
  final Value<String> plan;
  final Value<bool> esPreventa;
  final Value<String> fechaCheckIn;
  final Value<String> fechaCheckOut;
  final Value<DateTime> fecha;
  final Value<int?> adultos;
  final Value<int?> menores0a6;
  final Value<int?> menores7a12;
  final Value<int?> paxAdic;
  const HabitacionCompanion({
    this.id = const Value.absent(),
    this.folioHabitacion = const Value.absent(),
    this.subfolio = const Value.absent(),
    this.categoria = const Value.absent(),
    this.plan = const Value.absent(),
    this.esPreventa = const Value.absent(),
    this.fechaCheckIn = const Value.absent(),
    this.fechaCheckOut = const Value.absent(),
    this.fecha = const Value.absent(),
    this.adultos = const Value.absent(),
    this.menores0a6 = const Value.absent(),
    this.menores7a12 = const Value.absent(),
    this.paxAdic = const Value.absent(),
  });
  HabitacionCompanion.insert({
    this.id = const Value.absent(),
    required String folioHabitacion,
    required String subfolio,
    required String categoria,
    required String plan,
    required bool esPreventa,
    required String fechaCheckIn,
    required String fechaCheckOut,
    required DateTime fecha,
    this.adultos = const Value.absent(),
    this.menores0a6 = const Value.absent(),
    this.menores7a12 = const Value.absent(),
    this.paxAdic = const Value.absent(),
  })  : folioHabitacion = Value(folioHabitacion),
        subfolio = Value(subfolio),
        categoria = Value(categoria),
        plan = Value(plan),
        esPreventa = Value(esPreventa),
        fechaCheckIn = Value(fechaCheckIn),
        fechaCheckOut = Value(fechaCheckOut),
        fecha = Value(fecha);
  static Insertable<HabitacionData> custom({
    Expression<int>? id,
    Expression<String>? folioHabitacion,
    Expression<String>? subfolio,
    Expression<String>? categoria,
    Expression<String>? plan,
    Expression<bool>? esPreventa,
    Expression<String>? fechaCheckIn,
    Expression<String>? fechaCheckOut,
    Expression<DateTime>? fecha,
    Expression<int>? adultos,
    Expression<int>? menores0a6,
    Expression<int>? menores7a12,
    Expression<int>? paxAdic,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (folioHabitacion != null) 'folio_habitacion': folioHabitacion,
      if (subfolio != null) 'subfolio': subfolio,
      if (categoria != null) 'categoria': categoria,
      if (plan != null) 'plan': plan,
      if (esPreventa != null) 'es_preventa': esPreventa,
      if (fechaCheckIn != null) 'fecha_check_in': fechaCheckIn,
      if (fechaCheckOut != null) 'fecha_check_out': fechaCheckOut,
      if (fecha != null) 'fecha': fecha,
      if (adultos != null) 'adultos': adultos,
      if (menores0a6 != null) 'menores0a6': menores0a6,
      if (menores7a12 != null) 'menores7a12': menores7a12,
      if (paxAdic != null) 'pax_adic': paxAdic,
    });
  }

  HabitacionCompanion copyWith(
      {Value<int>? id,
      Value<String>? folioHabitacion,
      Value<String>? subfolio,
      Value<String>? categoria,
      Value<String>? plan,
      Value<bool>? esPreventa,
      Value<String>? fechaCheckIn,
      Value<String>? fechaCheckOut,
      Value<DateTime>? fecha,
      Value<int?>? adultos,
      Value<int?>? menores0a6,
      Value<int?>? menores7a12,
      Value<int?>? paxAdic}) {
    return HabitacionCompanion(
      id: id ?? this.id,
      folioHabitacion: folioHabitacion ?? this.folioHabitacion,
      subfolio: subfolio ?? this.subfolio,
      categoria: categoria ?? this.categoria,
      plan: plan ?? this.plan,
      esPreventa: esPreventa ?? this.esPreventa,
      fechaCheckIn: fechaCheckIn ?? this.fechaCheckIn,
      fechaCheckOut: fechaCheckOut ?? this.fechaCheckOut,
      fecha: fecha ?? this.fecha,
      adultos: adultos ?? this.adultos,
      menores0a6: menores0a6 ?? this.menores0a6,
      menores7a12: menores7a12 ?? this.menores7a12,
      paxAdic: paxAdic ?? this.paxAdic,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (folioHabitacion.present) {
      map['folio_habitacion'] = Variable<String>(folioHabitacion.value);
    }
    if (subfolio.present) {
      map['subfolio'] = Variable<String>(subfolio.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (plan.present) {
      map['plan'] = Variable<String>(plan.value);
    }
    if (esPreventa.present) {
      map['es_preventa'] = Variable<bool>(esPreventa.value);
    }
    if (fechaCheckIn.present) {
      map['fecha_check_in'] = Variable<String>(fechaCheckIn.value);
    }
    if (fechaCheckOut.present) {
      map['fecha_check_out'] = Variable<String>(fechaCheckOut.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitacionCompanion(')
          ..write('id: $id, ')
          ..write('folioHabitacion: $folioHabitacion, ')
          ..write('subfolio: $subfolio, ')
          ..write('categoria: $categoria, ')
          ..write('plan: $plan, ')
          ..write('esPreventa: $esPreventa, ')
          ..write('fechaCheckIn: $fechaCheckIn, ')
          ..write('fechaCheckOut: $fechaCheckOut, ')
          ..write('fecha: $fecha, ')
          ..write('adultos: $adultos, ')
          ..write('menores0a6: $menores0a6, ')
          ..write('menores7a12: $menores7a12, ')
          ..write('paxAdic: $paxAdic')
          ..write(')'))
        .toString();
  }
}

class $TarifaXDiaTable extends TarifaXDia
    with TableInfo<$TarifaXDiaTable, TarifaXDiaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarifaXDiaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _folioTarifaXDiaMeta =
      const VerificationMeta('folioTarifaXDia');
  @override
  late final GeneratedColumn<String> folioTarifaXDia = GeneratedColumn<String>(
      'folio_tarifa_x_dia', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subfolioMeta =
      const VerificationMeta('subfolio');
  @override
  late final GeneratedColumn<String> subfolio = GeneratedColumn<String>(
      'subfolio', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _diaMeta = const VerificationMeta('dia');
  @override
  late final GeneratedColumn<int> dia = GeneratedColumn<int>(
      'dia', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _tarifaRealPaxAdicMeta =
      const VerificationMeta('tarifaRealPaxAdic');
  @override
  late final GeneratedColumn<double> tarifaRealPaxAdic =
      GeneratedColumn<double>('tarifa_real_pax_adic', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaPreventaPaxAdicMeta =
      const VerificationMeta('tarifaPreventaPaxAdic');
  @override
  late final GeneratedColumn<double> tarifaPreventaPaxAdic =
      GeneratedColumn<double>('tarifa_preventa_pax_adic', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaRealAdultoMeta =
      const VerificationMeta('tarifaRealAdulto');
  @override
  late final GeneratedColumn<double> tarifaRealAdulto = GeneratedColumn<double>(
      'tarifa_real_adulto', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaPreventaAdultoMeta =
      const VerificationMeta('tarifaPreventaAdulto');
  @override
  late final GeneratedColumn<double> tarifaPreventaAdulto =
      GeneratedColumn<double>('tarifa_preventa_adulto', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaRealMenores7a12Meta =
      const VerificationMeta('tarifaRealMenores7a12');
  @override
  late final GeneratedColumn<double> tarifaRealMenores7a12 =
      GeneratedColumn<double>('tarifa_real_menores7a12', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaPreventaMenores7a12Meta =
      const VerificationMeta('tarifaPreventaMenores7a12');
  @override
  late final GeneratedColumn<double> tarifaPreventaMenores7a12 =
      GeneratedColumn<double>('tarifa_preventa_menores7a12', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        folioTarifaXDia,
        subfolio,
        dia,
        fecha,
        tarifaRealPaxAdic,
        tarifaPreventaPaxAdic,
        tarifaRealAdulto,
        tarifaPreventaAdulto,
        tarifaRealMenores7a12,
        tarifaPreventaMenores7a12
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarifa_x_dia';
  @override
  VerificationContext validateIntegrity(Insertable<TarifaXDiaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('folio_tarifa_x_dia')) {
      context.handle(
          _folioTarifaXDiaMeta,
          folioTarifaXDia.isAcceptableOrUnknown(
              data['folio_tarifa_x_dia']!, _folioTarifaXDiaMeta));
    }
    if (data.containsKey('subfolio')) {
      context.handle(_subfolioMeta,
          subfolio.isAcceptableOrUnknown(data['subfolio']!, _subfolioMeta));
    }
    if (data.containsKey('dia')) {
      context.handle(
          _diaMeta, dia.isAcceptableOrUnknown(data['dia']!, _diaMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('tarifa_real_pax_adic')) {
      context.handle(
          _tarifaRealPaxAdicMeta,
          tarifaRealPaxAdic.isAcceptableOrUnknown(
              data['tarifa_real_pax_adic']!, _tarifaRealPaxAdicMeta));
    }
    if (data.containsKey('tarifa_preventa_pax_adic')) {
      context.handle(
          _tarifaPreventaPaxAdicMeta,
          tarifaPreventaPaxAdic.isAcceptableOrUnknown(
              data['tarifa_preventa_pax_adic']!, _tarifaPreventaPaxAdicMeta));
    }
    if (data.containsKey('tarifa_real_adulto')) {
      context.handle(
          _tarifaRealAdultoMeta,
          tarifaRealAdulto.isAcceptableOrUnknown(
              data['tarifa_real_adulto']!, _tarifaRealAdultoMeta));
    }
    if (data.containsKey('tarifa_preventa_adulto')) {
      context.handle(
          _tarifaPreventaAdultoMeta,
          tarifaPreventaAdulto.isAcceptableOrUnknown(
              data['tarifa_preventa_adulto']!, _tarifaPreventaAdultoMeta));
    }
    if (data.containsKey('tarifa_real_menores7a12')) {
      context.handle(
          _tarifaRealMenores7a12Meta,
          tarifaRealMenores7a12.isAcceptableOrUnknown(
              data['tarifa_real_menores7a12']!, _tarifaRealMenores7a12Meta));
    }
    if (data.containsKey('tarifa_preventa_menores7a12')) {
      context.handle(
          _tarifaPreventaMenores7a12Meta,
          tarifaPreventaMenores7a12.isAcceptableOrUnknown(
              data['tarifa_preventa_menores7a12']!,
              _tarifaPreventaMenores7a12Meta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TarifaXDiaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarifaXDiaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      folioTarifaXDia: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}folio_tarifa_x_dia']),
      subfolio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subfolio']),
      dia: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dia']),
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      tarifaRealPaxAdic: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}tarifa_real_pax_adic']),
      tarifaPreventaPaxAdic: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}tarifa_preventa_pax_adic']),
      tarifaRealAdulto: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}tarifa_real_adulto']),
      tarifaPreventaAdulto: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}tarifa_preventa_adulto']),
      tarifaRealMenores7a12: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}tarifa_real_menores7a12']),
      tarifaPreventaMenores7a12: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}tarifa_preventa_menores7a12']),
    );
  }

  @override
  $TarifaXDiaTable createAlias(String alias) {
    return $TarifaXDiaTable(attachedDatabase, alias);
  }
}

class TarifaXDiaData extends DataClass implements Insertable<TarifaXDiaData> {
  final int id;
  final String? folioTarifaXDia;
  final String? subfolio;
  final int? dia;
  final DateTime fecha;
  final double? tarifaRealPaxAdic;
  final double? tarifaPreventaPaxAdic;
  final double? tarifaRealAdulto;
  final double? tarifaPreventaAdulto;
  final double? tarifaRealMenores7a12;
  final double? tarifaPreventaMenores7a12;
  const TarifaXDiaData(
      {required this.id,
      this.folioTarifaXDia,
      this.subfolio,
      this.dia,
      required this.fecha,
      this.tarifaRealPaxAdic,
      this.tarifaPreventaPaxAdic,
      this.tarifaRealAdulto,
      this.tarifaPreventaAdulto,
      this.tarifaRealMenores7a12,
      this.tarifaPreventaMenores7a12});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || folioTarifaXDia != null) {
      map['folio_tarifa_x_dia'] = Variable<String>(folioTarifaXDia);
    }
    if (!nullToAbsent || subfolio != null) {
      map['subfolio'] = Variable<String>(subfolio);
    }
    if (!nullToAbsent || dia != null) {
      map['dia'] = Variable<int>(dia);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    if (!nullToAbsent || tarifaRealPaxAdic != null) {
      map['tarifa_real_pax_adic'] = Variable<double>(tarifaRealPaxAdic);
    }
    if (!nullToAbsent || tarifaPreventaPaxAdic != null) {
      map['tarifa_preventa_pax_adic'] = Variable<double>(tarifaPreventaPaxAdic);
    }
    if (!nullToAbsent || tarifaRealAdulto != null) {
      map['tarifa_real_adulto'] = Variable<double>(tarifaRealAdulto);
    }
    if (!nullToAbsent || tarifaPreventaAdulto != null) {
      map['tarifa_preventa_adulto'] = Variable<double>(tarifaPreventaAdulto);
    }
    if (!nullToAbsent || tarifaRealMenores7a12 != null) {
      map['tarifa_real_menores7a12'] = Variable<double>(tarifaRealMenores7a12);
    }
    if (!nullToAbsent || tarifaPreventaMenores7a12 != null) {
      map['tarifa_preventa_menores7a12'] =
          Variable<double>(tarifaPreventaMenores7a12);
    }
    return map;
  }

  TarifaXDiaCompanion toCompanion(bool nullToAbsent) {
    return TarifaXDiaCompanion(
      id: Value(id),
      folioTarifaXDia: folioTarifaXDia == null && nullToAbsent
          ? const Value.absent()
          : Value(folioTarifaXDia),
      subfolio: subfolio == null && nullToAbsent
          ? const Value.absent()
          : Value(subfolio),
      dia: dia == null && nullToAbsent ? const Value.absent() : Value(dia),
      fecha: Value(fecha),
      tarifaRealPaxAdic: tarifaRealPaxAdic == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaRealPaxAdic),
      tarifaPreventaPaxAdic: tarifaPreventaPaxAdic == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaPreventaPaxAdic),
      tarifaRealAdulto: tarifaRealAdulto == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaRealAdulto),
      tarifaPreventaAdulto: tarifaPreventaAdulto == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaPreventaAdulto),
      tarifaRealMenores7a12: tarifaRealMenores7a12 == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaRealMenores7a12),
      tarifaPreventaMenores7a12:
          tarifaPreventaMenores7a12 == null && nullToAbsent
              ? const Value.absent()
              : Value(tarifaPreventaMenores7a12),
    );
  }

  factory TarifaXDiaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaXDiaData(
      id: serializer.fromJson<int>(json['id']),
      folioTarifaXDia: serializer.fromJson<String?>(json['folioTarifaXDia']),
      subfolio: serializer.fromJson<String?>(json['subfolio']),
      dia: serializer.fromJson<int?>(json['dia']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      tarifaRealPaxAdic:
          serializer.fromJson<double?>(json['tarifaRealPaxAdic']),
      tarifaPreventaPaxAdic:
          serializer.fromJson<double?>(json['tarifaPreventaPaxAdic']),
      tarifaRealAdulto: serializer.fromJson<double?>(json['tarifaRealAdulto']),
      tarifaPreventaAdulto:
          serializer.fromJson<double?>(json['tarifaPreventaAdulto']),
      tarifaRealMenores7a12:
          serializer.fromJson<double?>(json['tarifaRealMenores7a12']),
      tarifaPreventaMenores7a12:
          serializer.fromJson<double?>(json['tarifaPreventaMenores7a12']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'folioTarifaXDia': serializer.toJson<String?>(folioTarifaXDia),
      'subfolio': serializer.toJson<String?>(subfolio),
      'dia': serializer.toJson<int?>(dia),
      'fecha': serializer.toJson<DateTime>(fecha),
      'tarifaRealPaxAdic': serializer.toJson<double?>(tarifaRealPaxAdic),
      'tarifaPreventaPaxAdic':
          serializer.toJson<double?>(tarifaPreventaPaxAdic),
      'tarifaRealAdulto': serializer.toJson<double?>(tarifaRealAdulto),
      'tarifaPreventaAdulto': serializer.toJson<double?>(tarifaPreventaAdulto),
      'tarifaRealMenores7a12':
          serializer.toJson<double?>(tarifaRealMenores7a12),
      'tarifaPreventaMenores7a12':
          serializer.toJson<double?>(tarifaPreventaMenores7a12),
    };
  }

  TarifaXDiaData copyWith(
          {int? id,
          Value<String?> folioTarifaXDia = const Value.absent(),
          Value<String?> subfolio = const Value.absent(),
          Value<int?> dia = const Value.absent(),
          DateTime? fecha,
          Value<double?> tarifaRealPaxAdic = const Value.absent(),
          Value<double?> tarifaPreventaPaxAdic = const Value.absent(),
          Value<double?> tarifaRealAdulto = const Value.absent(),
          Value<double?> tarifaPreventaAdulto = const Value.absent(),
          Value<double?> tarifaRealMenores7a12 = const Value.absent(),
          Value<double?> tarifaPreventaMenores7a12 = const Value.absent()}) =>
      TarifaXDiaData(
        id: id ?? this.id,
        folioTarifaXDia: folioTarifaXDia.present
            ? folioTarifaXDia.value
            : this.folioTarifaXDia,
        subfolio: subfolio.present ? subfolio.value : this.subfolio,
        dia: dia.present ? dia.value : this.dia,
        fecha: fecha ?? this.fecha,
        tarifaRealPaxAdic: tarifaRealPaxAdic.present
            ? tarifaRealPaxAdic.value
            : this.tarifaRealPaxAdic,
        tarifaPreventaPaxAdic: tarifaPreventaPaxAdic.present
            ? tarifaPreventaPaxAdic.value
            : this.tarifaPreventaPaxAdic,
        tarifaRealAdulto: tarifaRealAdulto.present
            ? tarifaRealAdulto.value
            : this.tarifaRealAdulto,
        tarifaPreventaAdulto: tarifaPreventaAdulto.present
            ? tarifaPreventaAdulto.value
            : this.tarifaPreventaAdulto,
        tarifaRealMenores7a12: tarifaRealMenores7a12.present
            ? tarifaRealMenores7a12.value
            : this.tarifaRealMenores7a12,
        tarifaPreventaMenores7a12: tarifaPreventaMenores7a12.present
            ? tarifaPreventaMenores7a12.value
            : this.tarifaPreventaMenores7a12,
      );
  @override
  String toString() {
    return (StringBuffer('TarifaXDiaData(')
          ..write('id: $id, ')
          ..write('folioTarifaXDia: $folioTarifaXDia, ')
          ..write('subfolio: $subfolio, ')
          ..write('dia: $dia, ')
          ..write('fecha: $fecha, ')
          ..write('tarifaRealPaxAdic: $tarifaRealPaxAdic, ')
          ..write('tarifaPreventaPaxAdic: $tarifaPreventaPaxAdic, ')
          ..write('tarifaRealAdulto: $tarifaRealAdulto, ')
          ..write('tarifaPreventaAdulto: $tarifaPreventaAdulto, ')
          ..write('tarifaRealMenores7a12: $tarifaRealMenores7a12, ')
          ..write('tarifaPreventaMenores7a12: $tarifaPreventaMenores7a12')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      folioTarifaXDia,
      subfolio,
      dia,
      fecha,
      tarifaRealPaxAdic,
      tarifaPreventaPaxAdic,
      tarifaRealAdulto,
      tarifaPreventaAdulto,
      tarifaRealMenores7a12,
      tarifaPreventaMenores7a12);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaXDiaData &&
          other.id == this.id &&
          other.folioTarifaXDia == this.folioTarifaXDia &&
          other.subfolio == this.subfolio &&
          other.dia == this.dia &&
          other.fecha == this.fecha &&
          other.tarifaRealPaxAdic == this.tarifaRealPaxAdic &&
          other.tarifaPreventaPaxAdic == this.tarifaPreventaPaxAdic &&
          other.tarifaRealAdulto == this.tarifaRealAdulto &&
          other.tarifaPreventaAdulto == this.tarifaPreventaAdulto &&
          other.tarifaRealMenores7a12 == this.tarifaRealMenores7a12 &&
          other.tarifaPreventaMenores7a12 == this.tarifaPreventaMenores7a12);
}

class TarifaXDiaCompanion extends UpdateCompanion<TarifaXDiaData> {
  final Value<int> id;
  final Value<String?> folioTarifaXDia;
  final Value<String?> subfolio;
  final Value<int?> dia;
  final Value<DateTime> fecha;
  final Value<double?> tarifaRealPaxAdic;
  final Value<double?> tarifaPreventaPaxAdic;
  final Value<double?> tarifaRealAdulto;
  final Value<double?> tarifaPreventaAdulto;
  final Value<double?> tarifaRealMenores7a12;
  final Value<double?> tarifaPreventaMenores7a12;
  const TarifaXDiaCompanion({
    this.id = const Value.absent(),
    this.folioTarifaXDia = const Value.absent(),
    this.subfolio = const Value.absent(),
    this.dia = const Value.absent(),
    this.fecha = const Value.absent(),
    this.tarifaRealPaxAdic = const Value.absent(),
    this.tarifaPreventaPaxAdic = const Value.absent(),
    this.tarifaRealAdulto = const Value.absent(),
    this.tarifaPreventaAdulto = const Value.absent(),
    this.tarifaRealMenores7a12 = const Value.absent(),
    this.tarifaPreventaMenores7a12 = const Value.absent(),
  });
  TarifaXDiaCompanion.insert({
    this.id = const Value.absent(),
    this.folioTarifaXDia = const Value.absent(),
    this.subfolio = const Value.absent(),
    this.dia = const Value.absent(),
    required DateTime fecha,
    this.tarifaRealPaxAdic = const Value.absent(),
    this.tarifaPreventaPaxAdic = const Value.absent(),
    this.tarifaRealAdulto = const Value.absent(),
    this.tarifaPreventaAdulto = const Value.absent(),
    this.tarifaRealMenores7a12 = const Value.absent(),
    this.tarifaPreventaMenores7a12 = const Value.absent(),
  }) : fecha = Value(fecha);
  static Insertable<TarifaXDiaData> custom({
    Expression<int>? id,
    Expression<String>? folioTarifaXDia,
    Expression<String>? subfolio,
    Expression<int>? dia,
    Expression<DateTime>? fecha,
    Expression<double>? tarifaRealPaxAdic,
    Expression<double>? tarifaPreventaPaxAdic,
    Expression<double>? tarifaRealAdulto,
    Expression<double>? tarifaPreventaAdulto,
    Expression<double>? tarifaRealMenores7a12,
    Expression<double>? tarifaPreventaMenores7a12,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (folioTarifaXDia != null) 'folio_tarifa_x_dia': folioTarifaXDia,
      if (subfolio != null) 'subfolio': subfolio,
      if (dia != null) 'dia': dia,
      if (fecha != null) 'fecha': fecha,
      if (tarifaRealPaxAdic != null) 'tarifa_real_pax_adic': tarifaRealPaxAdic,
      if (tarifaPreventaPaxAdic != null)
        'tarifa_preventa_pax_adic': tarifaPreventaPaxAdic,
      if (tarifaRealAdulto != null) 'tarifa_real_adulto': tarifaRealAdulto,
      if (tarifaPreventaAdulto != null)
        'tarifa_preventa_adulto': tarifaPreventaAdulto,
      if (tarifaRealMenores7a12 != null)
        'tarifa_real_menores7a12': tarifaRealMenores7a12,
      if (tarifaPreventaMenores7a12 != null)
        'tarifa_preventa_menores7a12': tarifaPreventaMenores7a12,
    });
  }

  TarifaXDiaCompanion copyWith(
      {Value<int>? id,
      Value<String?>? folioTarifaXDia,
      Value<String?>? subfolio,
      Value<int?>? dia,
      Value<DateTime>? fecha,
      Value<double?>? tarifaRealPaxAdic,
      Value<double?>? tarifaPreventaPaxAdic,
      Value<double?>? tarifaRealAdulto,
      Value<double?>? tarifaPreventaAdulto,
      Value<double?>? tarifaRealMenores7a12,
      Value<double?>? tarifaPreventaMenores7a12}) {
    return TarifaXDiaCompanion(
      id: id ?? this.id,
      folioTarifaXDia: folioTarifaXDia ?? this.folioTarifaXDia,
      subfolio: subfolio ?? this.subfolio,
      dia: dia ?? this.dia,
      fecha: fecha ?? this.fecha,
      tarifaRealPaxAdic: tarifaRealPaxAdic ?? this.tarifaRealPaxAdic,
      tarifaPreventaPaxAdic:
          tarifaPreventaPaxAdic ?? this.tarifaPreventaPaxAdic,
      tarifaRealAdulto: tarifaRealAdulto ?? this.tarifaRealAdulto,
      tarifaPreventaAdulto: tarifaPreventaAdulto ?? this.tarifaPreventaAdulto,
      tarifaRealMenores7a12:
          tarifaRealMenores7a12 ?? this.tarifaRealMenores7a12,
      tarifaPreventaMenores7a12:
          tarifaPreventaMenores7a12 ?? this.tarifaPreventaMenores7a12,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (folioTarifaXDia.present) {
      map['folio_tarifa_x_dia'] = Variable<String>(folioTarifaXDia.value);
    }
    if (subfolio.present) {
      map['subfolio'] = Variable<String>(subfolio.value);
    }
    if (dia.present) {
      map['dia'] = Variable<int>(dia.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (tarifaRealPaxAdic.present) {
      map['tarifa_real_pax_adic'] = Variable<double>(tarifaRealPaxAdic.value);
    }
    if (tarifaPreventaPaxAdic.present) {
      map['tarifa_preventa_pax_adic'] =
          Variable<double>(tarifaPreventaPaxAdic.value);
    }
    if (tarifaRealAdulto.present) {
      map['tarifa_real_adulto'] = Variable<double>(tarifaRealAdulto.value);
    }
    if (tarifaPreventaAdulto.present) {
      map['tarifa_preventa_adulto'] =
          Variable<double>(tarifaPreventaAdulto.value);
    }
    if (tarifaRealMenores7a12.present) {
      map['tarifa_real_menores7a12'] =
          Variable<double>(tarifaRealMenores7a12.value);
    }
    if (tarifaPreventaMenores7a12.present) {
      map['tarifa_preventa_menores7a12'] =
          Variable<double>(tarifaPreventaMenores7a12.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaXDiaCompanion(')
          ..write('id: $id, ')
          ..write('folioTarifaXDia: $folioTarifaXDia, ')
          ..write('subfolio: $subfolio, ')
          ..write('dia: $dia, ')
          ..write('fecha: $fecha, ')
          ..write('tarifaRealPaxAdic: $tarifaRealPaxAdic, ')
          ..write('tarifaPreventaPaxAdic: $tarifaPreventaPaxAdic, ')
          ..write('tarifaRealAdulto: $tarifaRealAdulto, ')
          ..write('tarifaPreventaAdulto: $tarifaPreventaAdulto, ')
          ..write('tarifaRealMenores7a12: $tarifaRealMenores7a12, ')
          ..write('tarifaPreventaMenores7a12: $tarifaPreventaMenores7a12')
          ..write(')'))
        .toString();
  }
}

class $TarifaTable extends Tarifa with TableInfo<$TarifaTable, TarifaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarifaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _fechaInicioMeta =
      const VerificationMeta('fechaInicio');
  @override
  late final GeneratedColumn<String> fechaInicio = GeneratedColumn<String>(
      'fecha_inicio', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaFinMeta =
      const VerificationMeta('fechaFin');
  @override
  late final GeneratedColumn<String> fechaFin = GeneratedColumn<String>(
      'fecha_fin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tarifaRackMeta =
      const VerificationMeta('tarifaRack');
  @override
  late final GeneratedColumn<String> tarifaRack = GeneratedColumn<String>(
      'tarifa_rack', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tarifaPreventaMeta =
      const VerificationMeta('tarifaPreventa');
  @override
  late final GeneratedColumn<double> tarifaPreventa = GeneratedColumn<double>(
      'tarifa_preventa', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _porcentajeDescuentoMeta =
      const VerificationMeta('porcentajeDescuento');
  @override
  late final GeneratedColumn<double> porcentajeDescuento =
      GeneratedColumn<double>('porcentaje_descuento', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nivelMeta = const VerificationMeta('nivel');
  @override
  late final GeneratedColumn<int> nivel = GeneratedColumn<int>(
      'nivel', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tarifaRealIdMeta =
      const VerificationMeta('tarifaRealId');
  @override
  late final GeneratedColumn<int> tarifaRealId = GeneratedColumn<int>(
      'tarifa_real_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _responsableIdMeta =
      const VerificationMeta('responsableId');
  @override
  late final GeneratedColumn<int> responsableId = GeneratedColumn<int>(
      'responsable_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fecha,
        fechaInicio,
        fechaFin,
        tarifaRack,
        tarifaPreventa,
        porcentajeDescuento,
        categoria,
        nivel,
        tarifaRealId,
        responsableId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarifa';
  @override
  VerificationContext validateIntegrity(Insertable<TarifaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('fecha_inicio')) {
      context.handle(
          _fechaInicioMeta,
          fechaInicio.isAcceptableOrUnknown(
              data['fecha_inicio']!, _fechaInicioMeta));
    } else if (isInserting) {
      context.missing(_fechaInicioMeta);
    }
    if (data.containsKey('fecha_fin')) {
      context.handle(_fechaFinMeta,
          fechaFin.isAcceptableOrUnknown(data['fecha_fin']!, _fechaFinMeta));
    } else if (isInserting) {
      context.missing(_fechaFinMeta);
    }
    if (data.containsKey('tarifa_rack')) {
      context.handle(
          _tarifaRackMeta,
          tarifaRack.isAcceptableOrUnknown(
              data['tarifa_rack']!, _tarifaRackMeta));
    } else if (isInserting) {
      context.missing(_tarifaRackMeta);
    }
    if (data.containsKey('tarifa_preventa')) {
      context.handle(
          _tarifaPreventaMeta,
          tarifaPreventa.isAcceptableOrUnknown(
              data['tarifa_preventa']!, _tarifaPreventaMeta));
    }
    if (data.containsKey('porcentaje_descuento')) {
      context.handle(
          _porcentajeDescuentoMeta,
          porcentajeDescuento.isAcceptableOrUnknown(
              data['porcentaje_descuento']!, _porcentajeDescuentoMeta));
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    } else if (isInserting) {
      context.missing(_categoriaMeta);
    }
    if (data.containsKey('nivel')) {
      context.handle(
          _nivelMeta, nivel.isAcceptableOrUnknown(data['nivel']!, _nivelMeta));
    } else if (isInserting) {
      context.missing(_nivelMeta);
    }
    if (data.containsKey('tarifa_real_id')) {
      context.handle(
          _tarifaRealIdMeta,
          tarifaRealId.isAcceptableOrUnknown(
              data['tarifa_real_id']!, _tarifaRealIdMeta));
    } else if (isInserting) {
      context.missing(_tarifaRealIdMeta);
    }
    if (data.containsKey('responsable_id')) {
      context.handle(
          _responsableIdMeta,
          responsableId.isAcceptableOrUnknown(
              data['responsable_id']!, _responsableIdMeta));
    } else if (isInserting) {
      context.missing(_responsableIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TarifaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarifaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      fechaInicio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fecha_inicio'])!,
      fechaFin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fecha_fin'])!,
      tarifaRack: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarifa_rack'])!,
      tarifaPreventa: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tarifa_preventa']),
      porcentajeDescuento: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}porcentaje_descuento']),
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria'])!,
      nivel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}nivel'])!,
      tarifaRealId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tarifa_real_id'])!,
      responsableId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}responsable_id'])!,
    );
  }

  @override
  $TarifaTable createAlias(String alias) {
    return $TarifaTable(attachedDatabase, alias);
  }
}

class TarifaData extends DataClass implements Insertable<TarifaData> {
  final int id;
  final DateTime fecha;
  final String fechaInicio;
  final String fechaFin;
  final String tarifaRack;
  final double? tarifaPreventa;
  final double? porcentajeDescuento;
  final String categoria;
  final int nivel;
  final int tarifaRealId;
  final int responsableId;
  const TarifaData(
      {required this.id,
      required this.fecha,
      required this.fechaInicio,
      required this.fechaFin,
      required this.tarifaRack,
      this.tarifaPreventa,
      this.porcentajeDescuento,
      required this.categoria,
      required this.nivel,
      required this.tarifaRealId,
      required this.responsableId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fecha'] = Variable<DateTime>(fecha);
    map['fecha_inicio'] = Variable<String>(fechaInicio);
    map['fecha_fin'] = Variable<String>(fechaFin);
    map['tarifa_rack'] = Variable<String>(tarifaRack);
    if (!nullToAbsent || tarifaPreventa != null) {
      map['tarifa_preventa'] = Variable<double>(tarifaPreventa);
    }
    if (!nullToAbsent || porcentajeDescuento != null) {
      map['porcentaje_descuento'] = Variable<double>(porcentajeDescuento);
    }
    map['categoria'] = Variable<String>(categoria);
    map['nivel'] = Variable<int>(nivel);
    map['tarifa_real_id'] = Variable<int>(tarifaRealId);
    map['responsable_id'] = Variable<int>(responsableId);
    return map;
  }

  TarifaCompanion toCompanion(bool nullToAbsent) {
    return TarifaCompanion(
      id: Value(id),
      fecha: Value(fecha),
      fechaInicio: Value(fechaInicio),
      fechaFin: Value(fechaFin),
      tarifaRack: Value(tarifaRack),
      tarifaPreventa: tarifaPreventa == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaPreventa),
      porcentajeDescuento: porcentajeDescuento == null && nullToAbsent
          ? const Value.absent()
          : Value(porcentajeDescuento),
      categoria: Value(categoria),
      nivel: Value(nivel),
      tarifaRealId: Value(tarifaRealId),
      responsableId: Value(responsableId),
    );
  }

  factory TarifaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaData(
      id: serializer.fromJson<int>(json['id']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      fechaInicio: serializer.fromJson<String>(json['fechaInicio']),
      fechaFin: serializer.fromJson<String>(json['fechaFin']),
      tarifaRack: serializer.fromJson<String>(json['tarifaRack']),
      tarifaPreventa: serializer.fromJson<double?>(json['tarifaPreventa']),
      porcentajeDescuento:
          serializer.fromJson<double?>(json['porcentajeDescuento']),
      categoria: serializer.fromJson<String>(json['categoria']),
      nivel: serializer.fromJson<int>(json['nivel']),
      tarifaRealId: serializer.fromJson<int>(json['tarifaRealId']),
      responsableId: serializer.fromJson<int>(json['responsableId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fecha': serializer.toJson<DateTime>(fecha),
      'fechaInicio': serializer.toJson<String>(fechaInicio),
      'fechaFin': serializer.toJson<String>(fechaFin),
      'tarifaRack': serializer.toJson<String>(tarifaRack),
      'tarifaPreventa': serializer.toJson<double?>(tarifaPreventa),
      'porcentajeDescuento': serializer.toJson<double?>(porcentajeDescuento),
      'categoria': serializer.toJson<String>(categoria),
      'nivel': serializer.toJson<int>(nivel),
      'tarifaRealId': serializer.toJson<int>(tarifaRealId),
      'responsableId': serializer.toJson<int>(responsableId),
    };
  }

  TarifaData copyWith(
          {int? id,
          DateTime? fecha,
          String? fechaInicio,
          String? fechaFin,
          String? tarifaRack,
          Value<double?> tarifaPreventa = const Value.absent(),
          Value<double?> porcentajeDescuento = const Value.absent(),
          String? categoria,
          int? nivel,
          int? tarifaRealId,
          int? responsableId}) =>
      TarifaData(
        id: id ?? this.id,
        fecha: fecha ?? this.fecha,
        fechaInicio: fechaInicio ?? this.fechaInicio,
        fechaFin: fechaFin ?? this.fechaFin,
        tarifaRack: tarifaRack ?? this.tarifaRack,
        tarifaPreventa:
            tarifaPreventa.present ? tarifaPreventa.value : this.tarifaPreventa,
        porcentajeDescuento: porcentajeDescuento.present
            ? porcentajeDescuento.value
            : this.porcentajeDescuento,
        categoria: categoria ?? this.categoria,
        nivel: nivel ?? this.nivel,
        tarifaRealId: tarifaRealId ?? this.tarifaRealId,
        responsableId: responsableId ?? this.responsableId,
      );
  @override
  String toString() {
    return (StringBuffer('TarifaData(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('fechaFin: $fechaFin, ')
          ..write('tarifaRack: $tarifaRack, ')
          ..write('tarifaPreventa: $tarifaPreventa, ')
          ..write('porcentajeDescuento: $porcentajeDescuento, ')
          ..write('categoria: $categoria, ')
          ..write('nivel: $nivel, ')
          ..write('tarifaRealId: $tarifaRealId, ')
          ..write('responsableId: $responsableId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      fecha,
      fechaInicio,
      fechaFin,
      tarifaRack,
      tarifaPreventa,
      porcentajeDescuento,
      categoria,
      nivel,
      tarifaRealId,
      responsableId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaData &&
          other.id == this.id &&
          other.fecha == this.fecha &&
          other.fechaInicio == this.fechaInicio &&
          other.fechaFin == this.fechaFin &&
          other.tarifaRack == this.tarifaRack &&
          other.tarifaPreventa == this.tarifaPreventa &&
          other.porcentajeDescuento == this.porcentajeDescuento &&
          other.categoria == this.categoria &&
          other.nivel == this.nivel &&
          other.tarifaRealId == this.tarifaRealId &&
          other.responsableId == this.responsableId);
}

class TarifaCompanion extends UpdateCompanion<TarifaData> {
  final Value<int> id;
  final Value<DateTime> fecha;
  final Value<String> fechaInicio;
  final Value<String> fechaFin;
  final Value<String> tarifaRack;
  final Value<double?> tarifaPreventa;
  final Value<double?> porcentajeDescuento;
  final Value<String> categoria;
  final Value<int> nivel;
  final Value<int> tarifaRealId;
  final Value<int> responsableId;
  const TarifaCompanion({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.fechaInicio = const Value.absent(),
    this.fechaFin = const Value.absent(),
    this.tarifaRack = const Value.absent(),
    this.tarifaPreventa = const Value.absent(),
    this.porcentajeDescuento = const Value.absent(),
    this.categoria = const Value.absent(),
    this.nivel = const Value.absent(),
    this.tarifaRealId = const Value.absent(),
    this.responsableId = const Value.absent(),
  });
  TarifaCompanion.insert({
    this.id = const Value.absent(),
    required DateTime fecha,
    required String fechaInicio,
    required String fechaFin,
    required String tarifaRack,
    this.tarifaPreventa = const Value.absent(),
    this.porcentajeDescuento = const Value.absent(),
    required String categoria,
    required int nivel,
    required int tarifaRealId,
    required int responsableId,
  })  : fecha = Value(fecha),
        fechaInicio = Value(fechaInicio),
        fechaFin = Value(fechaFin),
        tarifaRack = Value(tarifaRack),
        categoria = Value(categoria),
        nivel = Value(nivel),
        tarifaRealId = Value(tarifaRealId),
        responsableId = Value(responsableId);
  static Insertable<TarifaData> custom({
    Expression<int>? id,
    Expression<DateTime>? fecha,
    Expression<String>? fechaInicio,
    Expression<String>? fechaFin,
    Expression<String>? tarifaRack,
    Expression<double>? tarifaPreventa,
    Expression<double>? porcentajeDescuento,
    Expression<String>? categoria,
    Expression<int>? nivel,
    Expression<int>? tarifaRealId,
    Expression<int>? responsableId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fecha != null) 'fecha': fecha,
      if (fechaInicio != null) 'fecha_inicio': fechaInicio,
      if (fechaFin != null) 'fecha_fin': fechaFin,
      if (tarifaRack != null) 'tarifa_rack': tarifaRack,
      if (tarifaPreventa != null) 'tarifa_preventa': tarifaPreventa,
      if (porcentajeDescuento != null)
        'porcentaje_descuento': porcentajeDescuento,
      if (categoria != null) 'categoria': categoria,
      if (nivel != null) 'nivel': nivel,
      if (tarifaRealId != null) 'tarifa_real_id': tarifaRealId,
      if (responsableId != null) 'responsable_id': responsableId,
    });
  }

  TarifaCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? fecha,
      Value<String>? fechaInicio,
      Value<String>? fechaFin,
      Value<String>? tarifaRack,
      Value<double?>? tarifaPreventa,
      Value<double?>? porcentajeDescuento,
      Value<String>? categoria,
      Value<int>? nivel,
      Value<int>? tarifaRealId,
      Value<int>? responsableId}) {
    return TarifaCompanion(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
      tarifaRack: tarifaRack ?? this.tarifaRack,
      tarifaPreventa: tarifaPreventa ?? this.tarifaPreventa,
      porcentajeDescuento: porcentajeDescuento ?? this.porcentajeDescuento,
      categoria: categoria ?? this.categoria,
      nivel: nivel ?? this.nivel,
      tarifaRealId: tarifaRealId ?? this.tarifaRealId,
      responsableId: responsableId ?? this.responsableId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (fechaInicio.present) {
      map['fecha_inicio'] = Variable<String>(fechaInicio.value);
    }
    if (fechaFin.present) {
      map['fecha_fin'] = Variable<String>(fechaFin.value);
    }
    if (tarifaRack.present) {
      map['tarifa_rack'] = Variable<String>(tarifaRack.value);
    }
    if (tarifaPreventa.present) {
      map['tarifa_preventa'] = Variable<double>(tarifaPreventa.value);
    }
    if (porcentajeDescuento.present) {
      map['porcentaje_descuento'] = Variable<double>(porcentajeDescuento.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (nivel.present) {
      map['nivel'] = Variable<int>(nivel.value);
    }
    if (tarifaRealId.present) {
      map['tarifa_real_id'] = Variable<int>(tarifaRealId.value);
    }
    if (responsableId.present) {
      map['responsable_id'] = Variable<int>(responsableId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaCompanion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('fechaFin: $fechaFin, ')
          ..write('tarifaRack: $tarifaRack, ')
          ..write('tarifaPreventa: $tarifaPreventa, ')
          ..write('porcentajeDescuento: $porcentajeDescuento, ')
          ..write('categoria: $categoria, ')
          ..write('nivel: $nivel, ')
          ..write('tarifaRealId: $tarifaRealId, ')
          ..write('responsableId: $responsableId')
          ..write(')'))
        .toString();
  }
}

class $TarifaRealTable extends TarifaReal
    with TableInfo<$TarifaRealTable, TarifaRealData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarifaRealTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _tipoHuespedMeta =
      const VerificationMeta('tipoHuesped');
  @override
  late final GeneratedColumn<String> tipoHuesped = GeneratedColumn<String>(
      'tipo_huesped', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tarifaMeta = const VerificationMeta('tarifa');
  @override
  late final GeneratedColumn<double> tarifa = GeneratedColumn<double>(
      'tarifa', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, fecha, tipoHuesped, tarifa];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarifa_real';
  @override
  VerificationContext validateIntegrity(Insertable<TarifaRealData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('tipo_huesped')) {
      context.handle(
          _tipoHuespedMeta,
          tipoHuesped.isAcceptableOrUnknown(
              data['tipo_huesped']!, _tipoHuespedMeta));
    }
    if (data.containsKey('tarifa')) {
      context.handle(_tarifaMeta,
          tarifa.isAcceptableOrUnknown(data['tarifa']!, _tarifaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TarifaRealData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarifaRealData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      tipoHuesped: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo_huesped']),
      tarifa: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tarifa']),
    );
  }

  @override
  $TarifaRealTable createAlias(String alias) {
    return $TarifaRealTable(attachedDatabase, alias);
  }
}

class TarifaRealData extends DataClass implements Insertable<TarifaRealData> {
  final int id;
  final DateTime fecha;
  final String? tipoHuesped;
  final double? tarifa;
  const TarifaRealData(
      {required this.id, required this.fecha, this.tipoHuesped, this.tarifa});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fecha'] = Variable<DateTime>(fecha);
    if (!nullToAbsent || tipoHuesped != null) {
      map['tipo_huesped'] = Variable<String>(tipoHuesped);
    }
    if (!nullToAbsent || tarifa != null) {
      map['tarifa'] = Variable<double>(tarifa);
    }
    return map;
  }

  TarifaRealCompanion toCompanion(bool nullToAbsent) {
    return TarifaRealCompanion(
      id: Value(id),
      fecha: Value(fecha),
      tipoHuesped: tipoHuesped == null && nullToAbsent
          ? const Value.absent()
          : Value(tipoHuesped),
      tarifa:
          tarifa == null && nullToAbsent ? const Value.absent() : Value(tarifa),
    );
  }

  factory TarifaRealData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaRealData(
      id: serializer.fromJson<int>(json['id']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      tipoHuesped: serializer.fromJson<String?>(json['tipoHuesped']),
      tarifa: serializer.fromJson<double?>(json['tarifa']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fecha': serializer.toJson<DateTime>(fecha),
      'tipoHuesped': serializer.toJson<String?>(tipoHuesped),
      'tarifa': serializer.toJson<double?>(tarifa),
    };
  }

  TarifaRealData copyWith(
          {int? id,
          DateTime? fecha,
          Value<String?> tipoHuesped = const Value.absent(),
          Value<double?> tarifa = const Value.absent()}) =>
      TarifaRealData(
        id: id ?? this.id,
        fecha: fecha ?? this.fecha,
        tipoHuesped: tipoHuesped.present ? tipoHuesped.value : this.tipoHuesped,
        tarifa: tarifa.present ? tarifa.value : this.tarifa,
      );
  @override
  String toString() {
    return (StringBuffer('TarifaRealData(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('tipoHuesped: $tipoHuesped, ')
          ..write('tarifa: $tarifa')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fecha, tipoHuesped, tarifa);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaRealData &&
          other.id == this.id &&
          other.fecha == this.fecha &&
          other.tipoHuesped == this.tipoHuesped &&
          other.tarifa == this.tarifa);
}

class TarifaRealCompanion extends UpdateCompanion<TarifaRealData> {
  final Value<int> id;
  final Value<DateTime> fecha;
  final Value<String?> tipoHuesped;
  final Value<double?> tarifa;
  const TarifaRealCompanion({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.tipoHuesped = const Value.absent(),
    this.tarifa = const Value.absent(),
  });
  TarifaRealCompanion.insert({
    this.id = const Value.absent(),
    required DateTime fecha,
    this.tipoHuesped = const Value.absent(),
    this.tarifa = const Value.absent(),
  }) : fecha = Value(fecha);
  static Insertable<TarifaRealData> custom({
    Expression<int>? id,
    Expression<DateTime>? fecha,
    Expression<String>? tipoHuesped,
    Expression<double>? tarifa,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fecha != null) 'fecha': fecha,
      if (tipoHuesped != null) 'tipo_huesped': tipoHuesped,
      if (tarifa != null) 'tarifa': tarifa,
    });
  }

  TarifaRealCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? fecha,
      Value<String?>? tipoHuesped,
      Value<double?>? tarifa}) {
    return TarifaRealCompanion(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      tipoHuesped: tipoHuesped ?? this.tipoHuesped,
      tarifa: tarifa ?? this.tarifa,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (tipoHuesped.present) {
      map['tipo_huesped'] = Variable<String>(tipoHuesped.value);
    }
    if (tarifa.present) {
      map['tarifa'] = Variable<double>(tarifa.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaRealCompanion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('tipoHuesped: $tipoHuesped, ')
          ..write('tarifa: $tarifa')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $UsuarioTable usuario = $UsuarioTable(this);
  late final $CotizacionTable cotizacion = $CotizacionTable(this);
  late final $HabitacionTable habitacion = $HabitacionTable(this);
  late final $TarifaXDiaTable tarifaXDia = $TarifaXDiaTable(this);
  late final $TarifaTable tarifa = $TarifaTable(this);
  late final $TarifaRealTable tarifaReal = $TarifaRealTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [usuario, cotizacion, habitacion, tarifaXDia, tarifa, tarifaReal];
}

typedef $$UsuarioTableInsertCompanionBuilder = UsuarioCompanion Function({
  Value<int> id,
  required String username,
  Value<String?> password,
  Value<String?> rol,
  Value<String?> correoElectronico,
  Value<String?> passwordCorreo,
  Value<String?> telefono,
  Value<String?> fechaNacimiento,
  Value<String?> nombre,
  Value<String?> apellido,
  Value<int?> numCotizaciones,
});
typedef $$UsuarioTableUpdateCompanionBuilder = UsuarioCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String?> password,
  Value<String?> rol,
  Value<String?> correoElectronico,
  Value<String?> passwordCorreo,
  Value<String?> telefono,
  Value<String?> fechaNacimiento,
  Value<String?> nombre,
  Value<String?> apellido,
  Value<int?> numCotizaciones,
});

class $$UsuarioTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsuarioTable,
    UsuarioData,
    $$UsuarioTableFilterComposer,
    $$UsuarioTableOrderingComposer,
    $$UsuarioTableProcessedTableManager,
    $$UsuarioTableInsertCompanionBuilder,
    $$UsuarioTableUpdateCompanionBuilder> {
  $$UsuarioTableTableManager(_$AppDatabase db, $UsuarioTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsuarioTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsuarioTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$UsuarioTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String?> password = const Value.absent(),
            Value<String?> rol = const Value.absent(),
            Value<String?> correoElectronico = const Value.absent(),
            Value<String?> passwordCorreo = const Value.absent(),
            Value<String?> telefono = const Value.absent(),
            Value<String?> fechaNacimiento = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> apellido = const Value.absent(),
            Value<int?> numCotizaciones = const Value.absent(),
          }) =>
              UsuarioCompanion(
            id: id,
            username: username,
            password: password,
            rol: rol,
            correoElectronico: correoElectronico,
            passwordCorreo: passwordCorreo,
            telefono: telefono,
            fechaNacimiento: fechaNacimiento,
            nombre: nombre,
            apellido: apellido,
            numCotizaciones: numCotizaciones,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String username,
            Value<String?> password = const Value.absent(),
            Value<String?> rol = const Value.absent(),
            Value<String?> correoElectronico = const Value.absent(),
            Value<String?> passwordCorreo = const Value.absent(),
            Value<String?> telefono = const Value.absent(),
            Value<String?> fechaNacimiento = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> apellido = const Value.absent(),
            Value<int?> numCotizaciones = const Value.absent(),
          }) =>
              UsuarioCompanion.insert(
            id: id,
            username: username,
            password: password,
            rol: rol,
            correoElectronico: correoElectronico,
            passwordCorreo: passwordCorreo,
            telefono: telefono,
            fechaNacimiento: fechaNacimiento,
            nombre: nombre,
            apellido: apellido,
            numCotizaciones: numCotizaciones,
          ),
        ));
}

class $$UsuarioTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $UsuarioTable,
    UsuarioData,
    $$UsuarioTableFilterComposer,
    $$UsuarioTableOrderingComposer,
    $$UsuarioTableProcessedTableManager,
    $$UsuarioTableInsertCompanionBuilder,
    $$UsuarioTableUpdateCompanionBuilder> {
  $$UsuarioTableProcessedTableManager(super.$state);
}

class $$UsuarioTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UsuarioTable> {
  $$UsuarioTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
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

  ColumnFilters<String> get rol => $state.composableBuilder(
      column: $state.table.rol,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get correoElectronico => $state.composableBuilder(
      column: $state.table.correoElectronico,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get passwordCorreo => $state.composableBuilder(
      column: $state.table.passwordCorreo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get telefono => $state.composableBuilder(
      column: $state.table.telefono,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fechaNacimiento => $state.composableBuilder(
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

  ColumnFilters<int> get numCotizaciones => $state.composableBuilder(
      column: $state.table.numCotizaciones,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UsuarioTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UsuarioTable> {
  $$UsuarioTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
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

  ColumnOrderings<String> get rol => $state.composableBuilder(
      column: $state.table.rol,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get correoElectronico => $state.composableBuilder(
      column: $state.table.correoElectronico,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get passwordCorreo => $state.composableBuilder(
      column: $state.table.passwordCorreo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get telefono => $state.composableBuilder(
      column: $state.table.telefono,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fechaNacimiento => $state.composableBuilder(
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

  ColumnOrderings<int> get numCotizaciones => $state.composableBuilder(
      column: $state.table.numCotizaciones,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CotizacionTableInsertCompanionBuilder = CotizacionCompanion Function({
  Value<int> id,
  Value<String?> folioPrincipal,
  Value<String?> nombreHuesped,
  Value<String?> numeroTelefonico,
  Value<String?> correoElectrico,
  Value<String?> tipo,
  required DateTime fecha,
  Value<int?> responsableID,
  Value<double?> total,
  Value<double?> descuento,
  Value<bool?> esGrupo,
  Value<bool?> esConcretado,
  Value<int?> habitaciones,
});
typedef $$CotizacionTableUpdateCompanionBuilder = CotizacionCompanion Function({
  Value<int> id,
  Value<String?> folioPrincipal,
  Value<String?> nombreHuesped,
  Value<String?> numeroTelefonico,
  Value<String?> correoElectrico,
  Value<String?> tipo,
  Value<DateTime> fecha,
  Value<int?> responsableID,
  Value<double?> total,
  Value<double?> descuento,
  Value<bool?> esGrupo,
  Value<bool?> esConcretado,
  Value<int?> habitaciones,
});

class $$CotizacionTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CotizacionTable,
    CotizacionData,
    $$CotizacionTableFilterComposer,
    $$CotizacionTableOrderingComposer,
    $$CotizacionTableProcessedTableManager,
    $$CotizacionTableInsertCompanionBuilder,
    $$CotizacionTableUpdateCompanionBuilder> {
  $$CotizacionTableTableManager(_$AppDatabase db, $CotizacionTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CotizacionTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CotizacionTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$CotizacionTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> folioPrincipal = const Value.absent(),
            Value<String?> nombreHuesped = const Value.absent(),
            Value<String?> numeroTelefonico = const Value.absent(),
            Value<String?> correoElectrico = const Value.absent(),
            Value<String?> tipo = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int?> responsableID = const Value.absent(),
            Value<double?> total = const Value.absent(),
            Value<double?> descuento = const Value.absent(),
            Value<bool?> esGrupo = const Value.absent(),
            Value<bool?> esConcretado = const Value.absent(),
            Value<int?> habitaciones = const Value.absent(),
          }) =>
              CotizacionCompanion(
            id: id,
            folioPrincipal: folioPrincipal,
            nombreHuesped: nombreHuesped,
            numeroTelefonico: numeroTelefonico,
            correoElectrico: correoElectrico,
            tipo: tipo,
            fecha: fecha,
            responsableID: responsableID,
            total: total,
            descuento: descuento,
            esGrupo: esGrupo,
            esConcretado: esConcretado,
            habitaciones: habitaciones,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> folioPrincipal = const Value.absent(),
            Value<String?> nombreHuesped = const Value.absent(),
            Value<String?> numeroTelefonico = const Value.absent(),
            Value<String?> correoElectrico = const Value.absent(),
            Value<String?> tipo = const Value.absent(),
            required DateTime fecha,
            Value<int?> responsableID = const Value.absent(),
            Value<double?> total = const Value.absent(),
            Value<double?> descuento = const Value.absent(),
            Value<bool?> esGrupo = const Value.absent(),
            Value<bool?> esConcretado = const Value.absent(),
            Value<int?> habitaciones = const Value.absent(),
          }) =>
              CotizacionCompanion.insert(
            id: id,
            folioPrincipal: folioPrincipal,
            nombreHuesped: nombreHuesped,
            numeroTelefonico: numeroTelefonico,
            correoElectrico: correoElectrico,
            tipo: tipo,
            fecha: fecha,
            responsableID: responsableID,
            total: total,
            descuento: descuento,
            esGrupo: esGrupo,
            esConcretado: esConcretado,
            habitaciones: habitaciones,
          ),
        ));
}

class $$CotizacionTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $CotizacionTable,
    CotizacionData,
    $$CotizacionTableFilterComposer,
    $$CotizacionTableOrderingComposer,
    $$CotizacionTableProcessedTableManager,
    $$CotizacionTableInsertCompanionBuilder,
    $$CotizacionTableUpdateCompanionBuilder> {
  $$CotizacionTableProcessedTableManager(super.$state);
}

class $$CotizacionTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CotizacionTable> {
  $$CotizacionTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get folioPrincipal => $state.composableBuilder(
      column: $state.table.folioPrincipal,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nombreHuesped => $state.composableBuilder(
      column: $state.table.nombreHuesped,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get numeroTelefonico => $state.composableBuilder(
      column: $state.table.numeroTelefonico,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get correoElectrico => $state.composableBuilder(
      column: $state.table.correoElectrico,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tipo => $state.composableBuilder(
      column: $state.table.tipo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get responsableID => $state.composableBuilder(
      column: $state.table.responsableID,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get descuento => $state.composableBuilder(
      column: $state.table.descuento,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get esGrupo => $state.composableBuilder(
      column: $state.table.esGrupo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get esConcretado => $state.composableBuilder(
      column: $state.table.esConcretado,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get habitaciones => $state.composableBuilder(
      column: $state.table.habitaciones,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CotizacionTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CotizacionTable> {
  $$CotizacionTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get folioPrincipal => $state.composableBuilder(
      column: $state.table.folioPrincipal,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nombreHuesped => $state.composableBuilder(
      column: $state.table.nombreHuesped,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get numeroTelefonico => $state.composableBuilder(
      column: $state.table.numeroTelefonico,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get correoElectrico => $state.composableBuilder(
      column: $state.table.correoElectrico,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tipo => $state.composableBuilder(
      column: $state.table.tipo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get responsableID => $state.composableBuilder(
      column: $state.table.responsableID,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get descuento => $state.composableBuilder(
      column: $state.table.descuento,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get esGrupo => $state.composableBuilder(
      column: $state.table.esGrupo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get esConcretado => $state.composableBuilder(
      column: $state.table.esConcretado,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get habitaciones => $state.composableBuilder(
      column: $state.table.habitaciones,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$HabitacionTableInsertCompanionBuilder = HabitacionCompanion Function({
  Value<int> id,
  required String folioHabitacion,
  required String subfolio,
  required String categoria,
  required String plan,
  required bool esPreventa,
  required String fechaCheckIn,
  required String fechaCheckOut,
  required DateTime fecha,
  Value<int?> adultos,
  Value<int?> menores0a6,
  Value<int?> menores7a12,
  Value<int?> paxAdic,
});
typedef $$HabitacionTableUpdateCompanionBuilder = HabitacionCompanion Function({
  Value<int> id,
  Value<String> folioHabitacion,
  Value<String> subfolio,
  Value<String> categoria,
  Value<String> plan,
  Value<bool> esPreventa,
  Value<String> fechaCheckIn,
  Value<String> fechaCheckOut,
  Value<DateTime> fecha,
  Value<int?> adultos,
  Value<int?> menores0a6,
  Value<int?> menores7a12,
  Value<int?> paxAdic,
});

class $$HabitacionTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitacionTable,
    HabitacionData,
    $$HabitacionTableFilterComposer,
    $$HabitacionTableOrderingComposer,
    $$HabitacionTableProcessedTableManager,
    $$HabitacionTableInsertCompanionBuilder,
    $$HabitacionTableUpdateCompanionBuilder> {
  $$HabitacionTableTableManager(_$AppDatabase db, $HabitacionTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$HabitacionTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$HabitacionTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$HabitacionTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> folioHabitacion = const Value.absent(),
            Value<String> subfolio = const Value.absent(),
            Value<String> categoria = const Value.absent(),
            Value<String> plan = const Value.absent(),
            Value<bool> esPreventa = const Value.absent(),
            Value<String> fechaCheckIn = const Value.absent(),
            Value<String> fechaCheckOut = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int?> adultos = const Value.absent(),
            Value<int?> menores0a6 = const Value.absent(),
            Value<int?> menores7a12 = const Value.absent(),
            Value<int?> paxAdic = const Value.absent(),
          }) =>
              HabitacionCompanion(
            id: id,
            folioHabitacion: folioHabitacion,
            subfolio: subfolio,
            categoria: categoria,
            plan: plan,
            esPreventa: esPreventa,
            fechaCheckIn: fechaCheckIn,
            fechaCheckOut: fechaCheckOut,
            fecha: fecha,
            adultos: adultos,
            menores0a6: menores0a6,
            menores7a12: menores7a12,
            paxAdic: paxAdic,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String folioHabitacion,
            required String subfolio,
            required String categoria,
            required String plan,
            required bool esPreventa,
            required String fechaCheckIn,
            required String fechaCheckOut,
            required DateTime fecha,
            Value<int?> adultos = const Value.absent(),
            Value<int?> menores0a6 = const Value.absent(),
            Value<int?> menores7a12 = const Value.absent(),
            Value<int?> paxAdic = const Value.absent(),
          }) =>
              HabitacionCompanion.insert(
            id: id,
            folioHabitacion: folioHabitacion,
            subfolio: subfolio,
            categoria: categoria,
            plan: plan,
            esPreventa: esPreventa,
            fechaCheckIn: fechaCheckIn,
            fechaCheckOut: fechaCheckOut,
            fecha: fecha,
            adultos: adultos,
            menores0a6: menores0a6,
            menores7a12: menores7a12,
            paxAdic: paxAdic,
          ),
        ));
}

class $$HabitacionTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $HabitacionTable,
    HabitacionData,
    $$HabitacionTableFilterComposer,
    $$HabitacionTableOrderingComposer,
    $$HabitacionTableProcessedTableManager,
    $$HabitacionTableInsertCompanionBuilder,
    $$HabitacionTableUpdateCompanionBuilder> {
  $$HabitacionTableProcessedTableManager(super.$state);
}

class $$HabitacionTableFilterComposer
    extends FilterComposer<_$AppDatabase, $HabitacionTable> {
  $$HabitacionTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get folioHabitacion => $state.composableBuilder(
      column: $state.table.folioHabitacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get subfolio => $state.composableBuilder(
      column: $state.table.subfolio,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get categoria => $state.composableBuilder(
      column: $state.table.categoria,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get plan => $state.composableBuilder(
      column: $state.table.plan,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get esPreventa => $state.composableBuilder(
      column: $state.table.esPreventa,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fechaCheckIn => $state.composableBuilder(
      column: $state.table.fechaCheckIn,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fechaCheckOut => $state.composableBuilder(
      column: $state.table.fechaCheckOut,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
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
}

class $$HabitacionTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $HabitacionTable> {
  $$HabitacionTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get folioHabitacion => $state.composableBuilder(
      column: $state.table.folioHabitacion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get subfolio => $state.composableBuilder(
      column: $state.table.subfolio,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get categoria => $state.composableBuilder(
      column: $state.table.categoria,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get plan => $state.composableBuilder(
      column: $state.table.plan,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get esPreventa => $state.composableBuilder(
      column: $state.table.esPreventa,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fechaCheckIn => $state.composableBuilder(
      column: $state.table.fechaCheckIn,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fechaCheckOut => $state.composableBuilder(
      column: $state.table.fechaCheckOut,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
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
}

typedef $$TarifaXDiaTableInsertCompanionBuilder = TarifaXDiaCompanion Function({
  Value<int> id,
  Value<String?> folioTarifaXDia,
  Value<String?> subfolio,
  Value<int?> dia,
  required DateTime fecha,
  Value<double?> tarifaRealPaxAdic,
  Value<double?> tarifaPreventaPaxAdic,
  Value<double?> tarifaRealAdulto,
  Value<double?> tarifaPreventaAdulto,
  Value<double?> tarifaRealMenores7a12,
  Value<double?> tarifaPreventaMenores7a12,
});
typedef $$TarifaXDiaTableUpdateCompanionBuilder = TarifaXDiaCompanion Function({
  Value<int> id,
  Value<String?> folioTarifaXDia,
  Value<String?> subfolio,
  Value<int?> dia,
  Value<DateTime> fecha,
  Value<double?> tarifaRealPaxAdic,
  Value<double?> tarifaPreventaPaxAdic,
  Value<double?> tarifaRealAdulto,
  Value<double?> tarifaPreventaAdulto,
  Value<double?> tarifaRealMenores7a12,
  Value<double?> tarifaPreventaMenores7a12,
});

class $$TarifaXDiaTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarifaXDiaTable,
    TarifaXDiaData,
    $$TarifaXDiaTableFilterComposer,
    $$TarifaXDiaTableOrderingComposer,
    $$TarifaXDiaTableProcessedTableManager,
    $$TarifaXDiaTableInsertCompanionBuilder,
    $$TarifaXDiaTableUpdateCompanionBuilder> {
  $$TarifaXDiaTableTableManager(_$AppDatabase db, $TarifaXDiaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TarifaXDiaTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TarifaXDiaTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$TarifaXDiaTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> folioTarifaXDia = const Value.absent(),
            Value<String?> subfolio = const Value.absent(),
            Value<int?> dia = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<double?> tarifaRealPaxAdic = const Value.absent(),
            Value<double?> tarifaPreventaPaxAdic = const Value.absent(),
            Value<double?> tarifaRealAdulto = const Value.absent(),
            Value<double?> tarifaPreventaAdulto = const Value.absent(),
            Value<double?> tarifaRealMenores7a12 = const Value.absent(),
            Value<double?> tarifaPreventaMenores7a12 = const Value.absent(),
          }) =>
              TarifaXDiaCompanion(
            id: id,
            folioTarifaXDia: folioTarifaXDia,
            subfolio: subfolio,
            dia: dia,
            fecha: fecha,
            tarifaRealPaxAdic: tarifaRealPaxAdic,
            tarifaPreventaPaxAdic: tarifaPreventaPaxAdic,
            tarifaRealAdulto: tarifaRealAdulto,
            tarifaPreventaAdulto: tarifaPreventaAdulto,
            tarifaRealMenores7a12: tarifaRealMenores7a12,
            tarifaPreventaMenores7a12: tarifaPreventaMenores7a12,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> folioTarifaXDia = const Value.absent(),
            Value<String?> subfolio = const Value.absent(),
            Value<int?> dia = const Value.absent(),
            required DateTime fecha,
            Value<double?> tarifaRealPaxAdic = const Value.absent(),
            Value<double?> tarifaPreventaPaxAdic = const Value.absent(),
            Value<double?> tarifaRealAdulto = const Value.absent(),
            Value<double?> tarifaPreventaAdulto = const Value.absent(),
            Value<double?> tarifaRealMenores7a12 = const Value.absent(),
            Value<double?> tarifaPreventaMenores7a12 = const Value.absent(),
          }) =>
              TarifaXDiaCompanion.insert(
            id: id,
            folioTarifaXDia: folioTarifaXDia,
            subfolio: subfolio,
            dia: dia,
            fecha: fecha,
            tarifaRealPaxAdic: tarifaRealPaxAdic,
            tarifaPreventaPaxAdic: tarifaPreventaPaxAdic,
            tarifaRealAdulto: tarifaRealAdulto,
            tarifaPreventaAdulto: tarifaPreventaAdulto,
            tarifaRealMenores7a12: tarifaRealMenores7a12,
            tarifaPreventaMenores7a12: tarifaPreventaMenores7a12,
          ),
        ));
}

class $$TarifaXDiaTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $TarifaXDiaTable,
    TarifaXDiaData,
    $$TarifaXDiaTableFilterComposer,
    $$TarifaXDiaTableOrderingComposer,
    $$TarifaXDiaTableProcessedTableManager,
    $$TarifaXDiaTableInsertCompanionBuilder,
    $$TarifaXDiaTableUpdateCompanionBuilder> {
  $$TarifaXDiaTableProcessedTableManager(super.$state);
}

class $$TarifaXDiaTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaXDiaTable> {
  $$TarifaXDiaTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get folioTarifaXDia => $state.composableBuilder(
      column: $state.table.folioTarifaXDia,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get subfolio => $state.composableBuilder(
      column: $state.table.subfolio,
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

  ColumnFilters<double> get tarifaRealPaxAdic => $state.composableBuilder(
      column: $state.table.tarifaRealPaxAdic,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaPreventaPaxAdic => $state.composableBuilder(
      column: $state.table.tarifaPreventaPaxAdic,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaRealAdulto => $state.composableBuilder(
      column: $state.table.tarifaRealAdulto,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaPreventaAdulto => $state.composableBuilder(
      column: $state.table.tarifaPreventaAdulto,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaRealMenores7a12 => $state.composableBuilder(
      column: $state.table.tarifaRealMenores7a12,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaPreventaMenores7a12 =>
      $state.composableBuilder(
          column: $state.table.tarifaPreventaMenores7a12,
          builder: (column, joinBuilders) =>
              ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TarifaXDiaTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaXDiaTable> {
  $$TarifaXDiaTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get folioTarifaXDia => $state.composableBuilder(
      column: $state.table.folioTarifaXDia,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get subfolio => $state.composableBuilder(
      column: $state.table.subfolio,
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

  ColumnOrderings<double> get tarifaRealPaxAdic => $state.composableBuilder(
      column: $state.table.tarifaRealPaxAdic,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaPreventaPaxAdic => $state.composableBuilder(
      column: $state.table.tarifaPreventaPaxAdic,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaRealAdulto => $state.composableBuilder(
      column: $state.table.tarifaRealAdulto,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaPreventaAdulto => $state.composableBuilder(
      column: $state.table.tarifaPreventaAdulto,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaRealMenores7a12 => $state.composableBuilder(
      column: $state.table.tarifaRealMenores7a12,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaPreventaMenores7a12 => $state
      .composableBuilder(
          column: $state.table.tarifaPreventaMenores7a12,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TarifaTableInsertCompanionBuilder = TarifaCompanion Function({
  Value<int> id,
  required DateTime fecha,
  required String fechaInicio,
  required String fechaFin,
  required String tarifaRack,
  Value<double?> tarifaPreventa,
  Value<double?> porcentajeDescuento,
  required String categoria,
  required int nivel,
  required int tarifaRealId,
  required int responsableId,
});
typedef $$TarifaTableUpdateCompanionBuilder = TarifaCompanion Function({
  Value<int> id,
  Value<DateTime> fecha,
  Value<String> fechaInicio,
  Value<String> fechaFin,
  Value<String> tarifaRack,
  Value<double?> tarifaPreventa,
  Value<double?> porcentajeDescuento,
  Value<String> categoria,
  Value<int> nivel,
  Value<int> tarifaRealId,
  Value<int> responsableId,
});

class $$TarifaTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarifaTable,
    TarifaData,
    $$TarifaTableFilterComposer,
    $$TarifaTableOrderingComposer,
    $$TarifaTableProcessedTableManager,
    $$TarifaTableInsertCompanionBuilder,
    $$TarifaTableUpdateCompanionBuilder> {
  $$TarifaTableTableManager(_$AppDatabase db, $TarifaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TarifaTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TarifaTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$TarifaTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<String> fechaInicio = const Value.absent(),
            Value<String> fechaFin = const Value.absent(),
            Value<String> tarifaRack = const Value.absent(),
            Value<double?> tarifaPreventa = const Value.absent(),
            Value<double?> porcentajeDescuento = const Value.absent(),
            Value<String> categoria = const Value.absent(),
            Value<int> nivel = const Value.absent(),
            Value<int> tarifaRealId = const Value.absent(),
            Value<int> responsableId = const Value.absent(),
          }) =>
              TarifaCompanion(
            id: id,
            fecha: fecha,
            fechaInicio: fechaInicio,
            fechaFin: fechaFin,
            tarifaRack: tarifaRack,
            tarifaPreventa: tarifaPreventa,
            porcentajeDescuento: porcentajeDescuento,
            categoria: categoria,
            nivel: nivel,
            tarifaRealId: tarifaRealId,
            responsableId: responsableId,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required DateTime fecha,
            required String fechaInicio,
            required String fechaFin,
            required String tarifaRack,
            Value<double?> tarifaPreventa = const Value.absent(),
            Value<double?> porcentajeDescuento = const Value.absent(),
            required String categoria,
            required int nivel,
            required int tarifaRealId,
            required int responsableId,
          }) =>
              TarifaCompanion.insert(
            id: id,
            fecha: fecha,
            fechaInicio: fechaInicio,
            fechaFin: fechaFin,
            tarifaRack: tarifaRack,
            tarifaPreventa: tarifaPreventa,
            porcentajeDescuento: porcentajeDescuento,
            categoria: categoria,
            nivel: nivel,
            tarifaRealId: tarifaRealId,
            responsableId: responsableId,
          ),
        ));
}

class $$TarifaTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $TarifaTable,
    TarifaData,
    $$TarifaTableFilterComposer,
    $$TarifaTableOrderingComposer,
    $$TarifaTableProcessedTableManager,
    $$TarifaTableInsertCompanionBuilder,
    $$TarifaTableUpdateCompanionBuilder> {
  $$TarifaTableProcessedTableManager(super.$state);
}

class $$TarifaTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaTable> {
  $$TarifaTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fechaInicio => $state.composableBuilder(
      column: $state.table.fechaInicio,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fechaFin => $state.composableBuilder(
      column: $state.table.fechaFin,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tarifaRack => $state.composableBuilder(
      column: $state.table.tarifaRack,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaPreventa => $state.composableBuilder(
      column: $state.table.tarifaPreventa,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get porcentajeDescuento => $state.composableBuilder(
      column: $state.table.porcentajeDescuento,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get categoria => $state.composableBuilder(
      column: $state.table.categoria,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get nivel => $state.composableBuilder(
      column: $state.table.nivel,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get tarifaRealId => $state.composableBuilder(
      column: $state.table.tarifaRealId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get responsableId => $state.composableBuilder(
      column: $state.table.responsableId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TarifaTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaTable> {
  $$TarifaTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fechaInicio => $state.composableBuilder(
      column: $state.table.fechaInicio,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fechaFin => $state.composableBuilder(
      column: $state.table.fechaFin,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tarifaRack => $state.composableBuilder(
      column: $state.table.tarifaRack,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaPreventa => $state.composableBuilder(
      column: $state.table.tarifaPreventa,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get porcentajeDescuento => $state.composableBuilder(
      column: $state.table.porcentajeDescuento,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get categoria => $state.composableBuilder(
      column: $state.table.categoria,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get nivel => $state.composableBuilder(
      column: $state.table.nivel,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get tarifaRealId => $state.composableBuilder(
      column: $state.table.tarifaRealId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get responsableId => $state.composableBuilder(
      column: $state.table.responsableId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TarifaRealTableInsertCompanionBuilder = TarifaRealCompanion Function({
  Value<int> id,
  required DateTime fecha,
  Value<String?> tipoHuesped,
  Value<double?> tarifa,
});
typedef $$TarifaRealTableUpdateCompanionBuilder = TarifaRealCompanion Function({
  Value<int> id,
  Value<DateTime> fecha,
  Value<String?> tipoHuesped,
  Value<double?> tarifa,
});

class $$TarifaRealTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarifaRealTable,
    TarifaRealData,
    $$TarifaRealTableFilterComposer,
    $$TarifaRealTableOrderingComposer,
    $$TarifaRealTableProcessedTableManager,
    $$TarifaRealTableInsertCompanionBuilder,
    $$TarifaRealTableUpdateCompanionBuilder> {
  $$TarifaRealTableTableManager(_$AppDatabase db, $TarifaRealTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TarifaRealTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TarifaRealTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$TarifaRealTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<String?> tipoHuesped = const Value.absent(),
            Value<double?> tarifa = const Value.absent(),
          }) =>
              TarifaRealCompanion(
            id: id,
            fecha: fecha,
            tipoHuesped: tipoHuesped,
            tarifa: tarifa,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required DateTime fecha,
            Value<String?> tipoHuesped = const Value.absent(),
            Value<double?> tarifa = const Value.absent(),
          }) =>
              TarifaRealCompanion.insert(
            id: id,
            fecha: fecha,
            tipoHuesped: tipoHuesped,
            tarifa: tarifa,
          ),
        ));
}

class $$TarifaRealTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $TarifaRealTable,
    TarifaRealData,
    $$TarifaRealTableFilterComposer,
    $$TarifaRealTableOrderingComposer,
    $$TarifaRealTableProcessedTableManager,
    $$TarifaRealTableInsertCompanionBuilder,
    $$TarifaRealTableUpdateCompanionBuilder> {
  $$TarifaRealTableProcessedTableManager(super.$state);
}

class $$TarifaRealTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaRealTable> {
  $$TarifaRealTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tipoHuesped => $state.composableBuilder(
      column: $state.table.tipoHuesped,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifa => $state.composableBuilder(
      column: $state.table.tarifa,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TarifaRealTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaRealTable> {
  $$TarifaRealTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tipoHuesped => $state.composableBuilder(
      column: $state.table.tipoHuesped,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifa => $state.composableBuilder(
      column: $state.table.tarifa,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$UsuarioTableTableManager get usuario =>
      $$UsuarioTableTableManager(_db, _db.usuario);
  $$CotizacionTableTableManager get cotizacion =>
      $$CotizacionTableTableManager(_db, _db.cotizacion);
  $$HabitacionTableTableManager get habitacion =>
      $$HabitacionTableTableManager(_db, _db.habitacion);
  $$TarifaXDiaTableTableManager get tarifaXDia =>
      $$TarifaXDiaTableTableManager(_db, _db.tarifaXDia);
  $$TarifaTableTableManager get tarifa =>
      $$TarifaTableTableManager(_db, _db.tarifa);
  $$TarifaRealTableTableManager get tarifaReal =>
      $$TarifaRealTableTableManager(_db, _db.tarifaReal);
}
