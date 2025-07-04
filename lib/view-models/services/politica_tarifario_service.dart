import 'package:tuple/tuple.dart';

import '../../database/dao/politica_tarifario_dao.dart';
import '../../database/database.dart';
import '../../models/error_model.dart';
import '../../models/politica_tarifario_model.dart';
import 'base_service.dart';

class PoliticaTarifarioService extends BaseService {
  Future<List<PoliticaTarifario>> getList({
    String clave = "",
    String descripcion = "",
    int? creadorId,
    DateTime? initDate,
    DateTime? lastDate,
    String sortBy = 'created_at',
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
      final politicaTarifarioDao = PoliticaTarifarioDao(db);
      List<PoliticaTarifario> list = await politicaTarifarioDao.getList(
        clave: clave,
        descripcion: descripcion,
        creadorId: creadorId,
        initDate: initDate,
        lastDate: lastDate,
        sortBy: sortSBy,
        order: ordenSBy,
        limit: limit,
        page: page,
      );

      await politicaTarifarioDao.close();
      await db.close();
      return list;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<PoliticaTarifario?> getByID(int id) async {
    try {
      final db = AppDatabase();
      final politicaTarifarioDao = PoliticaTarifarioDao(db);
      PoliticaTarifario? politica = await politicaTarifarioDao.getByID(id);
      await politicaTarifarioDao.close();
      await db.close();
      return politica;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Tuple3<ErrorModel?, PoliticaTarifario?, bool>?> saveData(
      PoliticaTarifario politica) async {
    ErrorModel error = ErrorModel();
    bool invalideToken = false;

    try {
      final db = AppDatabase();
      final politicaTarifarioDao = PoliticaTarifarioDao(db);
      PoliticaTarifario? savedPolitica =
          await politicaTarifarioDao.save(politica);
      await politicaTarifarioDao.close();
      await db.close();

      return Tuple3(null, savedPolitica, invalideToken);
    } catch (e) {
      error.message = e.toString();
      return Tuple3(error, null, invalideToken);
    }
  }

  Future<Tuple3<ErrorModel?, bool, bool>> delete(
      PoliticaTarifario politica) async {
    ErrorModel? error = ErrorModel();
    bool invalideToken = false;

    try {
      final db = AppDatabase();

      await db.transaction(
        () async {
          final politicaDao = PoliticaTarifarioDao(db);

          final response = await politicaDao.delet3(politica.idInt ?? 0);
          if (response == 0) {
            throw Exception("Error al eliminar la politica de tarifario");
          }

          await politicaDao.close();
        },
      );

      await db.close();
      return Tuple3(null, true, invalideToken);
    } catch (e) {
      error.message = e.toString();
      return Tuple3(error, false, invalideToken);
    }
  }
}
