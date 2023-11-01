import 'dart:io';
import 'dart:typed_data';

import 'package:card_club/card_editor/sharedstates/TextDisplay.dart';
import 'package:card_club/card_editor/sharedstates/sharedcard.dart';
import 'package:card_club/card_editor/text_properties_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/groups/bloc/group_bloc.dart';
import '../screens/sign_card/add_reciepent_to_sign.dart';
import '../screens/sign_card/delivery_option.dart';
import '../utils/app_colors.dart';
import 'display_image.dart';
import 'editor_controller.dart';
import 'editor_screens/ImagePage.dart';
import 'editor_screens/PaintPage.dart';
import 'editor_screens/TextPage.dart';

class EditorHome extends StatefulWidget {
  EditorHome();

  @override
  _EditorHomeState createState() => _EditorHomeState();
}

class _EditorHomeState extends State<EditorHome> {

  EditorController editorController = Get.put(EditorController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        showBottomSheet(willLeave);
        return willLeave;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(left: 40),
          color: Colors.transparent,
          height: Get.height * 0.25,
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              bottomNavigationBar: menu(),
              backgroundColor: Colors.transparent,
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  TextPage(),
                  PaintPage(),
                  ImagePage(),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            width: Get.width,
            height: Get.height,
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * .70,

                  child: GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height * 0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: main_color,
                                        elevation: 0.0,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        showBottomSheet(true);
                                        // Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Back",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.topRight,
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: main_color,
                                          elevation: 0.0,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        onPressed: () async {
                                          toSaveImage(context);
                                        },
                                        child: Text(
                                          "Next",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(height: Get.height * 0.040),
                              Container(
                                width: Get.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: main_color,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      20,
                                      20,
                                      20,
                                      20,
                                    ),
                                    child: Container(
                                        // color: Colors.white ,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white,
                                        ),
                                        child: SharedCard()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 0.75))
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.10,
      //showTabs ?
      child: TabBar(
        onTap: (index) => {
          editorController.tabIndex.value = index,
        },
        indicatorWeight: 2,
        labelColor: Colors.grey,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding:
            EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        indicatorColor: Colors.white,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xFFEDEDED),
        ),
        tabs: [
          Tab(
            child: Text(
              'Text',
              style: TextStyle(fontSize: 12),
            ),
            iconMargin: EdgeInsets.all(8),
            icon: Image.asset(
              'assets/images/editor_text.png',
              height: 24,
              width: 24,
            ),
          ),
          Tab(
            child: Text(
              'Paint',
              style: TextStyle(fontSize: 12),
            ),
            // text: "Investing",
            iconMargin: EdgeInsets.all(2),
            icon: Icon(Icons.brush_outlined),
          ),
          Tab(
            child: Text(
              "Photos",
              style: TextStyle(fontSize: 12),
            ),
            iconMargin: EdgeInsets.all(8),
            icon: Icon(Icons.photo),
          ),
        ],
      ),
      //: null
    );
  }

  showBottomSheet(bool willLeave) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text('Save Draft'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Discard'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
               TextDisplay.allTexts.clear();
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
             // editorController.enterText.value = false;
              // TextDisplay.textsCounter.value = 0;
                PaintPage.points.clear();
              textPropertiesBloc.isImageAvailable.value = false;




            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () {
            willLeave = true;
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  toSaveImage(BuildContext context) async {
    editorController.showButtonsBlock.value = false;

    await editorController.screenshotController
        .capture()
        .then((Uint8List? image) {
      //Capture Done
      if (image != null) {
        textPropertiesBloc.handleSCCapture(image);

        Get.to(() => DeliveryOption());
        //getAllGroups(context);

      }
    }).catchError((onError) {
      print(onError);
    });
    editorController.showButtonsBlock.value = true;
  }

  getAllGroups(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await groupBloc.getAllGroupsRequest();
    Navigator.of(context).pop();

    Get.to(() => AddReciepentToSign());
  }
}
