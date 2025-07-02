import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/view-models/providers/tarifario_provider.dart';
import 'package:generador_formato/view-models/services/tarifa_service.dart';
import 'package:generador_formato/res/helpers/constants.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';
import 'package:generador_formato/utils/shared_preferences/settings.dart';
import 'package:intl/intl.dart';

import '../../models/temporada_model.dart';
import '../../res/ui/custom_widgets.dart';
import '../../res/ui/progress_indicator.dart';
import '../../res/ui/show_snackbar.dart';
import '../../res/helpers/utility.dart';
import '../../utils/widgets/item_rows.dart';
import '../../res/ui/text_styles.dart';

class CalendarControllerWidget extends ConsumerStatefulWidget {
  final bool target;
  final bool inMenu;
  final void Function()? onTarget;
  final bool isMonthView;
  final DateTime initDayWeek;
  final bool startFlow;
  final void Function(DateTime)? onChangeDate;
  final void Function(bool)? onStartflow;
  final bool onExpandedSidebar;
  final bool viewWeek;
  final bool viewMonth;
  final bool viewYear;
  final PageController pageMonthController;
  final void Function()? onCreated;

  const CalendarControllerWidget({
    super.key,
    required this.target,
    required this.onTarget,
    required this.inMenu,
    required this.isMonthView,
    required this.initDayWeek,
    required this.startFlow,
    required this.onChangeDate,
    required this.onStartflow,
    required this.onExpandedSidebar,
    required this.viewWeek,
    required this.viewMonth,
    required this.viewYear,
    required this.pageMonthController,
    required this.onCreated,
  });

  @override
  _ControllerCalendarWidgetState createState() =>
      _ControllerCalendarWidgetState();
}

