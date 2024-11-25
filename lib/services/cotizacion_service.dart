import 'package:drift/drift.dart';
import 'package:generador_formato/models/prefijo_telefonico_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/habitacion_model.dart';

import '../database/database.dart';
import '../models/tarifa_x_dia_model.dart';
import 'base_service.dart';

class CotizacionService extends BaseService {
  Future<List<CotizacionData>> getCotizacionesTimePeriod(
      DateTime initTime, DateTime lastTime) async {
    final dataBase = AppDatabase();
    try {
      List<CotizacionData> resp = await dataBase.getCotizacionByPeriod(initTime,
          lastTime, (rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null);

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
      await database.transaction(
        () async {
          for (var element in habitaciones!) {
            if (isQuoteGroup) {
              element.tarifaXDia!.clear();
              int days = DateTime.parse(element.fechaCheckOut!)
                  .difference(DateTime.parse(element.fechaCheckIn!))
                  .inDays;

              for (var ink = 0; ink < days; ink++) {
                DateTime dateNow = DateTime.parse(element.fechaCheckOut!)
                    .add(Duration(days: ink));
                TarifaXDia newTariff = element.tarifaGrupal!.copyWith();
                newTariff.fecha = dateNow;
                newTariff.dia = ink;
                newTariff.numDays = 1;
                element.tarifaXDia!.add(
                  newTariff.copyWith(),
                );
              }
            }

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
        comprobantes = await database.getQuotesFiltered(
            userId: (rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null);
      } else {
        if (periodo.isNotEmpty) {
          DateTime initTime = DateTime.parse(periodo.substring(0, 10));
          DateTime lastTime = DateTime.parse(periodo.substring(10, 20));
          comprobantes = await database.getQuotesFiltered(
            initTime: initTime,
            lastTime: lastTime,
            search: search,
            userId: (rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null,
          );
        } else {
          switch (filtro) {
            case "Todos":
              if (search.isNotEmpty) {
                comprobantes = await database.getQuotesFiltered(
                  search: search,
                  userId:
                      (rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null,
                );
              } else {
                comprobantes = await database.getQuotesFiltered(
                    userId: (rol != "SUPERADMIN" && rol != "ADMIN")
                        ? userId
                        : null);
              }
              break;
            case 'Hace un dia':
              comprobantes = await database.getCotizacionesUltimoDia(
                search: search,
                userId: (rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null,
              );
              break;
            case 'Hace una semana':
              comprobantes = await database.getCotizacionesUltimaSemana(
                search: search,
                userId: (rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null,
              );
              break;
            case 'Hace un mes':
              comprobantes = await database.getCotizacionesUltimoMes(
                search: search,
                userId: (rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null,
              );
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
      await database.close();
      return false;
    }
  }

  Future<List<CotizacionData>> getCotizacionesRecientes() async {
    final dataBase = AppDatabase();
    try {
      List<QuoteWithUser> resp = await dataBase.getCotizacionesRecientes(
          (rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null);

      List<CotizacionData> quotes = [];

      for (var element in resp) {
        CotizacionData data = CotizacionData(
          id: element.quote.id,
          fecha: element.quote.fecha,
          correoElectrico: element.quote.correoElectrico,
          esConcretado: element.quote.esConcretado,
          esGrupo: element.quote.esGrupo,
          folioPrincipal: element.quote.folioPrincipal,
          habitaciones: element.quote.habitaciones,
          nombreHuesped: element.quote.nombreHuesped,
          numeroTelefonico: element.quote.numeroTelefonico,
          usuarioID: element.quote.usuarioID,
          username: element.user!.username,
        );

        quotes.add(data);
      }

      await dataBase.close();
      return quotes;
    } catch (e) {
      print(e);
      await dataBase.close();
      return List.empty();
    }
  }

  Future<List<CotizacionData>> getCotizacionesActuales() async {
    final dataBase = AppDatabase();
    try {
      List<CotizacionData> resp = await dataBase.getCotizacionesHoy(
          (rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null);

      await dataBase.close();
      return resp;
    } catch (e) {
      await dataBase.close();
      return List.empty();
    }
  }

  Future<List<CotizacionData>> getAllCotizaciones() async {
    final dataBase = AppDatabase();
    try {
      List<CotizacionData> resp = await dataBase.getHistorialCotizaciones(
          (rol != "SUPERADMIN" && rol != "ADMIN") ? userId : null);

      await dataBase.close();
      return resp;
    } catch (e) {
      await dataBase.close();
      return List.empty();
    }
  }
}
