import 'package:flutter/material.dart';
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

  Future<void> savePerfil(String user, String password) async {
    final db = AppDatabase();
    List<User> users =
        await db.loginUser(user, EncrypterTool.encryptData(password, null));

    Preferences.mail = users.first.mail;
    Preferences.passwordMail = users.first.passwordMail;
    Preferences.phone = int.parse(users.first.phone);
    Preferences.rol = users.first.rol;
    Preferences.username = users.first.name;

    db.close();
  }
}
