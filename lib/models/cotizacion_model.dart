import 'package:generador_formato/models/habitacion_model.dart';

class Cotizacion {
  int? id;
  String? folioPrincipal;
  String? nombreHuesped;
  String? numeroTelefonico;
  String? correoElectronico;
  String? tipo;
  String? fecha;
  int? responsableId;
  double? total;
  double? descuento;
  bool? esGrupo;
  bool? esConcretado;
  List<Habitacion>? habitaciones;

  Cotizacion({
    this.id,
    this.esGrupo,
    this.nombreHuesped,
    this.numeroTelefonico,
    this.correoElectronico,
    this.fecha,
    this.folioPrincipal,
    this.descuento,
    this.total,
    this.habitaciones,
    this.responsableId,
    this.tipo,
    this.esConcretado,
  });
}
