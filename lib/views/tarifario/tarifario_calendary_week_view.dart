import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/widgets/controller_calendar_widget.dart';
import 'package:generador_formato/widgets/item_row.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

class TarifarioCalendaryView extends StatefulWidget {
  const TarifarioCalendaryView({
    super.key,
    required this.target,
    required this.onTarget,
    required this.inMenu,
    required this.sideController,
    required this.viewWeek,
    required this.viewMonth,
    required this.viewYear,
  });

  final bool target;
  final bool inMenu;
  final void Function()? onTarget;
  final SidebarXController sideController;
  final bool viewWeek;
  final bool viewMonth;
  final bool viewYear;

  @override
  State<TarifarioCalendaryView> createState() => _TarifarioCalendaryViewState();
}

class _TarifarioCalendaryViewState extends State<TarifarioCalendaryView> {
  DateTime initDayWeek =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday));
  DateTime initDayWeekGraphics =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  bool selectedcurrentyear = false;
  bool startFlow = false;
  final PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);
  DateTime _currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                if (widget.viewMonth)
                  SizedBox(
                    height: screenHeight - 160,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: (screenWidth > 1280) ? (380) : 0),
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: 7,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 7, childAspectRatio: 0.5),
                            itemBuilder: (context, index) {
                              return ItemRow.getTitleDay(
                                title: 0,
                                withOutDay: true,
                                subTitle: daysNameShort[initDayWeekGraphics
                                        .add(Duration(days: index))
                                        .weekday -
                                    1],
                                select: initDayWeekGraphics
                                            .add(Duration(days: index))
                                            .weekday -
                                        1 ==
                                    (DateTime.now().weekday - 1),
                                index: index,
                                brightness: brightness,
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: 65,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: (screenWidth > 1280) ? 385 : 0,
                            ),
                            child: SizedBox(
                              width: (screenWidth > 1280)
                                  ? (screenWidth -
                                      385 -
                                      (widget.sideController.extended
                                          ? 230
                                          : 118))
                                  : screenWidth - 230,
                              height: screenHeight - 100,
                              child: PageView.builder(
                                // physics: const NeverScrollableScrollPhysics(),
                                controller: _pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentMonth = DateTime(
                                        _currentMonth.year, index + 1, 1);
                                  });
                                },
                                itemCount: 12 * 10,
                                itemBuilder: (context, pageIndex) {
                                  DateTime month = DateTime(_currentMonth.year,
                                      (pageIndex % 12) + 1, 1);
                                  return buildCalendar(
                                    month,
                                    initDayWeek.subtract(
                                      const Duration(
                                        days: 1,
                                      ),
                                    ),
                                  );
                                },
                              ).animate().fadeIn(duration: 1800.ms, begin: -.6),
                            ),
                          ),
                        ),
                        Positioned(
                          left: (screenWidth > 1280) ? (370) : -10,
                          top: 110,
                          child: SizedBox(
                            height: screenHeight - 260,
                            child: const SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (widget.viewWeek)
                  SizedBox(
                    height: screenHeight - 160,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 100,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: (screenWidth > 1280) ? 385 : 0,
                              ),
                              child: SizedBox(
                                width: (screenWidth > 1280)
                                    ? (screenWidth -
                                        385 -
                                        (widget.sideController.extended
                                            ? 230
                                            : 118))
                                    : screenWidth - 230,
                                child: Table(
                                  border: TableBorder(
                                    verticalInside: BorderSide(
                                        color: Theme.of(context).dividerColor),
                                    left: BorderSide(
                                        color: Theme.of(context).dividerColor),
                                    right: BorderSide(
                                        color: Theme.of(context).dividerColor),
                                  ),
                                  children: [
                                    TableRow(children: [
                                      for (var i = initDayWeek.day;
                                          i < (initDayWeek.day + 7);
                                          i++)
                                        SizedBox(
                                          height: screenHeight - 270,
                                          child: const Text(""),
                                        ),
                                    ]),
                                  ],
                                )
                                    .animate()
                                    .fadeIn(duration: 1800.ms, begin: -.6),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              left: (screenWidth > 1280) ? (380) : 0),
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: 7,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 7, childAspectRatio: 0.5),
                            itemBuilder: (context, index) {
                              return ItemRow.getTitleDay(
                                title: initDayWeekGraphics
                                    .add(Duration(days: index))
                                    .day,
                                subTitle: daysNameShort[initDayWeekGraphics
                                        .add(Duration(days: index))
                                        .weekday -
                                    1],
                                select: initDayWeekGraphics
                                            .add(Duration(days: index))
                                            .weekday -
                                        1 ==
                                    (DateTime.now().weekday - 1),
                                index: index,
                                brightness: brightness,
                              );
                            },
                          ),
                        ),
                        Positioned(
                          left: (screenWidth > 1280) ? (370) : -10,
                          top: 110,
                          child: SizedBox(
                            height: screenHeight - 260,
                            child: const SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!widget.inMenu || screenWidth > 1280)
                  Positioned(
                    child: ControllerCalendarWidget(
                      target: widget.target,
                      onTarget: widget.onTarget,
                      inMenu: widget.inMenu,
                      isMonthView: widget.viewMonth,
                      initDayWeek: initDayWeek,
                      startFlow: startFlow,
                      onExpandedSidebar: widget.sideController.extended,
                      viewWeek: widget.viewWeek,
                      viewMonth: widget.viewMonth,
                      viewYear: widget.viewYear,
                      onChangeDate: (p0) => setState(
                        () {
                          initDayWeek = p0;
                          initDayWeekGraphics = p0;
                        },
                      ),
                      onStartflow: (p0) => setState(() => startFlow = p0),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCalendar(DateTime month, DateTime initDayWeek) {
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    DateTime lastDayOfPreviousMonth =
        firstDayOfMonth.subtract(const Duration(days: 1));
    int daysInPreviousMonth = lastDayOfPreviousMonth.day;

    int lastDayOfMonth = 7 - DateTime(month.year, month.month + 1, 0).weekday;

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.41,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      shrinkWrap: true,
      itemCount: (daysInMonth + weekdayOfFirstDay - 1) + lastDayOfMonth,
      itemBuilder: (context, index) {
        if (index < weekdayOfFirstDay - 1) {
          int previousMonthDay =
              daysInPreviousMonth - (weekdayOfFirstDay - index) + 2;
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor)),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text(
                    previousMonthDay.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 50.ms * index);
        } else if (index < daysInMonth + weekdayOfFirstDay - 1) {
          // Displaying the current month's days
          DateTime date =
              DateTime(month.year, month.month, index - weekdayOfFirstDay + 2);
          int text = date.day;

          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: InkWell(
              onTap: () {
                DateTime selectDate = DateTime(month.year, month.month, text);
                int weekdaySelect = selectDate.weekday;
                DateTime initWeekSelect =
                    selectDate.subtract(Duration(days: weekdaySelect - 1));

                // widget.initDayWeek = initWeekSelect;
                // widget.onChangeDate!.call(initWeekSelect);
                setState(() {});
              },
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Text(
                      text.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 50.ms * index);
        } else {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor)),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text(
                    (index - (daysInMonth + weekdayOfFirstDay - 2)).toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 50.ms * index);
        }
      },
    );
  }
}
