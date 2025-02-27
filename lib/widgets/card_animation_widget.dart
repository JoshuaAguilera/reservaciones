import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/desktop_colors.dart';
import 'package:generador_formato/utils/shared_preferences/settings.dart';
import 'package:generador_formato/views/generacion_cotizaciones/dialogs/manager_tariff_single_dialog.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../providers/habitacion_provider.dart';
import '../utils/helpers/constants.dart';
import '../utils/helpers/utility.dart';
import 'text_styles.dart';

class CardAnimationWidget extends ConsumerStatefulWidget {
  const CardAnimationWidget({
    super.key,
    this.resetTime = const Duration(milliseconds: 3500),
    required this.sideController,
    required this.tarifaXDia,
  });

  final Duration resetTime;
  final SidebarXController sideController;
  final TarifaXDia tarifaXDia;

  @override
  _CardAnimationWidgetState createState() => _CardAnimationWidgetState();
}

class _CardAnimationWidgetState extends ConsumerState<CardAnimationWidget> {
  bool _showFrontSide = false;
  bool _flipXAxis = false;
  bool _isLoading = false;
  bool _isEditing = false;
  late Timer flipCard;
  RegistroTarifa? nowRegister;

  @override
  void initState() {
    _showFrontSide = true;
    _flipXAxis = true;
    nowRegister = widget.tarifaXDia.tarifa == null
        ? null
        : RegistroTarifa(
            tarifas: (widget.tarifaXDia.tarifas != null ||
                    (widget.tarifaXDia.tarifas ?? []).isNotEmpty)
                ? widget.tarifaXDia.tarifas
                : [widget.tarifaXDia.tarifa!],
            temporadas: (widget.tarifaXDia.temporadaSelect != null
                ? [widget.tarifaXDia.temporadaSelect!]
                : []),
          );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final habitacionProvider = ref.watch(habitacionSelectProvider);
    final typeQuote = ref.watch(typeQuoteProvider);

    return Center(
      child: Container(
        constraints: BoxConstraints.tight(const Size.square(200.0)),
        child: _buildFlipAnimation(habitacionProvider, typeQuote),
      ),
    );
  }

