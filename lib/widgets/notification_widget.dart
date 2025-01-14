import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/models/notificacion_model.dart';

import '../utils/helpers/desktop_colors.dart';
import 'text_styles.dart';

class NotificationWidget {
  static Widget notificationsWidget({
    required GlobalKey<TooltipState> key,
    required double screenWidth,
    required List<Notificacion> notifications,
    required Brightness brightness,
  }) {
    return Tooltip(
      key: key,
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
      richMessage: WidgetSpan(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: notifications.isEmpty ? 60 : 200,
            width: 250,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyles.titleText(
                    size: 14,
                    text: "Notificaciones",
                    color: brightness == Brightness.light
                        ? DesktopColors.ceruleanOscure
                        : DesktopColors.azulClaro,
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  if (notifications.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                          child: TextStyles.standardText(
                              text: "No hay notificaciones por ahora.",
                              size: 12)),
                    )
                  else
                    SizedBox(
                      width: screenWidth,
                      child: ListView.builder(
                        itemCount: notifications.length,
                        shrinkWrap: false,
                        itemBuilder: (context, index) {
                          return Text(notifications[index].title!);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      child: IconButton(
        onPressed: () {
          key.currentState?.ensureTooltipVisible();
        },
        icon: Icon(
          CupertinoIcons.bell_solid,
          color: brightness == Brightness.light
              ? DesktopColors.cerulean
              : DesktopColors.azulUltClaro,
          size: 26,
        ),
      ),
    );
  }
}
