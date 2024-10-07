import 'package:generador_formato/models/tarifa_x_dia_model.dart';

class Habitacion {
  int? id;
  String? folioHabitacion;
  String? categoria;
  bool? esPreventa;
  String? fechaCheckIn;
  String? fechaCheckOut;
  String? fecha;
  int? adultos;
  int? menores0a6;
  int? menores7a12;
  int? paxAdic;
  List<TarifaXDia>? tarifaXDia;

  Habitacion({
    this.id,
    this.esPreventa,
    this.categoria,
    this.fechaCheckIn,
    this.fechaCheckOut,
    this.fecha,
    this.folioHabitacion,
    this.tarifaXDia,
    this.adultos,
    this.menores0a6,
    this.menores7a12,
    this.paxAdic,
  });
}
