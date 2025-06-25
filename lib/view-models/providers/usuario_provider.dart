import 'package:riverpod/riverpod.dart';

import '../../database/database.dart';
import '../../models/imagen_model.dart';
import '../services/auth_service.dart';
import '../../utils/shared_preferences/preferences.dart';

final userProvider = StateProvider<UsuarioTableData>((ref) {
  return const UsuarioTableData(
    id: 0,
    username: "",
    password: "",
    rol: "",
    correoElectronico: "",
  );
});

final imagePerfilProvider = StateProvider<Imagen>((ref) {
  return Imagen(nombre: Preferences.userId);
});

final changeUsersProvider = StateProvider<int>((ref) {
  return 0;
});

final isEmptyUserProvider = StateProvider<bool>((ref) => false);

final foundImageFileProvider = StateProvider<bool>((ref) => false);

final searchUserProvider = StateProvider<String>((ref) => '');

final userQueryProvider =
    FutureProvider.family<List<UsuarioTableData>, String>((ref, arg) async {
  // final period = ref.watch(periodoProvider);
  final empty = ref.watch(isEmptyUserProvider);
  final search = ref.watch(searchUserProvider);
  // final pag = ref.watch(paginaProvider);
  // final filter = ref.watch(filtroProvider);

  final detectChanged = ref.watch(changeUsersProvider);

  final list = await AuthService().getUsers(search, empty);
  return list;
});
