import '../../database/database.dart';
import '../../models/tarifa_rack_model.dart';
import 'base_service.dart';

class TarifaRackService extends BaseService {
  Future<List<TarifaRack>> getList({
    int? tarifaBaseId,
    int? categoriaId,
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
      final tarifaRackDao = db.tarifaRackDao;

      final list = await tarifaRackDao.getList(
        
        initDate: initDate,
        lastDate: lastDate,
        sortBy: sortSBy,
        order: ordenSBy,
        limit: limit,
        page: page,
      );
    } catch (e) {
      print(e);
    }
  }
}
