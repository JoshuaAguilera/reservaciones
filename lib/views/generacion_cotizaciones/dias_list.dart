import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/habitacion_provider.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/check_listtile_tariff_widget.dart';
import 'package:generador_formato/widgets/item_rows.dart';
import 'package:generador_formato/widgets/table_rows.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../ui/progress_indicator.dart';

class DiasList extends ConsumerStatefulWidget {
  const DiasList({
    super.key,
    required this.initDay,
    required this.lastDay,
    this.isCalendary = false,
    this.isTable = false,
    this.isCheckList = false,
    required this.sideController,
  });

  final String initDay;
  final String lastDay;
  final bool isCalendary;
  final bool isTable;
  final bool isCheckList;
  final SidebarXController sideController;

  @override
  _DiasListState createState() => _DiasListState();
}

class _DiasListState extends ConsumerState<DiasList> {
  //prepare V4
  DateTime checkIn = DateTime.now();
  DateTime checkOut = DateTime.now();
  DateTime checkInLimit = DateTime.now();
  DateTime checkOutLimit = DateTime.now();

  @override
  void initState() {
    getDateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    double screenWidth = MediaQuery.of(context).size.width;
    final habitacionProvider = ref.watch(habitacionSelectProvider);
    final listTariffProvider = ref.watch(listTariffDayProvider);
    final typeQuote = ref.watch(typeQuoteProvider);
    final useCashSeason = ref.watch(useCashSeasonProvider);

    return SingleChildScrollView(
      child: listTariffProvider.when(
        data: (list) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: TextStyles.titleText(
                  text:
                      Utility.defineMonthPeriod(widget.initDay, widget.lastDay),
                  color: Theme.of(context).dividerColor,
                  size: 21),
            ),
            if (widget.isCalendary &&
                Utility.revisedLimitDateTime(checkIn, checkOut) &&
                defineUseScreenWidth(screenWidth))
              Card(
                elevation: 7,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 25, horizontal: screenWidth * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth < 1100 ? double.infinity : 1100,
                        height: 50,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 7,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7, childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            return ItemRows.getTitleDay(
                              title: 0,
                              withOutDay: true,
                              subTitle: daysNameShort[index],
                              select: false,
                              index: index,
                              brightness: brightness,
                            );
                          },
                        ),
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            width: screenWidth < 1100 ? double.infinity : 1100,
                            child: GridView.count(
                              crossAxisCount: 7,
                              shrinkWrap: true,
                              childAspectRatio: 0.9,
                              children: [
                                for (var ink = 0;
                                    ink <
                                        checkIn.difference(checkInLimit).inDays;
                                    ink++)
                                  ItemRows.dayRateRow(
                                    context: context,
                                    day: checkInLimit
                                        .add(Duration(days: ink))
                                        .day,
                                    inPeriod: false,
                                    dateNow:
                                        checkInLimit.add(Duration(days: ink)),
                                    sideController: widget.sideController,
                                  ),
                                for (var element in list)
                                  ItemRows.dayRateRow(
                                    context: context,
                                    inPeriod: true,
                                    sideController: widget.sideController,
                                    tarifaXDia: element,
                                  ),
                                for (var ink = -1;
                                    ink <
                                        checkOutLimit
                                                .difference(checkOut)
                                                .inDays -
                                            1;
                                    ink++)
                                  ItemRows.dayRateRow(
                                    context: context,
                                    day: checkOut
                                        .add(Duration(days: ink + 1))
                                        .day,
                                    inPeriod: false,
                                    dateNow:
                                        checkOut.add(Duration(days: ink + 1)),
                                    sideController: widget.sideController,
                                  ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            child: Container(
                              height: (MediaQuery.of(context).size.width > 1280)
                                  ? 135
                                  : 80,
                              width: 7800,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                    Theme.of(context).cardColor,
                                    if (brightness == Brightness.dark)
                                      const Color.fromARGB(0, 68, 68, 68),
                                    if (brightness == Brightness.light)
                                      const Color.fromARGB(0, 255, 255, 255)
                                  ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: (MediaQuery.of(context).size.width > 1280)
                                  ? 135
                                  : 80,
                              width: 7800,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).cardColor,
                                      if (brightness == Brightness.dark)
                                        const Color.fromARGB(0, 68, 68, 68),
                                      if (brightness == Brightness.light)
                                        const Color.fromARGB(0, 255, 255, 255)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                      .animate()
                      .slideY(begin: 2, duration: 500.ms)
                      .fadeIn(delay: 400.ms),
                ),
              ),
            if (widget.isTable)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border: TableBorder(
                        verticalInside: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                          width: 2,
                        ),
                      ),
                      children: [
                        TableRow(
                          children: [
                            for (var element in [
                              "Fecha",
                              "Tarifa Adultos",
                              ((screenWidth > 1400)
                                  ? "Tarifa Menores de 7 a 12 años"
                                  : "Men. 7 a 12"),
                              if (screenWidth > 1400)
                                "Tarifa Menores de 0 a 6 años",
                              if (screenWidth > 1000) "Tarifa Diaria",
                              "Opciones",
                            ])
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Center(
                                  child: TextStyles.standardText(
                                    text: element,
                                    isBold: true,
                                    color: Theme.of(context).primaryColor,
                                    size: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    Divider(color: Theme.of(context).primaryColorLight),
                    SizedBox(
                      height: Utility.limitHeightList(
                          checkOut.difference(checkIn).inDays, 9, 392),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, ink) {
                          return TableRows.tableRowTarifaDay(
                            context,
                            habitacion: habitacionProvider,
                            screenWidth: screenWidth,
                            tarifaXDia: list[ink],
                            setState: () => setState(() {}),
                            isGroupTariff: typeQuote,
                            useCashSeason: useCashSeason,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 700.ms),
            if (widget.isCheckList)
              SizedBox(
                height: Utility.limitHeightList(
                    checkOut.difference(checkIn).inDays, 4, 472),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, ink) {
                      return CheckListtileTariffWidget(
                        habitacion: habitacionProvider,
                        tarifaXDia: list[ink],
                        isGroupTariff: typeQuote,
                        useSeasonCash: useCashSeason,
                      );
                    },
                  ),
                ),
              ).animate().shimmer(delay: 500.ms).fadeIn(),
          ],
        ),
        error: (error, stackTrace) =>
            TextStyles.standardText(text: "Error de calculación de tarifas"),
        loading: () => SizedBox(
          height: 350,
          child: ProgressIndicatorCustom(screenHight: 0),
        ),
      ),
    );
  }

  void getDateData() {
    checkIn = DateTime.parse(widget.initDay);
    checkOut = DateTime.parse(widget.lastDay);

    int daysRestInit = checkIn.weekday;
    checkInLimit = checkIn.subtract(Duration(days: 6 + daysRestInit));

    int daysRestLast = 7 - (checkOut.subtract(const Duration(days: 1)).weekday);
    checkOutLimit = checkOut.add(Duration(days: 7 + daysRestLast));
  }

  bool defineUseScreenWidth(double screenWidth) {
    bool enable = false;
    if (widget.sideController.extended) {
      enable = screenWidth > 1115;
    } else {
      enable = screenWidth > 950;
    }

    return enable;
  }
}
