import 'cotizacion_model.dart';

class ComprobanteCotizacion {
  int? id;
  String? nombre;
  String? telefono;
  String? correo;
  String? folioCuotas;
  String? fechaRegistro;
  double? tarifaDiaria;
  double? total;
  List<Cotizacion>? cotizaciones;

  ComprobanteCotizacion({
    this.id,
    this.nombre,
    this.telefono,
    this.correo,
    this.cotizaciones,
    this.fechaRegistro,
    this.folioCuotas,
    this.tarifaDiaria,
    this.total,
  });

  //Pendiente diseñar tomap.tostring de cotizaciones
}
