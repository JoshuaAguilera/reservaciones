import 'package:generador_formato/models/cotizacion_grupal_model.dart';

import 'cotizacion_model.dart';

class ComprobanteCotizacion {
  int? id;
  bool? esGrupal;
  String? nombre;
  String? telefono;
  String? correo;
  String? folioCuotas;
  String? fechaRegistro;
  double? tarifaDiaria;
  double? total;
  int? habitaciones;
  List<Cotizacion>? cotizacionesInd;
  List<CotizacionGrupal>? cotizacionesGrup;

  ComprobanteCotizacion({
    this.id,
    this.esGrupal,
    this.nombre,
    this.telefono,
    this.correo,
    this.cotizacionesInd,
    this.fechaRegistro,
    this.folioCuotas,
    this.tarifaDiaria,
    this.total,
    this.habitaciones,
    this.cotizacionesGrup,
  });

  //Pendiente diseñar tomap.tostring de cotizaciones
}
