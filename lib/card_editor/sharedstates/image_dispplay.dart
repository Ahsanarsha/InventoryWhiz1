import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../editor_controller.dart';
import '../text_properties_bloc.dart';


class ImageDisplay extends StatefulWidget {
  ImageDisplay();

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {

  Offset offset = Offset.zero;
  final double minScale = 1;
  final double maxScale = 3;
  //EditorController editorController = Get.put(EditorController());
  double _scaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() =>Container(
      height: size.height * 0.415,
      width: Get.width,
      child: Image.file(
          textPropertiesBloc.selectedImage.value,
        scale: _scaleFactor,
        fit: BoxFit.fill,
        ),
    ),
    );
  }
}
