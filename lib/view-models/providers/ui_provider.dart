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
final routePageProvider = StateProvider<String>((ref) => '/dashboard');

final snackbarServiceProvider = Provider<SnackbarService>((ref) {
  return SnackbarService();
});

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService();
});

final logoutProvider = FutureProvider<void>((ref) async {
  ref.invalidate(NotificacionProvider.provider);
  ref.invalidate(HabitacionProvider.provider);
  ref.invalidate(TarifasProvisionalesProvider.provider);
  ref.invalidate(cotizacionProvider);
  ref.invalidate(saveTariffPolityProvider);
  ref.invalidate(filterReport);
  ref.invalidate(dateReportProvider);
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
