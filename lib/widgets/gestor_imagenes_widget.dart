import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/imagen_model.dart';
import 'package:generador_formato/providers/usuario_provider.dart';
import 'package:generador_formato/services/image_service.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:icons_plus/icons_plus.dart';

import '../database/database.dart';
import '../services/auth_service.dart';
import '../ui/show_snackbar.dart';
import '../utils/helpers/web_colors.dart';

class GestorImagenes extends ConsumerStatefulWidget {
  const GestorImagenes({
    super.key,
    required this.imagenes,
    this.isDialog = false,
    this.isSingleImage = false,
    this.implementDirecty = false,
  });

  final List<Imagen>? imagenes;
  final bool isDialog;
  final bool isSingleImage;
  final bool implementDirecty;

  @override
  _GestorImagenesState createState() => _GestorImagenesState();
}

class _GestorImagenesState extends ConsumerState<GestorImagenes> {
  bool isUpdatingImage = false;
  final CarouselController _controller = CarouselController();
  File? imagen;
  File? pathImage;
  double height = 250;
  Imagen? imagenSelect;
  int _current = 0;
  int codeImage = 0;
  bool isUploadingImage = false;

  @override
  void initState() {
    super.initState();
    if (widget.isDialog) {
      getData();
    }
  }

  Future selectImage(int i, {Imagen? imagePerfil}) async {
    var pickerImage;

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, // Limita la selección a imágenes
      );

