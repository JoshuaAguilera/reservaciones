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
  }) : super(key: key);

  final ReceiptQuoteData comprobante;
  final int index;
  final double screenWidth;
  final bool expandedSideBar;
  final void Function()? seeReceipt;

  @override
  State<ComprobanteItemRow> createState() => _ComprobanteItemRowState();
}

class _ComprobanteItemRowState extends State<ComprobanteItemRow> {
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
              text: "Cliente: ${widget.comprobante.nameCustomer}",
              size: 16),
          subtitle: TextStyles.standardText(
            text:
                "Folio: ${widget.comprobante.folioQuotes}     Fecha: ${widget.comprobante.dateRegister.substring(0, 10)} ${widget.comprobante.dateRegister.substring(11, 16)}      Tarifa: ${Utility.formatterNumber(widget.comprobante.rateDay)}     Total: ${Utility.formatterNumber(widget.comprobante.total)}",
            size: 12,
          ),
          trailing: Wrap(
            children: [
              IconButton(
                  onPressed: widget.seeReceipt,
                  icon: Icon(
                    color: WebColors.ceruleanOscure,
                    CupertinoIcons.eye,
                  )),
              IconButton(
                  onPressed: () {},
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
