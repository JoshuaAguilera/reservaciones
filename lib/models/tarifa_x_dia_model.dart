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
      "idInt": idInt,
      "id": id,
      "tarifaRackInt": tarifaRack?.idInt,
      "tarifaRack": tarifaRack?.id,
      "descIntegrado": descIntegrado,
      "esLibre": esLibre,
      "temporadaJson": temporadaSelect,
      "periodoJson": periodoSelect,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }

  factory TarifaXDia.fromJson(Map<String, dynamic> json) {
    return TarifaXDia(
      idInt: json['id'],
      id: json['code'],
      esLibre: json['esLibre'],
      descIntegrado: json['descIntegrado'],
      tarifaRack: json['tarifaRackJson'] != null
          ? tarifaRackFromJson(json['tarifaRackJson'])
          : null,
      temporadaSelect: json['temporadaJson'] != null
          ? temporadaFromJson(json['temporadaJson'])
          : null,
      periodoSelect: json['periodoJson'] != null
          ? periodoFromJson(json['periodoJson'])
          : null,
    );
  }
}
