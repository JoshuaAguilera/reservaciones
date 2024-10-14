import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: widget.colorText ?? Colors.black38),
      ),
      constraints: const BoxConstraints(
        minWidth: 40,
        maxWidth: 40,
        minHeight: 10.0,
        maxHeight: 100.0,
      ),
      child: Row(
        children: <Widget>[
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
                      Icons.arrow_drop_up,
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
                    Icons.arrow_drop_down,
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
