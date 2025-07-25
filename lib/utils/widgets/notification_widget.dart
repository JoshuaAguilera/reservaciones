import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';

import '../../models/notificacion_model.dart';
import '../../res/helpers/colors_helpers.dart';
import '../../res/helpers/desktop_colors.dart';
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
  Widget build(BuildContext context) {
    return Container(
      width: GeneralHelpers.clampSize(240.w, min: 275, max: 450),
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).cardColor,
      child: PageBase(
        padH: 20,
        padV: 20,
        spacing: 0,
        children: [
          Row(
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
              Buttons.floatingButton(
                context,
                toolTip: "Cerrar",
                tag: "close-notification",
                icon: Icons.close_rounded,
                onPressed: () {
                  ref.read(showNotificationsProvider.notifier).state = false;
                },
              ),
            ],
          ),
          SizedBox(
            height: 350,
            width: 280,
            child: Consumer(builder: (context, ref, _) {
              final keyList = ref.watch(keyNotListProvider);
              final updateList = ref.watch(updateViewNotificationListProvider);

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
                  return ProgressIndicatorCustom(screenHight: 310);
                },
                firstPageProgressIndicatorBuilder: (context, controller) {
                  return ProgressIndicatorCustom(screenHight: 310);
                },
              );
            }),
          ),
        ],
      ),
    ).animate().fadeIn(
          begin: 1,
          duration: 20.seconds,
        );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({required this.notificacion});

  final Notificacion notificacion;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getColorNotification(notificacion.mensaje ?? ''),
            ColorsHelpers.darken(
                _getColorNotification(notificacion.mensaje ?? ''), -0.15)
          ],
          end: Alignment.centerRight,
          begin: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Icon(
              IconHelpers.getIconNavbar(notificacion.tipo) ??
                  CupertinoIcons.bell,
              color: ColorsHelpers.darken(
                  _getColorNotification(notificacion.mensaje ?? ''), 0.05),
              size: 80,
            ),
          ),
          ListTile(
            title: AppText.listTitleText(
              text: notificacion.mensaje ?? '',
              color: Colors.white,
            ),
            subtitle: AppText.listBodyText(
              text: (notificacion.createdAt ?? DateTime.now()).toString(),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

Color _getColorNotification(String level) {
  switch (level) {
    case "info":
      return DesktopColors.notNormal;
    case "alert":
      return DesktopColors.cotGrupal;
    case "danger":
      return DesktopColors.notDanger;
    case "success":
      return DesktopColors.notSuccess;
    default:
      return DesktopColors.notNormal;
  }
}
