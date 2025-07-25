import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tuple/tuple.dart';

import '../../models/ui_models.dart';
import '../services/navigator_service.dart';
import '../services/snackbar_service.dart';
import 'cotizacion_provider.dart';
import 'dashboard_provider.dart';
import 'habitacion_provider.dart';
import 'notificacion_provider.dart';
import 'tarifario_provider.dart';
import 'usuario_provider.dart';

final showNotificationsProvider = StateProvider<bool>((ref) => false);

final sidebarControllerProvider = Provider<SidebarXController>((ref) {
  return SidebarXController(selectedIndex: 0, extended: true);
});

final sidebarItemsProvider = Provider<List<SidebarItem>>((ref) {
  final userPermissions = ref.watch(userProvider)?.rol?.permisos ??
      []; // Provider de permisos del usuario

  final allItems = [
    SidebarItem(
      route: '/dashboard',
      title: 'Dashboard',
      icon: Iconsax.home_1_bold,
      requiredPermissions: [],
    ),
    SidebarItem(
      route: '/generar_cotizacion',
      title: 'Generar Cotización',
      icon: Iconsax.money_send_outline,
      requiredPermissions: [],
    ),
    SidebarItem(
      route: '/historial',
      title: 'Historial',
      icon: HeroIcons.clipboard_document_list,
      requiredPermissions: [],
    ),
    SidebarItem(
      route: '/clientes',
      title: 'Clientes',
      icon: Iconsax.profile_2user_bold,
      requiredPermissions: [],
    ),
    SidebarItem(
      route: '/configuracion',
      title: 'Configuración',
      icon: HeroIcons.wrench_screwdriver,
      requiredPermissions: [],
    ),
    SidebarItem(
      route: '/tarifario',
      title: 'Tarifario',
      icon: HeroIcons.wallet,
      requiredPermissions: [],
    ),
    SidebarItem(
      route: '/gestion_usuarios',
      title: 'Gestión de Usuarios',
      icon: HeroIcons.user_group,
      requiredPermissions: [],
    ),
  ];

  // Filtrar según permisos del usuario
  final list = allItems.where((item) {
    return item.requiredPermissions.every(userPermissions.contains);
  }).toList();

  list.map((item) => item.index = allItems.indexOf(item)).toList();
  return list;
});

final selectPageProvider = StateProvider<SidebarItem>(
  (ref) {
    return SidebarItem(
      route: '/dashboard',
      title: 'Dashboard',
      icon: Icons.dashboard,
      requiredPermissions: [],
    );
  },
);

Future<void> navigateToRoute(
  WidgetRef ref,
  String route, {
  String subRoute = "",
  Tuple2<String?, int?>? ids,
}) async {
  final sidebarItems =
      ref.read(sidebarItemsProvider).map((e) => e.copyWith()).toList();
  final selectedSidebarItem =
      sidebarItems.firstWhere((item) => item.route == route);

  if (subRoute.isNotEmpty) {
    selectedSidebarItem.subRoute = subRoute;
  }

  if (ids != null) {
    selectedSidebarItem.ids = ids;
  }

  ref.read(sidebarControllerProvider).selectIndex(selectedSidebarItem.index);
  ref.read(selectPageProvider.notifier).state = selectedSidebarItem;
}

final showSearchExtProvider = StateProvider<bool>((ref) => false);

final snackbarServiceProvider = Provider<SnackbarService>((ref) {
  return SnackbarService();
});

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService();
});

final logoutProvider = FutureProvider<void>((ref) async {
  ref.invalidate(sidebarControllerProvider);
  ref.invalidate(sidebarItemsProvider);
  ref.invalidate(selectPageProvider);
  ref.invalidate(snackbarServiceProvider);
  ref.invalidate(navigationServiceProvider);
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
