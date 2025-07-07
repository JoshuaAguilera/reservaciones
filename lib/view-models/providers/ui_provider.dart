import 'package:riverpod/riverpod.dart';

import '../services/navigator_service.dart';
import '../services/snackbar_service.dart';

final showSearchExtProvider = StateProvider<bool>((ref) => false);

final snackbarServiceProvider = Provider<SnackbarService>((ref) {
  return SnackbarService();
});

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService();
});
