import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/functions_ui.dart';
import '../helpers/general_helpers.dart';
import 'buttons.dart';
import 'text_styles.dart';

class CustomDialog extends StatefulWidget {
  final Widget? iconWidget;
  final IconData? icon;
  final bool withIcon;
  final String title;
  final Widget? content;
  final String? contentString;
  final String nameButton1;
  final void Function()? funtion1;
  final String nameButton2;
  final bool withButtonSecondary;
  final bool notCloseInstant;
  final bool withLoadingProcess;

  const CustomDialog({
    super.key,
    this.icon,
    this.iconWidget,
    this.withIcon = false,
    required this.title,
    this.content,
    this.contentString,
    this.nameButton1 = 'Aceptar',
    required this.funtion1,
    this.nameButton2 = 'Cancelar',
    this.withButtonSecondary = false,
    this.notCloseInstant = false,
    this.withLoadingProcess = false,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool loadingProcess = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          title: SizedBox(
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    if (widget.withIcon)
                      widget.iconWidget ??
                          (widget.icon != null
                              ? Icon(widget.icon)
                              : const SizedBox()),
                    Align(
                      child: AppText.cardTitleText(text: widget.title),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  visualDensity: const VisualDensity(vertical: -4),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          content: SizedBox(
            width: GeneralHelpers.clampSize(750.sp, min: 400, max: 600),
            child: widget.content ??
                AppText.simpleText(
                  text: widget.contentString ?? '',
                  overflow: TextOverflow.clip,
                ),
          ),
          actions: [
            if (widget.withButtonSecondary)
              Buttons.filterButton1(
                title: widget.nameButton2,
                onPressed: (widget.withLoadingProcess && loadingProcess)
                    ? null
                    : () {
                        applyUnfocus();
                        if (widget.withLoadingProcess) {
                          loadingProcess = true;
                          setState(() {});
                        }

                        if (!widget.notCloseInstant) {
                          Navigator.of(context).pop();
                        }
                      },
              ),
            Buttons.buttonSecundary(
              text: widget.nameButton1,
              compact: true,
              isLoading: loadingProcess,
              foregroundColor: Colors.white,
              backgroudColor: Theme.of(context).iconTheme.color,
              onPressed: () {
                applyUnfocus();
                if (widget.withLoadingProcess) {
                  loadingProcess = true;
                  setState(() {});
                }

                widget.funtion1!.call();
                if (!widget.notCloseInstant) Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
