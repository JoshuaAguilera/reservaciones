import 'package:flutter/material.dart';
import 'package:generador_formato/helpers/web_colors.dart';
import 'package:generador_formato/widgets/text_styles.dart';

class SelectableButton extends StatefulWidget {
  const SelectableButton({
    super.key,
    required this.selected,
    required this.onPressed,
    required this.child,
  });

  final bool selected;
  final VoidCallback? onPressed;
  final Widget child;

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
              backgroundColor: WidgetStatePropertyAll(Colors.blue[200]),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust for desired roundness
                ),
              ),
              textStyle: WidgetStatePropertyAll(
                TextStyles.styleStandar(isBold: true),
              ),
              foregroundColor: WidgetStatePropertyAll(widget.selected ? WebColors.ceruleanOscure : Colors.grey[700]))
          : ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey[400]),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      12.0), // Adjust for desired roundness
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
