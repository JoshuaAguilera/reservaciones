import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/res/helpers/animation_helpers.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tuple/tuple.dart';

import '../../models/imagen_model.dart';
import '../../res/helpers/constants.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/text_styles.dart';
import '../../view-models/providers/imagen_provider.dart';
import '../../view-models/providers/usuario_provider.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../view-models/services/imagen_service.dart';
import '../shared_preferences/settings.dart';

class GestorImagenes extends ConsumerStatefulWidget {
  const GestorImagenes({
    super.key,
    this.isDialog = false,
    this.isSingleImage = false,
    this.implementDirecty = false,
    this.blocked = false,
    this.selectImage,
  });

  final bool isDialog;
  final bool isSingleImage;
  final bool implementDirecty;
  final bool blocked;
  final Imagen? selectImage;

  @override
  _GestorImagenesState createState() => _GestorImagenesState();
}

class _GestorImagenesState extends ConsumerState<GestorImagenes> {
  bool isUpdatingImage = false;
  File? imagen;
  File? pathImage;
  double height = 250;
  Imagen? imagenSelect;
  int codeImage = 0;
  bool isUploadingImage = false;

  @override
  void initState() {
    super.initState();
    if (widget.isDialog) getData();
  }

  Future getData() async {
    if (widget.selectImage != null) {
      //   isUpdatingImage = true;
      imagenSelect = widget.selectImage;
      // codeImage = imagenSelect!.code ?? 0;
      imagen = imagenSelect!.newImage;
      // height = 350;
      setState(() {});
    }
  }

  Future selectImage(int i, {Imagen? imagePerfil}) async {
    var pickerImage;

    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null && result.files.single.path != null) {
        pickerImage = File(result.files.single.path!);
        pathImage = pickerImage;

        setState(() {});
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      if (pickerImage != null) {
        imagen = File(pickerImage.path);

        height = widget.isDialog ? 250 : 400;
      } else {
        debugPrint("Imagen no seleccionada");
      }
      isUploadingImage = false;
    });

    ref.read(foundImageFileProvider.notifier).update((state) => false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageUser = ref.watch(imagePerfilProvider);

    return SizedBox(
      child: Column(
        children: [
          if (imagen == null)
            Center(
              child: SizedBox(
                child: Stack(
                  children: [
                    if (imageUser?.url == null)
                      Icon(
                        Iconsax.user_square_bulk,
                        size: height * 0.60,
                      )
                    else
                      ImageUserWidget(
                        image: imageUser,
                        size: height * 0.60,
                        withBorder: true,
                      ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Buttons.floatingButton(
                        context,
                        tag: "edit_photo",
                        icon: isUpdatingImage
                            ? Iconsax.close_circle_outline
                            : Iconsax.edit_2_outline,
                        iconSize: 22,
                        onPressed: widget.blocked
                            ? null
                            : () {
                                isUpdatingImage = !isUpdatingImage;
                                setState(() {});
                              },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (isUpdatingImage)
            AnimatedEntry(
              child: Column(
                children: [
                  if (imagen == null) const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      child: Column(
                        children: [
                          if (imagen == null)
                            TextStyles.standardText(
                              text: imagenSelect?.newImage == null
                                  ? "Seleccionar imagen:"
                                  : "Quitar imagen:",
                              size: 13,
                            ),
                          const SizedBox(height: 5),
                          if (imagen == null)
                            Column(
                              children: [
                                SizedBox(
                                  height: 38,
                                  child: Buttons.commonButton(
                                    text: "Subir archivo",
                                    icons: BoxIcons.bx_upload,
                                    isLoading: isUploadingImage,
                                    onPressed: () async {
                                      isUploadingImage = true;
                                      setState(() {});
                                      ref
                                          .read(foundImageFileProvider.notifier)
                                          .update((state) => true);
                                      await selectImage(2);
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          if (imagen != null)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: Image.file(
                                        imagen!,
                                        height: height * 0.60,
                                        width: height * 0.60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(18, 0, 18, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        child: Buttons.commonButton(
                                          text: (imagen != null &&
                                                  imagenSelect?.newImage !=
                                                      null)
                                              ? "Quitar"
                                              : "Guardar",
                                          isLoading: isUploadingImage,
                                          onPressed: () async {
                                            isUploadingImage = true;
                                            setState(() {});

                                            String urlImage =
                                                await ImagenService()
                                                    .handleImageSelection(
                                                        pathImage);

                                            Imagen workImage = Imagen();
                                            workImage.newImage = imagen;
                                            workImage.ruta = urlImage;
                                            workImage.idInt =
                                                widget.selectImage?.idInt;
                                            workImage.id =
                                                widget.selectImage?.id;

                                            ref
                                                .watch(imagenProvider.notifier)
                                                .update((state) => workImage);

                                            Tuple2<bool, Imagen?> response =
                                                await ref.read(
                                                    saveimagenProvider.future);

                                            if (response.item1) {
                                              isUploadingImage = false;
                                              setState(() {});
                                              return;
                                            }

                                            ref
                                                .read(imagenProvider.notifier)
                                                .update((state) => null);

                                            isUploadingImage = false;
                                            isUpdatingImage = false;
                                            imagen = null;
                                            imagenSelect = Imagen();
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                        child: Buttons.commonButton(
                                          text: "Cancelar",
                                          color: DesktopColors.prussianBlue,
                                          onPressed: isUploadingImage
                                              ? null
                                              : () {
                                                  imagen = null;
                                                  isUpdatingImage = false;
                                                  imagenSelect?.newImage = null;
                                                  setState(() {});
                                                },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).animate().slideY(
                    begin: -0.1,
                    delay: !Settings.applyAnimations ? null : 200.ms,
                    duration: Settings.applyAnimations ? null : 0.ms,
                  ),
            ),
        ],
      ),
    );
  }
}

class ImageUserWidget extends StatefulWidget {
  final Imagen? image;
  final double size;
  final bool withBorder;

  const ImageUserWidget({
    super.key,
    this.image,
    this.size = 45,
    this.withBorder = false,
  });

  @override
  State<ImageUserWidget> createState() => _ImageUserWidgetState();
}

class _ImageUserWidgetState extends State<ImageUserWidget> {
  bool online = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: !widget.withBorder
            ? null
            : Border.all(
                color: const Color.fromARGB(255, 187, 209, 210),
                width: 2,
              ),
      ),
      child: !online
          ? ClipOval(
              child: Image.file(
                File(widget.image?.ruta ?? ""),
                width: widget.size,
                height: widget.size,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Iconsax.user_square_bulk,
                  size: widget.size,
                  color: Colors.white,
                ),
              ),
            )
          : ClipOval(
              child: CachedNetworkImage(
                imageUrl: "$apiUrl${widget.image?.url}",
                width: widget.size,
                height: widget.size,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  width: widget.size,
                  height: widget.size,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Icon(
                  Iconsax.user_octagon_outline,
                  size: widget.size,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
