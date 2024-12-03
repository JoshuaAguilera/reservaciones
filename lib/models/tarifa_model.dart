import 'dart:convert';

List<Tarifa> tarifasFromJson(String str) =>
    List<Tarifa>.from(json.decode(str).map((x) => Tarifa.fromJson(x)));

String tarifasToJson(List<Tarifa> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Tarifa> listTarifasFromJson(List<dynamic> list) =>
    List<Tarifa>.from(list.map((x) => Tarifa.fromJson(x)));

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'categoria': categoria,
      'fecha': fecha,
      'tarifaAdulto1a2': tarifaAdulto1a2,
      'tarifaAdulto3': tarifaAdulto3,
      'tarifaAdulto4': tarifaAdulto4,
      'tarifaMenores7a12': tarifaMenores7a12,
      'tarifaPaxAdicional': tarifaPaxAdicional,
      'tarifaBaseId': tarifaBaseId,
    };
  }

  factory Tarifa.fromJson(Map<String, dynamic> json) {
    return Tarifa(
      id: json['id'],
      code: json['code'],
      categoria: json['categoria'],
      fecha: json['fecha'] ?? DateTime.now().toString(),
      tarifaAdulto1a2: json['tarifaAdulto1a2'],
      tarifaAdulto3: json['tarifaAdulto3'],
      tarifaAdulto4: json['tarifaAdulto4'],
      tarifaMenores7a12: json['tarifaMenores7a12'],
      tarifaPaxAdicional: json['tarifaPaxAdicional'],
      tarifaBaseId: json['tarifaBaseId'],
    );
  }
}
