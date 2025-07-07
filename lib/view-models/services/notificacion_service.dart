import 'package:tuple/tuple.dart';

import '../../database/dao/notificacion_dao.dart';
import '../../database/database.dart';
import '../../models/error_model.dart';
import '../../models/notificacion_model.dart';
import 'base_service.dart';

class NotificacionService extends BaseService {
  Future<List<Notificacion>> getList({
    String tipo = "",
    String documento = "",
    int? idUsuario,
    String estatus = '',
    DateTime? initDate,
    DateTime? lastDate,
    String sortBy = 'created_at',
    String orderBy = 'asc',
    int limit = 20,
    int page = 1,
    bool conDetalle = false,
  }) async {
    String ordenSBy = "asc";
    String sortSBy = "createdAt";

    switch (orderBy) {
      case "T":
        sortSBy = "tipo";
        ordenSBy = "asc";
        break;
      case "D":
        sortSBy = "documento";
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
      final notificacionDao = NotificacionDao(db);
      List<Notificacion> list = await notificacionDao.getList(
        tipo: tipo,
        estatus: estatus,
        initDate: initDate,
        lastDate: lastDate,
        documento: documento,
        idUsuario: idUsuario,
        page: page,
        limit: limit,
        orderBy: ordenSBy,
        sortBy: sortSBy,
        conDetalle: conDetalle,
      );

      await notificacionDao.close();
      await db.close();
      return list;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<Notificacion?> getById(int id) async {
    try {
      final db = AppDatabase();
      final notificacionDao = NotificacionDao(db);
      Notificacion? notificacion = await notificacionDao.getByID(id);
      await notificacionDao.close();
      await db.close();
      return notificacion;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Tuple3<ErrorModel?, Notificacion?, bool>> saveData(
      {required Notificacion notificacion}) async {
    ErrorModel? error;
    bool invalideToken = false;
    Notificacion? notificacionSaved;

    try {
      final db = AppDatabase();
      final notificacionDao = NotificacionDao(db);
      notificacionSaved = await notificacionDao.save(notificacion);

      if (notificacionSaved == null) {
        throw Exception("Error al guardar la notificación");
      }
      await notificacionDao.close();
      await db.close();
    } catch (e) {
      print(e);
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, notificacionSaved, invalideToken);
  }

  Future<Tuple3<ErrorModel?, bool, bool>> delete(
      Notificacion? notificacion) async {
    ErrorModel? error;
    bool invalideToken = false;
    bool success = false;

    try {
      final db = AppDatabase();
      final notificacionDao = NotificacionDao(db);
      int response = await notificacionDao.delet3(notificacion?.idInt ?? 0);
      success = response > 0;
      await notificacionDao.close();
      await db.close();
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, success, invalideToken);
  }
}
