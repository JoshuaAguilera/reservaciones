import '../models/usuario_model.dart';
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
        Usuario(
          username: 'admin',
          password: EncrypterTool.encryptData("12345678", null),
          correoElectronico: "sys2@coralbluehuatulco.mx",
          estatus: "Registrado",
        ),
      );
    }

    db.close();
  }
}
