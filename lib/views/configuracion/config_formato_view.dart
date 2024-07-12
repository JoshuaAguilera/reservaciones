import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/models/comprobante_cotizacion_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:printing/printing.dart';
import '../../services/generador_doc_service.dart';
import '../../utils/helpers/web_colors.dart';
import '../../widgets/carousel_widget.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/form_widgets.dart';
import 'package:pdf/widgets.dart' as pw;

class ConfigFormatoView extends StatefulWidget {
  const ConfigFormatoView({super.key});

  @override
  State<ConfigFormatoView> createState() => _ConfigFormatoViewState();
}

class _ConfigFormatoViewState extends State<ConfigFormatoView> {
  late pw.Document comprobantePDF;
  bool isLoading = false;
  Color colorLogoInd = DesktopColors.colorLogo;
  Color colorTableInd = DesktopColors.colorTables;

  @override
  void initState() {
    fetchDoc();
    super.initState();
  }

  void fetchDoc() async {
    if (isLoading) return;
    isLoading = true;
    setState(() {});

    comprobantePDF = await GeneradorDocService().generarComprobanteCotizacion(
        [
          Cotizacion(
            adultos: 1,
            categoria: categorias.first,
            plan: planes.first,
            tarifaRealAdulto: 0,
            esPreVenta: false,
            fechaEntrada: "2021-01-01",
            fechaSalida: "2021-01-05",
            menores0a6: 0,
            menores7a12: 0,
          ),
          Cotizacion(
            adultos: 1,
            categoria: categorias.first,
            plan: planes[1],
            tarifaRealAdulto: 0,
            esPreVenta: false,
            fechaEntrada: "2021-01-01",
            fechaSalida: "2021-01-05",
            menores0a6: 0,
            menores7a12: 0,
          ),
          Cotizacion(
            adultos: 1,
            categoria: categorias[1],
            plan: planes.first,
            tarifaRealAdulto: 0,
            esPreVenta: false,
            fechaEntrada: "2021-01-01",
            fechaSalida: "2021-01-05",
            menores0a6: 0,
            menores7a12: 0,
          ),
          Cotizacion(
            adultos: 1,
            categoria: categorias[1],
            plan: planes[1],
            tarifaRealAdulto: 0,
            esPreVenta: false,
            fechaEntrada: "2021-01-01",
            fechaSalida: "2021-01-05",
            menores0a6: 0,
            menores7a12: 0,
          )
        ],
        ComprobanteCotizacion(
            correo: "example@email.com",
            telefono: "01-800-2020",
            nombre: "Example Lorem ipsut"));

    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 465,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            TextStyles.mediumText(
                                text: "Formato de cotizaciones individuales",
                                color: DesktopColors.prussianBlue),
                            const SizedBox(height: 10),
                            FormWidgets.inputColor(
                                primaryColor: colorLogoInd,
                                nameInput: "Color de logotipo: "),
                            FormWidgets.inputImage(
                                nameInput: "Imagen de logotipo: "),
                            FormWidgets.inputColor(
                                primaryColor: colorTableInd,
                                nameInput: "Color de tablas: "),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  TextStyles.standardText(
                                      text: "Fuente de texto:  "),
                                  /*
                                  DropdownSearch<String>(
    popupProps: PopupProps.menu(
        showSelectedItems: true,
        disabledItemFn: (String s) => s.startsWith('I'),
    ),
    items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
    dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            labelText: "Menu mode",
            hintText: "country in menu mode",
        ),
    ),
    onChanged: print,
    selectedItem: "Brazil",
)
                                  */
                                  // DropdownSearch(
                                  //   key: UniqueKey(),
                                  //   items: textFont,
                                  //   selectedItem: textFont.first,
                                  // )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              if (isLoading)
                SizedBox(
                    width: screenWidth * 0.5,
                    child: ProgressIndicatorCustom(screenHight * 0.2)),
              if (!isLoading)
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 458,
                    child: PdfPreview(
                      build: (format) => comprobantePDF.save(),
                      actionBarTheme: PdfActionBarTheme(
                        backgroundColor: DesktopColors.ceruleanOscure,
                      ),
                      canChangeOrientation: false,
                      canChangePageFormat: false,
                      canDebug: false,
                      allowSharing: false,
                      allowPrinting: false,
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
                            CupertinoIcons.share,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 465,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            TextStyles.mediumText(
                                text: "Formato de cotizaciones grupales",
                                color: DesktopColors.prussianBlue),
                            const SizedBox(height: 10),
                            FormWidgets.inputColor(
                                primaryColor: DesktopColors.turqueza,
                                nameInput: "Color de logotipo: "),
                            FormWidgets.inputImage(
                                nameInput: "Imagen de logotipo: "),
                            FormWidgets.inputColor(
                                primaryColor: DesktopColors.turqueza,
                                nameInput: "Color de tablas: "),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 5),
                              child: TextStyles.standardText(
                                  text: "Imagenes adjuntas:"),
                            ),
                            CarouselWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              if (isLoading)
                SizedBox(
                    width: screenWidth * 0.5,
                    child: ProgressIndicatorCustom(screenHight * 0.2)),
              if (!isLoading)
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 458,
                    child: PdfPreview(
                      build: (format) => comprobantePDF.save(),
                      actionBarTheme: PdfActionBarTheme(
                        backgroundColor: DesktopColors.ceruleanOscure,
                      ),
                      canChangeOrientation: false,
                      canChangePageFormat: false,
                      canDebug: false,
                      allowSharing: false,
                      allowPrinting: false,
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
                            CupertinoIcons.share,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
