import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/desktop_colors.dart';
import 'package:generador_formato/widgets/text_styles.dart';

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
  static Widget commonButton({
    required void Function()? onPressed,
    Color? color,
    String text = "",
    bool isLoading = false,
    double sizeText = 14,
    bool isBold = false,
    bool withRoundedBorder = false,
    Color colorText = Colors.white,
    Widget? child,
    String? tooltipText,
    IconData? icons,
    double? sizeIcon,
  }) {
    return Tooltip(
      message: tooltipText ?? (child != null ? text : ""),
      child: AbsorbPointer(
        absorbing: isLoading,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 4,
            backgroundColor: color ?? DesktopColors.ceruleanOscure,
            shape: !withRoundedBorder
                ? null
                : const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icons != null && !isLoading)
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
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
                      strokeWidth: 2, color: Colors.white),
                ),
              if (isLoading) const SizedBox(width: 10),
              if (child != null)
                Expanded(child: child)
              else
                !isBold
                    ? TextStyles.standardText(
                        text: !isLoading ? text : "Espere",
                        aling: TextAlign.center,
                        size: sizeText,
                        color: colorText,
                      )
                    : TextStyles.buttonTextStyle(
                        text: !isLoading ? text : "Espere",
                        aling: TextAlign.center,
                        size: sizeText,
                        color: colorText,
                      ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget iconButtonCard({
    required IconData icon,
    required void Function()? onPressed,
    Color? backgroundColor,
    Color? colorIcon,
    String tooltip = "",
  }) {
    return Card(
      color: backgroundColor ?? DesktopColors.ceruleanOscure,
      child: SizedBox(
        height: 40,
        width: 40,
        child: IconButton(
          tooltip: tooltip,
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: colorIcon ?? Colors.white,
            size: 25,
          ),
        ),
      ),
    );
  }
}
