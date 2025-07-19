import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../utils/widgets/sidebar.dart';
import '../view-models/providers/ui_provider.dart';
import 'menu_view.dart';

class HomeView extends ConsumerStatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool startflow = false;
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(sidebarControllerProvider);
    final routePage = ref.watch(selectPageProvider);
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
        body: Row(
          children: [
            if (!isSmallScreen) const SideBar(),
            const Expanded(child: Center(child: MenuView())),
          ],
        ),
      ),
    );
  }
}
