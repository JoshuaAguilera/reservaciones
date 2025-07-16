import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sidebarx/sidebarx.dart';

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
  const MenuView({super.key, required this.controller});
  final SidebarXController controller;

  @override
  ConsumerState<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends ConsumerState<MenuView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final routePage = ref.watch(selectPageProvider);

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        switch (routePage.route) {
          case "/dashboard":
            return const DashboardView();
          case "/generar_cotizacion":
            return GenerarCotizacionView(sideController: widget.controller);
          case "/historial":
            return HistorialView(sideController: widget.controller);
          case "/configuracion":
            return ConfiguracionView(sideController: widget.controller);
          case "/tarifario":
            return TarifarioView(sideController: widget.controller);
          case "/gestion_usuarios":
            return GestionUsuariosView(sideController: widget.controller);
          case "/clientes":
            return const ClientesView();
          case "/perfil":
            return PerfilView(sideController: widget.controller);
          case "/cotizacion_detalle":
            return CotizacionDetalleView(sideController: widget.controller);
          case "/tarifario_form":
            return TarifarioFormView(sideController: widget.controller);
          case "/habitacion_form":
            return HabitacionForm(sideController: widget.controller);
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
