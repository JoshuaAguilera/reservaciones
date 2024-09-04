import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/controller_calendar_widget.dart';
import 'package:generador_formato/widgets/item_row.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../providers/tarifario_provider.dart';
import '../../ui/custom_widgets.dart';
import '../../ui/progress_indicator.dart';
import '../../widgets/period_item_row.dart';

class TarifarioCalendaryView extends ConsumerStatefulWidget {
  const TarifarioCalendaryView({
    super.key,
    required this.target,
    required this.onTarget,
    required this.inMenu,
    required this.sideController,
    required this.viewWeek,
    required this.viewMonth,
    required this.viewYear,
    required this.yearNow,
    required this.reduceYear,
    required this.increaseYear,
    required this.setYear,
    required this.targetForm,
    required this.showForm,
    required this.onTargetForm,
    required this.onCreate,
  });

  final bool target;
  final bool inMenu;
  final void Function()? onTarget;
  final SidebarXController sideController;
  final bool viewWeek;
  final bool viewMonth;
  final bool viewYear;
  final int yearNow;
  final bool targetForm;
  final bool showForm;
  final void Function()? reduceYear;
  final void Function()? increaseYear;
  final void Function(int)? setYear;
  final void Function()? onTargetForm;
  final void Function()? onCreate;

  @override
  _TarifarioCalendaryViewState createState() => _TarifarioCalendaryViewState();
}

