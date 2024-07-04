import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';

import '../encrypt/encrypter.dart';

class AuthService extends ChangeNotifier {
  Future<bool> foundUserName(String userName) async {
    final db = AppDatabase();
    List<User> users = await db.foundUserByName(userName);
    return users.isNotEmpty;
  }

  Future<bool> loginUser(String userName, String password) async {
    final db = AppDatabase();
    List<User> users =
        await db.loginUser(userName, EncrypterTool.encryptData(password, null));
    return users.isNotEmpty;
  }
}
