import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/views/tarifario/dialogs/manager_base_tariff_dialog.dart';
import 'package:generador_formato/views/tarifario/dialogs/politics_tarifario_dialog.dart';
import 'package:generador_formato/views/tarifario/tarifario_checklist_view.dart';
import 'package:generador_formato/views/tarifario/tarifario_table_view.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../models/registro_tarifa_model.dart';
import '../../providers/cotizacion_provider.dart';
import '../../providers/tarifario_provider.dart';
import '../../services/tarifa_service.dart';
import '../../ui/custom_widgets.dart';
import '../../ui/show_snackbar.dart';
import '../../ui/title_page.dart';
import '../../widgets/dialogs.dart';
import 'tarifario_calendary_view.dart';

class TarifarioView extends ConsumerStatefulWidget {
  const TarifarioView({super.key, required this.sideController});
  final SidebarXController sideController;

  @override
  _TarifarioViewState createState() => _TarifarioViewState();
}

class _TarifarioViewState extends ConsumerState<TarifarioView> {
  String typePeriod = filtrosRegistro.first;
  bool target = false;
  bool targetForm = false;
  bool showForm = true;
  bool inMenu = false;
  int yearNow = DateTime.now().year;
  int intervaloHab = 1;
  int limitCotGrup = 1;

  final List<bool> selectedModeCalendar = <bool>[
    true,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final modeViewProvider = ref.watch(selectedModeViewProvider);
    final politicaTarifaProvider = ref.watch(tariffPolicyProvider(""));
    final tarifasBase = ref.watch(tarifaBaseProvider(""));

    void onEdit(RegistroTarifa register) {
      ref.read(editTarifaProvider.notifier).update((state) => register);
      ref.read(temporadasIndividualesProvider.notifier).update((state) =>
          register.temporadas
              ?.where((element) =>
                  ((element.forGroup ?? false) == false) &&
                  (element.forCash ?? false) == false)
              .toList() ??
          List<Temporada>.empty());
      ref.read(temporadasGrupalesProvider.notifier).update((state) =>
          register.temporadas
              ?.where((element) => element.forGroup ?? false)
              .toList() ??
          List<Temporada>.empty());
      ref.read(temporadasEfectivoProvider.notifier).update((state) =>
          register.temporadas
              ?.where((element) => element.forCash ?? false)
              .toList() ??
          List<Temporada>.empty());
      onCreate.call();
    }

    void onDelete(RegistroTarifa register) {
      showDialog(
        context: context,
        builder: (context) => Dialogs.customAlertDialog(
          context: context,
          title: "Eliminar tarifa",
          contentText:
              "¿Desea eliminar la siguiente tarifa: ${register.nombre}?",
          nameButtonMain: "Aceptar",
          funtionMain: () async {
            bool isSaves = await TarifaService().deleteTarifaRack(register);

            if (isSaves) {
              showSnackBar(
                context: context,
                title: "Tarifa Eliminada",
                message: "La tarifa fue eliminada exitosamente.",
                type: "success",
                iconCustom: Icons.delete,
              );

              Future.delayed(
                500.ms,
                () {
                  ref
                      .read(changeTarifasProvider.notifier)
                      .update((state) => UniqueKey().hashCode);
                },
              );
            } else {
              showSnackBar(
                context: context,
                title: "Error al eliminar tarifa",
                message:
                    "La tarifa no fue eliminada debido a un error inesperado.",
                type: "danger",
                iconCustom: Icons.delete,
              );
            }
          },
          nameButtonCancel: "Cancelar",
          withButtonCancel: true,
          iconData: Icons.delete,
        ),
      );
    }

    void _dialogConfigTariffs(Politica? data) {
      showDialog(
        context: context,
        builder: (context) => PoliticsTarifarioDialog(policy: data),
      ).then(
        (value) {
          if (value != null) {
            ref
                .read(saveTariffPolityProvider.notifier)
                .update((state) => value as Politica);

            ref
                .read(changeTariffPolicyProvider.notifier)
                .update((state) => UniqueKey().hashCode);
          }
        },
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitlePage(
                title: "Tarifario",
                subtitle:
                    "Contempla, analiza y define las principales tarifas de planes, habitaciones, PAX y promociones para complementar la generación de cotizaciones.",
                childOptional: !showForm
                    ? const SizedBox()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          tarifasBase.when(
                            data: (data) => Buttons.iconButtonCard(
                              icon: HeroIcons.square_3_stack_3d,
                              tooltip: "Tarifas Base",
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ManagerBaseTariffDialog(
                                        tarifasBase: data);
                                  },
                                ).then((value) {
                                  if (value != null) {
                                    ref
                                        .read(changeTarifasProvider.notifier)
                                        .update(
                                            (state) => UniqueKey().hashCode);
                                    ref
                                        .read(
                                            changeTarifasListProvider.notifier)
                                        .update(
                                            (state) => UniqueKey().hashCode);
                                    ref
                                        .read(
                                            changeTarifasBaseProvider.notifier)
                                        .update(
                                            (state) => UniqueKey().hashCode);
                                  }
                                });
                              },
                            ),
                            error: (error, stackTrace) => const Tooltip(
                                message: "Error de consulta",
                                child: Icon(Icons.warning_amber_rounded,
                                    color: Colors.amber)),
                            loading: () => Center(
                              child: SizedBox(
                                width: 40,
                                child: ProgressIndicatorEstandar(
                                    sizeProgressIndicator: 30),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          politicaTarifaProvider.when(
                            data: (data) => Buttons.iconButtonCard(
                              icon: HeroIcons.adjustments_horizontal,
                              tooltip: "Politicas de aplicación",
                              onPressed: () {
                                _dialogConfigTariffs(data);
                              },
                            ),
                            error: (error, stackTrace) => const Tooltip(
                                message: "Error de consulta",
                                child: Icon(Icons.warning_amber_rounded,
                                    color: Colors.amber)),
                            loading: () => Center(
                              child: SizedBox(
                                width: 40,
                                child: ProgressIndicatorEstandar(
                                    sizeProgressIndicator: 30),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 40,
                            child: Buttons.commonButton(
                              onPressed: () {
                                ref
                                    .read(editTarifaProvider.notifier)
                                    .update((state) => RegistroTarifa());
                                ref
                                    .read(
                                        temporadasIndividualesProvider.notifier)
                                    .update(
                                      (state) => [
                                        Temporada(
                                            nombre: "DIRECTO", editable: false),
                                        Temporada(
                                            nombre: "BAR I", editable: false),
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
                                onCreate.call();
                              },
                              text: "Crear tarifa",
                            ).animate(target: !targetForm ? 1 : 0).fadeIn(),
                          ),
                        ],
                      ),
              ),
              Row(
                mainAxisAlignment: (modeViewProvider.first)
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
                children: [
                  if (modeViewProvider.first)
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          child: CustomWidgets.sectionButton(
                            listModes: selectedModeCalendar,
                            modesVisual: [],
                            onChanged: (p0, p1) {
                              selectedModeCalendar[p0] = p0 == p1;
                              if (selectedModeCalendar[0]) {
                                yearNow = DateTime.now().year;
                              }
                              setState(() {});
                            },
                            arrayStrings: filtrosRegistro,
                            borderRadius: 12,
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (screenWidth < 1280 && inMenu)
                          ElevatedButton(
                            onPressed: () {
                              if (targetForm) {
                                setState(() => targetForm = !targetForm);

                                Future.delayed(Durations.extralong1,
                                    () => setState(() => showForm = !showForm));
                              }

                              setState(() {
                                target = false;
                              });

                              Future.delayed(
                                700.ms,
                                () => setState(() => inMenu = false),
                              );
                            },
                            style: ButtonStyle(
                              padding:
                                  const WidgetStatePropertyAll(EdgeInsets.zero),
                              backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).cardColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Icon(
                                Icons.menu_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                            ),
                          )
                              .animate(target: target ? 1 : 0)
                              .slideX(begin: -0.2, duration: 550.ms)
                              .fadeIn(delay: !target ? 0.ms : 400.ms),
                      ],
                    ),
                  SizedBox(
                    height: 50,
                    child: CustomWidgets.sectionButton(
                      listModes: modeViewProvider,
                      modesVisual: modesVisual,
                      onChanged: (p0, p1) {
                        modeViewProvider[p0] = p0 == p1;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              if (modeViewProvider.first)
                TarifarioCalendaryView(
                  target: target,
                  inMenu: inMenu,
                  sideController: widget.sideController,
                  viewWeek: selectedModeCalendar[0],
                  viewMonth: selectedModeCalendar[1],
                  viewYear: selectedModeCalendar[2],
                  yearNow: yearNow,
                  targetForm: targetForm,
                  showForm: showForm,
                  onCreate: () => onCreate.call(),
                  onTarget: () {
                    setState(() => target = true);

                    Future.delayed(Durations.extralong1,
                        () => setState(() => inMenu = true));
                  },
                  onTargetForm: () {
                    setState(() => targetForm = !targetForm);

                    Future.delayed(Durations.extralong1,
                        () => setState(() => showForm = !showForm));
                  },
                  increaseYear: () => setState(() => yearNow++),
                  reduceYear: () => setState(() => yearNow--),
                  setYear: (p0) => setState(() => yearNow = p0),
                ),
              if (modeViewProvider[1])
                TarifarioTableView(
                  sideController: widget.sideController,
                  onEdit: (register) => onEdit(register),
                  onDelete: (register) => onDelete(register),
                ),
              if (modeViewProvider[2])
                TarifarioChecklistView(
                  sideController: widget.sideController,
                  onEdit: (register) => onEdit(register),
                  onDelete: (register) => onDelete(register),
                ),
            ],
          ),
        ),
      ),
    ).animate(target: targetForm ? 0 : 1).fadeIn();
  }

  void Function()? onCreate({bool isUpdating = false}) {
    setState(() {
      targetForm = true;
    });
    Future.delayed(500.ms, () => widget.sideController.selectIndex(15));
  }
}
