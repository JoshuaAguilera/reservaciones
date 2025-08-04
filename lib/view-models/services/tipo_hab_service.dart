import 'package:tuple/tuple.dart';

import '../../database/dao/tipo_hab_dao.dart';
import '../../database/database.dart';
import '../../models/error_model.dart';
import '../../models/tipo_habitacion_model.dart';
import 'base_service.dart';

class TipoHabService extends BaseService {
  Future<int> count() async {
    try {
      final db = AppDatabase();
      final tipoHabitacionDao = TipoHabitacionDao(db);
      final count = await tipoHabitacionDao.count();
      await tipoHabitacionDao.close();
      await db.close();
      return count;
    } catch (e) {
      print(e);
    }
    return 0;
  }

  Future<List<TipoHabitacion>> getList({
    String descripcion = "",
    String codigo = "",
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
        sortSBy = "descripcion";
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
      final tipoHabitacionDao = TipoHabitacionDao(db);
      List<TipoHabitacion> list = await tipoHabitacionDao.getList(
        descripcion: descripcion,
        codigo: codigo,
        initDate: initDate,
        lastDate: lastDate,
        sortBy: sortSBy,
        order: ordenSBy,
        limit: limit,
        page: page,
      );

      await tipoHabitacionDao.close();
      await db.close();
      return list;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<TipoHabitacion?> getByID(int id) async {
    try {
      final db = AppDatabase();
      final tipoHabitacionDao = TipoHabitacionDao(db);
      final tipoHabitacion = await tipoHabitacionDao.getByID(id);
      await tipoHabitacionDao.close();
      await db.close();
      return tipoHabitacion;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Tuple3<ErrorModel?, TipoHabitacion?, bool>> saveData(
      TipoHabitacion tipoHabitacion) async {
    ErrorModel? error;
    bool invalideToken = false;
    TipoHabitacion? savedTipoHabitacion;

    try {
      final db = AppDatabase();
      savedTipoHabitacion = await db.tipoHabitacionDao.save(tipoHabitacion);
      await db.close();

      if (savedTipoHabitacion == null) {
        throw Exception("Error al guardar el tipo de habitación");
      }
    } catch (e) {
      print(e); // Log the error
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, savedTipoHabitacion, invalideToken);
  }

  Future<Tuple2<ErrorModel?, bool>> delete(
    TipoHabitacion tipoHabitacion,
  ) async {
    ErrorModel? error;
    bool invalideToken = false;
    final db = AppDatabase();

    try {
      final response =
          await db.tipoHabitacionDao.delet3(tipoHabitacion.idInt ?? 0);
      if (response == 0) {
        throw Exception("Error al eliminar el tipo de habitación");
      }
    } catch (e) {
      print(e);
      error = ErrorModel(message: e.toString());
    }

    await db.close();
    return Tuple2(error, invalideToken);
  }
}
