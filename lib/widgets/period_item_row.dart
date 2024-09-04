import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/dynamic_widget.dart';

class PeriodItemRow extends StatefulWidget {
  const PeriodItemRow({
    Key? key,
    required this.tarifa,
    required this.lenghtDays,
    required this.lenghtSideBar,
    required this.weekNow,
  }) : super(key: key);

  final RegistroTarifa tarifa;
  final int lenghtDays;
  final double lenghtSideBar;
  final DateTime weekNow;

  @override
  State<PeriodItemRow> createState() => _PeriodItemRowState();
}

class _PeriodItemRowState extends State<PeriodItemRow> {
  List<DateTime> weekNowSegment = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sectionDay = ((((screenWidth > 1280)
        ? ((screenWidth - 385 - widget.lenghtSideBar) / 7)
        : (screenWidth - widget.lenghtSideBar) / 7)));
    weekNowSegment = Utility.generateSegmentWeek(widget.weekNow);

    debugPrint(Utility.getPeriodNow(widget.weekNow, widget.tarifa.periodos)
        .fechaInicial!
        .toIso8601String());

    return Row(
      children: dynamicWidget.buildExpansionItemWeek(
        weekNowSegment: weekNowSegment,
        weekNow: widget.weekNow,
        tarifa: widget.tarifa,
        sectionDay: sectionDay,
      ),
    );
  }
}
