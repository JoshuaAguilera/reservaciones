import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../models/estatus_snackbar_model.dart';
import '../../models/ui_models.dart';
import '../../res/helpers/colors_helpers.dart';
import '../../view-models/providers/ui_provider.dart';
import '../../view-models/providers/usuario_provider.dart';
import '../../res/helpers/constants.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/ui/my_sidebar_x_item.dart';
import '../../res/ui/text_styles.dart';
import '../../view-models/services/auth_service.dart';
import '../shared_preferences/preferences.dart';

class SideBar extends ConsumerStatefulWidget {
  final bool isExpanded;
  const SideBar({
    super.key,
    this.isExpanded = false,
  });

  @override
  ConsumerState<SideBar> createState() => _SideBarState();
}

class _SideBarState extends ConsumerState<SideBar> {
  bool startflow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageUser = ref.watch(imagePerfilProvider);
    final usuario = ref.watch(userProvider);
    final foundImageFile = ref.watch(foundImageFileProvider);
    final sidebarItems = ref.watch(sidebarItemsProvider);
    final controller = ref.watch(sidebarControllerProvider);
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return AbsorbPointer(
      absorbing: foundImageFile,
      child: SidebarX(
        controller: controller,
        showToggleButton: !widget.isExpanded,
        theme: SidebarXTheme(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorsHelpers.darken(
              DesktopColors.canvasColor,
              isDarkMode ? 0.1 : 0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          hoverColor: DesktopColors.scaffoldBackgroundColor,
          textStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontFamily: "poppins_regular",
            fontSize: 12,
          ),
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
            border: Border.all(
              color: ColorsHelpers.darken(
                DesktopColors.canvasColor,
                isDarkMode ? 0.1 : 0,
              ),
            ),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: DesktopColors.actionColor.withValues(alpha: 0.37),
            ),
            gradient: LinearGradient(
              colors: [
                DesktopColors.accentCanvasColor,
                DesktopColors.canvasColor
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.28),
                blurRadius: 30,
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.white.withValues(alpha: 0.7),
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
            color: ColorsHelpers.darken(
              DesktopColors.canvasColor,
              isDarkMode ? 0.1 : 0,
            ),
          ),
        ),
        footerDivider: DesktopColors.divider,
        headerBuilder: (context, extended) {
          if (extended) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () => navigateToRoute(ref, "/dashboard"),
                  child: Stack(
                    children: [
                      const SizedBox(
                        child: Image(
                          image: AssetImage("assets/image/large_logo.png"),
                          width: 180,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
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
                MySidebarXItem(
                  onTap: () => controller.selectIndex(99),
                  controller: controller,
                  selectIndex: 99,
                  children: [
                    Expanded(
                      child: (imageUser?.ruta?.isNotEmpty ?? false)
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
                                    File(imageUser?.ruta ?? ''),
                                    fit: BoxFit.cover,
                                    width: 45,
                                    height: 45,
                                    errorBuilder: (context, error, _) {
                                      return const Icon(
                                        Iconsax.user_square_bold,
                                        size: 45,
                                        color: Colors.white,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          : const Icon(
                              Iconsax.user_square_bold,
                              size: 45,
                              color: Colors.white,
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
                            usuario?.rol?.nombre ?? 'Unknown Role',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: "poppins_regular",
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Column(
              children: [
                GestureDetector(
                  onTap: () => navigateToRoute(ref, "/dashboard"),
                  child: const Tooltip(
                    message: "Versión $version",
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Image(
                        image: AssetImage("assets/image/logo_desktop.png"),
                        width: 35,
                      ),
                    ),
                  ),
                ),
                MySidebarXItem(
                  onTap: () {
                    ref.read(selectPageProvider.notifier).state = SidebarItem(
                      route: "/perfil",
                      title: "Perfil",
                      icon: Iconsax.user_square_bold,
                      requiredPermissions: [],
                    );
                  },
                  controller: controller,
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
                                File(imageUser?.ruta ?? ''),
                                fit: BoxFit.cover,
                                width: 30,
                                height: 30,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Iconsax.user_square_bold,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : const Icon(
                            Iconsax.user_square_bold,
                            size: 30,
                            color: Colors.white,
                          ),
                  ],
                ),
              ],
            );
          }
        },
        items: sidebarItems.map((item) {
          return sideBarCustomItem(item: item);
        }).toList(),
        headerDivider: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: DesktopColors.divider,
        ),
        footerBuilder: (_, extended) {
          return SizedBox(
            height: 70, // Ajusta la altura según tus necesidades
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: MySidebarXItem(
                onTap: () async {
                  try {
                    await ref.watch(logoutProvider.future);
                    await AuthService().logout();
                    await Preferences.clearUserData();
                  } catch (e) {
                    ref.read(snackbarServiceProvider).showCustomSnackBar(
                          message: e.toString(),
                          duration: const Duration(seconds: 3),
                          type: TypeSnackbar.danger,
                          withIcon: true,
                        );
                    return;
                  }

                  if (!mounted) return;
                  Navigator.pushReplacementNamed(context, 'login');
                },
                controller: controller,
                selectIndex: 45,
                icon: HeroIcons.arrow_right_on_rectangle,
                label: "Cerrar sesión",
                tooltip: controller.extended ? '' : "Cerrar sesión",
              ),
            ),
          );
        },
      ),
    );
  }

  SidebarXItem sideBarCustomItem({required SidebarItem item}) {
    final controller = ref.watch(sidebarControllerProvider);

    return SidebarXItem(
      label: item.title,
      onTap: () => ref.read(selectPageProvider.notifier).state = item,
      iconBuilder: (selected, hovered) {
        return Tooltip(
          message: !controller.extended ? item.title : "",
          child: Icon(
            item.icon,
            size: selected ? 21 : 20,
            color: (selected || hovered)
                ? Colors.white
                : Colors.white.withValues(alpha: 0.7),
          ),
        );
      },
    );
  }
}
