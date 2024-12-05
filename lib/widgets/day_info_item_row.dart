import 'package:flutter/material.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../utils/helpers/utility.dart';
import '../utils/helpers/desktop_colors.dart';
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
  });

  final RegistroTarifa tarifa;
  final int? yearNow;
  final int? day;
  final DateTime? month;
  final DateTime? weekNow;
  final Widget child;

  @override
  State<DayInfoItemRow> createState() => _DayInfoItemRowState();
}

class _DayInfoItemRowState extends State<DayInfoItemRow> {
  final _controller = SuperTooltipController();
  GlobalKey _containerKey = GlobalKey();
  TooltipDirection position = TooltipDirection.down;

  Future<bool>? _willPopCallback() async {
    if (_controller.isVisible) {
      await _controller.hideTooltip();
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.of(context).size.height;

    return PopScope(
      onPopInvoked: (didPop) => _willPopCallback,
      child: GestureDetector(
        key: _containerKey,
        onTap: () async {
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final Offset offset = await renderBox.localToGlobal(Offset.zero);
          if (heigth > 500) {
            if (offset.dy.round() > (heigth / 2)) {
              position = TooltipDirection.up;
            } else {
              position = TooltipDirection.down;
            }
          } else {
            position = TooltipDirection.up;
          }
          setState(() {});

          Future.delayed(
              Durations.short1, () async => await _controller.showTooltip());
        },
        child: AbsorbPointer(
          absorbing: true,
          child: SuperTooltip(
            showBarrier: true,
            controller: _controller,
            popupDirection: position,
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
                    TextStyles.standardText(
                      text: "Temporadas",
                      size: 11,
                      color: Theme.of(context).primaryColor,
                    ),
                    for (var element in widget.tarifa.temporadas!)
                      _itemSeasonInfo(
                        nombre: element.nombre ?? '',
                        estanciaMin: element.estanciaMinima,
                        isCash: element.forCash ?? false,
                        isGroup: element.forGroup ?? false,
                        porcentaje: element.porcentajePromocion,
                      ),
                  ],
                ),
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Widget _itemSeasonInfo({
    required String nombre,
    required int? estanciaMin,
    double? porcentaje,
    bool isGroup = false,
    bool isCash = false,
  }) {
    return Column(
      children: [
        Container(
          width: 275,
          height: 30,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isCash
                ? DesktopColors.cashSeason
                : isGroup
                    ? DesktopColors.cotGrupal
                    : DesktopColors.cotIndiv,
            borderRadius: const BorderRadius.all(
              Radius.circular(7),
            ),
          ),
          child: Center(
            child: TextStyles.mediumText(
              text: nombre,
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
                  name: "Estancia Min.",
                  blocked: true,
                  isNumeric: true,
                  initialValue: (estanciaMin ?? 0).toString(),
                  colorText: Theme.of(context).primaryColor,
                  colorBorder: Theme.of(context).disabledColor,
                  colorIcon: Theme.of(context).inputDecorationTheme.iconColor,
                  icon: const Icon(
                    HeroIcons.users,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: FormWidgets.textFormFieldResizable(
                  name: "Descuento",
                  blocked: true,
                  isNumeric: true,
                  colorText: Theme.of(context).primaryColor,
                  colorBorder: Theme.of(context).disabledColor,
                  colorIcon: Theme.of(context).inputDecorationTheme.iconColor,
                  initialValue: (porcentaje ?? 'No aplica').toString(),
                  icon:  Icon(
                  porcentaje != null ?  EvaIcons.percent : HeroIcons.no_symbol,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
