import 'dart:async';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../res/helpers/animation_helpers.dart';
import '../utils/widgets/notification_widget.dart';
import '../utils/widgets/sidebar.dart';
import '../view-models/providers/ui_provider.dart';
import 'menu_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool startflow = false;
  final _key = GlobalKey<ScaffoldState>();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Inicia el polling al iniciar la pantalla
    _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      // final notificaciones = await obtenerNotificaciones(
      //   db: widget.db,
      //   usuario: widget.usuarioActual,
      // );
      // for (var notificacion in notificaciones) {
      //   // Mostrar notificación (puedes usar un paquete de notificaciones locales)
      //   print("Tienes una notificación: ${notificacion['titulo']}");
      //   // Marcar como leída
      //   await marcarComoLeida(
      //     db: widget.db,
      //     idNotificacion: notificacion['id'],
      //   );
      // }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(sidebarControllerProvider);
    final routePage = ref.watch(selectPageProvider);
    final showNotifications = ref.watch(showNotificationsProvider);
    final isSmallScreen = MediaQuery.of(context).size.width < 800;
    if (!isSmallScreen) {
      startflow = true;
      _key.currentState?.closeDrawer();
    } else if (startflow) {
      controller.setExtended(startflow);
      startflow = false;
    }

    return ThemeSwitchingArea(
      child: Scaffold(
        key: _key,
        appBar: isSmallScreen
            ? AppBar(
                title: Text(routePage.title),
                leading: IconButton(
                  onPressed: () {
                    // if (!Platform.isAndroid && !Platform.isIOS) {
                    //   _controller.setExtended(true);
                    // }
                    _key.currentState?.openDrawer();
                  },
                  icon: const Icon(
                    Iconsax.element_2_outline,
                    color: Colors.white,
                  ),
                ),
              )
            : null,
        drawer: const SideBar(isExpanded: true),
        body: Stack(
          children: [
            Row(
              children: [
                if (!isSmallScreen) const SideBar(),
                const Expanded(
                  child: Center(child: MenuView()),
                ),
              ],
            ),
            if (showNotifications)
              AnimatedEntry(
                child: ModalBarrier(
                  color: Colors.black.withValues(alpha: 0.5),
                  onDismiss: () {
                    ref.read(showNotificationsProvider.notifier).state = false;
                  },
                ),
              ),
            if (showNotifications)
              const Positioned(right: 0, child: NotificationWidget()),
          ],
        ),
      ),
    );
  }
}
