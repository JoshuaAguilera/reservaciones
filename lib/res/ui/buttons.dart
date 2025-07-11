import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:icons_plus/icons_plus.dart';

import 'text_styles.dart';
import '../helpers/colors_helpers.dart';
import '../helpers/desktop_colors.dart';
import 'tools_ui.dart';

class SelectableButton extends StatefulWidget {
  const SelectableButton({
    super.key,
    required this.selected,
    required this.onPressed,
    required this.child,
    this.color = const Color.fromRGBO(144, 202, 249, 1),
    this.round = 12,
    this.roundActive = 10,
    this.elevation = 0,
  });

  final bool selected;
  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;
  final double? roundActive;
  final double? round;
  final double elevation;

  @override
  State<SelectableButton> createState() => _SelectableButtonState();
}

class _SelectableButtonState extends State<SelectableButton> {
  late final MaterialStatesController statesController;

  @override
  void initState() {
    super.initState();
    statesController = MaterialStatesController(
        <MaterialState>{if (widget.selected) MaterialState.selected});
  }

  @override
  void didUpdateWidget(SelectableButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      statesController.update(MaterialState.selected, widget.selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      statesController: statesController,
      style: widget.selected
          ? ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(widget.color),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.roundActive!),
                ),
              ),
              textStyle: WidgetStatePropertyAll(
                TextStyles.styleStandar(isBold: true),
              ),
              foregroundColor: WidgetStatePropertyAll(
                widget.selected
                    ? DesktopColors.ceruleanOscure
                    : Colors.grey[700],
              ),
              elevation: WidgetStatePropertyAll(widget.elevation),
            )
          : ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey[400]),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.round!),
                ),
              ),
              textStyle: WidgetStatePropertyAll(
                TextStyles.styleStandar(),
              ),
              foregroundColor: WidgetStatePropertyAll(Colors.grey[700]),
              elevation: WidgetStatePropertyAll(widget.elevation),
            ),
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}

