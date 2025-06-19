import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/views/tarifario/calendar_controller_widget.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../models/registro_tarifa_model.dart';
import '../../view-models/providers/tarifario_provider.dart';
import '../../res/ui/custom_widgets.dart';
import '../../res/helpers/utility.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../utils/shared_preferences/settings.dart';
import '../../utils/widgets/day_info_item_row.dart';
import '../../utils/widgets/dynamic_widget.dart';
import '../../res/ui/text_styles.dart';

class TarifarioCalendaryYearView extends ConsumerStatefulWidget {
  const TarifarioCalendaryYearView({
    super.key,
    required this.currentMonth,
    required this.sideController,
  });

  final DateTime currentMonth;
  final SidebarXController sideController;

  @override
  _TarifarioCalendaryYearViewState createState() =>
      _TarifarioCalendaryYearViewState();
}

class _TarifarioCalendaryYearViewState
    extends ConsumerState<TarifarioCalendaryYearView> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final listTarifasProvider = ref.watch(listTarifaProvider(""));
    final tarifaProvider = ref.watch(allTarifaProvider(""));
    final dateTariffer = ref.watch(dateTarifferProvider);

    return SizedBox(
      height: screenHeight - 160,
      child: Stack(
        children: [
          tarifaProvider.when(
            data: (list) {
              return listTarifasProvider.when(
                data: (list) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: (screenWidth > 1280) ? (380) : 0),
                    child: GridView.builder(
                      key: const PageStorageKey('myGridViewKey'),
                      addRepaintBoundaries: true,
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (screenWidth > 1080) ? 3 : 2,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 25,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        DateTime month =
                            DateTime(dateTariffer.year, (index % 12) + 1, 1);

                        return SizedBox(
                          height: 370,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeaderYear(month),
                              _buildWeeks(),
                              const Divider(height: 5),
                              Expanded(
                                child: Card(
                                    elevation: 5,
                                    child: buildCalendarYear(
                                        month, list, dateTariffer)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ).animate(target: 1).fadeIn(
                        duration: Settings.applyAnimations ? 1800.ms : 0.ms,
                        begin: -.6,
                      );
                },
                error: (error, stackTrace) => const SizedBox(),
                loading: () => const SizedBox(),
              );
            },
            error: (error, stackTrace) => Padding(
              padding: EdgeInsets.only(left: (screenWidth > 1280) ? (380) : 0),
              child: SizedBox(
                height: 150,
                child: CustomWidgets.messageNotResult(
                  context: context,
                  sizeImage: 100,
                ),
              ),
            ),
            loading: () => Padding(
              padding: EdgeInsets.only(left: (screenWidth > 1280) ? (380) : 0),
              child: dynamicWidget.loadingWidget(
                  screenWidth, 500, widget.sideController.extended,
                  isEstandar: true, sizeIndicator: 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCalendarYear(
      DateTime month, List<RegistroTarifa> list, DateTime dateTariffer) {
    int daysInMonth = DateTime(dateTariffer.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(dateTariffer.year, month.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    int lastDayOfMonth =
        7 - DateTime(dateTariffer.year, month.month + 1, 0).weekday;

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
              dateTariffer.year, month.month, index - weekdayOfFirstDay + 2);
          int text = date.day;

          RegistroTarifa? tariffNow = Utility.revisedTariffDay(
              DateTime(dateTariffer.year, month.month, text), list);

          return InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (list.isEmpty &&
                    DateTime(month.year, month.month, text)
                        .isSameDate(DateTime.now()))
                  Expanded(
                    child: Card(
                      elevation: 3.5,
                      color: Colors.amber,
                      child: Center(
                        child: Text(
                          text.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                else if (tariffNow != null && tariffNow.isSelected!)
                  Expanded(
                    child: DayInfoItemRow(
                      key: UniqueKey(),
                      tarifa: tariffNow,
                      yearNow: dateTariffer.year,
                      day: text,
                      month: month,
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
            color: Colors.white,
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
