import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/models/notificacion_model.dart';

import '../utils/helpers/web_colors.dart';
import 'text_styles.dart';

class NotificationWidget {
  static Widget notificationsWidget(
      {required GlobalKey<TooltipState> key,
      required double screenWidth,
      required List<Notificacion> notifications}) {
    return Tooltip(
      key: key,
      triggerMode: TooltipTriggerMode.manual,
      margin: const EdgeInsets.only(right: 50),
      showDuration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
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
                      size: 13,
                      text: "Notificaciones",
                      color: DesktopColors.ceruleanOscure),
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
          color: DesktopColors.cerulean,
          size: 26,
        ),
      ),
    );
  }
}
