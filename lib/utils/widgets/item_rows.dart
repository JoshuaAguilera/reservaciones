import 'dart:math' as math;

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/estadistica_model.dart';
import '../../models/tarifa_rack_model.dart';
import '../../models/tarifa_x_habitacion_model.dart';
import '../../res/helpers/animation_helpers.dart' as ah;
import '../../res/helpers/colors_helpers.dart';
import '../../res/helpers/date_helpers.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/helpers/icon_helpers.dart';
import '../../res/helpers/utility.dart';
import '../../res/ui/tools_ui.dart';
import '../../view-models/providers/ui_provider.dart';
import '../shared_preferences/settings.dart';
import 'card_animation_widget.dart';
import 'dialogs.dart';
import '../../res/ui/text_styles.dart';

class ItemRow {
  static Widget statisticsRow(
    List<Estadistica> list, {
    bool isLoading = false,
  }) {
    List<Widget> cards = [];
    for (var element in list) {
      cards.add(ItemRow.statisticRow(
        element,
        sizeText: 13.5,
        isLoading: isLoading,
      ));
    }

    return Wrap(runSpacing: 5, spacing: 14, children: cards);
  }

  static Widget statisticRow(
    Estadistica register, {
    double sizeText = 15,
    bool isLoading = false,
  }) {
    bool? status = register.numInitial == register.numNow
        ? null
        : register.numNow > register.numInitial;
    bool isQuest = (register.title ?? '').toLowerCase().contains("total");
    Color? backgroudColor = isQuest ? DesktopColors.primary6 : Colors.white;
    Color? foregroundColor = ColorsHelpers.getForegroundColor(backgroudColor);

    NumberFormat formatter = NumberFormat('00');
    String numeroFormateado = formatter.format(register.total ?? 0);

    IconData iconStatus = status == null
        ? Iconsax.minus_square_outline
        : !status
            ? Iconsax.arrow_down_1_outline
            : Iconsax.arrow_up_2_outline;

    return Builder(
      builder: (context) {
        final brightness =
            ThemeModelInheritedNotifier.of(context).theme.brightness;
        bool isDark = brightness == Brightness.dark;
        Color? foregroundColorSub = (status == null || isQuest)
            ? isDark
                ? null
                : foregroundColor
            : register.title == "Caducadas"
                ? DesktopColors.primary5
                : ColorsHelpers.getColorNavbar(status ? "success" : "danger");

        if (isDark && !isQuest) {
          foregroundColorSub =
              ColorsHelpers.darken(foregroundColorSub ?? Colors.white, -0.3);
        }

        Color? foregroundColorInt =
            (isDark && !isQuest) ? null : foregroundColor;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: !isQuest
                ? null
                : LinearGradient(
                    colors: ColorsHelpers.getGradientQuote(backgroudColor),
                    end: Alignment.centerRight,
                    begin: Alignment.centerLeft,
                    transform: const GradientRotation(math.pi / 0.28),
                  ),
            color: (!isDark && isQuest)
                ? backgroudColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          constraints: const BoxConstraints(minWidth: 170),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 9),
          height: 120,
          child: Stack(
            children: [
              Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        IconHelpers.getIconCardDashboard(register.title),
                        size: 30,
                        color: foregroundColorInt,
                      ),
                      Flexible(
                        child: AppText.sectionTitleText(
                          text: register.title ?? '',
                          color: foregroundColorInt,
                        ),
                      ),
                    ],
                  ),
                  Opacity(
                    opacity: !isLoading ? 1 : 0.5,
                    child: Row(
                      spacing: 5,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: AppText.styledText(
                            text: numeroFormateado,
                            size: 32,
                            color: foregroundColorInt,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isLoading)
                          LoadingAnimationWidget.twoRotatingArc(
                            size: 25,
                            color: foregroundColorInt ?? Colors.white,
                          ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: 5,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: foregroundColorSub ?? Colors.white,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Row(
                          spacing: 2,
                          children: [
                            Icon(
                              iconStatus,
                              size: 12,
                              color: foregroundColorSub,
                            ),
                            AppText.styledText(
                              text: register.difference()?.toString() ?? "0",
                              color: foregroundColorSub,
                              size: 10,
                              maxSize: 12,
                            ),
                          ],
                        ),
                      ),
                      AppText.styledText(
                        text: register.getStatusModifier(),
                        color: foregroundColorSub,
                        size: 10,
                        maxSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget dayRateRow({
    required BuildContext context,
    int day = 0,
    required bool inPeriod,
    DateTime? dateNow,
    required SidebarXController sideController,
    TarifaXHabitacion? tarifaXDia,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {},
        child: inPeriod
            ? SizedBox(
                width: double.infinity,
                height: 170,
                child: CardAnimationWidget(
                  key: UniqueKey(),
                  sideController: sideController,
                  tarifaXHabitacion: tarifaXDia!,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                height: 170,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 15,
                      child: (dateNow!.isSameDate(DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day)))
                          ? TextStyles.TextSpecial(
                                  day: day,
                                  subtitle: "",
                                  colorTitle: Colors.amber)
                              .animate(
                                  onPlay: (controller) => controller.repeat())
                              .shimmer(
                                delay:
                                    !Settings.applyAnimations ? null : 1800.ms,
                                duration:
                                    Settings.applyAnimations ? 1200.ms : 0.ms,
                              )
                              .shake(
                                hz: 4,
                                curve: Curves.easeInOutCubic,
                                duration:
                                    Settings.applyAnimations ? null : 0.ms,
                              )
                              .then(
                                delay:
                                    !Settings.applyAnimations ? null : 600.ms,
                                duration:
                                    Settings.applyAnimations ? null : 0.ms,
                              )
                          : TextStyles.TextSpecial(day: day, subtitle: ""),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  static Widget tarifaItemRow(
    BuildContext context, {
    TarifaRack? tarifaRack,
    void Function(bool?)? onChangedSelect,
    void Function()? onEdit,
    void Function()? onDelete,
  }) {
    return ListTile(
      leading: Checkbox(
        value: tarifaRack!.select,
        onChanged: onChangedSelect,
        activeColor: tarifaRack.color ?? Colors.amber,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
      ),
      title: TextStyles.standardText(
          text: tarifaRack.nombre ?? 'Unknow',
          color: Theme.of(context).primaryColor),
      trailing: PopupMenuButton<ListTileTitleAlignment>(
        position: PopupMenuPosition.under,
        tooltip: "Opciones",
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<ListTileTitleAlignment>>[
          PopupMenuItem<ListTileTitleAlignment>(
            value: ListTileTitleAlignment.threeLine,
            onTap: () {
              if (onEdit != null) {
                onEdit.call();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Iconsax.edit_outline, color: DesktopColors.mentaOscure),
                TextStyles.standardText(
                    text: "Editar", color: Theme.of(context).primaryColor)
              ],
            ),
          ),
          PopupMenuItem<ListTileTitleAlignment>(
            value: ListTileTitleAlignment.titleHeight,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialogs.customAlertDialog(
                  title: "Eliminar tarifa",
                  contentText:
                      "¿Desea eliminar la siguiente tarifa: ${tarifaRack.nombre}?",
                  nameButtonMain: "Aceptar",
                  funtionMain: () async {
                    onDelete!.call();
                  },
                  nameButtonCancel: "Cancelar",
                  withButtonCancel: true,
                  withLoadingProcess: true,
                  otherButton: true,
                  iconData: Icons.delete,
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(CupertinoIcons.delete, color: DesktopColors.cerulean),
                TextStyles.standardText(
                    text: "Eliminar", color: Theme.of(context).primaryColor)
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget tarifaCheckListItemRow({
    required TarifaRack rack,
    required double screenWidth,
    required void Function(TarifaRack)? onEdit,
    required void Function(TarifaRack)? onDelete,
    required String tarifaBase,
  }) {
    Color? colorText = useWhiteForeground(rack.color!)
        ? ColorsHelpers.darken(rack.color!, -0.4)
        : ColorsHelpers.darken(rack.color!, 0.4);
    Color? colorIcon = useWhiteForeground(rack.color!)
        ? ColorsHelpers.darken(rack.color!, -0.45)
        : ColorsHelpers.darken(rack.color!, 0.45);

    return SizedBox(
      width: 170,
      child: Card(
        elevation: 5,
        color: rack.color,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextStyles.standardText(
                  text: rack.nombre ?? '',
                  isBold: true,
                  color: colorText,
                ),
                TextStyles.TextAsociative(
                  "Estatus:  ",
                  Utility.defineStatusTariff(rack.periodos),
                  color: colorText,
                  boldInversed: true,
                ),
              ],
            ),
            trailing: Wrap(
              children: [
                IconButton(
                  onPressed: () => onEdit!.call(rack),
                  tooltip: "Editar",
                  icon: Icon(
                    Iconsax.edit_outline,
                    size: 30,
                    color: colorIcon,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () => onDelete!.call(rack),
                  tooltip: "Eliminar",
                  icon: Icon(
                    CupertinoIcons.delete,
                    size: 30,
                    color: colorIcon,
                  ),
                ),
              ],
            ),
            subtitle: Wrap(
              spacing: 20,
              children: [
                TextStyles.TextAsociative(
                  "Fecha de registro: ",
                  DateHelpers.getStringDate(data: rack.createdAt),
                  color: colorText,
                  size: 13,
                  boldInversed: true,
                ),
                TextStyles.TextAsociative(
                  "Tarifa base: ",
                  tarifaBase,
                  color: colorText,
                  size: 13,
                  boldInversed: true,
                ),

                TextStyles.TextAsociative(
                  "Dias de aplicación: ",
                  DateHelpers.getWeekDays(
                      rack.periodos?.firstOrNull?.diasActivo),
                  color: colorText,
                  size: 13,
                  boldInversed: true,
                ),
                // Wrap(
                //   spacing: 15,
                //   runSpacing: 10,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         TextStyles.standardText(
                //             text: "Tarifas Vista Reserva:",
                //             color: useWhiteForeground(registro.color!)
                //                 ? Colors.white
                //                 : Colors.black),
                //         const SizedBox(height: 4),
                //         Wrap(
                //           spacing: 7,
                //           runSpacing: 5,
                //           children: [
                //             tariffIndItemRow(
                //                 "SGL/DBL",
                //                 registro.tarifas!.first.tarifaAdultoSGLoDBL!,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "TPL",
                //                 registro.tarifas!.first.tarifaAdultoTPL,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "CPLE",
                //                 registro.tarifas!.first.tarifaAdultoCPLE,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "MEN 7-12",
                //                 registro.tarifas!.first.tarifaMenores7a12!,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "PAX ADIC",
                //                 registro.tarifas!.first.tarifaPaxAdicional!,
                //                 registro.color!),
                //           ],
                //         ),
                //       ],
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         TextStyles.standardText(
                //             text: "Tarifas Vista Parcial al Mar:",
                //             color: useWhiteForeground(registro.color!)
                //                 ? Colors.white
                //                 : Colors.black),
                //         const SizedBox(height: 4),
                //         Wrap(
                //           spacing: 7,
                //           runSpacing: 5,
                //           children: [
                //             tariffIndItemRow(
                //                 "SGL/DBL",
                //                 registro.tarifas![1].tarifaAdultoSGLoDBL!,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "TPL",
                //                 registro.tarifas![1].tarifaAdultoTPL,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "CPLE",
                //                 registro.tarifas![1].tarifaAdultoCPLE,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "MEN 7-12",
                //                 registro.tarifas![1].tarifaMenores7a12!,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "PAX ADIC",
                //                 registro.tarifas![1].tarifaPaxAdicional!,
                //                 registro.color!),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget tariffIndItemRow(String tipo, double? tarifa, Color color) {
    return Container(
      width: 135,
      padding: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: useWhiteForeground(color) ? Colors.white : Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Center(
        child: TextStyles.standardText(
            text: "$tipo: ${Utility.formatterNumber(tarifa ?? 0)}",
            color: useWhiteForeground(color) ? Colors.white : Colors.black),
      ),
    );
  }

  static Widget userTarifaItemRow(BuildContext context,
      {required String nameUser, required String rolUser}) {
    return ListTile(
      leading: Checkbox(
        value: true,
        onChanged: (value) {},
        activeColor: Colors.green[300],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
      ),
      trailing: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(CupertinoIcons.person_circle),
      ),
      title: TextStyles.standardText(
        text: nameUser,
        color: Theme.of(context).primaryColor,
      ),
      subtitle: TextStyles.standardText(
        text: rolUser,
        size: 11,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  static Widget getTitleDay({
    required int title,
    required String subTitle,
    required bool select,
    required int index,
    required Brightness brightness,
    bool withOutDay = false,
  }) {
    return Opacity(
      opacity: withOutDay
          ? 1
          : select
              ? 1
              : 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextStyles.TextSpecial(
            withOutDay: withOutDay,
            compact: true,
            day: title,
            subtitle: subTitle,
            sizeTitle: 34,
            sizeSubtitle: 16,
            colorTitle: brightness == Brightness.light
                ? DesktopColors.prussianBlue
                : DesktopColors.azulClaro,
            colorsubTitle: brightness == Brightness.light
                ? DesktopColors.prussianBlue
                : DesktopColors.azulClaro,
          )
              .animate(
                  delay: !Settings.applyAnimations ? null : (200.ms * index))
              .fadeIn(duration: !Settings.applyAnimations ? 0.ms : 400.ms)
              .scale(duration: !Settings.applyAnimations ? 0.ms : 500.ms),
          const SizedBox(height: 5),
          RotatedBox(
            quarterTurns: withOutDay ? 0 : 1,
            child: SizedBox(
              height: withOutDay ? 7 : null,
              width: withOutDay ? 100 : 12,
              child: const Divider(),
            ),
          )
              .animate(
                  delay: !Settings.applyAnimations ? null : (220.ms * index))
              .fadeIn(
                duration: Settings.applyAnimations ? null : 0.ms,
              ),
          if (select)
            Padding(
              padding: EdgeInsets.only(top: withOutDay ? 0 : 3),
              child: Icon(
                withOutDay ? Icons.keyboard_arrow_down : Icons.circle,
                color: Colors.amber,
                size: withOutDay ? 35 : 7.5,
              ),
            )
                .animate(
                    delay: !Settings.applyAnimations ? null : (220.ms * index))
                .fadeIn(
                  duration: Settings.applyAnimations ? null : 0.ms,
                )
                .scale(
                  duration: Settings.applyAnimations ? 500.ms : 0.ms,
                ),
        ],
      ),
    );
  }

  static Widget filterItemRow({
    required Color colorCard,
    DateTime? initDate,
    DateTime? lastDate,
    void Function()? onRemove,
    bool withDeleteButton = true,
    String title = "",
    bool withOutWidth = false,
    bool isSelect = true,
    Color? backgroundColor,
    double? sizeText,
    double width = 170,
  }) {
    return SizedBox(
      width: withOutWidth ? null : width,
      height: withDeleteButton ? null : 38,
      child: Card(
        color: isSelect ? colorCard : Colors.transparent,
        child: Container(
          decoration: isSelect
              ? null
              : BoxDecoration(
                  border: Border.all(
                      color: isSelect ? colorCard : Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: !withDeleteButton ? 6 : 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: withDeleteButton
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                if (withDeleteButton) const SizedBox(width: 7),
                TextStyles.standardText(
                  text: (initDate == null && lastDate == null)
                      ? title
                      : DateHelpers.getStringPeriod(
                          initDate: initDate!,
                          lastDate: lastDate!,
                        ),
                  color: useWhiteForeground(
                          isSelect ? colorCard : backgroundColor ?? colorCard)
                      ? isSelect
                          ? ColorsHelpers.darken(colorCard, -0.4)
                          : colorCard
                      : ColorsHelpers.darken(colorCard, 0.225),
                  size: sizeText ?? 13,
                ),
                if (withDeleteButton)
                  SizedBox(
                    width: 35,
                    height: 40,
                    child: IconButton(
                      onPressed: () {
                        onRemove!.call();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 25,
                        color: useWhiteForeground(isSelect
                                ? colorCard
                                : backgroundColor ?? colorCard)
                            ? isSelect
                                ? ColorsHelpers.darken(colorCard, -0.42)
                                : colorCard
                            : ColorsHelpers.darken(colorCard, 0.3),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget metricWidget(
    int index, {
    Metrica? metrica,
    bool isLoading = false,
  }) {
    List<Color> colors = DesktopColors.getPrimaryColors();
    int saveIndex = index % colors.length;
    final selectMetric = metrica ??
        Metrica(
          description: "Loading",
          initValue: 0,
          value: 0,
        );

    return Consumer(
      builder: (context, ref, _) {
        final screenWidth = MediaQuery.of(context).size.width;
        final sideController = ref.watch(sidebarControllerProvider);
        final realWidth = screenWidth - (sideController.extended ? 130 : 0);
        bool isExpanded = realWidth > 800;
        double maxValue = isLoading
            ? 100
            : (selectMetric.initValue ?? 0) < selectMetric.value
                ? selectMetric.value
                : selectMetric.initValue ?? 100;

        return SizedBox(
          height: 80,
          child: Card(
            color: Theme.of(context).cardTheme.color,
            child: Tooltip(
              message:
                  (isExpanded || isLoading) ? "" : metrica?.title ?? "unknow",
              margin: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: isExpanded
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 0,
                    child: SizedBox(
                      width: 80,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                color: (isLoading
                                        ? DesktopColors.grisPalido
                                        : colors[saveIndex])
                                    .withValues(alpha: .2),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(150),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: SfCircularChart(
                              palette: isLoading
                                  ? [DesktopColors.grisPalido]
                                  : [colors[saveIndex]],
                              series: <CircularSeries>[
                                RadialBarSeries<Metrica, String>(
                                  cornerStyle: CornerStyle.bothCurve,
                                  trackColor: Theme.of(context).cardColor,
                                  maximumValue: maxValue,
                                  innerRadius: "80%",
                                  dataSource: [selectMetric],
                                  xValueMapper: (Metrica data, _) =>
                                      data.description,
                                  yValueMapper: (Metrica data, _) =>
                                      isLoading ? 30 : data.value,
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: AppText.styledText(
                              text: isLoading
                                  ? "?%"
                                  : "${(metrica?.value.toInt())}${(metrica?.isPorcentage ?? false) ? "%" : ""}",
                              size: 14,
                              fontWeight: FontWeight.bold,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isExpanded)
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 8, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.listTitleText(
                              text: isLoading
                                  ? "Cargando..."
                                  : metrica?.title ?? "unknow",
                            ),
                            if (isLoading)
                              ah.AnimatedEntry(
                                type: ah.AnimationType.shimmer,
                                delay: const Duration(milliseconds: 2500),
                                duration: const Duration(milliseconds: 750),
                                child: Container(
                                  height: 16,
                                  margin: const EdgeInsets.only(top: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    color: DesktopColors.grisPalido,
                                  ),
                                ),
                              )
                            else
                              AppText.listBodyText(
                                text:
                                    "${metrica?.description ?? ""} ${metrica?.initValue?.round() ?? ""}",
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget itemRowCheckList(
    BuildContext context, {
    bool enable = true,
    String title = "",
    Widget? leadingWidget,
    IconData? icon,
    String description = '',
    String details = '',
    double height = 80,
    Color? color,
    double elevation = 0,
    double radius = 18,
    double sizeIcon = 38,
    double sizeDescription = 12,
    bool isThreeLine = true,
    bool hideTrailing = false,
    IconData? trailingIcon,
    Widget? trailingWidget,
    Widget? descriptionWidget,
    Widget? detailsWidget,
    double padTopLeading = 9,
    double? heightTitle,
    bool applyBoldDescription = false,
    bool showCheckBox = false,
    bool valueCheckBox = false,
    void Function()? onTap,
    void Function(bool?)? onChangedCheckBox,
    void Function()? onPressedEdit,
    void Function()? onPressedDelete,
    void Function()? onPressedDuplicate,
    void Function()? onPreseedTrailingIcon,
    List<PopupMenuEntry<ListTileTitleAlignment>>? customItems,
  }) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    Color colorItem = (color ?? DesktopColors.greyClean).withValues(
      alpha: brightness == Brightness.dark ? 0.5 : 1,
    );

    double bias = brightness == Brightness.dark ? 110 : 20;

    Color colorContent = useWhiteForeground(colorItem, bias: bias)
        ? Colors.white
        : Colors.black87;

    return ToolsUi.blockedWidget(
      isBloqued: !enable,
      child: Row(
        children: [
          if (showCheckBox)
            SizedBox(
              width: 30,
              child: Checkbox(
                value: valueCheckBox,
                activeColor: DesktopColors.buttonPrimary,
                onChanged: !enable ? null : onChangedCheckBox,
              ),
            ),
          Expanded(
            child: SizedBox(
              height: height,
              child: Card(
                color: colorItem,
                elevation: elevation,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 15, right: 4),
                  onTap: onTap,
                  leading: Padding(
                    padding: EdgeInsets.only(top: padTopLeading),
                    child: leadingWidget ??
                        Icon(
                          icon ?? Iconsax.unlimited_outline,
                          size: sizeIcon,
                          color: colorContent,
                        ),
                  ),
                  isThreeLine: isThreeLine,
                  title: title.isEmpty
                      ? null
                      : AppText.listTitleText(
                          text: title,
                          color: colorContent,
                        ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(right: hideTrailing ? 8 : 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: detailsWidget != null ? 3.5 : 0,
                      children: [
                        if (descriptionWidget != null)
                          descriptionWidget
                        else
                          AppText.listBodyText(
                            text: description,
                            color: colorContent,
                            fontWeight: applyBoldDescription
                                ? FontWeight.bold
                                : FontWeight.normal,
                            maxLines: details.isEmpty
                                ? 2
                                : title.isEmpty
                                    ? 2
                                    : 1,
                            height: 1.25,
                          ),
                        if (detailsWidget != null)
                          detailsWidget
                        else
                          AppText.listBodyText(
                            text: details,
                            color: colorContent,
                            maxLines: 1,
                            height: 1.25,
                          ),
                      ],
                    ),
                  ),
                  trailing: hideTrailing
                      ? null
                      : Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: (trailingIcon != null)
                              ? IconButton(
                                  icon: Icon(
                                    trailingIcon,
                                    size: 30,
                                    color: colorContent,
                                  ),
                                  onPressed:
                                      !enable ? null : onPreseedTrailingIcon,
                                )
                              : trailingWidget ??
                                  compactOptions(
                                    customItems: customItems,
                                    onPreseedEdit:
                                        !enable ? null : onPressedEdit,
                                    onPreseedDelete:
                                        !enable ? null : onPressedDelete,
                                    onPressedDuplicate:
                                        !enable ? null : onPressedDuplicate,
                                    colorIcon: colorContent,
                                  ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget compactOptions({
    void Function()? onPreseedEdit,
    void Function()? onPreseedDelete,
    void Function()? onPressedDuplicate,
    List<PopupMenuEntry<ListTileTitleAlignment>>? customItems,
    Color? colorIcon,
    bool diseablePad = false,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return PopupMenuButton<ListTileTitleAlignment>(
          iconColor: colorIcon,
          tooltip: "Opciones",
          padding:
              !diseablePad ? const EdgeInsets.all(8) : const EdgeInsets.all(0),
          itemBuilder: (BuildContext context) =>
              customItems ??
              <PopupMenuEntry<ListTileTitleAlignment>>[
                if (onPreseedEdit != null)
                  itemPopup(
                    "Detalles",
                    Iconsax.stickynote_outline,
                    onPreseedEdit,
                  ),
                if (onPressedDuplicate != null)
                  itemPopup(
                    "Duplicar",
                    Iconsax.copy_outline,
                    onPressedDuplicate,
                  ),
                if (onPreseedDelete != null)
                  itemPopup(
                    "Eliminar",
                    Iconsax.trash_outline,
                    onPreseedDelete,
                  ),
              ],
        );
      },
    );
  }

  static PopupMenuItem<ListTileTitleAlignment> itemPopup(
      String name, IconData icon, void Function()? onTap) {
    return PopupMenuItem<ListTileTitleAlignment>(
      value: ListTileTitleAlignment.threeLine,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [Icon(icon), AppText.simpleText(text: name)],
      ),
    );
  }
}
