import 'package:generador_formato/database/tables/tarifa_x_dia_table.dart';

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

  Map<String, dynamic> toMap() => {
        "id": id,
        "folioHabitacion": folioHabitacion,
        "esPreventa": esPreventa,
        "categoria": categoria,
        "fechaCheckIn": fechaCheckIn,
        "fechaCheckOut": fechaCheckOut,
        "fecha": fecha,
        "adultos": adultos,
        "menores0a6": menores0a6,
        "menores7a12": menores7a12,
        "paxAdic": paxAdic,
      };

  Map<String, dynamic> toMapUpdate() => {
        "folioHabitacion": folioHabitacion,
        "esPreventa": esPreventa,
        "categoria": categoria,
        "fechaCheckIn": fechaCheckIn,
        "fechaCheckOut": fechaCheckOut,
        "fecha": fecha,
        "adultos": adultos,
        "menores0a6": menores0a6,
        "menores7a12": menores7a12,
        "pax": paxAdic,
      };
}
