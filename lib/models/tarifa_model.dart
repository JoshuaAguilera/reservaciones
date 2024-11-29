class Tarifa {
  int? id;
  String? fecha;
  String? code;
  String? categoria;
  double? tarifaAdulto1a2;
  double? tarifaAdulto3;
  double? tarifaAdulto4;
  double? tarifaMenores7a12;
  double? tarifaPaxAdicional;
  int? tarifaBaseId;

  Tarifa({
    this.id,
    this.fecha,
    this.code,
    this.categoria,
    this.tarifaAdulto1a2,
    this.tarifaAdulto3,
    this.tarifaAdulto4,
    this.tarifaMenores7a12,
    this.tarifaPaxAdicional,
    this.tarifaBaseId,
  });

  Tarifa copyWith({
    int? id,
    String? fecha,
    String? code,
    String? categoria,
    double? tarifaAdulto1a2,
    double? tarifaAdulto3,
    double? tarifaAdulto4,
    double? tarifaMenores7a12,
    double? tarifaPaxAdicional,
    int? tarifaBaseId,
  }) =>
      Tarifa(
        id: id ?? this.id,
        code: code ?? this.code,
        categoria: categoria ?? this.categoria,
        fecha: fecha ?? this.fecha,
        tarifaAdulto1a2: tarifaAdulto1a2 ?? this.tarifaAdulto1a2,
        tarifaAdulto3: tarifaAdulto3 ?? this.tarifaAdulto3,
        tarifaAdulto4: tarifaAdulto4 ?? this.tarifaAdulto4,
        tarifaMenores7a12: tarifaMenores7a12 ?? this.tarifaMenores7a12,
        tarifaPaxAdicional: tarifaPaxAdicional ?? this.tarifaPaxAdicional,
        tarifaBaseId: tarifaBaseId ?? this.tarifaBaseId,
      );
}
