import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/notificacion_model.dart';
import '../../res/helpers/colors_helpers.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/helpers/icon_helpers.dart';
import '../../res/helpers/utility.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/text_styles.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({
    super.key,
    required this.notifications,
    required this.keyTool,
    required this.onPressed,
    this.viewNotification = false,
  });

  final List<Notificacion> notifications;
  final GlobalKey<TooltipState> keyTool;
  final void Function() onPressed;
  final bool viewNotification;

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Tooltip(
      key: widget.keyTool,
      triggerMode: TooltipTriggerMode.manual,
      margin: const EdgeInsets.only(right: 50),
      showDuration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        color: brightness == Brightness.light
            ? Colors.white
            : DesktopColors.grisSemiPalido,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      //Realizar llamado para desaparecer la notificacion de visto
      richMessage: WidgetSpan(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyles.titleText(
                    size: 14,
                    text:
                        "Notificaciones ${widget.notifications.length > 0 ? "(${widget.notifications.length})" : ""}",
                    color: Theme.of(context).primaryColor,
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 5),
                  if (widget.notifications.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                          child: TextStyles.standardText(
                              text: "No hay notificaciones por ahora.",
                              size: 12)),
                    )
                  else
                    SizedBox(
                      height: Utility.limitHeightList(
                          widget.notifications.length, 3, 200),
                      child: ListView.builder(
                        itemCount: widget.notifications.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _NotificationItem(
                            notificacion: widget.notifications[index],
                            isLast: widget.notifications[index] ==
                                widget.notifications.last,
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 5)
                ],
              ),
            ),
          ),
        ),
      ),
      child: Buttons.floatingButton(
        context,
        tag: "notificaciones",
        iconWidget: Stack(
          children: [
            const Icon(CupertinoIcons.bell, size: 26),
            if (widget.notifications.isNotEmpty && !widget.viewNotification)
              Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.circle,
                  color: DesktopColors.notDanger,
                  size: 14,
                ),
              )
          ],
        ),
        onPressed: () {
          widget.keyTool.currentState?.ensureTooltipVisible();
          widget.onPressed.call();
        },
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem(
      {Key? key, required this.notificacion, this.isLast = false})
      : super(key: key);

  final Notificacion notificacion;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getColorNotification(notificacion.mensaje ?? ''),
            ColorsHelpers.darken(
                _getColorNotification(notificacion.mensaje ?? ''), -0.15)
          ],
          end: Alignment.centerRight,
          begin: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Icon(
              IconHelpers.getIconNavbar(notificacion.tipo) ??
                  CupertinoIcons.bell,
              color: ColorsHelpers.darken(
                  _getColorNotification(notificacion.mensaje ?? ''), 0.05),
              size: 80,
            ),
          ),
          ListTile(
            title: TextStyles.standardText(
              text: notificacion.id ?? '',
              size: 12.5,
              isBold: true,
              color: Colors.white,
            ),
            subtitle: TextStyles.standardText(
              text: (notificacion.createdAt ?? DateTime.now()).toString(),
              size: 11,
              overClip: true,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

Color _getColorNotification(String level) {
  switch (level) {
    case "info":
      return DesktopColors.notNormal;
    case "alert":
      return DesktopColors.cotGrupal;
    case "danger":
      return DesktopColors.notDanger;
    case "success":
      return DesktopColors.notSuccess;
    default:
      return DesktopColors.notNormal;
  }
}
