import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/widgets/controller_calendar_widget.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../providers/tarifario_provider.dart';
import '../../ui/custom_widgets.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/dynamic_widget.dart';
import '../../widgets/item_rows.dart';
import '../../widgets/period_item_row.dart';
import '../../widgets/text_styles.dart';

class TarifarioCalendaryMonthView extends ConsumerStatefulWidget {
  const TarifarioCalendaryMonthView({
    super.key,
    required this.sideController,
    required this.initWeekMonth,
    required this.initDayWeekGraphics,
    required this.initDayWeek,
    required this.refreshDate,
    required this.yearNow,
    required this.showMonth,
    required this.pageWeekController,
    required this.targetMonth,
    required this.showMonthDelay,
  });

  final SidebarXController sideController;
  final DateTime initWeekMonth;
  final DateTime initDayWeekGraphics;
  final DateTime initDayWeek;
  final void Function(int)? refreshDate;
  final int yearNow;
  final bool showMonth;
  final PageController pageWeekController;
  final double targetMonth;
  final bool showMonthDelay;

  @override
  _TarifarioCalendaryMonthViewState createState() =>
      _TarifarioCalendaryMonthViewState();
}

class _TarifarioCalendaryMonthViewState
    extends ConsumerState<TarifarioCalendaryMonthView> {
  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    final listTarifasProvider = ref.watch(listTarifaProvider(""));
    final tarifaProvider = ref.watch(allTarifaProvider(""));
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight - 160,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 129 * 6.55,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: (screenWidth > 1280) ? (380) : 0),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 7,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7, childAspectRatio: 0.5),
                      itemBuilder: (context, index) {
                        return ItemRows.getTitleDay(
                          title: 0,
                          withOutDay: true,
                          subTitle: daysNameShort[widget.initDayWeekGraphics
                                  .add(Duration(days: index))
                                  .weekday -
                              1],
                          select: widget.initDayWeekGraphics
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
                  if (widget.showMonth)
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
                                  (widget.sideController.extended ? 230 : 118))
                              : (screenWidth > 800)
                                  ? screenWidth -
                                      (widget.sideController.extended
                                          ? 230
                                          : 118)
                                  : screenWidth - 28,
                          height: 129 * 6.55,
                          child: PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: widget.pageWeekController,
                            itemCount: 12 * 12,
                            itemBuilder: (context, pageIndex) {
                              DateTime month = DateTime(
                                  widget.yearNow, (pageIndex % 12) + 1, 1);

                              if (widget.refreshDate != null) {
                                widget.refreshDate!.call(pageIndex);
                              }

                              return buildCalendar(
                                month,
                                widget.initDayWeek.subtract(
                                  const Duration(
                                    days: 1,
                                  ),
                                ),
                              );
                            },
                          ).animate(target: widget.targetMonth).fadeIn(
                              duration:
                                  widget.targetMonth == 0 ? 500.ms : 1200.ms,
                              begin: -.6),
                        ),
                      ),
                    ),
                  Positioned(
                    left: (screenWidth > 1280) ? (385) : 0,
                    top: 65,
                    child: SizedBox(
                      height: screenHeight - 238,
                      child: tarifaProvider.when(
                        data: (list) {
                          return const SizedBox();
                        },
                        error: (error, stackTrace) => Padding(
                          padding: EdgeInsets.only(
                              left: (screenWidth > 1280) ? (380) : 0),
                          child: SizedBox(
                              height: 150,
                              child: CustomWidgets.messageNotResult(
                                context: context,
                                sizeImage: 100,
                              )),
                        ),
                        loading: () => Padding(
                          padding: EdgeInsets.only(
                              left: (screenWidth > 1280) ? (630) : 0),
                          child: dynamicWidget.loadingWidget(
                              screenWidth, 500, widget.sideController.extended,
                              isEstandar: true, sizeIndicator: 50),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: (screenWidth > 1280) ? (385) : 0,
                    top: 65,
                    child: SizedBox(
                      height: 129 * 6.55,
                      child: Column(
                        children: [
                          for (var i = 0;
                              i < Utility.getWeeksMonth(widget.initWeekMonth);
                              i++)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 129 * 0.25),
                                listTarifasProvider.when(
                                  data: (list) {
                                    if (list.isNotEmpty) {
                                      return SizedBox(
                                        height: 129 * 0.75,
                                        width: (screenWidth > 1280)
                                            ? (screenWidth -
                                                378 -
                                                (widget.sideController.extended
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
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding:
                                              const EdgeInsets.only(bottom: 0),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            if (Utility.showTariffByWeek(
                                                    list[index].periodos,
                                                    Utility.getInitsWeekMonth(
                                                        widget.initWeekMonth,
                                                        i)) &&
                                                list[index].isSelected!) {
                                              return PeriodItemRow(
                                                target: widget.targetMonth,
                                                showMonth:
                                                    widget.showMonthDelay,
                                                compact: true,
                                                weekNow:
                                                    Utility.getInitsWeekMonth(
                                                        widget.initWeekMonth,
                                                        i),
                                                tarifa: list[index],
                                                lenghtDays: 1,
                                                lenghtSideBar: (widget
                                                        .sideController.extended
                                                    ? 230
                                                    : 118),
                                              );
                                            } else {
                                              return const SizedBox();
                                            }
                                          },
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                  error: (error, stackTrace) =>
                                      const SizedBox(),
                                  loading: () => const SizedBox(),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
}
