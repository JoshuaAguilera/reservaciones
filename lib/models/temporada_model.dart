import 'dart:convert';
import 'tarifa_model.dart';

List<Temporada> temporadasFromJson(String str) =>
    List<Temporada>.from(json.decode(str).map((x) => Temporada.fromJson(x)));

String temporadasToJson(List<Temporada> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Temporada> listTemporadaFromJson(List<dynamic> list) =>
    List<Temporada>.from(list.map((x) => Temporada.fromJson(x)));

class Temporada {
  int? id;
  String? code;
  String? nombre;
  DateTime? fecha;
  int? estanciaMinima;
  double? porcentajePromocion;
  String? codeTarifa;
  List<Tarifa>? tarifas;
  bool? editable;
  bool? forGroup;
  bool? forCash;
  bool? useTariff;

  Temporada({
    this.id,
    this.code,
    this.nombre,
    this.fecha,
    this.estanciaMinima,
    this.porcentajePromocion,
    this.tarifas,
    this.codeTarifa,
    this.editable = true,
    this.forGroup = false,
    this.forCash = false,
    this.useTariff = false,
  });

  Temporada copyWith({
    int? id,
    String? code,
    String? nombre,
    DateTime? fecha,
    int? estanciaMinima,
    double? porcentajePromocion,
    String? codeTarifa,
    List<Tarifa>? tarifas,
    bool? editable,
    bool? forGroup,
    bool? forCash,
    bool? useTariff,
  }) =>
      Temporada(
        id: id ?? this.id,
        code: code ?? this.code,
        nombre: nombre ?? this.nombre,
        fecha: fecha ?? this.fecha,
        estanciaMinima: estanciaMinima ?? this.estanciaMinima,
        porcentajePromocion: porcentajePromocion ?? this.porcentajePromocion,
        codeTarifa: codeTarifa ?? this.codeTarifa,
        tarifas: tarifas ?? this.tarifas,
        editable: editable ?? this.editable,
        forCash: forCash ?? this.forCash,
        forGroup: forGroup ?? this.forGroup,
        useTariff: useTariff ?? this.useTariff,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'tarifas': tarifas,
      'fecha': fecha != null ? fecha!.toIso8601String() : '',
    };
  }

  factory Temporada.fromJson(Map<String, dynamic> json) {
    return Temporada(
      id: json['id'],
      code: json['code'],
      tarifas: json['tarifas'] != null
          ? json['tarifas'] != '[]'
              ? listTarifasFromJson(json['tarifas'])
              : List<Tarifa>.empty()
          : List<Tarifa>.empty(),
      fecha: DateTime.parse(json['fecha'] ?? DateTime.now().toString()),
      nombre: json['nombre'],
      codeTarifa: json['codeTarifa'],
      editable: json['editable'],
      estanciaMinima: json['estanciaMinima'],
      forCash: json['forCash'],
      forGroup: json['forGroup'],
      porcentajePromocion: json['porcentajePromocion'],
      useTariff: json['useTariff'],
    );
  }
}