class _ControllerCalendarWidgetState
    extends ConsumerState<CalendarControllerWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final listTarifasProvider = ref.watch(listTarifaProvider(""));
    final tarifasProvider = ref.watch(allTarifaProvider(""));
    final dateTariffer = ref.watch(dateTarifferProvider);
    final pageWeek = ref.watch(pageWeekControllerProvider);

    return SizedBox(
      width: screenWidth > 875
          ? screenWidth > 950
              ? 350
              : screenWidth * 0.34
          : 300,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: screenHeight - 210,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: (screenWidth > 1280) ? 10 : 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextStyles.standardText(
                                  text: "Gestor de tarifas",
                                  isBold: true,
                                  color: Theme.of(context).primaryColor,
                                  size: 14,
                                ),
                              ),
                            ),
                            if (screenWidth < 1280)
                              IconButton(
                                onPressed: () {
                                  widget.onTarget!.call();
                                },
                                icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded),
                              ),
                          ],
                        ),
                      ),
                      if (widget.viewYear)
                        SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              _buildHeaderMonth(dateTariffer),
                              SizedBox(
                                height: 5,
                                width: double.infinity,
                                child: PageView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: pageWeek,
                                  itemCount: 12 * 12,
                                  itemBuilder: (context, pageIndex) {
                                    return const SizedBox();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (widget.viewMonth)
                        SizedBox(
                          height: 380,
                          width: 300,
                          child: Column(
                            children: [
                              _buildHeaderMonth(dateTariffer),
                              const Divider(height: 5),
                              Expanded(
                                child: PageView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 10,
                                  itemBuilder: (context, pageIndex) {
                                    return _buildMonth(dateTariffer);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5,
                                width: double.infinity,
                                child: PageView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: pageWeek,
                                  itemCount: 12 * 12,
                                  itemBuilder: (context, pageIndex) {
                                    return const SizedBox();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (widget.viewWeek)
                        SizedBox(
                          height: 420,
                          child: Column(
                            children: [
                              _buildHeaderMonth(dateTariffer,
                                  verticalPadding: 0),
                              _buildHeaderWeek(dateTariffer, pageWeek),
                              const Divider(height: 5),
                              _buildWeeks(),
                              Expanded(
                                child: PageView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: pageWeek,
                                  onPageChanged: (index) {
                                    ref
                                        .watch(dateTarifferProvider.notifier)
                                        .update(
                                          (state) => DateTime(
                                            dateTariffer.year,
                                            index + 1,
                                            1,
                                          ),
                                        );
                                  },
                                  itemCount: 12 * 12,
                                  itemBuilder: (context, pageIndex) {
                                    DateTime month = DateTime(dateTariffer.year,
                                        (pageIndex % 12) + 1, 1);
                                    return buildCalendarMonth(
                                        month,
                                        widget.initDayWeek
                                            .subtract(const Duration(days: 1)));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ExpansionTile(
                        initiallyExpanded: true,
                        collapsedShape: Border(
                            top: BorderSide(
                                color: Theme.of(context).dividerColor)),
                        title: IconButton(
                          icon: const Icon(Icons.add_circle_rounded),
                          tooltip: "Crear tarifa",
                          onPressed: () {
                            ref
                                .read(editTarifaProvider.notifier)
                                .update((state) => RegistroTarifa());
                            ref
                                .read(temporadasIndividualesProvider.notifier)
                                .update(
                                  (state) => [
                                    Temporada(
                                        nombre: "DIRECTO", editable: false),
                                    Temporada(nombre: "BAR I", editable: false),
                                    Temporada(
                                        nombre: "BAR II", editable: false),
                                  ],
                                );
                            ref
                                .read(temporadasGrupalesProvider.notifier)
                                .update((state) => []);
                            ref
                                .read(temporadasEfectivoProvider.notifier)
                                .update((state) => []);
                            widget.onCreated!.call();
                          },
                        ),
                        leading: SizedBox(
                          width: 175,
                          child: TextStyles.standardText(
                            text: "Tarifas disponibles",
                            isBold: true,
                            color: Theme.of(context).primaryColor,
                            size: 14,
                          ),
                        ),
                        children: [
                          tarifasProvider.when(
                            data: (list) {
                              if (list.isEmpty) {
                                return SizedBox(
                                  height: 150,
                                  child: CustomWidgets.messageNotResult(
                                      context: context, sizeImage: 100),
                                );
                              } else {
                                return listTarifasProvider.when(
                                  data: (list) {
                                    return SizedBox(
                                      width: screenWidth,
                                      height: Utility.limitHeightList(
                                        list.length,
                                        6,
                                        widget.viewWeek
                                            ? 255
                                            : widget.viewYear
                                                ? 620
                                                : 300,
                                      ),
                                      child: ListView.builder(
                                        itemCount: list.length,
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return ItemRows.tarifaItemRow(
                                            context,
                                            tarifaRack: list[index],
                                            onEdit: () {
                                              ref
                                                  .read(
                                                      temporadasIndividualesProvider
                                                          .notifier)
                                                  .update((state) =>
                                                      list[index]
                                                          .temporadas
                                                          ?.where((element) =>
                                                              ((element.forGroup ??
                                                                      false) ==
                                                                  false) &&
                                                              ((element.forCash ??
                                                                      false) ==
                                                                  false))
                                                          .toList()
                                                          .map((e) =>
                                                              e.copyWith())
                                                          .toList() ??
                                                      List<Temporada>.empty());
                                              ref
                                                  .read(
                                                      temporadasGrupalesProvider
                                                          .notifier)
                                                  .update((state) =>
                                                      list[index]
                                                          .temporadas
                                                          ?.where((element) =>
                                                              element
                                                                  .forGroup ??
                                                              false)
                                                          .toList()
                                                          .map((e) =>
                                                              e.copyWith())
                                                          .toList() ??
                                                      List<Temporada>.empty());

                                              ref
                                                  .read(
                                                      temporadasEfectivoProvider
                                                          .notifier)
                                                  .update((state) =>
                                                      list[index]
                                                          .temporadas
                                                          ?.where((element) =>
                                                              element.forCash ??
                                                              false)
                                                          .toList()
                                                          .map((e) =>
                                                              e.copyWith())
                                                          .toList() ??
                                                      List<Temporada>.empty());
                                              ref
                                                  .read(editTarifaProvider
                                                      .notifier)
                                                  .update((state) =>
                                                      list[index].copyWith());

                                              widget.onCreated!.call();
                                            },
                                            onDelete: () async {
                                              bool isSaves =
                                                  await TarifaService()
                                                      .deleteTarifaRack(
                                                          list[index]);

                                              if (isSaves) {
                                                showSnackBar(
                                                  context: context,
                                                  title: "Tarifa Eliminada",
                                                  message:
                                                      "La tarifa fue eliminada exitosamente.",
                                                  type: "success",
                                                  iconCustom: Icons.delete,
                                                );

                                                Future.delayed(
                                                  500.ms,
                                                  () {
                                                    ref
                                                        .read(
                                                            changeTarifasProvider
                                                                .notifier)
                                                        .update((state) =>
                                                            UniqueKey()
                                                                .hashCode);
                                                  },
                                                );
                                              } else {
                                                if (mounted) return;
                                                showSnackBar(
                                                    context: context,
                                                    title:
                                                        "Error de eliminación",
                                                    message:
                                                        "Se detecto un error al intentar eliminar la tarifa. Intentelo más tarde.",
                                                    type: "danger");
                                                return;
                                              }
                                            },
                                            onChangedSelect: (p0) {
                                              setState(() =>
                                                  list[index].isSelected = p0);
                                              ref
                                                  .read(
                                                      changeTarifasListProvider
                                                          .notifier)
                                                  .update((state) =>
                                                      UniqueKey().hashCode);
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  error: (error, stackTrace) {
                                    return const SizedBox();
                                  },
                                  loading: () {
                                    return const SizedBox();
                                  },
                                );
                              }
                            },
                            error: (error, stackTrace) {
                              return SizedBox(
                                height: 150,
                                child: CustomWidgets.messageNotResult(
                                    context: context, sizeImage: 100),
                              );
                            },
                            loading: () {
                              return SizedBox(
                                height: 150,
                                child: ProgressIndicatorCustom(
                                  screenHight: 5,
                                  sizeProgressIndicator: 25,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextStyles.standardText(
                          text: "Ultima modificación:",
                          color: Theme.of(context).primaryColor),
                    ),
                    Expanded(
                      child: TextStyles.standardText(
                        text: Utility.getCompleteDate(
                                data: DateTime.now(), onlyNameDate: true)
                            .replaceAll(r' ', ''),
                        color: Theme.of(context).dividerColor,
                        align: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(
            delay: !Settings.applyAnimations
                ? null
                : !widget.startFlow
                    ? 1200.ms
                    : 0.ms,
            onComplete: (controller) => setState(() {
                  widget.onStartflow!.call(true);
                }),
            target: (screenWidth > 1280)
                ? 1
                : !widget.target
                    ? 1
                    : 0)
        .slideX(
          begin: -0.2,
          duration: Settings.applyAnimations ? 550.ms : 0.ms,
        )
        .fadeIn(
          delay: !Settings.applyAnimations
              ? null
              : widget.target
                  ? 0.ms
                  : 400.ms,
          duration: Settings.applyAnimations ? null : 0.ms,
        );
  }

  Widget _buildHeaderWeek(
    DateTime dateTariffer,
    PageController pageWeek,
  ) {
    bool isLastMonthOfYear = dateTariffer.month == 12;
    bool isFirstMonthOfYear = dateTariffer.month == 1;
    Intl.defaultLocale = "es_ES";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isFirstMonthOfYear)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                if (pageWeek.page! > 0) {
                  pageWeek.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );

                  ref.watch(pageWeekControllerProvider.notifier).update(
                      (state) =>
                          PageController(initialPage: dateTariffer.month - 2));
                }
              },
            )
          else
            const SizedBox(width: 36),
          TextStyles.titleText(
            text: DateFormat('MMMM')
                    .format(dateTariffer)
                    .substring(0, 1)
                    .toUpperCase() +
                DateFormat('MMMM').format(dateTariffer).substring(1),
            color: Theme.of(context).primaryColor,
            size: 16,
          ),
          if (!isLastMonthOfYear)
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                if (!isLastMonthOfYear) {
                  pageWeek.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );

                  ref.watch(pageWeekControllerProvider.notifier).update(
                      (state) =>
                          PageController(initialPage: dateTariffer.month));
                }
              },
            )
          else
            const SizedBox(width: 36),
        ],
      ),
    );
  }

  Widget _buildHeaderMonth(DateTime dateTariffer,
      {double verticalPadding = 8.0}) {
    Intl.defaultLocale = "es_ES";
    int yearNowStatic = DateTime.now().year - 1;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              ref.watch(monthNotifierProvider.notifier).disguice();

              ref.watch(pageWeekControllerProvider.notifier).update(
                    (state) => PageController(
                      initialPage:
                          ref.watch(pageWeekControllerProvider).initialPage,
                    ),
                  );

              Future.delayed(
                Durations.medium4,
                () {
                  ref.watch(dateTarifferProvider.notifier).update(
                        (state) => DateTime(
                          dateTariffer.year - 1,
                          dateTariffer.month,
                          dateTariffer.day,
                        ),
                      );
                },
              );

              ref.watch(monthNotifierProvider.notifier).reveal();
            },
          ),
          TextStyles.titleText(
              text: dateTariffer.year.toString(),
              color: Theme.of(context).primaryColor,
              size: 16),
          if (dateTariffer.year < (yearNowStatic + 11))
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                ref.watch(monthNotifierProvider.notifier).disguice();

                ref.watch(pageWeekControllerProvider.notifier).update(
                      (state) => PageController(
                        initialPage:
                            ref.watch(pageWeekControllerProvider).initialPage,
                      ),
                    );

                Future.delayed(
                  Durations.medium4,
                  () {
                    ref.watch(dateTarifferProvider.notifier).update(
                          (state) => DateTime(
                            dateTariffer.year + 1,
                            dateTariffer.month,
                            dateTariffer.day,
                          ),
                        );
                  },
                );

                ref.watch(monthNotifierProvider.notifier).reveal();
              },
            )
          else
            const SizedBox(width: 36),
        ],
      ),
    );
  }

  Widget _buildWeeks() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWeekDay('Lun'),
          _buildWeekDay('Mar'),
          _buildWeekDay('Mie'),
          _buildWeekDay('Jue'),
          _buildWeekDay('Vie'),
          _buildWeekDay('Sab'),
          _buildWeekDay('Dom'),
        ],
      ),
    );
  }

  Widget _buildWeekDay(String day) {
    return Center(
      child: TextStyles.standardText(
          text: day, isBold: true, color: Theme.of(context).primaryColor),
    );
  }

  Widget buildCalendarMonth(DateTime month, DateTime initDayWeek) {
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    DateTime lastDayOfPreviousMonth =
        firstDayOfMonth.subtract(const Duration(days: 1));
    int daysInPreviousMonth = lastDayOfPreviousMonth.day;

    int lastDayOfMonth = 7 - DateTime(month.year, month.month + 1, 0).weekday;

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: (daysInMonth + weekdayOfFirstDay - 1) + lastDayOfMonth,
      itemBuilder: (context, index) {
        if (index < weekdayOfFirstDay - 1) {
          int previousMonthDay =
              daysInPreviousMonth - (weekdayOfFirstDay - index) + 2;
          return ((initDayWeek
                          .difference(DateTime(
                                  month.year, month.month - 1, previousMonthDay)
                              .add(const Duration(days: 1)))
                          .inDays
                          .isNegative &&
                      !initDayWeek
                          .add(const Duration(days: 6))
                          .difference(DateTime(
                              month.year, month.month - 1, previousMonthDay))
                          .inDays
                          .isNegative) ||
                  widget.isMonthView)
              ? Opacity(
                  opacity: 0.5,
                  child: Card(
                    elevation: 3.5,
                    color: Colors.green[300],
                    child: Center(
                      child: Text(
                        previousMonthDay.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  child: Text(
                    previousMonthDay.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
        } else if (index < daysInMonth + weekdayOfFirstDay - 1) {
          // Displaying the current month's days
          DateTime date =
              DateTime(month.year, month.month, index - weekdayOfFirstDay + 2);
          int text = date.day;

          return InkWell(
            onTap: () {
              DateTime selectDate = DateTime(month.year, month.month, text);
              int weekdaySelect = selectDate.weekday;
              DateTime initWeekSelect =
                  selectDate.subtract(Duration(days: weekdaySelect - 1));

              // widget.initDayWeek = initWeekSelect;
              widget.onChangeDate!.call(initWeekSelect);
              setState(() {});
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if ((initDayWeek
                            .difference(DateTime(month.year, month.month, text)
                                .add(const Duration(days: 0)))
                            .inDays
                            .isNegative &&
                        !initDayWeek
                            .add(const Duration(days: 7))
                            .difference(DateTime(month.year, month.month, text))
                            .inDays
                            .isNegative) ||
                    widget.isMonthView)
                  Expanded(
                    child: Card(
                      elevation: 3.5,
                      color: Colors.green[300],
                      child: Center(
                        child: Text(
                          text.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        text.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        } else {
          return ((initDayWeek
                          .difference(DateTime(
                                  month.year,
                                  month.month + 1,
                                  (index -
                                      (daysInMonth + weekdayOfFirstDay - 2)))
                              .add(const Duration(days: 0)))
                          .inDays
                          .isNegative &&
                      !initDayWeek
                          .add(const Duration(days: 7))
                          .difference(DateTime(month.year, month.month + 1,
                              (index - (daysInMonth + weekdayOfFirstDay - 2))))
                          .inDays
                          .isNegative) ||
                  widget.isMonthView)
              ? Opacity(
                  opacity: 0.5,
                  child: Card(
                    elevation: 3.5,
                    color: Colors.green[300],
                    child: Center(
                      child: Text(
                        (index - (daysInMonth + weekdayOfFirstDay - 2))
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(),
                  alignment: Alignment.center,
                  child: Text(
                    (index - (daysInMonth + weekdayOfFirstDay - 2)).toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
        }
      },
    );
  }

  Widget _buildMonth(DateTime dateTariffer) {
    return GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.3),
        itemCount: 12,
        itemBuilder: (context, index) {
          return Card(
            color: (index == (dateTariffer.month - 1))
                ? DesktopColors.ceruleanOscure
                : DesktopColors.cerulean,
            elevation: 10,
            child: InkWell(
              onTap: () {
                if ((dateTariffer.month - 1) == index) return;

                ref.watch(monthNotifierProvider.notifier).disguice();

                ref.watch(pageWeekControllerProvider.notifier).update(
                      (state) => PageController(initialPage: index),
                    );

                ref.watch(dateTarifferProvider.notifier).update(
                    (state) => DateTime(dateTariffer.year, index + 1, 1));

                ref.watch(monthNotifierProvider.notifier).reveal();
              },
              child: Center(
                child: TextStyles.standardText(
                  text: monthNames[index],
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }
}
