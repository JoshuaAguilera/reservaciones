import 'package:drift/drift.dart';

import '../database/dao/usuario_dao.dart';
import '../database/database.dart';
import '../utils/encrypt/encrypter.dart';
import '../utils/shared_preferences/preferences.dart';
import 'base_service.dart';

class AuthService extends BaseService {
  Future<bool> foundUserName(String userName, [int? userId]) async {
    List<UsuarioTableData> users = [];

    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      users = await usuarioDao.getList(
        nombre: userName,
        id: userId,
      );
      db.close();
    } catch (e) {
      print(e);
    }
    return users.isNotEmpty;
  }

  Future<bool> loginUser(String userName, String password) async {
    List<UsuarioTableData> users = [];

    try {
      final db = AppDatabase();
      users = await db.loginUser(
          userName, EncrypterTool.encryptData(password, null));
      db.close();
    } catch (e) {
      print(e);
    }
    return users.isNotEmpty;
  }

  Future<UsuarioTableData> savePerfil(String user, String password) async {
    final db = AppDatabase();
    List<UsuarioTableData> users =
        await db.loginUser(user, EncrypterTool.encryptData(password, null));

    Preferences.mail = users.first.correoElectronico ?? '';
    Preferences.phone = users.first.telefono ?? '';
    Preferences.rol = users.first.rol ?? '';
    Preferences.username = users.first.username ?? '';
    Preferences.password = users.first.password ?? '';
    Preferences.userId = users.first.id;

    Preferences.firstName = users.first.nombre ?? '';
    Preferences.lastName = users.first.apellido ?? '';
    Preferences.birthDate = users.first.fechaNacimiento ?? '';

    db.close();

    return users.first;
  }

  Future<bool> deleteUser(UsuarioTableData user) async {
    bool success = false;

    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      int response = await usuarioDao.delet3(user.id);
      success = response == 1;
      db.close();
    } catch (e) {
      print(e);
    }

    return success;
  }

  Future<bool> updateUser(UsuarioTableData user) async {
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
      bool response = await usuarioDao.updat3(UsuarioTableData(
        id: userId,
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
      int response = await db.updateImageUser(userId, username, intId);
      success = response != 1;
      db.close();
    } catch (e) {
      print(e);
    }

    return success;
  }

  Future<List<UsuarioData>> getUsers(String search, bool empty) async {
    List<UsuarioData> users = [];

    try {
      final db = AppDatabase();
      if (empty) {
        users = await db.getListUser(userId);
      } else {
        users = await db.getUsersSearch(search, userId);
      }
      db.close();
    } catch (e) {
      print(e);
    }

    return users;
  }

  Future<bool> saveUsers(UsuarioData? user) async {
    final database = AppDatabase();

    try {
      await database.into(database.usuario).insert(
            UsuarioCompanion.insert(
              username: Value(user?.username ?? ''),
              password: Value(user?.password ?? ''),
              rol: Value(user?.rol ?? ''),
              status: const Value("ACTIVO"),
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
