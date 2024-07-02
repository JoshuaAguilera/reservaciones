class Cotizacion {
  int? id;
  bool? esGrupo;
  bool? esPreVenta;
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

  // Cotizacion grupo
  int? pax;
  String? tipoHabitacion;
  double? tarifaNoche;
  double? subtotal;
  List<String>? habitaciones;

  Cotizacion({
    this.id,
    this.esGrupo,
    this.esPreVenta,
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

    // Cotizacion grupo
    this.pax,
    this.tipoHabitacion,
    this.tarifaNoche,
    this.subtotal,
    this.habitaciones,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "esPreventa": esPreVenta,
        "esGrupo": esGrupo,
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

        // Cotizacion grupo
        "pax": pax,
        "tipoHabitacion": tipoHabitacion,
        "tarifaNoche": tarifaNoche,
        "subtotal": subtotal,
        "habitaciones": habitaciones,
      };

  Map<String, dynamic> toMapUpdate() => {
        "esPreventa": esPreVenta,
        "esGrupo": esGrupo,
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

        // Cotizacion grupo
        "pax": pax,
        "tipoHabitacion": tipoHabitacion,
        "tarifaNoche": tarifaNoche,
        "subtotal": subtotal,
        "habitaciones": habitaciones,
      };
}
