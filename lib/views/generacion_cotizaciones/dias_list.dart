import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  int dayWeekFinish = 0;
  int dayCheckIn = 1;
  int dayCheckOut = 2;
  int numDays = 0;

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
                        ink < (numDays + extraDays + daysMonth);
                        ink++)
                      if ((checkIn.day < checkOut.day) &&
                          ink >
                              (checkIn.day -
                                  checkIn.weekday -
                                  (7 - dayWeekInit + 2)) &&
                          ink <
                              (checkOut.day +
                                  (7 - checkOut.weekday) +
                                  ((checkIn.day >= 1 &&
                                          checkIn.day <= (7 - dayWeekInit + 1))
                                      ? (9 + (dayWeekInit - 3)) + 7
                                      : (9 + (dayWeekInit - 3)))))
                        ItemRow.dayRateRow(
                          context: context,
                          day: (checkIn.day >= 1 &&
                                  checkIn.day <= (7 - dayWeekInit + 1))
                              ? ink - 7
                              : ink,
                          initDay: dayWeekInit,
                          lastDay: daysMonth,
                          checkIn: dayCheckIn,
                          checkOut: dayCheckOut,
                          daysMonthAfter: daysMonthAfter,
                        )
                      else if ((checkIn.day > checkOut.day) &&
                          ink > (checkIn.day - checkIn.weekday - 5) &&
                          ink <
                              ((checkOut.day + daysMonth) +
                                  (7 - checkOut.weekday) +
                                  10))
                        ItemRow.dayRateRow(
                          context: context,
                          day: ink,
                          initDay: dayWeekInit,
                          lastDay: daysMonth,
                          checkIn: dayCheckIn,
                          checkOut: dayCheckOut,
                          daysMonthAfter: daysMonthAfter,
                          dayWeekLater: 7 - checkOut.weekday,
                          dayMonthLater: daysMonthLater,
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
    dayWeekFinish = DateTime(checkIn.year, checkIn.month, 0).weekday;

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
