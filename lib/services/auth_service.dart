import 'package:drift/drift.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/services/base_service.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';

import '../utils/encrypt/encrypter.dart';

class AuthService extends BaseService {
  Future<bool> foundUserName(String userName, [int? id]) async {
    final db = AppDatabase();
    List<UsuarioData> users = await db.getUsuariosByUsername(userName);
    db.close();

    // if(id != null) {
    //   return users.

    // }
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

    Preferences.firstName = users.first.nombre ?? '';
    Preferences.lastName = users.first.apellido ?? '';
    Preferences.birthDate = users.first.fechaNacimiento ?? '';
    Preferences.numberQuotes = users.first.numCotizaciones ?? 0;

    db.close();

    return users.first;
  }

  Future<bool> updateUser(UsuarioData user) async {
    bool success = false;

    final db = AppDatabase();
    int response = await db.updateUsuario(user);
    success = db == 1;
    db.close();

    return success;
  }

  Future<bool> updatePasswordUser(
      int userId, String username, String newPassword) async {
    bool success = false;

    final db = AppDatabase();
    int response = await db.updatePasswordUser(userId, username, newPassword);
    success = db == 1;
    db.close();

    return success;
  }

  Future<bool> updatePasswordMail(
      int userId, String username, String newPassword) async {
    bool success = false;

    final db = AppDatabase();
    int response =
        await db.updatePasswordMailUser(userId, username, newPassword);
    success = db == 1;
    db.close();

    return success;
  }

  Future<List<UsuarioData>> getUsers() async {
    List<UsuarioData> users = [];

    final db = AppDatabase();
    users = await db.getListUser();
    db.close();

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
