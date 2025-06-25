import 'dart:convert';
import 'dart:io';

List<Imagen> ImagenesFromJson(String str) =>
    List<Imagen>.from(json.decode(str).map((x) => Imagen.fromJson(x)));
String ImagenesToJson(List<Imagen> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Imagen> ListImagenFromJson(List<dynamic> str) =>
    List<Imagen>.from(str.map((x) => Imagen.fromJson(x)));

Imagen ImagenJson(String str) => Imagen.fromJson(json.decode(str));
String ImagenToJson(Imagen data) => json.encode(data.toJson());

class Imagen {
  int? idInt;
  String? id;
  String? nombre;
  String? ruta;
  String? url;
  File? newImage;
  DateTime? createdAt;

  Imagen({
    this.idInt,
    this.id,
    this.nombre,
    this.ruta,
    this.url,
    this.newImage,
    this.createdAt,
  });

  Imagen copyWith({
    int? idInt,
    String? id,
    String? nombre,
    String? ruta,
    String? url,
    File? newImage,
    DateTime? createdAt,
  }) =>
      Imagen(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        ruta: ruta ?? this.ruta,
        url: url ?? this.url,
        newImage: newImage ?? this.newImage,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Imagen.fromJson(Map<String, dynamic> json) => Imagen(
        idInt: json['id'],
        nombre: json['nombre'],
        ruta: json['ruta'],
        url: json['url'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at']),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id": idInt,
      "nombre": nombre,
      "ruta": ruta,
      "url": url,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
