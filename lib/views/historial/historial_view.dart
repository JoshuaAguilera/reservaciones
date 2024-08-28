import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/ui/title_page.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/services/habitacion_service.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/ui/textformfield_style.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/dialogs.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../providers/cotizacion_provider.dart';
import '../../services/cotizacion_service.dart';
import '../../ui/buttons.dart';
import '../../ui/custom_widgets.dart';
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

    return PopScope(
      onPopInvoked: (didPop) {
        ref.read(isEmptyProvider.notifier).update((state) => true);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitlePage(
                  title: "Historial",
                  subtitle: "",
                  childOptional: SizedBox(
                    height: 35,
                    width: screenWidth * 0.3,
                    child: TextField(
                      onSubmitted: (value) {
                        // pag = 1;
                        // fetchData(empty: false);
                        ref
                            .read(searchProvider.notifier)
                            .update((state) => value);
                        ref
                            .read(isEmptyProvider.notifier)
                            .update((state) => false);
                      },
                      controller: _searchController,
                      style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "poppins_regular",
                          height: 1),
                      decoration: TextFormFieldStyle.decorationFieldSearch(
                        label: "Buscar",
                        function: () {
                          ref
                              .read(searchProvider.notifier)
                              .update((state) => _searchController.text);
                          ref
                              .read(isEmptyProvider.notifier)
                              .update((state) => false);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: StatefulBuilder(
                              builder: (context, snapshot) {
                                return ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: filtros.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: SelectableButton(
                                        selected: filter == filtros[index],
                                        onPressed: () {
                                          // ref
                                          //     .read(filtroProvider.notifier)
                                          //     .update((state) => filtros[index]);
                                          filter = filtros[index];

                                          ref
                                              .read(searchProvider.notifier)
                                              .update((state) => "");
                                          snapshot(() {
                                            if (filter == "Personalizado") {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialogs
                                                      .filterDateDialog(
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
                                                        .update(
                                                            (state) => value);
                                                  }
                                                },
                                              );
                                            } else {
                                              ref
                                                  .read(filtroProvider.notifier)
                                                  .update((state) =>
                                                      filtros[index]);
                                              ref
                                                  .read(
                                                      periodoProvider.notifier)
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
                            width: screenWidth * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: DesktopColors.cotIndColor,
                                      size: 26,
                                    ),
                                    Container(
                                      width: screenWidth > 400
                                          ? screenWidth * 0.07
                                          : 15,
                                      child: TextStyles.standardText(
                                        text: screenWidth > 650
                                            ? "  Cot. Individual"
                                            : screenWidth > 400
                                                ? "  C. I."
                                                : " I",
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(width: 5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: DesktopColors.cotGroupColor,
                                      size: 26,
                                    ),
                                    Container(
                                      width: screenWidth > 400
                                          ? screenWidth * 0.07
                                          : 15,
                                      child: TextStyles.standardText(
                                        text: screenWidth > 650
                                            ? "  Cot. Grupal"
                                            : screenWidth > 400
                                                ? "  C. G."
                                                : " G",
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                receiptQuoteQuery.when(
                  data: (list) {
                    return list.isEmpty
                        ? SizedBox(
                            height: screenHight * 0.5,
                            child: CustomWidgets.messageNotResult(
                                sizeMessage: 15, context: context),
                          )
                        : SizedBox(
                            width: screenWidth,
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
                                    ref
                                        .read(isEmptyProvider.notifier)
                                        .update((state) => true);

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
                                      descuento: list[index].descuento,
                                      total: list[index].total,
                                      habitaciones: respHabitaciones,
                                    );

                                    ref
                                        .read(
                                            cotizacionDetalleProvider.notifier)
                                        .update((state) => newComprobante);

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
                                        content:
                                            "¿Desea eliminar la siguiente cotización \ndel huesped: ${list[index].nombreHuesped}?",
                                        nameButtonMain: "Aceptar",
                                        funtionMain: () async {
                                          debugPrint(
                                              list[index].folioPrincipal);
                                          if (await CotizacionService()
                                              .eliminarCotizacion(
                                                  list[index].folioPrincipal ??
                                                      '')) {}
                                        },
                                        nameButtonCancel: "Cancelar",
                                        withButtonCancel: true,
                                        iconData: Icons.delete,
                                      ),
                                    ).then(
                                      (value) {
                                        if (value != null) {
                                          // setState(() {});
                                          // Future.delayed(
                                          //     Durations.extralong1, () => fetchData());
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          );
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
