import '../utils/encrypt/encrypter.dart';
import 'database.dart';

class InitDatabase {
  static Future<void> iniciarBD() async {
    final db = AppDatabase();

    List<User> allUsers = await db.select(db.users).get();
    if (allUsers.isEmpty) {
      await db.into(db.users).insert(
            UsersCompanion.insert(
              name: 'admin',
              password: EncrypterTool.encryptData("12345678", null),
              rol: "SUPERADMIN",
              mail: "sys2@coralbluehuatulco.mx",
              passwordMail: EncrypterTool.encryptData("Sys2024CB", null),
              phone: "\+529581875040",
            ),
          );
    }

    db.close();
  }
}
