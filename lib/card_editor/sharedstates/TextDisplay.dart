import 'package:card_club/card_editor/editor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../text_properties_bloc.dart';

class TextItemModel {
  String text;
  int number;
  Offset offset;
  TextStyle textStyle;

  TextItemModel(this.text, this.number, this.offset, this.textStyle);
}

class TextDisplay extends StatefulWidget {

  static bool shouldDisplay = false;

  static RxList<TextItemModel> allTexts = <TextItemModel>[
    TextItemModel(
        '',
        0,
        Offset.zero,
        TextStyle(
          fontSize: 28,
          fontWeight: textPropertiesBloc.fontWeight.value,
          fontFamily: textPropertiesBloc.selectedFont.value,
          color: textPropertiesBloc.textColor.value,
        )),
  ].obs;

  static Rx<int> textsCounter = 0.obs;
  static RxList<double> topPadding = [10.0].obs;
  static int selectedTextIndex = 0;

  @override
  _TextDisplayState createState() => _TextDisplayState();
}

// Offset offset = Offset.zero;

class _TextDisplayState extends State<TextDisplay> {

  // late FocusNode myFocusNode;
  //
  // @override
   void initState() {
  //   // TODO: implement initState
  // TextDisplay.allTexts.length = 0;
    // TextDisplay.textsCounter = 0.obs;
    super.initState();
  }
  // @override
  void dispose() {
   // TextDisplay.allTexts.clear();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = MediaQuery.of(context).size.width;
    EditorController editorController = Get.put(EditorController());

    return Obx(() => Container(
         // margin: EdgeInsets.fromLTRB(width * .115, width * .040, 0, 0),
          width: Get.width * 0.86,
          height: Get.height * 0.46,
          child: Stack(
            children: TextDisplay.allTexts.map((element) {
              return Positioned(
                left: element.offset.dx,
                top: element.offset.dy,

                /// Checked
                child: Obx(
                  () => Padding(
                    padding: EdgeInsets.fromLTRB(
                        120, TextDisplay.topPadding[element.number], 8, 0),
                    child: Column(
                      children: [
                        TextDisplay.shouldDisplay
                            ? GestureDetector(
                                onTap: () {
                                  print('tapped on Text');
                                  print(element.text);
                                //  editorController.tabIndex.value == 1?
                                  editorController.enterText.value = true;
                                  //:editorController.enterText.value = false;


                                  TextDisplay.selectedTextIndex =
                                      TextDisplay
                                      .allTexts
                                      .indexWhere((innerElement) =>
                                          element == innerElement);
                                  TextDisplay.allTexts[TextDisplay.selectedTextIndex].text = element.text;

                                },
                          onLongPress: (){
                            print('long tapped on Text');

                            Get.showSnackbar(GetSnackBar(   title:  'Remove Text',
                                message: 'Want to Remove Text?',
                                isDismissible:true,
                                duration: Duration(seconds: 3),
                                mainButton: GestureDetector(onTap:(){
                                  //TextDisplay.selectedTextIndex == 0? TextDisplay.allTexts.removeAt(0):
                                  TextDisplay.allTexts.remove(TextDisplay.selectedTextIndex);

                                  TextDisplay.allTexts[TextDisplay.selectedTextIndex].text = "";
                                  TextDisplay.selectedTextIndex--;
                                  setState(() {

                                  });

                                },child:Container(
                                  margin: const EdgeInsets.all(15.0),
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Theme.of(context).primaryColor)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Remove", style: TextStyle(color: Colors.white),),
                                  ),
                                ),),

                                snackPosition: SnackPosition.BOTTOM));
                          },
                                onPanUpdate: (details) {
                                  setState(() {
                                    element.offset = Offset(
                                        element.offset.dx + details.delta.dx,
                                        element.offset.dy + details.delta.dy);
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Text(

                                      element.text,
                                      style: element.textStyle,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: size.height * 0,
                                width: size.width * 0,
                              ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ));
  }
}
