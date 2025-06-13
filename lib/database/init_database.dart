import 'package:drift/drift.dart';

import '../utils/encrypt/encrypter.dart';
import 'database.dart';

class InitDatabase {
  static Future<void> iniciarBD() async {
    final db = AppDatabase();

    List<UsuarioTableData> allUsers = await db.select(db.usuarioTable).get();
    if (allUsers.isEmpty) {
      await db.into(db.usuarioTable).insert(
            UsuarioTableCompanion.insert(
              username: const Value('admin'),
              password: Value(EncrypterTool.encryptData("12345678", null)),
              rol: const Value("SUPERADMIN"),
              correoElectronico: const Value("sys2@coralbluehuatulco.mx"),
              passwordCorreo:
                  Value(EncrypterTool.encryptData("Sys2024CB", null)),
              // telefono: const Value("\+529581875040"),
              numCotizaciones: const Value(0),
              status: const Value("ACTIVO"),
            ),
          );
    }

    db.close();
  }
}
