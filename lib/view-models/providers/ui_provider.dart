import 'package:riverpod/riverpod.dart';
import 'package:sidebarx/sidebarx.dart';

import '../services/snackbar_service.dart';

final showSearchExtProvider = StateProvider<SidebarXController>((ref) {
  return SidebarXController(selectedIndex: 0, extended: true);
});

final snackbarServiceProvider = Provider<SnackbarService>((ref) {
  return SnackbarService();
});
