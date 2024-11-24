import 'package:flutter/material.dart';

import 'textformfield_custom.dart';

class FormTariffWidget extends StatefulWidget {
  const FormTariffWidget({
    super.key,
    required this.tarifaAdultoController,
    required this.tarifaAdultoTPLController,
    required this.tarifaAdultoCPLController,
    required this.tarifaPaxAdicionalController,
    required this.tarifaMenoresController,
    required this.onUpdate,
    this.isEditing = false,
  });

  final TextEditingController tarifaAdultoController;
  final TextEditingController tarifaAdultoTPLController;
  final TextEditingController tarifaAdultoCPLController;
  final TextEditingController tarifaPaxAdicionalController;
  final TextEditingController tarifaMenoresController;
  final void Function() onUpdate;
  final bool isEditing;

  @override
  State<FormTariffWidget> createState() => _FormTariffWidgetState();
}

class _FormTariffWidgetState extends State<FormTariffWidget> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !widget.isEditing,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa SGL/DBL",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  onChanged: (p0) => widget.onUpdate.call(),
                  controller: widget.tarifaAdultoController,
                  readOnly: !widget.isEditing,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa TPL",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  onChanged: (p0) => widget.onUpdate.call(),
                  controller: widget.tarifaAdultoTPLController,
                   readOnly: !widget.isEditing,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa CPLE",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  onChanged: (p0) => widget.onUpdate.call(),
                  controller: widget.tarifaAdultoCPLController,
                   readOnly: !widget.isEditing,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa Pax Adic",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  controller: widget.tarifaPaxAdicionalController,
                  onChanged: (p0) => widget.onUpdate.call(),
                   readOnly: !widget.isEditing,                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa Menores 7 a 12 años",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  controller: widget.tarifaMenoresController,
                  onChanged: (p0) => widget.onUpdate.call(),
                   readOnly: !widget.isEditing,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa Menores 0 a 6 años",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  blocked: true,
                  enabled: false,
                  initialValue: "GRATIS",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
