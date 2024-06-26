import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/helpers/web_colors.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:sidebarx/sidebarx.dart';

import '../services/comprobante_service.dart';
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

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void fetchData({int pag = 1}) async {
    isLoading = true;
    setState(() {});
    List<ReceiptQuoteData> resp =
        await ComprobanteService().getComprobantesLocales();
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
              TextStyles.titlePagText(text: "Historial"),
              const Divider(color: Colors.black54),
              if (!isLoading)
                SizedBox(
                  width: screenWidth,
                  child: ListView.builder(
                    itemCount: comprobantes.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ComprobanteItemRow(
                        comprobante: comprobantes[index],
                        index: index,
                        screenWidth: screenWidth,
                        expandedSideBar: widget.sideController.extended,
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
