import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/item_row.dart';

class DiasList extends StatefulWidget {
  const DiasList({super.key});

  @override
  State<DiasList> createState() => _DiasListState();
}

class _DiasListState extends State<DiasList> {
  int daysMonth = 0;
  int dayWeekInit = 0;

  @override
  void initState() {
    defineDayOfMout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Table(
            border: TableBorder(
                horizontalInside:
                    BorderSide(color: Theme.of(context).dividerColor),
                verticalInside:
                    BorderSide(color: Theme.of(context).dividerColor)),
            children: [
              TableRow(children: [
                for (var i = 0; i < 7; i++)
                  ItemRow.dayRateRow(
                      context: context,
                      day: i,
                      initDay: dayWeekInit,
                      lastDay: daysMonth),
              ]),
              TableRow(children: [
                for (var i = 7; i < 14; i++)
                  ItemRow.dayRateRow(
                      context: context,
                      day: i,
                      initDay: dayWeekInit,
                      lastDay: daysMonth),
              ]),
              TableRow(children: [
                for (var i = 14; i < 21; i++)
                  ItemRow.dayRateRow(
                      context: context,
                      day: i,
                      initDay: dayWeekInit,
                      lastDay: daysMonth),
              ]),
              TableRow(children: [
                for (var i = 21; i < 28; i++)
                  ItemRow.dayRateRow(
                      context: context,
                      day: i,
                      initDay: dayWeekInit,
                      lastDay: daysMonth),
              ]),
              TableRow(children: [
                for (var i = 28; i < 35; i++)
                  ItemRow.dayRateRow(
                      context: context,
                      day: i,
                      initDay: dayWeekInit,
                      lastDay: daysMonth),
              ]),
            ],
          )
        ],
      ),
    );
  }

  Future defineDayOfMout() async {
    DateTime now = DateTime.now();
    daysMonth = Utility.getDaysInMonth(now.year, now.month);
    dayWeekInit = DateTime(now.year, now.month, 1).weekday;
  }
}
