import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/helpers/utility.dart';

import '../helpers/web_colors.dart';
import 'text_styles.dart';

class ComprobanteItemRow extends StatefulWidget {
  const ComprobanteItemRow({
    Key? key,
    required this.comprobante,
    required this.index,
    required this.screenWidth,
    this.seeReceipt,
    this.deleteReceipt,
    this.isQuery = false,
  }) : super(key: key);

  final ReceiptQuoteData comprobante;
  final int index;
  final double screenWidth;
  final void Function()? seeReceipt;
  final void Function()? deleteReceipt;
  final bool isQuery;

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
          leading: widget.isQuery
              ? null
              : TextStyles.TextTitleList(index: widget.index + 1),
          title: TextStyles.titleText(
              color: DesktopColors.prussianBlue,
              text: "Huesped: ${widget.comprobante.nameCustomer}",
              size: widget.isQuery ? 13 : 16),
          subtitle: Wrap(
            spacing: 10,
            children: [
              TextStyles.TextAsociative(
                "Folio: ",
                widget.comprobante.folioQuotes,
                size: widget.isQuery ? 11 : 12,
              ),
              TextStyles.TextAsociative(
                "Fecha: ",
                "${widget.comprobante.dateRegister.toIso8601String().substring(0, 10)} ${widget.comprobante.dateRegister.toIso8601String().substring(11, 16)}",
                size: widget.isQuery ? 11 : 12,
              ),
              TextStyles.TextAsociative(
                "Tarifa: ",
                Utility.formatterNumber(widget.comprobante.rateDay),
                size: widget.isQuery ? 11 : 12,
              ),
              TextStyles.TextAsociative(
                "Total: ",
                Utility.formatterNumber(widget.comprobante.total),
                size: widget.isQuery ? 11 : 12,
              ),
            ],
          ),
          trailing: widget.isQuery
              ? null
              : Wrap(
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
                          color: DesktopColors.ceruleanOscure,
                          CupertinoIcons.eye,
                        ),
                      )
                    else
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: DesktopColors.ceruleanOscure,
                          )),
                    IconButton(
                        onPressed: widget.deleteReceipt,
                        icon: Icon(
                            color: DesktopColors.ceruleanOscure,
                            CupertinoIcons.delete_solid))
                  ],
                ),
        ),
      ),
    );
  }
}
