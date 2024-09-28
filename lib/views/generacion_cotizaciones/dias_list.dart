import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
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
    required this.tarifas,
  });

  final String initDay;
  final String lastDay;
  final bool isCalendary;
  final bool isTable;
  final bool isCheckList;
  final List<RegistroTarifa> tarifas;

  @override
  State<DiasList> createState() => _DiasListState();
}

class _DiasListState extends State<DiasList> {
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
                                  numMonthInit: checkIn.month,
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
                                  numMonthInit: checkIn.month,
                                  inPeriod: true,
                                  dateNow: checkIn.add(Duration(days: ink)),
                                  tarifas: widget.tarifas,
                                ),
                              for (var ink = 0;
                                  ink <
                                      checkOutLimit.difference(checkOut).inDays;
                                  ink++)
                                ItemRow.dayRateRow(
                                  context: context,
                                  day:
                                      checkOut.add(Duration(days: ink + 1)).day,
                                  numMonthInit: checkIn.month,
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
              padding: const EdgeInsets.only(top: 10),
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
                    height: Utility.limitHeightList(numDays, 20, 370),
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
              height: Utility.limitHeightList(numDays, 20, 440),
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numDays + 1,
                  itemBuilder: (context, index) {
                    return ItemRow.itemTarifaDia(context,
                        day: index, initDate: checkIn, isDetail: false);
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
