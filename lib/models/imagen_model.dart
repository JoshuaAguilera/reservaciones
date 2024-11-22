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
  int? id;
  int? usuarioId;
  String? urlImagen;
  File? newImage;
  int? code;

  Imagen({
    this.id,
    this.usuarioId,
    this.urlImagen,
    this.newImage,
    this.code,
  });

  factory Imagen.fromJson(Map<String, dynamic> json) => Imagen(
        id: json['id'],
        usuarioId: json['usuarioId'],
        urlImagen: json['urlImagen'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (usuarioId != null) "usuarioId": usuarioId,
        if (urlImagen != null) "urlImagen": urlImagen,
      };
}
