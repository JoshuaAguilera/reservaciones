import 'package:drift/drift.dart';

import '../utils/encrypt/encrypter.dart';
import 'dao/usuario_dao.dart';
import 'database.dart';

class InitDatabase {
  static Future<void> iniciarBD() async {
    final db = AppDatabase();
    final usuarioDao = UsuarioDao(db);

    List<UsuarioTableData> allUsers = await db.select(db.usuarioTable).get();
    if (allUsers.isEmpty) {
      await usuarioDao.insert(
        UsuarioTableCompanion.insert(
          username: const Value('admin'),
          password: Value(EncrypterTool.encryptData("12345678", null)),
          rol: const Value("SUPERADMIN"),
          correoElectronico: const Value("sys2@coralbluehuatulco.mx"),
          estatus: const Value("registrado"),
        ),
      );
    }

    db.close();
  }
}
