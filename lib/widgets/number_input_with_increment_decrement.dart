import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberInputWithIncrementDecrement extends StatefulWidget {
  final void Function(String)? onChanged;
  const NumberInputWithIncrementDecrement({super.key, required this.onChanged});

  @override
  _NumberInputWithIncrementDecrementState createState() =>
      _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState
    extends State<NumberInputWithIncrementDecrement> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = "0"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black38),
      ),
      constraints: const BoxConstraints(
        minWidth: 40,
        maxWidth: 40,
        minHeight: 25.0,
        maxHeight: 100.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TextFormField(
              onChanged: (value) => widget.onChanged!.call(value),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 13),
              decoration: InputDecoration(
                border: InputBorder.none,
                labelStyle: GoogleFonts.poppins(fontSize: 13),
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
                    child: const Icon(
                      Icons.arrow_drop_up,
                      size: 18.0,
                    ),
                    onTap: () {
                      int currentValue = int.parse(_controller.text);
                      setState(() {
                        currentValue++;
                        _controller.text =
                            (currentValue).toString(); // incrementing value
                        widget.onChanged!.call(_controller.text);
                      });
                    },
                  ),
                ),
                InkWell(
                  child: const Icon(
                    Icons.arrow_drop_down,
                    size: 18.0,
                  ),
                  onTap: () {
                    int currentValue = int.parse(_controller.text);
                    setState(() {
                      currentValue--;
                      _controller.text = (currentValue > 0 ? currentValue : 0)
                          .toString(); // decrementing value
                      widget.onChanged!.call(_controller.text);
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
