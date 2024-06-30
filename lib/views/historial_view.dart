import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/helpers/constants.dart';
import 'package:generador_formato/models/comprobante_cotizacion_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/services/cotizacion_service.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/ui/textformfield_style.dart';
import 'package:generador_formato/widgets/dialogs.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:sidebarx/sidebarx.dart';

import '../providers/comprobante_provider.dart';
import '../services/comprobante_service.dart';
import '../ui/buttons.dart';
import '../widgets/comprobante_item_row.dart';

class HistorialView extends ConsumerStatefulWidget {
  const HistorialView({super.key, required this.sideController});

  @override
  _HistorialViewState createState() => _HistorialViewState();

  final SidebarXController sideController;
}

class _HistorialViewState extends ConsumerState<HistorialView> {
  List<ReceiptQuoteData> comprobantes = [];
  bool isLoading = false;
  int pag = 1;
  String search = "";
  DateTime initDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 1));
  String typeQuote = "Individual";
  final TextEditingController _searchController =
      TextEditingController(text: "");
  String filtro = filtros.first;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchData({bool empty = true}) async {
    isLoading = true;
    setState(() {});
    List<ReceiptQuoteData> resp = await ComprobanteService()
        .getComprobantesLocales(_searchController.text, pag, filtro, empty);
    if (!mounted) return;
    setState(() {
      comprobantes = resp;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                        pag = 1;
                        fetchData(empty: false);
                        _searchController.text = "";
                      },
                      controller: _searchController,
                      style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "poppins_regular",
                          height: 1),
                      decoration: TextFormFieldStyle.decorationFieldSearch(
                        label: "Buscar",
                        function: () {
                          pag = 1;
                          fetchData(empty: false);
                          _searchController.text = "";
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.black54),
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
                                selected: filtro == filtros[index],
                                onPressed: () {
                                  snapshot(() {
                                    filtro = filtros[index];
                                    pag = 1;
                                    fetchData(empty: false);
                                  });
                                },
                                child: Text(filtros[index]),
                              ),
                            );
                          },
                        );
                      },
                    )),
              ),
              if (!isLoading)
                SizedBox(
                  width: screenWidth,
                  child: ListView.builder(
                    itemCount: comprobantes.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ComprobanteItemRow(
                        key: UniqueKey(),
                        comprobante: comprobantes[index],
                        index: index,
                        screenWidth: screenWidth,
                        expandedSideBar: widget.sideController.extended,
                        seeReceipt: () async {
                          List<Cotizacion> respCotizaciones =
                              await CotizacionService().getCotizacionesByFolio(
                                  comprobantes[index].folioQuotes);
                          if (!mounted) return;

                          ComprobanteCotizacion newComprobante =
                              ComprobanteCotizacion(
                            nombre: comprobantes[index].nameCustomer,
                            correo: comprobantes[index].mail,
                            telefono: comprobantes[index].numPhone,
                            fechaRegistro:
                                comprobantes[index].dateRegister.toString(),
                            folioCuotas: comprobantes[index].folioQuotes,
                            tarifaDiaria: comprobantes[index].rateDay,
                            total: comprobantes[index].total,
                            cotizaciones: respCotizaciones,
                          );

                          ref
                              .read(comprobanteDetalleProvider.notifier)
                              .update((state) => newComprobante);

                          widget.sideController.selectIndex(12);
                        },
                        deleteReceipt: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialogs.customAlertDialog(
                              context: context,
                              title: "Eliminar comprobante",
                              content:
                                  "¿Desea eliminar la siguiente cotización \ndel huesped: ${comprobantes[index].nameCustomer}?",
                              nameButtonMain: "Aceptar",
                              funtionMain: () async {
                                debugPrint(comprobantes[index].folioQuotes);
                                if (await ComprobanteService()
                                    .eliminarComprobante(
                                        comprobantes[index].folioQuotes)) {}
                              },
                              nameButtonCancel: "Cancelar",
                              withButtonCancel: true,
                              iconData: Icons.delete,
                            ),
                          ).then(
                            (value) {
                              if (value != null) {
                                isLoading = true;
                                setState(() {});
                                Future.delayed(
                                    Durations.extralong1, () => fetchData());
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                )
              else
                ProgressIndicatorCustom(screenHight),
              if (comprobantes.isEmpty && !isLoading)
                TextStyles.standardText(
                    text: "No se han encontraron resultados.", size: 14)
            ],
          ),
        ),
      ),
    );
  }
}
