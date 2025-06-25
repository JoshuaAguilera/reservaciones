import 'dart:convert';

import 'cotizacion_model.dart';
import 'usuario_model.dart';

List<Reservacion> reservacionesFromJson(String str) => List<Reservacion>.from(
    json.decode(str).map((x) => Reservacion.fromJson(x)));

String reservacionesToJson(List<Reservacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Reservacion> listReservacionFromJson(List<dynamic> list) =>
    List<Reservacion>.from(list.map((x) => Reservacion.fromJson(x)));

Reservacion reservacionJson(String str) =>
    Reservacion.fromJson(json.decode(str));
String reservacionToJson(Reservacion data) => json.encode(data.toJson());

List<Brazalete> brazaletesFromJson(String str) =>
    List<Brazalete>.from(json.decode(str).map((x) => Brazalete.fromJson(x)));

String brazaletesToJson(List<Brazalete> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Brazalete> listBrazaletesFromJson(List<dynamic> list) =>
    List<Brazalete>.from(list.map((x) => Brazalete.fromJson(x)));

class Reservacion {
  int? idInt;
  String? id;
  String? sku;
  String? folio;
  DateTime? createdAt;
  String? estatus;
  Cotizacion? cotizacion;
  String? reservacionZabia;
  double? deposito;
  Usuario? creadoPor;
  List<Brazalete>? brazaletes;

  Reservacion({
    this.idInt,
    this.id,
    this.sku,
    this.folio,
    this.createdAt,
    this.estatus,
    this.cotizacion,
    this.reservacionZabia,
    this.deposito,
    this.creadoPor,
    this.brazaletes,
  });

  Reservacion copyWith({
    int? idInt,
    String? id,
    String? sku,
    String? folio,
    DateTime? createdAt,
    String? estatus,
    Cotizacion? cotizacion,
    String? reservacionZabia,
    double? deposito,
    Usuario? creadoPor,
    List<Brazalete>? brazaletes,
  }) =>
      Reservacion(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        sku: sku ?? this.sku,
        folio: folio ?? this.folio,
        estatus: estatus ?? this.estatus,
        cotizacion: cotizacion?.copyWith() ?? this.cotizacion?.copyWith(),
        reservacionZabia: reservacionZabia ?? this.reservacionZabia,
        deposito: deposito ?? this.deposito,
        creadoPor: creadoPor?.copyWith() ?? this.creadoPor?.copyWith(),
        createdAt: createdAt ?? this.createdAt,
        brazaletes: brazaletes ?? this.brazaletes,
      );

  factory Reservacion.fromJson(Map<String, dynamic> json) => Reservacion(
        id: json['id'],
        idInt: json['id_int'],
        cotizacion: json['cotizacion'],
        sku: json['sku'],
        folio: json['folio'],
        estatus: json['estatus'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at']),
        reservacionZabia: json['reservacion_zabia_id'],
        deposito: json['deposito'],
        creadoPor: json['creado_por'] != null
            ? Usuario.fromJson(json['creado_por'])
            : null,
        brazaletes: json['brazaletes'] != null
            ? json['brazaletes'] != '[]'
                ? listBrazaletesFromJson(json['brazaletes'])
                : List<Brazalete>.empty()
            : List<Brazalete>.empty(),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id": id,
      "id_int": idInt,
      "cotizacion_int": cotizacion?.idInt,
      "cotizacion": cotizacion?.id,
      "sku": sku,
      "folio": folio,
      "estatus": estatus,
      "descripcion": deposito,
      "reservacion_zabia_id": reservacionZabia,
      "deposito": deposito,
      "creado_por_int": creadoPor?.idInt,
      "creado_por": creadoPor?.id,
      "brazaletes": brazaletes,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}

class Brazalete {
  int? reservacionInt;
  String? reservacion;
  String? codigo;
  String? folioReservacion;

  Brazalete({
    this.reservacionInt,
    this.reservacion,
    this.codigo,
    this.folioReservacion,
  });

  Brazalete copyWith({
    int? reservacionIdInt,
    String? reservacionId,
    String? codigo,
    String? folioReservacion,
  }) =>
      Brazalete(
        reservacionInt: reservacionIdInt ?? this.reservacionInt,
        reservacion: reservacionId ?? this.reservacion,
        codigo: codigo ?? this.codigo,
        folioReservacion: folioReservacion ?? this.folioReservacion,
      );

  factory Brazalete.fromJson(Map<String, dynamic> json) => Brazalete(
        reservacionInt: json['reservacion_int'],
        reservacion: json['reservacion'],
        codigo: json['codigo'],
        folioReservacion: json['folio_reservacion'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "reservacion_int": reservacionInt,
      "reservacion": reservacion,
      "codigo": codigo,
      "folio_reservacion": folioReservacion,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
