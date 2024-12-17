import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/views/tarifario/tarifario_calendary_month_view.dart';
import 'package:generador_formato/views/tarifario/tarifario_calendary_week_view.dart';
import 'package:generador_formato/views/tarifario/tarifario_calendary_year_view.dart';
import 'package:generador_formato/views/tarifario/calendar_controller_widget.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

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
  // DateTime initDayWeek =
  //     DateTime.now().subtract(Duration(days: DateTime.now().weekday));
  // DateTime initDayWeekGraphics =
  //     DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));

  DateTime initDayWeek =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(
              days: DateTime(DateTime.now().year, DateTime.now().month,
                          DateTime.now().day)
                      .weekday -
                  1));
  DateTime initDayWeekGraphics =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(
              days: DateTime(DateTime.now().year, DateTime.now().month,
                          DateTime.now().day)
                      .weekday -
                  1));

  DateTime initWeekMonth = DateTime.now();
  bool selectedcurrentyear = false;
  bool startFlow = false;
  PageController pageWeekController =
      PageController(initialPage: DateTime.now().month - 1);
  final PageController pageMonthController = PageController(initialPage: 0);
  final DateTime _currentMonth = DateTime.now();
  double targetMonth = 1;
  bool showMonth = true;
  bool showMonthDelay = false;
  bool changeDate = false;
  bool changeMonth = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                if (widget.viewYear)
                  TarifarioCalendaryYearView(
                    currentMonth: _currentMonth,
                    sideController: widget.sideController,
                    yearNow: widget.yearNow,
                  ),
                if (widget.viewMonth)
                  TarifarioCalendaryMonthView(
                    sideController: widget.sideController,
                    initWeekMonth: initWeekMonth,
                    showMonth: showMonth,
                    showMonthDelay: showMonthDelay,
                    targetMonth: targetMonth,
                    initDayWeek: initDayWeek,
                    initDayWeekGraphics: initDayWeekGraphics,
                    yearNow: widget.yearNow,
                    pageWeekController: pageWeekController,
                    refreshDate: (pageIndex) {
                      if (!changeMonth) {
                        Future.delayed(
                            Durations.medium1,
                            () => setState(() => initWeekMonth = DateTime(
                                widget.yearNow, (pageIndex % 12) + 1, 1)));
                        changeMonth = true;
                      }
                    },
                  ),
                if (widget.viewWeek)
                  TarifarioCalendaryWeekView(
                    sideController: widget.sideController,
                    initDayWeek: initDayWeek,
                    initDayWeekGraphics: initDayWeekGraphics,
                    changeDate: changeDate,
                  ),
                if (!widget.inMenu || screenWidth > 1280)
                  Positioned(
                    child: CalendarControllerWidget(
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
                          if (!changeDate) {
                            changeDate = true;
                          }
                        },
                      ),
                      increaseYear: () {
                        setState(() => targetMonth = 0);

                        Future.delayed(
                          550.ms,
                          () => setState(() {
                            showMonth = false;
                            showMonthDelay = false;
                          }),
                        );

                        widget.increaseYear!.call();

                        Future.delayed(
                            Durations.long4,
                            () => setState(() => initWeekMonth = DateTime(
                                widget.yearNow,
                                (pageWeekController.initialPage.toInt() % 12) +
                                    1,
                                1)));

                        Future.delayed(
                          650.ms,
                          () => setState(
                            () {
                              showMonth = true;
                              targetMonth = 1;
                            },
                          ),
                        );

                        Future.delayed(
                          850.ms,
                          () => setState(() => showMonthDelay = true),
                        );
                      },
                      reduceYear: () {
                        setState(() => targetMonth = 0);

                        Future.delayed(
                          550.ms,
                          () => setState(() {
                            showMonth = false;
                            showMonthDelay = false;
                          }),
                        );

                        widget.reduceYear!.call();

                        Future.delayed(
                            Durations.long4,
                            () => setState(() => initWeekMonth = DateTime(
                                widget.yearNow,
                                (pageWeekController.initialPage.toInt() % 12) +
                                    1,
                                1)));

                        Future.delayed(
                          650.ms,
                          () => setState(
                            () {
                              showMonth = true;
                              targetMonth = 1;
                            },
                          ),
                        );

                        Future.delayed(
                          850.ms,
                          () => setState(() => showMonthDelay = true),
                        );
                      },
                      onChangePageWeekController: (p0) {
                        setState(() => targetMonth = 0);

                        Future.delayed(
                          550.ms,
                          () => setState(() {
                            showMonth = false;
                            showMonthDelay = false;
                          }),
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

                        Future.delayed(
                            Durations.long4,
                            () => setState(() => initWeekMonth =
                                DateTime(widget.yearNow, (p0 % 12) + 1, 1)));

                        Future.delayed(
                          850.ms,
                          () => setState(() => showMonthDelay = true),
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

                        Future.delayed(
                            Durations.long4,
                            () => setState(() => initWeekMonth =
                                DateTime(widget.yearNow, (p0 % 12) + 1, 1)));
                      },
                      onNextPage: (p0) {
                        setState(() {
                          pageWeekController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );

                          pageWeekController = PageController(initialPage: p0);
                        });

                        Future.delayed(
                            Durations.long4,
                            () => setState(() => initWeekMonth =
                                DateTime(widget.yearNow, (p0 % 12) + 1, 1)));
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
}
