import 'package:flutter/material.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:generador_formato/views/generar_cotizacion_view.dart';
import 'package:sidebarx/sidebarx.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
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
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
          case 1:
            return GenerarCotizacionView(sideController: widget.controller);
          case 2:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
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
