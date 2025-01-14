import 'package:generador_formato/models/tarifa_model.dart';

class TarifaBaseInt {
  int? id;
  String? code;
  String? nombre;
  TarifaBaseInt? tarifaPadre;
  double? descIntegrado;
  double? upgradeCategoria;
  double? upgradeMenor;
  double? upgradePaxAdic;
  List<Tarifa>? tarifas;
  int? tarifaOrigenId;

  TarifaBaseInt({
    this.id,
    this.code,
    this.nombre,
    this.tarifaPadre,
    this.descIntegrado,
    this.upgradeCategoria,
    this.upgradeMenor,
    this.upgradePaxAdic,
    this.tarifas,
    this.tarifaOrigenId,
  });

  TarifaBaseInt copyWith({
    int? id,
    String? code,
    String? nombre,
    TarifaBaseInt? tarifaPadre,
    double? descIntegrado,
    double? upgradeCategoria,
    double? upgradeMenor,
    double? upgradePaxAdic,
    List<Tarifa>? tarifas,
    int? tarifaOrigenId,
  }) =>
      TarifaBaseInt(
        id: id ?? this.id,
        code: code ?? this.code,
        nombre: nombre ?? this.nombre,
        tarifaPadre: tarifaPadre ?? this.tarifaPadre,
        descIntegrado: descIntegrado ?? this.descIntegrado,
        upgradeCategoria: upgradeCategoria ?? this.upgradeCategoria,
        upgradeMenor: upgradeMenor ?? this.upgradeMenor,
        upgradePaxAdic: upgradePaxAdic ?? this.upgradePaxAdic,
        tarifas: tarifas ?? this.tarifas,
        tarifaOrigenId: tarifaOrigenId ?? this.tarifaOrigenId,
      );
}
