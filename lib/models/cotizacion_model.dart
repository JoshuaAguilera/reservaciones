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
  double? total;
  double? totalReal;
  double? descuento;
  bool? esGrupo;
  bool? esConcretado;
  List<Habitacion>? habitaciones;

  Cotizacion({
    this.id,
    this.esGrupo,
    this.nombreHuesped,
    this.numeroTelefonico,
    this.correoElectronico,
    this.fecha,
    this.folioPrincipal,
    this.descuento,
    this.totalReal,
    this.total,
    this.habitaciones,
    this.responsableId,
    this.tipo,
    this.esConcretado,
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
    double? total,
    double? totalReal,
    double? descuento,
    bool? esGrupo,
    bool? esConcretado,
    List<Habitacion>? habitaciones,
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
        total: total ?? this.total,
        totalReal: totalReal ?? this.totalReal,
        descuento: descuento ?? this.descuento,
        esGrupo: esGrupo ?? this.esGrupo,
        esConcretado: esConcretado ?? this.esConcretado,
        habitaciones: habitaciones ?? this.habitaciones,
      );
}
