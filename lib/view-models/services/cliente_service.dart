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
    Cliente? savedCliente;

    try {
      final db = AppDatabase();
      final clienteDao = ClienteDao(db);
      savedCliente = await clienteDao.save(cliente);
      await clienteDao.close();
      await db.close();

      if (savedCliente == null) {
        throw Exception("Error al guardar el cliente");
      }
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, savedCliente, invalideToken);
  }

  Future<Tuple3<ErrorModel?, bool, bool>> delete(Cliente cliente) async {
    ErrorModel? error = ErrorModel();
    bool invalideToken = false;
    bool deleted = false;

    try {
      final db = AppDatabase();
      final clienteDao = ClienteDao(db);
      final response = await clienteDao.delet3(cliente.idInt ?? 0);
      deleted = response > 0;
      await clienteDao.close();
      await db.close();

      if (response == 0) {
        throw Exception("Error al eliminar el cliente");
      }
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }
    return Tuple3(error, deleted, invalideToken);
  }
}
