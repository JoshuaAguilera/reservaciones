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
    this.compact = false,
    this.target = 1,
    this.isUpDireccion = false,
    this.showMonth = false,
  }) : super(key: key);

  final RegistroTarifa tarifa;
  final int lenghtDays;
  final double lenghtSideBar;
  final DateTime weekNow;
  final bool compact;
  final double target;
  final bool isUpDireccion;
  final bool showMonth;

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
        : (screenWidth - widget.lenghtSideBar + (screenWidth > 800 ? 0 : 202)) /
            7)));
    weekNowSegment = Utility.generateSegmentWeek(widget.weekNow);

    return Row(
      children: dynamicWidget.buildExpansionItemWeek(
        weekNowSegment: weekNowSegment,
        weekNow: widget.weekNow,
        tarifa: widget.tarifa,
        sectionDay: sectionDay,
        compact: widget.compact,
        target: widget.target,
        isUpDireccion: widget.isUpDireccion,
        showMonth: widget.showMonth,
      ),
    );
  }
}
