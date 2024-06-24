import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';

import '../helpers/web_colors.dart';

class SideBar extends StatelessWidget {
  final bool isExpanded;
  const SideBar({
    Key? key,
    required SidebarXController controller,
    this.isExpanded = false,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      showToggleButton: !isExpanded,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: WebColors.canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: WebColors.scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: WebColors.canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: WebColors.actionColor.withOpacity(0.37),
          ),
          gradient: LinearGradient(
            colors: [WebColors.accentCanvasColor, WebColors.canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: WebColors.canvasColor,
        ),
      ),
      footerDivider: WebColors.divider,
      headerBuilder: (context, extended) {
        if (extended) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  _controller.selectIndex(0);
                },
                child: SizedBox(
                  height: 100,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 10, right: 10),
                    child: Image.network(
                        "https://static.wixstatic.com/media/a3b865_2a7c82994df6450ab30ff9232a0295ce~mv2.png"),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _controller.selectIndex(3),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12),
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: _controller.selectedIndex == 3
                          ? BoxDecoration(
                              border: Border.all(
                                color: WebColors.actionColor.withOpacity(0.37),
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  WebColors.accentCanvasColor,
                                  WebColors.canvasColor
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.28),
                                  blurRadius: 30,
                                )
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)))
                          : null,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/image/Logo.png'),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Username",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 14),
                                ),
                                Text(
                                  "188 cotizaciones",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 11),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network(
                  "https://static.wixstatic.com/media/a3b865_02615e33874a4314b822456823c169eb~mv2.png",
                  width: 33,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/image/Logo.png'),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
      items: const [
        SidebarXItem(
          icon: CupertinoIcons.home,
          label: 'Inicio',
        ),
        SidebarXItem(
          icon: CupertinoIcons.money_dollar_circle,
          label: 'Generar Cotización',
        ),
        SidebarXItem(
          icon: Icons.history,
          label: 'Historial',
        ),
      ],
    );
  }
}
