import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../models/imagen_model.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/text_styles.dart';
import '../../view-models/providers/usuario_provider.dart';
import '../../view-models/services/auth_service.dart';
import '../../res/ui/show_snackbar.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../view-models/services/image_service.dart';
import '../shared_preferences/settings.dart';

class GestorImagenes extends ConsumerStatefulWidget {
  const GestorImagenes({
    super.key,
    required this.imagenes,
    this.isDialog = false,
    this.isSingleImage = false,
    this.implementDirecty = false,
    this.blocked = false,
  });

  final List<Imagen>? imagenes;
  final bool isDialog;
  final bool isSingleImage;
  final bool implementDirecty;
  final bool blocked;

  @override
  _GestorImagenesState createState() => _GestorImagenesState();
}

class _GestorImagenesState extends ConsumerState<GestorImagenes> {
  bool isUpdatingImage = false;
  //final CarouselController _controller = CarouselController();
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

  Future getData() async {
    if (widget.imagenes!.isNotEmpty) {
      //   isUpdatingImage = true;
      imagenSelect = widget.imagenes![0];
      imagen = imagenSelect!.newImage;
      // height = 350;
      setState(() {});
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
                    if (imageUser.ruta == null)
                      Image(
                        image: const AssetImage("assets/image/usuario.png"),
                        height: height * 0.60,
                        width: height * 0.60,
                      )
                    else
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color.fromARGB(255, 187, 209, 210),
                                width: 2)),
                        child: ClipOval(
                          child: Image.file(
                            File(imageUser.ruta!),
                            height: height * 0.60,
                            width: height * 0.60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Image(
                              image:
                                  const AssetImage("assets/image/usuario.png"),
                              height: height * 0.60,
                              width: height * 0.60,
                            ),
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
                          onPressed: widget.blocked
                              ? null
                              : () {
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
                          : const SizedBox()
                      /*CarouselSlider.builder(
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
                          */
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
                                onTap: () {},
                                //=> _controller.animateToPage(entry.key),
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
                              onTap:
                                  () {}, //=> _controller.animateToPage(widget.imagenes!.length),
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
                                                imagenSelect?.newImage != null)
                                            ? "Quitar"
                                            : "Guardar",
                                        isLoading: isUploadingImage,
                                        onPressed: () async {
                                          bool showError = false;
                                          String urlImage = await ImageService()
                                              .handleImageSelection(pathImage);

                                          isUploadingImage = true;
                                          setState(() {});

                                          if (imageUser.idInt != null) {
                                            if (urlImage.isEmpty) {
                                              showError = true;
                                            } else {
                                              final updateImage =
                                                  await ImageService()
                                                      .saveImage(
                                                imagen: Imagen(
                                                  idInt: imageUser.idInt,
                                                  url: urlImage,
                                                ),
                                                oldUrl: imageUser.ruta!,
                                              );

                                              if (updateImage.item1 != null) {
                                                showError = true;
                                              } else {
                                                Imagen newImage = Imagen(
                                                  idInt: imageUser.idInt ?? 0,
                                                  createdAt:
                                                      imageUser.createdAt,
                                                  ruta: urlImage,
                                                  nombre: usuario?.nombre,
                                                );

                                                ref
                                                    .watch(imagePerfilProvider
                                                        .notifier)
                                                    .update(
                                                      (ref) => newImage,
                                                    );
                                              }
                                            }
                                          } else {
                                            if (urlImage.isEmpty) {
                                              showError = true;
                                            } else {
                                              Imagen newImage = Imagen(
                                                idInt: 0,
                                                ruta: urlImage,
                                                nombre: usuario?.nombre,
                                              );

                                              final response =
                                                  await ImageService()
                                                      .saveImage(
                                                          imagen: newImage);

                                              if (response.item1 == null) {
                                                showError = true;
                                              } else {
                                                bool updateSuccess =
                                                    await AuthService()
                                                        .updateImagePerfil(
                                                  usuario?.idInt ?? 0,
                                                  usuario?.username ?? "",
                                                  response.item2?.idInt ?? 0,
                                                );

                                                if (updateSuccess) {
                                                  showError = true;
                                                } else {
                                                  ref
                                                      .watch(imagePerfilProvider
                                                          .notifier)
                                                      .update(
                                                          (ref) => newImage);
                                                }
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
                                          } else {
                                            showSnackBar(
                                              context: context,
                                              title:
                                                  "Imagen de perfil actualizada",
                                              message:
                                                  "Se ha guardado correctamente la imagen de perfil",
                                              type: "success",
                                            );
                                          }

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
            )
                .animate()
                .fadeIn(
                  duration: Settings.applyAnimations ? null : 0.ms,
                )
                .slideY(
                  begin: -0.1,
                  delay: !Settings.applyAnimations ? null : 200.ms,
                  duration: Settings.applyAnimations ? null : 0.ms,
                ),
        ],
      ),
    );
  }
}
