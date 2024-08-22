import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:intl/intl.dart';

import '../utils/helpers/utility.dart';
import 'item_row.dart';
import 'text_styles.dart';

class ControllerCalendarWidget extends StatefulWidget {
  final bool target;
  final bool inMenu;
  final void Function()? onTarget;
  final bool isMonthView;
  final DateTime initDayWeek;
  final bool startFlow;
  final void Function(DateTime)? onChangeDate;
  final void Function(bool)? onStartflow;
  final bool onExpandedSidebar;
  final bool viewWeek;
  final bool viewMonth;
  final bool viewYear;
  final PageController pageMonthController;
  final PageController pageWeekController;
  final void Function(int)? onChangePageWeekController;
  final int yearNow;
  final void Function()? reduceYear;
  final void Function()? increaseYear;
  final void Function(int)? setYear;

  const ControllerCalendarWidget({
    super.key,
    required this.target,
    required this.onTarget,
    required this.inMenu,
    required this.isMonthView,
    required this.initDayWeek,
    required this.startFlow,
    required this.onChangeDate,
    required this.onStartflow,
    required this.onExpandedSidebar,
    required this.viewWeek,
    required this.viewMonth,
    required this.viewYear,
    required this.pageMonthController,
    required this.pageWeekController,
    required this.onChangePageWeekController,
    required this.yearNow,
    required this.reduceYear,
    required this.increaseYear,
    required this.setYear,
  });

  @override
  State<ControllerCalendarWidget> createState() =>
      _ControllerCalendarWidgetState();
}