class _TarifarioCalendaryViewState
    extends ConsumerState<TarifarioCalendaryView> {
  DateTime initDayWeek =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday));
  DateTime initDayWeekGraphics =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  bool selectedcurrentyear = false;
  bool startFlow = false;
  PageController pageWeekController =
      PageController(initialPage: DateTime.now().month - 1);
  final PageController pageMonthController = PageController(initialPage: 0);
  final DateTime _currentMonth = DateTime.now();
  double targetMonth = 1;
  bool showMonth = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final tarifasProvider = ref.watch(allTarifaProvider(""));
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                if (widget.viewYear)
                  SizedBox(
                    height: screenHeight - 160,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: (screenWidth > 1280) ? (380) : 0),
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: (screenWidth > 1080) ? 3 : 2,
                                childAspectRatio: 0.85,
                                crossAxisSpacing: 25,
                              ),
                              itemCount: 12,
                              itemBuilder: (context, index) {
                                DateTime month = DateTime(
                                    _currentMonth.year, (index % 12) + 1, 1);
                                return SizedBox(
                                  height: 380,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildHeaderYear(month),
                                      _buildWeeks(),
                                      const Divider(height: 5),
                                      Expanded(
                                        child: buildCalendarYear(month),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                            .animate(target: 1)
                            .fadeIn(duration: 1800.ms, begin: -.6),
                      ],
                    ),
                  ),
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
                        if (showMonth)
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
                                    : (screenWidth > 800)
                                        ? screenWidth -
                                            (widget.sideController.extended
                                                ? 230
                                                : 118)
                                        : screenWidth - 28,
                                height: screenHeight - 225,
                                child: PageView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: pageWeekController,
                                  itemCount: 12 * 12,
                                  itemBuilder: (context, pageIndex) {
                                    DateTime month = DateTime(widget.yearNow,
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
                                ).animate(target: targetMonth).fadeIn(
                                    duration:
                                        targetMonth == 0 ? 500.ms : 1200.ms,
                                    begin: -.6),
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
                                    : (screenWidth > 800)
                                        ? screenWidth -
                                            (widget.sideController.extended
                                                ? 230
                                                : 118)
                                        : screenWidth - 28,
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
                                    TableRow(
                                      children: [
                                        for (var i = initDayWeek.day;
                                            i < (initDayWeek.day + 7);
                                            i++)
                                          SizedBox(
                                            height: screenHeight - 270,
                                            child: const Text(""),
                                          ),
                                      ],
                                    ),
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
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  tarifasProvider.when(
                                    data: (list) {
                                      if (list.isNotEmpty) {
                                        return SizedBox(
                                          height: screenHeight - 260,
                                          width: (screenWidth > 1280)
                                              ? (screenWidth -
                                                  378 -
                                                  (widget.sideController
                                                          .extended
                                                      ? 230
                                                      : 118))
                                              : (screenWidth > 800)
                                                  ? screenWidth -
                                                      (widget.sideController
                                                              .extended
                                                          ? 230
                                                          : 118)
                                                  : screenWidth - 28,
                                          child: ListView.builder(
                                            itemCount: list.length,
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              if (Utility.showTariffByWeek(
                                                  list[index].nombre!,
                                                  list[index].periodos,
                                                  initDayWeekGraphics)) {
                                                return PeriodItemRow(
                                                  weekNow: initDayWeekGraphics,
                                                  tarifa: list[index],
                                                  lenghtDays: 1,
                                                  lenghtSideBar: (widget
                                                          .sideController
                                                          .extended
                                                      ? 230
                                                      : 118),
                                                );
                                              } else {
                                                return SizedBox();
                                              }
                                            },
                                          ),
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                    error: (error, stackTrace) {
                                      return SizedBox(
                                        height: 150,
                                        child: CustomWidgets.messageNotResult(
                                            context: context, sizeImage: 100),
                                      );
                                    },
                                    loading: () {
                                      return Center(
                                        child: ProgressIndicatorCustom(
                                          screenHight: screenHeight - 250,
                                          sizeProgressIndicator: 50,
                                        ),
                                      );
                                    },
                                  ),
                                ],
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
                      pageMonthController: pageMonthController,
                      pageWeekController: pageWeekController,
                      yearNow: widget.yearNow,
                      setYear: widget.setYear,
                      onChangeDate: (p0) => setState(
                        () {
                          initDayWeek = p0;
                          initDayWeekGraphics = p0;
                        },
                      ),
                      increaseYear: () {
                        setState(() => targetMonth = 0);

                        Future.delayed(
                          550.ms,
                          () => setState(() => showMonth = false),
                        );

                        widget.increaseYear!.call();

                        Future.delayed(
                          650.ms,
                          () => setState(
                            () {
                              showMonth = true;
                              targetMonth = 1;
                            },
                          ),
                        );
                      },
                      reduceYear: () {
                        setState(() => targetMonth = 0);

                        Future.delayed(
                          550.ms,
                          () => setState(() => showMonth = false),
                        );

                        widget.reduceYear!.call();

                        Future.delayed(
                          650.ms,
                          () => setState(
                            () {
                              showMonth = true;
                              targetMonth = 1;
                            },
                          ),
                        );
                      },
                      onChangePageWeekController: (p0) {
                        setState(() => targetMonth = 0);

                        Future.delayed(
                          550.ms,
                          () => setState(() => showMonth = false),
                        );

                        Future.delayed(
                            600.ms,
                            () => setState(() => pageWeekController =
                                PageController(initialPage: p0)));

                        Future.delayed(
                          650.ms,
                          () => setState(
                            () {
                              showMonth = true;
                              targetMonth = 1;
                            },
                          ),
                        );
                      },
                      onPreviewPage: (p0) {
                        setState(() {
                          pageWeekController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );

                          pageWeekController = PageController(initialPage: p0);
                        });
                      },
                      onNextPage: (p0) {
                        setState(() {
                          pageWeekController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        });
                        pageWeekController = PageController(initialPage: p0);
                      },
                      onStartflow: (p0) => setState(() => startFlow = p0),
                      onCreated: () => widget.onCreate!.call(),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCalendarYear(DateTime month) {
    int daysInMonth = DateTime(widget.yearNow, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(widget.yearNow, month.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    int lastDayOfMonth =
        7 - DateTime(widget.yearNow, month.month + 1, 0).weekday;

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: (daysInMonth + weekdayOfFirstDay - 1) + lastDayOfMonth,
      itemBuilder: (context, index) {
        if (index < weekdayOfFirstDay - 1) {
          return const SizedBox();
        } else if (index < daysInMonth + weekdayOfFirstDay - 1) {
          // Displaying the current month's days
          DateTime date = DateTime(
              widget.yearNow, month.month, index - weekdayOfFirstDay + 2);
          int text = date.day;

          return InkWell(
            onTap: () {
              // DateTime selectDate = DateTime(month.year, month.month, text);
              // int weekdaySelect = selectDate.weekday;
              // DateTime initWeekSelect =
              //     selectDate.subtract(Duration(days: weekdaySelect - 1));

              // // widget.initDayWeek = initWeekSelect;
              // // widget.onChangeDate!.call(initWeekSelect);
              // setState(() {});
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if ((initDayWeek
                        .difference(DateTime(widget.yearNow, month.month, text)
                            .add(const Duration(days: 1)))
                        .inDays
                        .isNegative &&
                    !initDayWeek
                        .add(const Duration(days: 6))
                        .difference(DateTime(widget.yearNow, month.month, text))
                        .inDays
                        .isNegative))
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
          return const SizedBox();
        }
      },
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
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        mainAxisExtent: 129,
      ),
      shrinkWrap: true,
      itemCount: (daysInMonth + weekdayOfFirstDay - 1) + lastDayOfMonth,
      itemBuilder: (context, index) {
        if (index < weekdayOfFirstDay - 1) {
          int previousMonthDay =
              daysInPreviousMonth - (weekdayOfFirstDay - index) + 2;
          return Opacity(
            opacity: 0.25,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor)),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    left: 5,
                    child: TextStyles.standardText(
                      text: previousMonthDay.toString(),
                      color: Theme.of(context).primaryColor,
                      isBold: true,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 50.ms * index),
          );
        } else if (index < daysInMonth + weekdayOfFirstDay - 1) {
          DateTime date =
              DateTime(month.year, month.month, index - weekdayOfFirstDay + 2);
          int text = date.day;
          DateTime dateNow = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day);

          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: InkWell(
              onTap: () {},
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                      width: 20,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: dateNow.isSameDate(date) ? Colors.amber : null,
                      ),
                      child: Center(
                        child: Text(
                          text.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 50.ms * index);
        } else {
          return Opacity(
            opacity: 0.25,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor)),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    left: 5,
                    child: TextStyles.standardText(
                      text: (index - (daysInMonth + weekdayOfFirstDay - 2))
                          .toString(),
                      isBold: true,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 50.ms * index),
          );
        }
      },
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

  Widget _buildHeaderYear(DateTime month) {
    Intl.defaultLocale = "es_ES";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
            color: DesktopColors.cerulean,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        width: 700,
        height: 40,
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextStyles.titleText(
            text:
                "              ${DateFormat('MMMM').format(month).substring(0, 1).toUpperCase()}${DateFormat('MMMM').format(month).substring(1)}",
            color: Theme.of(context).primaryColor,
            size: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildWeeks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildWeekDay('L'),
        _buildWeekDay('M'),
        _buildWeekDay('Mi'),
        _buildWeekDay('J'),
        _buildWeekDay('V'),
        _buildWeekDay('S'),
        _buildWeekDay('D'),
      ],
    );
  }

  Widget _buildWeekDay(String day) {
    return Center(
      child: TextStyles.standardText(
          text: day, isBold: true, color: Theme.of(context).primaryColor),
    );
  }
}
