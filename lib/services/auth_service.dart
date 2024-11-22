import 'package:drift/drift.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/services/base_service.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';

import '../utils/encrypt/encrypter.dart';

class AuthService extends BaseService {
  Future<bool> foundUserName(String userName, [int? userId]) async {
    List<UsuarioData> users = [];

    try {
      final db = AppDatabase();
      users = await db.getUsuariosByUsername(userName, userId);
      db.close();
    } catch (e) {
      print(e);
    }
    return users.isNotEmpty;
  }

  Future<bool> loginUser(String userName, String password) async {
    final db = AppDatabase();
    List<UsuarioData> users =
        await db.loginUser(userName, EncrypterTool.encryptData(password, null));
    db.close();
    return users.isNotEmpty;
  }

  Future<UsuarioData> savePerfil(String user, String password) async {
    final db = AppDatabase();
    List<UsuarioData> users =
        await db.loginUser(user, EncrypterTool.encryptData(password, null));

    Preferences.mail = users.first.correoElectronico ?? '';
    Preferences.passwordMail = users.first.passwordCorreo ?? '';
    Preferences.phone = users.first.telefono ?? '';
    Preferences.rol = users.first.rol ?? '';
    Preferences.username = users.first.username ?? '';
    Preferences.password = users.first.password ?? '';
    Preferences.userId = users.first.id;

    Preferences.firstName = users.first.nombre ?? '';
    Preferences.lastName = users.first.apellido ?? '';
    Preferences.birthDate = users.first.fechaNacimiento ?? '';
    Preferences.numberQuotes = users.first.numCotizaciones ?? 0;

    db.close();

    return users.first;
  }

  Future<bool> deleteUser(UsuarioData user) async {
    bool success = false;

    try {
      final db = AppDatabase();
      int response = await db.deleteUsuario(user);
      success = response == 1;
      db.close();
    } catch (e) {
      print(e);
    }

    return success;
  }

  Future<bool> updateUser(UsuarioData user) async {
    bool success = false;

    try {
      final db = AppDatabase();
      int response = await db.updateUsuario(user);
      success = response != 1;
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
      int response = await db.updatePasswordUser(userId, username, newPassword);
      success = response != 1;
      db.close();
    } catch (e) {
      print(e);
    }

    return success;
  }

  Future<bool> updatePasswordMail(
      int userId, String username, String newPassword) async {
    bool success = false;

    try {
      final db = AppDatabase();
      int response = await db.updatePasswordMail(userId, username, newPassword);
      success = response != 1;
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
              username: user?.username ?? '',
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
