import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/periodo_model.dart';
import 'package:generador_formato/res/helpers/date_helpers.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

import '../../../res/helpers/colors_helpers.dart';
import '../../../res/ui/buttons.dart';
import '../../../res/ui/inside_snackbar.dart';
import '../../../res/ui/title_page.dart';
import '../../../res/helpers/desktop_colors.dart';
import '../../../res/ui/text_styles.dart';
import '../../../utils/widgets/textformfield_custom.dart';

class PeriodCalendarDialog extends StatefulWidget {
  const PeriodCalendarDialog({
    Key? key,
    required this.colorTariff,
    this.title,
    this.description,
    this.initDate,
    this.lastDate,
    this.withLimit = false,
    this.initYear,
  }) : super(key: key);

  final Color colorTariff;
  final String? title;
  final String? description;
  final DateTime? initDate;
  final DateTime? lastDate;
  final bool withLimit;
  final int? initYear;

  @override
  State<PeriodCalendarDialog> createState() => _PeriodCalendarDialogState();
}

class _PeriodCalendarDialogState extends State<PeriodCalendarDialog> {
  bool inProcess = false;
  DateTime? initDate;
  DateTime? lastDate;
  CleanCalendarController calendarController = CleanCalendarController(
    minDate: DateTime(DateTime.now().year),
    maxDate:
        DateTime(DateTime.now().year + 2).subtract(const Duration(days: 1)),
  );
  bool showError = false;

  @override
  void initState() {
    super.initState();
    initDate = widget.initDate;
    lastDate = widget.lastDate;
    setState(() {});

    calendarController = CleanCalendarController(
      initialDateSelected: widget.initDate,
      initialFocusDate: widget.initDate,
      endDateSelected: widget.lastDate,
      minDate: widget.withLimit
          ? DateTime.now()
          : (widget.initYear != null)
              ? DateTime(widget.initYear!)
              : DateTime(DateTime.now().year),
      maxDate: DateTime(DateTime.now().year + 2).subtract(
        const Duration(days: 1),
      ),
      onRangeSelected: (firstDate, secondDate) {
        initDate = firstDate;
        lastDate = secondDate;
        setState(() {});
      },
    );
  }

  void _toggleSnackbar() {
    setState(() => showError = true);
    Future.delayed(5.seconds, () {
      if (mounted) {
        setState(() => showError = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    double screenHight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        height: 650,
        width: 375,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitlePage(
                icons: HeroIcons.calendar_days,
                isDialog: true,
                title: widget.title ?? "Selección de periodo",
                subtitle: widget.description ??
                    "Determina los dias de implementación.",
              ),
              Divider(color: Theme.of(context).primaryColor, thickness: 0.6),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      height: screenHight > 675 ? 420 : screenHight * 0.58,
                      width: 350,
                      child: ScrollableCleanCalendar(
                        daySelectedBackgroundColorBetween:
                            ColorsHelpers.darken(widget.colorTariff, -0.3)
                                .withValues(alpha: 0.9),
                        daySelectedBackgroundColor: widget.colorTariff,
                        locale: "es",
                        calendarController: calendarController,
                        layout: Layout.BEAUTY,
                        calendarCrossAxisSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormFieldCustom
                              .textFormFieldwithBorderCalendar(
                            align: TextAlign.center,
                            compact: true,
                            withButton: false,
                            readOnly: true,
                            name:
                                "Fecha de ${widget.initDate != null ? "llegada" : "inicio"}",
                            dateController: TextEditingController(
                                text: initDate?.toIso8601String() ?? ""),
                          ),
                        ),
                        const SizedBox(
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(HeroIcons.chevron_up_down),
                          ),
                        ),
                        Expanded(
                          child: TextFormFieldCustom
                              .textFormFieldwithBorderCalendar(
                            align: TextAlign.center,
                            compact: true,
                            readOnly: true,
                            name:
                                "Fecha de ${widget.initDate != null ? "salida" : "fin"}",
                            dateController: TextEditingController(
                                text: lastDate?.toIso8601String() ?? ""),
                            withButton: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: insideSnackBar(
                      message: "No puede seleccionar el mismo dia*",
                      type: 'danger',
                      showAnimation: showError,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: TextStyles.standardText(
                        text: "Cancelar",
                        isBold: true,
                        size: 12.5,
                        color: brightness == Brightness.light
                            ? DesktopColors.cerulean
                            : DesktopColors.azulUltClaro,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Buttons.commonButton(
                      text: "Seleccionar",
                      isLoading: inProcess,
                      sizeText: 12.5,
                      onPressed: (initDate == null || lastDate == null)
                          ? null
                          : () async {
                              if (initDate!.isSameDate(lastDate!)) {
                                _toggleSnackbar();
                                return;
                              }

                              if (initDate!.isAfter(lastDate!)) {
                                DateTime tempInit = initDate!;
                                initDate = lastDate;
                                lastDate = tempInit;
                              }

                              Periodo newPeriod = Periodo(
                                  fechaInicial: initDate, fechaFinal: lastDate);

                              Navigator.of(context).pop(newPeriod);
                            },
                    ),
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
