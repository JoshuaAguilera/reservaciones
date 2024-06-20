class CotizacionIndividual {
  int? id;
  String? categoria;
  String? plan;
  String? fechaEntrada;
  String? fechaSalida;
  int? adultos;
  int? menores0a6;
  int? menores7a12;
  double? tarifaRealAdulto;
  double? tarifaPreventaAdulto;
  double? tarifaRealMenor;
  double? tarifaPreventaMenor;

  CotizacionIndividual({
    this.id,
    this.categoria,
    this.plan,
    this.fechaEntrada,
    this.fechaSalida,
    this.adultos,
    this.menores0a6,
    this.menores7a12,
    this.tarifaRealAdulto,
    this.tarifaPreventaAdulto,
    this.tarifaPreventaMenor,
    this.tarifaRealMenor,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "categoria": categoria,
        "plan": plan,
        "fechaEntrada": fechaEntrada,
        "noches": fechaSalida,
        "adultos": adultos,
        "menores0a6": menores0a6,
        "menores7a12": menores7a12,
        "tarifaReal": tarifaRealAdulto,
        "tarifaPreventa": tarifaPreventaAdulto,
        "tarifaRealMenor": tarifaRealMenor,
        "tarifaPreventaMenor": tarifaPreventaMenor,
      };

  Map<String, dynamic> toMapUpdate() => {
        "categoria": categoria,
        "plan": plan,
        "fechaEntrada": fechaEntrada,
        "noches": fechaSalida,
        "adultos": adultos,
        "menores0a6": menores0a6,
        "menores7a12": menores7a12,
        "tarifaRealAdulto": tarifaRealAdulto,
        "tarifaPreventaAdulto": tarifaPreventaAdulto,
        "tarifaRealMenor": tarifaRealMenor,
        "tarifaPreventaMenor": tarifaPreventaMenor,
      };
}
