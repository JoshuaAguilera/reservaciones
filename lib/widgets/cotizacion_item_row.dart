import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/ui/custom_widgets.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';

import '../utils/helpers/desktop_colors.dart';
import 'text_styles.dart';

class ComprobanteItemRow extends StatefulWidget {
  const ComprobanteItemRow({
    Key? key,
    required this.cotizacion,
    required this.index,
    required this.screenWidth,
    this.seeReceipt,
    this.deleteReceipt,
    this.isQuery = false,
    this.delay = 0,
  }) : super(key: key);

  final CotizacionData cotizacion;
  final int index;
  final double screenWidth;
  final void Function()? seeReceipt;
  final void Function()? deleteReceipt;
  final bool isQuery;
  final int delay;

  @override
  State<ComprobanteItemRow> createState() => _ComprobanteItemRowState();
}

class _ComprobanteItemRowState extends State<ComprobanteItemRow> {
  bool isLoading = false;
  Color? colorText;
  Color? colorTextIndice;
  Color? colorIconDetail;
  Color? colorIconDelete;

  @override
  void initState() {
    super.initState();
    colorText = !widget.cotizacion.esGrupo!
        ? DesktopColors.azulUltClaro
        : DesktopColors.prussianBlue;
    colorTextIndice = !widget.cotizacion.esGrupo!
        ? DesktopColors.azulUltClaro
        : DesktopColors.prussianBlue;
    colorIconDelete = !widget.cotizacion.esGrupo!
        ? DesktopColors.azulCielo
        : DesktopColors.ceruleanOscure;
    colorIconDetail = !widget.cotizacion.esGrupo!
        ? DesktopColors.azulClaro
        : DesktopColors.ceruleanOscure;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 3,
        color: widget.cotizacion.esGrupo!
            ? DesktopColors.cotGrupal
            : DesktopColors.cotIndiv,
        child: ListTile(
          visualDensity: VisualDensity.comfortable,
          leading: widget.isQuery
              ? null
              : TextStyles.TextTitleList(
                  index: widget.index + 1, color: colorTextIndice),
          title: TextStyles.titleText(
              color: colorText,
              text: "Huesped: ${widget.cotizacion.nombreHuesped}",
              size: widget.isQuery ? 13 : 16),
          subtitle: Wrap(
            spacing: 10,
            children: [
              TextStyles.TextAsociative(
                  "Folio: ", widget.cotizacion.folioPrincipal!,
                  size: widget.isQuery ? 11 : 12, color: colorTextIndice),
              TextStyles.TextAsociative("Fecha: ",
                  "${Utility.getCompleteDate(data: widget.cotizacion.fecha)} ${widget.cotizacion.fecha.toIso8601String().substring(11, 16)}",
                  size: widget.isQuery ? 11 : 12, color: colorTextIndice),
              // TextStyles.TextAsociative("Tarifa: ",
              //     Utility.formatterNumber(widget.cotizacion.rateDay),
              //     size: widget.isQuery ? 11 : 12, color: colorTextIndice),
              TextStyles.TextAsociative(
                  "Correo: ", widget.cotizacion.correoElectrico ?? '',
                  size: widget.isQuery ? 11 : 12, color: colorTextIndice),
            ],
          ),
          trailing: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (!(Preferences.rol != "SUPERADMIN" &&
                  Preferences.rol != "ADMIN"))
                CustomWidgets.buildItemGraphics(
                  icon: CupertinoIcons.person_alt_circle,
                  color: colorText!,
                  label: widget.cotizacion.username ?? 'Not found',
                  fontSize: 11.5,
                  iconSize: 16,
                ),
              if (!isLoading && !widget.isQuery)
                IconButton(
                  tooltip: "Detalles",
                  icon: Icon(
                    color: colorIconDetail,
                    CupertinoIcons.eye,
                  ),
                  onPressed: () {
                    widget.seeReceipt!.call();
                    setState(() {
                      isLoading = true;
                    });
                  },
                )
              else if (!widget.isQuery)
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: colorIconDetail,
                  ),
                ),
              if (Preferences.rol != 'RECEPCION' && !widget.isQuery)
                IconButton(
                  tooltip: "Eliminar",
                  icon: Icon(
                    color: colorIconDelete,
                    CupertinoIcons.delete_solid,
                  ),
                  onPressed: widget.deleteReceipt,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
