import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/ui/title_page.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/services/habitacion_service.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/ui/textformfield_style.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/dialogs.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../providers/cotizacion_provider.dart';
import '../../providers/dahsboard_provider.dart';
import '../../services/cotizacion_service.dart';
import '../../ui/buttons.dart';
import '../../ui/custom_widgets.dart';
import '../../ui/show_snackbar.dart';
import '../../widgets/cotizacion_item_row.dart';

class HistorialView extends ConsumerStatefulWidget {
  const HistorialView({super.key, required this.sideController});

  @override
  _HistorialViewState createState() => _HistorialViewState();

  final SidebarXController sideController;
}

class _HistorialViewState extends ConsumerState<HistorialView> {
  DateTime initDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 1));
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
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final receiptQuoteQuery = ref.watch(receiptQuoteQueryProvider(""));
    var filter = ref.watch(filtroProvider);

    void _searchQuote({String? text}) {
      ref
          .read(searchProvider.notifier)
          .update((state) => text ?? _searchController.text);
      ref.read(isEmptyProvider.notifier).update((state) => false);
    }

    if (!startFlow) {
      Future.delayed(100.ms,
          () => ref.read(isEmptyProvider.notifier).update((state) => true));
      startFlow = true;
    }

    return PopScope(
      onPopInvoked: (didPop) {
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
                  title: "Historial",
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
                          label: "Buscar",
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
                ).animate().fadeIn(delay: 50.ms),
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
                                        filter = filtros[index];

                                        ref
                                            .read(searchProvider.notifier)
                                            .update((state) => "");
                                        snapshot(() {
                                          if (filter == "Personalizado") {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialogs.filterDateDialog(
                                                  context: context,
                                                  funtionMain: () {},
                                                );
                                              },
                                            ).then(
                                              (value) {
                                                if (value != null) {
                                                  ref
                                                      .read(periodoProvider
                                                          .notifier)
                                                      .update((state) => value);
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
                                                .update((state) => "");
                                          }
                                        });

                                        ref
                                            .read(isEmptyProvider.notifier)
                                            .update((state) => false);
                                      },
                                      child: Text(filtros[index]),
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
                            children: [
                              CustomWidgets.itemColorIndicator(
                                context,
                                screenWidth: screenWidth,
                                nameItem: "Cot. Grupal",
                                colorItem: DesktopColors.cotGrupal,
                              ),
                              const SizedBox(width: 5),
                              CustomWidgets.itemColorIndicator(
                                context,
                                nameItem: "Cot. Individual",
                                screenWidth: screenWidth,
                                colorItem: DesktopColors.cotIndiv,
                              ),
                              const SizedBox(width: 5),
                              CustomWidgets.itemColorIndicator(
                                context,
                                screenWidth: screenWidth,
                                nameItem: "Res. Grupal",
                                colorItem: DesktopColors.resGrupal,
                              ),
                              const SizedBox(width: 5),
                              CustomWidgets.itemColorIndicator(
                                context,
                                screenWidth: screenWidth,
                                nameItem: "Res. Individual",
                                colorItem: DesktopColors.resIndiv,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ).animate().fadeIn(delay: 150.ms),
                ),
                receiptQuoteQuery.when(
                  data: (list) {
                    return list.isEmpty
                        ? SizedBox(
                            height: screenHight * 0.5,
                            child: CustomWidgets.messageNotResult(
                                sizeMessage: 15, context: context),
                          )
                            .animate()
                            .slide(begin: const Offset(0, 0.05))
                            .fadeIn()
                        : SizedBox(
                            width: screenWidth,
                            height:
                                Utility.limitHeightList(list.length, 10, 150),
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

                                    Cotizacion newComprobante = Cotizacion(
                                      nombreHuesped: list[index].nombreHuesped,
                                      esGrupo: list[index].esGrupo,
                                      correoElectronico:
                                          list[index].correoElectrico,
                                      numeroTelefonico:
                                          list[index].numeroTelefonico,
                                      fecha: list[index].fecha.toString(),
                                      folioPrincipal:
                                          list[index].folioPrincipal,
                                      // descuento: list[index].descuento,
                                      // total: list[index].total,
                                      habitaciones: respHabitaciones,
                                    );

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
                                      builder: (context) =>
                                          Dialogs.customAlertDialog(
                                        context: context,
                                        title: "Eliminar comprobante",
                                        contentText:
                                            "¿Desea eliminar la siguiente cotización \ndel huesped: ${list[index].nombreHuesped}?",
                                        nameButtonMain: "Aceptar",
                                        funtionMain: () async {
                                          debugPrint(
                                              list[index].folioPrincipal);
                                          if (await CotizacionService()
                                              .eliminarCotizacion(
                                                  list[index].folioPrincipal ??
                                                      '')) {
                                            ref
                                                .read(changeHistoryProvider
                                                    .notifier)
                                                .update((state) =>
                                                    UniqueKey().hashCode);

                                            ref
                                                .read(changeProvider.notifier)
                                                .update((state) =>
                                                    UniqueKey().hashCode);

                                            if (!mounted) return;
                                            showSnackBar(
                                              type: "success",
                                              context: context,
                                              duration: 3.seconds,
                                              title: "Elimación completada",
                                              message:
                                                  "La cotizacion: ${list[index].folioPrincipal} fue eliminada correctamente.",
                                            );
                                          } else {
                                            if (!mounted) return;
                                            showSnackBar(
                                              type: "danger",
                                              context: context,
                                              duration: 3.seconds,
                                              title: "Elimación erronea",
                                              message:
                                                  "Error al eliminar la cotizacion: ${list[index].folioPrincipal}.",
                                            );
                                          }
                                        },
                                        nameButtonCancel: "Cancelar",
                                        withButtonCancel: true,
                                        iconData: Icons.delete,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ).animate().fadeIn(delay: 300.ms, duration: 500.ms);
                  },
                  error: (error, stackTrace) {
                    return SizedBox(
                      height: screenHight * 0.5,
                      child: CustomWidgets.messageNotResult(
                          sizeMessage: 15, context: context),
                    );
                  },
                  loading: () {
                    return ProgressIndicatorCustom(screenHight: screenHight);
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
