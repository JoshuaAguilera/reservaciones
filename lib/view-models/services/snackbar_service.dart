import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../models/error_model.dart';
import '../../models/estatus_snackbar_model.dart';
import '../../res/helpers/colors_helpers.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/helpers/icon_helpers.dart';
import '../../res/ui/text_styles.dart';

class SnackbarService {
  late GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;

  void init(GlobalKey<ScaffoldMessengerState> key) {
    _scaffoldMessengerKey = key;
  }

  void showCustomSnackBar({
    String message = '',
    ErrorModel? error,
    Duration? duration,
    String? type,
    IconData? icon,
    bool withIcon = false,
    double textSize = 14,
    Color? color,
    double elevation = 10,
    int maxLines = 2,
  }) {
    final messenger = _scaffoldMessengerKey.currentState;
    if (messenger == null) return;

    var brightness =
        ThemeModelInheritedNotifier.of(messenger.context).theme.brightness;

    String typeSnack = type ?? '';
    if (error != null) typeSnack = TypeSnackbar.danger;

    Color backgroundColor = color ??
        ColorsHelpers.getColorNavbar(typeSnack) ??
        DesktopColors.primaryColor;

    double bias = brightness == Brightness.dark ? 60 : 0;

    Color colorStrong = (useWhiteForeground(backgroundColor, bias: bias)
        ? Colors.white
        : Colors.black87);

    IconData icons = icon ?? IconHelpers.getIconSnackBar(typeSnack);

    final snackBar = SnackBar(
      width: 500,
      behavior: SnackBarBehavior.floating,
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: backgroundColor,
      showCloseIcon: false,
      closeIconColor: colorStrong,
      elevation: elevation,
      // margin: const EdgeInsets.all(8),
      dismissDirection: DismissDirection.horizontal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (withIcon)
                Icon(
                  icons,
                  color: colorStrong,
                ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (error != null && (error.title ?? '').isNotEmpty)
                      TextStyles.standardText(
                        text: (error.title ?? '').toUpperCase(),
                        align: TextAlign.left,
                        color: colorStrong,
                        textOverflow: TextOverflow.ellipsis,
                        size: textSize,
                        isBold: true,
                      ),
                    if (error == null || (error.message ?? '').isNotEmpty)
                      TextStyles.standardText(
                        text: error?.message ?? message,
                        align: TextAlign.left,
                        color: colorStrong,
                        textOverflow: TextOverflow.ellipsis,
                        size: textSize,
                        maxLines: maxLines,
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () => messenger.hideCurrentSnackBar(),
              ),
            ],
          ),
          if ((error?.listErrors ?? []).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Column(
                children: [
                  for (var element in error!.listErrors!.take(3))
                    TextStyles.standardText(
                      text: "- $element",
                      align: TextAlign.left,
                      color: colorStrong,
                      textOverflow: TextOverflow.ellipsis,
                      size: textSize - 4,
                      maxLines: maxLines,
                    ),
                ],
              ),
            ),
        ],
      ),
    );

    // _scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    messenger.showSnackBar(snackBar);
  }
}
