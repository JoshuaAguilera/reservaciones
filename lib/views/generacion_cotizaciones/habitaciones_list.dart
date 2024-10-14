import 'package:flutter/material.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../ui/buttons.dart';
import '../../ui/custom_widgets.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/habitacion_item_row.dart';
import '../../widgets/text_styles.dart';

class HabitacionesList extends StatefulWidget {
  const HabitacionesList(
      {super.key,
      required this.newRoom,
      required this.editRoom,
      required this.sideController,
      required this.habitaciones});

  final void Function()? newRoom;
  final void Function(Habitacion)? editRoom;
  final SidebarXController sideController;
  final List<Habitacion> habitaciones;

  @override
  State<HabitacionesList> createState() => _HabitacionesListState();
}

class _HabitacionesListState extends State<HabitacionesList> {
  List<String> tableTitles = [
    "#",
    "Fechas de estancia",
    "Adultos",
    "Menores 0-6",
    "Menores 7-12",
    "Tarifa Real",
    "Tarifa Total",
    "Opciones",
  ];

  bool viewTable = true;

  List<Widget> modesVisualRange = <Widget>[
    const Icon(Icons.table_chart),
    const Icon(Icons.dehaze_sharp),
  ];

  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                  width: 200,
                  height: 40,
                  child: Buttons.commonButton(
                    text: "Agregar habitación",
                    onPressed: () {
                      widget.newRoom!.call();
                    },
                  ),
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
                  columnWidths: const {
                    0: FractionColumnWidth(.05),
                    1: FractionColumnWidth(.2),
                    2: FractionColumnWidth(.1),
                    3: FractionColumnWidth(.1),
                    5: FractionColumnWidth(.1),
                    6: FractionColumnWidth(.1),
                    7: FractionColumnWidth(.2),
                  },
                  children: [
                    TableRow(
                      children: [
                        for (var item in tableTitles)
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
                height: Utility.limitHeightList(widget.habitaciones.length),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.habitaciones.length,
                  itemBuilder: (context, index) {
                    if (index < widget.habitaciones.length) {
                      return HabitacionItemRow(
                        key: ObjectKey(widget.habitaciones[index].hashCode),
                        index: index,
                        habitacion: widget.habitaciones[index],
                        isTable: viewTable,
                        onPressedDelete: () => setState(() => widget
                            .habitaciones
                            .remove(widget.habitaciones[index])),
                        onPressedEdit: () =>
                            widget.editRoom!.call(widget.habitaciones[index]),
                      );
                    }
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
