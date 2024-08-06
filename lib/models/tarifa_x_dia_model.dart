class TarifaXDia {
  int? id;
  String? subfolio;
  int? dia;
  String? fecha;
  double? tarifaRealPaxAdic;
  double? tarifaPreventaPaxAdic;
  double? tarifaRealAdulto;
  double? tarifaPreventaAdulto;
  double? tarifaRealMenores7a12;
  double? tarifaPreventaMenores7a12;

  TarifaXDia({
    this.id,
    this.fecha,
    this.dia,
    this.subfolio,
    this.tarifaRealPaxAdic,
    this.tarifaPreventaAdulto,
    this.tarifaPreventaMenores7a12,
    this.tarifaPreventaPaxAdic,
    this.tarifaRealAdulto,
    this.tarifaRealMenores7a12,
  });

  Map<String, dynamic> toMap() => {
        "subfolio": subfolio,
        "dia": dia,
        "fecha": fecha,
        "tarifaRealPaxAdic": tarifaRealPaxAdic,
        "tarifaPreventaPaxAdic": tarifaPreventaPaxAdic,
        "tarifaRealAdulto": tarifaRealAdulto,
        "tarifaPreventaAdulto": tarifaPreventaAdulto,
        "tarifaRealMenores7a12": tarifaRealMenores7a12,
        "tarifaPreventaMenores7a12": tarifaPreventaMenores7a12,
      };

  Map<String, dynamic> toMapUpdate() => {
        "id": id,
        "fecha": fecha,
        "subfolio": subfolio,
        "dia": dia,
        "tarifaRealPaxAdic": tarifaRealPaxAdic,
        "tarifaPreventaPaxAdic": tarifaPreventaPaxAdic,
        "tarifaRealAdulto": tarifaRealAdulto,
        "tarifaPreventaAdulto": tarifaPreventaAdulto,
        "tarifaRealMenores7a12": tarifaRealMenores7a12,
        "tarifaPreventaMenores7a12": tarifaPreventaMenores7a12,
      };
}
