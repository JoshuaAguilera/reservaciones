import 'package:flutter/material.dart';
import 'package:generador_formato/components/utility.dart';
import 'package:generador_formato/views/generar_cotizacion_view.dart';
import 'package:sidebarx/sidebarx.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = Utility.getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
          case 1:
            return const GenerarCotizacionView();
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
