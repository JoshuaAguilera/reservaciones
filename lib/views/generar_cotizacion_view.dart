import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/cotizacion_grupal_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/providers/cotizacion_grupal_provider.dart';
import 'package:generador_formato/providers/dahsboard_provider.dart';
import 'package:generador_formato/services/send_quote_service.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/models/comprobante_cotizacion_model.dart';
import 'package:generador_formato/providers/comprobante_provider.dart';
import 'package:generador_formato/providers/cotizacion_individual_provider.dart';
import 'package:generador_formato/services/comprobante_service.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/widgets/cotizacion_grupo_card.dart';
import 'package:generador_formato/widgets/cotizacion_indiv_card.dart';
import 'package:generador_formato/widgets/custom_dropdown.dart';
import 'package:generador_formato/widgets/dialogs.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/prefijo_telefonico_model.dart';
import '../ui/buttons.dart';
import '../utils/helpers/constants.dart';

class GenerarCotizacionView extends ConsumerStatefulWidget {
  final SidebarXController sideController;
  const GenerarCotizacionView({Key? key, required this.sideController})
      : super(key: key);

  @override
  GenerarCotizacionViewState createState() => GenerarCotizacionViewState();
}

class GenerarCotizacionViewState extends ConsumerState<GenerarCotizacionView> {
  String dropdownValue = cotizacionesList.first;
  final _formKeyCotizacion = GlobalKey<FormState>();
  late pw.Document comprobantePDF;
  bool isLoading = false;
  bool isFinish = false;
  bool isSendingEmail = false;
  ComprobanteCotizacion receiptQuotePresent = ComprobanteCotizacion();
  List<Cotizacion> quotesIndPresent = [];
  List<CotizacionGrupal> quotesGroupPresent = [];

