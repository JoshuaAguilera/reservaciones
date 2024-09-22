import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/dialogs.dart';

import '../utils/helpers/constants.dart';
import '../utils/helpers/utility.dart';
import 'text_styles.dart';

class CardAnimationWidget extends StatefulWidget {
  const CardAnimationWidget({
    super.key,
    required this.day,
    required this.isMostMonth,
    required this.initDay,
    required this.initMonth,
    this.daysMonth,
    this.weekDayLast,
    this.resetTime = const Duration(milliseconds: 3500),
  });

  final int day;
  final bool isMostMonth;
  final int initDay;
  final int initMonth;
  final int? daysMonth;
  final int? weekDayLast;
  final Duration resetTime;

  @override
  State<CardAnimationWidget> createState() => _CardAnimationWidgetState();
}

class _CardAnimationWidgetState extends State<CardAnimationWidget> {
  bool _showFrontSide = false;
  bool _flipXAxis = false;
  bool _isLoading = false;
  bool _isEditing = false;
  late Timer flipCard;

  @override
  void initState() {
    _showFrontSide = true;
    _flipXAxis = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.tight(const Size.square(200.0)),
        child: _buildFlipAnimation(),
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

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showFrontSide ? _buildFront() : _buildRear(),
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

  Widget _buildFront() {
    double padding = (MediaQuery.of(context).size.width > 850) ? 12 : 6;
    return __buildLayout(
      key: ValueKey(true),
      backgroundColor: Theme.of(context).primaryColorDark,
      faceName: "Front",
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, padding, 5, padding),
        child: Column(
          children: [
            TextStyles.TextSpecial(
                day: (widget.daysMonth != null)
                    ? ((widget.day - 2) <= widget.daysMonth!)
                        ? (widget.day - 2)
                        : widget.day - 2 - widget.daysMonth!
                    : (widget.day) - (widget.initDay - 2),
                subtitle: (MediaQuery.of(context).size.width > 1035)
                    ? dayNames[widget.isMostMonth
                        ? (widget.initDay == 4)
                            ? widget.day
                            : (widget.initDay < 4)
                                ? widget.day - (widget.initDay)
                                : widget.day + (widget.initDay - 4)
                        : widget.day]
                    : '',
                sizeTitle: 28,
                colorsubTitle: Theme.of(context).primaryColor,
                colorTitle: Theme.of(context).dividerColor,
                sizeSubtitle: 15),
            if (MediaQuery.of(context).size.width > 1035)
              const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (MediaQuery.of(context).size.width > 1200)
                  TextStyles.TextAsociative(
                      "Adulto: ", Utility.formatterNumber(0),
                      boldInversed: true,
                      size: 11,
                      color: Theme.of(context).primaryColor),
                if (MediaQuery.of(context).size.width > 1300)
                  TextStyles.TextAsociative(
                      "KID: ",
                      boldInversed: true,
                      size: 11,
                      Utility.formatterNumber(0),
                      color: Theme.of(context).primaryColor),
                if (MediaQuery.of(context).size.width > 1400)
                  TextStyles.TextAsociative(
                      "Pax adic: ",
                      boldInversed: true,
                      size: 11,
                      Utility.formatterNumber(0),
                      color: Theme.of(context).primaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRear() {
    double padding = (MediaQuery.of(context).size.width > 850) ? 10 : 0;

    return __buildLayout(
      key: ValueKey(false),
      backgroundColor: DesktopColors.cerulean,
      faceName: "Rear",
      child: Padding(
        padding: EdgeInsets.fromLTRB(padding, 10, padding, 0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (MediaQuery.of(context).size.width > 850)
                TextStyles.TextSpecial(
                    day: getNumDay(),
                    subtitle: (MediaQuery.of(context).size.width > 960)
                        ? dayNames[widget.isMostMonth
                            ? (widget.initDay == 4)
                                ? widget.day
                                : (widget.initDay < 4)
                                    ? widget.day - (widget.initDay)
                                    : widget.day + (widget.initDay - 4)
                            : widget.day]
                        : '',
                    sizeTitle: (MediaQuery.of(context).size.width > 1080)
                        ? 28
                        : (MediaQuery.of(context).size.width > 850)
                            ? 20
                            : 28,
                    colorsubTitle: Theme.of(context).primaryColor,
                    colorTitle: Theme.of(context).dividerColor,
                    sizeSubtitle: 15),
              if (MediaQuery.of(context).size.width > 1180)
                const SizedBox(height: 12),
              if (MediaQuery.of(context).size.width > 1180)
                TextStyles.TextAsociative(
                  "Periodo: ",
                  "Marzo-Abril",
                  boldInversed: true,
                  size: 11,
                  color: Theme.of(context).primaryColor,
                  overflow: (MediaQuery.of(context).size.width > 1280)
                      ? TextOverflow.clip
                      : TextOverflow.ellipsis,
                ),
              if (MediaQuery.of(context).size.width > 1280)
                TextStyles.TextAsociative(
                  "Temporada: ",
                  "Baja",
                  boldInversed: true,
                  size: 11,
                  color: Theme.of(context).primaryColor,
                ),
              if (MediaQuery.of(context).size.width > 1180)
                SizedBox(
                  width:
                      (MediaQuery.of(context).size.width > 1180) ? 105 : null,
                  child: Buttons.commonButton(
                    onPressed: () => showDialogEditQuote(),
                    text: "Cambiar",
                    sizeText: 11.5,
                    isBold: true,
                    withRoundedBorder: true,
                  ),
                ),
              if (MediaQuery.of(context).size.width <= 1180)
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
        title: "Modificar de tarifas ${getNumDay()} / ${getNameMonth()}",
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
          ]),
      child: Center(
        child: child,
      ),
    );
  }

  int getNumDay() {
    return (widget.daysMonth != null)
        ? ((widget.day - 2) <= widget.daysMonth!)
            ? (widget.day - 2)
            : widget.day - 2 - widget.daysMonth!
        : (widget.day) - (widget.initDay - 2);
  }

  String getNameMonth() {
    return (widget.daysMonth != null)
        ? ((widget.day - 2) <= widget.daysMonth!)
            ? monthNames[widget.initMonth - 1]
            : monthNames[widget.initMonth]
        : monthNames[widget.initMonth - 1];
  }
}
