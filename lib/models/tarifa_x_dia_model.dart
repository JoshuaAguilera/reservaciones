import 'dart:convert';

import 'periodo_model.dart';
import 'tarifa_rack_model.dart';
import 'temporada_model.dart';

List<TarifaXDia> tarifasXDiaFromJson(String str) =>
    List<TarifaXDia>.from(json.decode(str).map((x) => TarifaXDia.fromJson(x)));

String tarifasXDiaToJson(List<TarifaXDia> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<TarifaXDia> listTarifasXDiaFromJson(List<dynamic> list) =>
    List<TarifaXDia>.from(list.map((x) => TarifaXDia.fromJson(x)));

TarifaXDia tarifaXDiaFromJson(String str) =>
    TarifaXDia.fromJson(json.decode(str));
String tarifaXDiaToJson(TarifaXDia data) => json.encode(data.toJson());

class TarifaXDia {
  int? idInt;
  String? id;
  double? descIntegrado;
  bool? modificado;
  bool? esLibre;
  TarifaRack? tarifaRack;
  Temporada? temporadaSelect;
  Periodo? periodoSelect;

  TarifaXDia({
    this.idInt,
    this.id,
    this.descIntegrado,
    this.esLibre,
    this.modificado = false,
    this.tarifaRack,
    this.temporadaSelect,
    this.periodoSelect,
  });

  TarifaXDia copyWith({
    int? idInt,
    String? id,
    double? descIntegrado,
    bool? modificado,
    bool? esLibre,
    TarifaRack? tarifaRack,
    String? tarifaRackJson,
    Temporada? temporadaSelect,
    Periodo? periodoSelect,
  }) =>
      TarifaXDia(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        descIntegrado: descIntegrado ?? this.descIntegrado,
        modificado: modificado ?? this.modificado,
        esLibre: esLibre ?? this.esLibre,
        tarifaRack: tarifaRack?.copyWith() ?? this.tarifaRack?.copyWith(),
        temporadaSelect:
            temporadaSelect?.copyWith() ?? this.temporadaSelect?.copyWith(),
        periodoSelect:
            periodoSelect?.copyWith() ?? this.periodoSelect?.copyWith(),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id_int": idInt,
      "id": id,
      "tarifa_rack_int": tarifaRack?.idInt,
      "tarifa_rack": tarifaRack?.id,
      "desc_integrado": descIntegrado,
      "es_libre": esLibre,
      "temporada_json": temporadaSelect,
      "periodo_json": periodoSelect,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }

  factory TarifaXDia.fromJson(Map<String, dynamic> json) {
    return TarifaXDia(
      idInt: json['id'],
      id: json['code'],
      esLibre: json['es_libre'],
      descIntegrado: json['desc_integrado'],
      tarifaRack: json['tarifa_rack_json'] != null
          ? tarifaRackFromJson(json['tarifa_rack_json'])
          : null,
      temporadaSelect: json['temporada_json'] != null
          ? temporadaFromJson(json['temporada_json'])
          : null,
      periodoSelect: json['periodo_json'] != null
          ? periodoFromJson(json['periodo_json'])
          : null,
    );
  }
}
