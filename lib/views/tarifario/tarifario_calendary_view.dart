import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/views/tarifario/tarifario_calendary_month_view.dart';
import 'package:generador_formato/views/tarifario/tarifario_calendary_week_view.dart';
import 'package:generador_formato/widgets/controller_calendar_widget.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../providers/tarifario_provider.dart';
import '../../widgets/dynamic_widget.dart';

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

  DateTime initWeekMonth = DateTime.now();
  bool selectedcurrentyear = false;
  bool startFlow = false;
  PageController pageWeekController =
      PageController(initialPage: DateTime.now().month - 1);
  final PageController pageMonthController = PageController(initialPage: 0);
  final DateTime _currentMonth = DateTime.now();
  double targetMonth = 1;
  bool showMonth = true;
  bool changeDate = false;
  bool changeMonth = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final tarifasProvider = ref.watch(allTarifaProvider(""));

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
                        tarifasProvider.when(
                          data: (list) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: (screenWidth > 1280) ? (380) : 0),
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        (screenWidth > 1080) ? 3 : 2,
                                    childAspectRatio: 0.9,
                                    crossAxisSpacing: 25,
                                  ),
                                  itemCount: 12,
                                  itemBuilder: (context, index) {
                                    DateTime month = DateTime(
                                        _currentMonth.year,
                                        (index % 12) + 1,
                                        1);
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
                                            child:
                                                buildCalendarYear(month, list),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            )
                                .animate(target: 1)
                                .fadeIn(duration: 1800.ms, begin: -.6);
                          },
                          error: (error, stackTrace) => const SizedBox(),
                          loading: () => dynamicWidget.loadingWidget(
                              screenWidth,
                              screenHeight,
                              widget.sideController.extended),
                        ),
                      ],
                    ),
                  ),
                if (widget.viewMonth)
                  TarifarioCalendaryMonthView(
                    sideController: widget.sideController,
                    initWeekMonth: initWeekMonth,
                    showMonth: showMonth,
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
                          if (!changeDate) {
                            changeDate = true;
                          }
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
                      },
                      reduceYear: () {
                        setState(() => targetMonth = 0);

                        Future.delayed(
                          550.ms,
                          () => setState(() => showMonth = false),
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

                        Future.delayed(
                            Durations.long4,
                            () => setState(() => initWeekMonth =
                                DateTime(widget.yearNow, (p0 % 12) + 1, 1)));
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
                        print(p0);
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

  Widget buildCalendarYear(DateTime month, List<RegistroTarifa> list) {
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

          RegistroTarifa? tariffNow = Utility.revisedTariffDay(
              DateTime(widget.yearNow, month.month, text), list);

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
                if (tariffNow != null)
                  Expanded(
                    child: Card(
                      elevation: 3.5,
                      color: tariffNow.color,
                      child: Center(
                        child: Text(
                          text.toString(),
                          style: TextStyle(
                            fontWeight: useWhiteForeground(tariffNow.color!)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: useWhiteForeground(tariffNow.color!)
                                ? Colors.white
                                : Colors.black,
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
