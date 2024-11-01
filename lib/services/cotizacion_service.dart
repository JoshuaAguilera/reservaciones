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
            await database
                .into(database.habitacion)
                .insert(HabitacionCompanion.insert(
                  categoria: element.categoria ?? '',
                  fecha: DateTime.parse(element.fecha!),
                  fechaCheckIn: element.fechaCheckIn ?? '',
                  fechaCheckOut: element.fechaCheckOut ?? '',
                  subfolio: folio,
                ));
          }

          await database.into(database.cotizacion).insert(
                CotizacionCompanion.insert(
                  fecha: DateTime.parse(cotizacion.fecha!),
                  correoElectrico: Value(cotizacion.correoElectronico ?? ''),
                  descuento: Value(cotizacion.descuento),
                  esGrupo: Value(cotizacion.esGrupo),
                  folioPrincipal: Value(cotizacion.folioPrincipal),
                  habitaciones: Value(""),
                  nombreHuesped: Value(cotizacion.nombreHuesped),
                  numeroTelefonico: Value(cotizacion.numeroTelefonico),
                  usuarioID: Value(userId),
                  tipo: Value(cotizacion.tipo),
                  total: Value(cotizacion.total),
                  // folioQuotes: folio,
                  // mail: comprobante.correoElectronico!,
                  // nameCustomer: comprobante.nombreHuesped!,
                  // numPhone: prefijoInit.prefijo + comprobante.numeroTelefonico!,
                  // userId: 1,
                  // dateRegister: DateTime.now(),
                  // rateDay: !isQuoteGroup
                  //     ? Utility.calculateTarifaDiaria(
                  //         cotizacion: habitaciones!.first)
                  //     : 0,
                  // total: !isQuoteGroup
                  //     ? Utility.calculateTarifaTotal(habitaciones!)
                  //     : 0,
                  // rooms: comprobante.habitaciones ?? 0,
                  // isGroup: isQuoteGroup,
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
