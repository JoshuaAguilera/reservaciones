class Tarifa {
  int? id;
  String? fecha;
  String? fechaInicio;
  String? fechaFin;
  String? tarifaRack;
  double? porcentajeDescuento;
  String? categoria;
  int? nivel;
  int? tarifaRealId;
  int? responsableId;

  Tarifa({
    this.id,
    this.fecha,
    this.fechaInicio,
    this.fechaFin,
    this.tarifaRack,
    this.porcentajeDescuento,
    this.categoria,
    this.nivel,
    this.tarifaRealId,
    this.responsableId,
  });
}

class TarifaReal {
  int? id;
  String? fecha;
  String? tipoHuesped;
  double? tarifaBase;

  TarifaReal({
    this.id,
    this.fecha,
    this.tipoHuesped,
    this.tarifaBase,
  });
}
