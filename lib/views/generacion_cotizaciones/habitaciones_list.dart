import 'package:flutter/material.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../ui/buttons.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/habitacion_item_row.dart';
import '../../widgets/text_styles.dart';

class HabitacionesList extends StatefulWidget {
  const HabitacionesList(
      {super.key,
      required this.nuevaHabitacion,
      required this.sideController,
      required this.esGrupo,
      required this.habitaciones});

  final void Function()? nuevaHabitacion;
  final SidebarXController sideController;
  final bool esGrupo;
  final List<Habitacion> habitaciones;

  @override
  State<HabitacionesList> createState() => _HabitacionesListState();
}

class _HabitacionesListState extends State<HabitacionesList> {
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
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                  width: 200,
                  height: 40,
                  child: Buttons.commonButton(
                    text: "Agregar habitación",
                    onPressed: () {
                      widget.nuevaHabitacion!.call();
                    },
                  )),
            ),
            const SizedBox(height: 12),
            if (!Utility.isResizable(
                extended: widget.sideController.extended, context: context))
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(!widget.esGrupo ? .05 : .2),
                    1: FractionColumnWidth(!widget.esGrupo ? .15 : 0.22),
                    2: const FractionColumnWidth(.1),
                    3: FractionColumnWidth(!widget.esGrupo ? .1 : 0.22),
                    4: const FractionColumnWidth(.1),
                    5: FractionColumnWidth(!widget.esGrupo ? .1 : 0.15),
                    6: FractionColumnWidth(!widget.esGrupo ? .21 : .15),
                  },
                  children: [
                    TableRow(
                      children: [
                        if (!widget.esGrupo)
                          TextStyles.standardText(
                              text: "#",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor,
                              overClip: true),
                        TextStyles.standardText(
                            text: "Fechas de estancia",
                            aling: TextAlign.center,
                            color: Theme.of(context).primaryColor,
                            overClip: true),
                        if (!widget.esGrupo)
                          TextStyles.standardText(
                              text: "Adultos",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor,
                              overClip: true),
                        if (!widget.esGrupo)
                          TextStyles.standardText(
                              text: "Menores 0-6",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor,
                              overClip: true),
                        TextStyles.standardText(
                            text: (!widget.esGrupo)
                                ? "Menores 7-12"
                                : "1 o 2 Adultos",
                            aling: TextAlign.center,
                            color: Theme.of(context).primaryColor,
                            overClip: true),
                        TextStyles.standardText(
                            text: (!widget.esGrupo)
                                ? "Tarifa \nReal"
                                : "3 Adultos",
                            aling: TextAlign.center,
                            color: Theme.of(context).primaryColor,
                            overClip: true),
                        if (widget.esGrupo)
                          TextStyles.standardText(
                              text: "  4 Adultos  ",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor,
                              overClip: true),
                        if (widget.esGrupo)
                          TextStyles.standardText(
                              text: "Menores 7 a 12 Años",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor,
                              overClip: true),
                        if (!widget.esGrupo)
                          TextStyles.standardText(
                              text:
                                  "Tarifa de preventa oferta por tiempo limitado",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor,
                              overClip: true),
                        TextStyles.standardText(
                            text: "Opciones",
                            color: Theme.of(context).primaryColor,
                            aling: TextAlign.center)
                      ],
                    ),
                  ],
                ),
              ),
            const Divider(color: Colors.black54),
            if (!widget.esGrupo)
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
                          compact: !Utility.isResizable(
                              extended: widget.sideController.extended,
                              context: context),
                          onPressedDelete: () => setState(() => widget
                              .habitaciones
                              .remove(widget.habitaciones[index])),
                          onPressedEdit: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialogs().habitacionDialog(
                                    buildContext: context,
                                    cotizacion: widget.habitaciones[index]);
                              },
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  widget.habitaciones[index] = value;
                                });
                              }
                            });
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
