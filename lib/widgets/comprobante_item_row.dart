import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:generador_formato/views/comprobante_detalle_view.dart';

import '../helpers/web_colors.dart';
import 'text_styles.dart';

class ComprobanteItemRow extends StatefulWidget {
  const ComprobanteItemRow({
    Key? key,
    required this.comprobante,
    required this.index,
    required this.screenWidth,
    required this.expandedSideBar,
    this.seeReceipt,
    this.deleteReceipt
  }) : super(key: key);

  final ReceiptQuoteData comprobante;
  final int index;
  final double screenWidth;
  final bool expandedSideBar;
  final void Function()? seeReceipt;
  final void Function()? deleteReceipt;

  @override
  State<ComprobanteItemRow> createState() => _ComprobanteItemRowState();
}

class _ComprobanteItemRowState extends State<ComprobanteItemRow> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 3,
        color: Colors.blue[200],
        child: ListTile(
          visualDensity: VisualDensity.comfortable,
          leading: TextStyles.TextTitleList(index: widget.index + 1),
          title: TextStyles.titleText(
              color: WebColors.prussianBlue,
              text: "Huesped: ${widget.comprobante.nameCustomer}",
              size: 16),
          subtitle: TextStyles.standardText(
            text:
                "Folio: ${widget.comprobante.folioQuotes}     Fecha: ${widget.comprobante.dateRegister.toIso8601String().substring(0, 10)} ${widget.comprobante.dateRegister.toIso8601String().substring(11, 16)}      Tarifa: ${Utility.formatterNumber(widget.comprobante.rateDay)}     Total: ${Utility.formatterNumber(widget.comprobante.total)}",
            size: 12,
          ),
          trailing: Wrap(
            children: [
              if (!isLoading)
                IconButton(
                  onPressed: () {
                    widget.seeReceipt!.call();
                    setState(() {
                      isLoading = true;
                    });
                  },
                  icon: Icon(
                    color: WebColors.ceruleanOscure,
                    CupertinoIcons.eye,
                  ),
                )
              else
                SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: WebColors.ceruleanOscure,
                    )),
              IconButton(
                  onPressed: widget.deleteReceipt,
                  icon: Icon(
                      color: WebColors.ceruleanOscure,
                      CupertinoIcons.delete_solid))
            ],
          ),
        ),
      ),
    );
  }
}
