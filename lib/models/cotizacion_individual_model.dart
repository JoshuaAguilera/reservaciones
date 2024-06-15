class CotizacionIndividual {
  int? id;
  String? categoria;
  String? plan;
  String? fechaEntrada;
  int? noches;
  int? adultos;
  int? menores0a6;
  int? menores7a12;
  double? tarifaReal;
  double? tarifaPreventa;

  CotizacionIndividual({
    this.id,
    this.categoria,
    this.plan,
    this.fechaEntrada,
    this.noches,
    this.adultos,
    this.menores0a6,
    this.menores7a12,
    this.tarifaReal,
    this.tarifaPreventa,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "categoria": categoria,
        "plan": plan,
        "fechaEntrada": fechaEntrada,
        "noches": noches,
        "adultos": adultos,
        "menores0a6": menores0a6,
        "menores7a12": menores7a12,
        "tarifaReal": tarifaReal,
        "tarifaPreventa": tarifaPreventa,
      };

  Map<String, dynamic> toMapUpdate() => {
        "categoria": categoria,
        "plan": plan,
        "fechaEntrada": fechaEntrada,
        "noches": noches,
        "adultos": adultos,
        "menores0a6": menores0a6,
        "menores7a12": menores7a12,
        "tarifaReal": tarifaReal,
        "tarifaPreventa": tarifaPreventa,
      };
}
