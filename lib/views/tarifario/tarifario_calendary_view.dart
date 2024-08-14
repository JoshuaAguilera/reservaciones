import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/item_row.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:intl/intl.dart';

import '../../utils/helpers/web_colors.dart';

class TarifarioCalendaryView extends StatefulWidget {
  const TarifarioCalendaryView(
      {super.key, required this.target, required this.onTarget});
  final bool target;
  final void Function()? onTarget;

  @override
  State<TarifarioCalendaryView> createState() => _TarifarioCalendaryViewState();
}

class _TarifarioCalendaryViewState extends State<TarifarioCalendaryView> {
  final PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);
  DateTime _currentMonth = DateTime.now();
  bool selectedcurrentyear = false;
  bool startFlow = false;

  final List<bool> selectWeek = [
    false,
    false,
    false,
    true,
    false,
    false,
    false
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                    top: 100,
                    child: SizedBox(
                      width: screenWidth,
                      child: Table(
                        columnWidths: {
                          0: const FractionColumnWidth(.12),
                        },
                        border: TableBorder(
                          horizontalInside:
                              BorderSide(color: Theme.of(context).dividerColor),
                          top:
                              BorderSide(color: Theme.of(context).dividerColor),
                          bottom:
                              BorderSide(color: Theme.of(context).dividerColor),
                        ),
                        children: [
                          TableRow(children: [
                            SizedBox(
                              height: 80,
                              child: Center(
                                child: TextStyles.standardText(
                                  text: "Tarifa Mayo - Junio",
                                  overClip: true,
                                  aling: TextAlign.center,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox()
                          ]),
                          TableRow(children: [
                            SizedBox(
                              height: 80,
                              child: Center(
                                child: TextStyles.standardText(
                                  text: "Tarifa Agosto - Octubre",
                                  overClip: true,
                                  aling: TextAlign.center,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox()
                          ])
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 7,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7, childAspectRatio: 0.5),
                    itemBuilder: (context, index) {
                      return ItemRow.getTitleDay(
                        title: index + 1,
                        subTitle: "Lun",
                        select: selectWeek[index],
                        index: index,
                        brightness: brightness,
                      );
                    },
                  ),
                ),
                Positioned(
                  child: SizedBox(
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: (screenWidth > 1280) ? 10 : 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            SizedBox(
                              height: 380,
                              child: Column(
                                children: [
                                  _buildHeader(),
                                  const Divider(height: 5),
                                  _buildWeeks(),
                                  Expanded(
                                    child: PageView.builder(
                                      controller: _pageController,
                                      onPageChanged: (index) {
                                        setState(() {
                                          _currentMonth = DateTime(
                                              _currentMonth.year, index + 1, 1);
                                        });
                                      },
                                      itemCount: 12 *
                                          10, // Show 10 years, adjust this count as needed
                                      itemBuilder: (context, pageIndex) {
                                        DateTime month = DateTime(
                                            _currentMonth.year,
                                            (pageIndex % 12) + 1,
                                            1);
                                        return buildCalendar(month);
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
                              title: TextStyles.standardText(
                                text: "Tarifas disponibles",
                                isBold: true,
                                color: Theme.of(context).primaryColor,
                                size: 14,
                              ),
                              children: [
                                ItemRow.tarifaItemRow(
                                  context,
                                  nameRack: "Mayo - Julio",
                                  colorIndicator: Colors.blue[200],
                                ),
                                ItemRow.tarifaItemRow(
                                  context,
                                  nameRack: "Agosto - Octubre",
                                  colorIndicator: Colors.amber,
                                ),
                              ],
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
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextStyles.standardText(
                                      text: "Ultima modificación:",
                                      color: Theme.of(context).primaryColor),
                                  TextStyles.standardText(
                                      text: Utility.getCompleteDate(
                                          data: DateTime.now()),
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
                          delay: !startFlow ? 1600.ms : 0.ms,
                          onComplete: (controller) => setState(() {
                                startFlow = true;
                              }),
                          target: (screenWidth > 1280)
                              ? 1
                              : !widget.target
                                  ? 1
                                  : 0)
                      .slideX(begin: -0.2, duration: 550.ms)
                      .fadeIn(delay: widget.target ? 0.ms : 400.ms),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    // Checks if the current month is the last month of the year (December)
    bool isLastMonthOfYear = _currentMonth.month == 12;
    Intl.defaultLocale = "es_ES";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              // Moves to the previous page if the current page index is greater than 0
              if (_pageController.page! > 0) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
          // Displays the name of the current month
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
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            onPressed: () {
              // Moves to the next page if it's not the last month of the year
              if (!isLastMonthOfYear) {
                setState(() {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              }
            },
          ),
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

  // This widget builds the detailed calendar grid for the chosen month.
  Widget buildCalendar(DateTime month) {
    // Calculating various details for the month's display
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    DateTime lastDayOfPreviousMonth =
        firstDayOfMonth.subtract(Duration(days: 1));
    int daysInPreviousMonth = lastDayOfPreviousMonth.day;

    int lastDayOfMonth = 7 - DateTime(month.year, month.month + 1, 0).weekday;

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: (daysInMonth + weekdayOfFirstDay - 1) + lastDayOfMonth,
      itemBuilder: (context, index) {
        if (index < weekdayOfFirstDay - 1) {
          // Displaying dates from the previous month in grey
          int previousMonthDay =
              daysInPreviousMonth - (weekdayOfFirstDay - index) + 2;
          return Container(
            decoration: const BoxDecoration(
                // border: Border(
                //   top: BorderSide.none,
                //   left: BorderSide(width: 1.0, color: Colors.grey),
                //   right: BorderSide(width: 1.0, color: Colors.grey),
                //   bottom: BorderSide(width: 1.0, color: Colors.grey),
                // ),
                ),
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
          String text = date.day.toString();

          return InkWell(
            onTap: () {
              // Handle tap on a date cell
              // This is where you can add functionality when a date is tapped
            },
            child: Container(
              decoration: const BoxDecoration(
                  // border: Border(
                  //   top: BorderSide.none,
                  //   left: BorderSide(width: 1.0, color: Colors.grey),
                  //   right: BorderSide(width: 1.0, color: Colors.grey),
                  //   bottom: BorderSide(width: 1.0, color: Colors.grey),
                  // ),
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
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
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
