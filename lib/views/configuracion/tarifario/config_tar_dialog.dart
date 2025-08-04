import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:generador_formato/res/ui/progress_indicator.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../models/categoria_model.dart';
import '../../../models/tipo_habitacion_model.dart';
import '../../../res/helpers/functions_ui.dart';
import '../../../res/helpers/general_helpers.dart';
import '../../../res/ui/custom_dialog.dart';
import '../../../res/ui/input_decorations.dart';
import '../../../res/ui/text_styles.dart';
import '../../../utils/widgets/form_widgets.dart';
import '../../../view-models/providers/categoria_provider.dart';
import '../../../view-models/providers/tipo_hab_provider.dart';
import '../../../view-models/providers/usuario_provider.dart';

class TipoHabDialog extends StatefulWidget {
  final TipoHabitacion? tipoHabitacion;

  const TipoHabDialog({super.key, this.tipoHabitacion});

  @override
  State<TipoHabDialog> createState() => _TipoHabDialogState();
}

class _TipoHabDialogState extends State<TipoHabDialog> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _orderController = TextEditingController();
  final _bedsController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.tipoHabitacion != null) {
      _codeController.text = widget.tipoHabitacion!.codigo ?? '';
      _orderController.text = widget.tipoHabitacion!.orden?.toString() ?? '';
      _bedsController.text = widget.tipoHabitacion!.camas ?? '';
      _descriptionController.text = widget.tipoHabitacion!.descripcion ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Color fillColor = Theme.of(context).cardColor;

    return Consumer(
      builder: (context, ref, child) {
        return StatefulBuilder(
          builder: (context, snapshot) {
            return CustomDialog(
              withIcon: true,
              notCloseInstant: true,
              nameButton2: "Cancelar",
              nameButton1: "Guardar",
              withButtonSecondary: true,
              icon: Iconsax.lamp_1_outline,
              withLoadingProcess: isLoading,
              title: (widget.tipoHabitacion != null)
                  ? "Detalles del Tipo de Habitación"
                  : "Agregar Tipo de Habitación",
              content: Form(
                key: _formKey,
                child: Column(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        SizedBox(
                          width: GeneralHelpers.clampSize(300.w,
                              min: 120, max: 200),
                          child: FormWidgets.textFormField(
                            name: "Código",
                            fillColor: fillColor,
                            controller: _codeController,
                          ),
                        ),
                        SizedBox(
                          width: GeneralHelpers.clampSize(300.w,
                              min: 120, max: 200),
                          child: FormWidgets.textFormField(
                            name: "Orden*",
                            fillColor: fillColor,
                            controller: _orderController,
                            isNumeric: true,
                          ),
                        ),
                        FormWidgets.textFormField(
                          name: "Camas",
                          fillColor: fillColor,
                          controller: _bedsController,
                        ),
                      ],
                    ),
                    Column(
                      spacing: 3,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.simpleText(text: "  Descripción"),
                        FormWidgets.textAreaForm(
                          hintText: "Deluxe doble vista a ...",
                          fillColor: fillColor,
                          controller: _descriptionController,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              funtion1: () async {
                if (!_formKey.currentState!.validate()) return;
                isLoading = true;
                snapshot(() {});

                int? orden = int.tryParse(_orderController.text.trim());

                TipoHabitacion newTipoHabitacion = TipoHabitacion();
                newTipoHabitacion.codigo = _codeController.text.trim();
                newTipoHabitacion.orden = orden;
                newTipoHabitacion.camas = _bedsController.text;
                newTipoHabitacion.descripcion = _descriptionController.text;
                newTipoHabitacion.id = widget.tipoHabitacion?.id;
                newTipoHabitacion.idInt = widget.tipoHabitacion?.idInt;

                ref.read(tipoHabitacionProvider.notifier).state =
                    newTipoHabitacion;

                bool response =
                    await ref.read(saveTipoHabitacionProvider.future);

                if (response) {
                  isLoading = false;
                  snapshot(() {});
                  return;
                }

                ref
                    .read(tipoHabitacionProvider.notifier)
                    .update((state) => null);
                ref.invalidate(tipoHabListProvider(null));
                ref.invalidate(tipoHabListProvider(""));
                isLoading = false;
                snapshot(() {});

                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }
}

class TipoHabDeleteDialog extends ConsumerWidget {
  final TipoHabitacion? tipoHabitacion;
  const TipoHabDeleteDialog({super.key, this.tipoHabitacion});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomDialog(
      title: "Eliminar tipo de habitación",
      withButtonSecondary: true,
      notCloseInstant: true,
      contentString:
          "¿Desea eliminar ${tipoHabitacion != null ? "el tipo de habitación ${tipoHabitacion?.idInt}" : "estos tipos de habitación"} del sistema?",
      icon: Iconsax.trash_outline,
      withLoadingProcess: true,
      funtion1: () async {
        if (tipoHabitacion != null) {
          ref
              .read(tipoHabitacionProvider.notifier)
              .update((state) => tipoHabitacion);

          bool response = await ref.read(deleteTipoHabitacionProvider.future);

          if (response) return;

          ref.read(tipoHabitacionProvider.notifier).update((state) => null);
          ref.invalidate(tipoHabListProvider(""));
          ref.invalidate(tipoHabListProvider(null));

          if (!context.mounted) return;
          Navigator.of(context).pop(true);
        }
      },
    );
  }
}

class CategoriaDialog extends ConsumerStatefulWidget {
  final Categoria? categoria;
  const CategoriaDialog({super.key, this.categoria});

  @override
  ConsumerState<CategoriaDialog> createState() => _CategoriaDialogState();
}

class _CategoriaDialogState extends ConsumerState<CategoriaDialog> {
  bool isLoading = false;
  Color? selectColor;
  TipoHabitacion? selectType;
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.categoria != null) {
      selectType = widget.categoria?.tipoHabitacion;
      selectColor = widget.categoria?.color;
      _nombreController.text = widget.categoria!.nombre ?? '';
      _descriptionController.text = widget.categoria!.descripcion ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final tipoHabitacionAsync = ref.watch(tipoHabListProvider(null));
    Color fillColor = Theme.of(context).cardColor;

    return Consumer(
      builder: (context, ref, child) {
        return StatefulBuilder(
          builder: (context, snapshot) {
            double dialogWidth =
                GeneralHelpers.clampSize(750.sp, min: 350, max: 600);

            return CustomDialog(
              withIcon: true,
              notCloseInstant: true,
              nameButton2: "Cancelar",
              nameButton1: "Guardar",
              withButtonSecondary: true,
              icon: Iconsax.category_outline,
              withLoadingProcess: isLoading,
              title: (widget.categoria != null)
                  ? "Detalles de la Categoria"
                  : "Agregar Categoria",
              content: Form(
                key: _formKey,
                child: Column(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        SizedBox(
                          width: dialogWidth < 375
                              ? null
                              : (dialogWidth * 0.95) / 2,
                          child: FormWidgets.textFormField(
                            name: "Nombre",
                            fillColor: fillColor,
                            controller: _nombreController,
                          ),
                        ),
                        SizedBox(
                          width: dialogWidth < 375
                              ? null
                              : (dialogWidth * 0.95) / 2,
                          child: tipoHabitacionAsync.when(
                            data: (data) {
                              return CustomDropdown<
                                  TipoHabitacion>.searchRequest(
                                futureRequest: (p0) async {
                                  final response = await ref
                                      .read(tipoHabListProvider(p0).future);
                                  return Future.value(response.item1);
                                },
                                hintText: 'Seleccione un Tipo de Habitación',
                                enabled: !isLoading,
                                disabledDecoration: InputDecorations
                                    .defaultDropdownDiseableDecoration(),
                                decoration:
                                    InputDecorations.defaultDropdownDecoration(
                                  context,
                                  closedFillColor: fillColor,
                                ),
                                items: data.item1,
                                listItemPadding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 9,
                                ),
                                visibility: (p0) {
                                  if (p0) applyUnfocus();
                                },
                                headerBuilder:
                                    (context, selectedItem, enabled) {
                                  return SizedBox(
                                    height: 20,
                                    child: DropdownMenuItem(
                                      child: AppText.simpleText(
                                        text: selectedItem.codigo ?? 'unknown',
                                      ),
                                    ),
                                  );
                                },
                                listItemBuilder:
                                    (context, item, isSelected, onItemSelect) =>
                                        DropdownMenuItem(
                                  child: AppText.simpleText(
                                    text: item.codigo ?? 'unknown',
                                  ),
                                ),
                                initialItem: (widget.categoria != null)
                                    ? data.item1
                                        .where((element) =>
                                            element.idInt ==
                                            widget.categoria?.tipoHabitacion
                                                ?.idInt)
                                        .firstOrNull
                                    : selectType,
                                searchHintText: 'Buscar tipo de habitación',
                                noResultFoundText:
                                    "Tipo de habitación no encontrado",
                                validator: (p0) {
                                  if (p0 == null) {
                                    return "Tipo de habitación requerido*";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (!mounted) return;
                                  if (value != null) {
                                    applyUnfocus();
                                    selectType = value;
                                    setState(() {});
                                  }
                                },
                              );
                            },
                            error: (error, stackTrace) => AppText.simpleText(
                              text: "Error al consultar tipos de habitación",
                            ),
                            loading: () {
                              return Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: ProgressIndicatorCustom(
                                    screenHeight: 32,
                                    sizeProgressIndicator: 32,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        FormWidgets.inputColor(
                          nameInput: "Color Identificador: ",
                          primaryColor: selectColor,
                          mainAxisAlignment: MainAxisAlignment.start,
                          onChangedColor: (p0) {
                            selectColor = p0;
                            snapshot(() {});
                          },
                        ),
                      ],
                    ),
                    Column(
                      spacing: 3,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.simpleText(text: "  Descripción"),
                        FormWidgets.textAreaForm(
                          hintText: "Define la categoría de la habitación",
                          fillColor: fillColor,
                          controller: _descriptionController,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              funtion1: () async {
                if (!_formKey.currentState!.validate()) return;
                isLoading = true;
                snapshot(() {});
                final user = ref.watch(userProvider);

                Categoria newCategoria = Categoria();
                newCategoria.nombre = _nombreController.text.trim();
                newCategoria.color = selectColor;
                newCategoria.tipoHabitacion = selectType;
                newCategoria.descripcion = _descriptionController.text;
                newCategoria.id = widget.categoria?.id;
                newCategoria.idInt = widget.categoria?.idInt;
                newCategoria.creadoPor = user;

                ref.read(categoriaProvider.notifier).state = newCategoria;

                bool response = await ref.read(saveCategoryProvider.future);

                if (response) {
                  isLoading = false;
                  snapshot(() {});
                  return;
                }

                ref.read(categoriaProvider.notifier).update((state) => null);
                ref.invalidate(categoriaListProvider(""));
                isLoading = false;
                snapshot(() {});

                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }
}

class CategoriaDeleteDialog extends ConsumerWidget {
  final Categoria? categoria;
  const CategoriaDeleteDialog({super.key, this.categoria});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomDialog(
      title: "Eliminar categoría",
      withButtonSecondary: true,
      notCloseInstant: true,
      contentString:
          "¿Desea eliminar ${categoria != null ? "la categoría ${categoria?.idInt}" : "estas categorías"} del sistema?",
      icon: Iconsax.trash_outline,
      withLoadingProcess: true,
      funtion1: () async {
        if (categoria != null) {
          ref.read(categoriaProvider.notifier).update((state) => categoria);

          bool response = await ref.read(deleteCategoryProvider.future);

          if (response) return;

          ref.read(tipoHabitacionProvider.notifier).update((state) => null);
          ref.invalidate(tipoHabListProvider(""));

          if (!context.mounted) return;
          Navigator.of(context).pop(true);
        }
      },
    );
  }
}
