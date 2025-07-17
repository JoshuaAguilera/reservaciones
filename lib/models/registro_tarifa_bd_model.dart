import 'dart:convert';

import 'tarifa_model.dart';

List<RegistroTarifaBD> registroTarifasFromJson(String str) =>
    List<RegistroTarifaBD>.from(
        json.decode(str).map((x) => RegistroTarifaBD.fromJson(x)));
String registroTarifasToJson(List<RegistroTarifaBD> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<RegistroTarifaBD> listRegistroTarifaFromJson(List<dynamic> str) =>
    List<RegistroTarifaBD>.from(str.map((x) => RegistroTarifaBD.fromJson(x)));

RegistroTarifaBD registroTarifaFromJson(String str) =>
    RegistroTarifaBD.fromJson(json.decode(str));
String registroTarifaToJson(RegistroTarifaBD data) =>
    json.encode(data.toJson());

class RegistroTarifaBD {
  int? idInt;
  String? id;
  bool? esOriginal;
  Tarifa? tarifa;
  int? tarifaRackIdInt;
  String? tarifaRackId;

  RegistroTarifaBD({
    this.idInt,
    this.id,
    this.esOriginal = false,
    this.tarifa,
    this.tarifaRackIdInt,
    this.tarifaRackId,
  });

  RegistroTarifaBD copyWith({
    int? idInt,
    String? id,
    bool? esOriginal,
    Tarifa? tarifa,
    int? tarifaRackIdInt,
    String? tarifaRackId,
  }) =>
      RegistroTarifaBD(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        esOriginal: esOriginal ?? this.esOriginal,
        tarifa: tarifa?.copyWith() ?? this.tarifa?.copyWith(),
        tarifaRackIdInt: tarifaRackIdInt ?? this.tarifaRackIdInt,
        tarifaRackId: tarifaRackId ?? this.tarifaRackId,
      );

  RegistroTarifaBD.fromJson(Map<String, dynamic> json) {
    idInt = json['idInt'] as int?;
    id = json['id'] as String?;
    esOriginal = json['esOriginal'] as bool? ?? false;
    tarifa = json['tarifa'] != null ? Tarifa.fromJson(json['tarifa']) : null;
    tarifaRackIdInt = json['tarifaRackIdInt'] as int?;
    tarifaRackId = json['tarifaRackId'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'idInt': idInt,
      'id': id,
      'esOriginal': esOriginal,
      'tarifaIdInt': tarifa?.idInt,
      'tarifaId': tarifa?.id,
      'tarifaRackIdInt': tarifaRackIdInt,
      'tarifaRackId': tarifaRackId,
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}
