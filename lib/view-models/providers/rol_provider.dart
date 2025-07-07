import 'package:riverpod/riverpod.dart';
import 'package:tuple/tuple.dart';

import 'usuario_provider.dart';

final permissionsProvider =
    StateProvider.autoDispose.family<bool, Tuple2<List<String>, List<String>>>(
  (ref, arg) {
    bool found = false;
    final userData = ref.watch(userProvider);

    for (var permission in arg.item1) {
      found = userData?.rol?.permisos
              ?.any((element) => element.resource == permission) ??
          false;
      if (found && arg.item2.isNotEmpty) {
        bool foundAction = false;

        for (var action in arg.item2) {
          foundAction = userData?.rol?.permisos?.any((element) =>
                  element.action == action && element.resource == permission) ??
              false;
          if (foundAction) {
            found = true;
            break;
          } else {
            found = false;
          }
        }
      }
      if (found) break;
    }

    return found;
  },
);
