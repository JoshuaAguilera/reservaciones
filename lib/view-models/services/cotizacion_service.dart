import 'package:tuple/tuple.dart';

import '../../database/dao/cotizacion_dao.dart';
import '../../database/dao/habitacion_dao.dart';
import '../../database/dao/tarifa_x_dia_dao.dart';
import '../../database/dao/tarifa_x_habitacion_dao.dart';
import '../../database/database.dart';
import '../../models/cotizacion_model.dart';
import '../../models/error_model.dart';
import '../../models/habitacion_model.dart';
import '../../models/estadistica_model.dart';
import '../../models/tarifa_x_dia_model.dart';
import '../../models/tarifa_x_habitacion_model.dart';
import '../../models/usuario_model.dart';
import 'base_service.dart';

class CotizacionService extends BaseService {
  Future<List<Cotizacion>> getList({
    int pagina = 1,
    int limit = 20,
    List<bool>? showFilter,
    String search = "",
    String ordenBy = "",
    DateTime? initDate,
    DateTime? lastDate,
    bool conDetalle = false,
    Usuario? creadorPor,
    Usuario? cerradorPor,
    String? lapso,
  }) async {
    var cotizaciones = List<Cotizacion>.empty();

    bool inLastDay = false;
    bool inLastWeek = false;
    bool inLastMonth = false;
    String sortSBy = "";
    String ordenSBy = "asc";

    switch (ordenBy) {
      // case "A":
      //   sortSBy = "nombre";
      //   ordenSBy = "asc";
      case "MR":
        sortSBy = "createdAt";
        ordenSBy = "desc";
      case "MA":
        sortSBy = "createdAt";
        ordenSBy = "asc";
      default:
        sortSBy = "createdAt";
        ordenSBy = "asc";
    }

    if (lapso != null) {
      switch (lapso) {
        case "Ultimo día":
          inLastDay = true;
          break;
        case "Ultima semana":
          inLastWeek = true;
          break;
        case "Ultimo mes":
          inLastMonth = true;
          break;
        default:
      }
    }

    try {
      final db = AppDatabase();
      final cotDao = CotizacionDao(db);
      List<Cotizacion> resp = await cotDao.getList(
        page: pagina,
        limit: limit,
        clienteNombre: search,
        initDate: initDate,
        lastDate: lastDate,
        orderBy: ordenSBy,
        sortBy: sortSBy,
        conDetalle: conDetalle,
        creadorId: creadorPor?.idInt,
        cerradorId: cerradorPor?.idInt,
        filters: showFilter,
        inLastDay: inLastDay,
        inLastWeek: inLastWeek,
        inLastMonth: inLastMonth,
      );

      await cotDao.close();
      await db.close();
      return resp;
    } catch (e) {
      print(e);
    }
    return cotizaciones;
  }

  Future<List<Estadistica>> getCounts({
    required List<Estadistica> stats,
    String filtro = "Individual",
  }) async {
    List<Estadistica> list = [];
    DateTime now = DateTime.now();
    DateTime initPastMonth = DateTime(now.year, now.month - 1, 1);
    DateTime lastPastMonth = DateTime(now.year, now.month, 0);
    DateTime initNowMonth = DateTime(now.year, now.month, 1);
    DateTime lastNowMonth = DateTime(now.year, now.month + 1, 0);

    try {
      final db = AppDatabase();
      final cotDao = CotizacionDao(db);

      await db.transaction(
        () async {
          for (var stat in stats) {
            String title = stat.title?.toLowerCase() ?? "";
            bool esTotal = title == "total";
            bool esGrupal = title == "grupales";
            bool esIndividual = title == "individuales";
            bool esConcretadaInd = title == "reservadas ind";
            bool esConcretadaGrp = title == "reservadas grp";
            bool esCaducada = title == "caducadas";

            List<bool> filters = [
              esTotal,
              esGrupal,
              esIndividual,
              esConcretadaGrp,
              esConcretadaInd,
              esCaducada,
            ];

            int? totalNow = await cotDao.countBy(
              filters: filters,
              creadorId: filtro == "Equipo" ? null : userId,
            );

            int? nowMonth = await cotDao.countBy(
              initDate: initNowMonth,
              lastDate: lastNowMonth,
              filters: filters,
              creadorId: filtro == "Equipo" ? null : userId,
            );

            int? initialMonth = await cotDao.countBy(
              initDate: initPastMonth,
              lastDate: lastPastMonth,
              filters: filters,
              creadorId: filtro == "Equipo" ? null : userId,
            );

            Estadistica estadistica = Estadistica(
              title: stat.title,
              total: totalNow ?? 0,
              numNow: nowMonth ?? 0,
              numInitial: initialMonth ?? 0,
            );

            list.add(estadistica);
          }
        },
      );

      await cotDao.close();
      await db.close();
    } catch (e) {
      print(e);
    }

    return list;
  }

  Future<Cotizacion?> getByID(Tuple2<String?, int?> ids) async {
    Cotizacion? cotizacion;

    try {
      final db = AppDatabase();
      final cotDao = CotizacionDao(db);
      cotizacion = await cotDao.getByID(ids.item2 ?? 0);
      await db.close();
    } catch (e) {
      print(e);
    }

    return cotizacion;
  }

