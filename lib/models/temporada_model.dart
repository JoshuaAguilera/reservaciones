import 'tarifa_model.dart';

class Temporada {
  int? id;
  String? code;
  String? nombre;
  int? estanciaMinima;
  double? porcentajePromocion;
  List<Tarifa>? tarifa;
  bool? editable;
  bool? forGroup;

  Temporada({
    this.id,
    this.code,
    this.nombre,
    this.estanciaMinima,
    this.porcentajePromocion,
    this.tarifa,
    this.editable = true,
    this.forGroup = false,
  });
}
