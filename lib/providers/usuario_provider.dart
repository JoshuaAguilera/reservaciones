import 'package:generador_formato/database/database.dart';
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
