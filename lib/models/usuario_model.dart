import 'dart:convert';

import '../res/helpers/date_helpers.dart';
import 'imagen_model.dart';
import 'rol_model.dart';

List<Usuario> usuariosFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));
String usuariosToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Usuario> listUsuarioFromJson(List<dynamic> str) =>
    List<Usuario>.from(str.map((x) => Usuario.fromJson(x)));

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));
String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  int? idInt;
  String? id;
  String? username;
  String? password;
  Rol? rol;
  String? estatus;
  String? correoElectronico;
  String? telefono;
  DateTime? fechaNacimiento;
  String? nombre;
  String? apellido;
  Imagen? imagen;
  DateTime? createdAt;
  bool select = false;

  Usuario({
    this.idInt,
    this.id,
    this.password,
    this.username,
    this.telefono,
    this.imagen,
    this.apellido,
    this.correoElectronico,
    this.estatus,
    this.fechaNacimiento,
    this.nombre,
    this.rol,
    this.createdAt,
    this.select = false,
  });

  bool compareID(Usuario? other) {
    if (other == null) return false;
    return id == other.id || idInt == other.idInt;
  }

  Usuario copyWith({
    int? idInt,
    String? id,
    String? username,
    String? password,
    Rol? rol,
    String? estatus,
    String? correoElectronico,
    String? telefono,
    DateTime? fechaNacimiento,
    String? nombre,
    String? apellido,
    Imagen? imagen,
    DateTime? createdAt,
    bool select = false,
  }) =>
      Usuario(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        rol: rol?.copyWith() ?? this.rol?.copyWith(),
        estatus: estatus ?? this.estatus,
        correoElectronico: correoElectronico ?? this.correoElectronico,
        telefono: telefono ?? this.telefono,
        fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
        nombre: nombre ?? this.nombre,
        imagen: imagen?.copyWith() ?? this.imagen?.copyWith(),
        apellido: apellido ?? this.apellido,
        createdAt: createdAt ?? this.createdAt,
        select: select,
      );

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idInt: json['idInt'],
        id: json['id'],
        username: json['username'],
        password: json['password'],
        rol: json['rol'] != null ? Rol.fromJson(json['rol']) : null,
        estatus: json['estatus'],
        telefono: json['telefono'],
        correoElectronico: json['correoElectronico'],
        fechaNacimiento: json['fechaNacimiento'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        imagen: json['imagen'] != null ? Imagen.fromJson(json['imagen']) : null,
        createdAt: DateValueFormat.fromJSON(json['createdAt']),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "idInt": idInt,
      "id": id,
      "username": username,
      "password": password,
      "rol": rol?.id,
      "rolInt": rol?.idInt,
      "estado": estatus,
      "telefono": telefono,
      "correoElectronico": correoElectronico,
      "fechaNacimiento": fechaNacimiento,
      "nombre": nombre,
      "apellido": apellido,
      "imagen": imagen?.id,
      "imagenInt": imagen?.idInt,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
