import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/ui/my_sidebar_x_item.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/sidebarx.dart';

import '../providers/usuario_provider.dart';
import '../utils/helpers/desktop_colors.dart';
import 'text_styles.dart';

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
  bool startflow = false;
  @override
  Widget build(BuildContext context) {
    final imageUser = ref.watch(imagePerfilProvider);
    final usuario = ref.watch(userProvider);
    final foundImageFile = ref.watch(foundImageFileProvider);

    return AbsorbPointer(
      absorbing: foundImageFile,
      child: SidebarX(
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
                    child: SizedBox(
                      width: 180,
                      child: Stack(
                        children: [
                          const SizedBox(
                            child: Image(
                              image: AssetImage(
                                  "assets/image/logo_login_dark.png"),
                              width: 180,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 5,
                            child: TextStyles.standardText(
                              text: "Versión $version",
                              size: 9,
                              color: Colors.white,
                            ),
                          ),
                        ],
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
                                    image:
                                        AssetImage('assets/image/usuario.png'),
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
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Image(
                      image: AssetImage("assets/image/icon_home_sidebar.png"),
                      width: 35,
                    ),
                  ),
                ),
                MySidebarXItem(
                  onTap: () => widget._controller.selectIndex(99),
                  controller: widget._controller,
                  tooltip: "Perfil",
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
          _SideBarCustomItem(name: "Inicio", icon: HeroIcons.home),
          _SideBarCustomItem(
            name: "Generar Cotización",
            icon: Iconsax.money_send_outline,
          ),
          _SideBarCustomItem(
              name: "Historial", icon: HeroIcons.clipboard_document_list),
          _SideBarCustomItem(
              name: "Configuracion", icon: HeroIcons.wrench_screwdriver),
          if (usuario.rol == 'SUPERADMIN' || usuario.rol == 'ADMIN')
            _SideBarCustomItem(name: "Tarifario", icon: HeroIcons.wallet),
          if (usuario.rol == 'SUPERADMIN')
            _SideBarCustomItem(
                name: "Gestión de usuarios", icon: HeroIcons.user_group),
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
                tooltip: widget._controller.extended ? '' : "Cerrar sesión",
              ),
            ),
          );
        },
      ),
    );
  }

  SidebarXItem _SideBarCustomItem(
      {required String name, required IconData icon}) {
    return SidebarXItem(
      label: name,
      iconBuilder: (selected, hovered) {
        return Tooltip(
          message: !widget._controller.extended ? name : "",
          child: Icon(
            icon,
            size: selected ? 21 : 20,
            color: (selected || hovered)
                ? Colors.white
                : Colors.white.withOpacity(0.7),
          ),
        );
      },
    );
  }
}
