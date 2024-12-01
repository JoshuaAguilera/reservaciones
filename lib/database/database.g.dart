// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ImagesTableTable extends ImagesTable
    with TableInfo<$ImagesTableTable, ImagesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImagesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlImageMeta =
      const VerificationMeta('urlImage');
  @override
  late final GeneratedColumn<String> urlImage = GeneratedColumn<String>(
      'url_image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, code, urlImage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'images_table';
  @override
  VerificationContext validateIntegrity(Insertable<ImagesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('url_image')) {
      context.handle(_urlImageMeta,
          urlImage.isAcceptableOrUnknown(data['url_image']!, _urlImageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImagesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImagesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      urlImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url_image']),
    );
  }

  @override
  $ImagesTableTable createAlias(String alias) {
    return $ImagesTableTable(attachedDatabase, alias);
  }
}

class ImagesTableData extends DataClass implements Insertable<ImagesTableData> {
  final int id;
  final String? code;
  final String? urlImage;
  const ImagesTableData({required this.id, this.code, this.urlImage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || urlImage != null) {
      map['url_image'] = Variable<String>(urlImage);
    }
    return map;
  }

  ImagesTableCompanion toCompanion(bool nullToAbsent) {
    return ImagesTableCompanion(
      id: Value(id),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      urlImage: urlImage == null && nullToAbsent
          ? const Value.absent()
          : Value(urlImage),
    );
  }

  factory ImagesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImagesTableData(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String?>(json['code']),
      urlImage: serializer.fromJson<String?>(json['urlImage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String?>(code),
      'urlImage': serializer.toJson<String?>(urlImage),
    };
  }

  ImagesTableData copyWith(
          {int? id,
          Value<String?> code = const Value.absent(),
          Value<String?> urlImage = const Value.absent()}) =>
      ImagesTableData(
        id: id ?? this.id,
        code: code.present ? code.value : this.code,
        urlImage: urlImage.present ? urlImage.value : this.urlImage,
      );
  ImagesTableData copyWithCompanion(ImagesTableCompanion data) {
    return ImagesTableData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      urlImage: data.urlImage.present ? data.urlImage.value : this.urlImage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImagesTableData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('urlImage: $urlImage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, urlImage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImagesTableData &&
          other.id == this.id &&
          other.code == this.code &&
          other.urlImage == this.urlImage);
}

class ImagesTableCompanion extends UpdateCompanion<ImagesTableData> {
  final Value<int> id;
  final Value<String?> code;
  final Value<String?> urlImage;
  const ImagesTableCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.urlImage = const Value.absent(),
  });
  ImagesTableCompanion.insert({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.urlImage = const Value.absent(),
  });
  static Insertable<ImagesTableData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? urlImage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (urlImage != null) 'url_image': urlImage,
    });
  }

  ImagesTableCompanion copyWith(
      {Value<int>? id, Value<String?>? code, Value<String?>? urlImage}) {
    return ImagesTableCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      urlImage: urlImage ?? this.urlImage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (urlImage.present) {
      map['url_image'] = Variable<String>(urlImage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImagesTableCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('urlImage: $urlImage')
          ..write(')'))
        .toString();
  }
}

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
      'username', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
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
  static const VerificationMeta _imageIdMeta =
      const VerificationMeta('imageId');
  @override
  late final GeneratedColumn<int> imageId = GeneratedColumn<int>(
      'image_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES images_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        username,
        password,
        rol,
        status,
        correoElectronico,
        passwordCorreo,
        telefono,
        fechaNacimiento,
        nombre,
        apellido,
        numCotizaciones,
        imageId
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
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    }
    if (data.containsKey('rol')) {
      context.handle(
          _rolMeta, rol.isAcceptableOrUnknown(data['rol']!, _rolMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
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
    if (data.containsKey('image_id')) {
      context.handle(_imageIdMeta,
          imageId.isAcceptableOrUnknown(data['image_id']!, _imageIdMeta));
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
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password']),
      rol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rol']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
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
      imageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}image_id']),
    );
  }

  @override
  $UsuarioTable createAlias(String alias) {
    return $UsuarioTable(attachedDatabase, alias);
  }
}

