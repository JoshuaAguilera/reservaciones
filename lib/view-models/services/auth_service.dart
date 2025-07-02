import 'package:drift/drift.dart';
import 'package:tuple/tuple.dart';

import '../../database/dao/usuario_dao.dart';
import '../../database/database.dart';
import '../../models/imagen_model.dart';
import '../../models/usuario_model.dart';
import '../../utils/shared_preferences/preferences.dart';
import 'base_service.dart';

class AuthService extends BaseService {
  Future<bool> getUser(String username, [int? userId]) async {
    bool found = false;

    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      found = await usuarioDao.exists(username: username, id: userId);
      usuarioDao.close();
      db.close();
    } catch (e) {
      print(e);
    }
    return found;
  }

  Future<Tuple2<String?, Usuario?>> loginUser(
    String username,
    String password,
  ) async {
    Usuario? response;
    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      response = await usuarioDao.get(
        username: username,
        password: password,
        notStatus: "inactivo",
      );

      db.close();
      usuarioDao.close();
      if (response == null) return const Tuple2("Credenciales invalidas", null);

      Preferences.mail = response.correoElectronico ?? '';
      Preferences.phone = response.telefono ?? '';
      Preferences.username = response.username ?? '';
      Preferences.password = response.password ?? '';
      Preferences.userIdInt = response.idInt ?? 0;
      Preferences.userId = response.id ?? '';
      Preferences.firstName = response.nombre ?? '';
      Preferences.lastName = response.apellido ?? '';
      Preferences.birthDate =
          response.fechaNacimiento?.toString().substring(0, 10) ?? '';
    } catch (e) {
      print(e);
      return Tuple2("Error: ${e.toString()}", null);
    }
    return Tuple2(null, response);
  }

  Future<bool> deleteUser(Usuario user) async {
    bool success = false;

    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      int response = await usuarioDao.delet3(user.idInt ?? 0);
      success = response == 1;
      usuarioDao.close();
      db.close();
    } catch (e) {
      print(e);
    }

    return success;
  }

  Future<bool> updateUser(Usuario user) async {
    bool success = false;

    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      bool response = await usuarioDao.updat3(user);
      success = response;
      db.close();
    } catch (e) {
      print(e);
    }

    return success;
  }

  Future<bool> updatePasswordUser(
      int userId, String username, String newPassword) async {
    bool success = false;

    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      bool response = await usuarioDao.updat3(Usuario(
        idInt: userId,
        username: username,
        password: newPassword,
      ));
      success = response;
      db.close();
    } catch (e) {
      print(e);
    }

    return success;
  }

  Future<bool> updateImagePerfil(int userId, String username, int intId) async {
    bool success = false;

    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      Usuario user = Usuario(idInt: userId, imagen: Imagen(idInt: intId));
      bool response = await usuarioDao.updat3(user);
      success = response;
      db.close();
    } catch (e) {
      print(e);
    }

    return success;
  }

  Future<List<Usuario>> getUsers(String search, bool empty) async {
    List<Usuario> users = [];

    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      if (empty) {
        users = await usuarioDao.getList();
      } else {
        users = await usuarioDao.getList(username: search);
      }
      db.close();
    } catch (e) {
      print(e);
    }

    return users;
  }

  Future<bool> saveUsers(UsuarioTableData? user) async {
    final database = AppDatabase();

    try {
      await database.into(database.usuarioTable).insert(
            UsuarioTableCompanion.insert(
              username: Value(user?.username ?? ''),
              password: Value(user?.password ?? ''),
              rol: Value(user?.rol ?? ''),
              estatus: const Value("registrado"),
            ),
          );
      await database.close();
      return true;
    } catch (e) {
      print(e);
      await database.close();
      return false;
    }
  }
}
