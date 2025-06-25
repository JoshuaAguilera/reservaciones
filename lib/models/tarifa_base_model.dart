import 'dart:convert';

import 'tarifa_model.dart';
import 'usuario_model.dart';

List<TarifaBase> tarifaBasesFromJson(String str) =>
    List<TarifaBase>.from(json.decode(str).map((x) => TarifaBase.fromJson(x)));
String tarifaBasesToJson(List<TarifaBase> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<TarifaBase> listTarifaBaseFromJson(List<dynamic> str) =>
    List<TarifaBase>.from(str.map((x) => TarifaBase.fromJson(x)));

TarifaBase tarifaBaseFromJson(String str) =>
    TarifaBase.fromJson(json.decode(str));
String tarifaBaseToJson(TarifaBase data) => json.encode(data.toJson());

class TarifaBase {
  int? idInt;
  String? id;
  String? codigo;
  String? nombre;
  double? aumIntegrado;
  bool? conAutocalculacion;
  double? upgradeCategoria;
  double? upgradeMenor;
  double? upgradePaxAdic;
  List<Tarifa>? tarifas;
  TarifaBase? tarifaBase;
  Usuario? creadoPor;

  TarifaBase({
    this.idInt,
    this.id,
    this.codigo,
    this.nombre,
    this.conAutocalculacion,
    this.tarifaBase,
    this.aumIntegrado,
    this.upgradeCategoria,
    this.upgradeMenor,
    this.upgradePaxAdic,
    this.tarifas,
    this.creadoPor,
  });

  TarifaBase copyWith({
    int? idInt,
    String? id,
    String? codigo,
    String? nombre,
    bool? conAutocalculacion,
    TarifaBase? tarifaBase,
    double? aumIntegrado,
    double? upgradeCategoria,
    double? upgradeMenor,
    double? upgradePaxAdic,
    List<Tarifa>? tarifas,
    Usuario? creadoPor,
  }) =>
      TarifaBase(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        codigo: codigo ?? this.codigo,
        nombre: nombre ?? this.nombre,
        conAutocalculacion: conAutocalculacion ?? this.conAutocalculacion,
        tarifaBase: tarifaBase?.copyWith() ?? this.tarifaBase?.copyWith(),
        aumIntegrado: aumIntegrado ?? this.aumIntegrado,
        upgradeCategoria: upgradeCategoria ?? this.upgradeCategoria,
        upgradeMenor: upgradeMenor ?? this.upgradeMenor,
        upgradePaxAdic: upgradePaxAdic ?? this.upgradePaxAdic,
        tarifas: tarifas ?? this.tarifas,
        creadoPor: creadoPor?.copyWith() ?? this.creadoPor?.copyWith(),
      );

  factory TarifaBase.fromJson(Map<String, dynamic> json) => TarifaBase(
        idInt: json['id_int'],
        id: json['id'],
        nombre: json['nombre'],
        codigo: json['codigo'],
        aumIntegrado: json['aumento_integrado'],
        conAutocalculacion: json['con_autocalculacion'],
        upgradeCategoria: json['upgrade_categoria'],
        upgradeMenor: json['upgrade_menor'],
        upgradePaxAdic: json['upgrade_pax_adic'],
        tarifaBase: json['tarifa_base'] != null
            ? TarifaBase.fromJson(json['tarifa_base'])
            : null,
        creadoPor: json['creado_por'] != null
            ? Usuario.fromJson(json['creado_por'])
            : null,
        tarifas: json['tarifas'] != null
            ? json['tarifas'] != '[]'
                ? listTarifasFromJson(json['tarifas'])
                : List<Tarifa>.empty()
            : List<Tarifa>.empty(),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id_int": idInt,
      "id": id,
      "codigo": codigo,
      "nombre": nombre,
      "aumento_integrado": aumIntegrado,
      "con_autocalculacion": conAutocalculacion,
      "upgrade_categoria": upgradeCategoria,
      "upgrade_menor": upgradeMenor,
      "upgrade_pax_adic": upgradePaxAdic,
      "tarifa_base_int": tarifaBase?.idInt,
      "tarifa_base": tarifaBase?.id,
      "creado_por_int": creadoPor?.idInt,
      "creado_por": creadoPor?.id,
      "tarifas": tarifas,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
