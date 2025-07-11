import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../models/periodo_model.dart';
import '../../models/tarifa_rack_model.dart';
import '../../res/helpers/date_helpers.dart';
import '../../res/helpers/utility.dart';
import '../../res/helpers/desktop_colors.dart';
import 'form_widgets.dart';
import '../../res/ui/text_styles.dart';

class DayInfoItemRow extends StatefulWidget {
  const DayInfoItemRow({
    super.key,
    required this.child,
    required this.rack,
    this.yearNow,
    this.day,
    this.month,
    this.weekNow,
    this.isntWeek = true,
  });

  final TarifaRack rack;
  final int? yearNow;
  final int? day;
  final DateTime? month;
  final DateTime? weekNow;
  final Widget child;
  final bool isntWeek;

  @override
  State<DayInfoItemRow> createState() => _DayInfoItemRowState();
}

class _DayInfoItemRowState extends State<DayInfoItemRow> {
  final _controller = SuperTooltipController();
  GlobalKey _containerKey = GlobalKey();
  TooltipDirection position = TooltipDirection.down;
  late Periodo nowPeriod;

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
    if (widget.weekNow != null) {
      nowPeriod =
          DateHelpers.getPeriodNow(widget.weekNow!, widget.rack.periodos);
    }
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
                      text: widget.rack.nombre ?? '',
                      isBold: true,
                      color: Theme.of(context).primaryColor,
                    ),
                    TextStyles.standardText(
                      text: DateHelpers.definePeriodNow(
                        widget.weekNow ??
                            DateTime(widget.yearNow!, widget.month!.month,
                                widget.day!),
                        periodos: widget.rack.periodos,
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    if (widget.isntWeek && widget.weekNow != null)
                      TextStyles.TextAsociative(
                        "Estatus: ",
                        Utility.defineStatusPeriod(nowPeriod),
                        color: Theme.of(context).primaryColor,
                        boldInversed: true,
                      ),
                    TextStyles.standardText(
                      text: "Temporadas",
                      size: 11,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      height: 325,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var element in widget.rack.temporadas!)
                              _itemSeasonInfo(
                                nombre: element.nombre ?? '',
                                estanciaMin: element.estanciaMinima,
                                tipo: element.tipo,
                                porcentaje: element.descuento,
                              ),
                          ],
                        ),
                      ),
                    )
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
    String? tipo = "individual",
  }) {
    return Column(
      children: [
        Container(
          width: 275,
          height: 30,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: tipo == 'efectivo'
                ? DesktopColors.cashSeason
                : tipo == 'grupal'
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
                child: FormWidgets.textFormField(
                  name: "Estancia Min.",
                  enabled: true,
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
                child: FormWidgets.textFormField(
                  name: "Descuento",
                  enabled: true,
                  isNumeric: true,
                  colorText: Theme.of(context).primaryColor,
                  colorBorder: Theme.of(context).disabledColor,
                  colorIcon: Theme.of(context).inputDecorationTheme.iconColor,
                  initialValue: (porcentaje ?? 'No aplica').toString(),
                  icon: Icon(
                    porcentaje != null ? EvaIcons.percent : HeroIcons.no_symbol,
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
