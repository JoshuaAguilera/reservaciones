import 'package:generador_formato/models/tarifa_x_dia_model.dart';

class Habitacion {
  int? id;
  String? folioHabitacion;
  String? categoria;
  String? fechaCheckIn;
  String? fechaCheckOut;
  String? fecha;
  int? adultos;
  int? menores0a6;
  int? menores7a12;
  List<TarifaXDia>? tarifaXDia;
  double? totalReal;
  double? descuento;
  double? total;
  int count;

  Habitacion({
    this.id,
    this.categoria,
    this.fechaCheckIn,
    this.fechaCheckOut,
    this.fecha,
    this.folioHabitacion,
    this.tarifaXDia,
    this.adultos,
    this.menores0a6,
    this.menores7a12,
    this.totalReal,
    this.descuento,
    this.total,
    this.count = 1,
  });

  Habitacion CopyWith({
    int? id,
    String? folioHabitacion,
    String? categoria,
    String? fechaCheckIn,
    String? fechaCheckOut,
    String? fecha,
    int? adultos,
    int? menores0a6,
    int? menores7a12,
    List<TarifaXDia>? tarifaXDia,
    double? totalReal,
    double? descuento,
    double? total,
    int? count,
  }) =>
      Habitacion(
        id: id ?? this.id,
        folioHabitacion: folioHabitacion ?? this.folioHabitacion,
        categoria: categoria ?? this.categoria,
        fechaCheckIn: fechaCheckIn ?? this.fechaCheckIn,
        fechaCheckOut: fechaCheckOut ?? this.fechaCheckOut,
        fecha: fecha ?? this.fecha,
        adultos: adultos ?? this.adultos,
        menores0a6: menores0a6 ?? this.menores0a6,
        menores7a12: menores7a12 ?? this.menores7a12,
        tarifaXDia: tarifaXDia ?? this.tarifaXDia,
        totalReal: totalReal ?? this.totalReal,
        descuento: descuento ?? this.descuento,
        total: total ?? total,
        count: count ?? this.count,
      );
}
