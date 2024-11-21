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
  int? articuloId;
  int? articuloVarianteId;
  int? empresaId;
  int? sucursalId;
  String? claveArticulo;
  String? claveVariante;
  String? claveImagen;
  String? urlImagen;
  File? newImage;
  int? code;

  Imagen({
    this.id,
    this.articuloId,
    this.articuloVarianteId,
    this.empresaId,
    this.sucursalId,
    this.claveArticulo,
    this.claveVariante,
    this.claveImagen,
    this.urlImagen,
    this.newImage,
    this.code,
  });

  factory Imagen.fromJson(Map<String, dynamic> json) => Imagen(
        id: json['id'],
        articuloId: json['articulo_Id'],
        articuloVarianteId: json['articulo_Variante_Id'],
        empresaId: json['empresa_Id'],
        sucursalId: json['sucursal_Id'],
        claveArticulo: json['clave_Articulo'] ?? "",
        claveVariante: json['clave_Variante'] ?? "",
        claveImagen: json['clave_Imagen'] ?? "",
        urlImagen: json['urlImagen'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (articuloId != null) "articulo_Id": articuloId,
        if (articuloVarianteId != null)
          "articulo_Variante_Id": articuloVarianteId,
        // "empresa_Id": empresaId,
        if (sucursalId != null) "sucursal_Id": sucursalId,
        if (claveArticulo != null) "clave_Articulo": claveArticulo,
        if (claveVariante != null) "clave_Variante": claveVariante,
        if (claveImagen != null) "clave_Imagen": claveImagen,
        if (urlImagen != null) "urlImagen": urlImagen,
      };
}
