import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/widgets/dynamic_widget.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../providers/tarifario_provider.dart';
import '../../ui/custom_widgets.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/item_rows.dart';
import '../../widgets/period_item_row.dart';

class TarifarioCalendaryWeekView extends ConsumerStatefulWidget {
  const TarifarioCalendaryWeekView({
    super.key,
    required this.sideController,
    required this.initDayWeek,
    required this.initDayWeekGraphics,
    required this.changeDate,
  });

  final SidebarXController sideController;
  final DateTime initDayWeek;
  final DateTime initDayWeekGraphics;
  final bool changeDate;

  @override
  _TarifarioCalendaryWeekViewState createState() =>
      _TarifarioCalendaryWeekViewState();
}

class _TarifarioCalendaryWeekViewState
    extends ConsumerState<TarifarioCalendaryWeekView> {
  bool alreadyLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final listTarifasProvider = ref.watch(listTarifaProvider(""));
    final tarifaProvider = ref.watch(allTarifaProvider(""));
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    if (!alreadyLoading) {
      Future.delayed(2.seconds, () {
        if (mounted) {
          setState(() => alreadyLoading = true);
        }
      });
    }

    return SizedBox(
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
                        (widget.sideController.extended ? 230 : 118))
                    : (screenWidth > 800)
                        ? screenWidth -
                            (widget.sideController.extended ? 230 : 118)
                        : screenWidth - 28,
                child: Table(
                  border: TableBorder(
                    verticalInside:
                        BorderSide(color: Theme.of(context).dividerColor),
                    left: BorderSide(color: Theme.of(context).dividerColor),
                    right: BorderSide(color: Theme.of(context).dividerColor),
                  ),
                  children: [
                    TableRow(
                      children: [
                        for (var i = widget.initDayWeek.day;
                            i < (widget.initDayWeek.day + 7);
                            i++)
                          SizedBox(
                            height: screenHeight - 270,
                            child: const Text(""),
                          ),
                      ],
                    ),
                  ],
                ).animate().fadeIn(duration: 1800.ms, begin: -.6),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: (screenWidth > 1280) ? (380) : 0),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 7,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, childAspectRatio: 0.5),
              itemBuilder: (context, index) {
                return ItemRows.getTitleDay(
                  title:
                      widget.initDayWeekGraphics.add(Duration(days: index)).day,
                  subTitle: daysNameShort[widget.initDayWeekGraphics
                          .add(Duration(days: index))
                          .weekday -
                      1],
                  select: !widget.changeDate
                      ? widget.initDayWeekGraphics
                                  .add(Duration(days: index))
                                  .weekday -
                              1 ==
                          (DateTime.now().weekday - 1)
                      : DateTime(DateTime.now().year, DateTime.now().month,
                                  DateTime.now().day)
                              .compareTo(widget.initDayWeekGraphics
                                  .add(Duration(days: index))) ==
                          0,
                  index: index,
                  brightness: brightness,
                );
              },
            ),
          ),
          Positioned(
            left: (screenWidth > 1280) ? (385) : 0,
            top: 110,
            child: SizedBox(
              height: screenHeight - 260,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tarifaProvider.when(
                      data: (list) {
                        if (list.isNotEmpty) {
                          return listTarifasProvider.when(
                            data: (list) {
                              if (list.isNotEmpty) {
                                return SizedBox(
                                  height: screenHeight - 260,
                                  width: (screenWidth > 1280)
                                      ? (screenWidth -
                                          378 -
                                          (widget.sideController.extended
                                              ? 230
                                              : 118))
                                      : (screenWidth > 800)
                                          ? screenWidth -
                                              (widget.sideController.extended
                                                  ? 230
                                                  : 118)
                                          : screenWidth - 28,
                                  child: ListView.builder(
                                    itemCount: list.length,
                                    padding: const EdgeInsets.only(bottom: 10),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      if (Utility.showTariffByWeek(
                                              list[index].periodos,
                                              widget.initDayWeekGraphics) &&
                                          list[index].isSelected!) {
                                        return PeriodItemRow(
                                          isntWeek: false,
                                          weekNow: widget.initDayWeekGraphics,
                                          tarifa: list[index],
                                          lenghtDays: 1,
                                          lenghtSideBar:
                                              (widget.sideController.extended
                                                  ? 230
                                                  : 118),
                                          alreadyLoading: alreadyLoading,
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
                            error: (error, stackTrace) => const SizedBox(),
                            loading: () => const SizedBox(),
                          );
                        }
                        return const SizedBox(height: 150);
                      },
                      error: (error, stackTrace) => SizedBox(
                          height: 150,
                          child: CustomWidgets.messageNotResult(
                              context: context,
                              sizeImage: 100,
                              screenWidth: screenWidth,
                              extended: widget.sideController.extended)),
                      loading: () => dynamicWidget.loadingWidget(screenWidth,
                          screenHeight, widget.sideController.extended),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
