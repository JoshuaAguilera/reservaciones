import 'package:flutter/material.dart';

import '../ui/buttons.dart';
import '../utils/helpers/utility.dart';

class SelectButtonsWidget extends StatefulWidget {
  const SelectButtonsWidget({
    Key? key,
    required this.selectButton,
    required this.buttons,
    this.width,
    this.onPressed,
  }) : super(key: key);

  final String selectButton;
  final List<Map<String, Color>> buttons;
  final double? width;
  final void Function(int)? onPressed;

  @override
  State<SelectButtonsWidget> createState() => _SelectButtonsWidgetState();
}

class _SelectButtonsWidgetState extends State<SelectButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: widget.width,
      child: StatefulBuilder(
        builder: (context, snapshot) {
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            itemBuilder: (context, index) {
              bool isButtonNow =
                  widget.selectButton == widget.buttons[index].keys.first;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                child: SelectableButton(
                  selected: isButtonNow,
                  round: 4,
                  roundActive: 8,
                  color:
                      Utility.darken(widget.buttons[index].values.first, -0.15),
                  onPressed: () {
                    if (isButtonNow) return;

                    if (widget.onPressed != null) {
                      widget.onPressed!.call(index);
                    }
                  },
                  child: Text(
                    widget.buttons[index].keys.first,
                    style: TextStyle(
                      color: Utility.darken(
                          widget.buttons[index].values.first, 0.15),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
