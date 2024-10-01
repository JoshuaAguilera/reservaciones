import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/providers/habitacion_provider.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/item_row.dart';
import 'package:generador_formato/widgets/text_styles.dart';

class DiasList extends ConsumerStatefulWidget {
  const DiasList({
    super.key,
    required this.initDay,
    required this.lastDay,
    this.isCalendary = false,
    this.isTable = false,
    this.isCheckList = false,
    required this.tarifas,
  });

  final String initDay;
  final String lastDay;
  final bool isCalendary;
  final bool isTable;
  final bool isCheckList;
  final List<RegistroTarifa> tarifas;

  @override
  _DiasListState createState() => _DiasListState();
}

class _DiasListState extends ConsumerState<DiasList> {
  int numDays = 0;

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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TextStyles.titleText(
                text: Utility.defineMonthPeriod(widget.initDay, widget.lastDay),
                color: Theme.of(context).dividerColor,
                size: 21),
          ),
          if (widget.isCalendary &&
              Utility.revisedLimitDateTime(checkIn, checkOut))
            Card(
              elevation: 7,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth < 1100 ? double.infinity : 1100,
                      height: 50,
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
                                  ink < checkIn.difference(checkInLimit).inDays;
                                  ink++)
                                ItemRow.dayRateRow(
                                  context: context,
                                  day:
                                      checkInLimit.add(Duration(days: ink)).day,
                                  inPeriod: false,
                                  dateNow:
                                      checkInLimit.add(Duration(days: ink)),
                                ),
                              for (var ink = 0;
                                  ink < checkOut.difference(checkIn).inDays + 1;
                                  ink++)
                                ItemRow.dayRateRow(
                                  context: context,
                                  day: checkIn.add(Duration(days: ink)).day,
                                  inPeriod: true,
                                  dateNow: checkIn.add(Duration(days: ink)),
                                  tarifas: widget.tarifas,
                                  totalDays:
                                      checkOut.difference(checkIn).inDays,
                                  isLastDay: ink ==
                                      checkOut.difference(checkIn).inDays,
                                ),
                              for (var ink = 0;
                                  ink <
                                      checkOutLimit.difference(checkOut).inDays;
                                  ink++)
                                ItemRow.dayRateRow(
                                  context: context,
                                  day:
                                      checkOut.add(Duration(days: ink + 1)).day,
                                  inPeriod: false,
                                  dateNow:
                                      checkOut.add(Duration(days: ink + 1)),
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
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder(
                      verticalInside: BorderSide(
                        color: Theme.of(context).primaryColorLight,
                        width: 2,
                      ),
                    ),
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Center(
                              child: TextStyles.standardText(
                                  text: "Fecha",
                                  isBold: true,
                                  color: Theme.of(context).primaryColor,
                                  size: 14),
                            ),
                          ),
                          Center(
                            child: TextStyles.standardText(
                                text: "Tarifa Adultos",
                                isBold: true,
                                color: Theme.of(context).primaryColor,
                                size: 14),
                          ),
                          Center(
                            child: TextStyles.standardText(
                                text: "Tarifa Menores de 7 a 12 años",
                                isBold: true,
                                color: Theme.of(context).primaryColor,
                                size: 14),
                          ),
                          Center(
                            child: TextStyles.standardText(
                                text: "Tarifa Menores de 0 a 6 años",
                                isBold: true,
                                color: Theme.of(context).primaryColor,
                                size: 14),
                          ),
                          Center(
                            child: TextStyles.standardText(
                                text: "Tarifa Total",
                                isBold: true,
                                color: Theme.of(context).primaryColor,
                                size: 14),
                          ),
                          Center(
                            child: TextStyles.standardText(
                                text: "Opciones",
                                isBold: true,
                                color: Theme.of(context).primaryColor,
                                size: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(color: Theme.of(context).primaryColorLight),
                  SizedBox(
                    height: Utility.limitHeightList(checkOut.difference(checkIn).inDays, 8, 345),
                    child: SingleChildScrollView(
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder(
                          horizontalInside:
                              BorderSide(color: Theme.of(context).dividerColor),
                        ),
                        children: [
                          for (var ink = 0;
                              ink < checkOut.difference(checkIn).inDays + 1;
                              ink++)
                            ItemRow.tableRowTarifaDay(
                              context,
                              checkIn: checkIn,
                              ink: ink,
                              checkOut: checkOut,
                              tarifas: widget.tarifas,
                              habitacion: habitacionProvider,
                              screenWidth: screenWidth,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 700.ms),
          if (widget.isCheckList)
            SizedBox(
              height: Utility.limitHeightList(
                checkOut.difference(checkIn).inDays,
                4,
                380,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: checkOut.difference(checkIn).inDays + 1,
                  itemBuilder: (context, ink) {
                    RegistroTarifa? nowTariff = Utility.revisedTariffDay(
                        checkIn.add(Duration(days: ink)), widget.tarifas);

                    int totalDays = checkOut.difference(checkIn).inDays;

                    return ItemRow.itemTarifaDia(
                      context,
                      day: ink,
                      initDate: checkIn,
                      isDetail: (totalDays == ink),
                      color: nowTariff?.color,
                      tarifaAdulto: (totalDays == ink)
                          ? 0
                          : Utility.calculateTariffAdult(
                              nowTariff,
                              habitacionProvider,
                              totalDays,
                            ),
                      tarifaMenores7a12: (totalDays == ink)
                          ? 0
                          : Utility.calculateTariffChildren(
                              nowTariff,
                              habitacionProvider,
                              totalDays,
                            ),
                      tarifaMenores0a6: 0,
                      temporada:
                          Utility.getSeasonNow(nowTariff!, totalDays)?.nombre ??
                              'No definido',
                      periodo: nowTariff == null
                          ? "No definido"
                          : Utility.definePeriodNow(
                              checkIn.add(Duration(days: ink)),
                              nowTariff.periodos,
                              compact: true),
                    );
                  },
                ),
              ),
            ).animate().shimmer(delay: 500.ms).fadeIn(),
        ],
      ),
    );
  }

  void getDateData() {
    checkIn = DateTime.parse(widget.initDay);
    checkOut = DateTime.parse(widget.lastDay);

    int daysRestInit = checkIn.weekday;
    checkInLimit = checkIn.subtract(Duration(days: 6 + daysRestInit));

    int daysRestLast = 7 - checkOut.weekday;
    checkOutLimit = checkOut.add(Duration(days: 7 + daysRestLast));
  }
}
