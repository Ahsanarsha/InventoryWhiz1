import 'dart:async';

import 'package:card_club/card_editor/editor_controller.dart';
import 'package:card_club/card_editor/sharedstates/TextDisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import '../Paint/CustomPaint.dart';
import '../Paint/Draawing.dart';
import '../editor_screens/PaintPage.dart';
import '../text_properties_bloc.dart';
import 'image_dispplay.dart';

class SharedCard extends StatefulWidget {

  @override
  _SharedCardState createState() => _SharedCardState();
}

class _SharedCardState extends State<SharedCard> {

  late final KeyboardVisibilityController _keyboardVisibilityController;
  late StreamSubscription<bool> keyboardSubscription;
  var _editorController = Get.put(EditorController());

  @override
  void initState() {
    super.initState();
    PaintPage.selected = Colors.black;
    PaintPage.stroke = 2;
    TextDisplay.textsCounter.value = 0;
   print("List at init State : ${TextDisplay.allTexts.length}");
    //print("List text at init State  : ${TextDisplay.allTexts[0].text}");

    print("Text cOunt: ${TextDisplay.textsCounter.value}");


    _keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        _keyboardVisibilityController.onChange.listen((isVisible) {
      if (!isVisible) _editorController.enterText.value = false;
      if (!isVisible) FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
   // TextDisplay.shouldDisplay = false;
   // TextDisplay.allTexts.clear();
    super.dispose();
  }

  List<String> textsList = [];
  double padding = 40;
  final _transformationController = TransformationController();
  late TapDownDetails _doubleTapDetails;

  @override
  Widget build(BuildContext context) {
Size size = MediaQuery.of(context).size;
    return Screenshot(
      controller: _editorController.screenshotController,
      child: Stack(
        children: [
          Obx(() =>  Container(
            // height: size.height * 0.47,
            // width: Get.width * 0.42,
             // color:Colors.red,
              child:  Column(
                children: <Widget>[
                  if (textPropertiesBloc.isImageAvailable.value)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InteractiveViewer(
                          transformationController: _transformationController,
                         // panEnabled: false,
                          //scaleEnabled: true,
                          // minScale: 1.0,
                          // maxScale: 2.2,
                          child: ImageDisplay()),
                    ),
                ],
              )),),

          Container(
            child: Container(
              height: Get.height * 0.46,
              width: Get.width * 0.82,
             // color: Colors.pink,
              child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      ),
                  child: Obx(
                    () => _editorController.enterText.value
                        ? TextField(

                            autofocus: _editorController.textFocus,
                            // autofocus: true,
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.transparent),
                            onChanged: (value) {

                              setState(() {


                                TextDisplay
                                    .allTexts[TextDisplay.textsCounter.value]
                                    .text = value;
                                TextDisplay
                                    .allTexts[TextDisplay.textsCounter.value]
                                    .number = TextDisplay.textsCounter.value;
                                TextDisplay.shouldDisplay = true;
                              });
                              if (textPropertiesBloc.textColor.value !=
                                  Color(000000))
                                textPropertiesBloc.updateColor(
                                    textPropertiesBloc.textColor.value);
                              else
                                textPropertiesBloc.updateColor(Colors.black);
                            },
                            onSubmitted: (value) {
                              // TextDisplay.topPadding[TextDisplay.textsCounter]+=10.0;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              print("in onTap");
                              _editorController.textFocus = false;
                              if (_editorController.tabIndex.value == 0) {
                                TextDisplay.textsCounter.value++;
                                TextDisplay.topPadding.add(padding);
                                padding += 30;
                                TextDisplay.topPadding.refresh();
                                TextDisplay.allTexts.add(TextItemModel(
                                    '',
                                    0,
                                    Offset(10, 10),
                                    TextStyle(
                                      fontWeight:
                                          textPropertiesBloc.fontWeight.value,
                                      fontFamily:
                                          textPropertiesBloc.selectedFont.value,
                                      fontSize: 28,
                                      color: textPropertiesBloc.textColor.value,
                                    )));
                                _editorController.enterText.value = true;
                              } else
                                _editorController.enterText.value = false;
                            },

                      onDoubleTapDown: _handleDoubleTapDown,
                      onDoubleTap: _handleDoubleTap,

                            onPanDown: (details) {
                              ///Paint Tab Check
                              if (_editorController.tabIndex.value == 1) {
                                setState(() {
                                  PaintPage.points.add(DrawingArea(
                                      point: details.localPosition,
                                      areaPaint: Paint()
                                        ..strokeCap = StrokeCap.round
                                        ..isAntiAlias = true
                                        ..color =
                                            textPropertiesBloc.paintColor.value
                                        ..strokeWidth = textPropertiesBloc
                                            .paintStroke.value


                                  ));
                                });
                              }
                            },
                            onPanUpdate: (details) {
                              if (_editorController.tabIndex.value == 1) {
                                setState(() {
                                  PaintPage.points.add(DrawingArea(
                                      point: details.localPosition,
                                      areaPaint: Paint()
                                        ..strokeCap = StrokeCap.round
                                        ..isAntiAlias = true
                                        ..color =
                                            textPropertiesBloc.paintColor.value
                                        ..strokeWidth = textPropertiesBloc
                                            .paintStroke.value));
                                });
                              }
                            },
                            onPanEnd: (details) {
                              if (_editorController.tabIndex.value == 1) {
                                setState(() {
                                  PaintPage.points.add(null);
                                });
                              }
                            },
                            child:
                                // Container()
                            ClipRRect(
                              child: CustomPaint(
                            painter: MyCustomPainter(
                              points: PaintPage.points,
                            ),
                              ),
                            ),
                          ),
                    // Container()
                  )),
            ),
          ),
          CustomPaint(
            painter: MyCustomPainter(
              points: PaintPage.points,
            ),
          ),
          TextDisplay(),
        ],
      ),
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    print("Double Tap Down");
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    print("Double Tap");
    if (_editorController.tabIndex.value == 2) {
      if (_transformationController.value != Matrix4.identity()) {
        _transformationController.value = Matrix4.identity();
      } else {
        final position = _doubleTapDetails.localPosition;
        // For a 3x zoom
        _transformationController.value = Matrix4.identity()
          ..translate(-position.dx * 2, -position.dy * 2)
          ..scale(3.0);
        // Fox a 2x zoom
        // ..translate(-position.dx, -position.dy)
        // ..scale(2.0);
      }
    }
  }

  // get drawing points for saving in draft
  //#region description
  _save() {
    List<Map<String, dynamic>> paintData = [];
    for (var obj in PaintPage.points) {
      if (obj != null) {
        PaintObject paintObject = PaintObject(
            xCor: obj.point.dx,
            yCor: obj.point.dy,
            color: obj.areaPaint.color.value);
        paintData.add(paintObject.toMap());
      }
    }
  }
//#endregion
}


class PaintObject {
  final double xCor, yCor;
  final int color;

  const PaintObject({
    required this.xCor,
    required this.yCor,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'xCor': this.xCor,
      'yCor': this.yCor,
      'color': this.color,
    };
  }

  factory PaintObject.fromMap(Map<String, dynamic> map) {
    return PaintObject(
      xCor: map['xCor'] as double,
      yCor: map['yCor'] as double,
      color: map['color'] as int,
    );
  }
}
