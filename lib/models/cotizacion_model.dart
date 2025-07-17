import 'dart:convert';

import '../res/helpers/date_helpers.dart';
import 'cliente_model.dart';
import 'habitacion_model.dart';
import 'resumen_operacion_model.dart';
import 'usuario_model.dart';

List<Cotizacion> cotizacionesFromJson(String str) =>
    List<Cotizacion>.from(json.decode(str).map((x) => Cotizacion.fromJson(x)));

String cotizacionesToJson(List<Cotizacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Cotizacion> listCotizacionFromJson(List<dynamic> list) =>
    List<Cotizacion>.from(list.map((x) => Cotizacion.fromJson(x)));

Cotizacion cotizacionJson(String str) => Cotizacion.fromJson(json.decode(str));
String cotizacionToJson(Cotizacion data) => json.encode(data.toJson());

class Cotizacion {
  int? idInt;
  String? id;
  String? folio;
  Cliente? cliente;
  DateTime? createdAt;
  DateTime? fechaLimite;
  String? estatus;
  bool? esGrupo;
  Usuario? creadoPor;
  Usuario? cerradoPor;
  String? comentarios;
  Cotizacion? cotizacion;
  List<Habitacion>? habitaciones;
  List<ResumenOperacion>? resumenes;
  bool select;

  Cotizacion({
    this.idInt,
    this.id,
    this.folio,
    this.cliente,
    this.createdAt,
    this.fechaLimite,
    this.esGrupo,
    this.habitaciones,
    this.creadoPor,
    this.cerradoPor,
    this.estatus,
    this.comentarios,
    this.cotizacion,
    this.resumenes,
    this.select = false,
  });

  Cotizacion copyWith({
    int? idInt,
    String? id,
    String? folio,
    DateTime? createdAt,
    DateTime? fechaLimite,
    bool? esGrupo,
    String? estatus,
    List<Habitacion>? habitaciones,
    Usuario? creadoPor,
    Usuario? cerradoPor,
    Cliente? cliente,
    String? comentarios,
    Cotizacion? cotizacion,
    List<ResumenOperacion>? resumenes,
    bool? selected,
  }) =>
      Cotizacion(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        folio: folio ?? this.folio,
        createdAt: createdAt ?? this.createdAt,
        esGrupo: esGrupo ?? this.esGrupo,
        estatus: estatus ?? this.estatus,
        habitaciones: (habitaciones ?? this.habitaciones)
            ?.map((e) => e.copyWith())
            .toList(),
        fechaLimite: fechaLimite ?? this.fechaLimite,
        creadoPor: creadoPor?.copyWith() ?? this.creadoPor?.copyWith(),
        cerradoPor: cerradoPor?.copyWith() ?? this.cerradoPor?.copyWith(),
        cliente: cliente?.copyWith(),
        resumenes:
            (resumenes ?? this.resumenes)?.map((e) => e.copyWith()).toList(),
        select: selected ?? this.select,
      );

  factory Cotizacion.fromJson(Map<String, dynamic> json) => Cotizacion(
        idInt: json['idInt'],
        id: json['_id'],
        folio: json['folio'],
        cliente: json['cliente'] != null
            ? Cliente.fromJson(
                json['cliente'],
              )
            : null,
        createdAt: DateValueFormat.fromJSON(json['createdAt']),
        fechaLimite: DateValueFormat.fromJSON(json['fechaLimite']),
        estatus: json['estatus'],
        esGrupo: json['esGrupo'],
        creadoPor: json['creadoPor'] != null
            ? Usuario.fromJson(json['creadoPor'])
            : null,
        cerradoPor: json['cerradoPor'] != null
            ? Usuario.fromJson(json['cerradoPor'])
            : null,
        comentarios: json['comentarios'],
        cotizacion: (json['cotizacion']) != null
            ? Cotizacion.fromJson(json['cotizacion'])
            : null,
        resumenes: json['resumenes'] != null
            ? json['resumenes'] != '[]'
                ? listResumenHabitacionFromJson(json['resumenes'])
                : List<ResumenOperacion>.empty()
            : List<ResumenOperacion>.empty(),
        habitaciones: json['habitaciones'] != null
            ? json['habitaciones'] != '[]'
                ? listHabitacionFromJson(json['habitaciones'])
                : List<Habitacion>.empty()
            : List<Habitacion>.empty(),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "idInt": idInt,
      "id": id,
      "folio": folio,
      "cliente": cliente?.id,
      "clienteInt": cliente?.idInt,
      "fechaLimite": fechaLimite,
      "estatus": estatus,
      "esGrupo": esGrupo,
      "creadoPor": creadoPor?.id,
      "creadoPorInt": creadoPor?.idInt,
      "cerradoPor": cerradoPor?.id,
      "cerradoPorInt": cerradoPor?.idInt,
      "comentarios": comentarios,
      "cotizacion": cotizacion?.id,
      "cotizacionInt": cotizacion?.idInt,
      "resumenes": resumenes,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
