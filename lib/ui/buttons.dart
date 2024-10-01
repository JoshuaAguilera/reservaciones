import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
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
  });

  final bool selected;
  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;
  final double? roundActive;
  final double? round;

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
              foregroundColor: WidgetStatePropertyAll(widget.selected
                  ? DesktopColors.ceruleanOscure
                  : Colors.grey[700]))
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
              foregroundColor: WidgetStatePropertyAll(Colors.grey[700])),
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}

class Buttons {
  static ElevatedButton commonButton({
    required void Function()? onPressed,
    Color? color,
    String text = "",
    bool isLoading = false,
    double sizeText = 14,
    bool isBold = false,
    bool withRoundedBorder = false,
    Color colorText = Colors.white,
  }) {
    return ElevatedButton(
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
        mainAxisAlignment: isLoading
            ? MainAxisAlignment.spaceAround
            : MainAxisAlignment.center,
        children: [
          if (isLoading)
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white),
            ),
          isBold
              ? TextStyles.standardText(
                  text: !isLoading ? text : "Espere",
                  aling: TextAlign.center,
                  size: sizeText,
                  isBold: true,
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
    );
  }
}
