import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/providers/dahsboard_provider.dart';
import 'package:generador_formato/services/send_quote_service.dart';
import 'package:generador_formato/ui/title_page.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/providers/cotizacion_provider.dart';
import 'package:generador_formato/providers/habitacion_provider.dart';
import 'package:generador_formato/services/cotizacion_service.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/views/generacion_cotizaciones/habitacion_form.dart';
import 'package:generador_formato/views/generacion_cotizaciones/habitaciones_list.dart';
import 'package:generador_formato/widgets/custom_dropdown.dart';
import 'package:generador_formato/widgets/dialogs.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../models/prefijo_telefonico_model.dart';
import '../../ui/buttons.dart';
import '../../utils/helpers/constants.dart';

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
  Cotizacion receiptQuotePresent = Cotizacion();
  List<Habitacion> quotesIndPresent = [];
  double targetHabitaciones = 1;
  double targetDetalleHabitacion = 1;
  bool inDetail = false;
  bool inList = true;

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
    final habitaciones = ref.watch(HabitacionProvider.provider);
    final comprobante = ref.watch(cotizacionProvider);
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
                    TitlePage(
                      title: "Generar cotización",
                      subtitle:
                          "Proporcione un presupuesto detallado y claro a los clientes interesados en hacer una reservación",
                      childOptional: isFinish
                          ? ElevatedButton(
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
                          : const SizedBox(),
                    ),
                    if (!isLoading)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                      textAlign: TextAlign.start,
                                      color: Theme.of(context).dividerColor,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  TextFormFieldCustom.textFormFieldwithBorder(
                                    name: "Nombre completo",
                                    msgError: "Campo requerido*",
                                    initialValue: comprobante.nombreHuesped,
                                    isRequired: true,
                                    onChanged: (p0) {
                                      comprobante.nombreHuesped = p0;
                                    },
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
                                              initialSelection: prefijoInit,
                                              onSelected:
                                                  (PrefijoTelefonico? value) {
                                                setState(() {
                                                  prefijoInit = value!;
                                                });
                                              },
                                              elements:
                                                  getPrefijosTelefonicos(),
                                              screenWidth: null,
                                            ),
                                          )),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Teléfono",
                                          msgError: "Campo requerido*",
                                          initialValue:
                                              comprobante.numeroTelefonico,
                                          isNumeric: true,
                                          isDecimal: false,
                                          isRequired: true,
                                          onChanged: (p0) {
                                            comprobante.numeroTelefonico = p0;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Correo electronico",
                                          msgError: "Campo requerido*",
                                          initialValue:
                                              comprobante.correoElectronico,
                                          isRequired: true,
                                          onChanged: (p0) {
                                            comprobante.correoElectronico = p0;
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
                          SizedBox(
                            child: (inList)
                                ? HabitacionesList(
                                    nuevaHabitacion: () {
                                      setState(() => targetHabitaciones = 0);
                                      Future.delayed(
                                        800.ms,
                                        () => setState(
                                          () {
                                            inList = false;
                                            inDetail = true;
                                            targetDetalleHabitacion = 1;
                                          },
                                        ),
                                      );
                                    },
                                    sideController: widget.sideController,
                                    esGrupo: habitaciones.length > 9,
                                    habitaciones: habitaciones,
                                  )
                                    .animate(target: targetHabitaciones)
                                    // .slideX(
                                    //     duration: 900.ms,
                                    //     begin: 0.5,
                                    //     curve: Curves.easeInOutBack)
                                    .fadeIn(duration: 500.ms)
                                : HabitacionForm(
                                    cancelarFunction: () {
                                      setState(
                                          () => targetDetalleHabitacion = 0);
                                      Future.delayed(
                                        800.ms,
                                        () => setState(
                                          () {
                                            inList = true;
                                            inDetail = false;
                                            targetHabitaciones = 1;
                                          },
                                        ),
                                      );
                                    },
                                  )
                                    .animate(target: targetDetalleHabitacion)
                                    // .slideX(
                                    //     duration: 900.ms,
                                    //     begin: 0.5,
                                    //     curve: Curves.easeInOutBack)
                                    .fadeIn(duration: 850.ms),
                          ),
                          const SizedBox(height: 12),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 4.0),
                          //   child: Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: SizedBox(
                          //       width: 200,
                          //       height: 40,
                          //       child: Buttons.commonButton(
                          //               onPressed: () async {
                          //                 if (_formKeyCotizacion.currentState!
                          //                     .validate()) {
                          //                   if (habitaciones.isEmpty &&
                          //                       dropdownValue ==
                          //                           'Cotización Individual') {
                          //                     showSnackBar(
                          //                       type: "alert",
                          //                       context: context,
                          //                       title:
                          //                           "Cotizaciones no registradas",
                          //                       message:
                          //                           "Se requiere al menos una cotización",
                          //                     );
                          //                     return;
                          //                   }

                          //                   setState(() => isLoading = true);

                          //                   if (!(await CotizacionService()
                          //                       .createCotizacion(
                          //                           cotizacion: comprobante,
                          //                           habitaciones:
                          //                               habitaciones.isNotEmpty
                          //                                   ? habitaciones
                          //                                   : null,
                          //                           folio: folio,
                          //                           prefijoInit: prefijoInit,
                          //                           isQuoteGroup: dropdownValue ==
                          //                               'Cotización Grupos'))) {
                          //                     if (!context.mounted) return;
                          //                     showSnackBar(
                          //                       type: "danger",
                          //                       context: context,
                          //                       title:
                          //                           "Error al registrar la cotizacion",
                          //                       message:
                          //                           "Se produjo un error al insertar la nueva cotización.",
                          //                     );
                          //                     return;
                          //                   }

                          //                   receiptQuotePresent = comprobante;
                          //                   receiptQuotePresent.folioPrincipal =
                          //                       folio;
                          //                   quotesIndPresent = habitaciones;

                          //                   comprobantePDF = await ref
                          //                       .watch(HabitacionProvider
                          //                           .provider.notifier)
                          //                       .generarComprobante(
                          //                           comprobante);

                          //                   ref
                          //                       .read(
                          //                           cotizacionProvider.notifier)
                          //                       .update(
                          //                           (state) => Cotizacion());
                          //                   ref
                          //                       .watch(HabitacionProvider
                          //                           .provider.notifier)
                          //                       .clear();

                          //                   ref
                          //                       .read(uniqueFolioProvider
                          //                           .notifier)
                          //                       .update((state) => UniqueKey()
                          //                           .hashCode
                          //                           .toString());

                          //                   ref
                          //                       .read(changeProvider.notifier)
                          //                       .update((state) =>
                          //                           UniqueKey().hashCode);

                          //                   if (!context.mounted) return;
                          //                   Future.delayed(
                          //                       Durations.long2,
                          //                       () => setState(
                          //                           () => isFinish = true));
                          //                 }
                          //               },
                          //               text: "Generar cotización",
                          //               color: DesktopColors.prussianBlue)
                          //           .animate()
                          //           .fadeIn(
                          //             delay: const Duration(
                          //               milliseconds: 1000,
                          //             ),
                          //           ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    if (isLoading && !isFinish)
                      ProgressIndicatorCustom(screenHight: screenHight),
                    if (isFinish)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: SizedBox(
                          height: screenHight * 0.89,
                          child: PdfPreview(
                            loadingWidget: Center(
                              child: LoadingAnimationWidget.fourRotatingDots(
                                color: Colors.grey,
                                size: 45,
                              ),
                            ),
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
