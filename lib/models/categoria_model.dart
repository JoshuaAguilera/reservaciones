import 'dart:convert';
import 'dart:ui';

import '../res/helpers/colors_helpers.dart';
import 'tipo_habitacion_model.dart';
import 'usuario_model.dart';

List<Categoria> CategoriasFromJson(String str) =>
    List<Categoria>.from(json.decode(str).map((x) => Categoria.fromJson(x)));
String CategoriasToJson(List<Categoria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Categoria> ListCategoriaFromJson(List<dynamic> str) =>
    List<Categoria>.from(str.map((x) => Categoria.fromJson(x)));

Categoria CategoriaFromJson(String str) => Categoria.fromJson(json.decode(str));
String CategoriaToJson(Categoria data) => json.encode(data.toJson());

class Categoria {
  int? idInt;
  String? id;
  String? nombre;
  String? descripcion;
  Color? color;
  TipoHabitacion? tipoHabitacion;
  Usuario? creadoPor;
  bool isSelect;

  Categoria({
    this.idInt,
    this.id,
    this.nombre,
    this.descripcion,
    this.color,
    this.tipoHabitacion,
    this.creadoPor,
    this.isSelect = false,
  });

  Categoria copyWith({
    int? idInt,
    String? id,
    String? nombre,
    String? descripcion,
    Color? color,
    TipoHabitacion? tipoHabitacion,
    Usuario? creadoPor,
    bool isSelect = false,
  }) =>
      Categoria(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        color: color ?? this.color,
        tipoHabitacion:
            tipoHabitacion?.copyWith() ?? this.tipoHabitacion?.copyWith(),
        creadoPor: creadoPor?.copyWith() ?? this.creadoPor?.copyWith(),
        isSelect: isSelect,
      );

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      idInt: json['idInt'],
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      color: ColorsHelpers.colorFromJson(json['color']),
      tipoHabitacion: json['tipoHabitacion'] != null
          ? TipoHabitacion.fromJson(
              json['tipoHabitacion'],
            )
          : null,
      creadoPor: json['creadoPor'] != null
          ? Usuario.fromJson(
              json['creadoPor'],
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "idInt": idInt,
      "id": id,
      "nombre": nombre,
      "descripcion": descripcion,
      "color": color,
      "tipoHabitacionInt": tipoHabitacion?.idInt,
      "tipoHabitacion": tipoHabitacion?.id,
      "creadoPorInt": creadoPor?.idInt,
      "creadoPor": creadoPor?.id,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
