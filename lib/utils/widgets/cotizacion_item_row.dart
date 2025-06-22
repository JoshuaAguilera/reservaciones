import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';

import '../../models/cotizacion_model.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/helpers/utility.dart';
import '../../res/ui/custom_widgets.dart';
import '../../res/ui/text_styles.dart';
import '../shared_preferences/preferences.dart';

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

  final Cotizacion cotizacion;
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
  Color? colorItem;
  bool isInvalid = false;
  bool isConcrete = false;
  bool isGroup = false;

  @override
  void initState() {
    super.initState();
    isConcrete = (widget.cotizacion.estatus ?? false);
    isGroup = (widget.cotizacion.esGrupo ?? false);
    isInvalid = !isConcrete &&
        (DateTime.now()
                .compareTo(widget.cotizacion.fechaLimite ?? DateTime.now()) ==
            1);

    colorText = isInvalid
        ? Colors.white
        : !isGroup
            ? isConcrete
                ? DesktopColors.prussianBlue
                : DesktopColors.azulUltClaro
            : DesktopColors.prussianBlue;
    colorTextIndice = isInvalid
        ? Colors.white
        : !isGroup
            ? isConcrete
                ? DesktopColors.prussianBlue
                : DesktopColors.azulUltClaro
            : DesktopColors.prussianBlue;
    colorIconDelete = isInvalid
        ? Colors.white
        : !isGroup
            ? isConcrete
                ? DesktopColors.ceruleanOscure
                : DesktopColors.azulCielo
            : DesktopColors.ceruleanOscure;
    colorIconDetail = isInvalid
        ? Colors.white
        : !isGroup
            ? isConcrete
                ? DesktopColors.ceruleanOscure
                : DesktopColors.azulClaro
            : DesktopColors.ceruleanOscure;
    colorItem = isInvalid
        ? DesktopColors.cotNoConcr
        : isGroup
            ? (widget.cotizacion.estatus ?? false)
                ? DesktopColors.resGrupal
                : DesktopColors.cotGrupal
            : (widget.cotizacion.estatus ?? false)
                ? DesktopColors.resIndiv
                : DesktopColors.cotIndiv;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorItem!, Utility.darken(colorItem!, -0.15)],
            end: Alignment.centerRight,
            begin: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(6),
          // boxShadow: const [BoxShadow(spreadRadius:-1, blurRadius: 5, offset: Offset(0, 1.5))]
        ),
        margin: const EdgeInsets.all(0),
        // elevation: 3,
        child: ListTile(
          visualDensity: VisualDensity.comfortable,
          leading: widget.isQuery
              ? null
              : TextStyles.TextTitleList(
                  index: widget.index + 1, color: colorTextIndice),
          title: TextStyles.titleText(
              color: colorText,
              text: "Huesped: ${widget.cotizacion.cliente?.nombres}",
              size: widget.isQuery ? 13 : 16),
          subtitle: Wrap(
            spacing: 10,
            children: [
              TextStyles.TextAsociative(
                  "Folio: ", widget.cotizacion.folio!,
                  size: widget.isQuery ? 11 : 12, color: colorTextIndice),
              TextStyles.TextAsociative("Fecha: ",
                  "${Utility.getCompleteDate(data: widget.cotizacion.createdAt)} ${widget.cotizacion.createdAt?.toIso8601String().substring(11, 16)}",
                  size: widget.isQuery ? 11 : 12, color: colorTextIndice),
              if (!isConcrete)
                TextStyles.TextAsociative("Vigencia: ",
                    "${Utility.getCompleteDate(data: widget.cotizacion.fechaLimite)} ${widget.cotizacion.fechaLimite?.toIso8601String().substring(11, 16)}",
                    size: widget.isQuery ? 11 : 12, color: colorTextIndice),
              if ((widget.cotizacion.cliente?.correoElectronico ?? '')
                  .isNotEmpty)
                TextStyles.TextAsociative("Correo: ",
                    widget.cotizacion.cliente?.correoElectronico ?? '',
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
                  label: widget.cotizacion.creadoPor?.username != null
                      ? UsuarioTableData.fromJson(jsonDecode(
                                  widget.cotizacion.creadoPor?.nombre ?? "{}"))
                              .username ??
                          ''
                      : 'Not Found',
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
