import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/text_styles.dart';

class PeriodItemRow extends StatefulWidget {
  const PeriodItemRow({
    Key? key,
    this.color,
    required this.days,
    required this.lenghtDays,
    required this.lenghtSideBar,
  }) : super(key: key);

  final Color? color;
  final int days;
  final int lenghtDays;
  final double lenghtSideBar;

  @override
  State<PeriodItemRow> createState() => _PeriodItemRowState();
}

class _PeriodItemRowState extends State<PeriodItemRow> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: SizedBox(
        width: ((((screenWidth > 1280)
                    ? ((screenWidth - 385 - widget.lenghtSideBar) /
                        widget.lenghtDays)
                    : (screenWidth - widget.lenghtSideBar) /
                        widget.lenghtDays)) *
                (widget.days)) +
            10,
        height: 100,
        child: Card(
          color: widget.color ?? Colors.cyan,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextStyles.standardText(
                            text: "20 Agosto - 15 Octubre", size: 11),
                        Icon(Icons.warning_amber_rounded,
                            color: Theme.of(context).primaryColorDark)
                      ],
                    ),
                    TextStyles.standardText(text: "Temporada de Verano")
                  ],
                ),
                LinearProgressIndicator(value: widget.days/10,)
              ],
            ),
          ),
        ),
      ).animate(delay: 2200.ms).scaleX(alignment: Alignment.centerLeft),
    );
  }
}