class UsuarioData extends DataClass implements Insertable<UsuarioData> {
  final int id;
  final String? username;
  final String? password;
  final String? rol;
  final String? status;
  final String? correoElectronico;
  final String? passwordCorreo;
  final String? telefono;
  final String? fechaNacimiento;
  final String? nombre;
  final String? apellido;
  final int? numCotizaciones;
  final int? imageId;
  const UsuarioData(
      {required this.id,
      this.username,
      this.password,
      this.rol,
      this.status,
      this.correoElectronico,
      this.passwordCorreo,
      this.telefono,
      this.fechaNacimiento,
      this.nombre,
      this.apellido,
      this.numCotizaciones,
      this.imageId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || rol != null) {
      map['rol'] = Variable<String>(rol);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
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
    if (!nullToAbsent || imageId != null) {
      map['image_id'] = Variable<int>(imageId);
    }
    return map;
  }

  UsuarioCompanion toCompanion(bool nullToAbsent) {
    return UsuarioCompanion(
      id: Value(id),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      rol: rol == null && nullToAbsent ? const Value.absent() : Value(rol),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
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
      imageId: imageId == null && nullToAbsent
          ? const Value.absent()
          : Value(imageId),
    );
  }

  factory UsuarioData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsuarioData(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String?>(json['username']),
      password: serializer.fromJson<String?>(json['password']),
      rol: serializer.fromJson<String?>(json['rol']),
      status: serializer.fromJson<String?>(json['status']),
      correoElectronico:
          serializer.fromJson<String?>(json['correoElectronico']),
      passwordCorreo: serializer.fromJson<String?>(json['passwordCorreo']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      fechaNacimiento: serializer.fromJson<String?>(json['fechaNacimiento']),
      nombre: serializer.fromJson<String?>(json['nombre']),
      apellido: serializer.fromJson<String?>(json['apellido']),
      numCotizaciones: serializer.fromJson<int?>(json['numCotizaciones']),
      imageId: serializer.fromJson<int?>(json['imageId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String?>(username),
      'password': serializer.toJson<String?>(password),
      'rol': serializer.toJson<String?>(rol),
      'status': serializer.toJson<String?>(status),
      'correoElectronico': serializer.toJson<String?>(correoElectronico),
      'passwordCorreo': serializer.toJson<String?>(passwordCorreo),
      'telefono': serializer.toJson<String?>(telefono),
      'fechaNacimiento': serializer.toJson<String?>(fechaNacimiento),
      'nombre': serializer.toJson<String?>(nombre),
      'apellido': serializer.toJson<String?>(apellido),
      'numCotizaciones': serializer.toJson<int?>(numCotizaciones),
      'imageId': serializer.toJson<int?>(imageId),
    };
  }

  UsuarioData copyWith(
          {int? id,
          Value<String?> username = const Value.absent(),
          Value<String?> password = const Value.absent(),
          Value<String?> rol = const Value.absent(),
          Value<String?> status = const Value.absent(),
          Value<String?> correoElectronico = const Value.absent(),
          Value<String?> passwordCorreo = const Value.absent(),
          Value<String?> telefono = const Value.absent(),
          Value<String?> fechaNacimiento = const Value.absent(),
          Value<String?> nombre = const Value.absent(),
          Value<String?> apellido = const Value.absent(),
          Value<int?> numCotizaciones = const Value.absent(),
          Value<int?> imageId = const Value.absent()}) =>
      UsuarioData(
        id: id ?? this.id,
        username: username.present ? username.value : this.username,
        password: password.present ? password.value : this.password,
        rol: rol.present ? rol.value : this.rol,
        status: status.present ? status.value : this.status,
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
        imageId: imageId.present ? imageId.value : this.imageId,
      );
  UsuarioData copyWithCompanion(UsuarioCompanion data) {
    return UsuarioData(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      rol: data.rol.present ? data.rol.value : this.rol,
      status: data.status.present ? data.status.value : this.status,
      correoElectronico: data.correoElectronico.present
          ? data.correoElectronico.value
          : this.correoElectronico,
      passwordCorreo: data.passwordCorreo.present
          ? data.passwordCorreo.value
          : this.passwordCorreo,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      fechaNacimiento: data.fechaNacimiento.present
          ? data.fechaNacimiento.value
          : this.fechaNacimiento,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      apellido: data.apellido.present ? data.apellido.value : this.apellido,
      numCotizaciones: data.numCotizaciones.present
          ? data.numCotizaciones.value
          : this.numCotizaciones,
      imageId: data.imageId.present ? data.imageId.value : this.imageId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsuarioData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('rol: $rol, ')
          ..write('status: $status, ')
          ..write('correoElectronico: $correoElectronico, ')
          ..write('passwordCorreo: $passwordCorreo, ')
          ..write('telefono: $telefono, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('nombre: $nombre, ')
          ..write('apellido: $apellido, ')
          ..write('numCotizaciones: $numCotizaciones, ')
          ..write('imageId: $imageId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      username,
      password,
      rol,
      status,
      correoElectronico,
      passwordCorreo,
      telefono,
      fechaNacimiento,
      nombre,
      apellido,
      numCotizaciones,
      imageId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuarioData &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.rol == this.rol &&
          other.status == this.status &&
          other.correoElectronico == this.correoElectronico &&
          other.passwordCorreo == this.passwordCorreo &&
          other.telefono == this.telefono &&
          other.fechaNacimiento == this.fechaNacimiento &&
          other.nombre == this.nombre &&
          other.apellido == this.apellido &&
          other.numCotizaciones == this.numCotizaciones &&
          other.imageId == this.imageId);
}

class UsuarioCompanion extends UpdateCompanion<UsuarioData> {
  final Value<int> id;
  final Value<String?> username;
  final Value<String?> password;
  final Value<String?> rol;
  final Value<String?> status;
  final Value<String?> correoElectronico;
  final Value<String?> passwordCorreo;
  final Value<String?> telefono;
  final Value<String?> fechaNacimiento;
  final Value<String?> nombre;
  final Value<String?> apellido;
  final Value<int?> numCotizaciones;
  final Value<int?> imageId;
  const UsuarioCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.rol = const Value.absent(),
    this.status = const Value.absent(),
    this.correoElectronico = const Value.absent(),
    this.passwordCorreo = const Value.absent(),
    this.telefono = const Value.absent(),
    this.fechaNacimiento = const Value.absent(),
    this.nombre = const Value.absent(),
    this.apellido = const Value.absent(),
    this.numCotizaciones = const Value.absent(),
    this.imageId = const Value.absent(),
  });
  UsuarioCompanion.insert({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.rol = const Value.absent(),
    this.status = const Value.absent(),
    this.correoElectronico = const Value.absent(),
    this.passwordCorreo = const Value.absent(),
    this.telefono = const Value.absent(),
    this.fechaNacimiento = const Value.absent(),
    this.nombre = const Value.absent(),
    this.apellido = const Value.absent(),
    this.numCotizaciones = const Value.absent(),
    this.imageId = const Value.absent(),
  });
  static Insertable<UsuarioData> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? rol,
    Expression<String>? status,
    Expression<String>? correoElectronico,
    Expression<String>? passwordCorreo,
    Expression<String>? telefono,
    Expression<String>? fechaNacimiento,
    Expression<String>? nombre,
    Expression<String>? apellido,
    Expression<int>? numCotizaciones,
    Expression<int>? imageId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (rol != null) 'rol': rol,
      if (status != null) 'status': status,
      if (correoElectronico != null) 'correo_electronico': correoElectronico,
      if (passwordCorreo != null) 'password_correo': passwordCorreo,
      if (telefono != null) 'telefono': telefono,
      if (fechaNacimiento != null) 'fecha_nacimiento': fechaNacimiento,
      if (nombre != null) 'nombre': nombre,
      if (apellido != null) 'apellido': apellido,
      if (numCotizaciones != null) 'num_cotizaciones': numCotizaciones,
      if (imageId != null) 'image_id': imageId,
    });
  }

  UsuarioCompanion copyWith(
      {Value<int>? id,
      Value<String?>? username,
      Value<String?>? password,
      Value<String?>? rol,
      Value<String?>? status,
      Value<String?>? correoElectronico,
      Value<String?>? passwordCorreo,
      Value<String?>? telefono,
      Value<String?>? fechaNacimiento,
      Value<String?>? nombre,
      Value<String?>? apellido,
      Value<int?>? numCotizaciones,
      Value<int?>? imageId}) {
    return UsuarioCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      rol: rol ?? this.rol,
      status: status ?? this.status,
      correoElectronico: correoElectronico ?? this.correoElectronico,
      passwordCorreo: passwordCorreo ?? this.passwordCorreo,
      telefono: telefono ?? this.telefono,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      numCotizaciones: numCotizaciones ?? this.numCotizaciones,
      imageId: imageId ?? this.imageId,
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
    if (status.present) {
      map['status'] = Variable<String>(status.value);
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
    if (imageId.present) {
      map['image_id'] = Variable<int>(imageId.value);
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
          ..write('status: $status, ')
          ..write('correoElectronico: $correoElectronico, ')
          ..write('passwordCorreo: $passwordCorreo, ')
          ..write('telefono: $telefono, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('nombre: $nombre, ')
          ..write('apellido: $apellido, ')
          ..write('numCotizaciones: $numCotizaciones, ')
          ..write('imageId: $imageId')
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
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
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
  late final GeneratedColumn<String> habitaciones = GeneratedColumn<String>(
      'habitaciones', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _usuarioIDMeta =
      const VerificationMeta('usuarioID');
  @override
  late final GeneratedColumn<int> usuarioID = GeneratedColumn<int>(
      'usuario_i_d', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario (id)'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        folioPrincipal,
        nombreHuesped,
        numeroTelefonico,
        correoElectrico,
        fecha,
        esGrupo,
        esConcretado,
        habitaciones,
        usuarioID,
        username
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
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
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
    if (data.containsKey('usuario_i_d')) {
      context.handle(
          _usuarioIDMeta,
          usuarioID.isAcceptableOrUnknown(
              data['usuario_i_d']!, _usuarioIDMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
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
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      esGrupo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}es_grupo']),
      esConcretado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}es_concretado']),
      habitaciones: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habitaciones']),
      usuarioID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usuario_i_d']),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
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
  final DateTime fecha;
  final bool? esGrupo;
  final bool? esConcretado;
  final String? habitaciones;
  final int? usuarioID;
  final String? username;
  const CotizacionData(
      {required this.id,
      this.folioPrincipal,
      this.nombreHuesped,
      this.numeroTelefonico,
      this.correoElectrico,
      required this.fecha,
      this.esGrupo,
      this.esConcretado,
      this.habitaciones,
      this.usuarioID,
      this.username});
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
    map['fecha'] = Variable<DateTime>(fecha);
    if (!nullToAbsent || esGrupo != null) {
      map['es_grupo'] = Variable<bool>(esGrupo);
    }
    if (!nullToAbsent || esConcretado != null) {
      map['es_concretado'] = Variable<bool>(esConcretado);
    }
    if (!nullToAbsent || habitaciones != null) {
      map['habitaciones'] = Variable<String>(habitaciones);
    }
    if (!nullToAbsent || usuarioID != null) {
      map['usuario_i_d'] = Variable<int>(usuarioID);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
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
      fecha: Value(fecha),
      esGrupo: esGrupo == null && nullToAbsent
          ? const Value.absent()
          : Value(esGrupo),
      esConcretado: esConcretado == null && nullToAbsent
          ? const Value.absent()
          : Value(esConcretado),
      habitaciones: habitaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(habitaciones),
      usuarioID: usuarioID == null && nullToAbsent
          ? const Value.absent()
          : Value(usuarioID),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
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
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      esGrupo: serializer.fromJson<bool?>(json['esGrupo']),
      esConcretado: serializer.fromJson<bool?>(json['esConcretado']),
      habitaciones: serializer.fromJson<String?>(json['habitaciones']),
      usuarioID: serializer.fromJson<int?>(json['usuarioID']),
      username: serializer.fromJson<String?>(json['username']),
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
      'fecha': serializer.toJson<DateTime>(fecha),
      'esGrupo': serializer.toJson<bool?>(esGrupo),
      'esConcretado': serializer.toJson<bool?>(esConcretado),
      'habitaciones': serializer.toJson<String?>(habitaciones),
      'usuarioID': serializer.toJson<int?>(usuarioID),
      'username': serializer.toJson<String?>(username),
    };
  }

  CotizacionData copyWith(
          {int? id,
          Value<String?> folioPrincipal = const Value.absent(),
          Value<String?> nombreHuesped = const Value.absent(),
          Value<String?> numeroTelefonico = const Value.absent(),
          Value<String?> correoElectrico = const Value.absent(),
          DateTime? fecha,
          Value<bool?> esGrupo = const Value.absent(),
          Value<bool?> esConcretado = const Value.absent(),
          Value<String?> habitaciones = const Value.absent(),
          Value<int?> usuarioID = const Value.absent(),
          Value<String?> username = const Value.absent()}) =>
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
        fecha: fecha ?? this.fecha,
        esGrupo: esGrupo.present ? esGrupo.value : this.esGrupo,
        esConcretado:
            esConcretado.present ? esConcretado.value : this.esConcretado,
        habitaciones:
            habitaciones.present ? habitaciones.value : this.habitaciones,
        usuarioID: usuarioID.present ? usuarioID.value : this.usuarioID,
        username: username.present ? username.value : this.username,
      );
  CotizacionData copyWithCompanion(CotizacionCompanion data) {
    return CotizacionData(
      id: data.id.present ? data.id.value : this.id,
      folioPrincipal: data.folioPrincipal.present
          ? data.folioPrincipal.value
          : this.folioPrincipal,
      nombreHuesped: data.nombreHuesped.present
          ? data.nombreHuesped.value
          : this.nombreHuesped,
      numeroTelefonico: data.numeroTelefonico.present
          ? data.numeroTelefonico.value
          : this.numeroTelefonico,
      correoElectrico: data.correoElectrico.present
          ? data.correoElectrico.value
          : this.correoElectrico,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      esGrupo: data.esGrupo.present ? data.esGrupo.value : this.esGrupo,
      esConcretado: data.esConcretado.present
          ? data.esConcretado.value
          : this.esConcretado,
      habitaciones: data.habitaciones.present
          ? data.habitaciones.value
          : this.habitaciones,
      usuarioID: data.usuarioID.present ? data.usuarioID.value : this.usuarioID,
      username: data.username.present ? data.username.value : this.username,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CotizacionData(')
          ..write('id: $id, ')
          ..write('folioPrincipal: $folioPrincipal, ')
          ..write('nombreHuesped: $nombreHuesped, ')
          ..write('numeroTelefonico: $numeroTelefonico, ')
          ..write('correoElectrico: $correoElectrico, ')
          ..write('fecha: $fecha, ')
          ..write('esGrupo: $esGrupo, ')
          ..write('esConcretado: $esConcretado, ')
          ..write('habitaciones: $habitaciones, ')
          ..write('usuarioID: $usuarioID, ')
          ..write('username: $username')
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
      fecha,
      esGrupo,
      esConcretado,
      habitaciones,
      usuarioID,
      username);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CotizacionData &&
          other.id == this.id &&
          other.folioPrincipal == this.folioPrincipal &&
          other.nombreHuesped == this.nombreHuesped &&
          other.numeroTelefonico == this.numeroTelefonico &&
          other.correoElectrico == this.correoElectrico &&
          other.fecha == this.fecha &&
          other.esGrupo == this.esGrupo &&
          other.esConcretado == this.esConcretado &&
          other.habitaciones == this.habitaciones &&
          other.usuarioID == this.usuarioID &&
          other.username == this.username);
}

class CotizacionCompanion extends UpdateCompanion<CotizacionData> {
  final Value<int> id;
  final Value<String?> folioPrincipal;
  final Value<String?> nombreHuesped;
  final Value<String?> numeroTelefonico;
  final Value<String?> correoElectrico;
  final Value<DateTime> fecha;
  final Value<bool?> esGrupo;
  final Value<bool?> esConcretado;
  final Value<String?> habitaciones;
  final Value<int?> usuarioID;
  final Value<String?> username;
  const CotizacionCompanion({
    this.id = const Value.absent(),
    this.folioPrincipal = const Value.absent(),
    this.nombreHuesped = const Value.absent(),
    this.numeroTelefonico = const Value.absent(),
    this.correoElectrico = const Value.absent(),
    this.fecha = const Value.absent(),
    this.esGrupo = const Value.absent(),
    this.esConcretado = const Value.absent(),
    this.habitaciones = const Value.absent(),
    this.usuarioID = const Value.absent(),
    this.username = const Value.absent(),
  });
  CotizacionCompanion.insert({
    this.id = const Value.absent(),
    this.folioPrincipal = const Value.absent(),
    this.nombreHuesped = const Value.absent(),
    this.numeroTelefonico = const Value.absent(),
    this.correoElectrico = const Value.absent(),
    required DateTime fecha,
    this.esGrupo = const Value.absent(),
    this.esConcretado = const Value.absent(),
    this.habitaciones = const Value.absent(),
    this.usuarioID = const Value.absent(),
    this.username = const Value.absent(),
  }) : fecha = Value(fecha);
  static Insertable<CotizacionData> custom({
    Expression<int>? id,
    Expression<String>? folioPrincipal,
    Expression<String>? nombreHuesped,
    Expression<String>? numeroTelefonico,
    Expression<String>? correoElectrico,
    Expression<DateTime>? fecha,
    Expression<bool>? esGrupo,
    Expression<bool>? esConcretado,
    Expression<String>? habitaciones,
    Expression<int>? usuarioID,
    Expression<String>? username,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (folioPrincipal != null) 'folio_principal': folioPrincipal,
      if (nombreHuesped != null) 'nombre_huesped': nombreHuesped,
      if (numeroTelefonico != null) 'numero_telefonico': numeroTelefonico,
      if (correoElectrico != null) 'correo_electrico': correoElectrico,
      if (fecha != null) 'fecha': fecha,
      if (esGrupo != null) 'es_grupo': esGrupo,
      if (esConcretado != null) 'es_concretado': esConcretado,
      if (habitaciones != null) 'habitaciones': habitaciones,
      if (usuarioID != null) 'usuario_i_d': usuarioID,
      if (username != null) 'username': username,
    });
  }

  CotizacionCompanion copyWith(
      {Value<int>? id,
      Value<String?>? folioPrincipal,
      Value<String?>? nombreHuesped,
      Value<String?>? numeroTelefonico,
      Value<String?>? correoElectrico,
      Value<DateTime>? fecha,
      Value<bool?>? esGrupo,
      Value<bool?>? esConcretado,
      Value<String?>? habitaciones,
      Value<int?>? usuarioID,
      Value<String?>? username}) {
    return CotizacionCompanion(
      id: id ?? this.id,
      folioPrincipal: folioPrincipal ?? this.folioPrincipal,
      nombreHuesped: nombreHuesped ?? this.nombreHuesped,
      numeroTelefonico: numeroTelefonico ?? this.numeroTelefonico,
      correoElectrico: correoElectrico ?? this.correoElectrico,
      fecha: fecha ?? this.fecha,
      esGrupo: esGrupo ?? this.esGrupo,
      esConcretado: esConcretado ?? this.esConcretado,
      habitaciones: habitaciones ?? this.habitaciones,
      usuarioID: usuarioID ?? this.usuarioID,
      username: username ?? this.username,
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
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (esGrupo.present) {
      map['es_grupo'] = Variable<bool>(esGrupo.value);
    }
    if (esConcretado.present) {
      map['es_concretado'] = Variable<bool>(esConcretado.value);
    }
    if (habitaciones.present) {
      map['habitaciones'] = Variable<String>(habitaciones.value);
    }
    if (usuarioID.present) {
      map['usuario_i_d'] = Variable<int>(usuarioID.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
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
          ..write('fecha: $fecha, ')
          ..write('esGrupo: $esGrupo, ')
          ..write('esConcretado: $esConcretado, ')
          ..write('habitaciones: $habitaciones, ')
          ..write('usuarioID: $usuarioID, ')
          ..write('username: $username')
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
      'folio_habitacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _folioCotizacionMeta =
      const VerificationMeta('folioCotizacion');
  @override
  late final GeneratedColumn<String> folioCotizacion = GeneratedColumn<String>(
      'folio_cotizacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaCheckInMeta =
      const VerificationMeta('fechaCheckIn');
  @override
  late final GeneratedColumn<String> fechaCheckIn = GeneratedColumn<String>(
      'fecha_check_in', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaCheckOutMeta =
      const VerificationMeta('fechaCheckOut');
  @override
  late final GeneratedColumn<String> fechaCheckOut = GeneratedColumn<String>(
      'fecha_check_out', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isFreeMeta = const VerificationMeta('isFree');
  @override
  late final GeneratedColumn<bool> isFree = GeneratedColumn<bool>(
      'is_free', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_free" IN (0, 1))'));
  static const VerificationMeta _tarifaXDiaMeta =
      const VerificationMeta('tarifaXDia');
  @override
  late final GeneratedColumn<String> tarifaXDia = GeneratedColumn<String>(
      'tarifa_x_dia', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        folioHabitacion,
        folioCotizacion,
        fechaCheckIn,
        fechaCheckOut,
        fecha,
        adultos,
        menores0a6,
        menores7a12,
        paxAdic,
        count,
        isFree,
        tarifaXDia
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
    }
    if (data.containsKey('folio_cotizacion')) {
      context.handle(
          _folioCotizacionMeta,
          folioCotizacion.isAcceptableOrUnknown(
              data['folio_cotizacion']!, _folioCotizacionMeta));
    }
    if (data.containsKey('fecha_check_in')) {
      context.handle(
          _fechaCheckInMeta,
          fechaCheckIn.isAcceptableOrUnknown(
              data['fecha_check_in']!, _fechaCheckInMeta));
    }
    if (data.containsKey('fecha_check_out')) {
      context.handle(
          _fechaCheckOutMeta,
          fechaCheckOut.isAcceptableOrUnknown(
              data['fecha_check_out']!, _fechaCheckOutMeta));
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
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    }
    if (data.containsKey('is_free')) {
      context.handle(_isFreeMeta,
          isFree.isAcceptableOrUnknown(data['is_free']!, _isFreeMeta));
    }
    if (data.containsKey('tarifa_x_dia')) {
      context.handle(
          _tarifaXDiaMeta,
          tarifaXDia.isAcceptableOrUnknown(
              data['tarifa_x_dia']!, _tarifaXDiaMeta));
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
          DriftSqlType.string, data['${effectivePrefix}folio_habitacion']),
      folioCotizacion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}folio_cotizacion']),
      fechaCheckIn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fecha_check_in']),
      fechaCheckOut: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fecha_check_out']),
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
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count']),
      isFree: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_free']),
      tarifaXDia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarifa_x_dia']),
    );
  }

  @override
  $HabitacionTable createAlias(String alias) {
    return $HabitacionTable(attachedDatabase, alias);
  }
}

class HabitacionData extends DataClass implements Insertable<HabitacionData> {
  final int id;
  final String? folioHabitacion;
  final String? folioCotizacion;
  final String? fechaCheckIn;
  final String? fechaCheckOut;
  final DateTime fecha;
  final int? adultos;
  final int? menores0a6;
  final int? menores7a12;
  final int? paxAdic;
  final int? count;
  final bool? isFree;
  final String? tarifaXDia;
  const HabitacionData(
      {required this.id,
      this.folioHabitacion,
      this.folioCotizacion,
      this.fechaCheckIn,
      this.fechaCheckOut,
      required this.fecha,
      this.adultos,
      this.menores0a6,
      this.menores7a12,
      this.paxAdic,
      this.count,
      this.isFree,
      this.tarifaXDia});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || folioHabitacion != null) {
      map['folio_habitacion'] = Variable<String>(folioHabitacion);
    }
    if (!nullToAbsent || folioCotizacion != null) {
      map['folio_cotizacion'] = Variable<String>(folioCotizacion);
    }
    if (!nullToAbsent || fechaCheckIn != null) {
      map['fecha_check_in'] = Variable<String>(fechaCheckIn);
    }
    if (!nullToAbsent || fechaCheckOut != null) {
      map['fecha_check_out'] = Variable<String>(fechaCheckOut);
    }
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
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int>(count);
    }
    if (!nullToAbsent || isFree != null) {
      map['is_free'] = Variable<bool>(isFree);
    }
    if (!nullToAbsent || tarifaXDia != null) {
      map['tarifa_x_dia'] = Variable<String>(tarifaXDia);
    }
    return map;
  }

  HabitacionCompanion toCompanion(bool nullToAbsent) {
    return HabitacionCompanion(
      id: Value(id),
      folioHabitacion: folioHabitacion == null && nullToAbsent
          ? const Value.absent()
          : Value(folioHabitacion),
      folioCotizacion: folioCotizacion == null && nullToAbsent
          ? const Value.absent()
          : Value(folioCotizacion),
      fechaCheckIn: fechaCheckIn == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaCheckIn),
      fechaCheckOut: fechaCheckOut == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaCheckOut),
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
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      isFree:
          isFree == null && nullToAbsent ? const Value.absent() : Value(isFree),
      tarifaXDia: tarifaXDia == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaXDia),
    );
  }

  factory HabitacionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitacionData(
      id: serializer.fromJson<int>(json['id']),
      folioHabitacion: serializer.fromJson<String?>(json['folioHabitacion']),
      folioCotizacion: serializer.fromJson<String?>(json['folioCotizacion']),
      fechaCheckIn: serializer.fromJson<String?>(json['fechaCheckIn']),
      fechaCheckOut: serializer.fromJson<String?>(json['fechaCheckOut']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      adultos: serializer.fromJson<int?>(json['adultos']),
      menores0a6: serializer.fromJson<int?>(json['menores0a6']),
      menores7a12: serializer.fromJson<int?>(json['menores7a12']),
      paxAdic: serializer.fromJson<int?>(json['paxAdic']),
      count: serializer.fromJson<int?>(json['count']),
      isFree: serializer.fromJson<bool?>(json['isFree']),
      tarifaXDia: serializer.fromJson<String?>(json['tarifaXDia']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'folioHabitacion': serializer.toJson<String?>(folioHabitacion),
      'folioCotizacion': serializer.toJson<String?>(folioCotizacion),
      'fechaCheckIn': serializer.toJson<String?>(fechaCheckIn),
      'fechaCheckOut': serializer.toJson<String?>(fechaCheckOut),
      'fecha': serializer.toJson<DateTime>(fecha),
      'adultos': serializer.toJson<int?>(adultos),
      'menores0a6': serializer.toJson<int?>(menores0a6),
      'menores7a12': serializer.toJson<int?>(menores7a12),
      'paxAdic': serializer.toJson<int?>(paxAdic),
      'count': serializer.toJson<int?>(count),
      'isFree': serializer.toJson<bool?>(isFree),
      'tarifaXDia': serializer.toJson<String?>(tarifaXDia),
    };
  }

  HabitacionData copyWith(
          {int? id,
          Value<String?> folioHabitacion = const Value.absent(),
          Value<String?> folioCotizacion = const Value.absent(),
          Value<String?> fechaCheckIn = const Value.absent(),
          Value<String?> fechaCheckOut = const Value.absent(),
          DateTime? fecha,
          Value<int?> adultos = const Value.absent(),
          Value<int?> menores0a6 = const Value.absent(),
          Value<int?> menores7a12 = const Value.absent(),
          Value<int?> paxAdic = const Value.absent(),
          Value<int?> count = const Value.absent(),
          Value<bool?> isFree = const Value.absent(),
          Value<String?> tarifaXDia = const Value.absent()}) =>
      HabitacionData(
        id: id ?? this.id,
        folioHabitacion: folioHabitacion.present
            ? folioHabitacion.value
            : this.folioHabitacion,
        folioCotizacion: folioCotizacion.present
            ? folioCotizacion.value
            : this.folioCotizacion,
        fechaCheckIn:
            fechaCheckIn.present ? fechaCheckIn.value : this.fechaCheckIn,
        fechaCheckOut:
            fechaCheckOut.present ? fechaCheckOut.value : this.fechaCheckOut,
        fecha: fecha ?? this.fecha,
        adultos: adultos.present ? adultos.value : this.adultos,
        menores0a6: menores0a6.present ? menores0a6.value : this.menores0a6,
        menores7a12: menores7a12.present ? menores7a12.value : this.menores7a12,
        paxAdic: paxAdic.present ? paxAdic.value : this.paxAdic,
        count: count.present ? count.value : this.count,
        isFree: isFree.present ? isFree.value : this.isFree,
        tarifaXDia: tarifaXDia.present ? tarifaXDia.value : this.tarifaXDia,
      );
  HabitacionData copyWithCompanion(HabitacionCompanion data) {
    return HabitacionData(
      id: data.id.present ? data.id.value : this.id,
      folioHabitacion: data.folioHabitacion.present
          ? data.folioHabitacion.value
          : this.folioHabitacion,
      folioCotizacion: data.folioCotizacion.present
          ? data.folioCotizacion.value
          : this.folioCotizacion,
      fechaCheckIn: data.fechaCheckIn.present
          ? data.fechaCheckIn.value
          : this.fechaCheckIn,
      fechaCheckOut: data.fechaCheckOut.present
          ? data.fechaCheckOut.value
          : this.fechaCheckOut,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      adultos: data.adultos.present ? data.adultos.value : this.adultos,
      menores0a6:
          data.menores0a6.present ? data.menores0a6.value : this.menores0a6,
      menores7a12:
          data.menores7a12.present ? data.menores7a12.value : this.menores7a12,
      paxAdic: data.paxAdic.present ? data.paxAdic.value : this.paxAdic,
      count: data.count.present ? data.count.value : this.count,
      isFree: data.isFree.present ? data.isFree.value : this.isFree,
      tarifaXDia:
          data.tarifaXDia.present ? data.tarifaXDia.value : this.tarifaXDia,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitacionData(')
          ..write('id: $id, ')
          ..write('folioHabitacion: $folioHabitacion, ')
          ..write('folioCotizacion: $folioCotizacion, ')
          ..write('fechaCheckIn: $fechaCheckIn, ')
          ..write('fechaCheckOut: $fechaCheckOut, ')
          ..write('fecha: $fecha, ')
          ..write('adultos: $adultos, ')
          ..write('menores0a6: $menores0a6, ')
          ..write('menores7a12: $menores7a12, ')
          ..write('paxAdic: $paxAdic, ')
          ..write('count: $count, ')
          ..write('isFree: $isFree, ')
          ..write('tarifaXDia: $tarifaXDia')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      folioHabitacion,
      folioCotizacion,
      fechaCheckIn,
      fechaCheckOut,
      fecha,
      adultos,
      menores0a6,
      menores7a12,
      paxAdic,
      count,
      isFree,
      tarifaXDia);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitacionData &&
          other.id == this.id &&
          other.folioHabitacion == this.folioHabitacion &&
          other.folioCotizacion == this.folioCotizacion &&
          other.fechaCheckIn == this.fechaCheckIn &&
          other.fechaCheckOut == this.fechaCheckOut &&
          other.fecha == this.fecha &&
          other.adultos == this.adultos &&
          other.menores0a6 == this.menores0a6 &&
          other.menores7a12 == this.menores7a12 &&
          other.paxAdic == this.paxAdic &&
          other.count == this.count &&
          other.isFree == this.isFree &&
          other.tarifaXDia == this.tarifaXDia);
}

class HabitacionCompanion extends UpdateCompanion<HabitacionData> {
  final Value<int> id;
  final Value<String?> folioHabitacion;
  final Value<String?> folioCotizacion;
  final Value<String?> fechaCheckIn;
  final Value<String?> fechaCheckOut;
  final Value<DateTime> fecha;
  final Value<int?> adultos;
  final Value<int?> menores0a6;
  final Value<int?> menores7a12;
  final Value<int?> paxAdic;
  final Value<int?> count;
  final Value<bool?> isFree;
  final Value<String?> tarifaXDia;
  const HabitacionCompanion({
    this.id = const Value.absent(),
    this.folioHabitacion = const Value.absent(),
    this.folioCotizacion = const Value.absent(),
    this.fechaCheckIn = const Value.absent(),
    this.fechaCheckOut = const Value.absent(),
    this.fecha = const Value.absent(),
    this.adultos = const Value.absent(),
    this.menores0a6 = const Value.absent(),
    this.menores7a12 = const Value.absent(),
    this.paxAdic = const Value.absent(),
    this.count = const Value.absent(),
    this.isFree = const Value.absent(),
    this.tarifaXDia = const Value.absent(),
  });
  HabitacionCompanion.insert({
    this.id = const Value.absent(),
    this.folioHabitacion = const Value.absent(),
    this.folioCotizacion = const Value.absent(),
    this.fechaCheckIn = const Value.absent(),
    this.fechaCheckOut = const Value.absent(),
    required DateTime fecha,
    this.adultos = const Value.absent(),
    this.menores0a6 = const Value.absent(),
    this.menores7a12 = const Value.absent(),
    this.paxAdic = const Value.absent(),
    this.count = const Value.absent(),
    this.isFree = const Value.absent(),
    this.tarifaXDia = const Value.absent(),
  }) : fecha = Value(fecha);
  static Insertable<HabitacionData> custom({
    Expression<int>? id,
    Expression<String>? folioHabitacion,
    Expression<String>? folioCotizacion,
    Expression<String>? fechaCheckIn,
    Expression<String>? fechaCheckOut,
    Expression<DateTime>? fecha,
    Expression<int>? adultos,
    Expression<int>? menores0a6,
    Expression<int>? menores7a12,
    Expression<int>? paxAdic,
    Expression<int>? count,
    Expression<bool>? isFree,
    Expression<String>? tarifaXDia,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (folioHabitacion != null) 'folio_habitacion': folioHabitacion,
      if (folioCotizacion != null) 'folio_cotizacion': folioCotizacion,
      if (fechaCheckIn != null) 'fecha_check_in': fechaCheckIn,
      if (fechaCheckOut != null) 'fecha_check_out': fechaCheckOut,
      if (fecha != null) 'fecha': fecha,
      if (adultos != null) 'adultos': adultos,
      if (menores0a6 != null) 'menores0a6': menores0a6,
      if (menores7a12 != null) 'menores7a12': menores7a12,
      if (paxAdic != null) 'pax_adic': paxAdic,
      if (count != null) 'count': count,
      if (isFree != null) 'is_free': isFree,
      if (tarifaXDia != null) 'tarifa_x_dia': tarifaXDia,
    });
  }

  HabitacionCompanion copyWith(
      {Value<int>? id,
      Value<String?>? folioHabitacion,
      Value<String?>? folioCotizacion,
      Value<String?>? fechaCheckIn,
      Value<String?>? fechaCheckOut,
      Value<DateTime>? fecha,
      Value<int?>? adultos,
      Value<int?>? menores0a6,
      Value<int?>? menores7a12,
      Value<int?>? paxAdic,
      Value<int?>? count,
      Value<bool?>? isFree,
      Value<String?>? tarifaXDia}) {
    return HabitacionCompanion(
      id: id ?? this.id,
      folioHabitacion: folioHabitacion ?? this.folioHabitacion,
      folioCotizacion: folioCotizacion ?? this.folioCotizacion,
      fechaCheckIn: fechaCheckIn ?? this.fechaCheckIn,
      fechaCheckOut: fechaCheckOut ?? this.fechaCheckOut,
      fecha: fecha ?? this.fecha,
      adultos: adultos ?? this.adultos,
      menores0a6: menores0a6 ?? this.menores0a6,
      menores7a12: menores7a12 ?? this.menores7a12,
      paxAdic: paxAdic ?? this.paxAdic,
      count: count ?? this.count,
      isFree: isFree ?? this.isFree,
      tarifaXDia: tarifaXDia ?? this.tarifaXDia,
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
    if (folioCotizacion.present) {
      map['folio_cotizacion'] = Variable<String>(folioCotizacion.value);
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
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (isFree.present) {
      map['is_free'] = Variable<bool>(isFree.value);
    }
    if (tarifaXDia.present) {
      map['tarifa_x_dia'] = Variable<String>(tarifaXDia.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitacionCompanion(')
          ..write('id: $id, ')
          ..write('folioHabitacion: $folioHabitacion, ')
          ..write('folioCotizacion: $folioCotizacion, ')
          ..write('fechaCheckIn: $fechaCheckIn, ')
          ..write('fechaCheckOut: $fechaCheckOut, ')
          ..write('fecha: $fecha, ')
          ..write('adultos: $adultos, ')
          ..write('menores0a6: $menores0a6, ')
          ..write('menores7a12: $menores7a12, ')
          ..write('paxAdic: $paxAdic, ')
          ..write('count: $count, ')
          ..write('isFree: $isFree, ')
          ..write('tarifaXDia: $tarifaXDia')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
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
  static const VerificationMeta _codePeriodoMeta =
      const VerificationMeta('codePeriodo');
  @override
  late final GeneratedColumn<String> codePeriodo = GeneratedColumn<String>(
      'code_periodo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _codeTemporadaMeta =
      const VerificationMeta('codeTemporada');
  @override
  late final GeneratedColumn<String> codeTemporada = GeneratedColumn<String>(
      'code_temporada', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _codeTarifaMeta =
      const VerificationMeta('codeTarifa');
  @override
  late final GeneratedColumn<String> codeTarifa = GeneratedColumn<String>(
      'code_tarifa', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        subfolio,
        dia,
        fecha,
        tarifaRealPaxAdic,
        tarifaPreventaPaxAdic,
        tarifaRealAdulto,
        tarifaPreventaAdulto,
        tarifaRealMenores7a12,
        tarifaPreventaMenores7a12,
        codePeriodo,
        codeTemporada,
        codeTarifa
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('code_periodo')) {
      context.handle(
          _codePeriodoMeta,
          codePeriodo.isAcceptableOrUnknown(
              data['code_periodo']!, _codePeriodoMeta));
    }
    if (data.containsKey('code_temporada')) {
      context.handle(
          _codeTemporadaMeta,
          codeTemporada.isAcceptableOrUnknown(
              data['code_temporada']!, _codeTemporadaMeta));
    }
    if (data.containsKey('code_tarifa')) {
      context.handle(
          _codeTarifaMeta,
          codeTarifa.isAcceptableOrUnknown(
              data['code_tarifa']!, _codeTarifaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TarifaXDiaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarifaXDiaTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
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
      codePeriodo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code_periodo']),
      codeTemporada: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code_temporada']),
      codeTarifa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code_tarifa']),
    );
  }

  @override
  $TarifaXDiaTableTable createAlias(String alias) {
    return $TarifaXDiaTableTable(attachedDatabase, alias);
  }
}

class TarifaXDiaTableData extends DataClass
    implements Insertable<TarifaXDiaTableData> {
  final int id;
  final String? subfolio;
  final int? dia;
  final DateTime fecha;
  final double? tarifaRealPaxAdic;
  final double? tarifaPreventaPaxAdic;
  final double? tarifaRealAdulto;
  final double? tarifaPreventaAdulto;
  final double? tarifaRealMenores7a12;
  final double? tarifaPreventaMenores7a12;
  final String? codePeriodo;
  final String? codeTemporada;
  final String? codeTarifa;
  const TarifaXDiaTableData(
      {required this.id,
      this.subfolio,
      this.dia,
      required this.fecha,
      this.tarifaRealPaxAdic,
      this.tarifaPreventaPaxAdic,
      this.tarifaRealAdulto,
      this.tarifaPreventaAdulto,
      this.tarifaRealMenores7a12,
      this.tarifaPreventaMenores7a12,
      this.codePeriodo,
      this.codeTemporada,
      this.codeTarifa});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
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
    if (!nullToAbsent || codePeriodo != null) {
      map['code_periodo'] = Variable<String>(codePeriodo);
    }
    if (!nullToAbsent || codeTemporada != null) {
      map['code_temporada'] = Variable<String>(codeTemporada);
    }
    if (!nullToAbsent || codeTarifa != null) {
      map['code_tarifa'] = Variable<String>(codeTarifa);
    }
    return map;
  }

  TarifaXDiaTableCompanion toCompanion(bool nullToAbsent) {
    return TarifaXDiaTableCompanion(
      id: Value(id),
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
      codePeriodo: codePeriodo == null && nullToAbsent
          ? const Value.absent()
          : Value(codePeriodo),
      codeTemporada: codeTemporada == null && nullToAbsent
          ? const Value.absent()
          : Value(codeTemporada),
      codeTarifa: codeTarifa == null && nullToAbsent
          ? const Value.absent()
          : Value(codeTarifa),
    );
  }

  factory TarifaXDiaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaXDiaTableData(
      id: serializer.fromJson<int>(json['id']),
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
      codePeriodo: serializer.fromJson<String?>(json['codePeriodo']),
      codeTemporada: serializer.fromJson<String?>(json['codeTemporada']),
      codeTarifa: serializer.fromJson<String?>(json['codeTarifa']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
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
      'codePeriodo': serializer.toJson<String?>(codePeriodo),
      'codeTemporada': serializer.toJson<String?>(codeTemporada),
      'codeTarifa': serializer.toJson<String?>(codeTarifa),
    };
  }

  TarifaXDiaTableData copyWith(
          {int? id,
          Value<String?> subfolio = const Value.absent(),
          Value<int?> dia = const Value.absent(),
          DateTime? fecha,
          Value<double?> tarifaRealPaxAdic = const Value.absent(),
          Value<double?> tarifaPreventaPaxAdic = const Value.absent(),
          Value<double?> tarifaRealAdulto = const Value.absent(),
          Value<double?> tarifaPreventaAdulto = const Value.absent(),
          Value<double?> tarifaRealMenores7a12 = const Value.absent(),
          Value<double?> tarifaPreventaMenores7a12 = const Value.absent(),
          Value<String?> codePeriodo = const Value.absent(),
          Value<String?> codeTemporada = const Value.absent(),
          Value<String?> codeTarifa = const Value.absent()}) =>
      TarifaXDiaTableData(
        id: id ?? this.id,
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
        codePeriodo: codePeriodo.present ? codePeriodo.value : this.codePeriodo,
        codeTemporada:
            codeTemporada.present ? codeTemporada.value : this.codeTemporada,
        codeTarifa: codeTarifa.present ? codeTarifa.value : this.codeTarifa,
      );
  TarifaXDiaTableData copyWithCompanion(TarifaXDiaTableCompanion data) {
    return TarifaXDiaTableData(
      id: data.id.present ? data.id.value : this.id,
      subfolio: data.subfolio.present ? data.subfolio.value : this.subfolio,
      dia: data.dia.present ? data.dia.value : this.dia,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      tarifaRealPaxAdic: data.tarifaRealPaxAdic.present
          ? data.tarifaRealPaxAdic.value
          : this.tarifaRealPaxAdic,
      tarifaPreventaPaxAdic: data.tarifaPreventaPaxAdic.present
          ? data.tarifaPreventaPaxAdic.value
          : this.tarifaPreventaPaxAdic,
      tarifaRealAdulto: data.tarifaRealAdulto.present
          ? data.tarifaRealAdulto.value
          : this.tarifaRealAdulto,
      tarifaPreventaAdulto: data.tarifaPreventaAdulto.present
          ? data.tarifaPreventaAdulto.value
          : this.tarifaPreventaAdulto,
      tarifaRealMenores7a12: data.tarifaRealMenores7a12.present
          ? data.tarifaRealMenores7a12.value
          : this.tarifaRealMenores7a12,
      tarifaPreventaMenores7a12: data.tarifaPreventaMenores7a12.present
          ? data.tarifaPreventaMenores7a12.value
          : this.tarifaPreventaMenores7a12,
      codePeriodo:
          data.codePeriodo.present ? data.codePeriodo.value : this.codePeriodo,
      codeTemporada: data.codeTemporada.present
          ? data.codeTemporada.value
          : this.codeTemporada,
      codeTarifa:
          data.codeTarifa.present ? data.codeTarifa.value : this.codeTarifa,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TarifaXDiaTableData(')
          ..write('id: $id, ')
          ..write('subfolio: $subfolio, ')
          ..write('dia: $dia, ')
          ..write('fecha: $fecha, ')
          ..write('tarifaRealPaxAdic: $tarifaRealPaxAdic, ')
          ..write('tarifaPreventaPaxAdic: $tarifaPreventaPaxAdic, ')
          ..write('tarifaRealAdulto: $tarifaRealAdulto, ')
          ..write('tarifaPreventaAdulto: $tarifaPreventaAdulto, ')
          ..write('tarifaRealMenores7a12: $tarifaRealMenores7a12, ')
          ..write('tarifaPreventaMenores7a12: $tarifaPreventaMenores7a12, ')
          ..write('codePeriodo: $codePeriodo, ')
          ..write('codeTemporada: $codeTemporada, ')
          ..write('codeTarifa: $codeTarifa')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      subfolio,
      dia,
      fecha,
      tarifaRealPaxAdic,
      tarifaPreventaPaxAdic,
      tarifaRealAdulto,
      tarifaPreventaAdulto,
      tarifaRealMenores7a12,
      tarifaPreventaMenores7a12,
      codePeriodo,
      codeTemporada,
      codeTarifa);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaXDiaTableData &&
          other.id == this.id &&
          other.subfolio == this.subfolio &&
          other.dia == this.dia &&
          other.fecha == this.fecha &&
          other.tarifaRealPaxAdic == this.tarifaRealPaxAdic &&
          other.tarifaPreventaPaxAdic == this.tarifaPreventaPaxAdic &&
          other.tarifaRealAdulto == this.tarifaRealAdulto &&
          other.tarifaPreventaAdulto == this.tarifaPreventaAdulto &&
          other.tarifaRealMenores7a12 == this.tarifaRealMenores7a12 &&
          other.tarifaPreventaMenores7a12 == this.tarifaPreventaMenores7a12 &&
          other.codePeriodo == this.codePeriodo &&
          other.codeTemporada == this.codeTemporada &&
          other.codeTarifa == this.codeTarifa);
}

class TarifaXDiaTableCompanion extends UpdateCompanion<TarifaXDiaTableData> {
  final Value<int> id;
  final Value<String?> subfolio;
  final Value<int?> dia;
  final Value<DateTime> fecha;
  final Value<double?> tarifaRealPaxAdic;
  final Value<double?> tarifaPreventaPaxAdic;
  final Value<double?> tarifaRealAdulto;
  final Value<double?> tarifaPreventaAdulto;
  final Value<double?> tarifaRealMenores7a12;
  final Value<double?> tarifaPreventaMenores7a12;
  final Value<String?> codePeriodo;
  final Value<String?> codeTemporada;
  final Value<String?> codeTarifa;
  const TarifaXDiaTableCompanion({
    this.id = const Value.absent(),
    this.subfolio = const Value.absent(),
    this.dia = const Value.absent(),
    this.fecha = const Value.absent(),
    this.tarifaRealPaxAdic = const Value.absent(),
    this.tarifaPreventaPaxAdic = const Value.absent(),
    this.tarifaRealAdulto = const Value.absent(),
    this.tarifaPreventaAdulto = const Value.absent(),
    this.tarifaRealMenores7a12 = const Value.absent(),
    this.tarifaPreventaMenores7a12 = const Value.absent(),
    this.codePeriodo = const Value.absent(),
    this.codeTemporada = const Value.absent(),
    this.codeTarifa = const Value.absent(),
  });
  TarifaXDiaTableCompanion.insert({
    this.id = const Value.absent(),
    this.subfolio = const Value.absent(),
    this.dia = const Value.absent(),
    required DateTime fecha,
    this.tarifaRealPaxAdic = const Value.absent(),
    this.tarifaPreventaPaxAdic = const Value.absent(),
    this.tarifaRealAdulto = const Value.absent(),
    this.tarifaPreventaAdulto = const Value.absent(),
    this.tarifaRealMenores7a12 = const Value.absent(),
    this.tarifaPreventaMenores7a12 = const Value.absent(),
    this.codePeriodo = const Value.absent(),
    this.codeTemporada = const Value.absent(),
    this.codeTarifa = const Value.absent(),
  }) : fecha = Value(fecha);
  static Insertable<TarifaXDiaTableData> custom({
    Expression<int>? id,
    Expression<String>? subfolio,
    Expression<int>? dia,
    Expression<DateTime>? fecha,
    Expression<double>? tarifaRealPaxAdic,
    Expression<double>? tarifaPreventaPaxAdic,
    Expression<double>? tarifaRealAdulto,
    Expression<double>? tarifaPreventaAdulto,
    Expression<double>? tarifaRealMenores7a12,
    Expression<double>? tarifaPreventaMenores7a12,
    Expression<String>? codePeriodo,
    Expression<String>? codeTemporada,
    Expression<String>? codeTarifa,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
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
      if (codePeriodo != null) 'code_periodo': codePeriodo,
      if (codeTemporada != null) 'code_temporada': codeTemporada,
      if (codeTarifa != null) 'code_tarifa': codeTarifa,
    });
  }

  TarifaXDiaTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? subfolio,
      Value<int?>? dia,
      Value<DateTime>? fecha,
      Value<double?>? tarifaRealPaxAdic,
      Value<double?>? tarifaPreventaPaxAdic,
      Value<double?>? tarifaRealAdulto,
      Value<double?>? tarifaPreventaAdulto,
      Value<double?>? tarifaRealMenores7a12,
      Value<double?>? tarifaPreventaMenores7a12,
      Value<String?>? codePeriodo,
      Value<String?>? codeTemporada,
      Value<String?>? codeTarifa}) {
    return TarifaXDiaTableCompanion(
      id: id ?? this.id,
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
      codePeriodo: codePeriodo ?? this.codePeriodo,
      codeTemporada: codeTemporada ?? this.codeTemporada,
      codeTarifa: codeTarifa ?? this.codeTarifa,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    if (codePeriodo.present) {
      map['code_periodo'] = Variable<String>(codePeriodo.value);
    }
    if (codeTemporada.present) {
      map['code_temporada'] = Variable<String>(codeTemporada.value);
    }
    if (codeTarifa.present) {
      map['code_tarifa'] = Variable<String>(codeTarifa.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaXDiaTableCompanion(')
          ..write('id: $id, ')
          ..write('subfolio: $subfolio, ')
          ..write('dia: $dia, ')
          ..write('fecha: $fecha, ')
          ..write('tarifaRealPaxAdic: $tarifaRealPaxAdic, ')
          ..write('tarifaPreventaPaxAdic: $tarifaPreventaPaxAdic, ')
          ..write('tarifaRealAdulto: $tarifaRealAdulto, ')
          ..write('tarifaPreventaAdulto: $tarifaPreventaAdulto, ')
          ..write('tarifaRealMenores7a12: $tarifaRealMenores7a12, ')
          ..write('tarifaPreventaMenores7a12: $tarifaPreventaMenores7a12, ')
          ..write('codePeriodo: $codePeriodo, ')
          ..write('codeTemporada: $codeTemporada, ')
          ..write('codeTarifa: $codeTarifa')
          ..write(')'))
        .toString();
  }
}

class $PeriodoTable extends Periodo with TableInfo<$PeriodoTable, PeriodoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeriodoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
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
  static const VerificationMeta _enLunesMeta =
      const VerificationMeta('enLunes');
  @override
  late final GeneratedColumn<bool> enLunes = GeneratedColumn<bool>(
      'en_lunes', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("en_lunes" IN (0, 1))'));
  static const VerificationMeta _enMartesMeta =
      const VerificationMeta('enMartes');
  @override
  late final GeneratedColumn<bool> enMartes = GeneratedColumn<bool>(
      'en_martes', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("en_martes" IN (0, 1))'));
  static const VerificationMeta _enMiercolesMeta =
      const VerificationMeta('enMiercoles');
  @override
  late final GeneratedColumn<bool> enMiercoles = GeneratedColumn<bool>(
      'en_miercoles', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("en_miercoles" IN (0, 1))'));
  static const VerificationMeta _enJuevesMeta =
      const VerificationMeta('enJueves');
  @override
  late final GeneratedColumn<bool> enJueves = GeneratedColumn<bool>(
      'en_jueves', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("en_jueves" IN (0, 1))'));
  static const VerificationMeta _enViernesMeta =
      const VerificationMeta('enViernes');
  @override
  late final GeneratedColumn<bool> enViernes = GeneratedColumn<bool>(
      'en_viernes', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("en_viernes" IN (0, 1))'));
  static const VerificationMeta _enSabadoMeta =
      const VerificationMeta('enSabado');
  @override
  late final GeneratedColumn<bool> enSabado = GeneratedColumn<bool>(
      'en_sabado', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("en_sabado" IN (0, 1))'));
  static const VerificationMeta _enDomingoMeta =
      const VerificationMeta('enDomingo');
  @override
  late final GeneratedColumn<bool> enDomingo = GeneratedColumn<bool>(
      'en_domingo', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("en_domingo" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        code,
        fecha,
        fechaInicial,
        fechaFinal,
        enLunes,
        enMartes,
        enMiercoles,
        enJueves,
        enViernes,
        enSabado,
        enDomingo
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'periodo';
  @override
  VerificationContext validateIntegrity(Insertable<PeriodoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
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
    if (data.containsKey('en_lunes')) {
      context.handle(_enLunesMeta,
          enLunes.isAcceptableOrUnknown(data['en_lunes']!, _enLunesMeta));
    }
    if (data.containsKey('en_martes')) {
      context.handle(_enMartesMeta,
          enMartes.isAcceptableOrUnknown(data['en_martes']!, _enMartesMeta));
    }
    if (data.containsKey('en_miercoles')) {
      context.handle(
          _enMiercolesMeta,
          enMiercoles.isAcceptableOrUnknown(
              data['en_miercoles']!, _enMiercolesMeta));
    }
    if (data.containsKey('en_jueves')) {
      context.handle(_enJuevesMeta,
          enJueves.isAcceptableOrUnknown(data['en_jueves']!, _enJuevesMeta));
    }
    if (data.containsKey('en_viernes')) {
      context.handle(_enViernesMeta,
          enViernes.isAcceptableOrUnknown(data['en_viernes']!, _enViernesMeta));
    }
    if (data.containsKey('en_sabado')) {
      context.handle(_enSabadoMeta,
          enSabado.isAcceptableOrUnknown(data['en_sabado']!, _enSabadoMeta));
    }
    if (data.containsKey('en_domingo')) {
      context.handle(_enDomingoMeta,
          enDomingo.isAcceptableOrUnknown(data['en_domingo']!, _enDomingoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PeriodoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeriodoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha']),
      fechaInicial: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_inicial']),
      fechaFinal: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_final']),
      enLunes: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}en_lunes']),
      enMartes: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}en_martes']),
      enMiercoles: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}en_miercoles']),
      enJueves: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}en_jueves']),
      enViernes: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}en_viernes']),
      enSabado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}en_sabado']),
      enDomingo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}en_domingo']),
    );
  }

  @override
  $PeriodoTable createAlias(String alias) {
    return $PeriodoTable(attachedDatabase, alias);
  }
}

class PeriodoData extends DataClass implements Insertable<PeriodoData> {
  final int id;
  final String code;
  final DateTime? fecha;
  final DateTime? fechaInicial;
  final DateTime? fechaFinal;
  final bool? enLunes;
  final bool? enMartes;
  final bool? enMiercoles;
  final bool? enJueves;
  final bool? enViernes;
  final bool? enSabado;
  final bool? enDomingo;
  const PeriodoData(
      {required this.id,
      required this.code,
      this.fecha,
      this.fechaInicial,
      this.fechaFinal,
      this.enLunes,
      this.enMartes,
      this.enMiercoles,
      this.enJueves,
      this.enViernes,
      this.enSabado,
      this.enDomingo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || fecha != null) {
      map['fecha'] = Variable<DateTime>(fecha);
    }
    if (!nullToAbsent || fechaInicial != null) {
      map['fecha_inicial'] = Variable<DateTime>(fechaInicial);
    }
    if (!nullToAbsent || fechaFinal != null) {
      map['fecha_final'] = Variable<DateTime>(fechaFinal);
    }
    if (!nullToAbsent || enLunes != null) {
      map['en_lunes'] = Variable<bool>(enLunes);
    }
    if (!nullToAbsent || enMartes != null) {
      map['en_martes'] = Variable<bool>(enMartes);
    }
    if (!nullToAbsent || enMiercoles != null) {
      map['en_miercoles'] = Variable<bool>(enMiercoles);
    }
    if (!nullToAbsent || enJueves != null) {
      map['en_jueves'] = Variable<bool>(enJueves);
    }
    if (!nullToAbsent || enViernes != null) {
      map['en_viernes'] = Variable<bool>(enViernes);
    }
    if (!nullToAbsent || enSabado != null) {
      map['en_sabado'] = Variable<bool>(enSabado);
    }
    if (!nullToAbsent || enDomingo != null) {
      map['en_domingo'] = Variable<bool>(enDomingo);
    }
    return map;
  }

  PeriodoCompanion toCompanion(bool nullToAbsent) {
    return PeriodoCompanion(
      id: Value(id),
      code: Value(code),
      fecha:
          fecha == null && nullToAbsent ? const Value.absent() : Value(fecha),
      fechaInicial: fechaInicial == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaInicial),
      fechaFinal: fechaFinal == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaFinal),
      enLunes: enLunes == null && nullToAbsent
          ? const Value.absent()
          : Value(enLunes),
      enMartes: enMartes == null && nullToAbsent
          ? const Value.absent()
          : Value(enMartes),
      enMiercoles: enMiercoles == null && nullToAbsent
          ? const Value.absent()
          : Value(enMiercoles),
      enJueves: enJueves == null && nullToAbsent
          ? const Value.absent()
          : Value(enJueves),
      enViernes: enViernes == null && nullToAbsent
          ? const Value.absent()
          : Value(enViernes),
      enSabado: enSabado == null && nullToAbsent
          ? const Value.absent()
          : Value(enSabado),
      enDomingo: enDomingo == null && nullToAbsent
          ? const Value.absent()
          : Value(enDomingo),
    );
  }

  factory PeriodoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeriodoData(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      fecha: serializer.fromJson<DateTime?>(json['fecha']),
      fechaInicial: serializer.fromJson<DateTime?>(json['fechaInicial']),
      fechaFinal: serializer.fromJson<DateTime?>(json['fechaFinal']),
      enLunes: serializer.fromJson<bool?>(json['enLunes']),
      enMartes: serializer.fromJson<bool?>(json['enMartes']),
      enMiercoles: serializer.fromJson<bool?>(json['enMiercoles']),
      enJueves: serializer.fromJson<bool?>(json['enJueves']),
      enViernes: serializer.fromJson<bool?>(json['enViernes']),
      enSabado: serializer.fromJson<bool?>(json['enSabado']),
      enDomingo: serializer.fromJson<bool?>(json['enDomingo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'fecha': serializer.toJson<DateTime?>(fecha),
      'fechaInicial': serializer.toJson<DateTime?>(fechaInicial),
      'fechaFinal': serializer.toJson<DateTime?>(fechaFinal),
      'enLunes': serializer.toJson<bool?>(enLunes),
      'enMartes': serializer.toJson<bool?>(enMartes),
      'enMiercoles': serializer.toJson<bool?>(enMiercoles),
      'enJueves': serializer.toJson<bool?>(enJueves),
      'enViernes': serializer.toJson<bool?>(enViernes),
      'enSabado': serializer.toJson<bool?>(enSabado),
      'enDomingo': serializer.toJson<bool?>(enDomingo),
    };
  }

  PeriodoData copyWith(
          {int? id,
          String? code,
          Value<DateTime?> fecha = const Value.absent(),
          Value<DateTime?> fechaInicial = const Value.absent(),
          Value<DateTime?> fechaFinal = const Value.absent(),
          Value<bool?> enLunes = const Value.absent(),
          Value<bool?> enMartes = const Value.absent(),
          Value<bool?> enMiercoles = const Value.absent(),
          Value<bool?> enJueves = const Value.absent(),
          Value<bool?> enViernes = const Value.absent(),
          Value<bool?> enSabado = const Value.absent(),
          Value<bool?> enDomingo = const Value.absent()}) =>
      PeriodoData(
        id: id ?? this.id,
        code: code ?? this.code,
        fecha: fecha.present ? fecha.value : this.fecha,
        fechaInicial:
            fechaInicial.present ? fechaInicial.value : this.fechaInicial,
        fechaFinal: fechaFinal.present ? fechaFinal.value : this.fechaFinal,
        enLunes: enLunes.present ? enLunes.value : this.enLunes,
        enMartes: enMartes.present ? enMartes.value : this.enMartes,
        enMiercoles: enMiercoles.present ? enMiercoles.value : this.enMiercoles,
        enJueves: enJueves.present ? enJueves.value : this.enJueves,
        enViernes: enViernes.present ? enViernes.value : this.enViernes,
        enSabado: enSabado.present ? enSabado.value : this.enSabado,
        enDomingo: enDomingo.present ? enDomingo.value : this.enDomingo,
      );
  PeriodoData copyWithCompanion(PeriodoCompanion data) {
    return PeriodoData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      fechaInicial: data.fechaInicial.present
          ? data.fechaInicial.value
          : this.fechaInicial,
      fechaFinal:
          data.fechaFinal.present ? data.fechaFinal.value : this.fechaFinal,
      enLunes: data.enLunes.present ? data.enLunes.value : this.enLunes,
      enMartes: data.enMartes.present ? data.enMartes.value : this.enMartes,
      enMiercoles:
          data.enMiercoles.present ? data.enMiercoles.value : this.enMiercoles,
      enJueves: data.enJueves.present ? data.enJueves.value : this.enJueves,
      enViernes: data.enViernes.present ? data.enViernes.value : this.enViernes,
      enSabado: data.enSabado.present ? data.enSabado.value : this.enSabado,
      enDomingo: data.enDomingo.present ? data.enDomingo.value : this.enDomingo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeriodoData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('fecha: $fecha, ')
          ..write('fechaInicial: $fechaInicial, ')
          ..write('fechaFinal: $fechaFinal, ')
          ..write('enLunes: $enLunes, ')
          ..write('enMartes: $enMartes, ')
          ..write('enMiercoles: $enMiercoles, ')
          ..write('enJueves: $enJueves, ')
          ..write('enViernes: $enViernes, ')
          ..write('enSabado: $enSabado, ')
          ..write('enDomingo: $enDomingo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, fecha, fechaInicial, fechaFinal,
      enLunes, enMartes, enMiercoles, enJueves, enViernes, enSabado, enDomingo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeriodoData &&
          other.id == this.id &&
          other.code == this.code &&
          other.fecha == this.fecha &&
          other.fechaInicial == this.fechaInicial &&
          other.fechaFinal == this.fechaFinal &&
          other.enLunes == this.enLunes &&
          other.enMartes == this.enMartes &&
          other.enMiercoles == this.enMiercoles &&
          other.enJueves == this.enJueves &&
          other.enViernes == this.enViernes &&
          other.enSabado == this.enSabado &&
          other.enDomingo == this.enDomingo);
}

class PeriodoCompanion extends UpdateCompanion<PeriodoData> {
  final Value<int> id;
  final Value<String> code;
  final Value<DateTime?> fecha;
  final Value<DateTime?> fechaInicial;
  final Value<DateTime?> fechaFinal;
  final Value<bool?> enLunes;
  final Value<bool?> enMartes;
  final Value<bool?> enMiercoles;
  final Value<bool?> enJueves;
  final Value<bool?> enViernes;
  final Value<bool?> enSabado;
  final Value<bool?> enDomingo;
  const PeriodoCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.fecha = const Value.absent(),
    this.fechaInicial = const Value.absent(),
    this.fechaFinal = const Value.absent(),
    this.enLunes = const Value.absent(),
    this.enMartes = const Value.absent(),
    this.enMiercoles = const Value.absent(),
    this.enJueves = const Value.absent(),
    this.enViernes = const Value.absent(),
    this.enSabado = const Value.absent(),
    this.enDomingo = const Value.absent(),
  });
  PeriodoCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    this.fecha = const Value.absent(),
    this.fechaInicial = const Value.absent(),
    this.fechaFinal = const Value.absent(),
    this.enLunes = const Value.absent(),
    this.enMartes = const Value.absent(),
    this.enMiercoles = const Value.absent(),
    this.enJueves = const Value.absent(),
    this.enViernes = const Value.absent(),
    this.enSabado = const Value.absent(),
    this.enDomingo = const Value.absent(),
  }) : code = Value(code);
  static Insertable<PeriodoData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<DateTime>? fecha,
    Expression<DateTime>? fechaInicial,
    Expression<DateTime>? fechaFinal,
    Expression<bool>? enLunes,
    Expression<bool>? enMartes,
    Expression<bool>? enMiercoles,
    Expression<bool>? enJueves,
    Expression<bool>? enViernes,
    Expression<bool>? enSabado,
    Expression<bool>? enDomingo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (fecha != null) 'fecha': fecha,
      if (fechaInicial != null) 'fecha_inicial': fechaInicial,
      if (fechaFinal != null) 'fecha_final': fechaFinal,
      if (enLunes != null) 'en_lunes': enLunes,
      if (enMartes != null) 'en_martes': enMartes,
      if (enMiercoles != null) 'en_miercoles': enMiercoles,
      if (enJueves != null) 'en_jueves': enJueves,
      if (enViernes != null) 'en_viernes': enViernes,
      if (enSabado != null) 'en_sabado': enSabado,
      if (enDomingo != null) 'en_domingo': enDomingo,
    });
  }

  PeriodoCompanion copyWith(
      {Value<int>? id,
      Value<String>? code,
      Value<DateTime?>? fecha,
      Value<DateTime?>? fechaInicial,
      Value<DateTime?>? fechaFinal,
      Value<bool?>? enLunes,
      Value<bool?>? enMartes,
      Value<bool?>? enMiercoles,
      Value<bool?>? enJueves,
      Value<bool?>? enViernes,
      Value<bool?>? enSabado,
      Value<bool?>? enDomingo}) {
    return PeriodoCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      fecha: fecha ?? this.fecha,
      fechaInicial: fechaInicial ?? this.fechaInicial,
      fechaFinal: fechaFinal ?? this.fechaFinal,
      enLunes: enLunes ?? this.enLunes,
      enMartes: enMartes ?? this.enMartes,
      enMiercoles: enMiercoles ?? this.enMiercoles,
      enJueves: enJueves ?? this.enJueves,
      enViernes: enViernes ?? this.enViernes,
      enSabado: enSabado ?? this.enSabado,
      enDomingo: enDomingo ?? this.enDomingo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (fechaInicial.present) {
      map['fecha_inicial'] = Variable<DateTime>(fechaInicial.value);
    }
    if (fechaFinal.present) {
      map['fecha_final'] = Variable<DateTime>(fechaFinal.value);
    }
    if (enLunes.present) {
      map['en_lunes'] = Variable<bool>(enLunes.value);
    }
    if (enMartes.present) {
      map['en_martes'] = Variable<bool>(enMartes.value);
    }
    if (enMiercoles.present) {
      map['en_miercoles'] = Variable<bool>(enMiercoles.value);
    }
    if (enJueves.present) {
      map['en_jueves'] = Variable<bool>(enJueves.value);
    }
    if (enViernes.present) {
      map['en_viernes'] = Variable<bool>(enViernes.value);
    }
    if (enSabado.present) {
      map['en_sabado'] = Variable<bool>(enSabado.value);
    }
    if (enDomingo.present) {
      map['en_domingo'] = Variable<bool>(enDomingo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeriodoCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('fecha: $fecha, ')
          ..write('fechaInicial: $fechaInicial, ')
          ..write('fechaFinal: $fechaFinal, ')
          ..write('enLunes: $enLunes, ')
          ..write('enMartes: $enMartes, ')
          ..write('enMiercoles: $enMiercoles, ')
          ..write('enJueves: $enJueves, ')
          ..write('enViernes: $enViernes, ')
          ..write('enSabado: $enSabado, ')
          ..write('enDomingo: $enDomingo')
          ..write(')'))
        .toString();
  }
}

class $TemporadaTable extends Temporada
    with TableInfo<$TemporadaTable, TemporadaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemporadaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _estanciaMinimaMeta =
      const VerificationMeta('estanciaMinima');
  @override
  late final GeneratedColumn<int> estanciaMinima = GeneratedColumn<int>(
      'estancia_minima', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _porcentajePromocionMeta =
      const VerificationMeta('porcentajePromocion');
  @override
  late final GeneratedColumn<double> porcentajePromocion =
      GeneratedColumn<double>('porcentaje_promocion', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _codeTarifaMeta =
      const VerificationMeta('codeTarifa');
  @override
  late final GeneratedColumn<String> codeTarifa = GeneratedColumn<String>(
      'code_tarifa', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _forGroupMeta =
      const VerificationMeta('forGroup');
  @override
  late final GeneratedColumn<bool> forGroup = GeneratedColumn<bool>(
      'for_group', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("for_group" IN (0, 1))'));
  static const VerificationMeta _tarifaJSONMeta =
      const VerificationMeta('tarifaJSON');
  @override
  late final GeneratedColumn<String> tarifaJSON = GeneratedColumn<String>(
      'tarifa_j_s_o_n', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        code,
        nombre,
        fecha,
        estanciaMinima,
        porcentajePromocion,
        codeTarifa,
        forGroup,
        tarifaJSON
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'temporada';
  @override
  VerificationContext validateIntegrity(Insertable<TemporadaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    }
    if (data.containsKey('estancia_minima')) {
      context.handle(
          _estanciaMinimaMeta,
          estanciaMinima.isAcceptableOrUnknown(
              data['estancia_minima']!, _estanciaMinimaMeta));
    }
    if (data.containsKey('porcentaje_promocion')) {
      context.handle(
          _porcentajePromocionMeta,
          porcentajePromocion.isAcceptableOrUnknown(
              data['porcentaje_promocion']!, _porcentajePromocionMeta));
    }
    if (data.containsKey('code_tarifa')) {
      context.handle(
          _codeTarifaMeta,
          codeTarifa.isAcceptableOrUnknown(
              data['code_tarifa']!, _codeTarifaMeta));
    }
    if (data.containsKey('for_group')) {
      context.handle(_forGroupMeta,
          forGroup.isAcceptableOrUnknown(data['for_group']!, _forGroupMeta));
    }
    if (data.containsKey('tarifa_j_s_o_n')) {
      context.handle(
          _tarifaJSONMeta,
          tarifaJSON.isAcceptableOrUnknown(
              data['tarifa_j_s_o_n']!, _tarifaJSONMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemporadaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemporadaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha']),
      estanciaMinima: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}estancia_minima']),
      porcentajePromocion: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}porcentaje_promocion']),
      codeTarifa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code_tarifa']),
      forGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}for_group']),
      tarifaJSON: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarifa_j_s_o_n']),
    );
  }

  @override
  $TemporadaTable createAlias(String alias) {
    return $TemporadaTable(attachedDatabase, alias);
  }
}

class TemporadaData extends DataClass implements Insertable<TemporadaData> {
  final int id;
  final String code;
  final String nombre;
  final DateTime? fecha;
  final int? estanciaMinima;
  final double? porcentajePromocion;
  final String? codeTarifa;
  final bool? forGroup;
  final String? tarifaJSON;
  const TemporadaData(
      {required this.id,
      required this.code,
      required this.nombre,
      this.fecha,
      this.estanciaMinima,
      this.porcentajePromocion,
      this.codeTarifa,
      this.forGroup,
      this.tarifaJSON});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || fecha != null) {
      map['fecha'] = Variable<DateTime>(fecha);
    }
    if (!nullToAbsent || estanciaMinima != null) {
      map['estancia_minima'] = Variable<int>(estanciaMinima);
    }
    if (!nullToAbsent || porcentajePromocion != null) {
      map['porcentaje_promocion'] = Variable<double>(porcentajePromocion);
    }
    if (!nullToAbsent || codeTarifa != null) {
      map['code_tarifa'] = Variable<String>(codeTarifa);
    }
    if (!nullToAbsent || forGroup != null) {
      map['for_group'] = Variable<bool>(forGroup);
    }
    if (!nullToAbsent || tarifaJSON != null) {
      map['tarifa_j_s_o_n'] = Variable<String>(tarifaJSON);
    }
    return map;
  }

  TemporadaCompanion toCompanion(bool nullToAbsent) {
    return TemporadaCompanion(
      id: Value(id),
      code: Value(code),
      nombre: Value(nombre),
      fecha:
          fecha == null && nullToAbsent ? const Value.absent() : Value(fecha),
      estanciaMinima: estanciaMinima == null && nullToAbsent
          ? const Value.absent()
          : Value(estanciaMinima),
      porcentajePromocion: porcentajePromocion == null && nullToAbsent
          ? const Value.absent()
          : Value(porcentajePromocion),
      codeTarifa: codeTarifa == null && nullToAbsent
          ? const Value.absent()
          : Value(codeTarifa),
      forGroup: forGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(forGroup),
      tarifaJSON: tarifaJSON == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaJSON),
    );
  }

  factory TemporadaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemporadaData(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      nombre: serializer.fromJson<String>(json['nombre']),
      fecha: serializer.fromJson<DateTime?>(json['fecha']),
      estanciaMinima: serializer.fromJson<int?>(json['estanciaMinima']),
      porcentajePromocion:
          serializer.fromJson<double?>(json['porcentajePromocion']),
      codeTarifa: serializer.fromJson<String?>(json['codeTarifa']),
      forGroup: serializer.fromJson<bool?>(json['forGroup']),
      tarifaJSON: serializer.fromJson<String?>(json['tarifaJSON']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'nombre': serializer.toJson<String>(nombre),
      'fecha': serializer.toJson<DateTime?>(fecha),
      'estanciaMinima': serializer.toJson<int?>(estanciaMinima),
      'porcentajePromocion': serializer.toJson<double?>(porcentajePromocion),
      'codeTarifa': serializer.toJson<String?>(codeTarifa),
      'forGroup': serializer.toJson<bool?>(forGroup),
      'tarifaJSON': serializer.toJson<String?>(tarifaJSON),
    };
  }

  TemporadaData copyWith(
          {int? id,
          String? code,
          String? nombre,
          Value<DateTime?> fecha = const Value.absent(),
          Value<int?> estanciaMinima = const Value.absent(),
          Value<double?> porcentajePromocion = const Value.absent(),
          Value<String?> codeTarifa = const Value.absent(),
          Value<bool?> forGroup = const Value.absent(),
          Value<String?> tarifaJSON = const Value.absent()}) =>
      TemporadaData(
        id: id ?? this.id,
        code: code ?? this.code,
        nombre: nombre ?? this.nombre,
        fecha: fecha.present ? fecha.value : this.fecha,
        estanciaMinima:
            estanciaMinima.present ? estanciaMinima.value : this.estanciaMinima,
        porcentajePromocion: porcentajePromocion.present
            ? porcentajePromocion.value
            : this.porcentajePromocion,
        codeTarifa: codeTarifa.present ? codeTarifa.value : this.codeTarifa,
        forGroup: forGroup.present ? forGroup.value : this.forGroup,
        tarifaJSON: tarifaJSON.present ? tarifaJSON.value : this.tarifaJSON,
      );
  TemporadaData copyWithCompanion(TemporadaCompanion data) {
    return TemporadaData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      estanciaMinima: data.estanciaMinima.present
          ? data.estanciaMinima.value
          : this.estanciaMinima,
      porcentajePromocion: data.porcentajePromocion.present
          ? data.porcentajePromocion.value
          : this.porcentajePromocion,
      codeTarifa:
          data.codeTarifa.present ? data.codeTarifa.value : this.codeTarifa,
      forGroup: data.forGroup.present ? data.forGroup.value : this.forGroup,
      tarifaJSON:
          data.tarifaJSON.present ? data.tarifaJSON.value : this.tarifaJSON,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemporadaData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nombre: $nombre, ')
          ..write('fecha: $fecha, ')
          ..write('estanciaMinima: $estanciaMinima, ')
          ..write('porcentajePromocion: $porcentajePromocion, ')
          ..write('codeTarifa: $codeTarifa, ')
          ..write('forGroup: $forGroup, ')
          ..write('tarifaJSON: $tarifaJSON')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, nombre, fecha, estanciaMinima,
      porcentajePromocion, codeTarifa, forGroup, tarifaJSON);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemporadaData &&
          other.id == this.id &&
          other.code == this.code &&
          other.nombre == this.nombre &&
          other.fecha == this.fecha &&
          other.estanciaMinima == this.estanciaMinima &&
          other.porcentajePromocion == this.porcentajePromocion &&
          other.codeTarifa == this.codeTarifa &&
          other.forGroup == this.forGroup &&
          other.tarifaJSON == this.tarifaJSON);
}

class TemporadaCompanion extends UpdateCompanion<TemporadaData> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> nombre;
  final Value<DateTime?> fecha;
  final Value<int?> estanciaMinima;
  final Value<double?> porcentajePromocion;
  final Value<String?> codeTarifa;
  final Value<bool?> forGroup;
  final Value<String?> tarifaJSON;
  const TemporadaCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.nombre = const Value.absent(),
    this.fecha = const Value.absent(),
    this.estanciaMinima = const Value.absent(),
    this.porcentajePromocion = const Value.absent(),
    this.codeTarifa = const Value.absent(),
    this.forGroup = const Value.absent(),
    this.tarifaJSON = const Value.absent(),
  });
  TemporadaCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String nombre,
    this.fecha = const Value.absent(),
    this.estanciaMinima = const Value.absent(),
    this.porcentajePromocion = const Value.absent(),
    this.codeTarifa = const Value.absent(),
    this.forGroup = const Value.absent(),
    this.tarifaJSON = const Value.absent(),
  })  : code = Value(code),
        nombre = Value(nombre);
  static Insertable<TemporadaData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? nombre,
    Expression<DateTime>? fecha,
    Expression<int>? estanciaMinima,
    Expression<double>? porcentajePromocion,
    Expression<String>? codeTarifa,
    Expression<bool>? forGroup,
    Expression<String>? tarifaJSON,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (nombre != null) 'nombre': nombre,
      if (fecha != null) 'fecha': fecha,
      if (estanciaMinima != null) 'estancia_minima': estanciaMinima,
      if (porcentajePromocion != null)
        'porcentaje_promocion': porcentajePromocion,
      if (codeTarifa != null) 'code_tarifa': codeTarifa,
      if (forGroup != null) 'for_group': forGroup,
      if (tarifaJSON != null) 'tarifa_j_s_o_n': tarifaJSON,
    });
  }

  TemporadaCompanion copyWith(
      {Value<int>? id,
      Value<String>? code,
      Value<String>? nombre,
      Value<DateTime?>? fecha,
      Value<int?>? estanciaMinima,
      Value<double?>? porcentajePromocion,
      Value<String?>? codeTarifa,
      Value<bool?>? forGroup,
      Value<String?>? tarifaJSON}) {
    return TemporadaCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      nombre: nombre ?? this.nombre,
      fecha: fecha ?? this.fecha,
      estanciaMinima: estanciaMinima ?? this.estanciaMinima,
      porcentajePromocion: porcentajePromocion ?? this.porcentajePromocion,
      codeTarifa: codeTarifa ?? this.codeTarifa,
      forGroup: forGroup ?? this.forGroup,
      tarifaJSON: tarifaJSON ?? this.tarifaJSON,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (estanciaMinima.present) {
      map['estancia_minima'] = Variable<int>(estanciaMinima.value);
    }
    if (porcentajePromocion.present) {
      map['porcentaje_promocion'] = Variable<double>(porcentajePromocion.value);
    }
    if (codeTarifa.present) {
      map['code_tarifa'] = Variable<String>(codeTarifa.value);
    }
    if (forGroup.present) {
      map['for_group'] = Variable<bool>(forGroup.value);
    }
    if (tarifaJSON.present) {
      map['tarifa_j_s_o_n'] = Variable<String>(tarifaJSON.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemporadaCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nombre: $nombre, ')
          ..write('fecha: $fecha, ')
          ..write('estanciaMinima: $estanciaMinima, ')
          ..write('porcentajePromocion: $porcentajePromocion, ')
          ..write('codeTarifa: $codeTarifa, ')
          ..write('forGroup: $forGroup, ')
          ..write('tarifaJSON: $tarifaJSON')
          ..write(')'))
        .toString();
  }
}

class $TarifaBaseTable extends TarifaBase
    with TableInfo<$TarifaBaseTable, TarifaBaseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarifaBaseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descIntegradoMeta =
      const VerificationMeta('descIntegrado');
  @override
  late final GeneratedColumn<double> descIntegrado = GeneratedColumn<double>(
      'desc_integrado', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
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
  static const VerificationMeta _tarifaPadreIdMeta =
      const VerificationMeta('tarifaPadreId');
  @override
  late final GeneratedColumn<int> tarifaPadreId = GeneratedColumn<int>(
      'tarifa_padre_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tarifa_base (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        code,
        nombre,
        descIntegrado,
        upgradeCategoria,
        upgradeMenor,
        upgradePaxAdic,
        tarifaPadreId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarifa_base';
  @override
  VerificationContext validateIntegrity(Insertable<TarifaBaseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    }
    if (data.containsKey('desc_integrado')) {
      context.handle(
          _descIntegradoMeta,
          descIntegrado.isAcceptableOrUnknown(
              data['desc_integrado']!, _descIntegradoMeta));
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
    if (data.containsKey('tarifa_padre_id')) {
      context.handle(
          _tarifaPadreIdMeta,
          tarifaPadreId.isAcceptableOrUnknown(
              data['tarifa_padre_id']!, _tarifaPadreIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TarifaBaseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarifaBaseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre']),
      descIntegrado: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}desc_integrado']),
      upgradeCategoria: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}upgrade_categoria']),
      upgradeMenor: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}upgrade_menor']),
      upgradePaxAdic: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}upgrade_pax_adic']),
      tarifaPadreId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tarifa_padre_id']),
    );
  }

  @override
  $TarifaBaseTable createAlias(String alias) {
    return $TarifaBaseTable(attachedDatabase, alias);
  }
}

class TarifaBaseData extends DataClass implements Insertable<TarifaBaseData> {
  final int id;
  final String? code;
  final String? nombre;
  final double? descIntegrado;
  final double? upgradeCategoria;
  final double? upgradeMenor;
  final double? upgradePaxAdic;
  final int? tarifaPadreId;
  const TarifaBaseData(
      {required this.id,
      this.code,
      this.nombre,
      this.descIntegrado,
      this.upgradeCategoria,
      this.upgradeMenor,
      this.upgradePaxAdic,
      this.tarifaPadreId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || nombre != null) {
      map['nombre'] = Variable<String>(nombre);
    }
    if (!nullToAbsent || descIntegrado != null) {
      map['desc_integrado'] = Variable<double>(descIntegrado);
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
    if (!nullToAbsent || tarifaPadreId != null) {
      map['tarifa_padre_id'] = Variable<int>(tarifaPadreId);
    }
    return map;
  }

  TarifaBaseCompanion toCompanion(bool nullToAbsent) {
    return TarifaBaseCompanion(
      id: Value(id),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      descIntegrado: descIntegrado == null && nullToAbsent
          ? const Value.absent()
          : Value(descIntegrado),
      upgradeCategoria: upgradeCategoria == null && nullToAbsent
          ? const Value.absent()
          : Value(upgradeCategoria),
      upgradeMenor: upgradeMenor == null && nullToAbsent
          ? const Value.absent()
          : Value(upgradeMenor),
      upgradePaxAdic: upgradePaxAdic == null && nullToAbsent
          ? const Value.absent()
          : Value(upgradePaxAdic),
      tarifaPadreId: tarifaPadreId == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaPadreId),
    );
  }

