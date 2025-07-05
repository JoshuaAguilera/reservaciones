import 'package:generador_formato/view-models/services/auth_service.dart';
import 'package:riverpod/riverpod.dart';

import '../../models/estatus_snackbar_model.dart';
import 'ui_provider.dart';

final authProvider = FutureProvider<bool>(
  (ref) async {
    final username = ref.watch(usernameProvider);
    final password = ref.watch(passwordProvider);

    if (username.isNotEmpty && password.isNotEmpty) {
      final response = await AuthService().loginUser(username, password);

      if (response.item1 != null) {
        ref.read(snackbarServiceProvider).showCustomSnackBar(
              error: response.item1,
              type: TypeSnackbar.danger,
              withIcon: true,
            );
        return true;
      }
    }
  },
);

final usernameProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
