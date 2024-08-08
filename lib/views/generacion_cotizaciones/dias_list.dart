import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/item_row.dart';
import 'package:generador_formato/widgets/text_styles.dart';

class DiasList extends StatefulWidget {
  const DiasList({super.key, required this.initDay, required this.lastDay});

  final String initDay;
  final String lastDay;

  @override
  State<DiasList> createState() => _DiasListState();
}

class _DiasListState extends State<DiasList> {
  int daysMonth = 0;
  int daysMonthAfter = 0;
  int daysMonthLater = 0;
  int dayWeekInit = 0;
  int dayCheckIn = 1;
  int dayCheckOut = 2;
  int numDays = 0;
  int limitWeek = 0;
  List<int> serieSemanal = [];

  //prepare V3
  int extraDays = 0;

  DateTime checkIn = DateTime.now();
  DateTime checkOut = DateTime.now();

  @override
  void initState() {
    getInfoDates();
    respDataDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: TextStyles.titleText(
                text: Utility.defineMonthPeriod(widget.initDay, widget.lastDay),
                color: Theme.of(context).dividerColor,
                size: 21),
          ),
          Stack(
            children: [
              SizedBox(
                width: screenWidth < 1100 ? double.infinity : 1100,
                child: GridView.count(
                  crossAxisCount: 7,
                  shrinkWrap: true,
                  childAspectRatio: 0.9,
                  children: [
                    for (var ink = 0;
                        ink < (numDays + extraDays + checkIn.day);
                        ink++)
                      if (ink > (checkIn.day - checkIn.weekday - 5) &&
                          ink < (checkOut.day + (7 - checkOut.weekday) + 10))
                        ItemRow.dayRateRow(
                          context: context,
                          day: ink,
                          initDay: dayWeekInit,
                          lastDay: daysMonth,
                          checkIn: dayCheckIn,
                          checkOut: dayCheckOut,
                          daysMountAfter: daysMonthAfter,
                        )
                      else if ((checkIn.day > checkOut.day) &&
                          ink > (checkIn.day - checkIn.weekday - 5) &&
                          ink <
                              ((checkOut.day + checkIn.day) +
                                  (7 - checkOut.weekday) +
                                  10))
                        ItemRow.dayRateRow(
                          context: context,
                          day: ink,
                          initDay: dayWeekInit,
                          lastDay: daysMonth,
                          checkIn: dayCheckIn,
                          checkOut: dayCheckOut,
                          daysMountAfter: daysMonthAfter,
                        )
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  height: 135,
                  width: 7800,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Theme.of(context).cardColor,
                    if (brightness == Brightness.dark)
                      const Color.fromARGB(0, 68, 68, 68),
                    if (brightness == Brightness.light)
                      const Color.fromARGB(0, 255, 255, 255)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 135,
                  width: 7800,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Theme.of(context).cardColor,
                    if (brightness == Brightness.dark)
                      const Color.fromARGB(0, 68, 68, 68),
                    if (brightness == Brightness.light)
                      const Color.fromARGB(0, 255, 255, 255)
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future respDataDate() async {
    daysMonth = Utility.getDaysInMonth(checkIn.year, checkIn.month);
    daysMonthAfter = Utility.getDaysInMonth(checkIn.year, checkIn.month - 1);
    daysMonthLater = Utility.getDaysInMonth(checkIn.year, checkIn.month + 1);
    dayWeekInit = DateTime(checkIn.year, checkIn.month, 1).weekday;
    int dayWeekLast =
        DateTime(checkIn.year, checkIn.month, dayCheckOut).weekday;
    serieSemanal =
        Utility.getLimitWeeks(numDays, dayWeekInit, dayWeekLast, checkIn.day);
    limitWeek =
        Utility.getLimitDays(numDays, dayWeekInit, dayWeekLast, checkIn.day);

    extraDays += 7 - (checkIn.weekday);
    extraDays += 7 - (checkOut.weekday - 1);
    extraDays += 14;
  }

  Future getInfoDates() async {
    checkIn = DateTime.parse(widget.initDay);
    checkOut = DateTime.parse(widget.lastDay);
    dayCheckIn = checkIn.day;
    dayCheckOut = checkOut.day;
    numDays = checkOut.difference(checkIn).inDays;
  }
}
