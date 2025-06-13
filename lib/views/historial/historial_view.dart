import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/res/ui/title_page.dart';
import 'package:generador_formato/res/helpers/constants.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/services/habitacion_service.dart';
import 'package:generador_formato/res/ui/progress_indicator.dart';
import 'package:generador_formato/res/ui/textformfield_style.dart';
import 'package:generador_formato/res/helpers/utility.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';
import 'package:generador_formato/utils/widgets/dialogs.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../models/periodo_model.dart';
import '../../providers/cotizacion_provider.dart';
import '../../providers/dahsboard_provider.dart';
import '../../providers/usuario_provider.dart';
import '../../services/cotizacion_service.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/custom_widgets.dart';
import '../../res/ui/show_snackbar.dart';
import '../../utils/shared_preferences/settings.dart';
import '../../utils/widgets/cotizacion_item_row.dart';
import '../../res/ui/text_styles.dart';
import '../tarifario/dialogs/period_calendar_dialog.dart';

class HistorialView extends ConsumerStatefulWidget {
  const HistorialView({super.key, required this.sideController});

  @override
  _HistorialViewState createState() => _HistorialViewState();

  final SidebarXController sideController;
}

class _HistorialViewState extends ConsumerState<HistorialView> {
  final TextEditingController _searchController =
      TextEditingController(text: "");
  bool startFlow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final receiptQuoteQuery = ref.watch(receiptQuoteQueryProvider(""));
    final isEmpty = ref.watch(isEmptyProvider);
    var filter = ref.watch(filtroProvider);
    final usuario = ref.watch(userProvider);
    var showFilter = ref.watch(showFilterProvider);
    var periodFilter = ref.watch(periodoProvider);

    void _searchQuote({String? text}) {
      ref
          .read(searchProvider.notifier)
          .update((state) => text ?? _searchController.text);
      ref.read(isEmptyProvider.notifier).update((state) => false);
    }

    if (!startFlow) {
      if (!isEmpty) {
        Future.delayed(100.ms, () {
          if (mounted) {
            return ref.read(isEmptyProvider.notifier).update((state) => true);
          }
        });
      }
      if (!showFilter.first) {
        Future.delayed(
          100.ms,
          () {
            if (mounted) {
              return ref.read(showFilterProvider.notifier).update(
                    (state) => [
                      ...[true, false, false, false, false, false]
                    ],
                  );
            }
          },
        );
      }
      startFlow = true;
    }

    Future deleteQuote(CotizacionData quote) async {
      if (await CotizacionService()
          .eliminarCotizacion(quote.folioPrincipal ?? '')) {
        ref
            .read(changeHistoryProvider.notifier)
            .update((state) => UniqueKey().hashCode);

        ref
            .read(changeProvider.notifier)
            .update((state) => UniqueKey().hashCode);

        if (!mounted) return;
        showSnackBar(
          type: "success",
          context: context,
          duration: 3.seconds,
          title: "Elimación completada",
          message:
              "La cotizacion: ${quote.folioPrincipal} fue eliminada correctamente.",
        );
      } else {
        if (!mounted) return;
        showSnackBar(
          type: "danger",
          context: context,
          duration: 3.seconds,
          title: "Elimación erronea",
          message: "Error al eliminar la cotizacion: ${quote.folioPrincipal}.",
        );
      }
    }

