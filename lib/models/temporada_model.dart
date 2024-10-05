import 'tarifa_model.dart';

class Temporada {
  String? code;
  String? nombre;
  int? estanciaMinima;
  double? porcentajePromocion;
  List<TarifaTemporada>? tarifa;
  bool? editable;

  Temporada({
    this.code,
    this.nombre,
    this.estanciaMinima,
    this.porcentajePromocion,
    this.tarifa,
    this.editable = true,
  });
}
