import 'dart:convert';

import 'imagen_model.dart';

List<Usuario> UsuariosFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));
String UsuariosToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Usuario> ListUsuarioFromJson(List<dynamic> str) =>
    List<Usuario>.from(str.map((x) => Usuario.fromJson(x)));

Usuario UsuarioFromJson(String str) => Usuario.fromJson(json.decode(str));
String UsuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  int? id;
  String? userId;
  String? username;
  String? password;
  String? rol;
  String? estado;
  String? correoElectronico;
  String? telefono;
  DateTime? fechaNacimiento;
  String? nombre;
  String? apellido;
  Imagen? imagen;
  DateTime? createdAt;

  Usuario({
    this.id,
    this.userId,
    this.password,
    this.username,
    this.telefono,
    this.imagen,
    this.apellido,
    this.correoElectronico,
    this.estado,
    this.fechaNacimiento,
    this.nombre,
    this.rol,
    this.createdAt,
  });

  Usuario CopyWith({
    int? id,
    String? userId,
    String? username,
    String? password,
    String? rol,
    String? estado,
    String? correoElectronico,
    String? telefono,
    DateTime? fechaNacimiento,
    String? nombre,
    String? apellido,
    Imagen? imagen,
    DateTime? createAt,
  }) =>
      Usuario(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        username: username ?? this.username,
        password: password ?? this.password,
        rol: rol ?? this.rol,
        estado: estado ?? this.estado,
        correoElectronico: correoElectronico ?? this.correoElectronico,
        telefono: telefono ?? this.telefono,
        fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
        nombre: nombre ?? this.nombre,
        imagen: imagen ?? this.imagen,
        apellido: apellido ?? this.apellido,
        createdAt: createAt ?? this.createdAt,
      );

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json['_id'],
        username: json['username'],
        password: json['password'],
        rol: json['rol'],
        estado: json['estado'],
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
      "_id": id,
      "username": username,
      "password": password,
      "rol": rol,
      "estado": estado,
      "telefono": telefono,
      "correo_electronico": correoElectronico,
      "fecha_nacimiento": fechaNacimiento,
      "nombre": nombre,
      "apellido": apellido,
      "imagen": imagen,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
