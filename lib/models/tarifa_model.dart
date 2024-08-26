class TarifaTemporada {
  int? id;
  String? fecha;
  String? code;
  String? categoria;
  double? porcentajeDescuento;
  int? estanciaMinima;
  double? tarifaAdulto1a2;
  double? tarifaAdulto3;
  double? tarifaAdulto4;
  double? tarifaMenores7a12;
  double? tarifaPaxAdicional;

  TarifaTemporada({
    this.id,
    this.fecha,
    this.code,
    this.categoria,
    this.porcentajeDescuento,
    this.estanciaMinima,
    this.tarifaAdulto1a2,
    this.tarifaAdulto3,
    this.tarifaAdulto4,
    this.tarifaMenores7a12,
    this.tarifaPaxAdicional,
  });
}
