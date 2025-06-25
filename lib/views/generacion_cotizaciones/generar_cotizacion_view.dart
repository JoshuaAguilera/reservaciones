import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/res/ui/buttons.dart';
import 'package:generador_formato/res/ui/title_page.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/view-models/providers/cotizacion_provider.dart';
import 'package:generador_formato/view-models/providers/habitacion_provider.dart';
import 'package:generador_formato/res/ui/progress_indicator.dart';
import 'package:generador_formato/res/helpers/utility.dart';
import 'package:generador_formato/views/generacion_cotizaciones/habitaciones_list.dart';
import 'package:generador_formato/views/generacion_cotizaciones/dialogs/manager_tariff_group_dialog.dart';
import 'package:generador_formato/views/generacion_cotizaciones/pdf_cotizacion_view.dart';
import 'package:generador_formato/utils/widgets/form_widgets.dart';
import 'package:generador_formato/utils/widgets/summary_controller_widget.dart';
import 'package:generador_formato/utils/widgets/custom_dropdown.dart';
import 'package:generador_formato/res/ui/text_styles.dart';
import 'package:generador_formato/utils/widgets/textformfield_custom.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../models/notificacion_model.dart';
import '../../models/prefijo_telefonico_model.dart';
import '../../view-models/providers/dahsboard_provider.dart';
import '../../view-models/providers/notificacion_provider.dart';
import '../../view-models/providers/tarifario_provider.dart';
import '../../view-models/services/cotizacion_service.dart';
import '../../res/ui/show_snackbar.dart';
import '../../res/helpers/constants.dart';
import '../../utils/shared_preferences/settings.dart';

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
  bool startflow = false;

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
    final useCashTariff = ref.watch(useCashSeasonProvider);
    final useCashRoomTariff = ref.watch(useCashSeasonRoomProvider);

    if (!startflow) {
      if (useCashRoomTariff) {
        Future.delayed(
          100.ms,
          () => ref.read(useCashSeasonRoomProvider.notifier).update(
                (state) => useCashTariff,
              ),
        );
      }
      startflow = true;
    }

    void _goDetailRoom(Habitacion habitacion) {
      Habitacion habitacionSelect = habitacion.CopyWith();
      habitacionSelect.tarifasXHabitacion = [];
      for (var element in habitacion.tarifasXHabitacion!) {
        habitacionSelect.tarifasXHabitacion!.add(element.copyWith());
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

      ref.read(useCashSeasonRoomProvider.notifier).update(
          (state) => useCashTariff || (habitacion.useCashSeason ?? false));

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

    // if (!(Preferences.rol == 'RECEPCION')) {
    ref.listen<bool>(typeQuoteProvider, (previous, next) {
      if (next) {
        _showConfigurationTariffGroup(firstView: true);
      } else {
        ref.watch(HabitacionProvider.provider.notifier).removeGroupTariff();
      }
    });
    // }

    Future saveQuoteBD({int? limitDay}) async {
      int id = await CotizacionService().createCotizacion(
        cotizacion: cotizacion,
        habitaciones: habitaciones,
        folio: folio,
        prefijoInit: prefijoInit,
        isQuoteGroup: typeQuote,
        limitDay: limitDay,
      );

      if (id == 0) {
        if (!context.mounted) return;
        showSnackBar(
          type: "danger",
          context: context,
          title: "Error al registrar la cotizacion",
          message: "Se produjo un error al insertar la nueva cotización.",
        );
        return;
      }

      receiptQuotePresent = cotizacion.CopyWith();
      receiptQuotePresent.idInt = id;
      receiptQuotePresent.folio = folio;
      receiptQuotePresent.esGrupo = typeQuote;
      // receiptQuotePresent.numeroTelefonico =
      //     (cotizacion.numeroTelefonico ?? '').isEmpty
      //         ? ""
      //         : prefijoInit.prefijo.replaceAll("+", "") +
      //             (cotizacion.numeroTelefonico ?? '');
      receiptQuotePresent.habitaciones = [];
      for (var element in habitaciones) {
        receiptQuotePresent.habitaciones!.add(element.CopyWith());
      }

      comprobantePDF = await ref
          .watch(HabitacionProvider.provider.notifier)
          .generarComprobante(receiptQuotePresent, typeQuote);

      ref.read(cotizacionProvider.notifier).update((state) => Cotizacion());
      ref.watch(HabitacionProvider.provider.notifier).clear();

      ref
          .read(uniqueFolioProvider.notifier)
          .update((state) => UniqueKey().hashCode.toString());

      ref
          .read(detectChangeProvider.notifier)
          .update((state) => UniqueKey().hashCode);

      ref.read(changeProvider.notifier).update((state) => UniqueKey().hashCode);

      ref
          .read(changeHistoryProvider.notifier)
          .update((state) => UniqueKey().hashCode);

      ref.read(typeQuoteProvider.notifier).update((state) => false);

      ref.read(useCashSeasonProvider.notifier).update((state) => false);

      ref.read(useCashSeasonRoomProvider.notifier).update((state) => false);

      final notificaciones = ref.watch(NotificacionProvider.provider);

      Notificacion newNotification = Notificacion(
        idInt: notificaciones.length + 1,
        mensaje: "info",
        createdAt:
            "Nueva cotización a nombre de ${receiptQuotePresent.cliente?.nombres ?? ''} ha sido registrada.",
        id: "Nueva cotización registrada",
      );

      ref.read(userViewProvider.notifier).update((state) => false);

      ref
          .watch(NotificacionProvider.provider.notifier)
          .addItem(newNotification);

      isFinish = true;
      setState(() {});
    }

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
                          ).animate(target: targetHabitaciones).fadeIn(
                                duration:
                                    Settings.applyAnimations ? 250.ms : 0.ms,
                              ),
                          if (!isLoading && !isFinish)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // if (!(Preferences.rol == 'RECEPCION'))
                                const SizedBox(height: 8),
                                // if (!(Preferences.rol == 'RECEPCION'))
                                SizedBox(
                                  child: (!typeQuote)
                                      ? cardTypeQuote(
                                          type: "Cotización Individual",
                                          color: DesktopColors.cotIndiv,
                                          withTarget: typeQuote,
                                          //withSwithCashTariff: true,
                                          useCashTariff: useCashTariff,
                                          onPressedSwitch: (p0) {
                                            ref
                                                .watch(useCashSeasonProvider
                                                    .notifier)
                                                .update((ref) => p0);
                                          },
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
                                ).animate(target: targetHabitaciones).fadeIn(
                                      duration: Settings.applyAnimations
                                          ? 350.ms
                                          : 0.ms,
                                    ),
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
                                          controller: TextEditingController(
                                              text:
                                                  cotizacion.cliente?.nombres ??
                                                      ''),
                                          isRequired: true,
                                          onChanged: (p0) =>
                                              cotizacion.cliente?.nombres = p0,
                                          onUnfocus: () => setState(() {}),
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
                                                name:
                                                    "Numero Telefonico (Contacto o WhatsApp)",
                                                msgError: "Campo requerido*",
                                                controller: TextEditingController(
                                                    text: cotizacion.cliente
                                                            ?.numeroTelefonico ??
                                                        ''),
                                                isNumeric: true,
                                                isDecimal: false,
                                                isRequired: false,
                                                onChanged: (p0) {
                                                  cotizacion.cliente
                                                      ?.numeroTelefonico = p0;
                                                },
                                                onUnfocus: () =>
                                                    setState(() {}),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: TextFormFieldCustom
                                                  .textFormFieldwithBorder(
                                                name: "Correo electronico",
                                                msgError: "Campo requerido*",
                                                controller: TextEditingController(
                                                    text: cotizacion.cliente
                                                            ?.correoElectronico ??
                                                        ''),
                                                isRequired: false,
                                                onChanged: (p0) {
                                                  cotizacion.cliente
                                                      ?.correoElectronico = p0;
                                                },
                                                onUnfocus: () =>
                                                    setState(() {}),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ).animate(target: targetHabitaciones).fadeIn(
                                      duration: Settings.applyAnimations
                                          ? 250.ms
                                          : 0.ms,
                                    ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  child: HabitacionesList(
                                    newRoom: () => _goDetailRoom(
                                      Habitacion(
                                        categoria: tipoHabitacion.first,
                                        adultos: 1,
                                        menores0a6: 0,
                                        menores7a12: 0,
                                        tarifasXHabitacion: [],
                                        esCortesia: false,
                                        checkIn: DateTime.now()
                                            .toString()
                                            .substring(0, 10),
                                        checkOut: DateTime.now()
                                            .add(const Duration(days: 1))
                                            .toString()
                                            .substring(0, 10),
                                      ),
                                    ),
                                    editRoom: (p0) =>
                                        _goDetailRoom(p0.CopyWith()),
                                    duplicateRoom: (p0) {
                                      Habitacion roomDuplicate = p0.CopyWith();
                                      roomDuplicate.id =
                                          Utility.getUniqueCode().toString();

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
                                              if (!element.esCortesia) {
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
                                              if (!element.esCortesia) {
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

                                      ref
                                          .read(
                                              detectChangeRoomProvider.notifier)
                                          .update(
                                              (state) => UniqueKey().hashCode);
                                    },
                                    sideController: widget.sideController,
                                    habitaciones: habitaciones
                                        .where((element) => !element.esCortesia)
                                        .toList(),
                                  ),
                                ).animate(target: targetHabitaciones).fadeIn(
                                      duration: Settings.applyAnimations
                                          ? 450.ms
                                          : 0.ms,
                                    ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          if (isLoading && !isFinish)
                            ProgressIndicatorCustom(
                              screenHight: screenHeight,
                              message: TextStyles.standardText(
                                text: "Generando comprobante de\ncotización",
                                align: TextAlign.center,
                                size: 11,
                              ),
                            ),
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
                    showCancel: (habitaciones.isNotEmpty ||
                        (cotizacion.cliente?.nombres?.isNotEmpty ?? false) ||
                        (cotizacion.cliente?.correoElectronico?.isNotEmpty ??
                            false) ||
                        (cotizacion.cliente?.numeroTelefonico?.isNotEmpty ??
                            false)),
                    onCancel: () {
                      ref
                          .read(cotizacionProvider.notifier)
                          .update((state) => Cotizacion());
                      ref.watch(HabitacionProvider.provider.notifier).clear();

                      setState(() {});
                    },
                    onSaveQuote: isFinish
                        ? () {
                            isFinish = false;
                            isLoading = false;
                            setState(() {});
                          }
                        : () async {
                            if (!_formKeyCotizacion.currentState!.validate()) {
                              return;
                            }

                            if (habitaciones
                                .where((element) => !element.esCortesia)
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

                            setState(() => isLoading = true);
                            final politicaTarifaProvider =
                                ref.watch(tariffPolicyProvider(""));

                            await politicaTarifaProvider.when(
                              data: (data) async {
                                int? limitDay;
                                if (data != null) {
                                  if (typeQuote) {
                                    limitDay = data.diasVigenciaCotGroup;
                                  } else {
                                    limitDay = data.diasVigenciaCotInd;
                                  }
                                }
                                await saveQuoteBD(limitDay: limitDay);
                              },
                              error: (error, stackTrace) {
                                print("Politicas no encontradas");
                              },
                              loading: () {
                                print("Cargando politicas");
                              },
                            );
                            setState(() => isLoading = false);
                          },
                  ).animate(target: targetHabitaciones).fadeIn(
                        duration: Settings.applyAnimations ? 450.ms : 0.ms,
                      ),
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
    bool withSwithCashTariff = false,
    bool useCashTariff = false,
    void Function()? onPressedButton,
    void Function(bool)? onPressedSwitch,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextStyles.titleText(
                text: type,
                color: Colors.white,
              ),
              if (withButton)
                SizedBox(
                  width: 200,
                  child: Buttons.commonButton(
                    onPressed: () {
                      if (onPressedButton == null) return;
                      onPressedButton.call();
                    },
                    color: Utility.darken(color!, 0.15),
                    text: "Gestionar tarifas",
                  ),
                ),
              if (withSwithCashTariff)
                FormWidgets.inputSwitch(
                  activeColor: DesktopColors.azulClaro,
                  value: useCashTariff,
                  context: context,
                  name: "Usar Temporadas en Efectivo en todas",
                  onChanged: (p0) {
                    if (onPressedSwitch != null) {
                      onPressedSwitch.call(p0);
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    )
        .animate(
          autoPlay: true,
          delay: !Settings.applyAnimations ? null : 450.ms,
        )
        .fadeIn(
          duration: Settings.applyAnimations ? 200.ms : 0.ms,
        )
        .flip(
          duration: Settings.applyAnimations ? null : 0.ms,
        );
  }
}