class Buttons {
  static Widget buttonPrimary({
    required void Function()? onPressed,
    String text = "",
    bool isLoading = false,
    bool enable = true,
    IconData? icon,
    double? sizeIcon,
    double spaceBetween = 10,
    bool compact = false,
    double sizeText = 14,
    bool withTextBold = true,
    Color? backgroundColor,
    Color? colorText,
    Color? colorBorder,
    double? padVer,
    Color? colorSplash,
    bool forceColor = false,
  }) {
    Color colorContent = (useWhiteForeground(
      backgroundColor ?? DesktopColors.buttonPrimary,
      bias: 75,
    )
        ? Colors.white
        : Colors.black87);

    return StatefulBuilder(
      builder: (context, snapshot) {
        var brightness =
            ThemeModelInheritedNotifier.of(context).theme.brightness;

        return Opacity(
          opacity: onPressed != null ? 1 : 0.6,
          child: AbsorbPointer(
            absorbing: isLoading,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: brightness == Brightness.light
                    ? null
                    : WidgetStatePropertyAll(
                        colorSplash ??
                            backgroundColor ??
                            DesktopColors.buttonPrimary,
                      ),
                shape: WidgetStateProperty.all(
                  ContinuousRectangleBorder(
                    side: BorderSide(
                      color: (colorBorder ??
                          backgroundColor ??
                          DesktopColors.buttonPrimary),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(22)),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(
                  (!forceColor && brightness == Brightness.dark)
                      ? Colors.transparent
                      : backgroundColor ?? DesktopColors.buttonPrimary,
                ),
              ),
              onPressed: !enable ? null : onPressed,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: padVer ?? 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
                  children: [
                    if (icon != null && !isLoading)
                      Padding(
                        padding: EdgeInsets.only(right: spaceBetween),
                        child: Icon(
                          icon,
                          size: sizeIcon,
                          color: colorText ?? colorContent,
                        ),
                      ),
                    if (isLoading && text.isNotEmpty)
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    if (isLoading) const SizedBox(width: 10),
                    if (text.isNotEmpty)
                      Expanded(
                        flex: 0,
                        child: TextStyles.standardText(
                          text: !isLoading ? text : "Espere",
                          size: sizeText,
                          align: (icon != null)
                              ? TextAlign.start
                              : TextAlign.center,
                          isBold: withTextBold,
                          color: colorText ?? colorContent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget buttonSecundary({
    required void Function()? onPressed,
    String text = "",
    IconData? icon,
    bool isLoading = false,
    bool compact = false,
    double sizeText = 16,
    Color? backgroudColor,
    Color? foregroundColor,
  }) {
    return StatefulBuilder(
      builder: (context, _) {
        return buttonPrimary(
          onPressed: onPressed,
          text: text,
          icon: icon,
          compact: compact,
          sizeText: sizeText,
          isLoading: isLoading,
          withTextBold: false,
          padVer: 0,
          backgroundColor: backgroudColor ?? Colors.transparent,
          colorText: foregroundColor ?? Theme.of(context).iconTheme.color,
          colorBorder: backgroudColor ?? Theme.of(context).iconTheme.color,
        );
      },
    );
  }

  static Widget iconButtonCard({
    required IconData icon,
    required void Function()? onPressed,
    Color? backgroundColor,
    Color? colorIcon,
    String tooltip = "",
    bool invertColor = false,
  }) {
    return Card(
      color: (invertColor ? colorIcon : backgroundColor) ??
          DesktopColors.buttonPrimary,
      child: SizedBox(
        height: 40,
        width: 40,
        child: IconButton(
          tooltip: tooltip,
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: (invertColor ? backgroundColor : colorIcon) ?? Colors.white,
            size: 25,
          ),
        ),
      ),
    );
  }

  static Widget floatingButton(
    BuildContext context, {
    void Function()? onPressed,
    IconData? icon,
    Widget? iconWidget,
    required String tag,
    Color? color,
    double iconSize = 29,
    bool withAdd = false,
  }) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return FloatingActionButton(
      elevation: 0,
      backgroundColor: color ?? Theme.of(context).cardColor,
      highlightElevation: 0,
      shape: CircleBorder(
        side: BorderSide(
          color:
              brightness == Brightness.dark ? Colors.white24 : Colors.black12,
        ),
      ),
      heroTag: tag,
      mini: true,
      onPressed: onPressed,
      child: Stack(
        children: [
          iconWidget ??
              Icon(
                icon,
                size: iconSize,
              ),
          if (withAdd)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 15,
                width: 15,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(28)),
                child: const Icon(
                  Iconsax.add_circle_outline,
                  size: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }

  static Widget filterButton1({
    IconData? icon,
    String? title,
    bool isActive = false,
    Color? textColor,
    required void Function()? onPressed,
  }) {
    return Expanded(
      child: StatefulBuilder(builder: (context, _) {
        var brightness =
            ThemeModelInheritedNotifier.of(context).theme.brightness;

        Color colorText = textColor ??
            (isActive
                ? brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.white
                : brightness == Brightness.dark
                    ? Colors.white54
                    : Colors.black54);
        Color colorBorder = (isActive
            ? Colors.white
            : brightness == Brightness.dark
                ? Colors.white30
                : Colors.black54);

        return buttonPrimary(
          text: title ?? '',
          icon: icon,
          spaceBetween: 0,
          withTextBold: false,
          backgroundColor: isActive
              ? brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87
              : brightness == Brightness.dark
                  ? Colors.transparent
                  : Colors.white,
          forceColor: true,
          colorText: colorText,
          colorBorder: colorBorder,
          onPressed: onPressed,
          padVer: 0,
        );
      }),
    );
  }

  static Widget filterButton2({
    required String name,
    bool isActive = false,
    required Color colorButton,
    required void Function()? onPressed,
    IconData? icon,
  }) {
    return Expanded(
      child: buttonPrimary(
        text: name,
        withTextBold: false,
        backgroundColor: !isActive ? DesktopColors.grisPalido : colorButton,
        colorSplash: colorButton,
        colorText: !isActive
            ? DesktopColors.grisSemiPalido
            : ColorsHelpers.darken(colorButton, 0.3),
        onPressed: onPressed,
        padVer: 0,
        sizeText: 14.5,
        icon: icon,
      ),
    );
  }

  static Widget textButton({
    required void Function()? onPressed,
    String text = "",
    IconData? icon,
    Color? color,
    bool enable = true,
  }) {
    return ToolsUi.blockedWidget(
      isBloqued: !enable,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: color,
              ),
            Flexible(
              child: TextStyles.standardText(
                text: text,
                color: color,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget commonButton({
    required void Function()? onPressed,
    Color? color,
    String text = "",
    bool isLoading = false,
    double sizeText = 14,
    bool isBold = false,
    bool withRoundedBorder = false,
    double? borderRadius,
    Color colorText = Colors.white,
    Widget? child,
    String? tooltipText,
    IconData? icons,
    double? sizeIcon,
    bool onlyIcon = false,
    double? elevation,
    Color? colorBorder,
    double? spaceBetween,
    bool compact = false,
  }) {
    return Tooltip(
      margin: const EdgeInsets.only(top: 10),
      message: tooltipText ?? (child != null ? text : ""),
      child: AbsorbPointer(
        absorbing: isLoading,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            elevation: elevation ?? 4,
            backgroundColor: color ?? DesktopColors.ceruleanOscure,
            shape: !withRoundedBorder
                ? null
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius ?? 15),
                    ),
                    side: colorBorder == null
                        ? BorderSide.none
                        : BorderSide(color: colorBorder),
                  ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icons != null && !isLoading)
                Padding(
                  padding: EdgeInsets.only(
                      right: onlyIcon ? 0 : spaceBetween ?? 10.0),
                  child: Icon(
                    icons,
                    size: sizeIcon,
                  ),
                ),
              if (isLoading)
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              if (isLoading) const SizedBox(width: 10),
              if (child != null)
                Expanded(child: child)
              else
                Flexible(
                  flex: compact ? 1 : 0,
                  child: !isBold
                      ? TextStyles.standardText(
                          text: !isLoading ? text : "Espere",
                          align: TextAlign.center,
                          size: sizeText,
                          color: colorText,
                        )
                      : TextStyles.buttonTextStyle(
                          text: !isLoading ? text : "Espere",
                          aling: TextAlign.center,
                          size: sizeText,
                          color: colorText,
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
