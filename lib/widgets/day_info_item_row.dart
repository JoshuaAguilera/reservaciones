import 'package:flutter/material.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../utils/helpers/utility.dart';
import '../utils/helpers/web_colors.dart';
import 'form_widgets.dart';
import 'text_styles.dart';

class DayInfoItemRow extends StatefulWidget {
  const DayInfoItemRow({
    super.key,
    required this.child,
    required this.tarifa,
    this.yearNow,
    this.day,
    this.month,
    this.weekNow,
    this.popupDirection = TooltipDirection.up,
  });

  final RegistroTarifa tarifa;
  final int? yearNow;
  final int? day;
  final DateTime? month;
  final DateTime? weekNow;
  final Widget child;
  final TooltipDirection popupDirection;

  @override
  State<DayInfoItemRow> createState() => _DayInfoItemRowState();
}

class _DayInfoItemRowState extends State<DayInfoItemRow> {
  final _controller = SuperTooltipController();

  Future<bool>? _willPopCallback() async {
    if (_controller.isVisible) {
      await _controller.hideTooltip();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => _willPopCallback,
      child: GestureDetector(
        onTap: () async => await _controller.showTooltip(),
        child: SuperTooltip(
          showBarrier: true,
          controller: _controller,
          popupDirection: widget.popupDirection,
          barrierColor: Colors.transparent,
          borderColor: Colors.transparent,
          content: Padding(
              padding: const EdgeInsets.all(4),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextStyles.standardText(
                      text: widget.tarifa.nombre ?? '',
                      isBold: true,
                      color: Theme.of(context).primaryColor,
                    ),
                    TextStyles.standardText(
                      text: Utility.definePeriodNow(
                          widget.weekNow ??
                              DateTime(widget.yearNow!, widget.month!.month,
                                  widget.day!),
                          widget.tarifa.periodos),
                      color: Theme.of(context).primaryColor,
                    ),
                    Container(
                      width: 275,
                      height: 30,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: DesktopColors.vistaReserva,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      child: Center(
                        child: TextStyles.mediumText(
                          text: "VISTA RESERVA",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 275,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "SGL/DBL",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              initialValue: widget
                                  .tarifa.tarifas!.first.tarifaAdultoSGLoDBL!
                                  .toStringAsFixed(2),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "PAX ADIC",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              initialValue: widget
                                  .tarifa.tarifas!.first.tarifaPaxAdicional!
                                  .toStringAsFixed(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 275,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "TPL",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              initialValue: (widget.tarifa.tarifas!.first
                                          .tarifaAdultoTPL ??
                                      Utility.calculateRate(
                                          TextEditingController(
                                              text: widget.tarifa.tarifas!.first
                                                  .tarifaAdultoSGLoDBL
                                                  .toString()),
                                          TextEditingController(
                                              text: widget.tarifa.tarifas!.first
                                                  .tarifaPaxAdicional
                                                  .toString()),
                                          1))
                                  .toString(),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "CPLE",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              initialValue: (widget.tarifa.tarifas!.first
                                          .tarifaAdultoCPLE ??
                                      Utility.calculateRate(
                                          TextEditingController(
                                              text: widget.tarifa.tarifas!.first
                                                  .tarifaAdultoSGLoDBL
                                                  .toString()),
                                          TextEditingController(
                                              text: widget.tarifa.tarifas!.first
                                                  .tarifaPaxAdicional
                                                  .toString()),
                                          2))
                                  .toString(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 275,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "MENORES 7-12 AÑOS",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              initialValue: widget
                                  .tarifa.tarifas!.first.tarifaMenores7a12!
                                  .toStringAsFixed(2),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "MENORES 0-6 AÑOS",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              initialValue: "GRATIS",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 275,
                      height: 30,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: DesktopColors.vistaParcialMar,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      child: Center(
                        child: TextStyles.mediumText(
                          text: "VISTA PARCIAL AL MAR",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 275,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "SGL/DBL",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              initialValue: widget
                                  .tarifa.tarifas![1].tarifaAdultoSGLoDBL!
                                  .toStringAsFixed(2),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "PAX ADIC",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              initialValue: widget
                                  .tarifa.tarifas![1].tarifaPaxAdicional!
                                  .toStringAsFixed(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 275,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "TPL",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              initialValue:
                                  (widget.tarifa.tarifas![1].tarifaAdultoTPL ??
                                          Utility.calculateRate(
                                              TextEditingController(
                                                  text: widget
                                                      .tarifa
                                                      .tarifas![1]
                                                      .tarifaAdultoSGLoDBL
                                                      .toString()),
                                              TextEditingController(
                                                  text: widget
                                                      .tarifa
                                                      .tarifas![1]
                                                      .tarifaPaxAdicional
                                                      .toString()),
                                              1))
                                      .toString(),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "CPLE",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              initialValue:
                                  (widget.tarifa.tarifas![1].tarifaAdultoCPLE ??
                                          Utility.calculateRate(
                                              TextEditingController(
                                                  text: widget
                                                      .tarifa
                                                      .tarifas![1]
                                                      .tarifaAdultoSGLoDBL
                                                      .toString()),
                                              TextEditingController(
                                                  text: widget
                                                      .tarifa
                                                      .tarifas![1]
                                                      .tarifaPaxAdicional
                                                      .toString()),
                                              2))
                                      .toString(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 275,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "MENORES 7-12 AÑOS",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              initialValue: widget
                                  .tarifa.tarifas![1].tarifaMenores7a12!
                                  .toStringAsFixed(2),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "MENORES 0-6 AÑOS",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              initialValue: "GRATIS",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          child: widget.child,
        ),
      ),
    );
  }
}
