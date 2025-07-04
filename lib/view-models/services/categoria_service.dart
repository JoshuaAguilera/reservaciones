import 'package:tuple/tuple.dart';

import '../../database/dao/categoria_dao.dart';
import '../../database/database.dart';
import '../../models/categoria_model.dart';
import '../../models/error_model.dart';
import 'base_service.dart';

class CategoriaService extends BaseService {
  Future<List<Categoria>> getList({
    String nombre = "",
    String codigoHab = "",
    int? creadorId,
    int? tipoHabId,
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
      final categoriaDao = CategoriaDao(db);
      List<Categoria> list = await categoriaDao.getList(
        nombre: nombre,
        creadorId: creadorId,
        tipoHabId: tipoHabId,
        codigoHab: codigoHab,
        initDate: initDate,
        lastDate: lastDate,
        sortBy: sortSBy,
        order: ordenSBy,
        limit: limit,
        page: page,
        conDetalle: conDetalle,
      );

      await categoriaDao.close();
      await db.close();
      return list;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<Categoria?> getByID(int id) async {
    try {
      final db = AppDatabase();
      final categoriaDao = CategoriaDao(db);
      final categoria = await categoriaDao.getByID(id);
      await categoriaDao.close();
      await db.close();
      return categoria;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Tuple3<ErrorModel?, Categoria?, bool>> saveData(
      Categoria categoria) async {
    ErrorModel error = ErrorModel();
    bool invalideToken = false;

    try {
      final db = AppDatabase();
      final categoriaDao = CategoriaDao(db);
      final savedCategoria = await categoriaDao.save(categoria);
      if (savedCategoria == null) {
        throw Exception("Error al guardar el categoria");
      }

      await categoriaDao.close();
      await db.close();
      return Tuple3(null, savedCategoria, invalideToken);
    } catch (e) {
      error.message = e.toString();
      return Tuple3(error, null, invalideToken);
    }
  }

  Future<Tuple3<ErrorModel?, bool, bool>> delete(Categoria categoria) async {
    ErrorModel? error = ErrorModel();
    bool invalideToken = false;

    try {
      final db = AppDatabase();

      await db.transaction(
        () async {
          final categoriaDao = CategoriaDao(db);

          final response = await categoriaDao.delet3(categoria.idInt ?? 0);
          if (response == 0) {
            throw Exception("Error al eliminar el categoria");
          }

          await categoriaDao.close();
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
