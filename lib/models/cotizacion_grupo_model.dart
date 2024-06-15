class CotizacionGrupo {
  int? id;
  int? pax;
  String? tipoHabitacion;
  String? plan;
  String? fechaEntrada;
  int? noches;
  int? adultos;
  int? menores7a12;
  double? tarifaNoche;
  double? subtotal;
  List<String>? habitaciones;

  CotizacionGrupo({
    this.id,
    this.pax,
    this.tipoHabitacion,
    this.plan,
    this.fechaEntrada,
    this.noches,
    this.adultos,
    this.menores7a12,
    this.tarifaNoche,
    this.subtotal,
    this.habitaciones,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "pax": pax,
        "categoria": tipoHabitacion,
        "plan": plan,
        "fechaEntrada": fechaEntrada,
        "noches": noches,
        "adultos": adultos,
        "menores7a12": menores7a12,
        "tarifaReal": tarifaNoche,
        "tarifaPreventa": subtotal,
        "habitaciones": habitaciones,
      };

  Map<String, dynamic> toMapUpdate() => {
        "pax": pax,
        "categoria": tipoHabitacion,
        "plan": plan,
        "fechaEntrada": fechaEntrada,
        "noches": noches,
        "adultos": adultos,
        "menores7a12": menores7a12,
        "tarifaReal": tarifaNoche,
        "tarifaPreventa": subtotal,
        "habitaciones": habitaciones,
      };
}