  factory TarifaBaseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaBaseData(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String?>(json['code']),
      nombre: serializer.fromJson<String?>(json['nombre']),
      descIntegrado: serializer.fromJson<double?>(json['descIntegrado']),
      upgradeCategoria: serializer.fromJson<double?>(json['upgradeCategoria']),
      upgradeMenor: serializer.fromJson<double?>(json['upgradeMenor']),
      upgradePaxAdic: serializer.fromJson<double?>(json['upgradePaxAdic']),
      tarifaPadreId: serializer.fromJson<int?>(json['tarifaPadreId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String?>(code),
      'nombre': serializer.toJson<String?>(nombre),
      'descIntegrado': serializer.toJson<double?>(descIntegrado),
      'upgradeCategoria': serializer.toJson<double?>(upgradeCategoria),
      'upgradeMenor': serializer.toJson<double?>(upgradeMenor),
      'upgradePaxAdic': serializer.toJson<double?>(upgradePaxAdic),
      'tarifaPadreId': serializer.toJson<int?>(tarifaPadreId),
    };
  }

  TarifaBaseData copyWith(
          {int? id,
          Value<String?> code = const Value.absent(),
          Value<String?> nombre = const Value.absent(),
          Value<double?> descIntegrado = const Value.absent(),
          Value<double?> upgradeCategoria = const Value.absent(),
          Value<double?> upgradeMenor = const Value.absent(),
          Value<double?> upgradePaxAdic = const Value.absent(),
          Value<int?> tarifaPadreId = const Value.absent()}) =>
      TarifaBaseData(
        id: id ?? this.id,
        code: code.present ? code.value : this.code,
        nombre: nombre.present ? nombre.value : this.nombre,
        descIntegrado:
            descIntegrado.present ? descIntegrado.value : this.descIntegrado,
        upgradeCategoria: upgradeCategoria.present
            ? upgradeCategoria.value
            : this.upgradeCategoria,
        upgradeMenor:
            upgradeMenor.present ? upgradeMenor.value : this.upgradeMenor,
        upgradePaxAdic:
            upgradePaxAdic.present ? upgradePaxAdic.value : this.upgradePaxAdic,
        tarifaPadreId:
            tarifaPadreId.present ? tarifaPadreId.value : this.tarifaPadreId,
      );
  TarifaBaseData copyWithCompanion(TarifaBaseCompanion data) {
    return TarifaBaseData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descIntegrado: data.descIntegrado.present
          ? data.descIntegrado.value
          : this.descIntegrado,
      upgradeCategoria: data.upgradeCategoria.present
          ? data.upgradeCategoria.value
          : this.upgradeCategoria,
      upgradeMenor: data.upgradeMenor.present
          ? data.upgradeMenor.value
          : this.upgradeMenor,
      upgradePaxAdic: data.upgradePaxAdic.present
          ? data.upgradePaxAdic.value
          : this.upgradePaxAdic,
      tarifaPadreId: data.tarifaPadreId.present
          ? data.tarifaPadreId.value
          : this.tarifaPadreId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TarifaBaseData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nombre: $nombre, ')
          ..write('descIntegrado: $descIntegrado, ')
          ..write('upgradeCategoria: $upgradeCategoria, ')
          ..write('upgradeMenor: $upgradeMenor, ')
          ..write('upgradePaxAdic: $upgradePaxAdic, ')
          ..write('tarifaPadreId: $tarifaPadreId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, nombre, descIntegrado,
      upgradeCategoria, upgradeMenor, upgradePaxAdic, tarifaPadreId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaBaseData &&
          other.id == this.id &&
          other.code == this.code &&
          other.nombre == this.nombre &&
          other.descIntegrado == this.descIntegrado &&
          other.upgradeCategoria == this.upgradeCategoria &&
          other.upgradeMenor == this.upgradeMenor &&
          other.upgradePaxAdic == this.upgradePaxAdic &&
          other.tarifaPadreId == this.tarifaPadreId);
}

class TarifaBaseCompanion extends UpdateCompanion<TarifaBaseData> {
  final Value<int> id;
  final Value<String?> code;
  final Value<String?> nombre;
  final Value<double?> descIntegrado;
  final Value<double?> upgradeCategoria;
  final Value<double?> upgradeMenor;
  final Value<double?> upgradePaxAdic;
  final Value<int?> tarifaPadreId;
  const TarifaBaseCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descIntegrado = const Value.absent(),
    this.upgradeCategoria = const Value.absent(),
    this.upgradeMenor = const Value.absent(),
    this.upgradePaxAdic = const Value.absent(),
    this.tarifaPadreId = const Value.absent(),
  });
  TarifaBaseCompanion.insert({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descIntegrado = const Value.absent(),
    this.upgradeCategoria = const Value.absent(),
    this.upgradeMenor = const Value.absent(),
    this.upgradePaxAdic = const Value.absent(),
    this.tarifaPadreId = const Value.absent(),
  });
  static Insertable<TarifaBaseData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? nombre,
    Expression<double>? descIntegrado,
    Expression<double>? upgradeCategoria,
    Expression<double>? upgradeMenor,
    Expression<double>? upgradePaxAdic,
    Expression<int>? tarifaPadreId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (nombre != null) 'nombre': nombre,
      if (descIntegrado != null) 'desc_integrado': descIntegrado,
      if (upgradeCategoria != null) 'upgrade_categoria': upgradeCategoria,
      if (upgradeMenor != null) 'upgrade_menor': upgradeMenor,
      if (upgradePaxAdic != null) 'upgrade_pax_adic': upgradePaxAdic,
      if (tarifaPadreId != null) 'tarifa_padre_id': tarifaPadreId,
    });
  }

  TarifaBaseCompanion copyWith(
      {Value<int>? id,
      Value<String?>? code,
      Value<String?>? nombre,
      Value<double?>? descIntegrado,
      Value<double?>? upgradeCategoria,
      Value<double?>? upgradeMenor,
      Value<double?>? upgradePaxAdic,
      Value<int?>? tarifaPadreId}) {
    return TarifaBaseCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      nombre: nombre ?? this.nombre,
      descIntegrado: descIntegrado ?? this.descIntegrado,
      upgradeCategoria: upgradeCategoria ?? this.upgradeCategoria,
      upgradeMenor: upgradeMenor ?? this.upgradeMenor,
      upgradePaxAdic: upgradePaxAdic ?? this.upgradePaxAdic,
      tarifaPadreId: tarifaPadreId ?? this.tarifaPadreId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descIntegrado.present) {
      map['desc_integrado'] = Variable<double>(descIntegrado.value);
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
    if (tarifaPadreId.present) {
      map['tarifa_padre_id'] = Variable<int>(tarifaPadreId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaBaseCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nombre: $nombre, ')
          ..write('descIntegrado: $descIntegrado, ')
          ..write('upgradeCategoria: $upgradeCategoria, ')
          ..write('upgradeMenor: $upgradeMenor, ')
          ..write('upgradePaxAdic: $upgradePaxAdic, ')
          ..write('tarifaPadreId: $tarifaPadreId')
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
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tarifaAdultoSGLoDBLMeta =
      const VerificationMeta('tarifaAdultoSGLoDBL');
  @override
  late final GeneratedColumn<double> tarifaAdultoSGLoDBL =
      GeneratedColumn<double>('tarifa_adulto_s_g_lo_d_b_l', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaAdultoTPLMeta =
      const VerificationMeta('tarifaAdultoTPL');
  @override
  late final GeneratedColumn<double> tarifaAdultoTPL = GeneratedColumn<double>(
      'tarifa_adulto_t_p_l', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaAdultoCPLEMeta =
      const VerificationMeta('tarifaAdultoCPLE');
  @override
  late final GeneratedColumn<double> tarifaAdultoCPLE = GeneratedColumn<double>(
      'tarifa_adulto_c_p_l_e', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaMenores7a12Meta =
      const VerificationMeta('tarifaMenores7a12');
  @override
  late final GeneratedColumn<double> tarifaMenores7a12 =
      GeneratedColumn<double>('tarifa_menores7a12', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaPaxAdicionalMeta =
      const VerificationMeta('tarifaPaxAdicional');
  @override
  late final GeneratedColumn<double> tarifaPaxAdicional =
      GeneratedColumn<double>('tarifa_pax_adicional', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tarifaPadreIdMeta =
      const VerificationMeta('tarifaPadreId');
  @override
  late final GeneratedColumn<int> tarifaPadreId = GeneratedColumn<int>(
      'tarifa_padre_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tarifa_base (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        code,
        fecha,
        categoria,
        tarifaAdultoSGLoDBL,
        tarifaAdultoTPL,
        tarifaAdultoCPLE,
        tarifaMenores7a12,
        tarifaPaxAdicional,
        tarifaPadreId
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
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    }
    if (data.containsKey('tarifa_adulto_s_g_lo_d_b_l')) {
      context.handle(
          _tarifaAdultoSGLoDBLMeta,
          tarifaAdultoSGLoDBL.isAcceptableOrUnknown(
              data['tarifa_adulto_s_g_lo_d_b_l']!, _tarifaAdultoSGLoDBLMeta));
    }
    if (data.containsKey('tarifa_adulto_t_p_l')) {
      context.handle(
          _tarifaAdultoTPLMeta,
          tarifaAdultoTPL.isAcceptableOrUnknown(
              data['tarifa_adulto_t_p_l']!, _tarifaAdultoTPLMeta));
    }
    if (data.containsKey('tarifa_adulto_c_p_l_e')) {
      context.handle(
          _tarifaAdultoCPLEMeta,
          tarifaAdultoCPLE.isAcceptableOrUnknown(
              data['tarifa_adulto_c_p_l_e']!, _tarifaAdultoCPLEMeta));
    }
    if (data.containsKey('tarifa_menores7a12')) {
      context.handle(
          _tarifaMenores7a12Meta,
          tarifaMenores7a12.isAcceptableOrUnknown(
              data['tarifa_menores7a12']!, _tarifaMenores7a12Meta));
    }
    if (data.containsKey('tarifa_pax_adicional')) {
      context.handle(
          _tarifaPaxAdicionalMeta,
          tarifaPaxAdicional.isAcceptableOrUnknown(
              data['tarifa_pax_adicional']!, _tarifaPaxAdicionalMeta));
    }
    if (data.containsKey('tarifa_padre_id')) {
      context.handle(
          _tarifaPadreIdMeta,
          tarifaPadreId.isAcceptableOrUnknown(
              data['tarifa_padre_id']!, _tarifaPadreIdMeta));
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
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha']),
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria']),
      tarifaAdultoSGLoDBL: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}tarifa_adulto_s_g_lo_d_b_l']),
      tarifaAdultoTPL: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}tarifa_adulto_t_p_l']),
      tarifaAdultoCPLE: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}tarifa_adulto_c_p_l_e']),
      tarifaMenores7a12: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}tarifa_menores7a12']),
      tarifaPaxAdicional: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}tarifa_pax_adicional']),
      tarifaPadreId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tarifa_padre_id']),
    );
  }

  @override
  $TarifaTable createAlias(String alias) {
    return $TarifaTable(attachedDatabase, alias);
  }
}

class TarifaData extends DataClass implements Insertable<TarifaData> {
  final int id;
  final String? code;
  final DateTime? fecha;
  final String? categoria;
  final double? tarifaAdultoSGLoDBL;
  final double? tarifaAdultoTPL;
  final double? tarifaAdultoCPLE;
  final double? tarifaMenores7a12;
  final double? tarifaPaxAdicional;
  final int? tarifaPadreId;
  const TarifaData(
      {required this.id,
      this.code,
      this.fecha,
      this.categoria,
      this.tarifaAdultoSGLoDBL,
      this.tarifaAdultoTPL,
      this.tarifaAdultoCPLE,
      this.tarifaMenores7a12,
      this.tarifaPaxAdicional,
      this.tarifaPadreId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || fecha != null) {
      map['fecha'] = Variable<DateTime>(fecha);
    }
    if (!nullToAbsent || categoria != null) {
      map['categoria'] = Variable<String>(categoria);
    }
    if (!nullToAbsent || tarifaAdultoSGLoDBL != null) {
      map['tarifa_adulto_s_g_lo_d_b_l'] = Variable<double>(tarifaAdultoSGLoDBL);
    }
    if (!nullToAbsent || tarifaAdultoTPL != null) {
      map['tarifa_adulto_t_p_l'] = Variable<double>(tarifaAdultoTPL);
    }
    if (!nullToAbsent || tarifaAdultoCPLE != null) {
      map['tarifa_adulto_c_p_l_e'] = Variable<double>(tarifaAdultoCPLE);
    }
    if (!nullToAbsent || tarifaMenores7a12 != null) {
      map['tarifa_menores7a12'] = Variable<double>(tarifaMenores7a12);
    }
    if (!nullToAbsent || tarifaPaxAdicional != null) {
      map['tarifa_pax_adicional'] = Variable<double>(tarifaPaxAdicional);
    }
    if (!nullToAbsent || tarifaPadreId != null) {
      map['tarifa_padre_id'] = Variable<int>(tarifaPadreId);
    }
    return map;
  }

  TarifaCompanion toCompanion(bool nullToAbsent) {
    return TarifaCompanion(
      id: Value(id),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      fecha:
          fecha == null && nullToAbsent ? const Value.absent() : Value(fecha),
      categoria: categoria == null && nullToAbsent
          ? const Value.absent()
          : Value(categoria),
      tarifaAdultoSGLoDBL: tarifaAdultoSGLoDBL == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaAdultoSGLoDBL),
      tarifaAdultoTPL: tarifaAdultoTPL == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaAdultoTPL),
      tarifaAdultoCPLE: tarifaAdultoCPLE == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaAdultoCPLE),
      tarifaMenores7a12: tarifaMenores7a12 == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaMenores7a12),
      tarifaPaxAdicional: tarifaPaxAdicional == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaPaxAdicional),
      tarifaPadreId: tarifaPadreId == null && nullToAbsent
          ? const Value.absent()
          : Value(tarifaPadreId),
    );
  }

  factory TarifaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaData(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String?>(json['code']),
      fecha: serializer.fromJson<DateTime?>(json['fecha']),
      categoria: serializer.fromJson<String?>(json['categoria']),
      tarifaAdultoSGLoDBL:
          serializer.fromJson<double?>(json['tarifaAdultoSGLoDBL']),
      tarifaAdultoTPL: serializer.fromJson<double?>(json['tarifaAdultoTPL']),
      tarifaAdultoCPLE: serializer.fromJson<double?>(json['tarifaAdultoCPLE']),
      tarifaMenores7a12:
          serializer.fromJson<double?>(json['tarifaMenores7a12']),
      tarifaPaxAdicional:
          serializer.fromJson<double?>(json['tarifaPaxAdicional']),
      tarifaPadreId: serializer.fromJson<int?>(json['tarifaPadreId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String?>(code),
      'fecha': serializer.toJson<DateTime?>(fecha),
      'categoria': serializer.toJson<String?>(categoria),
      'tarifaAdultoSGLoDBL': serializer.toJson<double?>(tarifaAdultoSGLoDBL),
      'tarifaAdultoTPL': serializer.toJson<double?>(tarifaAdultoTPL),
      'tarifaAdultoCPLE': serializer.toJson<double?>(tarifaAdultoCPLE),
      'tarifaMenores7a12': serializer.toJson<double?>(tarifaMenores7a12),
      'tarifaPaxAdicional': serializer.toJson<double?>(tarifaPaxAdicional),
      'tarifaPadreId': serializer.toJson<int?>(tarifaPadreId),
    };
  }

  TarifaData copyWith(
          {int? id,
          Value<String?> code = const Value.absent(),
          Value<DateTime?> fecha = const Value.absent(),
          Value<String?> categoria = const Value.absent(),
          Value<double?> tarifaAdultoSGLoDBL = const Value.absent(),
          Value<double?> tarifaAdultoTPL = const Value.absent(),
          Value<double?> tarifaAdultoCPLE = const Value.absent(),
          Value<double?> tarifaMenores7a12 = const Value.absent(),
          Value<double?> tarifaPaxAdicional = const Value.absent(),
          Value<int?> tarifaPadreId = const Value.absent()}) =>
      TarifaData(
        id: id ?? this.id,
        code: code.present ? code.value : this.code,
        fecha: fecha.present ? fecha.value : this.fecha,
        categoria: categoria.present ? categoria.value : this.categoria,
        tarifaAdultoSGLoDBL: tarifaAdultoSGLoDBL.present
            ? tarifaAdultoSGLoDBL.value
            : this.tarifaAdultoSGLoDBL,
        tarifaAdultoTPL: tarifaAdultoTPL.present
            ? tarifaAdultoTPL.value
            : this.tarifaAdultoTPL,
        tarifaAdultoCPLE: tarifaAdultoCPLE.present
            ? tarifaAdultoCPLE.value
            : this.tarifaAdultoCPLE,
        tarifaMenores7a12: tarifaMenores7a12.present
            ? tarifaMenores7a12.value
            : this.tarifaMenores7a12,
        tarifaPaxAdicional: tarifaPaxAdicional.present
            ? tarifaPaxAdicional.value
            : this.tarifaPaxAdicional,
        tarifaPadreId:
            tarifaPadreId.present ? tarifaPadreId.value : this.tarifaPadreId,
      );
  TarifaData copyWithCompanion(TarifaCompanion data) {
    return TarifaData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      tarifaAdultoSGLoDBL: data.tarifaAdultoSGLoDBL.present
          ? data.tarifaAdultoSGLoDBL.value
          : this.tarifaAdultoSGLoDBL,
      tarifaAdultoTPL: data.tarifaAdultoTPL.present
          ? data.tarifaAdultoTPL.value
          : this.tarifaAdultoTPL,
      tarifaAdultoCPLE: data.tarifaAdultoCPLE.present
          ? data.tarifaAdultoCPLE.value
          : this.tarifaAdultoCPLE,
      tarifaMenores7a12: data.tarifaMenores7a12.present
          ? data.tarifaMenores7a12.value
          : this.tarifaMenores7a12,
      tarifaPaxAdicional: data.tarifaPaxAdicional.present
          ? data.tarifaPaxAdicional.value
          : this.tarifaPaxAdicional,
      tarifaPadreId: data.tarifaPadreId.present
          ? data.tarifaPadreId.value
          : this.tarifaPadreId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TarifaData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('fecha: $fecha, ')
          ..write('categoria: $categoria, ')
          ..write('tarifaAdultoSGLoDBL: $tarifaAdultoSGLoDBL, ')
          ..write('tarifaAdultoTPL: $tarifaAdultoTPL, ')
          ..write('tarifaAdultoCPLE: $tarifaAdultoCPLE, ')
          ..write('tarifaMenores7a12: $tarifaMenores7a12, ')
          ..write('tarifaPaxAdicional: $tarifaPaxAdicional, ')
          ..write('tarifaPadreId: $tarifaPadreId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      code,
      fecha,
      categoria,
      tarifaAdultoSGLoDBL,
      tarifaAdultoTPL,
      tarifaAdultoCPLE,
      tarifaMenores7a12,
      tarifaPaxAdicional,
      tarifaPadreId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaData &&
          other.id == this.id &&
          other.code == this.code &&
          other.fecha == this.fecha &&
          other.categoria == this.categoria &&
          other.tarifaAdultoSGLoDBL == this.tarifaAdultoSGLoDBL &&
          other.tarifaAdultoTPL == this.tarifaAdultoTPL &&
          other.tarifaAdultoCPLE == this.tarifaAdultoCPLE &&
          other.tarifaMenores7a12 == this.tarifaMenores7a12 &&
          other.tarifaPaxAdicional == this.tarifaPaxAdicional &&
          other.tarifaPadreId == this.tarifaPadreId);
}

class TarifaCompanion extends UpdateCompanion<TarifaData> {
  final Value<int> id;
  final Value<String?> code;
  final Value<DateTime?> fecha;
  final Value<String?> categoria;
  final Value<double?> tarifaAdultoSGLoDBL;
  final Value<double?> tarifaAdultoTPL;
  final Value<double?> tarifaAdultoCPLE;
  final Value<double?> tarifaMenores7a12;
  final Value<double?> tarifaPaxAdicional;
  final Value<int?> tarifaPadreId;
  const TarifaCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.fecha = const Value.absent(),
    this.categoria = const Value.absent(),
    this.tarifaAdultoSGLoDBL = const Value.absent(),
    this.tarifaAdultoTPL = const Value.absent(),
    this.tarifaAdultoCPLE = const Value.absent(),
    this.tarifaMenores7a12 = const Value.absent(),
    this.tarifaPaxAdicional = const Value.absent(),
    this.tarifaPadreId = const Value.absent(),
  });
  TarifaCompanion.insert({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.fecha = const Value.absent(),
    this.categoria = const Value.absent(),
    this.tarifaAdultoSGLoDBL = const Value.absent(),
    this.tarifaAdultoTPL = const Value.absent(),
    this.tarifaAdultoCPLE = const Value.absent(),
    this.tarifaMenores7a12 = const Value.absent(),
    this.tarifaPaxAdicional = const Value.absent(),
    this.tarifaPadreId = const Value.absent(),
  });
  static Insertable<TarifaData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<DateTime>? fecha,
    Expression<String>? categoria,
    Expression<double>? tarifaAdultoSGLoDBL,
    Expression<double>? tarifaAdultoTPL,
    Expression<double>? tarifaAdultoCPLE,
    Expression<double>? tarifaMenores7a12,
    Expression<double>? tarifaPaxAdicional,
    Expression<int>? tarifaPadreId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (fecha != null) 'fecha': fecha,
      if (categoria != null) 'categoria': categoria,
      if (tarifaAdultoSGLoDBL != null)
        'tarifa_adulto_s_g_lo_d_b_l': tarifaAdultoSGLoDBL,
      if (tarifaAdultoTPL != null) 'tarifa_adulto_t_p_l': tarifaAdultoTPL,
      if (tarifaAdultoCPLE != null) 'tarifa_adulto_c_p_l_e': tarifaAdultoCPLE,
      if (tarifaMenores7a12 != null) 'tarifa_menores7a12': tarifaMenores7a12,
      if (tarifaPaxAdicional != null)
        'tarifa_pax_adicional': tarifaPaxAdicional,
      if (tarifaPadreId != null) 'tarifa_padre_id': tarifaPadreId,
    });
  }

  TarifaCompanion copyWith(
      {Value<int>? id,
      Value<String?>? code,
      Value<DateTime?>? fecha,
      Value<String?>? categoria,
      Value<double?>? tarifaAdultoSGLoDBL,
      Value<double?>? tarifaAdultoTPL,
      Value<double?>? tarifaAdultoCPLE,
      Value<double?>? tarifaMenores7a12,
      Value<double?>? tarifaPaxAdicional,
      Value<int?>? tarifaPadreId}) {
    return TarifaCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      fecha: fecha ?? this.fecha,
      categoria: categoria ?? this.categoria,
      tarifaAdultoSGLoDBL: tarifaAdultoSGLoDBL ?? this.tarifaAdultoSGLoDBL,
      tarifaAdultoTPL: tarifaAdultoTPL ?? this.tarifaAdultoTPL,
      tarifaAdultoCPLE: tarifaAdultoCPLE ?? this.tarifaAdultoCPLE,
      tarifaMenores7a12: tarifaMenores7a12 ?? this.tarifaMenores7a12,
      tarifaPaxAdicional: tarifaPaxAdicional ?? this.tarifaPaxAdicional,
      tarifaPadreId: tarifaPadreId ?? this.tarifaPadreId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (tarifaAdultoSGLoDBL.present) {
      map['tarifa_adulto_s_g_lo_d_b_l'] =
          Variable<double>(tarifaAdultoSGLoDBL.value);
    }
    if (tarifaAdultoTPL.present) {
      map['tarifa_adulto_t_p_l'] = Variable<double>(tarifaAdultoTPL.value);
    }
    if (tarifaAdultoCPLE.present) {
      map['tarifa_adulto_c_p_l_e'] = Variable<double>(tarifaAdultoCPLE.value);
    }
    if (tarifaMenores7a12.present) {
      map['tarifa_menores7a12'] = Variable<double>(tarifaMenores7a12.value);
    }
    if (tarifaPaxAdicional.present) {
      map['tarifa_pax_adicional'] = Variable<double>(tarifaPaxAdicional.value);
    }
    if (tarifaPadreId.present) {
      map['tarifa_padre_id'] = Variable<int>(tarifaPadreId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('fecha: $fecha, ')
          ..write('categoria: $categoria, ')
          ..write('tarifaAdultoSGLoDBL: $tarifaAdultoSGLoDBL, ')
          ..write('tarifaAdultoTPL: $tarifaAdultoTPL, ')
          ..write('tarifaAdultoCPLE: $tarifaAdultoCPLE, ')
          ..write('tarifaMenores7a12: $tarifaMenores7a12, ')
          ..write('tarifaPaxAdicional: $tarifaPaxAdicional, ')
          ..write('tarifaPadreId: $tarifaPadreId')
          ..write(')'))
        .toString();
  }
}

