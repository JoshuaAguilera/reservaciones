import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/argumento_model.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/models/comprobante_cotizacion_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/services/cotizacion_service.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/ui/textformfield_style.dart';
import 'package:generador_formato/widgets/dialogs.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../providers/comprobante_provider.dart';
import '../../services/comprobante_service.dart';
import '../../ui/buttons.dart';
import '../../widgets/comprobante_item_row.dart';

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
    final filter = ref.watch(filtroProvider);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStyles.titlePagText(text: "Historial"),
                    SizedBox(
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
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                      height: 30,
                      child: StatefulBuilder(
                        builder: (context, snapshot) {
                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: filtros.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: SelectableButton(
                                  selected: filter == filtros[index],
                                  onPressed: () {
                                    ref
                                        .read(searchProvider.notifier)
                                        .update((state) => "");
                                    snapshot(() {
                                      ref
                                          .read(filtroProvider.notifier)
                                          .update((state) => filtros[index]);

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
                                                  .read(
                                                      periodoProvider.notifier)
                                                  .update((state) => value);
                                            }
                                          },
                                        );
                                      } else {
                                        ref
                                            .read(filtroProvider.notifier)
                                            .update((state) => filtros[index]);
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
                      )),
                ),
                receiptQuoteQuery.when(
                  data: (list) {
                    print("cargado");
                    return list.isEmpty
                        ? TextStyles.standardText(
                            text: "No se han encontraron resultados.", size: 14)
                        : SizedBox(
                            width: screenWidth,
                            child: ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ComprobanteItemRow(
                                  key: UniqueKey(),
                                  comprobante: list[index],
                                  index: index,
                                  screenWidth: screenWidth,
                                  seeReceipt: () async {
                                    ref
                                        .read(isEmptyProvider.notifier)
                                        .update((state) => true);
                                    List<Cotizacion> respCotizaciones =
                                        await CotizacionService()
                                            .getCotizacionesByFolio(
                                                list[index].folioQuotes);
                                    if (!mounted) return;

                                    ComprobanteCotizacion newComprobante =
                                        ComprobanteCotizacion(
                                      nombre: list[index].nameCustomer,
                                      correo: list[index].mail,
                                      telefono: list[index].numPhone,
                                      fechaRegistro:
                                          list[index].dateRegister.toString(),
                                      folioCuotas: list[index].folioQuotes,
                                      tarifaDiaria: list[index].rateDay,
                                      total: list[index].total,
                                      cotizaciones: respCotizaciones,
                                    );

                                    ref
                                        .read(
                                            comprobanteDetalleProvider.notifier)
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
                                            "¿Desea eliminar la siguiente cotización \ndel huesped: ${list[index].nameCustomer}?",
                                        nameButtonMain: "Aceptar",
                                        funtionMain: () async {
                                          debugPrint(list[index].folioQuotes);
                                          if (await ComprobanteService()
                                              .eliminarComprobante(
                                                  list[index].folioQuotes)) {}
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
                    return TextStyles.standardText(
                        text: "No se han encontraron resultados.", size: 14);
                  },
                  loading: () {
                    return ProgressIndicatorCustom(screenHight);
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
