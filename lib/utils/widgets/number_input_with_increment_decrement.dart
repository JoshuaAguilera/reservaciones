import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';

class NumberInputWithIncrementDecrement extends StatefulWidget {
  final void Function(String) onChanged;
  final void Function(int)? onIncrement;
  final void Function(int)? onDecrement;
  final String? initialValue;
  final int? minimalValue;
  final int? maxValue;
  final double? sizeIcons;
  final double? height;
  final bool focused;
  final Color? colorText;
  final bool inHorizontal;
  final double maxHeight;

  const NumberInputWithIncrementDecrement({
    super.key,
    required this.onChanged,
    required this.initialValue,
    this.minimalValue,
    this.maxValue,
    this.onIncrement,
    this.onDecrement,
    this.sizeIcons,
    this.height,
    this.focused = false,
    this.colorText,
    this.inHorizontal = false,
    this.maxHeight = 100,
  });

  @override
  _NumberInputWithIncrementDecrementState createState() =>
      _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState
    extends State<NumberInputWithIncrementDecrement> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text =
        widget.initialValue ?? "0"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.inHorizontal ? null : const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: widget.colorText ?? Colors.black38),
      ),
      constraints: BoxConstraints(
        minWidth: 5,
        maxWidth: widget.inHorizontal ? 80 : 40,
        minHeight: 10.0,
        maxHeight: widget.maxHeight,
      ),
      child: Row(
        children: <Widget>[
          if (widget.inHorizontal)
            SizedBox(
              height: 38,
              width: 20,
              child: InkWell(
                child: Icon(
                  Iconsax.arrow_left_1_outline,
                  size: widget.sizeIcons ?? 18.0,
                ),
                onTap: () {
                  int currentValue = int.parse(_controller.text);
                  setState(() {
                    currentValue--;
                    _controller.text =
                        (currentValue > (widget.minimalValue ?? 0)
                                ? currentValue
                                : widget.minimalValue ?? 0)
                            .toString(); // decrementing value
                    widget.onChanged.call(_controller.text);
                    if (widget.onDecrement != null) {
                      widget.onDecrement!.call(currentValue);
                    }
                  });
                },
              ),
            ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: widget.height,
              child: AbsorbPointer(
                absorbing: !widget.focused,
                child: Focus(
                  onFocusChange: (value) {
                    if (!value &&
                        (_controller.text.isEmpty ||
                            int.parse(_controller.text) <
                                widget.minimalValue!)) {
                      setState(() =>
                          _controller.text = widget.minimalValue!.toString());
                    }
                  },
                  child: TextFormField(
                    onChanged: (value) => widget.onChanged.call(value),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "poppins_regular",
                        fontSize: 13,
                        color: widget.colorText),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                        fontFamily: "poppins_regular",
                        fontSize: 13,
                      ),
                    ),
                    controller: _controller,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: false,
                      signed: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.inHorizontal)
            SizedBox(
              height: 38,
              width: 20,
              child: InkWell(
                child: Icon(
                  Iconsax.arrow_right_4_outline,
                  size: widget.sizeIcons ?? 18.0,
                ),
                onTap: () {
                  int currentValue = int.parse(_controller.text);
                  setState(() {
                    currentValue++;
                    _controller.text = widget.maxValue != null
                        ? _controller.text =
                            (currentValue < (widget.maxValue!)
                                    ? currentValue
                                    : widget.maxValue)
                                .toString()
                        : (currentValue).toString(); // incrementing value
                    widget.onChanged.call(_controller.text);
                    if (widget.onIncrement != null) {
                      widget.onIncrement!.call(currentValue);
                    }
                  });
                },
              ),
            ),
          if (!widget.inHorizontal)
            SizedBox(
              height: 38.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: InkWell(
                      child: Icon(
                        Iconsax.arrow_up_2_outline,
                        size: widget.sizeIcons ?? 18.0,
                      ),
                      onTap: () {
                        int currentValue = int.parse(_controller.text);
                        setState(() {
                          currentValue++;
                          _controller.text = widget.maxValue != null
                              ? _controller.text =
                                  (currentValue < (widget.maxValue!)
                                          ? currentValue
                                          : widget.maxValue)
                                      .toString()
                              : (currentValue).toString(); // incrementing value
                          widget.onChanged.call(_controller.text);
                          if (widget.onIncrement != null) {
                            widget.onIncrement!.call(currentValue);
                          }
                        });
                      },
                    ),
                  ),
                  InkWell(
                    child: Icon(
                      Iconsax.arrow_down_1_outline,
                      size: widget.sizeIcons ?? 18.0,
                    ),
                    onTap: () {
                      int currentValue = int.parse(_controller.text);
                      setState(() {
                        currentValue--;
                        _controller.text =
                            (currentValue > (widget.minimalValue ?? 0)
                                    ? currentValue
                                    : widget.minimalValue ?? 0)
                                .toString(); // decrementing value
                        widget.onChanged.call(_controller.text);
                        if (widget.onDecrement != null) {
                          widget.onDecrement!.call(currentValue);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
