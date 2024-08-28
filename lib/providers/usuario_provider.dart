import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/services/auth_service.dart';
import 'package:riverpod/riverpod.dart';

final userProvider = StateProvider<UsuarioData>((ref) {
  return const UsuarioData(
    id: 0,
    username: "",
    password: "",
    rol: "",
    correoElectronico: "",
    passwordCorreo: "",
  );
});

final allUsersProvider =
    FutureProvider.family<List<UsuarioData>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeUsersProvider);
  final list = await AuthService().getUsers();
  return list;
});

final changeUsersProvider = StateProvider<int>((ref) {
  return 0;
});
