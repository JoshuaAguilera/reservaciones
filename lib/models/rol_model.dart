import 'dart:convert';

import 'package:flutter/material.dart';

import '../res/helpers/colors_helpers.dart';
import 'permiso_model.dart';

List<Rol> rolesFromJson(String str) =>
    List<Rol>.from(json.decode(str).map((x) => Rol.fromJson(x)));
String rolesToJson(List<Rol> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Rol> listRolFromJson(List<dynamic> str) =>
    List<Rol>.from(str.map((x) => Rol.fromJson(x)));

Rol rolFromJson(String str) => Rol.fromJson(json.decode(str));
String rolToJson(Rol data) => json.encode(data.toJson());

class Rol {
  int? idInt;
  String? id;
  String? nombre;
  Color? color;
  String? descripcion;
  List<Permiso>? permisos;
  bool select = false;

  Rol({
    this.idInt,
    this.id,
    this.nombre,
    this.color,
    this.descripcion,
    this.permisos,
    this.select = false,
  });

  Rol copyWith({
    int? idInt,
    String? id,
    String? nombre,
    Color? color,
    String? descripcion,
    List<Permiso>? permisos,
    bool? select,
  }) =>
      Rol(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        color: color ?? this.color,
        descripcion: descripcion ?? this.descripcion,
        permisos: permisos ?? this.permisos,
        select: select ?? this.select,
      );

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        idInt: json['id_int'],
        id: json['id'],
        nombre: json['nombre'],
        color: ColorsHelpers.colorFromJson(json['color']),
        descripcion: json['descripcion'],
        permisos: json['permisos'] != null
            ? json['permisos'] != '[]'
                ? ListPermisoFromJson(json['permisos'])
                : List<Permiso>.empty()
            : List<Permiso>.empty(),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id_int": idInt,
      "id": id,
      "nombre": nombre,
      "color": ColorsHelpers.colorToJson(color),
      "descripcion": descripcion,
      "permisos": permisos,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
