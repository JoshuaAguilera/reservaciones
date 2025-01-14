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
    this.applyAutoCalculation = false,
    this.autoCalculation,
    this.applyRound = false,
  });

  final TextEditingController tarifaAdultoController;
  final TextEditingController tarifaAdultoTPLController;
  final TextEditingController tarifaAdultoCPLController;
  final TextEditingController tarifaPaxAdicionalController;
  final TextEditingController tarifaMenoresController;
  final void Function() onUpdate;
  final bool isEditing;
  final bool applyAutoCalculation;
  final void Function()? autoCalculation;
  final bool applyRound;

  @override
  State<FormTariffWidget> createState() => _FormTariffWidgetState();
}

class _FormTariffWidgetState extends State<FormTariffWidget> {
  TextEditingController _roundController(TextEditingController controller) {
    if (!widget.applyRound) {
      return controller;
    }
    return TextEditingController(
        text: "${double.tryParse(controller.text)?.round().toDouble()}");
  }

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
                  onChanged: (p0) {
                    if (widget.autoCalculation != null) {
                      widget.autoCalculation!.call();
                    }
                    widget.onUpdate.call();
                  },
                  controller: _roundController(widget.tarifaAdultoController),
                  readOnly: !widget.isEditing,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Opacity(
                  opacity: widget.applyAutoCalculation ? 0.6 : 1,
                  child: TextFormFieldCustom.textFormFieldwithBorder(
                    name: "Tarifa TPL",
                    isMoneda: true,
                    isNumeric: true,
                    isDecimal: true,
                    onChanged: (p0) {
                      if (!widget.applyAutoCalculation) {
                        widget.onUpdate.call();
                      }
                    },
                    controller:
                        _roundController(widget.tarifaAdultoTPLController),
                    readOnly:
                        (!widget.isEditing || widget.applyAutoCalculation),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Opacity(
                  opacity: widget.applyAutoCalculation ? 0.6 : 1,
                  child: TextFormFieldCustom.textFormFieldwithBorder(
                    name: "Tarifa CPLE",
                    isMoneda: true,
                    isNumeric: true,
                    isDecimal: true,
                    onChanged: (p0) {
                      if (!widget.applyAutoCalculation) {
                        widget.onUpdate.call();
                      }
                    },
                    controller:
                        _roundController(widget.tarifaAdultoCPLController),
                    readOnly:
                        (!widget.isEditing || widget.applyAutoCalculation),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa Pax Adic",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  controller:
                      _roundController(widget.tarifaPaxAdicionalController),
                  onChanged: (p0) {
                    if (widget.autoCalculation != null) {
                      widget.autoCalculation!.call();
                    }
                    widget.onUpdate.call();
                  },
                  readOnly: !widget.isEditing,
                ),
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
                  controller: _roundController(widget.tarifaMenoresController),
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