  void _switchCard() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
        _showFrontSide = !_showFrontSide;
      });

      flipCard = Timer(widget.resetTime, () {
        if (mounted) {
          setState(
            () {
              if (!_isEditing) {
                _showFrontSide = !_showFrontSide;
              }
            },
          );
        }
      });

      Future.delayed(
        widget.resetTime + 800.ms,
        () {
          if (mounted) {
            setState(
              () {
                if (!_isEditing) {
                  _isLoading = false;
                }
              },
            );
          }
        },
      );
    }
  }

  Widget _buildFlipAnimation(Habitacion habitacion, bool typeQuote) {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: !Settings.applyAnimations
            ? const Duration(milliseconds: 0)
            : const Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showFrontSide
            ? _buildFront(habitacion, typeQuote)
            : _buildRear(habitacion, typeQuote),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFront(Habitacion habitacion, bool typeQuote) {
    final useCashSeason = ref.watch(useCashSeasonRoomProvider);

    double padding = (MediaQuery.of(context).size.width > 850) ? 12 : 6;
    double totalAdulto = Utility.calculateTotalTariffRoom(
      nowRegister,
      habitacion,
      habitacion.tarifaXDia!.length,
      descuentoProvisional: widget.tarifaXDia.descuentoProvisional,
      isGroupTariff: typeQuote,
      useCashSeason: useCashSeason,
      applyRoundFormat: !(widget.tarifaXDia.modificado ?? false),
    );

    double totalMenores = Utility.calculateTotalTariffRoom(
      nowRegister,
      habitacion,
      habitacion.tarifaXDia!.length,
      descuentoProvisional: widget.tarifaXDia.descuentoProvisional,
      isCalculateChildren: true,
      isGroupTariff: typeQuote,
      useCashSeason: useCashSeason,
      applyRoundFormat: !(widget.tarifaXDia.modificado ?? false),
    );

    bool showToolTip = (MediaQuery.of(context).size.width >
        (1710 - (widget.sideController.extended ? 100 : 200)));

    return __buildLayout(
      key: ValueKey(true),
      backgroundColor: Theme.of(context).primaryColorDark,
      faceName: "Front",
      child: Tooltip(
        richMessage: showToolTip
            ? TextSpan()
            : WidgetSpan(
                child: SizedBox(
                  width: 95,
                  child: Column(
                    children: [
                      if (MediaQuery.of(context).size.width <
                          (1210 - (widget.sideController.extended ? 0 : 100)))
                        TextStyles.standardText(
                          text: widget.tarifaXDia.nombreTariff ?? '',
                          size: 11,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      if (MediaQuery.of(context).size.width <
                          (1510 - (widget.sideController.extended ? 50 : 175)))
                        _messageAsociate(
                          title: "Adul: ",
                          count: widget.tarifaXDia.tarifa == null
                              ? 0
                              : totalAdulto,
                          isTooltip: true,
                        ),
                      if (MediaQuery.of(context).size.width <
                          (1610 - (widget.sideController.extended ? 50 : 175)))
                        _messageAsociate(
                          title: "Men 7-12: ",
                          count: widget.tarifaXDia.tarifa == null
                              ? 0
                              : totalMenores,
                          isTooltip: true,
                        ),
                      if (MediaQuery.of(context).size.width <
                          (1720 - (widget.sideController.extended ? 100 : 200)))
                        _messageAsociate(
                          title: "Total: ",
                          count: widget.tarifaXDia.tarifa == null
                              ? 0
                              : (totalMenores + totalAdulto),
                          isTooltip: true,
                        ),
                    ],
                  ),
                ),
              ),
        verticalOffset: 40,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, padding, 15, padding),
          child: Column(
            children: [
              TextStyles.TextTitleList(
                index: widget.tarifaXDia.fecha!.day,
                color: widget.tarifaXDia.subCode == null
                    ? widget.tarifaXDia.color ?? Theme.of(context).dividerColor
                    : Utility.darken(
                        widget.tarifaXDia.color ?? DesktopColors.cerulean, 0.2),
                size: (MediaQuery.of(context).size.width >
                        (1110 - (widget.sideController.extended ? 0 : 100)))
                    ? 28
                    : 23,
              ),
              if (MediaQuery.of(context).size.width > 1345)
                const SizedBox(height: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (MediaQuery.of(context).size.width >
                      (1210 - (widget.sideController.extended ? 0 : 100)))
                    TextStyles.standardText(
                      text: widget.tarifaXDia.nombreTariff ?? '',
                      size: 11,
                      color: Theme.of(context).primaryColor,
                    ),
                  if (MediaQuery.of(context).size.width >
                      (1510 - (widget.sideController.extended ? 50 : 175)))
                    _messageAsociate(
                      title: "Adul: ",
                      count: widget.tarifaXDia.tarifa == null ? 0 : totalAdulto,
                    ),
                  if (MediaQuery.of(context).size.width >
                      (1610 - (widget.sideController.extended ? 50 : 175)))
                    _messageAsociate(
                      title: "Men 7-12: ",
                      count:
                          widget.tarifaXDia.tarifa == null ? 0 : totalMenores,
                    ),
                  if (MediaQuery.of(context).size.width > 1710)
                    const SizedBox(height: 10),
                  if (showToolTip)
                    _messageAsociate(
                      title: "Total: ",
                      count: widget.tarifaXDia.tarifa == null
                          ? 0
                          : (totalMenores + totalAdulto),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _messageAsociate({
    required String title,
    required double count,
    bool isTooltip = false,
  }) {
    return TextStyles.TextAsociative(
      title,
      Utility.formatterNumber(
        count,
      ),
      boldInversed: true,
      size: 11,
      color: isTooltip
          ? Theme.of(context).primaryColorDark
          : Theme.of(context).primaryColor,
    );
  }

  Widget _buildRear(Habitacion habitacion, bool typeQuote) {
    double padding = (MediaQuery.of(context).size.width > 850) ? 10 : 0;
    bool isUnknow = widget.tarifaXDia.code!.contains("Unknow") ||
        widget.tarifaXDia.code!.contains("tariffFree");

    return __buildLayout(
      key: ValueKey(false),
      backgroundColor: widget.tarifaXDia.subCode == null
          ? widget.tarifaXDia.color ?? DesktopColors.cerulean
          : Utility.darken(
              widget.tarifaXDia.color ?? DesktopColors.cerulean, 0.2),
      faceName: "Rear",
      child: Padding(
        padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: (MediaQuery.of(context).size.width > 1200)
                ? MainAxisAlignment.center
                : MainAxisAlignment.center,
            children: [
              if (typeQuote
                  ? true
                  : MediaQuery.of(context).size.width >
                      (1100 + (widget.sideController.extended ? 120 : 0)))
                TextStyles.TextTitleList(
                  index: widget.tarifaXDia.fecha!.day,
                  color: widget.tarifaXDia.color == null
                      ? Colors.white
                      : useWhiteForeground(widget.tarifaXDia.subCode == null
                              ? widget.tarifaXDia.color ??
                                  DesktopColors.cerulean
                              : Utility.darken(
                                  widget.tarifaXDia.color ??
                                      DesktopColors.cerulean,
                                  0.2))
                          ? Colors.white
                          : const Color.fromARGB(255, 43, 43, 43),
                  size: (MediaQuery.of(context).size.width > 1390)
                      ? 28
                      : !typeQuote
                          ? 20
                          : 26,
                ),
              if (MediaQuery.of(context).size.width > 1590)
                const SizedBox(height: 8),
              if (MediaQuery.of(context).size.width >
                  (1500 - (widget.sideController.extended ? 0 : 250)))
                Padding(
                  padding: EdgeInsets.only(bottom: isUnknow ? 10 : 0),
                  child: TextStyles.TextAsociative(
                    (isUnknow && widget.tarifaXDia.tariffCode == null)
                        ? "Descuento: "
                        : "Temporada: ",
                    (isUnknow && widget.tarifaXDia.tariffCode == null)
                        ? "${widget.tarifaXDia.descuentoProvisional}%"
                        : widget.tarifaXDia.temporadaSelect?.nombre ?? "---",
                    boldInversed: true,
                    textAling: TextAlign.center,
                    size: 11,
                    color: widget.tarifaXDia.color == null
                        ? Colors.white
                        : useWhiteForeground(widget.tarifaXDia.subCode == null
                                ? widget.tarifaXDia.color ??
                                    DesktopColors.cerulean
                                : Utility.darken(
                                    widget.tarifaXDia.color ??
                                        DesktopColors.cerulean,
                                    0.2))
                            ? Colors.white
                            : const Color.fromARGB(255, 43, 43, 43),
                    overflow: (MediaQuery.of(context).size.width > 1590)
                        ? TextOverflow.clip
                        : typeQuote
                            ? TextOverflow.clip
                            : TextOverflow.ellipsis,
                  ),
                ),
              if (MediaQuery.of(context).size.width >
                      (1590 - (widget.sideController.extended ? 0 : 150)) &&
                  !isUnknow)
                TextStyles.TextAsociative(
                  "Periodo: ",
                  widget.tarifaXDia.periodo == null
                      ? "No definido"
                      : Utility.getStringPeriod(
                          initDate: widget.tarifaXDia.periodo!.fechaInicial!,
                          lastDate: widget.tarifaXDia.periodo!.fechaFinal!,
                          compact: true,
                        ),
                  boldInversed: true,
                  textAling: TextAlign.center,
                  size: 11,
                  color: widget.tarifaXDia.color == null
                      ? Colors.white
                      : useWhiteForeground(widget.tarifaXDia.subCode == null
                              ? widget.tarifaXDia.color ??
                                  DesktopColors.cerulean
                              : Utility.darken(
                                  widget.tarifaXDia.color ??
                                      DesktopColors.cerulean,
                                  0.2))
                          ? Colors.white
                          : const Color.fromARGB(255, 43, 43, 43),
                ),
              if (MediaQuery.of(context).size.width > 1490 && !typeQuote)
                SizedBox(
                  width:
                      (MediaQuery.of(context).size.width > 1490) ? 105 : null,
                  child: Buttons.commonButton(
                    onPressed: () => showDialogEditQuote(habitacion),
                    text: "Editar",
                    sizeText: 11.5,
                    isBold: true,
                    withRoundedBorder: true,
                    color: Utility.darken(
                        widget.tarifaXDia.subCode == null
                            ? widget.tarifaXDia.color ?? DesktopColors.cerulean
                            : Utility.darken(
                                widget.tarifaXDia.color ??
                                    DesktopColors.cerulean,
                                0.2),
                        0.2),
                    colorText: widget.tarifaXDia.color == null
                        ? Colors.white
                        : useWhiteForeground(Utility.darken(
                                widget.tarifaXDia.subCode == null
                                    ? widget.tarifaXDia.color ??
                                        DesktopColors.cerulean
                                    : Utility.darken(
                                        widget.tarifaXDia.color ??
                                            DesktopColors.cerulean,
                                        0.2),
                                0.2))
                            ? Colors.white
                            : const Color.fromARGB(255, 43, 43, 43),
                  ),
                ),
              if (MediaQuery.of(context).size.width <= 1490 && !typeQuote)
                Tooltip(
                  message: "Editar",
                  child: IconButton(
                    onPressed: () => showDialogEditQuote(habitacion),
                    icon: Icon(
                      Icons.mode_edit_outline_outlined,
                      color: useWhiteForeground(
                              widget.tarifaXDia.color ?? DesktopColors.cerulean)
                          ? Colors.white
                          : const Color.fromARGB(255, 43, 43, 43),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogEditQuote(Habitacion habitacion) {
    setState(() {
      flipCard.cancel;
      _isEditing = true;
    });
    showDialog(
      context: context,
      builder: (context) => ManagerTariffSingleDialog(
        tarifaXDia: widget.tarifaXDia,
        numDays: DateTime.parse(habitacion.fechaCheckOut ?? '')
            .difference(DateTime.parse(habitacion.fechaCheckIn ?? ''))
            .inDays,
      ),
    ).then(
      (value) {
        if (mounted) {
          setState(
            () {
              flipCard.cancel();
              if (!_showFrontSide) {
                setState(() {
                  _showFrontSide = !_showFrontSide;
                });
              }
            },
          );
        }

        nowRegister = widget.tarifaXDia.tarifa == null
            ? null
            : RegistroTarifa(
                tarifas: (widget.tarifaXDia.tarifas != null ||
                        widget.tarifaXDia.tarifas!.isNotEmpty)
                    ? widget.tarifaXDia.tarifas
                    : [widget.tarifaXDia.tarifa!],
                temporadas: widget.tarifaXDia.temporadaSelect != null
                    ? [widget.tarifaXDia.temporadaSelect!]
                    : []);

        Future.delayed(
          1200.ms,
          () {
            if (mounted) {
              setState(
                () {
                  _isLoading = false;
                  _isEditing = false;
                },
              );
            }
          },
        );
      },
    );
  }

  Widget __buildLayout(
      {required Key key,
      required Widget child,
      required String faceName,
      required Color backgroundColor}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15.0),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 10, // Increased blur radius
              offset: const Offset(0, 7),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 15, // Increased blur radius
              offset: const Offset(0, -2),
            ),
          ]),
      child: Center(
        child: child,
      ),
    );
  }

  String getNameMonth() {
    return monthNames[widget.tarifaXDia.fecha!.month - 1];
  }
}
