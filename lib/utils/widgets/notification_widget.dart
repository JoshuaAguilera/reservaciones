import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';

import '../../models/notificacion_model.dart';
import '../../res/helpers/animation_helpers.dart';
import '../../res/helpers/colors_helpers.dart';
import '../../res/helpers/date_helpers.dart';
import '../../res/helpers/general_helpers.dart';
import '../../res/helpers/icon_helpers.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/custom_widgets.dart';
import '../../res/ui/message_error_scroll.dart';
import '../../res/ui/page_base.dart';
import '../../res/ui/progress_indicator.dart';
import '../../res/ui/text_styles.dart';
import '../../view-models/providers/notificacion_provider.dart';
import '../../view-models/providers/ui_provider.dart';

class NotificationWidget extends ConsumerStatefulWidget {
  const NotificationWidget({
    super.key,
  });

  @override
  ConsumerState<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends ConsumerState<NotificationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: GeneralHelpers.clampSize(720.w, min: 275, max: 400),
      height: MediaQuery.of(context).size.height,
      child: AnimatedEntry(
        duration: const Duration(milliseconds: 150),
        type: AnimationType.slideX,
        child: PageBase(
          padH: 20,
          padV: 20,
          spacing: 0,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.cardTitleText(text: "Notificaciones"),
                        AppText.simpleText(
                          text: "Aquí puedes ver todas tus notificaciones.",
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      ref.read(showNotificationsProvider.notifier).state =
                          false;
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                width: GeneralHelpers.clampSize(720.w, min: 255, max: 380),
                child: Consumer(builder: (context, ref, _) {
                  final keyList = ref.watch(keyNotListProvider);
                  final updateList =
                      ref.watch(updateViewNotificationListProvider);

                  return RiverPagedBuilder<int, Notificacion>(
                    key: ValueKey(keyList + updateList),
                    firstPageKey: 1,
                    provider: notificacionesProvider(""),
                    itemBuilder: (context, item, index) => _NotificationItem(
                      notificacion: item,
                    ),
                    pagedBuilder: (controller, builder) {
                      return PagedListView(
                        pagingController: controller,
                        builderDelegate: builder,
                      );
                    },
                    firstPageErrorIndicatorBuilder: (_, __) {
                      return SizedBox(
                        height: 280,
                        child: CustomWidgets.messageNotResult(
                          delay: const Duration(milliseconds: 1250),
                        ),
                      );
                    },
                    limit: 20,
                    noMoreItemsIndicatorBuilder: (context, controller) {
                      return MessageErrorScroll.messageNotFound();
                    },
                    noItemsFoundIndicatorBuilder: (_, __) {
                      return const MessageErrorScroll(
                        icon: Iconsax.direct_normal_outline,
                        title: 'No se encontraron notificaciones',
                        message: 'No tienes notificaciones pendientes.',
                      );
                    },
                    newPageProgressIndicatorBuilder: (context, controller) {
                      return ProgressIndicatorCustom(screenHeight: 310);
                    },
                    firstPageProgressIndicatorBuilder: (context, controller) {
                      return ProgressIndicatorCustom(screenHeight: 310);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatefulWidget {
  const _NotificationItem({required this.notificacion});
  final Notificacion notificacion;

  @override
  State<_NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<_NotificationItem> {
  bool isExpanded = false;
  bool isReaded = false;

  @override
  void initState() {
    super.initState();
    isReaded = widget.notificacion.estatus == 'Leido';
  }

  @override
  Widget build(BuildContext context) {
    Color getColorNotification(NotificationType? tipo) {
      return ColorsHelpers.getColorNotification(tipo);
    }

    final contentColor = getColorNotification(widget.notificacion.tipo);
    final iconColor = ColorsHelpers.darken(contentColor, 0.05);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isExpanded ? 5 : 3),
      child: ListTileTheme(
        minVerticalPadding: 0,
        child: Opacity(
          opacity: (!isExpanded && isReaded) ? 0.7 : 1,
          child: ExpansionTile(
            showTrailingIcon: false,
            initiallyExpanded: isExpanded,
            tilePadding: const EdgeInsets.all(0),
            shape: ContinuousRectangleBorder(
              side: BorderSide(
                width: 4,
                color: isExpanded
                    ? contentColor
                    : Theme.of(context).scaffoldBackgroundColor,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            onExpansionChanged: (value) {
              isExpanded = value;
              setState(() {});
            },
            title: Container(
              decoration: BoxDecoration(
                gradient: isExpanded
                    ? null
                    : LinearGradient(
                        colors: [
                          contentColor,
                          ColorsHelpers.darken(contentColor, -0.2)
                        ],
                        end: Alignment.centerRight,
                        begin: Alignment.center,
                      ),
                borderRadius: BorderRadius.circular(6),
                color: isExpanded
                    ? Theme.of(context).scaffoldBackgroundColor
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: ListTile(
                      minTileHeight: 0,
                      title: AppText.listTitleText(
                        text: widget.notificacion.title ?? '',
                        color: isExpanded ? null : Colors.white,
                      ),
                      subtitle: AppText.listBodyText(
                        text:
                            "Hace ${DateHelpers.getCountDate(widget.notificacion.createdAt)} ${isReaded ? "(leído)" : ""}",
                        color: isExpanded ? null : Colors.white,
                      ),
                    ),
                  ),
                  Icon(
                    IconHelpers.getIconNavbar(widget.notificacion.tipo
                            ?.toString()
                            .split('.')
                            .last) ??
                        CupertinoIcons.bell,
                    color: iconColor,
                    size: GeneralHelpers.clampSize(100.w, min: 25, max: 65),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Icon(
                      isExpanded
                          ? Iconsax.arrow_up_outline
                          : Iconsax.arrow_bottom_outline,
                      color: iconColor,
                    ),
                  ),
                ],
              ),
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.fromLTRB(15, 2, 15, 12),
            children: [
              AppText.simpleText(
                text: widget.notificacion.message ?? '',
                overflow: TextOverflow.clip,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 30,
                child: Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Buttons.buttonPrimary(
                        text: "Ver detalles",
                        backgroundColor: contentColor,
                        icon: Iconsax.arrow_right_4_outline,
                        padVer: 0,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: Buttons.buttonSecundary(
                        text: "Descartar",
                        icon: Iconsax.close_circle_outline,
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
