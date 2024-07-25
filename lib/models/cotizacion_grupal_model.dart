class CotizacionGrupal {
  int? id;
  bool? esPreVenta;
  String? categoria;
  String? plan;
  String? fechaEntrada;
  String? fechaSalida;
  double? tarifaAdulto1_2;
  double? tarifaAdulto3;
  double? tarifaAdulto4;
  double? tarifaMenor;

  CotizacionGrupal({
    this.id,
    this.esPreVenta,
    this.categoria,
    this.plan,
    this.fechaEntrada,
    this.fechaSalida,
    this.tarifaAdulto1_2,
    this.tarifaAdulto3,
    this.tarifaMenor,
    this.tarifaAdulto4,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "esPreventa": esPreVenta,
        "categoria": categoria,
        "plan": plan,
        "fechaEntrada": fechaEntrada,
        "noches": fechaSalida,
        "tarifaReal": tarifaAdulto1_2,
        "tarifaPreventa": tarifaAdulto3,
        "tarifaRealMenor": tarifaAdulto4,
        "tarifaPreventaMenor": tarifaMenor,
      };

  Map<String, dynamic> toMapUpdate() => {
        "esPreventa": esPreVenta,
        "categoria": categoria,
        "plan": plan,
        "fechaEntrada": fechaEntrada,
        "noches": fechaSalida,
        "tarifaRealAdulto": tarifaAdulto1_2,
        "tarifaPreventaAdulto": tarifaAdulto3,
        "tarifaRealMenor": tarifaAdulto4,
        "tarifaPreventaMenor": tarifaMenor,
      };
}
