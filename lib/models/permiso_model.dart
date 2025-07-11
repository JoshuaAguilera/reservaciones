import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:animated_custom_dropdown/custom_dropdown.dart';

List<Permiso> PermisosFromJson(String str) =>
    List<Permiso>.from(json.decode(str).map((x) => Permiso.fromJson(x)));
String PermisosToJson(List<Permiso> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Permiso> ListPermisoFromJson(List<dynamic> str) =>
    List<Permiso>.from(str.map((x) => Permiso.fromJson(x)));

Permiso PermisoFromJson(String str) => Permiso.fromJson(json.decode(str));
String PermisoToJson(Permiso data) => json.encode(data.toJson());

class Permiso with CustomDropdownListFilter {
  String? id;
  String? resource;
  String? action;
  String? description;
  bool? isLocal;
  bool? isDefault;
  bool select;

  Permiso({
    this.id,
    this.resource,
    this.action,
    this.description,
    this.isLocal,
    this.isDefault,
    this.select = false,
  });

  @override
  String toString() {
    return description ?? '';
  }

  Permiso copyWith({
    String? id,
    String? nombre,
    String? valor,
    String? description,
    bool? isLocal,
    bool? isDefault,
    bool isSelect = false,
  }) =>
      Permiso(
        id: id ?? this.id,
        resource: nombre ?? this.resource,
        action: valor ?? this.action,
        description: description ?? this.description,
        isLocal: isLocal ?? this.isLocal,
        isDefault: isDefault ?? this.isDefault,
        select: isSelect,
      );

  factory Permiso.fromJson(Map<String, dynamic> json) => Permiso(
        id: json['id'],
        resource: json['resource'],
        action: json['action'],
        description: json['description'],
        isLocal: json["isLocal"],
        isDefault: json["isDefault"],
      );

  @override
  bool filter(String query) {
    return resource!.toLowerCase().contains(query.toLowerCase());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id": id,
      "resource": resource,
      "action": action,
      "description": description,
      "isLocal": isLocal,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}

class Permission {
  static final Permission _instance = Permission._internal();

  factory Permission() {
    return _instance;
  }

  Permission._internal();

  late List<Permiso> _permisos;

  Future<void> cargarPermisos() async {
    String jsonString = await rootBundle.loadString('assets/file/permisos.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    List<Permiso> permisos = jsonList.map((e) => Permiso.fromJson(e)).toList();

    _permisos = permisos;
  }

  List<Permiso> get permisos => _permisos;

  Permiso getPermiso({
    String id = "",
    String recurso = "",
    String descripcion = "",
  }) {
    return _permisos.firstWhere(
      (element) {
        if (id.isNotEmpty) {
          return element.id == id;
        } else if (recurso.isNotEmpty) {
          return element.resource == recurso;
        } else if (descripcion.isNotEmpty) {
          return element.description == descripcion;
        }
        return false;
      },
      orElse: () => Permiso(
        id: "0",
        resource: "No encontrado",
        action: "No encontrado",
        description: "No encontrado",
        isLocal: false,
        isDefault: false,
      ),
    );
  }
}
