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

  Categoria({
    this.idInt,
    this.id,
    this.nombre,
    this.descripcion,
    this.color,
    this.tipoHabitacion,
    this.creadoPor,
  });

  Categoria copyWith({
    int? idInt,
    String? id,
    String? nombre,
    String? descripcion,
    Color? color,
    TipoHabitacion? tipoHabitacion,
    Usuario? creadoPor,
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
      );

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      idInt: json['id_int'],
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      color: ColorsHelpers.colorFromJson(json['color']),
      tipoHabitacion: json['tipo_habitacion'] != null
          ? TipoHabitacion.fromJson(
              json['tipo_habitacion'],
            )
          : null,
      creadoPor: json['creado_por'] != null
          ? Usuario.fromJson(
              json['creado_por'],
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id_int": idInt,
      "id": id,
      "nombre": nombre,
      "descripcion": descripcion,
      "color": color,
      "tipo_habitacion_int": tipoHabitacion?.idInt,
      "tipo_habitacion": tipoHabitacion?.id,
      "creado_por_int": creadoPor?.idInt,
      "creado_por": creadoPor?.id,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
