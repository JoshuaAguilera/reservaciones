import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/imagen_model.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/helpers/web_colors.dart';

class GestorImagenes extends StatefulWidget {
  const GestorImagenes({
    super.key,
    required this.imagenes,
    this.isDialog = false,
    this.isSingleImage = false,
  });

  final List<Imagen>? imagenes;
  final bool isDialog;
  final bool isSingleImage;

  @override
  State<GestorImagenes> createState() => _GestorImagenesState();
}

class _GestorImagenesState extends State<GestorImagenes> {
  bool isUpdatingImage = false;
  final CarouselController _controller = CarouselController();
  File? imagen;
  double height = 150;
  final picker = ImagePicker();
  Imagen? imagenSelect;
  int _current = 0;
  int codeImage = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isDialog) {
      getData();
    }
  }

  Future selectImage(int i) async {
    var pickerImage;
    if (i == 1) {
      try {
        pickerImage = await picker.pickImage(source: ImageSource.camera);
      } catch (e) {
        print(e);
      }
    } else {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image, // Limita la selección a imágenes
        );

        if (result != null && result.files.single.path != null) {
          setState(() {
            pickerImage = File(result.files.single.path!);
          });
        }
        // pickerImage = await picker.pickImage(source: ImageSource.gallery);
      } catch (e) {
        print(e);
      }
    }

    setState(() {
      if (pickerImage != null) {
        imagen = File(pickerImage.path);
        height = widget.isDialog ? 350 : 400;
      } else {
        debugPrint("Imagen no seleccionada");
      }
    });
  }

  Future getData() async {
    if (widget.imagenes!.isNotEmpty) {
      isUpdatingImage = true;
      imagenSelect = widget.imagenes![0];
      codeImage = imagenSelect!.code ?? 0;
      print(codeImage);
      imagen = imagenSelect!.newImage;
      height = 350;
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

    return SizedBox(
      width: screenWidth * 0.9,
      height: widget.isDialog ? height : null,
      child: Column(
        children: [
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
          if (isUpdatingImage || widget.isDialog)
            Column(children: [
              const SizedBox(height: 5),
              Center(
                child: SizedBox(
                  width: screenWidth - 50,
                  child: Column(
                    children: [
                      TextStyles.standardText(
                          text: imagenSelect?.newImage == null
                              ? "Seleccionar imagen:"
                              : "Quitar imagen:",
                          color: Theme.of(context).primaryColor,
                          size: 13),
                      const SizedBox(height: 5),
                      if (imagen == null)
                        Column(children: [
                          SizedBox(
                            height: 38,
                            child: Buttons.commonButton(
                              text: "Tomar una foto",
                              icons: Icons.camera_alt_rounded,
                              onPressed: () async {
                                await selectImage(1);
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 38,
                            child: Buttons.commonButton(
                              text: "Seleccionar una foto",
                              icons: Icons.photo,
                              onPressed: () async {
                                await selectImage(2);
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                        ]),
                      if (imagen != null)
                        Column(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: Image.file(
                                  imagen!,
                                  height: height * 0.55,
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
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
                                      onPressed: (imagen != null &&
                                              imagenSelect?.newImage != null)
                                          ? () {
                                              setState(() {
                                                isUpdatingImage = false;
                                                imagenSelect = Imagen();
                                                imagen = null;
                                                if (widget.isDialog) {
                                                  height = 200;
                                                  widget.imagenes!.removeAt(0);
                                                } else {
                                                  widget.imagenes!.removeAt(
                                                    widget.imagenes!.indexWhere(
                                                        (element) =>
                                                            element.code ==
                                                            codeImage),
                                                  );
                                                }
                                              });
                                            }
                                          : () {
                                              int newCode =
                                                  UniqueKey().hashCode;
                                              if (widget.imagenes != null &&
                                                  widget.imagenes!.isNotEmpty) {
                                                widget.imagenes!.add(Imagen(
                                                  newImage: imagen,
                                                  code: newCode,
                                                ));
                                              } else {
                                                widget.imagenes!.add(Imagen(
                                                  newImage: imagen,
                                                  code: newCode,
                                                ));
                                              }
                                              isUpdatingImage = false;

                                              // if (widget.isDialog) {
                                              //   Navigator.of(context)
                                              //       .pop(imagen);
                                              // }

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
                                        if (widget.isDialog) {
                                          //  Navigator.pop(context);
                                        } else {
                                          imagen = null;
                                          isUpdatingImage = false;
                                          setState(() {});
                                        }
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
            ])
                .animate()
                .fadeIn()
                .slideY(begin: -0.2, delay: const Duration(milliseconds: 200))
        ],
      ),
    );
  }
}
