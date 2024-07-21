import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/configuracion_provider.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/ui/custom_widgets.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:printing/printing.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import '../../utils/helpers/web_colors.dart';
import '../../widgets/form_widgets.dart';

class ConfigFormatoIndView extends ConsumerStatefulWidget {
  const ConfigFormatoIndView({super.key, required this.sideController});

  final SidebarXController sideController;

  @override
  _ConfigFormatoViewState createState() => _ConfigFormatoViewState();
}

class _ConfigFormatoViewState extends ConsumerState<ConfigFormatoIndView> {
  bool isLoading = false;
  Color colorLogoInd = DesktopColors.colorLogo;
  Color colorTableInd = DesktopColors.colorTablesInd;
  String font = textFont.first;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final docIndividualSync = ref.watch(documentQuoteIndProvider(""));
    final applyWhitBlack = ref.watch(themeDefaultIndProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              SizedBox(
                width: screenWidth < 1100 ? screenWidth : screenWidth * 0.33,
                height: screenWidth < 1100 ? null : screenHight * 0.85,
                child: CustomWidgets.containerCard(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        TextStyles.mediumText(
                            text: "Formato de cotizaciones individuales",
                            color: DesktopColors.prussianBlue),
                        const SizedBox(height: 10),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            FormWidgets.inputColor(
                              primaryColor: colorLogoInd,
                              nameInput: "Color de logotipo: ",
                              blocked: applyWhitBlack,
                            ),
                            FormWidgets.inputColor(
                              primaryColor: colorTableInd,
                              nameInput: "Color de tablas: ",
                              verticalPadding: 12,
                              blocked: applyWhitBlack,
                            ),
                            FormWidgets.inputSwitch(
                                value: applyWhitBlack,
                                activeColor: Colors.grey[900],
                                name: "Blanco y negro",
                                onChanged: (p0) {
                                  ref
                                      .read(themeDefaultIndProvider.notifier)
                                      .update((state) => p0);
                                })
                          ],
                        ),
                        Wrap(
                          spacing: 10,
                          runSpacing: 15,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              child: FormWidgets.inputImage(
                                  nameInput: "Imagen de logotipo: "),
                            ),
                            SizedBox(
                              width: 300,
                              child: FormWidgets.inputDropdownFont(
                                  title: "Fuente de texto:", font: font),
                            )
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Buttons.commonButton(
                          onPressed: () {}, text: "  Guardar  "),
                    )
                  ],
                ),
              ),
              docIndividualSync.when(
                data: (document) {
                  return SizedBox(
                    width: screenWidth < 1100
                        ? screenWidth
                        : screenWidth -
                            (screenWidth * 0.33) -
                            (widget.sideController.extended ? 240 : 125),
                    height: screenWidth < 1100
                        ? screenHight * 0.65
                        : screenHight * 0.85,
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
                  );
                },
                error: (error, stackTrace) {
                  return const Text('No se encontraron resultados');
                },
                loading: () {
                  return ProgressIndicatorCustom(screenHight * 0.3);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
