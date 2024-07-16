import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/configuracion_provider.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:printing/printing.dart';
import '../../utils/helpers/web_colors.dart';
import '../../widgets/carousel_widget.dart';
import '../../widgets/form_widgets.dart';

import 'package:animated_custom_dropdown/custom_dropdown.dart';

class ConfigFormatoView extends ConsumerStatefulWidget {
  const ConfigFormatoView({super.key});

  @override
  _ConfigFormatoViewState createState() => _ConfigFormatoViewState();
}

class _ConfigFormatoViewState extends ConsumerState<ConfigFormatoView> {
  bool isLoading = false;
  Color colorLogoInd = DesktopColors.colorLogo;
  Color colorTableInd = DesktopColors.colorTables;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final docIndividualSync = ref.watch(documentQuoteIndProvider(""));
    final docGroupSync = ref.watch(documentQuoteGroupProvider(""));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          docGroupSync.when(
            data: (document) {
              return SizedBox(
                height: screenHight * 0.85,
                child: PdfPreview(
                  build: (format) => document.save(),
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
                          bytes: await document.save(),
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.share,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          ref
                              .read(changeDocGroupProvider.notifier)
                              .update((state) => UniqueKey().hashCode);
                        },
                        icon: const Icon(Icons.change_circle_outlined))
                  ],
                ),
              );
            },
            error: (error, stackTrace) {
              print(error.toString());
              return const Text('No se encontraron resultados');
            },
            loading: () {
              return SizedBox(
                  width: screenWidth * 0.5,
                  child: ProgressIndicatorCustom(screenHight * 0.2));
            },
          ),
          /*
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
                            const SizedBox(height: 10),
                            FormWidgets.inputColor(
                                primaryColor: colorTableInd,
                                nameInput: "Color de tablas: ",
                                verticalPadding: 12),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Wrap(
                                // crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  TextStyles.standardText(
                                      text: "Fuente de texto:"),
                                  SizedBox(
                                    child: CustomDropdown<String>.search(
                                      searchHintText: "Buscar",
                                      hintText:
                                          "Selecciona la nueva fuente del documento",
                                      closedHeaderPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                      items: textFont,
                                      decoration: CustomDropdownDecoration(
                                          closedBorderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5)),
                                          expandedBorderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(4)),
                                          closedBorder:
                                              Border.all(color: Colors.grey)),
                                      initialItem: textFont.first,
                                      onChanged: (p0) {},
                                      headerBuilder:
                                          (context, selectedItem, enabled) =>
                                              Text(
                                        selectedItem,
                                        style: TextStyle(
                                            fontFamily:
                                                "${selectedItem.toLowerCase().replaceAll(' ', '')}_regular"),
                                      ),
                                      listItemBuilder: (context, item,
                                              isSelected, onItemSelect) =>
                                          Text(
                                        item,
                                        style: TextStyle(
                                            fontFamily:
                                                "${item.toLowerCase().replaceAll(' ', '')}_regular"),
                                      ),
                                    ),
                                  )
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
              docIndividualSync.when(
                data: (document) {
                  return Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 458,
                      child: PdfPreview(
                        build: (format) => document.save(),
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
                                bytes: await document.save(),
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
                  );
                },
                error: (error, stackTrace) {
                  return const Text('No se encontraron resultados');
                },
                loading: () {
                  return SizedBox(
                      width: screenWidth * 0.5,
                      child: ProgressIndicatorCustom(screenHight * 0.2));
                },
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
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Wrap(
                                // crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  TextStyles.standardText(
                                      text: "Fuente de texto:"),
                                  SizedBox(
                                    child: CustomDropdown<String>.search(
                                      searchHintText: "Buscar",
                                      hintText:
                                          "Selecciona la nueva fuente del documento",
                                      closedHeaderPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                      items: textFont,
                                      decoration: CustomDropdownDecoration(
                                          closedBorderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5)),
                                          expandedBorderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(4)),
                                          closedBorder:
                                              Border.all(color: Colors.grey)),
                                      initialItem: textFont.first,
                                      onChanged: (p0) {},
                                      headerBuilder:
                                          (context, selectedItem, enabled) =>
                                              Text(
                                        selectedItem,
                                        style: TextStyle(
                                            fontFamily:
                                                "${selectedItem.toLowerCase().replaceAll(' ', '')}_regular"),
                                      ),
                                      listItemBuilder: (context, item,
                                              isSelected, onItemSelect) =>
                                          Text(
                                        item,
                                        style: TextStyle(
                                            fontFamily:
                                                "${item.toLowerCase().replaceAll(' ', '')}_regular"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
              docIndividualSync.when(
                data: (document) {
                  return Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 458,
                      child: PdfPreview(
                        build: (format) => document.save(),
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
                                bytes: await document.save(),
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
                  );
                },
                error: (error, stackTrace) {
                  return const Text('No se encontraron resultados');
                },
                loading: () {
                  return SizedBox(
                      width: screenWidth * 0.5,
                      child: ProgressIndicatorCustom(screenHight * 0.2));
                },
              ),
            ],
          ),
          */
        ],
      ),
    );
  }
}
