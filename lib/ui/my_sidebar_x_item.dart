import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/desktop_colors.dart';
import 'package:sidebarx/sidebarx.dart';

class MySidebarXItem extends StatefulWidget {
  const MySidebarXItem({
    super.key,
    this.onTap,
    required this.controller,
    required this.selectIndex,
    this.children,
    this.icon,
    this.label,
    this.tooltip = '',
  });

  final void Function()? onTap;
  final SidebarXController controller;
  final int selectIndex;
  final List<Widget>? children;
  final IconData? icon;
  final String? label;
  final String tooltip;

  @override
  State<MySidebarXItem> createState() => _MySidebarXItemState();
}

class _MySidebarXItemState extends State<MySidebarXItem>
    with SingleTickerProviderStateMixin {
  bool horeved = false;
  AnimationController? _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Durations.short4,
    );
    if (widget.controller.extended) {
      _animationController?.forward();
    } else {
      _animationController?.reverse();
    }
    widget.controller.extendStream.listen(
      (extended) {
        if (_animationController?.isCompleted ?? false) {
          _animationController?.reverse();
        } else {
          _animationController?.forward();
        }
      },
    );

    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => horeved = true),
      onExit: (event) => setState(() => horeved = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Tooltip(
          message: widget.tooltip,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: widget.controller.selectedIndex == widget.selectIndex
                  ? BoxDecoration(
                      border: Border.all(
                        color: DesktopColors.actionColor.withOpacity(0.37),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          DesktopColors.accentCanvasColor,
                          DesktopColors.canvasColor
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.28),
                          blurRadius: 30,
                        )
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    )
                  : horeved
                      ? BoxDecoration(
                          color: DesktopColors.accentCanvasColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        )
                      : null,
              child: Row(
                mainAxisAlignment: widget.controller.extended
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: widget.children ??
                    [
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, _) {
                          final value = ((1 - _animation.value) * 6).toInt();
                          if (value <= 0) {
                            return const SizedBox();
                          }
                          return Spacer(flex: value);
                        },
                      ),
                      Icon(
                        widget.icon,
                        color: (horeved ||
                                widget.controller.selectedIndex ==
                                    widget.selectIndex)
                            ? Colors.white
                            : Colors.white.withOpacity(0.7),
                        size: 23,
                      ),
                      Flexible(
                        flex: 6,
                        child: FadeTransition(
                          opacity: _animation,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              widget.label ?? '',
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: horeved
                                  ? const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.5,
                                      fontFamily: "poppins_regular",
                                    )
                                  : TextStyle(
                                      color: widget.controller.selectedIndex ==
                                              widget.selectIndex
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.7),
                                      fontFamily: "poppins_regular",
                                      fontSize: 12,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }
}
