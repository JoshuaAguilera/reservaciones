import 'package:tuple/tuple.dart';

import '../../database/dao/rol_dao.dart';
import '../../database/database.dart';
import '../../models/error_model.dart';
import '../../models/rol_model.dart';
import 'base_service.dart';

class RolService extends BaseService {
  Future<List<Rol>> getList({
    String nombre = "",
    String codigo = "",
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
        break;
      case "MR":
        sortSBy = "createdAt";
        ordenSBy = "desc";
        break;
      case "MA":
        sortSBy = "createdAt";
        ordenSBy = "asc";
        break;
      default:
        sortSBy = "createdAt";
        ordenSBy = "asc";
    }

    try {
      final db = AppDatabase();
      final rolDao = RolDao(db);
      List<Rol> list = await rolDao.getList(
        nombre: nombre,
        initDate: initDate,
        lastDate: lastDate,
        sortBy: sortSBy,
        order: ordenSBy,
        limit: limit,
        page: page,
      );

      await rolDao.close();
      await db.close();
      return list;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<Rol?> getByID(int id) async {
    try {
      final db = AppDatabase();
      final rolDao = RolDao(db);
      Rol? rol = await rolDao.getByID(id);
      await rolDao.close();
      await db.close();
      return rol;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Tuple3<ErrorModel?, Rol?, bool>> saveData(Rol rol) async {
    ErrorModel? error;
    Rol? savedRol;
    bool invalideToken = false;

    try {
      final db = AppDatabase();
      final rolDao = RolDao(db);
      savedRol = await rolDao.save(rol);
      rolDao.close();
      db.close();

      if (savedRol == null) throw Exception("Error al guardar el rol");
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, savedRol, invalideToken);
  }

  Future<Tuple3<ErrorModel?, bool, bool>> delete(Rol rol) async {
    ErrorModel? error;
    bool invalideToken = false;
    bool success = false;

    try {
      final db = AppDatabase();
      final rolDao = RolDao(db);
      int response = await rolDao.delet3(rol.idInt ?? 0);
      await rolDao.close();
      await db.close();

      if (response == 0) {
        error = ErrorModel(message: "Error al eliminar el rol");
      }
      success = response == 1;
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, success, invalideToken);
  }
}
