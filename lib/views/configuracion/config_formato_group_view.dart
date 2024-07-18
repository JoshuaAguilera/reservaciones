import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/configuracion_provider.dart';
import 'package:generador_formato/ui/custom_widgets.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:printing/printing.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import '../../utils/helpers/web_colors.dart';
import '../../widgets/carousel_widget.dart';
import '../../widgets/form_widgets.dart';

import 'package:animated_custom_dropdown/custom_dropdown.dart';

class ConfigFormatoGroupView extends ConsumerStatefulWidget {
  const ConfigFormatoGroupView({super.key, required this.sideController});

  final SidebarXController sideController;

  @override
  _ConfigFormatoViewState createState() => _ConfigFormatoViewState();
}

class _ConfigFormatoViewState extends ConsumerState<ConfigFormatoGroupView> {
  bool isLoading = false;
  Color colorLogoInd = DesktopColors.colorLogo;
  Color colorTableInd = DesktopColors.colorTablesInd;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final docGroupSync = ref.watch(documentQuoteGroupProvider(""));

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
                  maxAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    TextStyles.mediumText(
                        text: "Formato de cotizaciones grupales",
                        color: DesktopColors.prussianBlue),
                    const SizedBox(height: 10),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: [
                        FormWidgets.inputColor(
                            primaryColor: colorLogoInd,
                            nameInput: "Color de logotipo: "),
                        FormWidgets.inputColor(
                            primaryColor: colorTableInd,
                            nameInput: "Color de tablas: ",
                            verticalPadding: 12),
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
                          child: Wrap(
                            children: [
                              TextStyles.standardText(text: "Fuente de texto:"),
                              SizedBox(
                                child: CustomDropdown<String>.search(
                                  searchHintText: "Buscar",
                                  hintText:
                                      "Selecciona la nueva fuente del documento",
                                  closedHeaderPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 13),
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
                                      (context, selectedItem, enabled) => Text(
                                    selectedItem,
                                    style: TextStyle(
                                        fontFamily:
                                            "${selectedItem.toLowerCase().replaceAll(' ', '')}_regular"),
                                  ),
                                  listItemBuilder: (context, item, isSelected,
                                          onItemSelect) =>
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
                    SizedBox(
                      width: Utility.getWidthDynamicCarrousel(screenWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 5),
                            child: TextStyles.standardText(
                                text: "Imagenes adjuntas:"),
                          ),
                          CarouselWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              docGroupSync.when(
                data: (document) {
                  return SizedBox(
                    width: screenWidth < 1100
                        ? screenWidth
                        : screenWidth -
                            (screenWidth * 0.33) -
                            (widget.sideController.extended ? 240 : 125),
                    height: screenWidth < 1100
                        ? screenHight * 0.6
                        : screenHight * 0.85,
                    child: PdfPreview(
                      padding: const EdgeInsets.all(0),
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
            ],
          ),
        ],
      ),
    );
  }
}
