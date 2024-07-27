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
  int? habitaciones;
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
    this.habitaciones,
  });

  //Pendiente diseñar tomap.tostring de cotizaciones
}
