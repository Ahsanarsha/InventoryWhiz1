import 'dart:io';
import 'package:card_club/card_editor/image_properties_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../text_properties_bloc.dart';
import 'PaintPage.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

Offset offset = Offset.zero;

class _ImagePageState extends State<ImagePage> {

  // final List<double> _zooms = [
  //   1.5,
  //  2.0,
  //   2.5,
  //   3.0,
  //   3.5,
  //   4.0
  // ];
  // double _zoomSliderPosition = 0;
  // double? _currentZoom;


  @override
  void initState() {
   // _currentZoom = _calculateSelectedZoom(_zoomSliderPosition);
    textPropertiesBloc.isImageAvailable.value ? SizedBox():bottomSheet();
    super.initState();
  }



  // _zoomChangeHandler(double position) {
  //   //handle out of bounds positions
  //   if (position > Get.width * 0.800) {
  //     position = Get.width * 0.800;
  //   }
  //   if (position < 0) {
  //     position = 0;
  //   }
  //   setState(() {
  //     _zoomSliderPosition = position;
  //     _currentZoom = _calculateSelectedZoom(_zoomSliderPosition);
  //   });
  //
  //   imagePropertiesBloc.updateZoom(_currentZoom!);
  // }
  //
  // double _calculateSelectedZoom(double position) {
  //   //determine zoom
  //   double positionInZoomArray =
  //   (position / Get.width * 0.800 * (_zooms.length - 1));
  //   print(positionInZoomArray);
  //   int index = positionInZoomArray.truncate();
  //   print(index);
  //   double remainder = positionInZoomArray - index;
  //   if (remainder == 0.0) {
  //     _currentZoom = _zooms[index];
  //   } else {
  //     //calculate new zoom
  //
  //     if (position == 2.0)
  //     _currentZoom = 2.0;
  //     else if (position ==2.5)
  //       _currentZoom = 2.5;
  //     else if (position ==3.0)
  //       _currentZoom = 3.0;
  //   }
  //   return _currentZoom!;
  // }


  File? pickedImage;
  TextStyle bottomSheetTextStyle = TextStyle(
    fontSize: 16,
    ///Add FontWeight Here
    fontWeight: FontWeight.normal,
  );

  //select from gallery/camera
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      textPropertiesBloc.updateImage(tempImage);

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // GestureDetector(
          //   behavior: HitTestBehavior.opaque,
          //   onHorizontalDragStart: (DragStartDetails details) {
          //     print("_-------------------------STARTED DRAG");
          //     _zoomChangeHandler(details.localPosition.dx);
          //   },
          //   onHorizontalDragUpdate: (DragUpdateDetails details) {
          //     _zoomChangeHandler(details.localPosition.dx);
          //   },
          //   onTapDown: (TapDownDetails details) {
          //     _zoomChangeHandler(details.localPosition.dx);
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.only(top: 15, bottom: 15),
          //     child: Container(
          //       width: Get.width * 0.800,
          //       height: 5,
          //       decoration: BoxDecoration(
          //         border: Border.all(width: 2, color: Colors.grey[800]!),
          //         borderRadius: BorderRadius.circular(15),
          //       // gradient: LinearGradient(colors: _colors),
          //       ),
          //       child: CustomPaint(
          //         painter: _SliderIndicatorPainter(_zoomSliderPosition),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }


  bottomSheet(){
    Future.delayed(Duration(seconds: 0)).then((_) {
      showCupertinoModalPopup(context: context, builder: (context) => CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text("Photos", style: bottomSheetTextStyle),
            isDefaultAction: true,
            onPressed: () {
              pickImage(ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: Text("Gallery", style: bottomSheetTextStyle),
            onPressed: () {
              pickImage(ImageSource.gallery);
            },

          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("Cancel", style: bottomSheetTextStyle,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ));

    });
    PaintPage.selected = Colors.black;
    PaintPage.stroke = 2;
  }


}


class _SliderIndicatorPainter extends CustomPainter {
  final double position;

  _SliderIndicatorPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(position, size.height / 2), 5, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(_SliderIndicatorPainter old) {
    return true;
  }
}