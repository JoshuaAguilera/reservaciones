import 'package:flutter/material.dart';

import '../../ui/buttons.dart';
import '../../widgets/text_styles.dart';

class HabitacionForm extends StatefulWidget {
  const HabitacionForm({super.key, required this.cancelarFunction});

  final void Function()? cancelarFunction;

  @override
  State<HabitacionForm> createState() => _HabitacionFormState();
}

class _HabitacionFormState extends State<HabitacionForm> {
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
                  text: "Nueva Habitación",
                  color: Theme.of(context).dividerColor,
                )),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 200,
                height: 40,
                child: Buttons.commonButton(
                    onPressed: () {
                      widget.cancelarFunction!.call();
                    },
                    text: "Cancelar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
