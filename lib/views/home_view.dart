import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:sidebarx/sidebarx.dart';

import '../widgets/sidebar.dart';
import '../helpers/web_colors.dart';
import 'menu_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  bool startflow = false;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    if (!isSmallScreen) {
      startflow = true;
      _key.currentState?.closeDrawer();
    } else if (startflow) {
      _controller.setExtended(startflow);
      startflow = false;
    }

    return Scaffold(
      key: _key,
      appBar: isSmallScreen
          ? AppBar(
              backgroundColor: WebColors.canvasColor,
              title: TextStyles.titleText(
                  color: Colors.white,
                  text: Utility.getTitleByIndex(_controller.selectedIndex)),
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
    );
  }
}
