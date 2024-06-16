import 'package:flutter/material.dart';
import 'package:generador_formato/services/generador_doc_service.dart';
import 'package:printing/printing.dart';

class PreviewPdfView extends StatelessWidget {
  const PreviewPdfView( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Preview")),
        body:
            PdfPreview(build: (format) => GeneradorDocService().saveDocument()),
      ),
    );
  }
}
