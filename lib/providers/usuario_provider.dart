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

final changeUsersProvider = StateProvider<int>((ref) {
  return 0;
});

final isEmptyUserProvider = StateProvider<bool>((ref) => false);

final searchUserProvider = StateProvider<String>((ref) => '');

final userQueryProvider =
    FutureProvider.family<List<UsuarioData>, String>((ref, arg) async {
  // final period = ref.watch(periodoProvider);
  final empty = ref.watch(isEmptyUserProvider);
  final search = ref.watch(searchUserProvider);
  // final pag = ref.watch(paginaProvider);
  // final filter = ref.watch(filtroProvider);

  final detectChanged = ref.watch(changeUsersProvider);

  final list = await AuthService().getUsers(search, empty);
  return list;
});
