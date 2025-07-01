import 'package:flutter/material.dart';
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
  final bool targetForm;
  final bool showForm;
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
  final PageController pageMonthController = PageController(initialPage: 0);
  final DateTime _currentMonth = DateTime.now();
  double targetMonth = 1;
  bool changeDate = false;
  bool changeMonth = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //Trata de unificarlo mi chavo

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
                  ),
                if (widget.viewMonth)
                  TarifarioCalendaryMonthView(
                    sideController: widget.sideController,
                    initDayWeekGraphics: initDayWeekGraphics,
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
                      onChangeDate: (p0) => setState(
                        () {
                          initDayWeek = p0;
                          initDayWeekGraphics = p0;
                          if (!changeDate) {
                            changeDate = true;
                          }
                        },
                      ),
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
