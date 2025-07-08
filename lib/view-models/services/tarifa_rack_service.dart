import 'package:tuple/tuple.dart';

import '../../database/dao/periodo_dao.dart';
import '../../database/dao/registro_tarifa_dao.dart';
import '../../database/dao/tarifa_dao.dart';
import '../../database/dao/tarifa_rack_dao.dart';
import '../../database/dao/temporada_dao.dart';
import '../../database/database.dart';
import '../../models/error_model.dart';
import '../../models/periodo_model.dart';
import '../../models/registro_tarifa_bd_model.dart';
import '../../models/tarifa_model.dart';
import '../../models/tarifa_rack_model.dart';
import '../../models/temporada_model.dart';
import 'base_service.dart';

class TarifaRackService extends BaseService {
  Future<List<TarifaRack>> getList({
    String nombre = "",
    int? creadorId,
    DateTime? initDate,
    DateTime? lastDate,
    String sortBy = 'created_at',
    String orderBy = 'asc',
    int limit = 20,
    int page = 1,
    bool conDetalle = false,
  }) async {
    String sortSBy = "";
    String ordenSBy = "asc";

    switch (orderBy) {
      case "A":
        sortSBy = "nombre";
        ordenSBy = "asc";
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

    try {
      final db = AppDatabase();
      final tarifaRackDao = TarifaRackDao(db);

      final list = await tarifaRackDao.getList(
        nombre: nombre,
        creadorId: creadorId,
        initDate: initDate,
        lastDate: lastDate,
        sortBy: sortSBy,
        order: ordenSBy,
        limit: limit,
        page: page,
      );

      tarifaRackDao.close();
      db.close();
      return list;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<TarifaRack?> getById(int id) async {
    try {
      final db = AppDatabase();
      final tarifaRackDao = TarifaRackDao(db);
      final tarifaRack = await tarifaRackDao.getByID(id);

      tarifaRackDao.close();
      db.close();
      return tarifaRack;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<Tuple3<ErrorModel?, TarifaRack?, bool>> saveData(
      TarifaRack tarifaRack) async {
    ErrorModel? error;
    bool invalideToken = false;
    TarifaRack? saveTarifaRack;

    try {
      final db = AppDatabase();

      await db.transaction(
        () async {
          final tarifaRackDao = TarifaRackDao(db);
          final tarifaDao = TarifaDao(db);
          final registroDao = RegistroTarifaDao(db);
          final periodoDao = PeriodoDao(db);
          final temporadaDao = TemporadaDao(db);

          TarifaRack? newRack = await tarifaRackDao.save(tarifaRack);
          if (newRack == null) {
            throw Exception("Error al guardar la tarifa rack");
          }

          saveTarifaRack = newRack;
          saveTarifaRack?.registros = [];
          saveTarifaRack?.periodos = [];
          saveTarifaRack?.temporadas = [];

          if (tarifaRack.registros != null &&
              tarifaRack.registros!.isNotEmpty) {
            for (var registro in tarifaRack.registros ?? <RegistroTarifaBD>[]) {
              registro.esOriginal = registro.tarifa?.idInt == null;

              Tarifa? newTarifa = await tarifaDao.save(registro.tarifa!);
              if (newTarifa == null) {
                throw Exception("Error al guardar la tarifa");
              }

              if (registro.idInt != null) continue;
              registro.tarifa = newTarifa;
              registro.tarifaRackIdInt = newRack.idInt;
              RegistroTarifaBD? newRegisto = await registroDao.save(registro);
              if (newRegisto == null) {
                throw Exception("Error al guardar el registro de tarifa");
              }
              saveTarifaRack?.registros?.add(newRegisto);
            }
          }

          if (tarifaRack.periodos != null && tarifaRack.periodos!.isNotEmpty) {
            for (var periodo in tarifaRack.periodos ?? <Periodo>[]) {
              var newPeriodo = await periodoDao.save(periodo);
              if (newPeriodo == null) {
                throw Exception("Error al guardar el periodo");
              }
              saveTarifaRack?.periodos?.add(newPeriodo);
            }
          }

          if (tarifaRack.temporadas != null &&
              tarifaRack.temporadas!.isNotEmpty) {
            for (var temporada in tarifaRack.temporadas ?? <Temporada>[]) {
              var newTemporada = await temporadaDao.save(temporada);
              if (newTemporada == null) {
                throw Exception("Error al guardar la temporada");
              }
              saveTarifaRack?.temporadas?.add(newTemporada);
            }
          }

          tarifaRackDao.close();
          tarifaDao.close();
          periodoDao.close();
          temporadaDao.close();
        },
      );

      db.close();
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, saveTarifaRack, invalideToken);
  }

  Future<Tuple3<ErrorModel?, bool, bool>> delete(TarifaRack tarifaRack) async {
    ErrorModel error = ErrorModel();
    bool invalideToken = false;
    bool deleted = false;

    try {
      final db = AppDatabase();

      await db.transaction(
        () async {
          final tarifaRackDao = TarifaRackDao(db);
          final tarifaDao = TarifaDao(db);
          final registroDao = RegistroTarifaDao(db);
          final periodoDao = PeriodoDao(db);
          final temporadaDao = TemporadaDao(db);

          final responseTR = await tarifaRackDao.delet3(tarifaRack.idInt ?? 0);

          if (responseTR == 0) {
            throw Exception("Error al eliminar la tarifa rack");
          }

          for (var registro in tarifaRack.registros ?? <RegistroTarifaBD>[]) {
            if (registro.tarifa?.idInt != null && registro.esOriginal == true) {
              final responseT = await tarifaDao.delet3(
                registro.tarifa?.idInt ?? 0,
              );
              if (responseT == 0) {
                throw Exception("Error al eliminar la tarifa");
              }
            }

            if (registro.idInt != null) {
              final responseR = await registroDao.delet3(registro.idInt ?? 0);
              if (responseR == 0) {
                throw Exception("Error al eliminar el registro de tarifa");
              }
            }
          }

          for (var periodo in tarifaRack.periodos ?? <Periodo>[]) {
            final responseP = await periodoDao.delet3(periodo.idInt ?? 0);
            if (responseP == 0) {
              throw Exception("Error al eliminar el periodo");
            }
          }

          for (var temporada in tarifaRack.temporadas ?? <Temporada>[]) {
            final responseT = await temporadaDao.delet3(temporada.idInt ?? 0);
            if (responseT == 0) {
              throw Exception("Error al eliminar la temporada");
            }
          }

          deleted = responseTR > 0;
          tarifaRackDao.close();
          tarifaDao.close();
          registroDao.close();
          periodoDao.close();
          temporadaDao.close();
        },
      );

      db.close();
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, deleted, invalideToken);
  }
}
