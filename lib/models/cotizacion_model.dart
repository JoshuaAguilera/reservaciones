import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';

class Cotizacion {
  int? id;
  String? folioPrincipal;
  String? nombreHuesped;
  String? numeroTelefonico;
  String? correoElectronico;
  String? tipo;
  String? fecha;
  int? responsableId;
  String? fechaLimite;
  bool? esGrupo;
  bool? esConcretado;
  List<Habitacion>? habitaciones;
  UsuarioData? autor;

  Cotizacion({
    this.id,
    this.esGrupo,
    this.nombreHuesped,
    this.numeroTelefonico,
    this.correoElectronico,
    this.fecha,
    this.fechaLimite,
    this.folioPrincipal,
    this.habitaciones,
    this.responsableId,
    this.tipo,
    this.esConcretado,
    this.autor,
  });

  Cotizacion CopyWith({
    int? id,
    String? folioPrincipal,
    String? nombreHuesped,
    String? numeroTelefonico,
    String? correoElectronico,
    String? tipo,
    String? fecha,
    int? responsableId,
    bool? esGrupo,
    bool? esConcretado,
    List<Habitacion>? habitaciones,
    UsuarioData? autor,
  }) =>
      Cotizacion(
        id: id ?? this.id,
        folioPrincipal: folioPrincipal ?? this.folioPrincipal,
        nombreHuesped: nombreHuesped ?? this.nombreHuesped,
        numeroTelefonico: numeroTelefonico ?? this.numeroTelefonico,
        correoElectronico: correoElectronico ?? this.correoElectronico,
        tipo: tipo ?? this.tipo,
        fecha: fecha ?? this.fecha,
        responsableId: responsableId ?? this.responsableId,
        esGrupo: esGrupo ?? this.esGrupo,
        esConcretado: esConcretado ?? this.esConcretado,
        habitaciones: habitaciones ?? this.habitaciones,
        fechaLimite: fechaLimite ?? this.fechaLimite,
        autor: autor ?? this.autor,
      );
}
