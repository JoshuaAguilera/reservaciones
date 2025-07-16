import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/shared_preferences/settings.dart';

class AnimatedEntry extends StatefulWidget {
  final Widget child;
  final AnimationType type;
  final Duration? delay;
  final Duration? duration;
  final double? target;

  const AnimatedEntry({
    required this.child,
    this.type = AnimationType.fadeIn,
    this.delay = const Duration(milliseconds: 150),
    this.duration,
    super.key,
    this.target = 1,
  });

  @override
  State<AnimatedEntry> createState() => _AnimatedEntryState();
}

class _AnimatedEntryState extends State<AnimatedEntry> {
  final withAnimaitions = Settings.applyAnimations;

  @override
  Widget build(BuildContext context) {
    final animation = widget.child.animate(target: widget.target);
    switch (widget.type) {
      case AnimationType.fadeIn:
        return animation.fadeIn(
          delay: !withAnimaitions ? null : widget.delay,
          duration: !withAnimaitions ? 0.ms : widget.duration,
        );
      case AnimationType.slideIn:
        return animation.slide(
          begin: const Offset(1, 0),
          delay: !withAnimaitions ? null : widget.delay,
          duration: !withAnimaitions ? 0.ms : widget.duration,
        );
      case AnimationType.scale:
        return animation.scale(
          delay: !withAnimaitions ? null : widget.delay,
          duration: !withAnimaitions ? 0.ms : widget.duration,
        );
      // agrega más tipos aquí
    }
  }
}

enum AnimationType { fadeIn, slideIn, scale /* etc */ }
