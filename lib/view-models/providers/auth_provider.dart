import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../../models/estatus_snackbar_model.dart';
import '../../utils/shared_preferences/settings.dart';
import '../services/auth_service.dart';
import 'ui_provider.dart';

final authProvider = FutureProvider<bool>(
  (ref) async {
    bool success = false;
    final username = ref.watch(usernameProvider);
    final password = ref.watch(passwordProvider);
    final saveName = ref.watch(saveNameProvider);

    if (username.text.isNotEmpty && password.text.isNotEmpty) {
      final response =
          await AuthService().loginUser(username.text, password.text);

      if (response.item1 != null) {
        ref.read(snackbarServiceProvider).showCustomSnackBar(
              error: response.item1,
              type: TypeSnackbar.danger,
              withIcon: true,
            );

        return true;
      }
      // ref.read(userProvider.notifier).state = response.item2;
    }

    ref.watch(usernameProvider.notifier).state.text = '';
    ref.watch(passwordProvider.notifier).state.text = '';
    if (saveName) Settings.savename = username.text;

    return success;
  },
);

final usernameProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
final passwordProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final saveNameProvider = StateProvider<bool>(
  (ref) => Settings.savename.isNotEmpty,
);
