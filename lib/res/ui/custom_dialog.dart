import 'package:flutter/material.dart';

import '../helpers/functions_ui.dart';
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
          title: Row(
            spacing: 10,
            children: [
              widget.iconWidget ??
                  (widget.icon != null ? Icon(widget.icon) : SizedBox()),
              Align(
                child: TextStyles.standardText(
                  text: widget.title,
                  size: 18,
                  height: 1,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: constraints.maxWidth * 0.65,
            child: widget.content ??
                TextStyles.standardText(
                  text: widget.contentString ?? '',
                  overflow: TextOverflow.clip,
                ),
          ),
          actions: [
            if (widget.withButtonSecondary)
              TextButton(
                onPressed: (widget.withLoadingProcess && loadingProcess)
                    ? null
                    : () {
                        applyUnfocus();
                        Navigator.pop(context);
                      },
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(
                    Theme.of(context).iconTheme.color,
                  ),
                ),
                child: TextStyles.standardText(
                  text: widget.nameButton2,
                ),
              ),
            SizedBox(
              height: 35,
              child: Buttons.buttonSecundary(
                text: widget.nameButton1,
                sizeText: 14,
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
            ),
          ],
        );
      },
    );
  }
}