  PrefijoTelefonico prefijoInit = getPrefijosTelefonicos().first;

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
    final cotizacionesIndividuales =
        ref.watch(CotizacionIndividualProvider.provider);
    final cotizacionesGrupales = ref.watch(CotizacionGrupalProvider.provider);
    final comprobante = ref.watch(comprobanteProvider);
    final folio = ref.watch(uniqueFolioProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKeyCotizacion,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextStyles.titlePagText(text: "Generar cotización"),
                        if (isFinish)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isFinish = false;
                                isLoading = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 4,
                                backgroundColor: DesktopColors.prussianBlue),
                            child: (!Utility.isResizable(
                                    extended: widget.sideController.extended,
                                    context: context,
                                    minWidth: 425,
                                    minWidthWithBar: 435))
                                ? TextStyles.buttonTextStyle(
                                    text: "Nueva cotizacion")
                                : const Icon(
                                    Icons.restore_page,
                                    color: Colors.white,
                                  ),
                          )
                      ],
                    ),
                    if (!isLoading)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomDropdown.dropdownMenuCustom(
                              initialSelection: cotizacionesList.first,
                              onSelected: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              elements: cotizacionesList,
                              screenWidth: null,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Card(
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextStyles.titleText(
                                        text: "Datos del huesped",
                                        textAlign: TextAlign.start),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Nombre completo",
                                          msgError: "Campo requerido*",
                                          initialValue: comprobante.nombre,
                                          isRequired: true,
                                          onChanged: (p0) {
                                            comprobante.nombre = p0;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                          width: dropdownValue ==
                                                  'Cotización Grupos'
                                              ? 12
                                              : 0),
                                      if (dropdownValue == 'Cotización Grupos')
                                        Expanded(
                                          flex: 1,
                                          child: TextFormFieldCustom
                                              .textFormFieldwithBorder(
                                            name: "Habitaciones",
                                            msgError: "Campo requerido*",
                                            initialValue:
                                                (comprobante.habitaciones ?? '')
                                                    .toString(),
                                            isRequired: true,
                                            onChanged: (p0) {
                                              comprobante.habitaciones =
                                                  int.tryParse(p0);
                                            },
                                            isNumeric: true,
                                            icon: Icon(
                                              CupertinoIcons.bed_double_fill,
                                              color:
                                                  DesktopColors.ceruleanOscure,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: CustomDropdown
                                                .dropdownPrefijoNumerico(
                                                    initialSelection:
                                                        prefijoInit,
                                                    onSelected:
                                                        (PrefijoTelefonico?
                                                            value) {
                                                      setState(() {
                                                        prefijoInit = value!;
                                                      });
                                                    },
                                                    elements:
                                                        getPrefijosTelefonicos(),
                                                    screenWidth: null),
                                          )),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Teléfono",
                                          msgError: "Campo requerido*",
                                          initialValue: comprobante.telefono,
                                          isNumeric: true,
                                          isDecimal: false,
                                          isRequired: true,
                                          onChanged: (p0) {
                                            comprobante.telefono = p0;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Correo electronico",
                                          msgError: "Campo requerido*",
                                          initialValue: comprobante.correo,
                                          isRequired: true,
                                          onChanged: (p0) {
                                            comprobante.correo = p0;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ).animate().fadeIn(),
                          const SizedBox(height: 10),
                          Card(
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextStyles.titleText(
                                          text: "Cotizaciones")),
                                  const SizedBox(height: 15),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                        width: 200,
                                        height: 40,
                                        child: Buttons.commonButton(
                                          text: "Agregar cotización",
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return (dropdownValue ==
                                                        "Cotización Individual")
                                                    ? Dialogs()
                                                        .habitacionIndividualDialog(
                                                            buildContext:
                                                                context)
                                                    : Dialogs()
                                                        .habitacionGrupoDialog(
                                                        buildContext: context,
                                                        onInsert: (p0) =>
                                                            setState(() {
                                                          cotizacionesGrupales
                                                              .add(p0!);
                                                        }),
                                                      );
                                              },
                                            ).then((value) {
                                              if (value != null) {
                                                setState(() =>
                                                    cotizacionesIndividuales
                                                        .add(value));
                                              }
                                            });
                                          },
                                        )),
                                  ),
                                  const SizedBox(height: 12),
                                  if (!Utility.isResizable(
                                      extended: widget.sideController.extended,
                                      context: context))
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 5),
                                      child: Table(
                                        columnWidths: {
                                          0: FractionColumnWidth(
                                              (dropdownValue ==
                                                      "Cotización Individual")
                                                  ? .05
                                                  : .2),
                                          1: FractionColumnWidth(
                                              (dropdownValue ==
                                                      "Cotización Individual")
                                                  ? .15
                                                  : 0.22),
                                          2: const FractionColumnWidth(.1),
                                          3: FractionColumnWidth(
                                              (dropdownValue ==
                                                      "Cotización Individual")
                                                  ? .1
                                                  : 0.22),
                                          4: const FractionColumnWidth(.1),
                                          5: FractionColumnWidth(
                                              (dropdownValue ==
                                                      "Cotización Individual")
                                                  ? .1
                                                  : 0.15),
                                          6: FractionColumnWidth(
                                              (dropdownValue ==
                                                      "Cotización Individual")
                                                  ? .21
                                                  : .15),
                                        },
                                        children: [
                                          TableRow(children: [
                                            if (dropdownValue ==
                                                "Cotización Individual")
                                              TextStyles.standardText(
                                                  text: "#",
                                                  aling: TextAlign.center,
                                                  overClip: true),
                                            TextStyles.standardText(
                                                text: "Fechas de estancia",
                                                aling: TextAlign.center,
                                                overClip: true),
                                            if (dropdownValue ==
                                                "Cotización Individual")
                                              TextStyles.standardText(
                                                  text: "Adultos",
                                                  aling: TextAlign.center,
                                                  overClip: true),
                                            if (dropdownValue ==
                                                "Cotización Individual")
                                              TextStyles.standardText(
                                                  text: "Menores 0-6",
                                                  aling: TextAlign.center,
                                                  overClip: true),
                                            TextStyles.standardText(
                                                text: (dropdownValue ==
                                                        "Cotización Individual")
                                                    ? "Menores 7-12"
                                                    : "1 o 2 Adultos",
                                                aling: TextAlign.center,
                                                overClip: true),
                                            TextStyles.standardText(
                                                text: (dropdownValue ==
                                                        "Cotización Individual")
                                                    ? "Tarifa \nReal"
                                                    : "3 Adultos",
                                                aling: TextAlign.center,
                                                overClip: true),
                                            if (dropdownValue ==
                                                "Cotización Grupos")
                                              TextStyles.standardText(
                                                  text: "  4 Adultos  ",
                                                  aling: TextAlign.center,
                                                  overClip: true),
                                            if (dropdownValue ==
                                                "Cotización Grupos")
                                              TextStyles.standardText(
                                                  text: "Menores 7 a 12 Años",
                                                  aling: TextAlign.center,
                                                  overClip: true),
                                            if (dropdownValue ==
                                                "Cotización Individual")
                                              TextStyles.standardText(
                                                  text:
                                                      "Tarifa de preventa oferta por tiempo limitado",
                                                  aling: TextAlign.center,
                                                  overClip: true),
                                            TextStyles.standardText(
                                                text: "Opciones",
                                                aling: TextAlign.center)
                                          ]),
                                        ],
                                      ),
                                    ),
                                  const Divider(color: Colors.black54),
                                  if (dropdownValue == "Cotización Individual")
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: SizedBox(
                                        height: Utility.limitHeightList(
                                            cotizacionesIndividuales.length),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              cotizacionesIndividuales.length,
                                          itemBuilder: (context, index) {
                                            if (index <
                                                cotizacionesIndividuales
                                                    .length) {
                                              return CotizacionIndividualCard(
                                                key: ObjectKey(
                                                    cotizacionesIndividuales[
                                                            index]
                                                        .hashCode),
                                                index: index,
                                                cotizacion:
                                                    cotizacionesIndividuales[
                                                        index],
                                                compact: !Utility.isResizable(
                                                    extended: widget
                                                        .sideController
                                                        .extended,
                                                    context: context),
                                                onPressedDelete: () => setState(
                                                    () => cotizacionesIndividuales
                                                        .remove(
                                                            cotizacionesIndividuales[
                                                                index])),
                                                onPressedEdit: () {
                                                  print(dropdownValue);
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return (dropdownValue ==
                                                              "Cotización Individual")
                                                          ? Dialogs()
                                                              .habitacionIndividualDialog(
                                                                  buildContext:
                                                                      context,
                                                                  cotizacion:
                                                                      cotizacionesIndividuales[
                                                                          index])
                                                          : Dialogs()
                                                              .habitacionGrupoDialog(
                                                                  buildContext:
                                                                      context,
                                                                  cotizacion:
                                                                      cotizacionesGrupales[
                                                                          index]);
                                                    },
                                                  ).then((value) {
                                                    if (value != null) {
                                                      setState(() {
                                                        cotizacionesIndividuales[
                                                            index] = value;
                                                      });
                                                    }
                                                  });
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  else
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: SizedBox(
                                        height: Utility.limitHeightList(
                                            cotizacionesGrupales.length),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              cotizacionesGrupales.length,
                                          itemBuilder: (context, index) {
                                            if (index <
                                                cotizacionesGrupales.length) {
                                              return CotizacionGrupoCard(
                                                key: ObjectKey(
                                                    cotizacionesGrupales[index]
                                                        .hashCode),
                                                index: index,
                                                cotGroup:
                                                    cotizacionesGrupales[index],
                                                compact: !Utility.isResizable(
                                                    extended: widget
                                                        .sideController
                                                        .extended,
                                                    context: context),
                                                onPressedDelete: () => setState(
                                                    () => cotizacionesGrupales
                                                        .remove(
                                                            cotizacionesGrupales[
                                                                index])),
                                                onPressedEdit: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialogs()
                                                            .habitacionGrupoDialog(
                                                          buildContext: context,
                                                          cotizacion:
                                                              cotizacionesGrupales[
                                                                  index],
                                                          onUpdate: (p0) =>
                                                              setState(() {
                                                            cotizacionesGrupales[
                                                                index] = p0!;
                                                          }),
                                                        );
                                                      });
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 6.0),
                                  //   child: Align(
                                  //     alignment: Alignment.centerRight,
                                  //     child: TextStyles.titleText(
                                  //       text:
                                  //           "Subtotal: ${Utility.formatterNumber(Utility.calculateTarifaTotal(cotizaciones))}",
                                  //       size: 16,
                                  //       color: DesktopColors.prussianBlue,
                                  //     ),
                                  //   ),
                                  // ),
                                  if (dropdownValue == 'Cotización Individual')
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: TextStyles.titleText(
                                          text:
                                              "Total: ${Utility.formatterNumber(Utility.calculateTarifaTotal(cotizacionesIndividuales))}",
                                          size: 16,
                                          color: DesktopColors.prussianBlue,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn(delay: const Duration(milliseconds: 500)),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 200,
                                height: 40,
                                child: Buttons.commonButton(
                                        onPressed: () async {
                                          if (_formKeyCotizacion.currentState!
                                              .validate()) {
                                            if (cotizacionesIndividuales
                                                    .isEmpty &&
                                                dropdownValue ==
                                                    'Cotización Individual') {
                                              showSnackBar(
                                                type: "alert",
                                                context: context,
                                                title:
                                                    "Cotizaciones no registradas",
                                                message:
                                                    "Se requiere al menos una cotización",
                                              );
                                              return;
                                            }

                                            if (cotizacionesGrupales.isEmpty &&
                                                dropdownValue ==
                                                    'Cotización Grupos') {
                                              showSnackBar(
                                                type: "alert",
                                                context: context,
                                                title:
                                                    "Cotizaciones no registradas",
                                                message:
                                                    "Se requiere al menos una cotización",
                                              );
                                              return;
                                            }

                                            setState(() => isLoading = true);

                                            if (!(await ComprobanteService()
                                                .createComprobante(
                                                    comprobante: comprobante,
                                                    cotizacionesInd:
                                                        cotizacionesIndividuales
                                                                .isNotEmpty
                                                            ? cotizacionesIndividuales
                                                            : null,
                                                    cotizacionesGrup:
                                                        cotizacionesGrupales
                                                                .isNotEmpty
                                                            ? cotizacionesGrupales
                                                            : null,
                                                    folio: folio,
                                                    prefijoInit: prefijoInit,
                                                    isQuoteGroup: dropdownValue ==
                                                        'Cotización Grupos'))) {
                                              if (!context.mounted) return;
                                              showSnackBar(
                                                type: "danger",
                                                context: context,
                                                title:
                                                    "Error al registrar la cotizacion",
                                                message:
                                                    "Se produjo un error al insertar la nueva cotización.",
                                              );
                                              return;
                                            }

                                            receiptQuotePresent = comprobante;
                                            receiptQuotePresent.folioCuotas =
                                                folio;
                                            quotesIndPresent =
                                                cotizacionesIndividuales;
                                            quotesGroupPresent =
                                                cotizacionesGrupales;

                                            if (dropdownValue ==
                                                'Cotización Individual') {
                                              comprobantePDF = await ref
                                                  .watch(
                                                      CotizacionIndividualProvider
                                                          .provider.notifier)
                                                  .generarComprobante(
                                                      comprobante);
                                            } else {
                                              comprobantePDF = await ref
                                                  .watch(
                                                      CotizacionGrupalProvider
                                                          .provider.notifier)
                                                  .generarComprobante(
                                                      comprobante);
                                            }

                                            ref
                                                .read(comprobanteProvider
                                                    .notifier)
                                                .update((state) =>
                                                    ComprobanteCotizacion());
                                            ref
                                                .watch(
                                                    CotizacionIndividualProvider
                                                        .provider.notifier)
                                                .clear();
                                            ref
                                                .watch(CotizacionGrupalProvider
                                                    .provider.notifier)
                                                .clear();
                                            ref
                                                .read(uniqueFolioProvider
                                                    .notifier)
                                                .update((state) => UniqueKey()
                                                    .hashCode
                                                    .toString());

                                            ref
                                                .read(changeProvider.notifier)
                                                .update((state) =>
                                                    UniqueKey().hashCode);

                                            if (!context.mounted) return;
                                            Future.delayed(
                                                Durations.long2,
                                                () => setState(
                                                    () => isFinish = true));
                                          }
                                        },
                                        text: "Generar cotización",
                                        color: DesktopColors.prussianBlue)
                                    .animate()
                                    .fadeIn(
                                        delay:
                                            const Duration(milliseconds: 1000)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (isLoading && !isFinish)
                      ProgressIndicatorCustom(screenHight),
                    if (isFinish)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: SizedBox(
                          height: screenHight * 0.89,
                          child: PdfPreview(
                            build: (format) => comprobantePDF.save(),
                            actionBarTheme: PdfActionBarTheme(
                              backgroundColor: DesktopColors.ceruleanOscure,
                            ),
                            canChangeOrientation: false,
                            canChangePageFormat: false,
                            canDebug: false,
                            allowSharing: false,
                            pdfFileName:
                                "Comprobante de cotizacion ${DateTime.now().toString().substring(0, 10)}.pdf",
                            actions: [
                              IconButton(
                                onPressed: () async {
                                  await Printing.sharePdf(
                                    filename:
                                        "Comprobante de cotizacion ${DateTime.now().toString().substring(0, 10)}.pdf",
                                    bytes: await comprobantePDF.save(),
                                  );
                                },
                                icon: const Icon(
                                  CupertinoIcons.tray_arrow_down_fill,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              if (isSendingEmail)
                                const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                )
                              else
                                IconButton(
                                  onPressed: () async {
                                    setState(() => isSendingEmail = true);

                                    if (await SendQuoteService().sendQuoteMail(
                                      comprobantePDF,
                                      receiptQuotePresent,
                                      quotesIndPresent,
                                    )) {
                                      if (!mounted) return;
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialogs.customAlertDialog(
                                              context: context,
                                              iconData: Icons.send,
                                              iconColor: DesktopColors.turqueza,
                                              title: "Correo enviado",
                                              content:
                                                  "El correo fue enviado exitosamente",
                                              nameButtonMain: "Aceptar",
                                              funtionMain: () {},
                                              nameButtonCancel: "",
                                              withButtonCancel: false);
                                        },
                                      ).then((value) => setState(
                                          () => isSendingEmail = false));
                                    }
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.mail,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              GestureDetector(
                                onTap: () async {
                                  SendQuoteService().sendQuoteWhatsApp(
                                      receiptQuotePresent, quotesIndPresent);
                                },
                                child: const Image(
                                    image: AssetImage(
                                        "assets/image/whatsApp_icon.png"),
                                    width: 22,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
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
