import 'dart:convert';

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
        idInt: json['id_int'],
        id: json['_id'],
        folio: json['folio'],
        cliente: json['cliente'] != null
            ? Cliente.fromJson(
                json['cliente'],
              )
            : null,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at']),
        fechaLimite: json['fecha_limite'] == null
            ? null
            : DateTime.tryParse(json['fecha_limite']),
        estatus: json['estatus'],
        esGrupo: json['es_grupo'],
        creadoPor: json['creado_por'] != null
            ? Usuario.fromJson(json['creado_por'])
            : null,
        cerradoPor: json['cerrado_por'] != null
            ? Usuario.fromJson(json['cerrado_por'])
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
      "id_int": idInt,
      "id": id,
      "folio": folio,
      "cliente": cliente?.id,
      "cliente_int": cliente?.idInt,
      "fecha_limite": fechaLimite,
      "estatus": estatus,
      "es_grupo": esGrupo,
      "creado_por": creadoPor?.id,
      "creado_por_int": creadoPor?.idInt,
      "cerrado_por": cerradoPor?.id,
      "cerrado_por_int": cerradoPor?.idInt,
      "comentarios": comentarios,
      "cotizacion": cotizacion?.id,
      "cotizacion_int": cotizacion?.idInt,
      "resumenes": resumenes,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
