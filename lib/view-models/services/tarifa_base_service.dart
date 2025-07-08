import 'package:tuple/tuple.dart';

import '../../database/dao/tarifa_base_dao.dart';
import '../../database/dao/tarifa_dao.dart';
import '../../database/database.dart';
import '../../models/error_model.dart';
import '../../models/tarifa_base_model.dart';
import '../../models/tarifa_model.dart';
import 'base_service.dart';

class TarifaBaseService extends BaseService {
  Future<List<TarifaBase>> getList({
    String nombre = '',
    String codigo = '',
    int? tarifaBaseId,
    int? creadorId,
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String orderBy = 'asc',
    int limit = 20,
    int page = 1,
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
      final tarifaBaseDao = TarifaBaseDao(db);
      List<TarifaBase> list = await tarifaBaseDao.getList(
        nombre: nombre,
        codigo: codigo,
        tarifaBaseId: tarifaBaseId,
        creadorId: creadorId,
        initDate: initDate,
        lastDate: lastDate,
        sortBy: sortSBy,
        order: ordenSBy,
        limit: limit,
        page: page,
      );

      await tarifaBaseDao.close();
      await db.close();
      return list;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<TarifaBase?> getById(int id) async {
    try {
      final db = AppDatabase();
      final tarifaBaseDao = TarifaBaseDao(db);
      TarifaBase? tarifaBase = await tarifaBaseDao.getByID(id);

      await tarifaBaseDao.close();
      await db.close();
      return tarifaBase;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<Tuple3<ErrorModel?, TarifaBase?, bool>> saveData(
      TarifaBase tarifaBase) async {
    ErrorModel error = ErrorModel();
    bool invalideToken = false;
    TarifaBase? saveBaseTariff;

    try {
      final db = AppDatabase();
      await db.transaction(
        () async {
          final tarifaBaseDao = TarifaBaseDao(db);
          final tarifaDao = TarifaDao(db);

          TarifaBase? newBase = await tarifaBaseDao.save(tarifaBase);
          if (newBase == null) {
            throw Exception("Error al guardar la tarifa base");
          }
          saveBaseTariff = newBase;
          saveBaseTariff?.tarifas ??= List<Tarifa>.empty();

          if (tarifaBase.tarifas != null && tarifaBase.tarifas!.isNotEmpty) {
            for (var element in tarifaBase.tarifas!) {
              element.tarifaBase = saveBaseTariff;

              if (saveBaseTariff?.upgradeCategoria != null) {
                element.tarifaAdulto1a2 = (element.tarifaAdulto1a2 ?? 0) +
                    (saveBaseTariff?.upgradeCategoria ?? 0);
              }

              if (saveBaseTariff?.upgradePaxAdic != null) {
                element.tarifaPaxAdicional = (element.tarifaPaxAdicional ?? 0) +
                    (saveBaseTariff?.upgradePaxAdic ?? 0);
              }

              if (saveBaseTariff?.upgradeMenor != null) {
                element.tarifaMenores7a12 = (element.tarifaMenores7a12 ?? 0) +
                    (saveBaseTariff?.upgradeMenor ?? 0);
              }

              final newTariff = await tarifaDao.save(element);

              if (newTariff == null) {
                throw Exception(
                    "Error al guardar la tarifa: ${element.categoria?.nombre}");
              }
              saveBaseTariff?.tarifas?.add(newTariff);
            }
          }

          await tarifaDao.close();
          await tarifaBaseDao.close();
        },
      );

      await db.close();
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, saveBaseTariff, invalideToken);
  }

  Future<Tuple3<ErrorModel?, bool, bool>> delete(TarifaBase tarifaBase) async {
    ErrorModel? error;
    bool invalideToken = false;
    bool deleted = false;

    try {
      final db = AppDatabase();

      await db.transaction(
        () async {
          final tarifaBaseDao = TarifaBaseDao(db);
          final tarifaDao = TarifaDao(db);
          final responseTB = await tarifaBaseDao.delet3(tarifaBase.idInt ?? 0);
          await tarifaDao.close();
          await tarifaBaseDao.close();

          if (responseTB == 0) {
            throw Exception("Error al eliminar la tarifa base");
          }
          deleted = responseTB > 0;
          // for (var element in tarifaBase.tarifas ?? <Tarifa>[]) {
          //   final responseT = await tarifaDao.delet3(element.idInt ?? 0);
          //   if (responseT == 0) {
          //     throw Exception(
          //         "Error al eliminar la tarifa: ${element.categoria?.nombre}");
          //   }
          // }
        },
      );

      await db.close();
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, deleted, invalideToken);
  }
}
