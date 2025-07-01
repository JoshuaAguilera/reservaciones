import 'dart:convert';

List<Periodo> periodosFromJson(String str) =>
    List<Periodo>.from(json.decode(str).map((x) => Periodo.fromJson(x)));

String periodosToJson(List<Periodo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Periodo> listPeriodoFromJson(List<dynamic> list) =>
    List<Periodo>.from(list.map((x) => Periodo.fromJson(x)));

Periodo periodoFromJson(String str) => Periodo.fromJson(json.decode(str));
String periodoToJson(Periodo data) => json.encode(data.toJson());

List<String> candenasFromJson(List<dynamic> str) {
  return List<String>.from(str.map((x) => x.toString()));
}

class Periodo {
  int? idInt;
  String? id;
  DateTime? createdAt;
  DateTime? fechaInicial;
  DateTime? fechaFinal;
  List<String>? diasActivo;
  int? tarifaRackInt;
  String? tarifaRack;

  Periodo({
    this.idInt,
    this.id,
    this.createdAt,
    this.fechaInicial,
    this.fechaFinal,
    this.diasActivo,
    this.tarifaRackInt,
    this.tarifaRack,
  });

  Periodo copyWith({
    int? idInt,
    String? id,
    DateTime? createdAt,
    DateTime? fechaInicial,
    DateTime? fechaFinal,
    List<String>? diasActivo,
    int? tarifaRackInt,
    String? tarifaRack,
  }) =>
      Periodo(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        fechaInicial: fechaInicial ?? this.fechaInicial,
        fechaFinal: fechaFinal ?? this.fechaFinal,
        diasActivo: diasActivo ?? this.diasActivo,
        tarifaRack: tarifaRack ?? this.tarifaRack,
        tarifaRackInt: tarifaRackInt ?? this.tarifaRackInt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Periodo.fromJson(Map<String, dynamic> json) => Periodo(
        id: json['id'],
        idInt: json['id_int'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at']),
        fechaInicial: json['fecha_inicial'] == null
            ? null
            : DateTime.tryParse(json['fecha_inicial']),
        fechaFinal: json['fecha_final'] == null
            ? null
            : DateTime.tryParse(json['fecha_final']),
        diasActivo: json['dias_activo'] != null
            ? json['dias_activo'] != '[]'
                ? candenasFromJson(json['dias_activo'])
                : List<String>.empty()
            : List<String>.empty(),
        tarifaRack: json['tarifa_rack'],
        tarifaRackInt: json['tarifa_rack_int'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id": id,
      "id_int": idInt,
      "fecha_inicial": fechaInicial,
      "fecha_final": fechaFinal,
      "dias_activo": diasActivo,
      "tarifa_rack": tarifaRack,
      "tarifa_rack_int": tarifaRackInt,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
