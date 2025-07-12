import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../models/periodo_model.dart';

class IconHelpers {
  static IconData? getIconNavbar(String? type) {
    switch (type) {
      case "alert":
        return CupertinoIcons.exclamationmark_octagon;
      case "danger":
        return CupertinoIcons.exclamationmark_triangle;
      case "success":
        return CupertinoIcons.checkmark_alt;
      case "info":
        return CupertinoIcons.exclamationmark_bubble;
      default:
    }
    return null;
  }

  static IconData getIconSnackBar(String type) {
    switch (type) {
      case "alert":
        return Iconsax.warning_2_outline;
      case "info":
        return Iconsax.info_circle_outline;
      case "danger":
        return Iconsax.danger_outline;
      case "success":
        return Icons.check_circle_outline_rounded;
      default:
        return Iconsax.message_question_outline;
    }
  }

  static IconData? getIconCardDashboard(String? tipoCotizacion) {
    switch (tipoCotizacion?.toLowerCase()) {
      case "grupales":
        return Iconsax.people_outline;
      case "individuales":
        return Iconsax.user_outline;
      case "reservadas":
        return Iconsax.calendar_tick_outline;
      case "caducadas":
        return Iconsax.direct_inbox_outline;
      case "total":
        return Iconsax.align_horizontally_outline;
      default:
        return Icons.error_outline;
    }
  }

  static Widget getIconStatusPeriod(Periodo nowPeriod, Color color) {
    final today = DateTime.now();
    final current = DateTime(today.year, today.month, today.day);

    final iconColor = useWhiteForeground(color) ? Colors.white : Colors.black;
    const iconSize = 15.0;

    Widget buildIcon(IconData iconData) {
      return Icon(iconData, color: iconColor, size: iconSize);
    }

    final start = nowPeriod.fechaInicial!;
    final end = nowPeriod.fechaFinal!;

    if (current.isBefore(start)) {
      return buildIcon(CupertinoIcons.time);
    }

    if (current.isAfter(end)) {
      return buildIcon(Icons.done_all_outlined);
    }

    return RotatedBox(
      quarterTurns: 3,
      child: buildIcon(CupertinoIcons.chevron_right_2),
    );
  }
}
