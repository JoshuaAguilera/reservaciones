import 'dart:convert';

import '../res/helpers/date_helpers.dart';

List<Cliente> ClientesFromJson(String str) =>
    List<Cliente>.from(json.decode(str).map((x) => Cliente.fromJson(x)));
String ClientesToJson(List<Cliente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Cliente> ListClienteFromJson(List<dynamic> str) =>
    List<Cliente>.from(str.map((x) => Cliente.fromJson(x)));

Cliente ClienteFromJson(String str) => Cliente.fromJson(json.decode(str));
String ClienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
  int? idInt;
  String? id;
  String? nombres;
  String? apellidos;
  String? numeroTelefonico;
  String? correoElectronico;
  String? pais;
  String? estado;
  String? ciudad;
  String? direccion;
  String? notas;
  DateTime? createdAt;

  Cliente({
    this.idInt,
    this.id,
    this.nombres,
    this.apellidos,
    this.numeroTelefonico,
    this.correoElectronico,
    this.pais,
    this.estado,
    this.ciudad,
    this.direccion,
    this.notas,
    this.createdAt,
  });

  Cliente copyWith({
    int? idInt,
    String? id,
    String? nombres,
    String? apellidos,
    String? numeroTelefonico,
    String? correoElectronico,
    String? pais,
    String? estado,
    String? ciudad,
    String? direccion,
    String? notas,
    DateTime? createdAt,
  }) =>
      Cliente(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        nombres: nombres ?? this.nombres,
        apellidos: apellidos ?? this.apellidos,
        numeroTelefonico: numeroTelefonico ?? this.numeroTelefonico,
        correoElectronico: correoElectronico ?? this.pais,
        pais: pais ?? this.pais,
        estado: estado ?? this.estado,
        ciudad: ciudad ?? this.ciudad,
        direccion: direccion ?? this.direccion,
        notas: notas ?? this.notas,
        createdAt: createdAt ?? this.createdAt,
      );

  String get fullName {
    return '${nombres ?? ''} ${apellidos ?? ''}'.trim();
  }

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        idInt: json['idInt'],
        id: json['_id'],
        nombres: json['nombres'],
        apellidos: json['apellidos'],
        numeroTelefonico: json['numeroTelefonico'],
        correoElectronico: json['correoElectronico'],
        pais: json['pais'],
        estado: json['estado'],
        ciudad: json['ciudad'],
        direccion: json['direccion'],
        notas: json['notas'],
        createdAt: DateValueFormat.fromJSON(json['createdAt']),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "idInt": idInt,
      "id": id,
      "nombres": nombres,
      "apellidos": apellidos,
      "numeroTelefonico": numeroTelefonico,
      "correoElectronico": correoElectronico,
      "pais": pais,
      "estado": estado,
      "ciudad": ciudad,
      "direccion": direccion,
      "notas": notas,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
