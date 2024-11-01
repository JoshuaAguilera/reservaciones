import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../ui/buttons.dart';
import '../../ui/custom_widgets.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/habitacion_item_row.dart';
import '../../widgets/text_styles.dart';

class HabitacionesList extends StatefulWidget {
  const HabitacionesList({
    super.key,
    required this.newRoom,
    required this.editRoom,
    required this.duplicateRoom,
    required this.sideController,
    required this.habitaciones,
    required this.deleteRoom,
  });

  final void Function()? newRoom;
  final void Function(Habitacion)? editRoom;
  final void Function(Habitacion)? duplicateRoom;
  final void Function(String)? deleteRoom;
  final SidebarXController sideController;
  final List<Habitacion> habitaciones;

  @override
  State<HabitacionesList> createState() => _HabitacionesListState();
}

class _HabitacionesListState extends State<HabitacionesList> {
  bool viewTable = true;

  List<Widget> modesVisualRange = <Widget>[
    const Icon(Icons.table_chart),
    const Icon(Icons.dehaze_sharp),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenWidthWithSideBar = screenWidth +
        (screenWidth > 800 ? (widget.sideController.extended ? 50 : 180) : 300);

    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: TextStyles.titleText(
                  text: "Habitaciones",
                  color: Theme.of(context).dividerColor,
                )),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomWidgets.sectionButton(
                  listModes: [viewTable, !viewTable],
                  modesVisual: modesVisualRange,
                  onChanged: (p0, p1) => setState(() => viewTable = p0 != p1),
                ),
                if ((screenWidth + (!widget.sideController.extended ? 60 : 0)) >
                    975)
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: Buttons.commonButton(
                      text: "Agregar habitación",
                      color: DesktopColors.prussianWhiteBlue,
                      onPressed: () {
                        widget.newRoom!.call();
                      },
                    ),
                  )
                else
                  Buttons.iconButtonCard(
                    icon: CupertinoIcons.add,
                    onPressed: () {},
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (!Utility.isResizable(
                    extended: widget.sideController.extended,
                    context: context) &&
                viewTable)
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Table(
                  border: TableBorder(
                    verticalInside: BorderSide(
                      color: Theme.of(context).primaryColorLight,
                      width: 2,
                    ),
                  ),
                  columnWidths: {
                    0: const FractionColumnWidth(0.1),
                    if (screenWidthWithSideBar < 1250 &&
                        screenWidthWithSideBar > 950)
                      1: const FractionColumnWidth(0.35),
                    if (screenWidthWithSideBar < 1550 &&
                        screenWidthWithSideBar > 1250)
                      2: const FractionColumnWidth(0.1),
                    if (screenWidthWithSideBar < 1550 &&
                        screenWidthWithSideBar > 1350)
                      3: const FractionColumnWidth(0.1),
                    if (screenWidthWithSideBar < 1550 &&
                        screenWidthWithSideBar > 1450)
                      4: const FractionColumnWidth(0.1),
                  },
                  children: [
                    TableRow(
                      children: [
                        for (var item in [
                          "#",
                          if (screenWidthWithSideBar > 950)
                            "Fechas de estancia",
                          if (screenWidthWithSideBar > 1250) "Adultos",
                          if (screenWidthWithSideBar > 1450) "Menores 0-6",
                          if (screenWidthWithSideBar > 1350) "Menores 7-12",
                          if (screenWidthWithSideBar > 1700) "Tarifa Real",
                          if (screenWidthWithSideBar > 1550) "Tarifa Total",
                          "Opciones",
                        ])
                          TextStyles.standardText(
                            text: item,
                            aling: TextAlign.center,
                            color: Theme.of(context).primaryColor,
                            overClip: true,
                            size: 11.5,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            Divider(color: Theme.of(context).primaryColorLight, thickness: 1.8),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: Utility.limitHeightList(
                    widget.habitaciones.length, viewTable ? 9 : 5, 530),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.habitaciones.length,
                  itemBuilder: (_, index) {
                    return HabitacionItemRow(
                      key: ObjectKey(widget.habitaciones[index].hashCode),
                      sideController: widget.sideController,
                      index: index,
                      habitacion: widget.habitaciones[index],
                      isTable: viewTable,
                      onPressedDelete: () {
                        widget.deleteRoom!
                            .call(widget.habitaciones[index].folioHabitacion!);
                      },
                      onPressedEdit: () =>
                          widget.editRoom!.call(widget.habitaciones[index]),
                      onPressedDuplicate: () => widget.duplicateRoom!
                          .call(widget.habitaciones[index]),
                    );
                  },
                ),
              ),
            ),
            if (widget.habitaciones.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: CustomWidgets.messageNotResult(
                  context: context,
                  sizeImage: 90,
                  message: "Sin habitaciones asignadas",
                ),
              ),
          ],
        ),
      ),
    );
  }
}
