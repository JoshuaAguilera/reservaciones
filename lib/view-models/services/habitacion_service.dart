import '../../database/dao/habitacion_dao.dart';
import '../../database/database.dart';
import '../../models/habitacion_model.dart';
import 'base_service.dart';

class HabitacionService extends BaseService {
  Future<List<Habitacion>> getList({
    int? cotizacionId,
    DateTime? initDate,
    DateTime? lastDate,
    String sortBy = '',
    String orderBy = '',
    int pagina = 1,
    int limit = 20,
    bool conDetalle = false,
  }) async {
    String sortSBy = "";
    String ordenSBy = "asc";

    switch (orderBy) {
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
      final habDao = HabitacionDao(db);
      List<Habitacion> resp = await habDao.getList(
        page: pagina,
        limit: limit,
        initDate: initDate,
        lastDate: lastDate,
        orderBy: ordenSBy,
        sortBy: sortSBy,
      );

      await habDao.close();
      await db.close();
      return resp;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
