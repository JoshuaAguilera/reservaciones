import 'package:flutter/material.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';

import '../widgets/text_styles.dart';

class GestionUsuariosView extends StatefulWidget {
  const GestionUsuariosView({super.key});

  @override
  State<GestionUsuariosView> createState() => _GestionUsuariosViewState();
}

const List<Widget> fruits = <Widget>[
  Icon(Icons.table_chart),
  Icon(Icons.dehaze_sharp),
];

class _GestionUsuariosViewState extends State<GestionUsuariosView> {
  final List<bool> _selectedFruits = <bool>[true, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStyles.titlePagText(
                          text: "Gestión de usuarios",
                          color: Theme.of(context).primaryColor,
                        ),
                        TextStyles.standardText(
                          text:
                              "Crea, edita, supervisa y elimina los usuarios activos del sistema.",
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                  Buttons.commonButton(
                    onPressed: () {},
                    text: "Agregar usuario",
                    color: DesktopColors.turquezaOscure,
                  )
                ],
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedFruits.length; i++) {
                        _selectedFruits[i] = i == index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: DesktopColors.cerulean,
                  selectedColor: DesktopColors.ceruleanOscure,
                  // fillColor: Colors.red[200],
                  color: Theme.of(context).primaryColor,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: _selectedFruits,
                  children: fruits,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
