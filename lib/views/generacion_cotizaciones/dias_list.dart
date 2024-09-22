import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/item_row.dart';
import 'package:generador_formato/widgets/text_styles.dart';

import '../../widgets/dialogs.dart';

class DiasList extends StatefulWidget {
  const DiasList({
    super.key,
    required this.initDay,
    required this.lastDay,
    this.isCalendary = false,
    this.isTable = false,
    this.isCheckList = false,
  });

  final String initDay;
  final String lastDay;
  final bool isCalendary;
  final bool isTable;
  final bool isCheckList;

  @override
  State<DiasList> createState() => _DiasListState();
}

class _DiasListState extends State<DiasList> {
  int daysMonth = 0;
  int daysMonthAfter = 0;
  int daysMonthLater = 0;
  int dayWeekInit = 0;
  int dayCheckIn = 1;
  int dayCheckOut = 2;
  int numDays = 0;

  //prepare V3
  int extraDays = 0;
  DateTime checkIn = DateTime.now();
  DateTime checkOut = DateTime.now();

  @override
  void initState() {
    getInfoDates();
    respDataDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    double screenWidth = MediaQuery.of(context).size.width;

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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                                  ink < (numDays + extraDays + daysMonth);
                                  ink++)
                                if ((checkIn.day < checkOut.day) &&
                                    ink >
                                        (checkIn.day -
                                            checkIn.weekday -
                                            (7 - dayWeekInit + 2)) &&
                                    ink <
                                        (checkOut.day +
                                            (7 - checkOut.weekday) +
                                            ((checkIn.day >= 1 &&
                                                    checkIn.day <=
                                                        (7 - dayWeekInit + 1))
                                                ? (9 + (dayWeekInit - 3)) + 7
                                                : (9 + (dayWeekInit - 3)))))
                                  ItemRow.dayRateRow(
                                    context: context,
                                    day: (checkIn.day >= 1 &&
                                            checkIn.day <=
                                                (7 - dayWeekInit + 1))
                                        ? ink - 7
                                        : ink,
                                    initDay: dayWeekInit,
                                    lastDay: daysMonth,
                                    dayCheckIn: dayCheckIn,
                                    dayCheckOut: dayCheckOut,
                                    daysMonthAfter: daysMonthAfter,
                                    numMonthInit: checkIn.month,
                                  )
                                else if ((checkIn.day > checkOut.day) &&
                                    ink > (checkIn.day - checkIn.weekday - 5) &&
                                    ink <
                                        ((checkOut.day + daysMonth) +
                                            (7 - checkOut.weekday) +
                                            10))
                                  ItemRow.dayRateRow(
                                    context: context,
                                    day: ink,
                                    initDay: dayWeekInit,
                                    lastDay: daysMonth,
                                    dayCheckIn: dayCheckIn,
                                    dayCheckOut: dayCheckOut,
                                    daysMonthAfter: daysMonthAfter,
                                    dayWeekLater: 7 - checkOut.weekday,
                                    dayMonthLater: daysMonthLater,
                                    numMonthInit: checkIn.month,
                                  )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: Container(
                            height: (MediaQuery.of(context).size.width > 1080)
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
                            height: (MediaQuery.of(context).size.width > 1080)
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
              padding: const EdgeInsets.only(top: 15),
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
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
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
                                text: "Tarifa de Pax Adicional",
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
                    height: Utility.limitHeightList(numDays, 20, 450),
                    child: SingleChildScrollView(
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder(
                          horizontalInside:
                              BorderSide(color: Theme.of(context).dividerColor),
                        ),
                        children: [
                          for (var i = 0; i < numDays + 1; i++)
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 11.0),
                                  child: Center(
                                    child: TextStyles.standardText(
                                        text: DateTime.parse(widget.initDay)
                                            .add(Duration(days: i))
                                            .toIso8601String()
                                            .substring(0, 10),
                                        color: Theme.of(context).primaryColor,
                                        size: 14),
                                  ),
                                ),
                                Center(
                                  child: TextStyles.standardText(
                                      text: Utility.formatterNumber(0),
                                      color: Theme.of(context).primaryColor,
                                      size: 14),
                                ),
                                Center(
                                  child: TextStyles.standardText(
                                      text: Utility.formatterNumber(0),
                                      color: Theme.of(context).primaryColor,
                                      size: 14),
                                ),
                                Center(
                                  child: TextStyles.standardText(
                                      text: Utility.formatterNumber(0),
                                      color: Theme.of(context).primaryColor,
                                      size: 14),
                                ),
                                Center(
                                  child: TextStyles.standardText(
                                      text: Utility.formatterNumber(0),
                                      color: Theme.of(context).primaryColor,
                                      size: 14),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (screenWidth > 1400)
                                      Buttons.commonButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  Dialogs.taridaAlertDialog(
                                                context: context,
                                                title:
                                                    "Modificar de tarifas ${DateTime.parse(widget.initDay).add(Duration(days: i)).day} / ${monthNames[DateTime.parse(widget.initDay).add(Duration(days: i)).month - 1]}",
                                                iconData: CupertinoIcons
                                                    .pencil_circle,
                                                iconColor:
                                                    DesktopColors.cerulean,
                                                nameButtonMain: "ACEPTAR",
                                                funtionMain: () {},
                                                nameButtonCancel: "CANCELAR",
                                                withButtonCancel: true,
                                              ),
                                            );
                                          },
                                          text: "Editar")
                                    else
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                Dialogs.taridaAlertDialog(
                                              context: context,
                                              title:
                                                  "Modificar de tarifas ${DateTime.parse(widget.initDay).add(Duration(days: i)).day} / ${monthNames[DateTime.parse(widget.initDay).add(Duration(days: i)).month - 1]}",
                                              iconData:
                                                  CupertinoIcons.pencil_circle,
                                              iconColor: DesktopColors.cerulean,
                                              nameButtonMain: "ACEPTAR",
                                              funtionMain: () {},
                                              nameButtonCancel: "CANCELAR",
                                              withButtonCancel: true,
                                            ),
                                          );
                                        },
                                        tooltip: "Editar",
                                        icon: Icon(
                                          CupertinoIcons.pencil,
                                          size: 30,
                                          color: DesktopColors.cerulean,
                                        ),
                                      ),
                                  ],
                                )
                              ],
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
              height: Utility.limitHeightList(numDays, 20, 400),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: numDays + 1,
                itemBuilder: (context, index) {
                  return ItemRow.itemTarifaDia(context,
                      day: index, initDate: checkIn, isDetail: false);
                },
              ),
            ).animate().shimmer(delay: 500.ms).fadeIn(),
        ],
      ),
    );
  }

  Future respDataDate() async {
    daysMonth = Utility.getDaysInMonth(checkIn.year, checkIn.month);
    daysMonthAfter = Utility.getDaysInMonth(checkIn.year, checkIn.month - 1);
    daysMonthLater = Utility.getDaysInMonth(checkIn.year, checkIn.month + 1);
    dayWeekInit = DateTime(checkIn.year, checkIn.month, 1).weekday;

    extraDays += 7 - (checkIn.weekday);
    extraDays += 7 - (checkOut.weekday - 1);
    extraDays += 14;
  }

  Future getInfoDates() async {
    checkIn = DateTime.parse(widget.initDay);
    checkOut = DateTime.parse(widget.lastDay);
    dayCheckIn = checkIn.day;
    dayCheckOut = checkOut.day;
    numDays = checkOut.difference(checkIn).inDays;
  }
}
