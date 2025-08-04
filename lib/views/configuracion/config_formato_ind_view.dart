import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/view-models/providers/configuracion_provider.dart';
import 'package:generador_formato/res/ui/buttons.dart';
import 'package:generador_formato/res/ui/custom_widgets.dart';
import 'package:generador_formato/res/ui/progress_indicator.dart';
import 'package:generador_formato/res/helpers/constants.dart';
import 'package:generador_formato/res/ui/text_styles.dart';
import 'package:printing/printing.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../utils/widgets/form_widgets.dart';

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
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            // FormWidgets.inputColor(
                            //   primaryColor: colorLogoInd,
                            //   nameInput: "Color de logotipo: ",
                            //   blocked: applyWhitBlack,
                            //   colorText: Theme.of(context).primaryColor,
                            // ),
                            // FormWidgets.inputColor(
                            //   primaryColor: colorTableInd,
                            //   nameInput: "Color de tablas: ",
                            //   blocked: applyWhitBlack,
                            //   colorText: Theme.of(context).primaryColor,
                            // ),
                            FormWidgets.inputSwitch(
                              value: applyWhitBlack,
                              activeColor: Colors.grey[900],
                              name: "Blanco y negro",
                              onChanged: (p0) {
                                ref
                                    .read(themeDefaultIndProvider.notifier)
                                    .update((state) => p0);
                              },
                              context: context,
                            )
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
                                nameInput: "Imagen de logotipo: ",
                                colorText: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: FormWidgets.inputDropdownFont(
                                title: "Fuente de texto:",
                                font: font,
                                textColor: Theme.of(context).primaryColor,
                                contentColor:
                                    Theme.of(context).primaryColorDark,
                                textFontColor:
                                    Theme.of(context).primaryColorLight,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.bottomRight,
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
                      loadingWidget: ProgressIndicatorCustom(screenHeight: 0),
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
                  return ProgressIndicatorCustom(
                      screenHeight: screenHight * 0.3);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
