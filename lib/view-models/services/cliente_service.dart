import 'package:tuple/tuple.dart';

import '../../database/dao/cliente_dao.dart';
import '../../database/database.dart';
import '../../models/cliente_model.dart';
import '../../models/error_model.dart';
import 'base_service.dart';

class ClienteService extends BaseService {
  Future<List<Cliente>> getList({
    String nombre = "",
    String correo = "",
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
      final clienteDao = ClienteDao(db);
      List<Cliente> list = await clienteDao.getList(
        nombre: nombre,
        correo: correo,
        initDate: initDate,
        lastDate: lastDate,
        sortBy: sortSBy,
        order: ordenSBy,
        limit: limit,
        page: page,
      );

      await clienteDao.close();
      await db.close();
      return list;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<Cliente?> getByID(int id) async {
    try {
      final db = AppDatabase();
      final clienteDao = ClienteDao(db);
      Cliente? cliente = await clienteDao.getByID(id);
      await clienteDao.close();
      await db.close();
      return cliente;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Tuple3<ErrorModel?, Cliente?, bool>> saveData(Cliente cliente) async {
    ErrorModel error = ErrorModel();
    bool invalideToken = false;

    try {
      final db = AppDatabase();
      final clienteDao = ClienteDao(db);
      Cliente? savedCliente = await clienteDao.save(cliente);
      if (savedCliente == null) {
        throw Exception("Error al guardar el cliente");
      }

      await clienteDao.close();
      await db.close();
      return Tuple3(null, savedCliente, invalideToken);
    } catch (e) {
      error.message = e.toString();
      return Tuple3(error, null, invalideToken);
    }
  }

  Future<Tuple3<ErrorModel?, bool, bool>> delete(Cliente cliente) async {
    ErrorModel? error = ErrorModel();
    bool invalideToken = false;

    try {
      final db = AppDatabase();

      await db.transaction(
        () async {
          final clienteDao = ClienteDao(db);

          final response = await clienteDao.delet3(cliente.idInt ?? 0);
          if (response == 0) {
            throw Exception("Error al eliminar el cliente");
          }

          await clienteDao.close();
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
