import 'package:riverpod/riverpod.dart';
import 'package:sidebarx/sidebarx.dart';

final showSearchExtProvider = StateProvider<SidebarXController>((ref) {
  return SidebarXController(selectedIndex: 0, extended: true);
});