    void _updateShowFilter(int index) {
      int length = showFilter.where((element) => element).toList().length;

      if (length == 1 && showFilter[index]) return;

      showFilter.fillRange(0, showFilter.length, false);

      showFilter[index] = !showFilter[index];
      ref.read(showFilterProvider.notifier).update((state) => [...showFilter]);
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, proccess) {
        ref.read(isEmptyProvider.notifier).update((state) => true);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitlePage(
                  title:
                      !(usuario.rol != "SUPERADMIN" && usuario.rol != "ADMIN")
                          ? "Historial de Cotizaciones del Equipo"
                          : "Historial de Cotizaciones",
                  subtitle: "",
                  childOptional: SizedBox(
                    width: screenWidth * 0.3,
                    child: StatefulBuilder(builder: (context, snapshot) {
                      return TextField(
                        onSubmitted: (value) {
                          _searchQuote(text: value);
                          _searchController.text = '';
                        },
                        onChanged: (value) => snapshot(() {}),
                        controller: _searchController,
                        style: const TextStyle(
                            fontSize: 13,
                            fontFamily: "poppins_regular",
                            height: 1),
                        decoration: TextFormFieldStyle.decorationFieldSearch(
                          label: "Buscar por nombre de huésped",
                          controller: _searchController,
                          function: () {
                            if (_searchController.text.isNotEmpty) {
                              _searchController.text = '';
                            }
                            // _searchQuote();
                          },
                        ),
                      );
                    }),
                  ),
                ).animate().fadeIn(
                      delay: !Settings.applyAnimations ? null : 50.ms,
                      duration: Settings.applyAnimations ? null : 0.ms,
                    ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: StatefulBuilder(
                            builder: (context, snapshot) {
                              return ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: filtros.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: SelectableButton(
                                      selected: filter == filtros[index],
                                      onPressed: () {
                                        String initFilter = filter;
                                        filter = filtros[index];

                                        ref
                                            .read(searchProvider.notifier)
                                            .update((state) => "");
                                        snapshot(() {
                                          if (filter == "Personalizado") {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  PeriodCalendarDialog(
                                                colorTariff:
                                                    DesktopColors.primaryColor,
                                                initYear: 2024,
                                                title: "Filtrar por fechas",
                                                description:
                                                    "Seleccione un periodo de tiempo:",
                                              ),
                                            ).then(
                                              (value) {
                                                if (value != null) {
                                                  Periodo newPeriod =
                                                      value as Periodo;
                                                  ref
                                                      .read(periodoProvider
                                                          .notifier)
                                                      .update(
                                                        (state) => newPeriod,
                                                      );

                                                  ref
                                                      .read(filtroProvider
                                                          .notifier)
                                                      .update((state) =>
                                                          filtros[index]);
                                                } else {
                                                  filter = initFilter;
                                                  setState(() {});
                                                }
                                              },
                                            );
                                          } else {
                                            ref
                                                .read(filtroProvider.notifier)
                                                .update(
                                                    (state) => filtros[index]);
                                            ref
                                                .read(periodoProvider.notifier)
                                                .update((state) => null);
                                          }
                                        });

                                        ref
                                            .read(isEmptyProvider.notifier)
                                            .update((state) => false);
                                      },
                                      child: (filtros[index] ==
                                                  "Personalizado" &&
                                              filter == filtros[index] &&
                                              periodFilter != null)
                                          ? Text(Utility.getStringPeriod(
                                              initDate:
                                                  periodFilter.fechaInicial ??
                                                      DateTime.now(),
                                              lastDate:
                                                  periodFilter.fechaFinal ??
                                                      DateTime.now(),
                                            ))
                                          : Text(filtros[index]),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: 5,
                            children: [
                              CustomWidgets.itemColorIndicator(
                                context,
                                screenWidth: screenWidth,
                                nameItem: "Todos",
                                icons: Iconsax.layer_outline,
                                colorItem: DesktopColors.cotGrupal,
                                isSelected: showFilter[0],
                                onPreseed: () => _updateShowFilter(0),
                              ),
                              CustomWidgets.itemColorIndicator(
                                context,
                                screenWidth: screenWidth,
                                nameItem: "Cot. Grupal",
                                colorItem: DesktopColors.cotGrupal,
                                isSelected: showFilter[1],
                                onPreseed: () => _updateShowFilter(1),
                              ),
                              CustomWidgets.itemColorIndicator(
                                context,
                                nameItem: "Cot. Individual",
                                screenWidth: screenWidth,
                                colorItem: DesktopColors.cotIndiv,
                                isSelected: showFilter[2],
                                onPreseed: () => _updateShowFilter(2),
                              ),
                              CustomWidgets.itemColorIndicator(
                                context,
                                screenWidth: screenWidth,
                                nameItem: "Res. Grupal",
                                colorItem: DesktopColors.resGrupal,
                                isSelected: showFilter[3],
                                onPreseed: () => _updateShowFilter(3),
                              ),
                              CustomWidgets.itemColorIndicator(
                                context,
                                screenWidth: screenWidth,
                                nameItem: "Res. Individual",
                                colorItem: DesktopColors.resIndiv,
                                isSelected: showFilter[4],
                                onPreseed: () => _updateShowFilter(4),
                              ),
                              CustomWidgets.itemColorIndicator(
                                context,
                                screenWidth: screenWidth,
                                nameItem: "No Concretada",
                                colorItem: DesktopColors.cotNoConcr,
                                isSelected: showFilter[5],
                                onPreseed: () => _updateShowFilter(5),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ).animate().fadeIn(
                        delay: !Settings.applyAnimations ? null : 150.ms,
                        duration: Settings.applyAnimations ? null : 0.ms,
                      ),
                ),
                receiptQuoteQuery.when(
                  data: (list) {
                    return list.isEmpty
                        ? SizedBox(
                            height: screenHeight * 0.5,
                            child: CustomWidgets.messageNotResult(
                              sizeMessage: 12,
                              context: context,
                            ),
                          )
                            .animate(
                              delay: !Settings.applyAnimations ? null : 250.ms,
                            )
                            .slide(
                              begin: const Offset(0, 0.05),
                              duration: Settings.applyAnimations ? null : 0.ms,
                            )
                            .fadeIn(
                              duration: Settings.applyAnimations ? null : 0.ms,
                            )
                        : SizedBox(
                            width: screenWidth,
                            height: Utility.limitHeightList(
                                list.length, 10, screenHeight * 0.85),
                            child: ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ComprobanteItemRow(
                                  key: UniqueKey(),
                                  cotizacion: list[index],
                                  index: index,
                                  screenWidth: screenWidth,
                                  seeReceipt: () async {
                                    List<Habitacion> respHabitaciones = [];

                                    respHabitaciones = await HabitacionService()
                                        .getHabitacionesByFolio(
                                            list[index].folioPrincipal ?? '');

                                    if (!mounted) return;

                                    UsuarioData autor = UsuarioData.fromJson(
                                      jsonDecode(list[index].username ?? '{}'),
                                    );

                                    Cotizacion newComprobante = Cotizacion(
                                        nombreHuesped:
                                            list[index].nombreHuesped,
                                        esGrupo: list[index].esGrupo,
                                        esConcretado: list[index].esConcretado,
                                        responsableId: autor.id,
                                        correoElectronico:
                                            list[index].correoElectrico,
                                        numeroTelefonico:
                                            list[index].numeroTelefonico,
                                        fecha: list[index].fecha.toString(),
                                        fechaLimite:
                                            list[index].fechaLimite.toString(),
                                        folioPrincipal:
                                            list[index].folioPrincipal,
                                        habitaciones: respHabitaciones,
                                        id: list[index].id,
                                        autor: autor);

                                    ref
                                        .read(
                                            cotizacionDetalleProvider.notifier)
                                        .update((state) => newComprobante);

                                    ref
                                        .read(isEmptyProvider.notifier)
                                        .update((state) => true);

                                    widget.sideController.selectIndex(12);
                                  },
                                  delay: index,
                                  deleteReceipt: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialogs.customAlertDialog(
                                          context: context,
                                          title: "Eliminar comprobante",
                                          contentText:
                                              "¿Desea eliminar la siguiente cotización \ndel huesped: ${list[index].nombreHuesped}?",
                                          nameButtonMain: "Aceptar",
                                          otherButton: true,
                                          withLoadingProcess: true,
                                          funtionMain: () async {
                                            await deleteQuote(list[index]);
                                          },
                                          nameButtonCancel: "Cancelar",
                                          withButtonCancel: true,
                                          iconData: Icons.delete,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ).animate().fadeIn(
                              delay: !Settings.applyAnimations ? null : 300.ms,
                              duration:
                                  Settings.applyAnimations ? 500.ms : 0.ms,
                            );
                  },
                  error: (error, stackTrace) {
                    return SizedBox(
                      height: screenHeight * 0.5,
                      child: CustomWidgets.messageNotResult(
                          sizeMessage: 15, context: context),
                    );
                  },
                  loading: () {
                    return ProgressIndicatorCustom(
                      screenHight: screenHeight,
                      typeLoading: "progressiveDots",
                      message: TextStyles.standardText(
                        text: "Buscando cotizaciones",
                        align: TextAlign.center,
                        size: 11,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
