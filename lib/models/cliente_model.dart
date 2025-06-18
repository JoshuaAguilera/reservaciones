import 'dart:convert';

List<Cliente> ClientesFromJson(String str) =>
    List<Cliente>.from(json.decode(str).map((x) => Cliente.fromJson(x)));
String ClientesToJson(List<Cliente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Cliente> ListClienteFromJson(List<dynamic> str) =>
    List<Cliente>.from(str.map((x) => Cliente.fromJson(x)));

Cliente ClienteFromJson(String str) => Cliente.fromJson(json.decode(str));
String ClienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
  int? id;
  String? nombre;
  String? apellido;
  String? numeroTelefonico;
  String? correoElectronico;
  String? nacionalidad;
  String? estado;
  String? ciudad;
  String? cp;
  String? notas;
  DateTime? createdAt;

  Cliente({
    this.id,
    this.nombre,
    this.apellido,
    this.numeroTelefonico,
    this.correoElectronico,
    this.nacionalidad,
    this.estado,
    this.ciudad,
    this.cp,
    this.notas,
    this.createdAt,
  });

  Cliente CopyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? numeroTelefonico,
    String? correoElectronico,
    String? nacionalidad,
    String? estado,
    String? ciudad,
    String? cp,
    String? notas,
    DateTime? createAt,
  }) =>
      Cliente(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        numeroTelefonico: numeroTelefonico ?? this.numeroTelefonico,
        correoElectronico: correoElectronico ?? this.nacionalidad,
        nacionalidad: nacionalidad ?? this.nacionalidad,
        estado: estado ?? this.estado,
        ciudad: ciudad ?? this.ciudad,
        cp: cp ?? this.cp,
        notas: notas ?? this.notas,
      );

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json['_id'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        numeroTelefonico: json['numero_telefonico'],
        correoElectronico: json['correo_electronico'],
        nacionalidad: json['nacionalidad'],
        estado: json['estado'],
        ciudad: json['ciudad'],
        cp: json['cp'],
        notas: json['notas'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "_id": id,
      "nombre": nombre,
      "apellido": apellido,
      "numero_telefonico": numeroTelefonico,
      "correo_electronico": correoElectronico,
      "nacionalidad": nacionalidad,
      "estado": estado,
      "ciudad": ciudad,
      "cp": cp,
      "notas": notas,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