class $UserActivityTable extends UserActivity
    with TableInfo<$UserActivityTable, UserActivityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserActivityTable(this.attachedDatabase, [this._alias]);
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
      'fecha', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, fecha, name, category, status, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_activity';
  @override
  VerificationContext validateIntegrity(Insertable<UserActivityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserActivityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserActivityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
    );
  }

  @override
  $UserActivityTable createAlias(String alias) {
    return $UserActivityTable(attachedDatabase, alias);
  }
}

class UserActivityData extends DataClass
    implements Insertable<UserActivityData> {
  final int id;
  final DateTime? fecha;
  final String? name;
  final String? category;
  final int? status;
  final int? userId;
  const UserActivityData(
      {required this.id,
      this.fecha,
      this.name,
      this.category,
      this.status,
      this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || fecha != null) {
      map['fecha'] = Variable<DateTime>(fecha);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<int>(status);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    return map;
  }

  UserActivityCompanion toCompanion(bool nullToAbsent) {
    return UserActivityCompanion(
      id: Value(id),
      fecha:
          fecha == null && nullToAbsent ? const Value.absent() : Value(fecha),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
    );
  }

  factory UserActivityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserActivityData(
      id: serializer.fromJson<int>(json['id']),
      fecha: serializer.fromJson<DateTime?>(json['fecha']),
      name: serializer.fromJson<String?>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      status: serializer.fromJson<int?>(json['status']),
      userId: serializer.fromJson<int?>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fecha': serializer.toJson<DateTime?>(fecha),
      'name': serializer.toJson<String?>(name),
      'category': serializer.toJson<String?>(category),
      'status': serializer.toJson<int?>(status),
      'userId': serializer.toJson<int?>(userId),
    };
  }

  UserActivityData copyWith(
          {int? id,
          Value<DateTime?> fecha = const Value.absent(),
          Value<String?> name = const Value.absent(),
          Value<String?> category = const Value.absent(),
          Value<int?> status = const Value.absent(),
          Value<int?> userId = const Value.absent()}) =>
      UserActivityData(
        id: id ?? this.id,
        fecha: fecha.present ? fecha.value : this.fecha,
        name: name.present ? name.value : this.name,
        category: category.present ? category.value : this.category,
        status: status.present ? status.value : this.status,
        userId: userId.present ? userId.value : this.userId,
      );
  UserActivityData copyWithCompanion(UserActivityCompanion data) {
    return UserActivityData(
      id: data.id.present ? data.id.value : this.id,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      status: data.status.present ? data.status.value : this.status,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserActivityData(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('status: $status, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fecha, name, category, status, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserActivityData &&
          other.id == this.id &&
          other.fecha == this.fecha &&
          other.name == this.name &&
          other.category == this.category &&
          other.status == this.status &&
          other.userId == this.userId);
}

class UserActivityCompanion extends UpdateCompanion<UserActivityData> {
  final Value<int> id;
  final Value<DateTime?> fecha;
  final Value<String?> name;
  final Value<String?> category;
  final Value<int?> status;
  final Value<int?> userId;
  const UserActivityCompanion({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.status = const Value.absent(),
    this.userId = const Value.absent(),
  });
  UserActivityCompanion.insert({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.status = const Value.absent(),
    this.userId = const Value.absent(),
  });
  static Insertable<UserActivityData> custom({
    Expression<int>? id,
    Expression<DateTime>? fecha,
    Expression<String>? name,
    Expression<String>? category,
    Expression<int>? status,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fecha != null) 'fecha': fecha,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (status != null) 'status': status,
      if (userId != null) 'user_id': userId,
    });
  }

  UserActivityCompanion copyWith(
      {Value<int>? id,
      Value<DateTime?>? fecha,
      Value<String?>? name,
      Value<String?>? category,
      Value<int?>? status,
      Value<int?>? userId}) {
    return UserActivityCompanion(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      name: name ?? this.name,
      category: category ?? this.category,
      status: status ?? this.status,
      userId: userId ?? this.userId,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserActivityCompanion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('status: $status, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $TarifaRackTable extends TarifaRack
    with TableInfo<$TarifaRackTable, TarifaRackData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarifaRackTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _nombreRackMeta =
      const VerificationMeta('nombreRack');
  @override
  late final GeneratedColumn<String> nombreRack = GeneratedColumn<String>(
      'nombre_rack', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorIdentificacionMeta =
      const VerificationMeta('colorIdentificacion');
  @override
  late final GeneratedColumn<String> colorIdentificacion =
      GeneratedColumn<String>('color_identificacion', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _codeTemporadaMeta =
      const VerificationMeta('codeTemporada');
  @override
  late final GeneratedColumn<String> codeTemporada = GeneratedColumn<String>(
      'code_temporada', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _codePeriodoMeta =
      const VerificationMeta('codePeriodo');
  @override
  late final GeneratedColumn<String> codePeriodo = GeneratedColumn<String>(
      'code_periodo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _usuarioIdMeta =
      const VerificationMeta('usuarioId');
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
      'usuario_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        code,
        fecha,
        nombreRack,
        colorIdentificacion,
        codeTemporada,
        codePeriodo,
        usuarioId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarifa_rack';
  @override
  VerificationContext validateIntegrity(Insertable<TarifaRackData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    }
    if (data.containsKey('nombre_rack')) {
      context.handle(
          _nombreRackMeta,
          nombreRack.isAcceptableOrUnknown(
              data['nombre_rack']!, _nombreRackMeta));
    }
    if (data.containsKey('color_identificacion')) {
      context.handle(
          _colorIdentificacionMeta,
          colorIdentificacion.isAcceptableOrUnknown(
              data['color_identificacion']!, _colorIdentificacionMeta));
    }
    if (data.containsKey('code_temporada')) {
      context.handle(
          _codeTemporadaMeta,
          codeTemporada.isAcceptableOrUnknown(
              data['code_temporada']!, _codeTemporadaMeta));
    }
    if (data.containsKey('code_periodo')) {
      context.handle(
          _codePeriodoMeta,
          codePeriodo.isAcceptableOrUnknown(
              data['code_periodo']!, _codePeriodoMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(_usuarioIdMeta,
          usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TarifaRackData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarifaRackData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha']),
      nombreRack: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre_rack']),
      colorIdentificacion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}color_identificacion']),
      codeTemporada: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code_temporada']),
      codePeriodo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code_periodo']),
      usuarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usuario_id']),
    );
  }

  @override
  $TarifaRackTable createAlias(String alias) {
    return $TarifaRackTable(attachedDatabase, alias);
  }
}

class TarifaRackData extends DataClass implements Insertable<TarifaRackData> {
  final int id;
  final String code;
  final DateTime? fecha;
  final String? nombreRack;
  final String? colorIdentificacion;
  final String? codeTemporada;
  final String? codePeriodo;
  final int? usuarioId;
  const TarifaRackData(
      {required this.id,
      required this.code,
      this.fecha,
      this.nombreRack,
      this.colorIdentificacion,
      this.codeTemporada,
      this.codePeriodo,
      this.usuarioId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || fecha != null) {
      map['fecha'] = Variable<DateTime>(fecha);
    }
    if (!nullToAbsent || nombreRack != null) {
      map['nombre_rack'] = Variable<String>(nombreRack);
    }
    if (!nullToAbsent || colorIdentificacion != null) {
      map['color_identificacion'] = Variable<String>(colorIdentificacion);
    }
    if (!nullToAbsent || codeTemporada != null) {
      map['code_temporada'] = Variable<String>(codeTemporada);
    }
    if (!nullToAbsent || codePeriodo != null) {
      map['code_periodo'] = Variable<String>(codePeriodo);
    }
    if (!nullToAbsent || usuarioId != null) {
      map['usuario_id'] = Variable<int>(usuarioId);
    }
    return map;
  }

  TarifaRackCompanion toCompanion(bool nullToAbsent) {
    return TarifaRackCompanion(
      id: Value(id),
      code: Value(code),
      fecha:
          fecha == null && nullToAbsent ? const Value.absent() : Value(fecha),
      nombreRack: nombreRack == null && nullToAbsent
          ? const Value.absent()
          : Value(nombreRack),
      colorIdentificacion: colorIdentificacion == null && nullToAbsent
          ? const Value.absent()
          : Value(colorIdentificacion),
      codeTemporada: codeTemporada == null && nullToAbsent
          ? const Value.absent()
          : Value(codeTemporada),
      codePeriodo: codePeriodo == null && nullToAbsent
          ? const Value.absent()
          : Value(codePeriodo),
      usuarioId: usuarioId == null && nullToAbsent
          ? const Value.absent()
          : Value(usuarioId),
    );
  }

  factory TarifaRackData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarifaRackData(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      fecha: serializer.fromJson<DateTime?>(json['fecha']),
      nombreRack: serializer.fromJson<String?>(json['nombreRack']),
      colorIdentificacion:
          serializer.fromJson<String?>(json['colorIdentificacion']),
      codeTemporada: serializer.fromJson<String?>(json['codeTemporada']),
      codePeriodo: serializer.fromJson<String?>(json['codePeriodo']),
      usuarioId: serializer.fromJson<int?>(json['usuarioId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'fecha': serializer.toJson<DateTime?>(fecha),
      'nombreRack': serializer.toJson<String?>(nombreRack),
      'colorIdentificacion': serializer.toJson<String?>(colorIdentificacion),
      'codeTemporada': serializer.toJson<String?>(codeTemporada),
      'codePeriodo': serializer.toJson<String?>(codePeriodo),
      'usuarioId': serializer.toJson<int?>(usuarioId),
    };
  }

  TarifaRackData copyWith(
          {int? id,
          String? code,
          Value<DateTime?> fecha = const Value.absent(),
          Value<String?> nombreRack = const Value.absent(),
          Value<String?> colorIdentificacion = const Value.absent(),
          Value<String?> codeTemporada = const Value.absent(),
          Value<String?> codePeriodo = const Value.absent(),
          Value<int?> usuarioId = const Value.absent()}) =>
      TarifaRackData(
        id: id ?? this.id,
        code: code ?? this.code,
        fecha: fecha.present ? fecha.value : this.fecha,
        nombreRack: nombreRack.present ? nombreRack.value : this.nombreRack,
        colorIdentificacion: colorIdentificacion.present
            ? colorIdentificacion.value
            : this.colorIdentificacion,
        codeTemporada:
            codeTemporada.present ? codeTemporada.value : this.codeTemporada,
        codePeriodo: codePeriodo.present ? codePeriodo.value : this.codePeriodo,
        usuarioId: usuarioId.present ? usuarioId.value : this.usuarioId,
      );
  TarifaRackData copyWithCompanion(TarifaRackCompanion data) {
    return TarifaRackData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      nombreRack:
          data.nombreRack.present ? data.nombreRack.value : this.nombreRack,
      colorIdentificacion: data.colorIdentificacion.present
          ? data.colorIdentificacion.value
          : this.colorIdentificacion,
      codeTemporada: data.codeTemporada.present
          ? data.codeTemporada.value
          : this.codeTemporada,
      codePeriodo:
          data.codePeriodo.present ? data.codePeriodo.value : this.codePeriodo,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TarifaRackData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('fecha: $fecha, ')
          ..write('nombreRack: $nombreRack, ')
          ..write('colorIdentificacion: $colorIdentificacion, ')
          ..write('codeTemporada: $codeTemporada, ')
          ..write('codePeriodo: $codePeriodo, ')
          ..write('usuarioId: $usuarioId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, fecha, nombreRack,
      colorIdentificacion, codeTemporada, codePeriodo, usuarioId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarifaRackData &&
          other.id == this.id &&
          other.code == this.code &&
          other.fecha == this.fecha &&
          other.nombreRack == this.nombreRack &&
          other.colorIdentificacion == this.colorIdentificacion &&
          other.codeTemporada == this.codeTemporada &&
          other.codePeriodo == this.codePeriodo &&
          other.usuarioId == this.usuarioId);
}

class TarifaRackCompanion extends UpdateCompanion<TarifaRackData> {
  final Value<int> id;
  final Value<String> code;
  final Value<DateTime?> fecha;
  final Value<String?> nombreRack;
  final Value<String?> colorIdentificacion;
  final Value<String?> codeTemporada;
  final Value<String?> codePeriodo;
  final Value<int?> usuarioId;
  const TarifaRackCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.fecha = const Value.absent(),
    this.nombreRack = const Value.absent(),
    this.colorIdentificacion = const Value.absent(),
    this.codeTemporada = const Value.absent(),
    this.codePeriodo = const Value.absent(),
    this.usuarioId = const Value.absent(),
  });
  TarifaRackCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    this.fecha = const Value.absent(),
    this.nombreRack = const Value.absent(),
    this.colorIdentificacion = const Value.absent(),
    this.codeTemporada = const Value.absent(),
    this.codePeriodo = const Value.absent(),
    this.usuarioId = const Value.absent(),
  }) : code = Value(code);
  static Insertable<TarifaRackData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<DateTime>? fecha,
    Expression<String>? nombreRack,
    Expression<String>? colorIdentificacion,
    Expression<String>? codeTemporada,
    Expression<String>? codePeriodo,
    Expression<int>? usuarioId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (fecha != null) 'fecha': fecha,
      if (nombreRack != null) 'nombre_rack': nombreRack,
      if (colorIdentificacion != null)
        'color_identificacion': colorIdentificacion,
      if (codeTemporada != null) 'code_temporada': codeTemporada,
      if (codePeriodo != null) 'code_periodo': codePeriodo,
      if (usuarioId != null) 'usuario_id': usuarioId,
    });
  }

  TarifaRackCompanion copyWith(
      {Value<int>? id,
      Value<String>? code,
      Value<DateTime?>? fecha,
      Value<String?>? nombreRack,
      Value<String?>? colorIdentificacion,
      Value<String?>? codeTemporada,
      Value<String?>? codePeriodo,
      Value<int?>? usuarioId}) {
    return TarifaRackCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      fecha: fecha ?? this.fecha,
      nombreRack: nombreRack ?? this.nombreRack,
      colorIdentificacion: colorIdentificacion ?? this.colorIdentificacion,
      codeTemporada: codeTemporada ?? this.codeTemporada,
      codePeriodo: codePeriodo ?? this.codePeriodo,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (nombreRack.present) {
      map['nombre_rack'] = Variable<String>(nombreRack.value);
    }
    if (colorIdentificacion.present) {
      map['color_identificacion'] = Variable<String>(colorIdentificacion.value);
    }
    if (codeTemporada.present) {
      map['code_temporada'] = Variable<String>(codeTemporada.value);
    }
    if (codePeriodo.present) {
      map['code_periodo'] = Variable<String>(codePeriodo.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifaRackCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('fecha: $fecha, ')
          ..write('nombreRack: $nombreRack, ')
          ..write('colorIdentificacion: $colorIdentificacion, ')
          ..write('codeTemporada: $codeTemporada, ')
          ..write('codePeriodo: $codePeriodo, ')
          ..write('usuarioId: $usuarioId')
          ..write(')'))
        .toString();
  }
}

class $PoliticasTable extends Politicas
    with TableInfo<$PoliticasTable, Politica> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PoliticasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fechaActualizacionMeta =
      const VerificationMeta('fechaActualizacion');
  @override
  late final GeneratedColumn<DateTime> fechaActualizacion =
      GeneratedColumn<DateTime>('fecha_actualizacion', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _intervaloHabitacionGratuitaMeta =
      const VerificationMeta('intervaloHabitacionGratuita');
  @override
  late final GeneratedColumn<int> intervaloHabitacionGratuita =
      GeneratedColumn<int>('intervalo_habitacion_gratuita', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _limiteHabitacionCotizacionMeta =
      const VerificationMeta('limiteHabitacionCotizacion');
  @override
  late final GeneratedColumn<int> limiteHabitacionCotizacion =
      GeneratedColumn<int>('limite_habitacion_cotizacion', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fechaActualizacion,
        intervaloHabitacionGratuita,
        limiteHabitacionCotizacion
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'politicas';
  @override
  VerificationContext validateIntegrity(Insertable<Politica> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fecha_actualizacion')) {
      context.handle(
          _fechaActualizacionMeta,
          fechaActualizacion.isAcceptableOrUnknown(
              data['fecha_actualizacion']!, _fechaActualizacionMeta));
    }
    if (data.containsKey('intervalo_habitacion_gratuita')) {
      context.handle(
          _intervaloHabitacionGratuitaMeta,
          intervaloHabitacionGratuita.isAcceptableOrUnknown(
              data['intervalo_habitacion_gratuita']!,
              _intervaloHabitacionGratuitaMeta));
    }
    if (data.containsKey('limite_habitacion_cotizacion')) {
      context.handle(
          _limiteHabitacionCotizacionMeta,
          limiteHabitacionCotizacion.isAcceptableOrUnknown(
              data['limite_habitacion_cotizacion']!,
              _limiteHabitacionCotizacionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Politica map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Politica(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fechaActualizacion: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_actualizacion']),
      intervaloHabitacionGratuita: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}intervalo_habitacion_gratuita']),
      limiteHabitacionCotizacion: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}limite_habitacion_cotizacion']),
    );
  }

  @override
  $PoliticasTable createAlias(String alias) {
    return $PoliticasTable(attachedDatabase, alias);
  }
}

class Politica extends DataClass implements Insertable<Politica> {
  final int id;
  final DateTime? fechaActualizacion;
  final int? intervaloHabitacionGratuita;
  final int? limiteHabitacionCotizacion;
  const Politica(
      {required this.id,
      this.fechaActualizacion,
      this.intervaloHabitacionGratuita,
      this.limiteHabitacionCotizacion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || fechaActualizacion != null) {
      map['fecha_actualizacion'] = Variable<DateTime>(fechaActualizacion);
    }
    if (!nullToAbsent || intervaloHabitacionGratuita != null) {
      map['intervalo_habitacion_gratuita'] =
          Variable<int>(intervaloHabitacionGratuita);
    }
    if (!nullToAbsent || limiteHabitacionCotizacion != null) {
      map['limite_habitacion_cotizacion'] =
          Variable<int>(limiteHabitacionCotizacion);
    }
    return map;
  }

  PoliticasCompanion toCompanion(bool nullToAbsent) {
    return PoliticasCompanion(
      id: Value(id),
      fechaActualizacion: fechaActualizacion == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaActualizacion),
      intervaloHabitacionGratuita:
          intervaloHabitacionGratuita == null && nullToAbsent
              ? const Value.absent()
              : Value(intervaloHabitacionGratuita),
      limiteHabitacionCotizacion:
          limiteHabitacionCotizacion == null && nullToAbsent
              ? const Value.absent()
              : Value(limiteHabitacionCotizacion),
    );
  }

  factory Politica.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Politica(
      id: serializer.fromJson<int>(json['id']),
      fechaActualizacion:
          serializer.fromJson<DateTime?>(json['fechaActualizacion']),
      intervaloHabitacionGratuita:
          serializer.fromJson<int?>(json['intervaloHabitacionGratuita']),
      limiteHabitacionCotizacion:
          serializer.fromJson<int?>(json['limiteHabitacionCotizacion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fechaActualizacion': serializer.toJson<DateTime?>(fechaActualizacion),
      'intervaloHabitacionGratuita':
          serializer.toJson<int?>(intervaloHabitacionGratuita),
      'limiteHabitacionCotizacion':
          serializer.toJson<int?>(limiteHabitacionCotizacion),
    };
  }

  Politica copyWith(
          {int? id,
          Value<DateTime?> fechaActualizacion = const Value.absent(),
          Value<int?> intervaloHabitacionGratuita = const Value.absent(),
          Value<int?> limiteHabitacionCotizacion = const Value.absent()}) =>
      Politica(
        id: id ?? this.id,
        fechaActualizacion: fechaActualizacion.present
            ? fechaActualizacion.value
            : this.fechaActualizacion,
        intervaloHabitacionGratuita: intervaloHabitacionGratuita.present
            ? intervaloHabitacionGratuita.value
            : this.intervaloHabitacionGratuita,
        limiteHabitacionCotizacion: limiteHabitacionCotizacion.present
            ? limiteHabitacionCotizacion.value
            : this.limiteHabitacionCotizacion,
      );
  Politica copyWithCompanion(PoliticasCompanion data) {
    return Politica(
      id: data.id.present ? data.id.value : this.id,
      fechaActualizacion: data.fechaActualizacion.present
          ? data.fechaActualizacion.value
          : this.fechaActualizacion,
      intervaloHabitacionGratuita: data.intervaloHabitacionGratuita.present
          ? data.intervaloHabitacionGratuita.value
          : this.intervaloHabitacionGratuita,
      limiteHabitacionCotizacion: data.limiteHabitacionCotizacion.present
          ? data.limiteHabitacionCotizacion.value
          : this.limiteHabitacionCotizacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Politica(')
          ..write('id: $id, ')
          ..write('fechaActualizacion: $fechaActualizacion, ')
          ..write('intervaloHabitacionGratuita: $intervaloHabitacionGratuita, ')
          ..write('limiteHabitacionCotizacion: $limiteHabitacionCotizacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fechaActualizacion,
      intervaloHabitacionGratuita, limiteHabitacionCotizacion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Politica &&
          other.id == this.id &&
          other.fechaActualizacion == this.fechaActualizacion &&
          other.intervaloHabitacionGratuita ==
              this.intervaloHabitacionGratuita &&
          other.limiteHabitacionCotizacion == this.limiteHabitacionCotizacion);
}

class PoliticasCompanion extends UpdateCompanion<Politica> {
  final Value<int> id;
  final Value<DateTime?> fechaActualizacion;
  final Value<int?> intervaloHabitacionGratuita;
  final Value<int?> limiteHabitacionCotizacion;
  const PoliticasCompanion({
    this.id = const Value.absent(),
    this.fechaActualizacion = const Value.absent(),
    this.intervaloHabitacionGratuita = const Value.absent(),
    this.limiteHabitacionCotizacion = const Value.absent(),
  });
  PoliticasCompanion.insert({
    this.id = const Value.absent(),
    this.fechaActualizacion = const Value.absent(),
    this.intervaloHabitacionGratuita = const Value.absent(),
    this.limiteHabitacionCotizacion = const Value.absent(),
  });
  static Insertable<Politica> custom({
    Expression<int>? id,
    Expression<DateTime>? fechaActualizacion,
    Expression<int>? intervaloHabitacionGratuita,
    Expression<int>? limiteHabitacionCotizacion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fechaActualizacion != null) 'fecha_actualizacion': fechaActualizacion,
      if (intervaloHabitacionGratuita != null)
        'intervalo_habitacion_gratuita': intervaloHabitacionGratuita,
      if (limiteHabitacionCotizacion != null)
        'limite_habitacion_cotizacion': limiteHabitacionCotizacion,
    });
  }

  PoliticasCompanion copyWith(
      {Value<int>? id,
      Value<DateTime?>? fechaActualizacion,
      Value<int?>? intervaloHabitacionGratuita,
      Value<int?>? limiteHabitacionCotizacion}) {
    return PoliticasCompanion(
      id: id ?? this.id,
      fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
      intervaloHabitacionGratuita:
          intervaloHabitacionGratuita ?? this.intervaloHabitacionGratuita,
      limiteHabitacionCotizacion:
          limiteHabitacionCotizacion ?? this.limiteHabitacionCotizacion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fechaActualizacion.present) {
      map['fecha_actualizacion'] = Variable<DateTime>(fechaActualizacion.value);
    }
    if (intervaloHabitacionGratuita.present) {
      map['intervalo_habitacion_gratuita'] =
          Variable<int>(intervaloHabitacionGratuita.value);
    }
    if (limiteHabitacionCotizacion.present) {
      map['limite_habitacion_cotizacion'] =
          Variable<int>(limiteHabitacionCotizacion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PoliticasCompanion(')
          ..write('id: $id, ')
          ..write('fechaActualizacion: $fechaActualizacion, ')
          ..write('intervaloHabitacionGratuita: $intervaloHabitacionGratuita, ')
          ..write('limiteHabitacionCotizacion: $limiteHabitacionCotizacion')
          ..write(')'))
        .toString();
  }
}

class $TemporadaTarifaTable extends TemporadaTarifa
    with TableInfo<$TemporadaTarifaTable, TemporadaTarifaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemporadaTarifaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _temporadaIdMeta =
      const VerificationMeta('temporadaId');
  @override
  late final GeneratedColumn<int> temporadaId = GeneratedColumn<int>(
      'temporada_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES temporada (id)'));
  static const VerificationMeta _TarifaIdMeta =
      const VerificationMeta('TarifaId');
  @override
  late final GeneratedColumn<int> TarifaId = GeneratedColumn<int>(
      'tarifa_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tarifa (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, temporadaId, TarifaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'temporada_tarifa';
  @override
  VerificationContext validateIntegrity(
      Insertable<TemporadaTarifaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('temporada_id')) {
      context.handle(
          _temporadaIdMeta,
          temporadaId.isAcceptableOrUnknown(
              data['temporada_id']!, _temporadaIdMeta));
    }
    if (data.containsKey('tarifa_id')) {
      context.handle(_TarifaIdMeta,
          TarifaId.isAcceptableOrUnknown(data['tarifa_id']!, _TarifaIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemporadaTarifaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemporadaTarifaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      temporadaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}temporada_id']),
      TarifaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tarifa_id']),
    );
  }

  @override
  $TemporadaTarifaTable createAlias(String alias) {
    return $TemporadaTarifaTable(attachedDatabase, alias);
  }
}

class TemporadaTarifaData extends DataClass
    implements Insertable<TemporadaTarifaData> {
  final int id;
  final int? temporadaId;
  final int? TarifaId;
  const TemporadaTarifaData(
      {required this.id, this.temporadaId, this.TarifaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || temporadaId != null) {
      map['temporada_id'] = Variable<int>(temporadaId);
    }
    if (!nullToAbsent || TarifaId != null) {
      map['tarifa_id'] = Variable<int>(TarifaId);
    }
    return map;
  }

  TemporadaTarifaCompanion toCompanion(bool nullToAbsent) {
    return TemporadaTarifaCompanion(
      id: Value(id),
      temporadaId: temporadaId == null && nullToAbsent
          ? const Value.absent()
          : Value(temporadaId),
      TarifaId: TarifaId == null && nullToAbsent
          ? const Value.absent()
          : Value(TarifaId),
    );
  }

  factory TemporadaTarifaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemporadaTarifaData(
      id: serializer.fromJson<int>(json['id']),
      temporadaId: serializer.fromJson<int?>(json['temporadaId']),
      TarifaId: serializer.fromJson<int?>(json['TarifaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'temporadaId': serializer.toJson<int?>(temporadaId),
      'TarifaId': serializer.toJson<int?>(TarifaId),
    };
  }

  TemporadaTarifaData copyWith(
          {int? id,
          Value<int?> temporadaId = const Value.absent(),
          Value<int?> TarifaId = const Value.absent()}) =>
      TemporadaTarifaData(
        id: id ?? this.id,
        temporadaId: temporadaId.present ? temporadaId.value : this.temporadaId,
        TarifaId: TarifaId.present ? TarifaId.value : this.TarifaId,
      );
  TemporadaTarifaData copyWithCompanion(TemporadaTarifaCompanion data) {
    return TemporadaTarifaData(
      id: data.id.present ? data.id.value : this.id,
      temporadaId:
          data.temporadaId.present ? data.temporadaId.value : this.temporadaId,
      TarifaId: data.TarifaId.present ? data.TarifaId.value : this.TarifaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemporadaTarifaData(')
          ..write('id: $id, ')
          ..write('temporadaId: $temporadaId, ')
          ..write('TarifaId: $TarifaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, temporadaId, TarifaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemporadaTarifaData &&
          other.id == this.id &&
          other.temporadaId == this.temporadaId &&
          other.TarifaId == this.TarifaId);
}

class TemporadaTarifaCompanion extends UpdateCompanion<TemporadaTarifaData> {
  final Value<int> id;
  final Value<int?> temporadaId;
  final Value<int?> TarifaId;
  const TemporadaTarifaCompanion({
    this.id = const Value.absent(),
    this.temporadaId = const Value.absent(),
    this.TarifaId = const Value.absent(),
  });
  TemporadaTarifaCompanion.insert({
    this.id = const Value.absent(),
    this.temporadaId = const Value.absent(),
    this.TarifaId = const Value.absent(),
  });
  static Insertable<TemporadaTarifaData> custom({
    Expression<int>? id,
    Expression<int>? temporadaId,
    Expression<int>? TarifaId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (temporadaId != null) 'temporada_id': temporadaId,
      if (TarifaId != null) 'tarifa_id': TarifaId,
    });
  }

  TemporadaTarifaCompanion copyWith(
      {Value<int>? id, Value<int?>? temporadaId, Value<int?>? TarifaId}) {
    return TemporadaTarifaCompanion(
      id: id ?? this.id,
      temporadaId: temporadaId ?? this.temporadaId,
      TarifaId: TarifaId ?? this.TarifaId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (temporadaId.present) {
      map['temporada_id'] = Variable<int>(temporadaId.value);
    }
    if (TarifaId.present) {
      map['tarifa_id'] = Variable<int>(TarifaId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemporadaTarifaCompanion(')
          ..write('id: $id, ')
          ..write('temporadaId: $temporadaId, ')
          ..write('TarifaId: $TarifaId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ImagesTableTable imagesTable = $ImagesTableTable(this);
  late final $UsuarioTable usuario = $UsuarioTable(this);
  late final $CotizacionTable cotizacion = $CotizacionTable(this);
  late final $HabitacionTable habitacion = $HabitacionTable(this);
  late final $TarifaXDiaTableTable tarifaXDiaTable =
      $TarifaXDiaTableTable(this);
  late final $PeriodoTable periodo = $PeriodoTable(this);
  late final $TemporadaTable temporada = $TemporadaTable(this);
  late final $TarifaBaseTable tarifaBase = $TarifaBaseTable(this);
  late final $TarifaTable tarifa = $TarifaTable(this);
  late final $UserActivityTable userActivity = $UserActivityTable(this);
  late final $TarifaRackTable tarifaRack = $TarifaRackTable(this);
  late final $PoliticasTable politicas = $PoliticasTable(this);
  late final $TemporadaTarifaTable temporadaTarifa =
      $TemporadaTarifaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        imagesTable,
        usuario,
        cotizacion,
        habitacion,
        tarifaXDiaTable,
        periodo,
        temporada,
        tarifaBase,
        tarifa,
        userActivity,
        tarifaRack,
        politicas,
        temporadaTarifa
      ];
}

typedef $$ImagesTableTableCreateCompanionBuilder = ImagesTableCompanion
    Function({
  Value<int> id,
  Value<String?> code,
  Value<String?> urlImage,
});
typedef $$ImagesTableTableUpdateCompanionBuilder = ImagesTableCompanion
    Function({
  Value<int> id,
  Value<String?> code,
  Value<String?> urlImage,
});

class $$ImagesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ImagesTableTable,
    ImagesTableData,
    $$ImagesTableTableFilterComposer,
    $$ImagesTableTableOrderingComposer,
    $$ImagesTableTableCreateCompanionBuilder,
    $$ImagesTableTableUpdateCompanionBuilder> {
  $$ImagesTableTableTableManager(_$AppDatabase db, $ImagesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ImagesTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ImagesTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String?> urlImage = const Value.absent(),
          }) =>
              ImagesTableCompanion(
            id: id,
            code: code,
            urlImage: urlImage,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String?> urlImage = const Value.absent(),
          }) =>
              ImagesTableCompanion.insert(
            id: id,
            code: code,
            urlImage: urlImage,
          ),
        ));
}

class $$ImagesTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ImagesTableTable> {
  $$ImagesTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get urlImage => $state.composableBuilder(
      column: $state.table.urlImage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter usuarioRefs(
      ComposableFilter Function($$UsuarioTableFilterComposer f) f) {
    final $$UsuarioTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.usuario,
        getReferencedColumn: (t) => t.imageId,
        builder: (joinBuilder, parentComposers) => $$UsuarioTableFilterComposer(
            ComposerState(
                $state.db, $state.db.usuario, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ImagesTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ImagesTableTable> {
  $$ImagesTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get urlImage => $state.composableBuilder(
      column: $state.table.urlImage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$UsuarioTableCreateCompanionBuilder = UsuarioCompanion Function({
  Value<int> id,
  Value<String?> username,
  Value<String?> password,
  Value<String?> rol,
  Value<String?> status,
  Value<String?> correoElectronico,
  Value<String?> passwordCorreo,
  Value<String?> telefono,
  Value<String?> fechaNacimiento,
  Value<String?> nombre,
  Value<String?> apellido,
  Value<int?> numCotizaciones,
  Value<int?> imageId,
});
typedef $$UsuarioTableUpdateCompanionBuilder = UsuarioCompanion Function({
  Value<int> id,
  Value<String?> username,
  Value<String?> password,
  Value<String?> rol,
  Value<String?> status,
  Value<String?> correoElectronico,
  Value<String?> passwordCorreo,
  Value<String?> telefono,
  Value<String?> fechaNacimiento,
  Value<String?> nombre,
  Value<String?> apellido,
  Value<int?> numCotizaciones,
  Value<int?> imageId,
});

class $$UsuarioTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsuarioTable,
    UsuarioData,
    $$UsuarioTableFilterComposer,
    $$UsuarioTableOrderingComposer,
    $$UsuarioTableCreateCompanionBuilder,
    $$UsuarioTableUpdateCompanionBuilder> {
  $$UsuarioTableTableManager(_$AppDatabase db, $UsuarioTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsuarioTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsuarioTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> password = const Value.absent(),
            Value<String?> rol = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> correoElectronico = const Value.absent(),
            Value<String?> passwordCorreo = const Value.absent(),
            Value<String?> telefono = const Value.absent(),
            Value<String?> fechaNacimiento = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> apellido = const Value.absent(),
            Value<int?> numCotizaciones = const Value.absent(),
            Value<int?> imageId = const Value.absent(),
          }) =>
              UsuarioCompanion(
            id: id,
            username: username,
            password: password,
            rol: rol,
            status: status,
            correoElectronico: correoElectronico,
            passwordCorreo: passwordCorreo,
            telefono: telefono,
            fechaNacimiento: fechaNacimiento,
            nombre: nombre,
            apellido: apellido,
            numCotizaciones: numCotizaciones,
            imageId: imageId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> password = const Value.absent(),
            Value<String?> rol = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> correoElectronico = const Value.absent(),
            Value<String?> passwordCorreo = const Value.absent(),
            Value<String?> telefono = const Value.absent(),
            Value<String?> fechaNacimiento = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String?> apellido = const Value.absent(),
            Value<int?> numCotizaciones = const Value.absent(),
            Value<int?> imageId = const Value.absent(),
          }) =>
              UsuarioCompanion.insert(
            id: id,
            username: username,
            password: password,
            rol: rol,
            status: status,
            correoElectronico: correoElectronico,
            passwordCorreo: passwordCorreo,
            telefono: telefono,
            fechaNacimiento: fechaNacimiento,
            nombre: nombre,
            apellido: apellido,
            numCotizaciones: numCotizaciones,
            imageId: imageId,
          ),
        ));
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

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
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

  $$ImagesTableTableFilterComposer get imageId {
    final $$ImagesTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.imageId,
        referencedTable: $state.db.imagesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ImagesTableTableFilterComposer(ComposerState($state.db,
                $state.db.imagesTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter cotizacionRefs(
      ComposableFilter Function($$CotizacionTableFilterComposer f) f) {
    final $$CotizacionTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.cotizacion,
        getReferencedColumn: (t) => t.usuarioID,
        builder: (joinBuilder, parentComposers) =>
            $$CotizacionTableFilterComposer(ComposerState($state.db,
                $state.db.cotizacion, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter userActivityRefs(
      ComposableFilter Function($$UserActivityTableFilterComposer f) f) {
    final $$UserActivityTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.userActivity,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder, parentComposers) =>
            $$UserActivityTableFilterComposer(ComposerState($state.db,
                $state.db.userActivity, joinBuilder, parentComposers)));
    return f(composer);
  }
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

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
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

  $$ImagesTableTableOrderingComposer get imageId {
    final $$ImagesTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.imageId,
        referencedTable: $state.db.imagesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ImagesTableTableOrderingComposer(ComposerState($state.db,
                $state.db.imagesTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$CotizacionTableCreateCompanionBuilder = CotizacionCompanion Function({
  Value<int> id,
  Value<String?> folioPrincipal,
  Value<String?> nombreHuesped,
  Value<String?> numeroTelefonico,
  Value<String?> correoElectrico,
  required DateTime fecha,
  Value<bool?> esGrupo,
  Value<bool?> esConcretado,
  Value<String?> habitaciones,
  Value<int?> usuarioID,
  Value<String?> username,
});
typedef $$CotizacionTableUpdateCompanionBuilder = CotizacionCompanion Function({
  Value<int> id,
  Value<String?> folioPrincipal,
  Value<String?> nombreHuesped,
  Value<String?> numeroTelefonico,
  Value<String?> correoElectrico,
  Value<DateTime> fecha,
  Value<bool?> esGrupo,
  Value<bool?> esConcretado,
  Value<String?> habitaciones,
  Value<int?> usuarioID,
  Value<String?> username,
});

class $$CotizacionTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CotizacionTable,
    CotizacionData,
    $$CotizacionTableFilterComposer,
    $$CotizacionTableOrderingComposer,
    $$CotizacionTableCreateCompanionBuilder,
    $$CotizacionTableUpdateCompanionBuilder> {
  $$CotizacionTableTableManager(_$AppDatabase db, $CotizacionTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CotizacionTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CotizacionTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> folioPrincipal = const Value.absent(),
            Value<String?> nombreHuesped = const Value.absent(),
            Value<String?> numeroTelefonico = const Value.absent(),
            Value<String?> correoElectrico = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<bool?> esGrupo = const Value.absent(),
            Value<bool?> esConcretado = const Value.absent(),
            Value<String?> habitaciones = const Value.absent(),
            Value<int?> usuarioID = const Value.absent(),
            Value<String?> username = const Value.absent(),
          }) =>
              CotizacionCompanion(
            id: id,
            folioPrincipal: folioPrincipal,
            nombreHuesped: nombreHuesped,
            numeroTelefonico: numeroTelefonico,
            correoElectrico: correoElectrico,
            fecha: fecha,
            esGrupo: esGrupo,
            esConcretado: esConcretado,
            habitaciones: habitaciones,
            usuarioID: usuarioID,
            username: username,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> folioPrincipal = const Value.absent(),
            Value<String?> nombreHuesped = const Value.absent(),
            Value<String?> numeroTelefonico = const Value.absent(),
            Value<String?> correoElectrico = const Value.absent(),
            required DateTime fecha,
            Value<bool?> esGrupo = const Value.absent(),
            Value<bool?> esConcretado = const Value.absent(),
            Value<String?> habitaciones = const Value.absent(),
            Value<int?> usuarioID = const Value.absent(),
            Value<String?> username = const Value.absent(),
          }) =>
              CotizacionCompanion.insert(
            id: id,
            folioPrincipal: folioPrincipal,
            nombreHuesped: nombreHuesped,
            numeroTelefonico: numeroTelefonico,
            correoElectrico: correoElectrico,
            fecha: fecha,
            esGrupo: esGrupo,
            esConcretado: esConcretado,
            habitaciones: habitaciones,
            usuarioID: usuarioID,
            username: username,
          ),
        ));
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

  ColumnFilters<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
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

  ColumnFilters<String> get habitaciones => $state.composableBuilder(
      column: $state.table.habitaciones,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get username => $state.composableBuilder(
      column: $state.table.username,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$UsuarioTableFilterComposer get usuarioID {
    final $$UsuarioTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioID,
        referencedTable: $state.db.usuario,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$UsuarioTableFilterComposer(
            ComposerState(
                $state.db, $state.db.usuario, joinBuilder, parentComposers)));
    return composer;
  }
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

  ColumnOrderings<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
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

  ColumnOrderings<String> get habitaciones => $state.composableBuilder(
      column: $state.table.habitaciones,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get username => $state.composableBuilder(
      column: $state.table.username,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$UsuarioTableOrderingComposer get usuarioID {
    final $$UsuarioTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioID,
        referencedTable: $state.db.usuario,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableOrderingComposer(ComposerState(
                $state.db, $state.db.usuario, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$HabitacionTableCreateCompanionBuilder = HabitacionCompanion Function({
  Value<int> id,
  Value<String?> folioHabitacion,
  Value<String?> folioCotizacion,
  Value<String?> fechaCheckIn,
  Value<String?> fechaCheckOut,
  required DateTime fecha,
  Value<int?> adultos,
  Value<int?> menores0a6,
  Value<int?> menores7a12,
  Value<int?> paxAdic,
  Value<int?> count,
  Value<bool?> isFree,
  Value<String?> tarifaXDia,
});
typedef $$HabitacionTableUpdateCompanionBuilder = HabitacionCompanion Function({
  Value<int> id,
  Value<String?> folioHabitacion,
  Value<String?> folioCotizacion,
  Value<String?> fechaCheckIn,
  Value<String?> fechaCheckOut,
  Value<DateTime> fecha,
  Value<int?> adultos,
  Value<int?> menores0a6,
  Value<int?> menores7a12,
  Value<int?> paxAdic,
  Value<int?> count,
  Value<bool?> isFree,
  Value<String?> tarifaXDia,
});

class $$HabitacionTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitacionTable,
    HabitacionData,
    $$HabitacionTableFilterComposer,
    $$HabitacionTableOrderingComposer,
    $$HabitacionTableCreateCompanionBuilder,
    $$HabitacionTableUpdateCompanionBuilder> {
  $$HabitacionTableTableManager(_$AppDatabase db, $HabitacionTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$HabitacionTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$HabitacionTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> folioHabitacion = const Value.absent(),
            Value<String?> folioCotizacion = const Value.absent(),
            Value<String?> fechaCheckIn = const Value.absent(),
            Value<String?> fechaCheckOut = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int?> adultos = const Value.absent(),
            Value<int?> menores0a6 = const Value.absent(),
            Value<int?> menores7a12 = const Value.absent(),
            Value<int?> paxAdic = const Value.absent(),
            Value<int?> count = const Value.absent(),
            Value<bool?> isFree = const Value.absent(),
            Value<String?> tarifaXDia = const Value.absent(),
          }) =>
              HabitacionCompanion(
            id: id,
            folioHabitacion: folioHabitacion,
            folioCotizacion: folioCotizacion,
            fechaCheckIn: fechaCheckIn,
            fechaCheckOut: fechaCheckOut,
            fecha: fecha,
            adultos: adultos,
            menores0a6: menores0a6,
            menores7a12: menores7a12,
            paxAdic: paxAdic,
            count: count,
            isFree: isFree,
            tarifaXDia: tarifaXDia,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> folioHabitacion = const Value.absent(),
            Value<String?> folioCotizacion = const Value.absent(),
            Value<String?> fechaCheckIn = const Value.absent(),
            Value<String?> fechaCheckOut = const Value.absent(),
            required DateTime fecha,
            Value<int?> adultos = const Value.absent(),
            Value<int?> menores0a6 = const Value.absent(),
            Value<int?> menores7a12 = const Value.absent(),
            Value<int?> paxAdic = const Value.absent(),
            Value<int?> count = const Value.absent(),
            Value<bool?> isFree = const Value.absent(),
            Value<String?> tarifaXDia = const Value.absent(),
          }) =>
              HabitacionCompanion.insert(
            id: id,
            folioHabitacion: folioHabitacion,
            folioCotizacion: folioCotizacion,
            fechaCheckIn: fechaCheckIn,
            fechaCheckOut: fechaCheckOut,
            fecha: fecha,
            adultos: adultos,
            menores0a6: menores0a6,
            menores7a12: menores7a12,
            paxAdic: paxAdic,
            count: count,
            isFree: isFree,
            tarifaXDia: tarifaXDia,
          ),
        ));
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

  ColumnFilters<String> get folioCotizacion => $state.composableBuilder(
      column: $state.table.folioCotizacion,
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

  ColumnFilters<int> get count => $state.composableBuilder(
      column: $state.table.count,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isFree => $state.composableBuilder(
      column: $state.table.isFree,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tarifaXDia => $state.composableBuilder(
      column: $state.table.tarifaXDia,
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

  ColumnOrderings<String> get folioCotizacion => $state.composableBuilder(
      column: $state.table.folioCotizacion,
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

  ColumnOrderings<int> get count => $state.composableBuilder(
      column: $state.table.count,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isFree => $state.composableBuilder(
      column: $state.table.isFree,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tarifaXDia => $state.composableBuilder(
      column: $state.table.tarifaXDia,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TarifaXDiaTableTableCreateCompanionBuilder = TarifaXDiaTableCompanion
    Function({
  Value<int> id,
  Value<String?> subfolio,
  Value<int?> dia,
  required DateTime fecha,
  Value<double?> tarifaRealPaxAdic,
  Value<double?> tarifaPreventaPaxAdic,
  Value<double?> tarifaRealAdulto,
  Value<double?> tarifaPreventaAdulto,
  Value<double?> tarifaRealMenores7a12,
  Value<double?> tarifaPreventaMenores7a12,
  Value<String?> codePeriodo,
  Value<String?> codeTemporada,
  Value<String?> codeTarifa,
});
typedef $$TarifaXDiaTableTableUpdateCompanionBuilder = TarifaXDiaTableCompanion
    Function({
  Value<int> id,
  Value<String?> subfolio,
  Value<int?> dia,
  Value<DateTime> fecha,
  Value<double?> tarifaRealPaxAdic,
  Value<double?> tarifaPreventaPaxAdic,
  Value<double?> tarifaRealAdulto,
  Value<double?> tarifaPreventaAdulto,
  Value<double?> tarifaRealMenores7a12,
  Value<double?> tarifaPreventaMenores7a12,
  Value<String?> codePeriodo,
  Value<String?> codeTemporada,
  Value<String?> codeTarifa,
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
            Value<int> id = const Value.absent(),
            Value<String?> subfolio = const Value.absent(),
            Value<int?> dia = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<double?> tarifaRealPaxAdic = const Value.absent(),
            Value<double?> tarifaPreventaPaxAdic = const Value.absent(),
            Value<double?> tarifaRealAdulto = const Value.absent(),
            Value<double?> tarifaPreventaAdulto = const Value.absent(),
            Value<double?> tarifaRealMenores7a12 = const Value.absent(),
            Value<double?> tarifaPreventaMenores7a12 = const Value.absent(),
            Value<String?> codePeriodo = const Value.absent(),
            Value<String?> codeTemporada = const Value.absent(),
            Value<String?> codeTarifa = const Value.absent(),
          }) =>
              TarifaXDiaTableCompanion(
            id: id,
            subfolio: subfolio,
            dia: dia,
            fecha: fecha,
            tarifaRealPaxAdic: tarifaRealPaxAdic,
            tarifaPreventaPaxAdic: tarifaPreventaPaxAdic,
            tarifaRealAdulto: tarifaRealAdulto,
            tarifaPreventaAdulto: tarifaPreventaAdulto,
            tarifaRealMenores7a12: tarifaRealMenores7a12,
            tarifaPreventaMenores7a12: tarifaPreventaMenores7a12,
            codePeriodo: codePeriodo,
            codeTemporada: codeTemporada,
            codeTarifa: codeTarifa,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> subfolio = const Value.absent(),
            Value<int?> dia = const Value.absent(),
            required DateTime fecha,
            Value<double?> tarifaRealPaxAdic = const Value.absent(),
            Value<double?> tarifaPreventaPaxAdic = const Value.absent(),
            Value<double?> tarifaRealAdulto = const Value.absent(),
            Value<double?> tarifaPreventaAdulto = const Value.absent(),
            Value<double?> tarifaRealMenores7a12 = const Value.absent(),
            Value<double?> tarifaPreventaMenores7a12 = const Value.absent(),
            Value<String?> codePeriodo = const Value.absent(),
            Value<String?> codeTemporada = const Value.absent(),
            Value<String?> codeTarifa = const Value.absent(),
          }) =>
              TarifaXDiaTableCompanion.insert(
            id: id,
            subfolio: subfolio,
            dia: dia,
            fecha: fecha,
            tarifaRealPaxAdic: tarifaRealPaxAdic,
            tarifaPreventaPaxAdic: tarifaPreventaPaxAdic,
            tarifaRealAdulto: tarifaRealAdulto,
            tarifaPreventaAdulto: tarifaPreventaAdulto,
            tarifaRealMenores7a12: tarifaRealMenores7a12,
            tarifaPreventaMenores7a12: tarifaPreventaMenores7a12,
            codePeriodo: codePeriodo,
            codeTemporada: codeTemporada,
            codeTarifa: codeTarifa,
          ),
        ));
}

class $$TarifaXDiaTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaXDiaTableTable> {
  $$TarifaXDiaTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
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

  ColumnFilters<String> get codePeriodo => $state.composableBuilder(
      column: $state.table.codePeriodo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codeTemporada => $state.composableBuilder(
      column: $state.table.codeTemporada,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codeTarifa => $state.composableBuilder(
      column: $state.table.codeTarifa,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TarifaXDiaTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaXDiaTableTable> {
  $$TarifaXDiaTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
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

  ColumnOrderings<String> get codePeriodo => $state.composableBuilder(
      column: $state.table.codePeriodo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codeTemporada => $state.composableBuilder(
      column: $state.table.codeTemporada,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codeTarifa => $state.composableBuilder(
      column: $state.table.codeTarifa,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PeriodoTableCreateCompanionBuilder = PeriodoCompanion Function({
  Value<int> id,
  required String code,
  Value<DateTime?> fecha,
  Value<DateTime?> fechaInicial,
  Value<DateTime?> fechaFinal,
  Value<bool?> enLunes,
  Value<bool?> enMartes,
  Value<bool?> enMiercoles,
  Value<bool?> enJueves,
  Value<bool?> enViernes,
  Value<bool?> enSabado,
  Value<bool?> enDomingo,
});
typedef $$PeriodoTableUpdateCompanionBuilder = PeriodoCompanion Function({
  Value<int> id,
  Value<String> code,
  Value<DateTime?> fecha,
  Value<DateTime?> fechaInicial,
  Value<DateTime?> fechaFinal,
  Value<bool?> enLunes,
  Value<bool?> enMartes,
  Value<bool?> enMiercoles,
  Value<bool?> enJueves,
  Value<bool?> enViernes,
  Value<bool?> enSabado,
  Value<bool?> enDomingo,
});

class $$PeriodoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PeriodoTable,
    PeriodoData,
    $$PeriodoTableFilterComposer,
    $$PeriodoTableOrderingComposer,
    $$PeriodoTableCreateCompanionBuilder,
    $$PeriodoTableUpdateCompanionBuilder> {
  $$PeriodoTableTableManager(_$AppDatabase db, $PeriodoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PeriodoTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PeriodoTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<DateTime?> fecha = const Value.absent(),
            Value<DateTime?> fechaInicial = const Value.absent(),
            Value<DateTime?> fechaFinal = const Value.absent(),
            Value<bool?> enLunes = const Value.absent(),
            Value<bool?> enMartes = const Value.absent(),
            Value<bool?> enMiercoles = const Value.absent(),
            Value<bool?> enJueves = const Value.absent(),
            Value<bool?> enViernes = const Value.absent(),
            Value<bool?> enSabado = const Value.absent(),
            Value<bool?> enDomingo = const Value.absent(),
          }) =>
              PeriodoCompanion(
            id: id,
            code: code,
            fecha: fecha,
            fechaInicial: fechaInicial,
            fechaFinal: fechaFinal,
            enLunes: enLunes,
            enMartes: enMartes,
            enMiercoles: enMiercoles,
            enJueves: enJueves,
            enViernes: enViernes,
            enSabado: enSabado,
            enDomingo: enDomingo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String code,
            Value<DateTime?> fecha = const Value.absent(),
            Value<DateTime?> fechaInicial = const Value.absent(),
            Value<DateTime?> fechaFinal = const Value.absent(),
            Value<bool?> enLunes = const Value.absent(),
            Value<bool?> enMartes = const Value.absent(),
            Value<bool?> enMiercoles = const Value.absent(),
            Value<bool?> enJueves = const Value.absent(),
            Value<bool?> enViernes = const Value.absent(),
            Value<bool?> enSabado = const Value.absent(),
            Value<bool?> enDomingo = const Value.absent(),
          }) =>
              PeriodoCompanion.insert(
            id: id,
            code: code,
            fecha: fecha,
            fechaInicial: fechaInicial,
            fechaFinal: fechaFinal,
            enLunes: enLunes,
            enMartes: enMartes,
            enMiercoles: enMiercoles,
            enJueves: enJueves,
            enViernes: enViernes,
            enSabado: enSabado,
            enDomingo: enDomingo,
          ),
        ));
}

class $$PeriodoTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PeriodoTable> {
  $$PeriodoTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
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

  ColumnFilters<bool> get enLunes => $state.composableBuilder(
      column: $state.table.enLunes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get enMartes => $state.composableBuilder(
      column: $state.table.enMartes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get enMiercoles => $state.composableBuilder(
      column: $state.table.enMiercoles,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get enJueves => $state.composableBuilder(
      column: $state.table.enJueves,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get enViernes => $state.composableBuilder(
      column: $state.table.enViernes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get enSabado => $state.composableBuilder(
      column: $state.table.enSabado,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get enDomingo => $state.composableBuilder(
      column: $state.table.enDomingo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$PeriodoTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PeriodoTable> {
  $$PeriodoTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
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

  ColumnOrderings<bool> get enLunes => $state.composableBuilder(
      column: $state.table.enLunes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get enMartes => $state.composableBuilder(
      column: $state.table.enMartes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get enMiercoles => $state.composableBuilder(
      column: $state.table.enMiercoles,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get enJueves => $state.composableBuilder(
      column: $state.table.enJueves,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get enViernes => $state.composableBuilder(
      column: $state.table.enViernes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get enSabado => $state.composableBuilder(
      column: $state.table.enSabado,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get enDomingo => $state.composableBuilder(
      column: $state.table.enDomingo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TemporadaTableCreateCompanionBuilder = TemporadaCompanion Function({
  Value<int> id,
  required String code,
  required String nombre,
  Value<DateTime?> fecha,
  Value<int?> estanciaMinima,
  Value<double?> porcentajePromocion,
  Value<String?> codeTarifa,
  Value<bool?> forGroup,
  Value<String?> tarifaJSON,
});
typedef $$TemporadaTableUpdateCompanionBuilder = TemporadaCompanion Function({
  Value<int> id,
  Value<String> code,
  Value<String> nombre,
  Value<DateTime?> fecha,
  Value<int?> estanciaMinima,
  Value<double?> porcentajePromocion,
  Value<String?> codeTarifa,
  Value<bool?> forGroup,
  Value<String?> tarifaJSON,
});

class $$TemporadaTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TemporadaTable,
    TemporadaData,
    $$TemporadaTableFilterComposer,
    $$TemporadaTableOrderingComposer,
    $$TemporadaTableCreateCompanionBuilder,
    $$TemporadaTableUpdateCompanionBuilder> {
  $$TemporadaTableTableManager(_$AppDatabase db, $TemporadaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TemporadaTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TemporadaTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<DateTime?> fecha = const Value.absent(),
            Value<int?> estanciaMinima = const Value.absent(),
            Value<double?> porcentajePromocion = const Value.absent(),
            Value<String?> codeTarifa = const Value.absent(),
            Value<bool?> forGroup = const Value.absent(),
            Value<String?> tarifaJSON = const Value.absent(),
          }) =>
              TemporadaCompanion(
            id: id,
            code: code,
            nombre: nombre,
            fecha: fecha,
            estanciaMinima: estanciaMinima,
            porcentajePromocion: porcentajePromocion,
            codeTarifa: codeTarifa,
            forGroup: forGroup,
            tarifaJSON: tarifaJSON,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String code,
            required String nombre,
            Value<DateTime?> fecha = const Value.absent(),
            Value<int?> estanciaMinima = const Value.absent(),
            Value<double?> porcentajePromocion = const Value.absent(),
            Value<String?> codeTarifa = const Value.absent(),
            Value<bool?> forGroup = const Value.absent(),
            Value<String?> tarifaJSON = const Value.absent(),
          }) =>
              TemporadaCompanion.insert(
            id: id,
            code: code,
            nombre: nombre,
            fecha: fecha,
            estanciaMinima: estanciaMinima,
            porcentajePromocion: porcentajePromocion,
            codeTarifa: codeTarifa,
            forGroup: forGroup,
            tarifaJSON: tarifaJSON,
          ),
        ));
}

class $$TemporadaTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TemporadaTable> {
  $$TemporadaTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get estanciaMinima => $state.composableBuilder(
      column: $state.table.estanciaMinima,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get porcentajePromocion => $state.composableBuilder(
      column: $state.table.porcentajePromocion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codeTarifa => $state.composableBuilder(
      column: $state.table.codeTarifa,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get forGroup => $state.composableBuilder(
      column: $state.table.forGroup,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tarifaJSON => $state.composableBuilder(
      column: $state.table.tarifaJSON,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter temporadaTarifaRefs(
      ComposableFilter Function($$TemporadaTarifaTableFilterComposer f) f) {
    final $$TemporadaTarifaTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.temporadaTarifa,
            getReferencedColumn: (t) => t.temporadaId,
            builder: (joinBuilder, parentComposers) =>
                $$TemporadaTarifaTableFilterComposer(ComposerState($state.db,
                    $state.db.temporadaTarifa, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$TemporadaTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TemporadaTable> {
  $$TemporadaTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get estanciaMinima => $state.composableBuilder(
      column: $state.table.estanciaMinima,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get porcentajePromocion => $state.composableBuilder(
      column: $state.table.porcentajePromocion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codeTarifa => $state.composableBuilder(
      column: $state.table.codeTarifa,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get forGroup => $state.composableBuilder(
      column: $state.table.forGroup,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tarifaJSON => $state.composableBuilder(
      column: $state.table.tarifaJSON,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TarifaBaseTableCreateCompanionBuilder = TarifaBaseCompanion Function({
  Value<int> id,
  Value<String?> code,
  Value<String?> nombre,
  Value<double?> descIntegrado,
  Value<double?> upgradeCategoria,
  Value<double?> upgradeMenor,
  Value<double?> upgradePaxAdic,
  Value<int?> tarifaPadreId,
});
typedef $$TarifaBaseTableUpdateCompanionBuilder = TarifaBaseCompanion Function({
  Value<int> id,
  Value<String?> code,
  Value<String?> nombre,
  Value<double?> descIntegrado,
  Value<double?> upgradeCategoria,
  Value<double?> upgradeMenor,
  Value<double?> upgradePaxAdic,
  Value<int?> tarifaPadreId,
});

class $$TarifaBaseTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarifaBaseTable,
    TarifaBaseData,
    $$TarifaBaseTableFilterComposer,
    $$TarifaBaseTableOrderingComposer,
    $$TarifaBaseTableCreateCompanionBuilder,
    $$TarifaBaseTableUpdateCompanionBuilder> {
  $$TarifaBaseTableTableManager(_$AppDatabase db, $TarifaBaseTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TarifaBaseTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TarifaBaseTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<double?> descIntegrado = const Value.absent(),
            Value<double?> upgradeCategoria = const Value.absent(),
            Value<double?> upgradeMenor = const Value.absent(),
            Value<double?> upgradePaxAdic = const Value.absent(),
            Value<int?> tarifaPadreId = const Value.absent(),
          }) =>
              TarifaBaseCompanion(
            id: id,
            code: code,
            nombre: nombre,
            descIntegrado: descIntegrado,
            upgradeCategoria: upgradeCategoria,
            upgradeMenor: upgradeMenor,
            upgradePaxAdic: upgradePaxAdic,
            tarifaPadreId: tarifaPadreId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<double?> descIntegrado = const Value.absent(),
            Value<double?> upgradeCategoria = const Value.absent(),
            Value<double?> upgradeMenor = const Value.absent(),
            Value<double?> upgradePaxAdic = const Value.absent(),
            Value<int?> tarifaPadreId = const Value.absent(),
          }) =>
              TarifaBaseCompanion.insert(
            id: id,
            code: code,
            nombre: nombre,
            descIntegrado: descIntegrado,
            upgradeCategoria: upgradeCategoria,
            upgradeMenor: upgradeMenor,
            upgradePaxAdic: upgradePaxAdic,
            tarifaPadreId: tarifaPadreId,
          ),
        ));
}

class $$TarifaBaseTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaBaseTable> {
  $$TarifaBaseTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get descIntegrado => $state.composableBuilder(
      column: $state.table.descIntegrado,
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

  $$TarifaBaseTableFilterComposer get tarifaPadreId {
    final $$TarifaBaseTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tarifaPadreId,
        referencedTable: $state.db.tarifaBase,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$TarifaBaseTableFilterComposer(ComposerState($state.db,
                $state.db.tarifaBase, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter tarifaRefs(
      ComposableFilter Function($$TarifaTableFilterComposer f) f) {
    final $$TarifaTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.tarifa,
        getReferencedColumn: (t) => t.tarifaPadreId,
        builder: (joinBuilder, parentComposers) => $$TarifaTableFilterComposer(
            ComposerState(
                $state.db, $state.db.tarifa, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$TarifaBaseTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaBaseTable> {
  $$TarifaBaseTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nombre => $state.composableBuilder(
      column: $state.table.nombre,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get descIntegrado => $state.composableBuilder(
      column: $state.table.descIntegrado,
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

  $$TarifaBaseTableOrderingComposer get tarifaPadreId {
    final $$TarifaBaseTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tarifaPadreId,
        referencedTable: $state.db.tarifaBase,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$TarifaBaseTableOrderingComposer(ComposerState($state.db,
                $state.db.tarifaBase, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$TarifaTableCreateCompanionBuilder = TarifaCompanion Function({
  Value<int> id,
  Value<String?> code,
  Value<DateTime?> fecha,
  Value<String?> categoria,
  Value<double?> tarifaAdultoSGLoDBL,
  Value<double?> tarifaAdultoTPL,
  Value<double?> tarifaAdultoCPLE,
  Value<double?> tarifaMenores7a12,
  Value<double?> tarifaPaxAdicional,
  Value<int?> tarifaPadreId,
});
typedef $$TarifaTableUpdateCompanionBuilder = TarifaCompanion Function({
  Value<int> id,
  Value<String?> code,
  Value<DateTime?> fecha,
  Value<String?> categoria,
  Value<double?> tarifaAdultoSGLoDBL,
  Value<double?> tarifaAdultoTPL,
  Value<double?> tarifaAdultoCPLE,
  Value<double?> tarifaMenores7a12,
  Value<double?> tarifaPaxAdicional,
  Value<int?> tarifaPadreId,
});

class $$TarifaTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarifaTable,
    TarifaData,
    $$TarifaTableFilterComposer,
    $$TarifaTableOrderingComposer,
    $$TarifaTableCreateCompanionBuilder,
    $$TarifaTableUpdateCompanionBuilder> {
  $$TarifaTableTableManager(_$AppDatabase db, $TarifaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TarifaTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TarifaTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<DateTime?> fecha = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
            Value<double?> tarifaAdultoSGLoDBL = const Value.absent(),
            Value<double?> tarifaAdultoTPL = const Value.absent(),
            Value<double?> tarifaAdultoCPLE = const Value.absent(),
            Value<double?> tarifaMenores7a12 = const Value.absent(),
            Value<double?> tarifaPaxAdicional = const Value.absent(),
            Value<int?> tarifaPadreId = const Value.absent(),
          }) =>
              TarifaCompanion(
            id: id,
            code: code,
            fecha: fecha,
            categoria: categoria,
            tarifaAdultoSGLoDBL: tarifaAdultoSGLoDBL,
            tarifaAdultoTPL: tarifaAdultoTPL,
            tarifaAdultoCPLE: tarifaAdultoCPLE,
            tarifaMenores7a12: tarifaMenores7a12,
            tarifaPaxAdicional: tarifaPaxAdicional,
            tarifaPadreId: tarifaPadreId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<DateTime?> fecha = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
            Value<double?> tarifaAdultoSGLoDBL = const Value.absent(),
            Value<double?> tarifaAdultoTPL = const Value.absent(),
            Value<double?> tarifaAdultoCPLE = const Value.absent(),
            Value<double?> tarifaMenores7a12 = const Value.absent(),
            Value<double?> tarifaPaxAdicional = const Value.absent(),
            Value<int?> tarifaPadreId = const Value.absent(),
          }) =>
              TarifaCompanion.insert(
            id: id,
            code: code,
            fecha: fecha,
            categoria: categoria,
            tarifaAdultoSGLoDBL: tarifaAdultoSGLoDBL,
            tarifaAdultoTPL: tarifaAdultoTPL,
            tarifaAdultoCPLE: tarifaAdultoCPLE,
            tarifaMenores7a12: tarifaMenores7a12,
            tarifaPaxAdicional: tarifaPaxAdicional,
            tarifaPadreId: tarifaPadreId,
          ),
        ));
}

class $$TarifaTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaTable> {
  $$TarifaTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get categoria => $state.composableBuilder(
      column: $state.table.categoria,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaAdultoSGLoDBL => $state.composableBuilder(
      column: $state.table.tarifaAdultoSGLoDBL,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaAdultoTPL => $state.composableBuilder(
      column: $state.table.tarifaAdultoTPL,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaAdultoCPLE => $state.composableBuilder(
      column: $state.table.tarifaAdultoCPLE,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaMenores7a12 => $state.composableBuilder(
      column: $state.table.tarifaMenores7a12,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tarifaPaxAdicional => $state.composableBuilder(
      column: $state.table.tarifaPaxAdicional,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$TarifaBaseTableFilterComposer get tarifaPadreId {
    final $$TarifaBaseTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tarifaPadreId,
        referencedTable: $state.db.tarifaBase,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$TarifaBaseTableFilterComposer(ComposerState($state.db,
                $state.db.tarifaBase, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter temporadaTarifaRefs(
      ComposableFilter Function($$TemporadaTarifaTableFilterComposer f) f) {
    final $$TemporadaTarifaTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.temporadaTarifa,
            getReferencedColumn: (t) => t.TarifaId,
            builder: (joinBuilder, parentComposers) =>
                $$TemporadaTarifaTableFilterComposer(ComposerState($state.db,
                    $state.db.temporadaTarifa, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$TarifaTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaTable> {
  $$TarifaTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get categoria => $state.composableBuilder(
      column: $state.table.categoria,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaAdultoSGLoDBL => $state.composableBuilder(
      column: $state.table.tarifaAdultoSGLoDBL,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaAdultoTPL => $state.composableBuilder(
      column: $state.table.tarifaAdultoTPL,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaAdultoCPLE => $state.composableBuilder(
      column: $state.table.tarifaAdultoCPLE,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaMenores7a12 => $state.composableBuilder(
      column: $state.table.tarifaMenores7a12,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tarifaPaxAdicional => $state.composableBuilder(
      column: $state.table.tarifaPaxAdicional,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$TarifaBaseTableOrderingComposer get tarifaPadreId {
    final $$TarifaBaseTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tarifaPadreId,
        referencedTable: $state.db.tarifaBase,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$TarifaBaseTableOrderingComposer(ComposerState($state.db,
                $state.db.tarifaBase, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$UserActivityTableCreateCompanionBuilder = UserActivityCompanion
    Function({
  Value<int> id,
  Value<DateTime?> fecha,
  Value<String?> name,
  Value<String?> category,
  Value<int?> status,
  Value<int?> userId,
});
typedef $$UserActivityTableUpdateCompanionBuilder = UserActivityCompanion
    Function({
  Value<int> id,
  Value<DateTime?> fecha,
  Value<String?> name,
  Value<String?> category,
  Value<int?> status,
  Value<int?> userId,
});

class $$UserActivityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserActivityTable,
    UserActivityData,
    $$UserActivityTableFilterComposer,
    $$UserActivityTableOrderingComposer,
    $$UserActivityTableCreateCompanionBuilder,
    $$UserActivityTableUpdateCompanionBuilder> {
  $$UserActivityTableTableManager(_$AppDatabase db, $UserActivityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UserActivityTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UserActivityTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> fecha = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<int?> status = const Value.absent(),
            Value<int?> userId = const Value.absent(),
          }) =>
              UserActivityCompanion(
            id: id,
            fecha: fecha,
            name: name,
            category: category,
            status: status,
            userId: userId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> fecha = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<int?> status = const Value.absent(),
            Value<int?> userId = const Value.absent(),
          }) =>
              UserActivityCompanion.insert(
            id: id,
            fecha: fecha,
            name: name,
            category: category,
            status: status,
            userId: userId,
          ),
        ));
}

class $$UserActivityTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UserActivityTable> {
  $$UserActivityTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$UsuarioTableFilterComposer get userId {
    final $$UsuarioTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $state.db.usuario,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$UsuarioTableFilterComposer(
            ComposerState(
                $state.db, $state.db.usuario, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$UserActivityTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UserActivityTable> {
  $$UserActivityTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$UsuarioTableOrderingComposer get userId {
    final $$UsuarioTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $state.db.usuario,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$UsuarioTableOrderingComposer(ComposerState(
                $state.db, $state.db.usuario, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$TarifaRackTableCreateCompanionBuilder = TarifaRackCompanion Function({
  Value<int> id,
  required String code,
  Value<DateTime?> fecha,
  Value<String?> nombreRack,
  Value<String?> colorIdentificacion,
  Value<String?> codeTemporada,
  Value<String?> codePeriodo,
  Value<int?> usuarioId,
});
typedef $$TarifaRackTableUpdateCompanionBuilder = TarifaRackCompanion Function({
  Value<int> id,
  Value<String> code,
  Value<DateTime?> fecha,
  Value<String?> nombreRack,
  Value<String?> colorIdentificacion,
  Value<String?> codeTemporada,
  Value<String?> codePeriodo,
  Value<int?> usuarioId,
});

class $$TarifaRackTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarifaRackTable,
    TarifaRackData,
    $$TarifaRackTableFilterComposer,
    $$TarifaRackTableOrderingComposer,
    $$TarifaRackTableCreateCompanionBuilder,
    $$TarifaRackTableUpdateCompanionBuilder> {
  $$TarifaRackTableTableManager(_$AppDatabase db, $TarifaRackTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TarifaRackTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TarifaRackTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<DateTime?> fecha = const Value.absent(),
            Value<String?> nombreRack = const Value.absent(),
            Value<String?> colorIdentificacion = const Value.absent(),
            Value<String?> codeTemporada = const Value.absent(),
            Value<String?> codePeriodo = const Value.absent(),
            Value<int?> usuarioId = const Value.absent(),
          }) =>
              TarifaRackCompanion(
            id: id,
            code: code,
            fecha: fecha,
            nombreRack: nombreRack,
            colorIdentificacion: colorIdentificacion,
            codeTemporada: codeTemporada,
            codePeriodo: codePeriodo,
            usuarioId: usuarioId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String code,
            Value<DateTime?> fecha = const Value.absent(),
            Value<String?> nombreRack = const Value.absent(),
            Value<String?> colorIdentificacion = const Value.absent(),
            Value<String?> codeTemporada = const Value.absent(),
            Value<String?> codePeriodo = const Value.absent(),
            Value<int?> usuarioId = const Value.absent(),
          }) =>
              TarifaRackCompanion.insert(
            id: id,
            code: code,
            fecha: fecha,
            nombreRack: nombreRack,
            colorIdentificacion: colorIdentificacion,
            codeTemporada: codeTemporada,
            codePeriodo: codePeriodo,
            usuarioId: usuarioId,
          ),
        ));
}

class $$TarifaRackTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarifaRackTable> {
  $$TarifaRackTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nombreRack => $state.composableBuilder(
      column: $state.table.nombreRack,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get colorIdentificacion => $state.composableBuilder(
      column: $state.table.colorIdentificacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codeTemporada => $state.composableBuilder(
      column: $state.table.codeTemporada,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codePeriodo => $state.composableBuilder(
      column: $state.table.codePeriodo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get usuarioId => $state.composableBuilder(
      column: $state.table.usuarioId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TarifaRackTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarifaRackTable> {
  $$TarifaRackTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fecha => $state.composableBuilder(
      column: $state.table.fecha,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nombreRack => $state.composableBuilder(
      column: $state.table.nombreRack,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get colorIdentificacion => $state.composableBuilder(
      column: $state.table.colorIdentificacion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codeTemporada => $state.composableBuilder(
      column: $state.table.codeTemporada,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codePeriodo => $state.composableBuilder(
      column: $state.table.codePeriodo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get usuarioId => $state.composableBuilder(
      column: $state.table.usuarioId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PoliticasTableCreateCompanionBuilder = PoliticasCompanion Function({
  Value<int> id,
  Value<DateTime?> fechaActualizacion,
  Value<int?> intervaloHabitacionGratuita,
  Value<int?> limiteHabitacionCotizacion,
});
typedef $$PoliticasTableUpdateCompanionBuilder = PoliticasCompanion Function({
  Value<int> id,
  Value<DateTime?> fechaActualizacion,
  Value<int?> intervaloHabitacionGratuita,
  Value<int?> limiteHabitacionCotizacion,
});

class $$PoliticasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PoliticasTable,
    Politica,
    $$PoliticasTableFilterComposer,
    $$PoliticasTableOrderingComposer,
    $$PoliticasTableCreateCompanionBuilder,
    $$PoliticasTableUpdateCompanionBuilder> {
  $$PoliticasTableTableManager(_$AppDatabase db, $PoliticasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PoliticasTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PoliticasTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> fechaActualizacion = const Value.absent(),
            Value<int?> intervaloHabitacionGratuita = const Value.absent(),
            Value<int?> limiteHabitacionCotizacion = const Value.absent(),
          }) =>
              PoliticasCompanion(
            id: id,
            fechaActualizacion: fechaActualizacion,
            intervaloHabitacionGratuita: intervaloHabitacionGratuita,
            limiteHabitacionCotizacion: limiteHabitacionCotizacion,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> fechaActualizacion = const Value.absent(),
            Value<int?> intervaloHabitacionGratuita = const Value.absent(),
            Value<int?> limiteHabitacionCotizacion = const Value.absent(),
          }) =>
              PoliticasCompanion.insert(
            id: id,
            fechaActualizacion: fechaActualizacion,
            intervaloHabitacionGratuita: intervaloHabitacionGratuita,
            limiteHabitacionCotizacion: limiteHabitacionCotizacion,
          ),
        ));
}

class $$PoliticasTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PoliticasTable> {
  $$PoliticasTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get fechaActualizacion => $state.composableBuilder(
      column: $state.table.fechaActualizacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get intervaloHabitacionGratuita =>
      $state.composableBuilder(
          column: $state.table.intervaloHabitacionGratuita,
          builder: (column, joinBuilders) =>
              ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get limiteHabitacionCotizacion => $state.composableBuilder(
      column: $state.table.limiteHabitacionCotizacion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$PoliticasTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PoliticasTable> {
  $$PoliticasTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get fechaActualizacion => $state.composableBuilder(
      column: $state.table.fechaActualizacion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get intervaloHabitacionGratuita =>
      $state.composableBuilder(
          column: $state.table.intervaloHabitacionGratuita,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get limiteHabitacionCotizacion =>
      $state.composableBuilder(
          column: $state.table.limiteHabitacionCotizacion,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TemporadaTarifaTableCreateCompanionBuilder = TemporadaTarifaCompanion
    Function({
  Value<int> id,
  Value<int?> temporadaId,
  Value<int?> TarifaId,
});
typedef $$TemporadaTarifaTableUpdateCompanionBuilder = TemporadaTarifaCompanion
    Function({
  Value<int> id,
  Value<int?> temporadaId,
  Value<int?> TarifaId,
});

class $$TemporadaTarifaTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TemporadaTarifaTable,
    TemporadaTarifaData,
    $$TemporadaTarifaTableFilterComposer,
    $$TemporadaTarifaTableOrderingComposer,
    $$TemporadaTarifaTableCreateCompanionBuilder,
    $$TemporadaTarifaTableUpdateCompanionBuilder> {
  $$TemporadaTarifaTableTableManager(
      _$AppDatabase db, $TemporadaTarifaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TemporadaTarifaTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TemporadaTarifaTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> temporadaId = const Value.absent(),
            Value<int?> TarifaId = const Value.absent(),
          }) =>
              TemporadaTarifaCompanion(
            id: id,
            temporadaId: temporadaId,
            TarifaId: TarifaId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> temporadaId = const Value.absent(),
            Value<int?> TarifaId = const Value.absent(),
          }) =>
              TemporadaTarifaCompanion.insert(
            id: id,
            temporadaId: temporadaId,
            TarifaId: TarifaId,
          ),
        ));
}

class $$TemporadaTarifaTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TemporadaTarifaTable> {
  $$TemporadaTarifaTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$TemporadaTableFilterComposer get temporadaId {
    final $$TemporadaTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.temporadaId,
        referencedTable: $state.db.temporada,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$TemporadaTableFilterComposer(ComposerState(
                $state.db, $state.db.temporada, joinBuilder, parentComposers)));
    return composer;
  }

  $$TarifaTableFilterComposer get TarifaId {
    final $$TarifaTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.TarifaId,
        referencedTable: $state.db.tarifa,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$TarifaTableFilterComposer(
            ComposerState(
                $state.db, $state.db.tarifa, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$TemporadaTarifaTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TemporadaTarifaTable> {
  $$TemporadaTarifaTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$TemporadaTableOrderingComposer get temporadaId {
    final $$TemporadaTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.temporadaId,
        referencedTable: $state.db.temporada,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$TemporadaTableOrderingComposer(ComposerState(
                $state.db, $state.db.temporada, joinBuilder, parentComposers)));
    return composer;
  }

  $$TarifaTableOrderingComposer get TarifaId {
    final $$TarifaTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.TarifaId,
        referencedTable: $state.db.tarifa,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$TarifaTableOrderingComposer(ComposerState(
                $state.db, $state.db.tarifa, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ImagesTableTableTableManager get imagesTable =>
      $$ImagesTableTableTableManager(_db, _db.imagesTable);
  $$UsuarioTableTableManager get usuario =>
      $$UsuarioTableTableManager(_db, _db.usuario);
  $$CotizacionTableTableManager get cotizacion =>
      $$CotizacionTableTableManager(_db, _db.cotizacion);
  $$HabitacionTableTableManager get habitacion =>
      $$HabitacionTableTableManager(_db, _db.habitacion);
  $$TarifaXDiaTableTableTableManager get tarifaXDiaTable =>
      $$TarifaXDiaTableTableTableManager(_db, _db.tarifaXDiaTable);
  $$PeriodoTableTableManager get periodo =>
      $$PeriodoTableTableManager(_db, _db.periodo);
  $$TemporadaTableTableManager get temporada =>
      $$TemporadaTableTableManager(_db, _db.temporada);
  $$TarifaBaseTableTableManager get tarifaBase =>
      $$TarifaBaseTableTableManager(_db, _db.tarifaBase);
  $$TarifaTableTableManager get tarifa =>
      $$TarifaTableTableManager(_db, _db.tarifa);
  $$UserActivityTableTableManager get userActivity =>
      $$UserActivityTableTableManager(_db, _db.userActivity);
  $$TarifaRackTableTableManager get tarifaRack =>
      $$TarifaRackTableTableManager(_db, _db.tarifaRack);
  $$PoliticasTableTableManager get politicas =>
      $$PoliticasTableTableManager(_db, _db.politicas);
  $$TemporadaTarifaTableTableManager get temporadaTarifa =>
      $$TemporadaTarifaTableTableManager(_db, _db.temporadaTarifa);
}