  Future<Tuple3<ErrorModel?, Cotizacion?, bool>> saveData(
      Cotizacion cotizacion) async {
    ErrorModel error = ErrorModel();
    bool invalidToken = false;
    Cotizacion? savedCotizacion;

    try {
      final db = AppDatabase();

      await db.transaction(
        () async {
          final cotizacionDao = CotizacionDao(db);
          final habitacionDao = HabitacionDao(db);
          final tarifaHabDao = TarifaXHabitacionDao(db);
          final tarifaDiaDao = TarifaXDiaDao(db);

          Cotizacion? newCotizacion = await cotizacionDao.save(cotizacion);
          if (newCotizacion == null) {
            throw Exception("Error al guardar la cotización");
          }
          savedCotizacion = newCotizacion;
          savedCotizacion!.habitaciones ??= List<Habitacion>.empty();

          for (var room
              in cotizacion.habitaciones ?? List<Habitacion>.empty()) {
            if (cotizacion.esGrupo ?? false) {
              room.tarifasXHabitacion!.clear();
              int days = room.checkOut!.difference(room.checkIn!).inDays;

              for (var ink = 0; ink < days; ink++) {
                DateTime dateNow = room.checkOut!.add(Duration(days: ink));
                TarifaXHabitacion newTariff = room.tarifasXHabitacion!
                    .where((element) => element.esGrupal ?? false)
                    .first
                    .copyWith();
                newTariff.fecha = dateNow;
                newTariff.dia = ink;
                newTariff.numDays = 1;
                room.tarifasXHabitacion!.add(
                  newTariff.copyWith(),
                );
              }
            }

            room.cotizacionInt = newCotizacion.idInt;
            Habitacion? newRoom = await habitacionDao.save(room);
            if (newRoom == null) {
              throw Exception("Error al guardar la habitación");
            }

            newRoom.tarifasXHabitacion ??= List<TarifaXHabitacion>.empty();

            for (var tarHab
                in room.tarifasXHabitacion ?? List<TarifaXHabitacion>.empty()) {
              tarHab.habitacionInt = newRoom.idInt;
              TarifaXDia? newTariff;

              if (tarHab.tarifaXDia != null) {
                newTariff = await tarifaDiaDao.save(tarHab.tarifaXDia!);
                if (newTariff == null) {
                  throw Exception("Error al guardar la tarifa del día");
                }
              }

              if (tarHab.tarifaXDia == null) {
                tarHab.tarifaXDia?.idInt = newTariff?.idInt;
              }

              TarifaXHabitacion? newRateRoom = await tarifaHabDao.save(tarHab);
              if (newRateRoom == null) {
                throw Exception("Error al guardar la tarifa de la habitación");
              }

              newRateRoom.tarifaXDia = newTariff;
              newRoom.tarifasXHabitacion?.add(newRateRoom);
            }

            savedCotizacion!.habitaciones!.add(newRoom);
          }

          await tarifaDiaDao.close();
          await tarifaHabDao.close();
          await habitacionDao.close();
          await cotizacionDao.close();
        },
      );
      await db.close();
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }
    return Tuple3(error, savedCotizacion, invalidToken);
  }

  Future<Tuple3<ErrorModel?, bool, bool>> delete(Cotizacion cotizacion) async {
    ErrorModel error = ErrorModel();
    bool invalidToken = false;
    bool deleted = false;

    try {
      final db = AppDatabase();

      await db.transaction(
        () async {
          final cotDao = CotizacionDao(db);
          final habitacionDao = HabitacionDao(db);
          final tarifaHabDao = TarifaXHabitacionDao(db);
          final tarifaDiaDao = TarifaXDiaDao(db);

          final responseDQ = await cotDao.delet3(
            id: cotizacion.idInt,
            folio: cotizacion.folio ?? '',
          );

          if (responseDQ == 0) {
            throw Exception("Error al eliminar la cotización");
          }
          for (var room
              in cotizacion.habitaciones ?? List<Habitacion>.empty()) {
            final responseDH = await habitacionDao.delet3(room.idInt ?? 0);
            if (responseDH == 0) {
              throw Exception("Error al eliminar la habitación");
            }

            for (var tarHab
                in room.tarifasXHabitacion ?? List<TarifaXHabitacion>.empty()) {
              if (tarHab.tarifaXDia != null) {
                final responseDTar = await tarifaDiaDao.delet3(
                  tarHab.tarifaXDia!.idInt ?? 0,
                );
                if (responseDTar == 0) {
                  throw Exception("Error al eliminar la tarifa del día");
                }
              }

              final responseDT = await tarifaHabDao.delet3(tarHab.idInt ?? 0);
              if (responseDT == 0) {
                throw Exception("Error al eliminar la tarifa de la habitación");
              }
            }
          }

          tarifaDiaDao.close();
          tarifaHabDao.close();
          habitacionDao.close();
          cotDao.close();
        },
      );

      await db.close();
      deleted = true;
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, deleted, invalidToken);
  }
}
