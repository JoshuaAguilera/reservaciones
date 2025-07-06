import 'package:riverpod/riverpod.dart';

import '../../models/imagen_model.dart';
import '../../models/usuario_model.dart';
import '../services/auth_service.dart';
import '../../utils/shared_preferences/preferences.dart';
import '../services/usuario_service.dart';

final getUserProvider = FutureProvider<Usuario?>((ref) async {
  final userId = Preferences.userIdInt;
  if (userId == 0) return null;
  final user = await UsuarioService().getByID(userId);
  ref.watch(userProvider.notifier).state = user;
  ref.watch(imagePerfilProvider.notifier).state = user?.imagen;
  return user;
});

final userProvider = StateProvider<Usuario?>((ref) => null);
final imagePerfilProvider = StateProvider<Imagen?>((ref) => Imagen());
final changeUsersProvider = StateProvider<int>((ref) {
  return 0;
});

final isEmptyUserProvider = StateProvider<bool>((ref) => false);

final foundImageFileProvider = StateProvider<bool>((ref) => false);

final searchUserProvider = StateProvider<String>((ref) => '');

final userQueryProvider =
    FutureProvider.family<List<Usuario>, String>((ref, arg) async {
  // final period = ref.watch(periodoProvider);
  final empty = ref.watch(isEmptyUserProvider);
  final search = ref.watch(searchUserProvider);
  // final pag = ref.watch(paginaProvider);
  // final filter = ref.watch(filtroProvider);

  final detectChanged = ref.watch(changeUsersProvider);

  final list = await AuthService().getUsers(search, empty);
  return list;
});
