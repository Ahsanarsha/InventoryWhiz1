import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';


class EditorController extends GetxController{
  var tabIndex = 0.obs;
  var enterText = true.obs;
  bool textFocus = false;

  var sideSwitcher = 1.obs;
  ScreenshotController screenshotController = ScreenshotController();
  var showButtonsBlock = true.obs;
  RelativeRect weightDialoguePosition = RelativeRect.fromLTRB(63, 465, 100, 50);
}