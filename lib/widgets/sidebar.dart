import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/ui/my_sidebar_x_item.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/sidebarx.dart';

import '../providers/usuario_provider.dart';
import '../utils/helpers/web_colors.dart';

class SideBar extends ConsumerStatefulWidget {
  final bool isExpanded;
  const SideBar({
    Key? key,
    required SidebarXController controller,
    this.isExpanded = false,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends ConsumerState<SideBar> {
  Image? _imageWidget;
  bool startflow = false;
  @override
  Widget build(BuildContext context) {
    final imageUser = ref.watch(imagePerfilProvider);
    final usuario = ref.watch(userProvider);

    return SidebarX(
      controller: widget._controller,
      showToggleButton: !widget.isExpanded,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: DesktopColors.canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: DesktopColors.scaffoldBackgroundColor,
        textStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontFamily: "poppins_regular",
            fontSize: 12),
        selectedTextStyle: const TextStyle(
            color: Colors.white, fontFamily: "poppins_regular", fontSize: 12),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 12.5,
          fontFamily: "poppins_regular",
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: DesktopColors.canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: DesktopColors.actionColor.withOpacity(0.37)),
          gradient: LinearGradient(
            colors: [
              DesktopColors.accentCanvasColor,
              DesktopColors.canvasColor
            ],
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
          color: DesktopColors.canvasColor,
        ),
      ),
      footerDivider: DesktopColors.divider,
      headerBuilder: (context, extended) {
        if (extended) {
          return SizedBox(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    widget._controller.selectIndex(0);
                  },
                  child: const SizedBox(
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0, left: 10, right: 10),
                      child: Image(
                        image: AssetImage('assets/image/logo_inicio.png'),
                      ),
                    ),
                  ),
                ),
                MySidebarXItem(
                  onTap: () => widget._controller.selectIndex(99),
                  controller: widget._controller,
                  selectIndex: 99,
                  children: [
                    Expanded(
                      child: (imageUser.urlImagen?.isNotEmpty ?? false)
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white60,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.file(
                                    File(imageUser.urlImagen!),
                                    fit: BoxFit.cover,
                                    width: 45,
                                    height: 45,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white60,
                                image: DecorationImage(
                                  image: AssetImage('assets/image/usuario.png'),
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
                            Preferences.username,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: "poppins_regular",
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            usuario.rol ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: "poppins_regular",
                                color: Colors.white,
                                fontSize: 11),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Column(
            children: [
              GestureDetector(
                onTap: () => widget._controller.selectIndex(0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.network(
                    "https://static.wixstatic.com/media/a3b865_02615e33874a4314b822456823c169eb~mv2.png",
                    width: 33,
                  ),
                ),
              ),
              MySidebarXItem(
                onTap: () => widget._controller.selectIndex(99),
                controller: widget._controller,
                selectIndex: 99,
                children: [
                  Preferences.userImageUrl.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white60,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.file(
                              File(imageUser.urlImagen!),
                              fit: BoxFit.cover,
                              width: 30,
                              height: 30,
                            ),
                          ),
                        )
                      : Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white60,
                            image: DecorationImage(
                              image: AssetImage('assets/image/usuario.png'),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          );
        }
      },
      items: [
        const SidebarXItem(
          icon: CupertinoIcons.home,
          label: 'Inicio',
        ),
        const SidebarXItem(
          icon: CupertinoIcons.money_dollar_circle,
          label: 'Generar Cotización',
        ),
        const SidebarXItem(
          icon: Icons.history,
          label: 'Historial',
        ),
        const SidebarXItem(
          icon: Icons.settings,
          label: 'Configuracion',
        ),
        if (usuario.rol == 'SUPERADMIN' || usuario.rol == 'ADMIN')
          const SidebarXItem(
            icon: CupertinoIcons.book_fill,
            label: 'Tarifario',
          ),
        if (usuario.rol == 'SUPERADMIN')
          const SidebarXItem(
            icon: CupertinoIcons.rectangle_stack_person_crop,
            label: 'Gestión de usuarios',
          ),
      ],
      headerDivider: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: DesktopColors.divider,
      ),
      footerBuilder: (context, extended) {
        return SizedBox(
          height: 70, // Ajusta la altura según tus necesidades
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: MySidebarXItem(
              onTap: () => Navigator.pop(context),
              controller: widget._controller,
              selectIndex: 45,
              icon: HeroIcons.arrow_right_on_rectangle,
              label: "Cerrar sesión",
            ),
          ),
        );
      },
    );
  }
}
