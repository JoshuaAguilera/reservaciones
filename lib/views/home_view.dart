import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/home_provider.dart';
import 'package:generador_formato/res/helpers/utility.dart';
import 'package:generador_formato/res/ui/text_styles.dart';
import 'package:sidebarx/sidebarx.dart';

import '../utils/widgets/sidebar.dart';
import '../res/helpers/desktop_colors.dart';
import 'menu_view.dart';

class HomeView extends ConsumerStatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  bool startflow = false;
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _controller.addListener(
      () => ref
          .read(indexSideBarProvider.notifier)
          .update((state) => _controller.selectedIndex),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(indexSideBarProvider);
    final isSmallScreen = MediaQuery.of(context).size.width < 800;
    if (!isSmallScreen) {
      startflow = true;
      _key.currentState?.closeDrawer();
    } else if (startflow) {
      _controller.setExtended(startflow);
      startflow = false;
    }

    return ThemeSwitchingArea(
      child: Scaffold(
        key: _key,
        appBar: isSmallScreen
            ? AppBar(
                backgroundColor: DesktopColors.canvasColor,
                title: TextStyles.titleText(
                    color: Colors.white, text: Utility.getTitleByIndex(index)),
                leading: IconButton(
                  onPressed: () {
                    // if (!Platform.isAndroid && !Platform.isIOS) {
                    //   _controller.setExtended(true);
                    // }
                    _key.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                ),
              )
            : null,
        drawer: SideBar(
          controller: _controller,
          isExpanded: true,
        ),
        body: Row(
          children: [
            if (!isSmallScreen)
              SideBar(
                controller: _controller,
              ),
            Expanded(
              child: Center(
                child: MenuView(
                  controller: _controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
