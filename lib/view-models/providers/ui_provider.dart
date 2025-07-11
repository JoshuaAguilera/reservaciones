import 'package:riverpod/riverpod.dart';

import '../services/navigator_service.dart';
import '../services/snackbar_service.dart';
import 'cotizacion_provider.dart';
import 'dahsboard_provider.dart';
import 'habitacion_provider.dart';
import 'notificacion_provider.dart';
import 'tarifario_provider.dart';
import 'usuario_provider.dart';

final showSearchExtProvider = StateProvider<bool>((ref) => false);

final snackbarServiceProvider = Provider<SnackbarService>((ref) {
  return SnackbarService();
});

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService();
});

final logoutProvider = FutureProvider<void>((ref) async {
  // ref.watch(NotificacionProvider.provider.notifier).clear();
  // ref.watch(HabitacionProvider.provider.notifier).clear();
  // ref.watch(TarifasProvisionalesProvider.provider.notifier).clear();
  // ref.watch(TarifasProvisionalesProvider.provider.notifier).clear();
  ref.invalidate(cotizacionProvider);
  ref.invalidate(saveTariffPolityProvider);
  ref.invalidate(filterReport);
  ref.invalidate(dateReport);
  ref.invalidate(useCashSeasonProvider);
  ref.invalidate(useCashSeasonRoomProvider);
  ref.invalidate(typeQuoteProvider);
  ref.invalidate(showManagerTariffGroupProvider);
  ref.invalidate(descuentoProvisionalProvider);
  ref.invalidate(editTarifaProvider);
  ref.invalidate(selectedModeViewProvider);
  ref.invalidate(userProvider);
  ref.invalidate(userViewProvider);
});
