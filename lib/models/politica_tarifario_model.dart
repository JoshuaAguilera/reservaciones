import 'dart:convert';

import 'usuario_model.dart';

List<PoliticaTarifario> politicasFromJson(String str) =>
    List<PoliticaTarifario>.from(
        json.decode(str).map((x) => PoliticaTarifario.fromJson(x)));

String politicasToJson(List<PoliticaTarifario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<PoliticaTarifario> listPoliticaFromJson(List<dynamic> list) =>
    List<PoliticaTarifario>.from(
        list.map((x) => PoliticaTarifario.fromJson(x)));

PoliticaTarifario politicaJson(String str) =>
    PoliticaTarifario.fromJson(json.decode(str));
String politicaToJson(PoliticaTarifario data) => json.encode(data.toJson());

class PoliticaTarifario {
  int? idInt;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? clave;
  dynamic valor;
  String? descripcion;
  Usuario? creadoPor;

  PoliticaTarifario({
    this.idInt,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.clave,
    this.valor,
    this.descripcion,
    this.creadoPor,
  });

  PoliticaTarifario copyWith({
    int? idInt,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? clave,
    dynamic valor,
    String? descripcion,
    Usuario? creadoPor,
  }) =>
      PoliticaTarifario(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
        clave: clave ?? this.clave,
        valor: valor ?? this.valor,
        descripcion: descripcion ?? this.descripcion,
        creadoPor: creadoPor?.copyWith() ?? this.creadoPor?.copyWith(),
        createdAt: createdAt ?? this.createdAt,
      );

  factory PoliticaTarifario.fromJson(Map<String, dynamic> json) =>
      PoliticaTarifario(
        id: json['id'],
        idInt: json['id_int'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.tryParse(json['updated_at']),
        clave: json['clave'],
        descripcion: json['descripcion'],
        valor: json['valor'],
        creadoPor: json['creado_por'] != null
            ? Usuario.fromJson(json['creado_por'])
            : null,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id": id,
      "id_int": idInt,
      "updated_at": updatedAt,
      "clave": clave,
      "descripcion": descripcion,
      "valor": valor,
      "creado_por_int": creadoPor?.idInt,
      "creado_por": creadoPor?.id,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
