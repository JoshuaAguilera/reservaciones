import '../../database/database.dart';
import '../../models/habitacion_model.dart';
import '../../models/tarifa_x_dia_model.dart';
import '../../res/helpers/utility.dart';
import 'base_service.dart';

class HabitacionService extends BaseService {
  List<Habitacion> habitaciones = [];

  Future<List<Habitacion>> getHabitacionesByFolio(String folio) async {
    final db = AppDatabase();

    try {
      List<HabitacionTableData> resp = await db.getHabitacionesByFolio(folio);

      for (var element in resp) {
        habitaciones.add(Habitacion(
          // categoria: element.categoria,
          checkIn: element.fechaCheckIn,
          checkOut: element.fechaCheckOut,
          createdAt: element.fecha.toString(),
          id: element.folioHabitacion,
          adultos: element.adultos,
          count: element.count ?? 1,
          useCashSeason: element.useCashSeason,
          // descuento: element.descuento,
          folioCotizacion: element.folioCotizacion,
          esCortesia: element.isFree ?? false,
          menores0a6: element.menores0a6,
          menores7a12: element.menores7a12,
          tarifaXHabitacion: tarifasXDiaFromJson(element.tarifaXDia ?? '[]'),
          // total: element.total,
          // totalReal: element.totalReal,
          idInt: element.id,
        ));
      }

      for (var element in habitaciones) {
        List<TarifaXDia> tarifasFiltradas =
            Utility.getUniqueTariffs(element.tarifaXHabitacion!);

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
          element.tarifaXHabitacion?.length ?? 0,
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
          element.tarifaXHabitacion?.length ?? 0,
          onlyTariffVPM: true,
        );

        element.totalVPM = element.totalRealVPM! - element.descuentoVPM!;
      }

      await db.close();
      return habitaciones;
    } catch (e) {
      print(e);
      await db.close();
      return List.empty();
    }
  }

  Future<List<HabitacionTableData>> getHabitacionesIndTimePeriod(
      DateTime initTime, DateTime lastTime) async {
    final dataBase = AppDatabase();
    try {
      List<HabitacionTableData> resp =
          await dataBase.getHabitacionesByPeriod(initTime, lastTime);

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<HabitacionTableData>> getHabitacionesActuales() async {
    final dataBase = AppDatabase();
    try {
      List<HabitacionTableData> resp = await dataBase.getHabitacionesHoy();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<HabitacionTableData>> getAllHabitaciones() async {
    final dataBase = AppDatabase();
    try {
      List<HabitacionTableData> resp = await dataBase.getAllHabitaciones();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }
}
