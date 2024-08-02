import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/services/auth_service.dart';
import 'package:riverpod/riverpod.dart';

final userProvider = StateProvider<User>((ref) {
  return User(
      id: 0,
      name: "",
      password: "",
      rol: "",
      mail: "",
      passwordMail: "",
      phone: "");
});

final allUsersProvider =
    FutureProvider.family<List<User>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeUsersProvider);
  final list = await AuthService().getUsers();
  return list;
});

final changeUsersProvider = StateProvider<int>((ref) {
  return 0;
});