class _ControllerCalendarWidgetState extends State<ControllerCalendarWidget> {
  DateTime _currentMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth > 875
          ? screenWidth > 950
              ? 350
              : screenWidth * 0.34
          : 300,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: screenHeight - 210,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: (screenWidth > 1280) ? 10 : 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextStyles.standardText(
                                  text: "Diseño de calendario",
                                  isBold: true,
                                  color: Theme.of(context).primaryColor,
                                  size: 14,
                                ),
                              ),
                            ),
                            if (screenWidth < 1280)
                              IconButton(
                                onPressed: () {
                                  widget.onTarget!.call();
                                },
                                icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded),
                              ),
                          ],
                        ),
                      ),
                      if (widget.viewYear)
                        SizedBox(
                          height: 320,
                          width: 300,
                          child: Column(
                            children: [
                              const Divider(height: 5),
                              Expanded(
                                child: PageView.builder(
                                  physics: const NeverScrollableScrollPhysics(),

                                  ///   controller: widget.pageMonthController,
                                  itemCount: 10,
                                  itemBuilder: (context, pageIndex) {
                                    return _buildYear();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (widget.viewMonth)
                        SizedBox(
                          height: 380,
                          width: 300,
                          child: Column(
                            children: [
                              _buildHeaderMonth(),
                              const Divider(height: 5),
                              Expanded(
                                child: PageView.builder(
                                  physics: const NeverScrollableScrollPhysics(),

                                  ///   controller: widget.pageMonthController,
                                  itemCount: 10,
                                  itemBuilder: (context, pageIndex) {
                                    return _buildMonth();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5,
                                width: double.infinity,
                                child: PageView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: widget.pageWeekController,
                                  itemCount: 12 * 12,
                                  itemBuilder: (context, pageIndex) {
                                    return SizedBox();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (widget.viewWeek)
                        SizedBox(
                          height: 380,
                          child: Column(
                            children: [
                              _buildHeaderWeek(),
                              const Divider(height: 5),
                              _buildWeeks(),
                              Expanded(
                                child: PageView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: widget.pageWeekController,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentMonth = DateTime(
                                          _currentMonth.year, index + 1, 1);
                                    });
                                  },
                                  itemCount: 12 * 12,
                                  itemBuilder: (context, pageIndex) {
                                    DateTime month = DateTime(
                                        _currentMonth.year,
                                        (pageIndex % 12) + 1,
                                        1);
                                    return buildCalendarMonth(
                                        month,
                                        widget.initDayWeek
                                            .subtract(const Duration(days: 1)));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ExpansionTile(
                        initiallyExpanded: true,
                        collapsedShape: Border(
                            top: BorderSide(
                                color: Theme.of(context).dividerColor)),
                        title: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add_circle_rounded)),
                        leading: SizedBox(
                          width: 190,
                          child: TextStyles.standardText(
                            text: "Tarifas disponibles",
                            isBold: true,
                            color: Theme.of(context).primaryColor,
                            size: 14,
                          ),
                        ),
                        children: [],
                      ),
                      ExpansionTile(
                        initiallyExpanded: true,
                        collapsedShape: Border(
                            top: BorderSide(
                                color: Theme.of(context).dividerColor)),
                        title: TextStyles.standardText(
                          text: "Usuarios autorizados",
                          isBold: true,
                          color: Theme.of(context).primaryColor,
                          size: 14,
                        ),
                        children: [
                          ItemRow.userTarifaItemRow(context,
                              nameUser: "Neli", rolUser: "Administrador")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStyles.standardText(
                        text: "Ultima modificación:",
                        color: Theme.of(context).primaryColor),
                    TextStyles.standardText(
                        text: Utility.getCompleteDate(data: DateTime.now()),
                        color: Theme.of(context).dividerColor),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(
            delay: !widget.startFlow ? 1200.ms : 0.ms,
            onComplete: (controller) => setState(() {
                  widget.onStartflow!.call(true);
                }),
            target: (screenWidth > 1280)
                ? 1
                : !widget.target
                    ? 1
                    : 0)
        .slideX(begin: -0.2, duration: 550.ms)
        .fadeIn(delay: widget.target ? 0.ms : 400.ms);
  }

  Widget _buildHeaderWeek() {
    bool isLastMonthOfYear = _currentMonth.month == 12;
    bool isFirstMonthOfYear = _currentMonth.month == 1;
    Intl.defaultLocale = "es_ES";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isFirstMonthOfYear)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                setState(() {
                  if (widget.pageWeekController.page! > 0) {
                    widget.pageWeekController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                });
              },
            )
          else
            const SizedBox(width: 36),
          TextStyles.titleText(
              text: DateFormat('MMMM')
                      .format(_currentMonth)
                      .substring(0, 1)
                      .toUpperCase() +
                  DateFormat('MMMM').format(_currentMonth).substring(1),
              color: Theme.of(context).primaryColor,
              size: 16),
          /*
          DropdownButton<int>(
            // Dropdown for selecting a year
            value: _currentMonth.year,
            onChanged: (int? year) {
              if (year != null) {
                setState(() {
                  // Sets the current month to January of the selected year
                  _currentMonth = DateTime(year, 1, 1);

                  // Calculates the month index based on the selected year and sets the page
                  int yearDiff = DateTime.now().year - year;
                  int monthIndex = 12 * yearDiff + _currentMonth.month - 1;
                  _pageController.jumpToPage(monthIndex);
                });
              }
            },
            items: [
              // Generates DropdownMenuItems for a range of years from current year to 10 years ahead
              for (int year = DateTime.now().year;
                  year <= DateTime.now().year + 10;
                  year++)
                DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString()),
                ),
            ],
          ),
          */
          if (!isLastMonthOfYear)
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                if (!isLastMonthOfYear) {
                  setState(() {
                    widget.pageWeekController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  });
                }
              },
            )
          else
            const SizedBox(width: 36),
        ],
      ),
    );
  }

  Widget _buildHeaderMonth() {
    Intl.defaultLocale = "es_ES";
    int yearNowStatic = DateTime.now().year;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.yearNow > yearNowStatic)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                widget.reduceYear!.call();
                // setState(() {
                //   if (widget.pageMonthController.page! > 0) {
                //     widget.pageMonthController.previousPage(
                //       duration: const Duration(milliseconds: 300),
                //       curve: Curves.easeInOut,
                //     );
                //   }
                // });
              },
            )
          else
            const SizedBox(width: 36),
          TextStyles.titleText(
              text: widget.yearNow.toString(),
              color: Theme.of(context).primaryColor,
              size: 16),
          if (widget.yearNow < (yearNowStatic + 11))
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                widget.increaseYear!.call();
                // setState(() {
                //   widget.pageMonthController.nextPage(
                //     duration: const Duration(milliseconds: 300),
                //     curve: Curves.easeInOut,
                //   );
                // });
              },
            )
          else
            const SizedBox(width: 36),
        ],
      ),
    );
  }

  Widget _buildWeeks() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWeekDay('Lun'),
          _buildWeekDay('Mar'),
          _buildWeekDay('Mie'),
          _buildWeekDay('Jue'),
          _buildWeekDay('Vie'),
          _buildWeekDay('Sab'),
          _buildWeekDay('Dom'),
        ],
      ),
    );
  }

  Widget _buildWeekDay(String day) {
    return Center(
      child: TextStyles.standardText(
          text: day, isBold: true, color: Theme.of(context).primaryColor),
    );
  }

  Widget buildCalendarMonth(DateTime month, DateTime initDayWeek) {
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    DateTime lastDayOfPreviousMonth =
        firstDayOfMonth.subtract(const Duration(days: 1));
    int daysInPreviousMonth = lastDayOfPreviousMonth.day;

    int lastDayOfMonth = 7 - DateTime(month.year, month.month + 1, 0).weekday;

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: (daysInMonth + weekdayOfFirstDay - 1) + lastDayOfMonth,
      itemBuilder: (context, index) {
        if (index < weekdayOfFirstDay - 1) {
          int previousMonthDay =
              daysInPreviousMonth - (weekdayOfFirstDay - index) + 2;
          return ((initDayWeek
                          .difference(DateTime(
                                  month.year, month.month - 1, previousMonthDay)
                              .add(const Duration(days: 1)))
                          .inDays
                          .isNegative &&
                      !initDayWeek
                          .add(const Duration(days: 6))
                          .difference(DateTime(
                              month.year, month.month - 1, previousMonthDay))
                          .inDays
                          .isNegative) ||
                  widget.isMonthView)
              ? Opacity(
                  opacity: 0.5,
                  child: Card(
                    elevation: 3.5,
                    color: Colors.green[300],
                    child: Center(
                      child: Text(
                        previousMonthDay.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  child: Text(
                    previousMonthDay.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
        } else if (index < daysInMonth + weekdayOfFirstDay - 1) {
          // Displaying the current month's days
          DateTime date =
              DateTime(month.year, month.month, index - weekdayOfFirstDay + 2);
          int text = date.day;

          return InkWell(
            onTap: () {
              DateTime selectDate = DateTime(month.year, month.month, text);
              int weekdaySelect = selectDate.weekday;
              DateTime initWeekSelect =
                  selectDate.subtract(Duration(days: weekdaySelect - 1));

              // widget.initDayWeek = initWeekSelect;
              widget.onChangeDate!.call(initWeekSelect);
              setState(() {});
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if ((initDayWeek
                            .difference(DateTime(month.year, month.month, text)
                                .add(const Duration(days: 0)))
                            .inDays
                            .isNegative &&
                        !initDayWeek
                            .add(const Duration(days: 7))
                            .difference(DateTime(month.year, month.month, text))
                            .inDays
                            .isNegative) ||
                    widget.isMonthView)
                  Expanded(
                    child: Card(
                      elevation: 3.5,
                      color: Colors.green[300],
                      child: Center(
                        child: Text(
                          text.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        text.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        } else {
          return ((initDayWeek
                          .difference(DateTime(
                                  month.year,
                                  month.month + 1,
                                  (index -
                                      (daysInMonth + weekdayOfFirstDay - 2)))
                              .add(const Duration(days: 0)))
                          .inDays
                          .isNegative &&
                      !initDayWeek
                          .add(const Duration(days: 7))
                          .difference(DateTime(month.year, month.month + 1,
                              (index - (daysInMonth + weekdayOfFirstDay - 2))))
                          .inDays
                          .isNegative) ||
                  widget.isMonthView)
              ? Opacity(
                  opacity: 0.5,
                  child: Card(
                    elevation: 3.5,
                    color: Colors.green[300],
                    child: Center(
                      child: Text(
                        (index - (daysInMonth + weekdayOfFirstDay - 2))
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(),
                  alignment: Alignment.center,
                  child: Text(
                    (index - (daysInMonth + weekdayOfFirstDay - 2)).toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
        }
      },
    );
  }

  Widget _buildMonth() {
    return GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.3),
        itemCount: 12,
        itemBuilder: (context, index) {
          return Card(
            color: (index == (_currentMonth.month - 1))
                ? DesktopColors.ceruleanOscure
                : DesktopColors.cerulean,
            elevation: 10,
            child: InkWell(
              onTap: () {
                widget.onChangePageWeekController!.call(index);

                setState(() {
                  _currentMonth = DateTime(_currentMonth.year, index + 1, 1);
                });
              },
              child: Center(
                child: Text(
                  monthNames[index],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildYear() {
    return GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.3),
        itemCount: 12,
        itemBuilder: (context, index) {
          return Card(
            color: ((DateTime.now().year + index) == (widget.yearNow))
                ? DesktopColors.ceruleanOscure
                : DesktopColors.cerulean,
            elevation: 10,
            child: InkWell(
              onTap: () {
                widget.setYear!.call(DateTime.now().year + (index));
              },
              child: Center(
                child: Text(
                  "${DateTime.now().year + index}",
                ),
              ),
            ),
          );
        });
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
