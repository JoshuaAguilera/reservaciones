import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/views/generacion_cotizaciones/habitacion_form.dart';
import 'package:generador_formato/views/tarifario/tarifario_form_view.dart';
import 'package:generador_formato/views/tarifario/tarifario_view.dart';
import 'package:generador_formato/views/usuarios/gestion_usuarios_view.dart';
import 'package:generador_formato/views/historial/cotizacion_detalle_view.dart';
import 'package:generador_formato/views/configuracion/configuracion_view.dart';
import 'package:generador_formato/views/dashboard_view.dart';
import 'package:generador_formato/views/generacion_cotizaciones/generar_cotizacion_view.dart';
import 'package:generador_formato/views/historial/historial_view.dart';
import 'package:generador_formato/views/perfil_view.dart';
import 'package:sidebarx/sidebarx.dart';

class MenuView extends StatefulWidget {
  const MenuView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final pageTitle =
            Utility.getTitleByIndex(widget.controller.selectedIndex);
        switch (widget.controller.selectedIndex) {
          case 0:
            return DashboardView(sideController: widget.controller);
          case 1:
            return GenerarCotizacionView(sideController: widget.controller);
          case 2:
            return HistorialView(sideController: widget.controller);
          case 3:
            return ConfiguracionView(sideController: widget.controller);
          case 4:
            return TarifarioView(sideController: widget.controller);
          case 5:
            return GestionUsuariosView(sideController: widget.controller);
          case 99:
            return PerfilView(sideController: widget.controller);
          case 12:
            return CotizacionDetalleView(sideController: widget.controller);
          case 15:
            return TarifarioFormView(sideController: widget.controller);
          case 16:
            return HabitacionForm(sideController: widget.controller);
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}
