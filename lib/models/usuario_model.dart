import 'dart:convert';

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
  });

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
      );

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idInt: json['id_int'],
        id: json['id'],
        username: json['username'],
        password: json['password'],
        rol: json['rol'] != null ? Rol.fromJson(json['rol']) : null,
        estatus: json['estatus'],
        telefono: json['telefono'],
        correoElectronico: json['correo_electronico'],
        fechaNacimiento: json['fecha_nacimiento'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        imagen: json['imagen'] != null ? Imagen.fromJson(json['imagen']) : null,
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id_int": idInt,
      "id": id,
      "username": username,
      "password": password,
      "rol": rol?.id,
      "rol_int": rol?.idInt,
      "estado": estatus,
      "telefono": telefono,
      "correo_electronico": correoElectronico,
      "fecha_nacimiento": fechaNacimiento,
      "nombre": nombre,
      "apellido": apellido,
      "imagen": imagen?.id,
      "imagen_int": imagen?.idInt,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
