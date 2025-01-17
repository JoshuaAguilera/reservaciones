import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';

import '../utils/helpers/utility.dart';
import 'base_service.dart';

class HabitacionService extends BaseService {
  List<Habitacion> habitaciones = [];

  Future<List<Habitacion>> getHabitacionesByFolio(String folio) async {
    final database = AppDatabase();

    try {
      List<HabitacionData> resp = await database.getHabitacionesByFolio(folio);

      for (var element in resp) {
        habitaciones.add(Habitacion(
          // categoria: element.categoria,
          fechaCheckIn: element.fechaCheckIn,
          fechaCheckOut: element.fechaCheckOut,
          fecha: element.fecha.toString(),
          folioHabitacion: element.folioHabitacion,
          adultos: element.adultos,
          count: element.count ?? 1,
          useCashSeason: element.useCashSeason,
          // descuento: element.descuento,
          folioCotizacion: element.folioCotizacion,
          isFree: element.isFree ?? false,
          menores0a6: element.menores0a6,
          menores7a12: element.menores7a12,
          tarifaXDia: tarifasXDiaFromJson(element.tarifaXDia ?? '[]'),
          // total: element.total,
          // totalReal: element.totalReal,
          id: element.id,
        ));
      }

      for (var element in habitaciones) {
        List<TarifaXDia> tarifasFiltradas =
            Utility.getUniqueTariffs(element.tarifaXDia!);

        element.totalRealVR = Utility.calculateTariffTotals(
          tarifasFiltradas,
          element,
          onlyChildren: true,
          onlyAdults: true,
          onlyTariffVR: true,
        );

        element.descuentoVR = Utility.calculateDiscountTotal(
          tarifasFiltradas,
          element,
          element.tarifaXDia?.length ?? 0,
          onlyTariffVR: true,
        );

        element.totalVR = element.totalRealVR! - element.descuentoVR!;

        element.totalRealVPM = Utility.calculateTariffTotals(
          tarifasFiltradas,
          element,
          onlyChildren: true,
          onlyAdults: true,
          onlyTariffVPM: true,
        );

        element.descuentoVPM = Utility.calculateDiscountTotal(
          tarifasFiltradas,
          element,
          element.tarifaXDia?.length ?? 0,
          onlyTariffVPM: true,
        );

        element.totalVPM = element.totalRealVPM! - element.descuentoVPM!;
      }

      await database.close();
      return habitaciones;
    } catch (e) {
      print(e);
      await database.close();
      return List.empty();
    }
  }

  Future<List<HabitacionData>> getHabitacionesIndTimePeriod(
      DateTime initTime, DateTime lastTime) async {
    final dataBase = AppDatabase();
    try {
      List<HabitacionData> resp =
          await dataBase.getHabitacionesByPeriod(initTime, lastTime);

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<HabitacionData>> getHabitacionesActuales() async {
    final dataBase = AppDatabase();
    try {
      List<HabitacionData> resp = await dataBase.getHabitacionesHoy();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<HabitacionData>> getAllHabitaciones() async {
    final dataBase = AppDatabase();
    try {
      List<HabitacionData> resp = await dataBase.getAllHabitaciones();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }
}
