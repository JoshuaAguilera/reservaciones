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
    ErrorModel? error;
    bool invalideToken = false;
    PoliticaTarifario? savedPolitica;

    try {
      final db = AppDatabase();
      final politicaTarifarioDao = PoliticaTarifarioDao(db);
      savedPolitica = await politicaTarifarioDao.save(politica);
      await politicaTarifarioDao.close();
      await db.close();

      if (savedPolitica == null) {
        throw Exception("Error al guardar la política de tarifario");
      }
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, savedPolitica, invalideToken);
  }

  Future<Tuple3<ErrorModel?, bool, bool>> delete(
      PoliticaTarifario politica) async {
    ErrorModel? error = ErrorModel();
    bool invalideToken = false;
    bool deleted = false;

    try {
      final db = AppDatabase();
      final politicaDao = PoliticaTarifarioDao(db);
      final response = await politicaDao.delet3(politica.idInt ?? 0);
      await politicaDao.close();
      await db.close();
      if (response == 0) {
        throw Exception("Error al eliminar la politica de tarifario");
      }

      if (response > 0) deleted = true;
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, deleted, invalideToken);
  }
}
