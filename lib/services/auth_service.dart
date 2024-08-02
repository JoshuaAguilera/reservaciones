import 'package:drift/drift.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/services/base_service.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';

import '../utils/encrypt/encrypter.dart';

class AuthService extends BaseService {
  Future<bool> foundUserName(String userName) async {
    final db = AppDatabase();
    List<User> users = await db.foundUserByName(userName);
    db.close();
    return users.isNotEmpty;
  }

  Future<bool> loginUser(String userName, String password) async {
    final db = AppDatabase();
    List<User> users =
        await db.loginUser(userName, EncrypterTool.encryptData(password, null));
    db.close();
    return users.isNotEmpty;
  }

  Future<User> savePerfil(String user, String password) async {
    final db = AppDatabase();
    List<User> users =
        await db.loginUser(user, EncrypterTool.encryptData(password, null));

    Preferences.mail = users.first.mail ?? '';
    Preferences.passwordMail = users.first.passwordMail ?? '';
    Preferences.phone = users.first.phone ?? '';
    Preferences.rol = users.first.rol ?? '';
    Preferences.username = users.first.name ?? '';
    Preferences.password = users.first.password ?? '';

    Preferences.firstName = users.first.firstName ?? '';
    Preferences.lastName = users.first.secondName ?? '';
    Preferences.birthDate = users.first.birthDate ?? '';
    db.close();

    return users.first;
  }

  Future<bool> updateUser(User user) async {
    bool success = false;

    final db = AppDatabase();
    int response = await db.updateInfoUser(user);
    success = db == 1;
    db.close();

    return success;
  }

  Future<bool> updatePasswordUser(int userId, String newPassword) async {
    bool success = false;

    final db = AppDatabase();
    int response = await db.updatePasswordUser(userId, newPassword);
    success = db == 1;
    db.close();

    return success;
  }

  Future<bool> updatePasswordMail(int userId, String newPassword) async {
    bool success = false;

    final db = AppDatabase();
    int response = await db.updatePasswordMailUser(userId, newPassword);
    success = db == 1;
    db.close();

    return success;
  }

  Future<List<User>> getUsers() async {
    List<User> users = [];

    final db = AppDatabase();
    users = await db.getListUser();
    db.close();

    return users;
  }

  Future<bool> saveUsers(User? user) async {
    final database = AppDatabase();

    try {
      await database.into(database.users).insert(
            UsersCompanion.insert(
              name: Value(user?.name ?? ''),
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
