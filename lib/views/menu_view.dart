import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view-models/providers/ui_provider.dart';
import 'clientes/clientes_view.dart';
import 'configuracion/configuracion_view.dart';
import 'dashboard/dashboard_view.dart';
import 'generacion_cotizaciones/generar_cotizacion_view.dart';
import 'generacion_cotizaciones/habitacion_form.dart';
import 'historial/cotizacion_detalle_view.dart';
import 'historial/historial_view.dart';
import 'perfil_view.dart';
import 'tarifario/tarifario_form_view.dart';
import 'tarifario/tarifario_view.dart';
import 'gestion_usuarios_view.dart';

class MenuView extends ConsumerStatefulWidget {
  const MenuView({super.key});

  @override
  ConsumerState<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends ConsumerState<MenuView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final routePage = ref.watch(selectPageProvider);
    final sidebarController = ref.watch(sidebarControllerProvider);

    return AnimatedBuilder(
      animation: sidebarController,
      builder: (context, child) {
        switch (routePage.route) {
          case "/dashboard":
            return const DashboardView();
          case "/generar_cotizacion":
            return GenerarCotizacionView(sideController: sidebarController);
          case "/historial":
            if (routePage.subRoute == "/detalle") {
              return CotizacionDetalleView(ids: routePage.ids);
            }
            return HistorialView(sideController: sidebarController);
          case "/configuracion":
            return ConfiguracionView(sideController: sidebarController);
          case "/tarifario":
            return TarifarioView(sideController: sidebarController);
          case "/gestion_usuarios":
            return GestionUsuariosView(sideController: sidebarController);
          case "/clientes":
            return const ClientesView();
          case "/perfil":
            return PerfilView(sideController: sidebarController);
          case "/tarifario_form":
            return TarifarioFormView(sideController: sidebarController);
          case "/habitacion_form":
            return HabitacionForm(sideController: sidebarController);
          default:
            return Text(
              routePage.title,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}
