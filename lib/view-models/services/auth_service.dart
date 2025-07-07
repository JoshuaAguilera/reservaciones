import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tuple/tuple.dart';

import '../../database/dao/usuario_dao.dart';
import '../../database/database.dart';
import '../../models/error_model.dart';
import '../../models/usuario_model.dart';
import '../../utils/shared_preferences/preferences.dart';
import 'base_service.dart';

class AuthService extends BaseService {
  Future<bool> searchToken() async {
    bool isValid = false;
    print('validar token: ${Preferences.token}');
    if (Preferences.token != '') isValid = await validToken();
    notifyListeners();
    return isValid;
  }

  Future<bool> validToken() async {
    bool status = false;
    status = await validTokenNW();
    return status;
  }

  Future<bool> validTokenNW() async {
    bool status = false;

    try {
      var response = await verifyJwtToken();
      if (!response) status = false;
      status = true;
    } catch (e) {
      print(e);
    }
    return status;
  }

  Future<bool> getUser(String username, [int? userId]) async {
    bool found = false;

    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);
      found = await usuarioDao.exists(username: username, id: userId);
      usuarioDao.close();
      db.close();
    } catch (e) {
      print(e);
    }
    return found;
  }

  Future<Tuple2<ErrorModel?, Usuario?>> loginUser(
    String username,
    String password,
  ) async {
    ErrorModel? error;
    Usuario? response;

    try {
      final db = AppDatabase();
      final usuarioDao = UsuarioDao(db);

      final existBD = await usuarioDao.exists(username: username);
      if (!existBD) throw Exception("Usuario no existe");

      response = await usuarioDao.getByID(
        username: username,
        password: password,
        notStatus: "inactivo",
      );

      db.close();
      usuarioDao.close();
      if (response == null) throw Exception("Credenciales invalidas");
      String token = await getTokenLocal(
        id: response.idInt ?? 0,
        username: response.username ?? '',
        rolId: response.rol?.idInt ?? 0,
      );

      Preferences.token = token;
      Preferences.mail = response.correoElectronico ?? '';
      Preferences.phone = response.telefono ?? '';
      Preferences.username = response.username ?? '';
      Preferences.password = response.password ?? '';
      Preferences.userIdInt = response.idInt ?? 0;
      Preferences.userId = response.id ?? '';
      Preferences.firstName = response.nombre ?? '';
      Preferences.lastName = response.apellido ?? '';
      Preferences.birthDate =
          response.fechaNacimiento?.toString().substring(0, 10) ?? '';
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }
    return Tuple2(error, response);
  }

// Instancia global de storage seguro
  final secureStorage = const FlutterSecureStorage();

// Guarda el secret key seguro
  Future<void> saveSecretKey(String secret) async {
    await secureStorage.write(key: 'jwt_secret', value: secret);
  }

// Obtiene el secret key seguro
  Future<String?> getSecretKey() async {
    return await secureStorage.read(key: 'jwt_secret');
  }

// Genera el secret la primera vez (aleatorio)
  Future<String> initializeSecretKey() async {
    String? existing = await getSecretKey();
    if (existing != null) return existing;

    // Generar clave aleatoria simple (mejor usar una mejor función en producción)
    final generated =
        List.generate(32, (i) => (i + 65).toRadixString(16)).join();
    await saveSecretKey(generated);
    return generated;
  }

// Ejemplo: Login local y generación de JWT
  Future<String> getTokenLocal({
    required int id,
    required String username,
    required int rolId,
    String role = 'user',
  }) async {
    final secret = await initializeSecretKey();

    final jwt = JWT(
      {
        'username': username,
        'id': id,
        'rol_id': rolId,
        'role': role,
      },
      issuer: 'local_app',
    );
    final token = jwt.sign(
      SecretKey(secret),
      expiresIn: const Duration(hours: 12),
    );

    // Puedes guardar el token para uso posterior
    await secureStorage.write(key: 'jwt_token', value: token);

    return token;
  }

// Verificación del JWT (para pantallas protegidas)
  Future<bool> verifyJwtToken() async {
    // final token = await secureStorage.read(key: 'jwt_token');
    final token = Preferences.token;
    final secret = await getSecretKey();
    if (token == null || secret == null) return false;

    try {
      JWT.verify(token, SecretKey(secret));
      return true;
    } catch (e) {
      return false;
    }
  }

// Cerrar sesión
  Future<void> logout() async {
    await secureStorage.delete(key: 'jwt_token');
  }
}
