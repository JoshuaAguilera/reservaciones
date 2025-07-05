import 'package:tuple/tuple.dart';

import '../../database/dao/usuario_dao.dart';
import '../../database/database.dart';
import '../../models/error_model.dart';
import '../../models/usuario_model.dart';
import '../../utils/encrypt/encrypter.dart';
import 'base_service.dart';

class UsuarioService extends BaseService {
  Future<List<Usuario>> getList({
    String username = "",
    String correo = "",
    int? rolId,
    String estatus = 'registrado',
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
        sortSBy = "username";
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
      final usuarioDao = UsuarioDao(db);
      List<Usuario> list = await usuarioDao.getList(
        username: username,
        correo: correo,
        rolId: rolId,
        estatus: estatus,
        initDate: initDate,
        lastDate: lastDate,
        sortBy: sortSBy,
        order: ordenSBy,
        limit: limit,
        page: page,
        conDetalle: conDetalle,
      );

      await usuarioDao.close();
      await db.close();
      return list;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<Usuario?> getByID(int id) async {
    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      Usuario? user = await usuarioDao.getByID(id: id);
      await usuarioDao.close();
      await db.close();
      return user;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<Tuple3<ErrorModel?, Usuario?, bool>> saveData(
      Usuario user, String? newPassword) async {
    ErrorModel? error;
    bool invalideToken = false;
    Usuario? savedUser;

    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      if (newPassword != null && newPassword.isNotEmpty) {
        user.password = EncrypterTool.encryptData(newPassword, null);
      }

      savedUser = await usuarioDao.insert(user);
      if (savedUser == null) {
        error = ErrorModel(message: "Error al guardar el usuario.");
      }
      db.close();
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, savedUser, invalideToken);
  }

  Future<Tuple3<ErrorModel?, bool, bool>> delete(Usuario user) async {
    ErrorModel? error;
    bool invalideToken = false;
    bool success = false;

    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      int response = await usuarioDao.delet3(user.idInt ?? 0);
      success = response == 1;
      await usuarioDao.close();
      await db.close();
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, success, invalideToken);
  }
}
