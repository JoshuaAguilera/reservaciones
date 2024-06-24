import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:sidebarx/sidebarx.dart';

import '../widgets/sidebar.dart';
import '../helpers/web_colors.dart';
import 'dashboard_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      key: _key,
      appBar: isSmallScreen
          ? AppBar(
              backgroundColor: WebColors.canvasColor,
              title: Text(Utility.getTitleByIndex(_controller.selectedIndex)),
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
      ),
      body: Row(
        children: [
          if (!isSmallScreen)
            SideBar(
              controller: _controller,
              isExpanded: true,
            ),
          Expanded(
            child: Center(
              child: DashboardView(
                controller: _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
