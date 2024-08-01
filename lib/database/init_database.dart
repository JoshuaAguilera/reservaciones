import 'package:drift/drift.dart';

import '../utils/encrypt/encrypter.dart';
import 'database.dart';

class InitDatabase {
  static Future<void> iniciarBD() async {
    final db = AppDatabase();

    List<User> allUsers = await db.select(db.users).get();
    if (allUsers.isEmpty) {
      await db.into(db.users).insert(
            UsersCompanion.insert(
              name: const Value('admin'),
              password: Value(EncrypterTool.encryptData("12345678", null)),
              rol: const Value("SUPERADMIN"),
              mail: const Value("sys2@coralbluehuatulco.mx"),
              passwordMail: Value(EncrypterTool.encryptData("Sys2024CB", null)),
              phone: const Value("\+529581875040"),
            ),
          );
    }

    db.close();
  }
}
