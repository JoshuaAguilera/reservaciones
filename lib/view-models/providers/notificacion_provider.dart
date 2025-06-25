import 'package:riverpod/riverpod.dart';

import '../../models/notificacion_model.dart';

class NotificacionProvider extends StateNotifier<List<Notificacion>> {
  NotificacionProvider() : super([]);

  static final provider =
      StateNotifierProvider<NotificacionProvider, List<Notificacion>>(
          (ref) => NotificacionProvider());

  Notificacion _current = Notificacion();
  Notificacion get current => _current;

  void addItem(Notificacion item) {
    _current = item;
    state = [...state, item];
  }

  void editItem(Notificacion item) {
    int index = state.indexWhere((element) => element.idInt == item.idInt);
    if (index != -1) {
      state[index] = item;
    }
  }

  void remove(int id) {
    state = [...state.where((element) => element.idInt != id)];
  }

  void clear() {
    state = [];
  }
}

final userViewProvider = StateProvider<bool>((ref) {
  return false;
});
