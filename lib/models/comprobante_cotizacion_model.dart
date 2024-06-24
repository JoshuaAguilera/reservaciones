import 'cotizacion_model.dart';

class ComprobanteCotizacion {
  int? id;
  String? nombre;
  String? telefono;
  String? correo;
  List<Cotizacion>? cotizaciones;

  ComprobanteCotizacion({
    this.id,
    this.nombre,
    this.telefono,
    this.correo,
    this.cotizaciones,
  });

  //Pendiente diseñar tomap.tostring de cotizaciones
}
