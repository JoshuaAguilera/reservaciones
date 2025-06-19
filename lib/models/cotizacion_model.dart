import 'cliente_model.dart';
import 'habitacion_model.dart';
import 'usuario_model.dart';

class Cotizacion {
  int? id;
  String? cotId;
  String? folioPrincipal;
  DateTime? createdAt;
  DateTime? fechaLimite;
  bool? esGrupo;
  bool? esConcretado;
  List<Habitacion>? habitaciones;
  Usuario? creadoPor;
  Usuario? cerradoPor;
  Cliente? cliente;
  String? comentarios;
  Cotizacion? cotizacionOrigenId;

  Cotizacion({
    this.id,
    this.cotId,
    this.esGrupo,
    this.createdAt,
    this.fechaLimite,
    this.folioPrincipal,
    this.habitaciones,
    this.creadoPor,
    this.cerradoPor,
    this.esConcretado,
    this.comentarios,
    this.cliente,
    this.cotizacionOrigenId,
  });

  Cotizacion CopyWith({
    int? id,
    String? cotId,
    String? folioPrincipal,
    DateTime? fecha,
    DateTime? fechaLimite,
    bool? esGrupo,
    bool? esConcretado,
    List<Habitacion>? habitaciones,
    Usuario? creadoPor,
    Usuario? cerradoPor,
    Cliente? cliente,
    String? comentarios,
    Cotizacion? cotizacionOrigenId,
  }) =>
      Cotizacion(
        id: id ?? this.id,
        cotId: cotId ?? this.cotId,
        folioPrincipal: folioPrincipal ?? this.folioPrincipal,
        createdAt: fecha ?? this.createdAt,
        esGrupo: esGrupo ?? this.esGrupo,
        esConcretado: esConcretado ?? this.esConcretado,
        habitaciones: habitaciones ?? this.habitaciones,
        fechaLimite: fechaLimite ?? this.fechaLimite,
        creadoPor: creadoPor ?? this.creadoPor,
        cerradoPor: cerradoPor ?? this.cerradoPor,
        cliente: cliente,
      );
}
