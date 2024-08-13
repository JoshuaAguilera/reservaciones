import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';

import '../utils/helpers/constants.dart';
import '../utils/helpers/utility.dart';
import 'text_styles.dart';

class CardAnimationWidget extends StatefulWidget {
  const CardAnimationWidget({
    super.key,
    required this.day,
    required this.isMostMonth,
    required this.initDay,
    this.daysMonth,
    this.weekDayLast,
    this.resetTime = const Duration(milliseconds: 3500),
  });

  final int day;
  final bool isMostMonth;
  final int initDay;
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
        child:
            AbsorbPointer(absorbing: _isLoading, child: _buildFlipAnimation()),
      ),
    );
  }

  void _switchCard() {
    setState(() {
      _isLoading = true;
      _showFrontSide = !_showFrontSide;
    });

    Future.delayed(
        1100.ms,
        () => setState(() {
              _isLoading = false;
            }));

    Future.delayed(
        widget.resetTime,
        () => setState(() {
              _showFrontSide = !_showFrontSide;
            }));
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _isLoading ? null : _switchCard,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: _showFrontSide ? _buildFront() : _buildRear(),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
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
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFront() {
    return __buildLayout(
      key: ValueKey(true),
      backgroundColor: Theme.of(context).primaryColorDark,
      faceName: "Front",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        child: Column(
          children: [
            TextStyles.TextSpecial(
                day: (widget.daysMonth != null)
                    ? ((widget.day - 2) <= widget.daysMonth!)
                        ? (widget.day - 2)
                        : widget.day - 2 - widget.daysMonth!
                    : (widget.day!) - (widget.initDay - 2),
                subtitle: dayNames[widget.isMostMonth
                    ? (widget.initDay == 4)
                        ? widget.day
                        : (widget.initDay < 4)
                            ? widget.day - (widget.initDay)
                            : widget.day + (widget.initDay - 4)
                    : widget.day],
                sizeTitle: 28,
                colorsubTitle: Theme.of(context).primaryColor,
                colorTitle: Theme.of(context).dividerColor,
                sizeSubtitle: 15),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyles.TextAsociative(
                    "Adulto: ", Utility.formatterNumber(0),
                    boldInversed: true,
                    size: 11,
                    color: Theme.of(context).primaryColor),
                TextStyles.TextAsociative(
                    "KID: ",
                    boldInversed: true,
                    size: 11,
                    Utility.formatterNumber(0),
                    color: Theme.of(context).primaryColor),
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
    return __buildLayout(
      key: ValueKey(false),
      backgroundColor: DesktopColors.cerulean,
      faceName: "Rear",
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextStyles.TextSpecial(
                  day: (widget.daysMonth != null)
                      ? ((widget.day - 2) <= widget.daysMonth!)
                          ? (widget.day - 2)
                          : widget.day - 2 - widget.daysMonth!
                      : (widget.day!) - (widget.initDay - 2),
                  subtitle: dayNames[widget.isMostMonth
                      ? (widget.initDay == 4)
                          ? widget.day
                          : (widget.initDay < 4)
                              ? widget.day - (widget.initDay)
                              : widget.day + (widget.initDay - 4)
                      : widget.day],
                  sizeTitle: 28,
                  colorsubTitle: Theme.of(context).primaryColor,
                  colorTitle: Theme.of(context).dividerColor,
                  sizeSubtitle: 15),
              const SizedBox(height: 15),
              SizedBox(
                width: 105,
                child: Buttons.commonButton(
                  onPressed: () {},
                  text: "Cambiar",
                  sizeText: 12.5,
                  isBold: true,
                  withRoundedBorder: true,
                ),
              ),
            ],
          ),
        ),
      ),
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
}
