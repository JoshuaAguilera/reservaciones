import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/ui/title_page.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/providers/cotizacion_provider.dart';
import 'package:generador_formato/providers/habitacion_provider.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/views/generacion_cotizaciones/habitaciones_list.dart';
import 'package:generador_formato/views/generacion_cotizaciones/manager_tariff_group_dialog.dart';
import 'package:generador_formato/views/generacion_cotizaciones/pdf_cotizacion_view.dart';
import 'package:generador_formato/widgets/summary_controller_widget.dart';
import 'package:generador_formato/widgets/custom_dropdown.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../models/prefijo_telefonico_model.dart';
import '../../providers/dahsboard_provider.dart';
import '../../providers/tarifario_provider.dart';
import '../../services/cotizacion_service.dart';
import '../../ui/show_snackbar.dart';
import '../../utils/helpers/constants.dart';

class GenerarCotizacionView extends ConsumerStatefulWidget {
  final SidebarXController sideController;
  const GenerarCotizacionView({Key? key, required this.sideController})
      : super(key: key);

  @override
  GenerarCotizacionViewState createState() => GenerarCotizacionViewState();
}

class GenerarCotizacionViewState extends ConsumerState<GenerarCotizacionView> {
  final _formKeyCotizacion = GlobalKey<FormState>();
  late pw.Document comprobantePDF;
  bool isLoading = false;
  bool isFinish = false;

  Cotizacion receiptQuotePresent = Cotizacion();
  List<Habitacion> quotesIndPresent = [];
  double targetHabitaciones = 1;
  double targetDetalleHabitacion = 1;
  bool inDetail = false;
  bool inList = true;

  PrefijoTelefonico prefijoInit = getPrefijosTelefonicos().first;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final habitaciones = ref.watch(HabitacionProvider.provider);
    final cotizacion = ref.watch(cotizacionProvider);
    final folio = ref.watch(uniqueFolioProvider);
    final typeQuote = ref.watch(typeQuoteProvider);

    void _goDetailRoom(Habitacion habitacion) {
      Habitacion habitacionSelect = habitacion.CopyWith();
      habitacionSelect.tarifaXDia = [];
      for (var element in habitacion.tarifaXDia!) {
        habitacionSelect.tarifaXDia!.add(element.copyWith());
      }

      ref
          .read(habitacionSelectProvider.notifier)
          .update((state) => habitacionSelect);
      final tarifasProvider = TarifasProvisionalesProvider.provider;
      ref.read(tarifasProvider.notifier).clear();
      ref.read(descuentoProvisionalProvider.notifier).update((state) => 0);
      setState(() => targetHabitaciones = 0);
      ref
          .read(detectChangeProvider.notifier)
          .update((state) => UniqueKey().hashCode);

      Future.delayed(
        800.ms,
        () => setState(
          () {
            inList = false;
            inDetail = true;
            targetDetalleHabitacion = 1;
          },
        ),
      );

      Future.delayed(1000.ms, () => widget.sideController.selectIndex(16));
    }

    void _showConfigurationTariffGroup({bool firstView = false}) {
      showDialog(
        context: context,
        builder: (context) => const ManagerTariffGroupDialog(),
      ).then(
        (value) {
          if (value == null && firstView) {
            ref
                .watch(HabitacionProvider.provider.notifier)
                .implementGroupTariff([]);
          } else {
            if (value == null) return;

            List<TarifaXDia?> selectTariffs = value;
            ref
                .watch(HabitacionProvider.provider.notifier)
                .implementGroupTariff(selectTariffs);
          }
        },
      );
    }

