import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/view-models/providers/cotizacion_provider.dart';
import 'package:generador_formato/res/ui/buttons.dart';
import 'package:generador_formato/res/ui/custom_widgets.dart';
import 'package:generador_formato/utils/widgets/habitacion_item_row.dart';
import 'package:generador_formato/utils/widgets/summary_controller_widget.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../res/helpers/date_helpers.dart';
import '../../res/helpers/utility.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../view-models/services/generador_doc_service.dart';
import '../../res/ui/progress_indicator.dart';
import '../../utils/shared_preferences/settings.dart';
import '../../res/ui/text_styles.dart';
import '../../utils/widgets/textformfield_custom.dart';
import '../generacion_cotizaciones/pdf_cotizacion_view.dart';

class CotizacionDetalleView extends ConsumerStatefulWidget {
  const CotizacionDetalleView({super.key, required this.sideController});

  final SidebarXController sideController;
  @override
  _CotizacionDetalleViewState createState() => _CotizacionDetalleViewState();
}

class _CotizacionDetalleViewState extends ConsumerState<CotizacionDetalleView> {
  late pw.Document comprobantePDF;
  bool isLoading = false;
  bool isFinish = false;
  Color? colorElement;
  Color? colorText;
  bool startFlow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cotizacion = ref.watch(cotizacionDetalleProvider);
    if (!startFlow) {
      colorElement = Theme.of(context).primaryColor;
      colorText = !(cotizacion.esGrupo ?? false)
          ? DesktopColors.azulUltClaro
          : DesktopColors.prussianBlue;
      startFlow = true;
    }
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenWidthWithSideBar = screenWidth +
        (screenWidth > 800 ? (widget.sideController.extended ? 50 : 180) : 300);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomWidgets.titleFormPage(
                          onPressedBack: () {
                            if (!isFinish) {
                              widget.sideController.selectIndex(2);
                            } else {
                              isFinish = false;
                              isLoading = false;
                              setState(() {});
                            }
                          },
                          showSaveButton: false,
                          context: context,
                          title:
                              "Detalles de ${(cotizacion.estatus == "concretado") ? "Reservación" : "Cotización"} - ${cotizacion.folio}",
                        ),
                        if (!isLoading)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
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
                                          textAlign: TextAlign.start,
                                          color: Theme.of(context).dividerColor,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      TextFormFieldCustom
                                          .textFormFieldwithBorder(
                                        name: "Nombre completo",
                                        blocked: true,
                                        readOnly: true,
                                        initialValue:
                                            cotizacion.cliente?.nombres ?? '',
                                      ),
                                      if (cotizacion
                                                  .cliente?.correoElectronico ==
                                              null &&
                                          cotizacion
                                                  .cliente?.numeroTelefonico ==
                                              null)
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: TextFormFieldCustom
                                                  .textFormFieldwithBorder(
                                                name:
                                                    "Numero Telefonico (Contacto o WhatsApp)",
                                                initialValue: cotizacion.cliente
                                                        ?.numeroTelefonico ??
                                                    '',
                                                blocked: true,
                                                readOnly: true,
                                                enabled: (cotizacion.cliente
                                                            ?.numeroTelefonico ??
                                                        '')
                                                    .isNotEmpty,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: TextFormFieldCustom
                                                  .textFormFieldwithBorder(
                                                name: "Correo electronico",
                                                initialValue: cotizacion.cliente
                                                        ?.correoElectronico ??
                                                    '',
                                                blocked: true,
                                                readOnly: true,
                                                enabled: (cotizacion.cliente
                                                            ?.correoElectronico ??
                                                        '')
                                                    .isNotEmpty,
                                              ),
                                            ),
                                          ],
                                        ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: TextFormFieldCustom
                                                .textFormFieldwithBorder(
                                              name: "Fecha de registro",
                                              initialValue:
                                                  "${DateHelpers.getStringDate(data: cotizacion.createdAt)} ${cotizacion.createdAt?.toString().substring(11, 16)}",
                                              blocked: true,
                                              readOnly: true,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: TextFormFieldCustom
                                                .textFormFieldwithBorder(
                                              name: (cotizacion.estatus ==
                                                      "concretado")
                                                  ? "Responsable"
                                                  : "Fecha de vigencia",
                                              initialValue: (cotizacion
                                                          .estatus ==
                                                      "concretado")
                                                  ? "${"${cotizacion.creadoPor?.nombre} "} ${cotizacion.creadoPor?.apellido ?? ''}"
                                                  : "${DateHelpers.getStringDate(data: cotizacion.fechaLimite!)} ${cotizacion.fechaLimite?.toString().substring(11, 16)}",
                                              blocked: true,
                                              readOnly: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ).animate().fadeIn(
                                    duration: Settings.applyAnimations
                                        ? 250.ms
                                        : 0.ms,
                                  ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Divider(color: colorElement),
                              ),
                              TextStyles.titleText(
                                text:
                                    "Habitaciones ${(cotizacion.estatus == "concretado") ? "reservadas" : "cotizadas"}",
                                color: colorElement,
                              ),
                              const SizedBox(height: 12),
                              if (!Utility.isResizable(
                                  extended: widget.sideController.extended,
                                  context: context))
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 5),
                                    child: Table(
                                      border: TableBorder(
                                        verticalInside: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          width: 2,
                                        ),
                                      ),
                                      columnWidths: {
                                        0: const FractionColumnWidth(0.1),
                                        if (screenWidthWithSideBar < 1250 &&
                                            screenWidthWithSideBar > 950)
                                          1: const FractionColumnWidth(0.35),
                                        if (screenWidthWithSideBar < 1550 &&
                                            screenWidthWithSideBar > 1250)
                                          2: const FractionColumnWidth(0.1),
                                        if (screenWidthWithSideBar < 1550 &&
                                            screenWidthWithSideBar > 1350)
                                          3: const FractionColumnWidth(0.1),
                                        if (screenWidthWithSideBar < 1550 &&
                                            screenWidthWithSideBar > 1450)
                                          4: const FractionColumnWidth(0.1),
                                      },
                                      children: [
                                        TableRow(
                                          children: [
                                            for (var item in [
                                              "#",
                                              if (screenWidthWithSideBar > 950)
                                                "Fechas de estancia",
                                              if (screenWidthWithSideBar > 1250)
                                                "Adultos",
                                              if (screenWidthWithSideBar > 1450)
                                                "Menores 0-6",
                                              if (screenWidthWithSideBar > 1350)
                                                "Menores 7-12",
                                              if (screenWidthWithSideBar > 1700)
                                                "Tarifa Real",
                                              if (screenWidthWithSideBar > 1550)
                                                "Tarifa Total",
                                              "Cantidad",
                                            ])
                                              TextStyles.standardText(
                                                text: item,
                                                align: TextAlign.center,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                overClip: true,
                                                size: 11.5,
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: SizedBox(
                                  height: Utility.limitHeightList(cotizacion
                                          .habitaciones
                                          ?.where(
                                              (element) => !element.esCortesia)
                                          .toList()
                                          .length ??
                                      0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: cotizacion.habitaciones
                                            ?.where((element) =>
                                                !element.esCortesia)
                                            .toList()
                                            .length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      if (index <
                                          (cotizacion.habitaciones
                                                  ?.where((element) =>
                                                      !element.esCortesia)
                                                  .toList()
                                                  .length ??
                                              0)) {
                                        return const SizedBox();
                                        // return HabitacionItemRow(
                                        //   key: ObjectKey(cotizacion
                                        //       .habitaciones!
                                        //       .where((element) =>
                                        //           !element.esCortesia)
                                        //       .toList()[index]
                                        //       .hashCode),
                                        //   index: index,
                                        //   habitacion: cotizacion.habitaciones!
                                        //       .where((element) =>
                                        //           !element.esCortesia)
                                        //       .toList()[index],
                                        //   isTable: !Utility.isResizable(
                                        //       extended: widget
                                        //           .sideController.extended,
                                        //       context: context),
                                        //   esDetalle: true,
                                        //   sideController: widget.sideController,
                                        // );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12, top: 8),
                                child: Divider(color: colorElement),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 5,
                                  children: [
                                    if (!(cotizacion.estatus == "concretado"))
                                      if (!(DateTime.now().compareTo(
                                              cotizacion.fechaLimite ??
                                                  DateTime.now()) ==
                                          1))
                                        SizedBox(
                                          width: 230,
                                          height: 40,
                                          child: Buttons.commonButton(
                                            text: "Generar comprobante PDF",
                                            onPressed: () async {
                                              setState(() => isLoading = true);

                                              if (cotizacion.esGrupo ?? false) {
                                                comprobantePDF =
                                                    await GeneradorDocService()
                                                        .generarComprobanteCotizacionGrupal(
                                                  habitaciones: cotizacion
                                                          .habitaciones ??
                                                      List<Habitacion>.empty(),
                                                  cotizacion: cotizacion,
                                                );
                                              } else {
                                                comprobantePDF =
                                                    await GeneradorDocService()
                                                        .generarCompInd(
                                                  cotizacion: cotizacion,
                                                );
                                              }

                                              Future.delayed(
                                                Durations.long2,
                                                () => setState(
                                                    () => isFinish = true),
                                              );
                                            },
                                          ),
                                        ),
                                    if (!(cotizacion.estatus == "concretado"))
                                      SizedBox(
                                        width: 230,
                                        height: 40,
                                        child: Buttons.commonButton(
                                          text: "Crear Reservación",
                                          onPressed: null,
                                          tooltipText:
                                              "Función aun no disponible",
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        if (isLoading && !isFinish)
                          ProgressIndicatorCustom(
                            screenHight: screenHight,
                            message: TextStyles.standardText(
                              text: "Generando comprante PDF",
                              align: TextAlign.center,
                              size: 11,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        if (isFinish)
                          PdfCotizacionView(
                            comprobantePDF: comprobantePDF,
                            cotizacion: cotizacion,
                            isDetail: true,
                          ),
                      ],
                    ),
                  ),
                  SummaryControllerWidget(
                    withSaveButton: false,
                    saveRooms: cotizacion.habitaciones,
                    finishQuote: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
