import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/dialogs.dart';

import '../providers/habitacion_provider.dart';
import '../utils/helpers/constants.dart';
import '../utils/helpers/utility.dart';
import 'text_styles.dart';

class CardAnimationWidget extends ConsumerStatefulWidget {
  const CardAnimationWidget({
    super.key,
    required this.day,
    this.resetTime = const Duration(milliseconds: 3500),
    required this.dateNow,
    required this.registros,
    required this.totalDays,
    required this.isLastDay,
  });

  final int day;
  final Duration resetTime;
  final DateTime dateNow;
  final List<RegistroTarifa> registros;
  final int totalDays;
  final bool isLastDay;

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
    nowRegister = Utility.revisedTariffDay(widget.dateNow, widget.registros);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final habitacionProvider = ref.watch(habitacionSelectProvider);

    return Center(
      child: Container(
        constraints: BoxConstraints.tight(const Size.square(200.0)),
        child: _buildFlipAnimation(habitacionProvider),
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

  Widget _buildFlipAnimation(Habitacion habitacion) {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child:
            _showFrontSide ? _buildFront(habitacion) : _buildRear(habitacion),
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

  Widget _buildFront(Habitacion habitacion) {
    double padding = (MediaQuery.of(context).size.width > 850) ? 12 : 6;
    return __buildLayout(
      key: ValueKey(true),
      backgroundColor: Theme.of(context).primaryColorDark,
      faceName: "Front",
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, padding, 15, padding),
        child: Column(
          children: [
            TextStyles.TextTitleList(
              index: widget.day,
              color: nowRegister != null
                  ? nowRegister!.color!
                  : Theme.of(context).dividerColor,
              size: 28,
            ),
            if (MediaQuery.of(context).size.width > 1345)
              const SizedBox(height: 7),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (MediaQuery.of(context).size.width > 1310)
                  TextStyles.standardText(
                    text: nowRegister != null
                        ? nowRegister!.nombre ?? ''
                        : "No definido",
                    size: 11,
                    color: Theme.of(context).primaryColor,
                  ),
                if (MediaQuery.of(context).size.width > 1510)
                  TextStyles.TextAsociative(
                      "Adulto: ",
                      widget.isLastDay
                          ? "\$0.00"
                          : Utility.formatterNumber(
                              Utility.calculateTariffAdult(
                                  nowRegister, habitacion, widget.totalDays)),
                      boldInversed: true,
                      size: 11,
                      color: Theme.of(context).primaryColor),
                if (MediaQuery.of(context).size.width > 1610)
                  TextStyles.TextAsociative(
                      "Men 7-12: ",
                      boldInversed: true,
                      size: 11,
                      widget.isLastDay
                          ? "\$0.00"
                          : Utility.formatterNumber(
                              Utility.calculateTariffChildren(
                                  nowRegister, habitacion, widget.totalDays)),
                      color: Theme.of(context).primaryColor),
                if (MediaQuery.of(context).size.width > 1710)
                  const SizedBox(height: 10),
                if (MediaQuery.of(context).size.width > 1710)
                  TextStyles.TextAsociative(
                      "Total: ",
                      boldInversed: true,
                      size: 11,
                      widget.isLastDay
                          ? "\$0.00"
                          : Utility.formatterNumber(
                              Utility.calculateTariffAdult(nowRegister,
                                      habitacion, widget.totalDays) +
                                  Utility.calculateTariffChildren(nowRegister,
                                      habitacion, widget.totalDays)),
                      color: Theme.of(context).primaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRear(Habitacion habitacion) {
    double padding = (MediaQuery.of(context).size.width > 850) ? 10 : 0;

    return __buildLayout(
      key: ValueKey(false),
      backgroundColor:
          nowRegister != null ? nowRegister!.color! : DesktopColors.cerulean,
      faceName: "Rear",
      child: Padding(
        padding: EdgeInsets.fromLTRB(padding, 10, padding, 0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: (MediaQuery.of(context).size.width > 1200)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (MediaQuery.of(context).size.width > 1200)
                TextStyles.TextTitleList(
                  index: widget.day,
                  color: nowRegister == null
                      ? Colors.white
                      : useWhiteForeground(nowRegister!.color!)
                          ? Colors.white
                          : const Color.fromARGB(255, 43, 43, 43),
                  size: (MediaQuery.of(context).size.width > 1390)
                      ? 28
                      : (MediaQuery.of(context).size.width > 1160)
                          ? 20
                          : 28,
                ),
              if (MediaQuery.of(context).size.width > 1590)
                const SizedBox(height: 8),
              if (MediaQuery.of(context).size.width > 1500)
                TextStyles.TextAsociative(
                  "Periodo: ",
                  nowRegister == null
                      ? "No definido"
                      : Utility.definePeriodNow(
                          widget.dateNow, nowRegister!.periodos,
                          compact: true),
                  boldInversed: true,
                  size: 11,
                  color: nowRegister == null
                      ? Colors.white
                      : useWhiteForeground(nowRegister!.color!)
                          ? Colors.white
                          : const Color.fromARGB(255, 43, 43, 43),
                  overflow: (MediaQuery.of(context).size.width > 1590)
                      ? TextOverflow.clip
                      : TextOverflow.ellipsis,
                ),
              if (MediaQuery.of(context).size.width > 1590)
                TextStyles.TextAsociative(
                  "Temporada: ",
                  Utility.getSeasonNow(nowRegister!, widget.totalDays)
                          ?.nombre ??
                      '',
                  boldInversed: true,
                  size: 11,
                  color: nowRegister == null
                      ? Colors.white
                      : useWhiteForeground(nowRegister!.color!)
                          ? Colors.white
                          : const Color.fromARGB(255, 43, 43, 43),
                ),
              if (MediaQuery.of(context).size.width > 1460)
                const SizedBox(height: 8),
              if (MediaQuery.of(context).size.width > 1490 && !widget.isLastDay)
                SizedBox(
                  width:
                      (MediaQuery.of(context).size.width > 1490) ? 105 : null,
                  child: Buttons.commonButton(
                    onPressed: () => showDialogEditQuote(),
                    text: "Cambiar",
                    sizeText: 11.5,
                    isBold: true,
                    withRoundedBorder: true,
                    color: nowRegister?.color,
                    colorText: nowRegister == null
                        ? Colors.white
                        : useWhiteForeground(nowRegister!.color!)
                            ? Colors.white
                            : const Color.fromARGB(255, 43, 43, 43),
                  ),
                ),
              if (MediaQuery.of(context).size.width <= 1490)
                IconButton(
                  onPressed: () => showDialogEditQuote(),
                  icon: Icon(
                    Icons.mode_edit_outline_outlined,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogEditQuote() {
    setState(() {
      flipCard.cancel;
      _isEditing = true;
    });
    showDialog(
      context: context,
      builder: (context) => Dialogs.taridaAlertDialog(
        context: context,
        title: "Modificar de tarifas ${widget.day} / ${getNameMonth()}",
        iconData: CupertinoIcons.pencil_circle,
        iconColor: DesktopColors.cerulean,
        nameButtonMain: "ACEPTAR",
        funtionMain: () {},
        nameButtonCancel: "CANCELAR",
        withButtonCancel: true,
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
    return monthNames[widget.dateNow.month - 1];
  }
}
