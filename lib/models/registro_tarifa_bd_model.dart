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
    idInt = json['id_int'] as int?;
    id = json['id'] as String?;
    esOriginal = json['es_original'] as bool? ?? false;
    tarifa = json['tarifa'] != null ? Tarifa.fromJson(json['tarifa']) : null;
    tarifaRackIdInt = json['tarifa_rack_id_int'] as int?;
    tarifaRackId = json['tarifa_rack_id'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id_int': idInt,
      'id': id,
      'es_original': esOriginal,
      'tarifa_id_int': tarifa?.idInt,
      'tarifa_id': tarifa?.id,
      'tarifa_rack_id_int': tarifaRackIdInt,
      'tarifa_rack_id': tarifaRackId,
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}
