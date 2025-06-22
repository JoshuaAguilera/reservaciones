import 'package:drift/drift.dart';

import '../../database/dao/cotizacion_dao.dart';
import '../../database/database.dart';
import '../../models/cotizacion_model.dart';
import '../../models/habitacion_model.dart';
import '../../models/periodo_model.dart';
import '../../models/prefijo_telefonico_model.dart';
import '../../models/tarifa_x_dia_model.dart';
import 'base_service.dart';

class CotizacionService extends BaseService {
  Future<List<Cotizacion>> getCotizacionesTimePeriod(
      DateTime initTime, DateTime lastTime) async {
    final db = AppDatabase();
    final cotDao = CotizacionDao(db);
    try {
      List<Cotizacion> resp = await cotDao.getList(
        initDate: initTime,
        lastDate: lastTime,
      );

      await db.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<int> createCotizacion({
    required Cotizacion cotizacion,
    List<Habitacion>? habitaciones,
    required String folio,
    required PrefijoTelefonico prefijoInit,
    int? limitDay,
    bool isQuoteGroup = false,
  }) async {
    final database = AppDatabase();
    int id = 0;

    try {
      await database.transaction(
        () async {
          for (var element in habitaciones!) {
            if (isQuoteGroup) {
              element.tarifaXHabitacion!.clear();
              int days = DateTime.parse(element.checkOut!)
                  .difference(DateTime.parse(element.checkIn!))
                  .inDays;

              for (var ink = 0; ink < days; ink++) {
                DateTime dateNow = DateTime.parse(element.checkOut!)
                    .add(Duration(days: ink));
                TarifaXDia newTariff = element.tarifaGrupal!.copyWith();
                newTariff.fecha = dateNow;
                newTariff.dia = ink;
                newTariff.numDays = 1;
                element.tarifaXHabitacion!.add(
                  newTariff.copyWith(),
                );
              }
            }

            await database.into(database.habitacionTable).insert(
                  HabitacionTableCompanion.insert(
                    // categoria: Value(element.categoria),
                    fecha: DateTime.now(),
                    useCashSeason: Value(element.useCashSeason),
                    fechaCheckIn: Value(element.checkIn),
                    fechaCheckOut: Value(element.checkOut),
                    folioCotizacion: Value(folio),
                    adultos: Value(element.adultos),
                    count: Value(element.count),
                    // descuento: Value(element.descuento),
                    folioHabitacion: Value(element.id),
                    isFree: Value(element.esCortesia),
                    menores0a6: Value(element.menores0a6),
                    menores7a12: Value(element.menores7a12),
                    paxAdic: Value(0),
                    // total: Value(element.total),
                    // totalReal: Value(element.totalReal),
                    tarifaXDia: Value(tarifasXDiaToJson(element.tarifaXHabitacion!)),
                  ),
                );
          }

          id = await database.into(database.cotizacionTable).insert(
                CotizacionTableCompanion.insert(
                  esGrupo: Value(isQuoteGroup),
                  folioPrincipal: Value(folio),
                  habitaciones: const Value(""),
                  creadoPor: Value(userId),
                  esConcretado: const Value(false),
                  fechaLimite: Value(
                    DateTime.now().add(Duration(days: limitDay ?? 0)),
                  ),
                ),
              );
        },
      );
      await database.close();
      return id;
    } catch (e) {
      print(e);
      await database.close();
      return id;
    }
  }

  Future<List<Cotizacion>> getCotizacionesLocales(
    String search,
    int pag,
    String filtro,
    bool empty,
    Periodo? periodo,
    List<bool> showFilter,
  ) async {
    final db = AppDatabase();
    final cotDao = CotizacionDao(db);
    int? selectUser = (rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null;

    try {
      List<Cotizacion> comprobantes = [];
      if (empty) {
        comprobantes = await cotDao.getList(
          // userId: (rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null,
          showFilter: showFilter,
        );
      } else {
        if (periodo != null) {
          comprobantes = await cotDao.getList(
            initDate: periodo.fechaInicial,
            lastDate: periodo.fechaFinal,
            clienteNombre: search,
            cerradorId: selectUser,
            showFilter: showFilter,
          );
        } else {
          switch (filtro) {
            case "Todos":
              comprobantes = await cotDao.getList(
                clienteNombre: search,
                creadorId: selectUser,
                showFilter: showFilter,
              );
              break;
            case 'Hace un dia':
              comprobantes = await cotDao.getList(
                creadorId: selectUser,
                clienteNombre: search,
                showFilter: showFilter,
                inLastDay: true,
              );
              break;
            case 'Hace una semana':
              comprobantes = await cotDao.getList(
                creadorId: selectUser,
                clienteNombre: search,
                showFilter: showFilter,
                inLastWeek: true,
              );
              break;
            case 'Hace un mes':
              comprobantes = await cotDao.getList(
                creadorId: selectUser,
                clienteNombre: search,
                showFilter: showFilter,
                inLastMonth: true,
              );
              break;
            default:
          }
        }
      }

      await db.close();

      return comprobantes;
    } catch (e) {
      print(e);
      await db.close();

      return List.empty();
    }
  }

  Future<bool> eliminarCotizacion(String folio) async {
    final db = AppDatabase();
    final cotDao = CotizacionDao(db);
    try {
      await db.transaction(
        () async {
          int responseDQ = await cotDao.delet3(folio: folio);
          int responseDR = await db.deleteHabitacionByFolio(folio);

          print("$responseDQ - $responseDR");
        },
      );

      await db.close();
      return true;
    } catch (e) {
      print(e);
      await db.close();
      return false;
    }
  }

  Future<List<Cotizacion>> getCotizacionesRecientes() async {
    final db = AppDatabase();
    final cotDao = CotizacionDao(db);
    try {
      //(rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null
      List<Cotizacion> resp = await cotDao.getList(order: "created_at");
      return resp;
    } catch (e) {
      print(e);
      await db.close();
      return List.empty();
    }
  }

  Future<List<Cotizacion>> getCotizacionesActuales() async {
    final db = AppDatabase();
    final cotDao = CotizacionDao(db);
    try {
      List<Cotizacion> resp = await cotDao.getList();

      await db.close();
      return resp;
    } catch (e) {
      await db.close();
      return List.empty();
    }
  }

  Future<List<Cotizacion>> getCotizaciones({
    int pagina = 1,
    int limit = 20,
    String search = "",
    String sortBy = "",
    String ordenBy = "asc",
    DateTime? initDate,
    DateTime? lastDate,
  }) async {
    final db = AppDatabase();
    final cotDao = CotizacionDao(db);
    try {
      List<Cotizacion> resp = await cotDao.getList(
        page: pagina,
        limit: limit,
        clienteNombre: search,
        sortBy: sortBy,
        order: ordenBy,
        initDate: initDate,
        lastDate: lastDate,
      );
      await db.close();
      return resp;
    } catch (e) {
      await db.close();
      return List.empty();
    }
  }

  Future<bool> updateCotizacion(CotizacionTableData data) async {
    final db = AppDatabase();
    final cotDao = CotizacionDao(db);

    try {
      bool result = await cotDao.updat3(data);
      await db.close();
      return result;
    } catch (e) {
      print(e);
      await db.close();
      return false;
    }
  }
}
