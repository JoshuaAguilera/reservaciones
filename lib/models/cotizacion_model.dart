import 'cliente_model.dart';
import 'habitacion_model.dart';
import 'usuario_model.dart';

class Cotizacion {
  int? idInt;
  String? id;
  String? cotId;
  String? folio;
  Cliente? cliente;
  DateTime? createdAt;
  DateTime? fechaLimite;
  String? estatus;
  bool? esGrupo;
  Usuario? creadoPor;
  Usuario? cerradoPor;
  double? subtotal;
  double? descuento;
  double? impuestos;
  double? total;
  String? comentarios;
  Cotizacion? cotizacion;
  List<Habitacion>? habitaciones;

  Cotizacion({
    this.idInt,
    this.id,
    this.cotId,
    this.folio,
    this.cliente,
    this.createdAt,
    this.fechaLimite,
    this.esGrupo,
    this.habitaciones,
    this.creadoPor,
    this.cerradoPor,
    this.estatus,
    this.subtotal,
    this.descuento,
    this.impuestos,
    this.total,
    this.comentarios,
    this.cotizacion,
  });

  Cotizacion CopyWith({
    int? id,
    String? cotId,
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
    Cotizacion? cotizacionOrigenId,
  }) =>
      Cotizacion(
        idInt: id ?? this.idInt,
        cotId: cotId ?? this.cotId,
        folio: folio ?? this.folio,
        createdAt: createdAt ?? this.createdAt,
        esGrupo: esGrupo ?? this.esGrupo,
        estatus: estatus ?? this.estatus,
        habitaciones: habitaciones ?? this.habitaciones,
        fechaLimite: fechaLimite ?? this.fechaLimite,
        creadoPor: creadoPor ?? this.creadoPor,
        cerradoPor: cerradoPor ?? this.cerradoPor,
        cliente: cliente,
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
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.tryParse(json['createdAt']),
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
        subtotal: json['subtotal'],
        descuento: json['descuento'],
        impuestos: json['impuestos'],
        total: json['total'],
        comentarios: json['comentarios'],
        cotizacion: (json['cotizacion']) != null
            ? Cotizacion.fromJson(json['cotizacion'])
            : null,
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
      "subtotal": subtotal,
      "descuento": descuento,
      "impuestos": impuestos,
      "total": total,
      "comentarios": comentarios,
      "cotizacion": cotizacion?.id,
      "cotizacion_int": cotizacion?.idInt,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
