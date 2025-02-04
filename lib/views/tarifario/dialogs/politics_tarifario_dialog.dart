import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../services/tarifa_service.dart';
import '../../../ui/buttons.dart';
import '../../../ui/show_snackbar.dart';
import '../../../ui/title_page.dart';
import '../../../utils/helpers/desktop_colors.dart';
import '../../../utils/helpers/utility.dart';
import '../../../widgets/form_widgets.dart';
import '../../../widgets/text_styles.dart';

class PoliticsTarifarioDialog extends StatefulWidget {
  const PoliticsTarifarioDialog({Key? key, required this.policy})
      : super(key: key);

  final Politica? policy;

  @override
  State<PoliticsTarifarioDialog> createState() =>
      _PoliticsTarifarioDialogState();
}

class _PoliticsTarifarioDialogState extends State<PoliticsTarifarioDialog> {
  final _formKeyPolitics = GlobalKey<FormState>();
  int intervaloHabitacion = 0;
  int limiteCotizacionGrupal = 0;
  int vigenciaCotInd = 0;
  int vigenciaCotGrup = 0;
  bool inProcess = false;

  @override
  void initState() {
    super.initState();
    intervaloHabitacion = widget.policy == null
        ? 1
        : widget.policy?.intervaloHabitacionGratuita ?? 0;
    limiteCotizacionGrupal = widget.policy == null
        ? 1
        : widget.policy?.limiteHabitacionCotizacion ?? 0;

    vigenciaCotInd =
        widget.policy == null ? 1 : widget.policy?.diasVigenciaCotInd ?? 0;

    vigenciaCotGrup =
        widget.policy == null ? 1 : widget.policy?.diasVigenciaCotGroup ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        height: 480,
        width: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TitlePage(
                      icons: HeroIcons.adjustments_horizontal,
                      isDialog: true,
                      title: "Políticas y criterios de Aplicación",
                      subtitle:
                          "Ultima modificación: ${Utility.getCompleteDate(data: widget.policy?.fechaActualizacion)}",
                    ),
                    Divider(
                        color: Theme.of(context).primaryColor, thickness: 0.6),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: SizedBox(
                        width: 450,
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKeyPolitics,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormWidgets.inputCountField(
                                  colorText: Theme.of(context).primaryColor,
                                  widthInput: 70,
                                  sizeText: 13.3,
                                  nameField:
                                      "Intervalo de Aplicación para Habitaciones\nde Cortesía",
                                  description:
                                      "Determina el número de habitaciones valido\npara aplicar una habitación gratis para\ncotizaciones grupales.",
                                  initialValue: intervaloHabitacion.toString(),
                                  onChanged: (p0) => intervaloHabitacion =
                                      p0.isEmpty ? 1 : int.parse(p0),
                                  onDecrement: (p0) =>
                                      intervaloHabitacion = p0 < 1 ? 1 : p0,
                                  onIncrement: (p0) => intervaloHabitacion = p0,
                                ),
                                const SizedBox(height: 30),
                                FormWidgets.inputCountField(
                                  colorText: Theme.of(context).primaryColor,
                                  widthInput: 70,
                                  sizeText: 13.3,
                                  nameField:
                                      "Limite de Habitaciones para Cotizaciones\nIndividuales",
                                  description:
                                      "Especifica el número máximo de habitaciones\npara una cotización individual. Más de este\nnúmero será considerado una cotización grupal.",
                                  initialValue:
                                      limiteCotizacionGrupal.toString(),
                                  onChanged: (p0) => limiteCotizacionGrupal =
                                      p0.isEmpty ? 1 : int.parse(p0),
                                  onDecrement: (p0) =>
                                      limiteCotizacionGrupal = p0 < 1 ? 1 : p0,
                                  onIncrement: (p0) =>
                                      limiteCotizacionGrupal = p0,
                                ),
                                const SizedBox(height: 30),
                                FormWidgets.inputCountField(
                                  colorText: Theme.of(context).primaryColor,
                                  widthInput: 70,
                                  sizeText: 13.3,
                                  nameField:
                                      "Vigencia para Cotizaciones Individuales",
                                  definition: "Dias",
                                  initialValue: vigenciaCotInd.toString(),
                                  onChanged: (p0) => vigenciaCotInd =
                                      p0.isEmpty ? 1 : int.parse(p0),
                                  onDecrement: (p0) =>
                                      vigenciaCotInd = p0 < 1 ? 1 : p0,
                                  onIncrement: (p0) => vigenciaCotInd = p0,
                                ),
                                const SizedBox(height: 30),
                                FormWidgets.inputCountField(
                                  colorText: Theme.of(context).primaryColor,
                                  widthInput: 70,
                                  sizeText: 13.3,
                                  nameField:
                                      "Vigencia para Cotizaciones Grupales",
                                  definition: "Dias",
                                  initialValue: vigenciaCotGrup.toString(),
                                  onChanged: (p0) => vigenciaCotGrup =
                                      p0.isEmpty ? 1 : int.parse(p0),
                                  onDecrement: (p0) =>
                                      vigenciaCotGrup = p0 < 1 ? 1 : p0,
                                  onIncrement: (p0) => vigenciaCotGrup = p0,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: TextStyles.standardText(
                      text: "Cancelar",
                      isBold: true,
                      size: 12.5,
                      color: brightness == Brightness.light
                          ? DesktopColors.cerulean
                          : DesktopColors.azulUltClaro,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Buttons.commonButton(
                    text: "Guardar",
                    isLoading: inProcess,
                    sizeText: 12.5,
                    onPressed: () async {
                      Politica savePolicy = Politica(
                        id: widget.policy?.id ?? 0,
                        intervaloHabitacionGratuita: intervaloHabitacion,
                        fechaActualizacion: DateTime.now(),
                        limiteHabitacionCotizacion: limiteCotizacionGrupal,
                        diasVigenciaCotGroup: vigenciaCotGrup,
                        diasVigenciaCotInd: vigenciaCotInd,
                      );

                      bool responseSavePolicy =
                          await TarifaService().saveTariffPolicy(savePolicy);

                      if (!context.mounted) return;

                      if (!responseSavePolicy) {
                        if (mounted) return;
                        showSnackBar(
                            context: context,
                            title: "Error de guardado",
                            message:
                                "Se detecto un error al intentar guardar las tarifas. Intentelo más tarde.",
                            type: "danger");
                        return;
                      }

                      showSnackBar(
                        context: context,
                        title:
                            "Politicas ${widget.policy?.id != 0 ? "Actualizadas" : "Implementadas"}",
                        message:
                            "Las politicas de implementación de tarifas fue ${widget.policy?.id != 0 ? "actualizada" : "guardada"} con exito",
                        type: "success",
                        iconCustom:
                            widget.policy?.id != 0 ? Icons.edit : Icons.save,
                      );

                      Navigator.of(context).pop(savePolicy);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
