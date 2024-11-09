import 'package:drift/drift.dart';
import 'package:generador_formato/models/prefijo_telefonico_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/habitacion_model.dart';

import '../database/database.dart';
import 'base_service.dart';

class CotizacionService extends BaseService {
  Future<List<CotizacionData>> getCotizacionesTimePeriod(
      DateTime initTime, DateTime lastTime) async {
    final dataBase = AppDatabase();
    try {
      List<CotizacionData> resp =
          await dataBase.getCotizacionByPeriod(initTime, lastTime);

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<bool> createCotizacion({
    required Cotizacion cotizacion,
    List<Habitacion>? habitaciones,
    required String folio,
    required PrefijoTelefonico prefijoInit,
    bool isQuoteGroup = false,
  }) async {
    final database = AppDatabase();

    try {
      database.transaction(
        () async {
          for (var element in habitaciones!) {
            await database.into(database.habitacion).insert(
                  HabitacionCompanion.insert(
                    // categoria: Value(element.categoria),
                    fecha: DateTime.now(),
                    fechaCheckIn: Value(element.fechaCheckIn),
                    fechaCheckOut: Value(element.fechaCheckOut),
                    folioCotizacion: Value(folio),
                    adultos: Value(element.adultos),
                    count: Value(element.count),
                    // descuento: Value(element.descuento),
                    folioHabitacion: Value(element.folioHabitacion),
                    isFree: Value(element.isFree),
                    menores0a6: Value(element.menores0a6),
                    menores7a12: Value(element.menores7a12),
                    paxAdic: Value(0),
                    // total: Value(element.total),
                    // totalReal: Value(element.totalReal),
                    tarifaXDia: Value(tarifasXDiaToJson(element.tarifaXDia!)),
                  ),
                );
          }

          await database.into(database.cotizacion).insert(
                CotizacionCompanion.insert(
                  fecha: DateTime.now(),
                  correoElectrico: Value(cotizacion.correoElectronico ?? ''),
                  esGrupo: Value(isQuoteGroup),
                  folioPrincipal: Value(folio),
                  habitaciones: const Value(""),
                  nombreHuesped: Value(cotizacion.nombreHuesped),
                  numeroTelefonico: Value(cotizacion.numeroTelefonico),
                  usuarioID: Value(userId),
                  esConcretado: const Value(false),
                  // descuento: Value(cotizacion.descuento),
                  // total: Value(cotizacion.total),
                  // totalReal: Value(cotizacion.totalReal),
                ),
              );
        },
      );
      await database.close();
      return true;
    } catch (e) {
      print(e);
      await database.close();
      return false;
    }
  }

  Future<List<CotizacionData>> getCotizacionesLocales(
      String search, int pag, String filtro, bool empty, String periodo) async {
    final database = AppDatabase();
    try {
      List<CotizacionData> comprobantes = [];
      if (empty) {
        comprobantes = await database.select(database.cotizacion).get();
      } else {
        if (periodo.isNotEmpty) {
          DateTime initTime = DateTime.parse(periodo.substring(0, 10));
          DateTime lastTime = DateTime.parse(periodo.substring(10, 20));
          comprobantes = await database
              .getCotizacionesPeriodo(initTime, lastTime, search: search);
        } else {
          switch (filtro) {
            case "Todos":
              if (search.isNotEmpty) {
                comprobantes = await database.getCotizacionesSearch(search);
              } else {
                comprobantes = await database.select(database.cotizacion).get();
              }
              break;
            case 'Hace un dia':
              comprobantes =
                  await database.getCotizacionesUltimoDia(search: search);
              break;
            case 'Hace una semana':
              comprobantes =
                  await database.getCotizacionesUltimaSemana(search: search);
              break;
            case 'Hace un mes':
              comprobantes =
                  await database.getCotizacionesUltimoMes(search: search);
              break;
            default:
          }
        }
      }

      await database.close();
      return comprobantes;
    } catch (e) {
      print(e);
      await database.close();

      return List.empty();
    }
  }

  Future<bool> eliminarCotizacion(String folio) async {
    final database = AppDatabase();
    try {
      await database.deleteCotizacionByFolio(folio).toString();
      await database.deleteHabitacionByFolio(folio).toString();

      await database.close();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<CotizacionData>> getCotizacionesRecientes() async {
    final dataBase = AppDatabase();
    try {
      List<CotizacionData> resp = await dataBase.getCotizacionesRecientes();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<CotizacionData>> getCotizacionesActuales() async {
    final dataBase = AppDatabase();
    try {
      List<CotizacionData> resp = await dataBase.getCotizacionesHoy();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<CotizacionData>> getAllCotizaciones() async {
    final dataBase = AppDatabase();
    try {
      List<CotizacionData> resp = await dataBase.getHistorialCotizaciones();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }
}