    ref.listen<bool>(typeQuoteProvider, (previous, next) {
      if (next) {
        _showConfigurationTariffGroup(firstView: true);
      } else {
        ref.watch(HabitacionProvider.provider.notifier).removeGroupTariff();
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Form(
                      key: _formKeyCotizacion,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitlePage(
                            title: "Generar cotización",
                            subtitle:
                                "Proporcione un presupuesto detallado y claro a los clientes interesados en hacer una reservación",
                          )
                              .animate(target: targetHabitaciones)
                              .fadeIn(duration: 250.ms),
                          if (!isLoading)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                SizedBox(
                                  child: (!typeQuote)
                                      ? cardTypeQuote(
                                          type: "Cotización Individual",
                                          color: DesktopColors.cotIndiv,
                                          withTarget: typeQuote,
                                        )
                                      : cardTypeQuote(
                                          type: "Cotización Grupal",
                                          color: DesktopColors.cotGrupal,
                                          withTarget: !typeQuote,
                                          withButton: true,
                                          onPressedButton: () {
                                            _showConfigurationTariffGroup();
                                          },
                                        ),
                                )
                                    .animate(target: targetHabitaciones)
                                    .fadeIn(duration: 350.ms),
                                const SizedBox(height: 8),
                                Card(
                                  elevation: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextStyles.titleText(
                                            text: "Datos del huesped",
                                            textAlign: TextAlign.start,
                                            color:
                                                Theme.of(context).dividerColor,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Nombre completo",
                                          msgError: "Campo requerido*",
                                          initialValue:
                                              cotizacion.nombreHuesped,
                                          isRequired: true,
                                          onChanged: (p0) {
                                            cotizacion.nombreHuesped = p0;
                                          },
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                flex: 0,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: CustomDropdown
                                                      .dropdownPrefijoNumerico(
                                                    initialSelection:
                                                        prefijoInit,
                                                    onSelected:
                                                        (PrefijoTelefonico?
                                                            value) {
                                                      setState(() {
                                                        prefijoInit = value!;
                                                      });
                                                    },
                                                    elements:
                                                        getPrefijosTelefonicos(),
                                                    screenWidth: null,
                                                  ),
                                                )),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: TextFormFieldCustom
                                                  .textFormFieldwithBorder(
                                                name: "Teléfono",
                                                msgError: "Campo requerido*",
                                                initialValue:
                                                    cotizacion.numeroTelefonico,
                                                isNumeric: true,
                                                isDecimal: false,
                                                isRequired: true,
                                                onChanged: (p0) {
                                                  cotizacion.numeroTelefonico =
                                                      p0;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: TextFormFieldCustom
                                                  .textFormFieldwithBorder(
                                                name: "Correo electronico",
                                                msgError: "Campo requerido*",
                                                initialValue: cotizacion
                                                    .correoElectronico,
                                                isRequired: true,
                                                onChanged: (p0) {
                                                  cotizacion.correoElectronico =
                                                      p0;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                    .animate(target: targetHabitaciones)
                                    .fadeIn(duration: 250.ms),
                                const SizedBox(height: 10),
                                SizedBox(
                                  child: HabitacionesList(
                                    newRoom: () => _goDetailRoom(Habitacion(
                                      categoria: tipoHabitacion.first,
                                      adultos: 1,
                                      menores0a6: 0,
                                      menores7a12: 0,
                                      tarifaXDia: [],
                                      isFree: false,
                                      fechaCheckIn: DateTime.now()
                                          .toString()
                                          .substring(0, 10),
                                      fechaCheckOut: DateTime.now()
                                          .add(const Duration(days: 1))
                                          .toString()
                                          .substring(0, 10),
                                    )),
                                    editRoom: (p0) =>
                                        _goDetailRoom(p0.CopyWith()),
                                    duplicateRoom: (p0) {
                                      Habitacion roomDuplicate = p0.CopyWith();
                                      roomDuplicate.folioHabitacion =
                                          UniqueKey()
                                              .toString()
                                              .replaceAll('[', '')
                                              .replaceAll(']', '');

                                      roomDuplicate.count = 1;

                                      ref
                                          .read(HabitacionProvider
                                              .provider.notifier)
                                          .addItem(roomDuplicate, typeQuote);

                                      final politicaTarifaProvider =
                                          ref.watch(tariffPolicyProvider(""));
                                      final habitaciones = ref
                                          .watch(HabitacionProvider.provider);

                                      politicaTarifaProvider.when(
                                        data: (data) {
                                          if (data != null) {
                                            int rooms = 0;
                                            for (var element in habitaciones) {
                                              if (!element.isFree) {
                                                rooms += element.count;
                                              }
                                            }

                                            if (!typeQuote &&
                                                rooms >=
                                                    data
                                                        .limiteHabitacionCotizacion!) {
                                              ref
                                                  .watch(typeQuoteProvider
                                                      .notifier)
                                                  .update((ref) => true);
                                            } else if (typeQuote &&
                                                rooms <
                                                    data.limiteHabitacionCotizacion!) {
                                              ref
                                                  .watch(typeQuoteProvider
                                                      .notifier)
                                                  .update((ref) => false);
                                            }
                                          }
                                        },
                                        error: (error, stackTrace) {
                                          print("Politicas no encontradas");
                                        },
                                        loading: () {
                                          print("Cargando politicas");
                                        },
                                      );
                                    },
                                    deleteRoom: (p0) {
                                      ref
                                          .read(HabitacionProvider
                                              .provider.notifier)
                                          .remove(p0);

                                      final typeQuote =
                                          ref.watch(typeQuoteProvider);
                                      final politicaTarifaProvider =
                                          ref.watch(tariffPolicyProvider(""));

                                      politicaTarifaProvider.when(
                                        data: (data) {
                                          if (data != null) {
                                            int rooms = 0;
                                            for (var element in habitaciones) {
                                              if (!element.isFree)
                                                rooms += element.count;
                                            }

                                            if (!typeQuote &&
                                                rooms >=
                                                    data
                                                        .limiteHabitacionCotizacion!) {
                                              ref
                                                  .watch(typeQuoteProvider
                                                      .notifier)
                                                  .update((ref) => true);
                                            } else if (typeQuote &&
                                                rooms <
                                                    data.limiteHabitacionCotizacion!) {
                                              ref
                                                  .watch(typeQuoteProvider
                                                      .notifier)
                                                  .update((ref) => false);
                                            }
                                          }
                                        },
                                        error: (error, stackTrace) {
                                          print("Politicas no encontradas");
                                        },
                                        loading: () {
                                          print("Cargando politicas");
                                        },
                                      );

                                      ref
                                          .read(
                                              detectChangeRoomProvider.notifier)
                                          .update(
                                              (state) => UniqueKey().hashCode);
                                    },
                                    sideController: widget.sideController,
                                    habitaciones: habitaciones
                                        .where((element) => !element.isFree)
                                        .toList(),
                                  ),
                                )
                                    .animate(target: targetHabitaciones)
                                    .fadeIn(duration: 450.ms),
                                const SizedBox(height: 12),
                              ],
                            ),
                          if (isLoading && !isFinish)
                            ProgressIndicatorCustom(screenHight: screenHeight),
                          if (isFinish)
                            PdfCotizacionView(
                              comprobantePDF: comprobantePDF,
                              cotizacion: receiptQuotePresent,
                            ),
                        ],
                      ),
                    ),
                  ),
                  SummaryControllerWidget(
                    isLoading: isLoading,
                    saveRooms:
                        isFinish ? receiptQuotePresent.habitaciones : null,
                    finishQuote: isFinish,
                    onSaveQuote: isFinish
                        ? () => setState(() {
                              isFinish = false;
                              isLoading = false;
                            })
                        : () async {
                            if (!_formKeyCotizacion.currentState!.validate())
                              return;
                            if (habitaciones
                                .where((element) => !element.isFree)
                                .toList()
                                .isEmpty) {
                              showSnackBar(
                                  type: "alert",
                                  context: context,
                                  iconCustom: CupertinoIcons.tray_fill,
                                  duration: 3.seconds,
                                  title: "Habitaciones no registradas",
                                  message:
                                      "Se requiere al menos una habitación para generar esta cotización.");
                              return;
                            }

                            if (!(await CotizacionService().createCotizacion(
                              cotizacion: cotizacion,
                              habitaciones: habitaciones,
                              folio: folio,
                              prefijoInit: prefijoInit,
                              isQuoteGroup: typeQuote,
                            ))) {
                              if (!context.mounted) return;
                              showSnackBar(
                                type: "danger",
                                context: context,
                                title: "Error al registrar la cotizacion",
                                message:
                                    "Se produjo un error al insertar la nueva cotización.",
                              );
                              return;
                            }

                            setState(() => isLoading = true);

                            receiptQuotePresent = cotizacion.CopyWith();
                            receiptQuotePresent.folioPrincipal = folio;
                            receiptQuotePresent.esGrupo = typeQuote;
                            receiptQuotePresent.numeroTelefonico = prefijoInit.prefijo + (cotizacion.numeroTelefonico ?? '');
                            receiptQuotePresent.habitaciones = [];
                            for (var element in habitaciones) {
                              receiptQuotePresent.habitaciones!
                                  .add(element.CopyWith());
                            }

                            comprobantePDF = await ref
                                .watch(HabitacionProvider.provider.notifier)
                                .generarComprobante(receiptQuotePresent, typeQuote);

                            ref
                                .read(cotizacionProvider.notifier)
                                .update((state) => Cotizacion());
                            ref
                                .watch(HabitacionProvider.provider.notifier)
                                .clear();

                            ref.read(uniqueFolioProvider.notifier).update(
                                (state) => UniqueKey().hashCode.toString());

                            ref
                                .read(detectChangeProvider.notifier)
                                .update((state) => UniqueKey().hashCode);

                            ref
                                .read(changeProvider.notifier)
                                .update((state) => UniqueKey().hashCode);

                            ref
                                .read(changeHistoryProvider.notifier)
                                .update((state) => UniqueKey().hashCode);

                            ref
                                .read(typeQuoteProvider.notifier)
                                .update((state) => false);

                            if (!context.mounted) return;
                            Future.delayed(Durations.long2,
                                () => setState(() => isFinish = true));
                          },
                  )
                      .animate(target: targetHabitaciones)
                      .fadeIn(duration: 450.ms),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardTypeQuote({
    required String type,
    required Color? color,
    bool withTarget = false,
    bool withButton = false,
    void Function()? onPressedButton,
  }) {
    return Card(
      color: color,
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextStyles.titleText(
                text: type,
                color: Colors.white,
              ),
              if (withButton)
                Buttons.commonButton(
                  onPressed: () {
                    if (onPressedButton == null) return;
                    onPressedButton.call();
                  },
                  color: Utility.darken(color!, 0.15),
                  text: "Gestionar tarifas",
                )
            ],
          ),
        ),
      ),
    ).animate(autoPlay: true, delay: 450.ms).fadeIn(duration: 200.ms).flip();
  }
}