      if (result != null && result.files.single.path != null) {
        pickerImage = File(result.files.single.path!);
        pathImage = pickerImage;

        setState(() {});
      }
      // pickerImage = await picker.pickImage(source: ImageSource.gallery);
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
  }

  Future getData() async {
    if (widget.imagenes!.isNotEmpty) {
      //   isUpdatingImage = true;
      imagenSelect = widget.imagenes![0];
      codeImage = imagenSelect!.code ?? 0;
      print(codeImage);
      imagen = imagenSelect!.newImage;
      // height = 350;
      setState(() {});
    }
  }

  Future<String> handleImageSelection() async {
    try {
      final folderPath = '/images';

      //agregar code para no sobrescribir imagenes
      final fileName = 'image_user_${Preferences.userId}_perfil.png';
      final filePath = '$folderPath/$fileName';

      final folder = Directory(folderPath);
      if (!folder.existsSync()) {
        folder.createSync(recursive: true);
      }

      final savedImage = await pathImage!.copy(filePath);

      return savedImage.path;
    } catch (e) {
      print(e);
      return '';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageUser = ref.watch(imagePerfilProvider);
    final usuario = ref.watch(userProvider);

    return SizedBox(
      child: Column(
        children: [
          if (imagen == null)
            Center(
              child: SizedBox(
                child: Stack(
                  children: [
                    if (imageUser.urlImagen == null)
                      Image(
                        image: const AssetImage("assets/image/usuario.png"),
                        height: height * 0.60,
                        width: height * 0.60,
                      )
                    else
                      Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: ClipOval(
                          child: Image.file(
                            File(imageUser.urlImagen!),
                            height: height * 0.60,
                            width: height * 0.60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              isUpdatingImage = !isUpdatingImage;
                            });
                          },
                          child: Icon(
                            isUpdatingImage
                                ? Iconsax.close_circle_outline
                                : Icons.edit,
                            color: DesktopColors.cerulean,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (!widget.isDialog)
            Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 20),
                    child: (widget.imagenes == null)
                        ? Stack(
                            children: [
                              const Center(
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/box_article_icon.png'),
                                    width: 120),
                              ),
                              Center(
                                child: Opacity(
                                  opacity: 0.7,
                                  child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      iconSize: 100,
                                      onPressed: () {
                                        setState(() {
                                          isUpdatingImage = true;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add_photo_alternate,
                                        size: 120,
                                        color: Colors.blueGrey,
                                      )),
                                ),
                              )
                            ],
                          )
                        : CarouselSlider.builder(
                            itemCount: widget.imagenes!.length +
                                ((widget.isSingleImage &&
                                        widget.imagenes!.length > 0)
                                    ? 0
                                    : 1),
                            carouselController: _controller,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              if (itemIndex < widget.imagenes!.length) {
                                return Stack(
                                  children: [
                                    if (widget.imagenes![itemIndex].newImage ==
                                        null)
                                      Image.network(
                                          widget.imagenes![itemIndex]
                                                  .urlImagen ??
                                              "",
                                          width: 200,
                                          height: 150)
                                    else
                                      Image.file(
                                          widget.imagenes![itemIndex].newImage!,
                                          height: 150,
                                          width: 200),
                                    Positioned(
                                      width: screenWidth * 0.5,
                                      height: 55,
                                      bottom: 0,
                                      left: 60,
                                      child: Opacity(
                                        opacity: 0.8,
                                        child: IconButton(
                                            padding: const EdgeInsets.all(0),
                                            iconSize: 100,
                                            onPressed: () {
                                              isUpdatingImage = true;
                                              imagenSelect =
                                                  widget.imagenes![itemIndex];
                                              codeImage =
                                                  imagenSelect!.code ?? 0;
                                              print(codeImage);
                                              imagen = imagenSelect!.newImage;
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              Icons.remove_circle,
                                              size: 60,
                                              color: Colors.red[800],
                                            )),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Stack(
                                  children: [
                                    // Center(
                                    //   child: Image(
                                    //       image: AssetImage(widget.isPlaca
                                    //           ? 'assets/images/placa.png'
                                    //           : 'assets/images/box_article_icon.png'),
                                    //       width: 120),
                                    // ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 28.0),
                                      child: Center(
                                        child: Opacity(
                                          opacity: 0.7,
                                          child: IconButton(
                                              padding: const EdgeInsets.all(0),
                                              iconSize: 100,
                                              onPressed: () async {
                                                setState(() {
                                                  isUpdatingImage = true;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.add_photo_alternate,
                                                size: 120,
                                                color: Colors.blueGrey,
                                              )),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }
                            },
                            options: CarouselOptions(
                              height: 145,
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) {
                                setState(
                                  () {
                                    isUpdatingImage = false;
                                    imagenSelect = Imagen();
                                    imagen = null;
                                    _current = index;
                                  },
                                );
                              },
                            ),
                          ),
                  ),
                ),
                if (widget.imagenes != null && !widget.isSingleImage)
                  Positioned(
                    width: screenWidth - 30,
                    height: widget.isDialog ? 350 : 339,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                widget.imagenes!.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 3.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                        .withOpacity(
                                            _current == entry.key ? 0.8 : 0.4),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          if (widget.imagenes != null)
                            GestureDetector(
                              onTap: () => _controller
                                  .animateToPage(widget.imagenes!.length),
                              child: Icon(
                                Icons.add,
                                size: 16,
                                color: DesktopColors.grisPalido,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          if (isUpdatingImage)
            Column(
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
                              color: Theme.of(context).primaryColor,
                              size: 13),
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
                                                imagenSelect?.newImage != null)
                                            ? "Quitar"
                                            : "Aceptar",
                                        onPressed: () async {
                                          if (imageUser.id != null) {
                                            String urlImage =
                                                await handleImageSelection();

                                            if (urlImage.isEmpty) {
                                              showSnackBar(
                                                  context: context,
                                                  title:
                                                      "Error al guardar la imagen",
                                                  message:
                                                      "Se presento un problema al intentar actualizar la imagen de perfil.",
                                                  type: "danger");
                                            } else {
                                              showSnackBar(
                                                context: context,
                                                title:
                                                    "Imagen de Perfil actualizado correctamente",
                                                message:
                                                    "Se ha guardado correctamente la imagen de perfil, se alojo en la ruta: ${imageUser.urlImagen}",
                                                type: "success",
                                              );
                                            }
                                          } else {
                                            bool showError = false;
                                            String urlImage =
                                                await handleImageSelection();
                                            if (urlImage.isEmpty) {
                                              showError = true;
                                            } else {
                                              int uniqueCode =
                                                  UniqueKey().hashCode;

                                              Imagen newImage = Imagen(
                                                id: imageUser.id ?? 0,
                                                code: imageUser.code ??
                                                    uniqueCode,
                                                urlImagen: urlImage,
                                                usuarioId: Preferences.userId,
                                              );

                                              ImagesTableData? response =
                                                  await ImageService()
                                                      .saveImage(newImage);

                                              if (response == null) {
                                                showError = true;
                                              } else {
                                                if (await AuthService()
                                                    .updateImagePerfil(
                                                        usuario.id,
                                                        usuario.username,
                                                        response.id)) {
                                                  showError = true;
                                                } else {
                                                  showSnackBar(
                                                    context: context,
                                                    title:
                                                        "Imagen de Perfil actualizado correctamente",
                                                    message:
                                                        "Se ha guardado correctamente la imagen de perfil, se alojo en la ruta: $urlImage",
                                                    type: "success",
                                                  );
                                                  ref
                                                      .watch(imagePerfilProvider
                                                          .notifier)
                                                      .update(
                                                        (ref) => newImage,
                                                      );
                                                }
                                              }
                                            }

                                            if (showError) {
                                              showSnackBar(
                                                  context: context,
                                                  title:
                                                      "Error al guardar la imagen",
                                                  message:
                                                      "Se presento un problema al intentar actualizar la imagen de perfil.",
                                                  type: "danger");
                                            }
                                          }

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
                                        onPressed: () {
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
            )
                .animate()
                .fadeIn()
                .slideY(begin: -0.1, delay: const Duration(milliseconds: 200))
        ],
      ),
    );
  }
}
