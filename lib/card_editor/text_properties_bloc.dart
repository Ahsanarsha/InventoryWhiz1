import 'dart:io';
import 'dart:typed_data';
import 'package:card_club/card_editor/sharedstates/TextDisplay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextPropertiesBloc {

  var _color = Color(000000).obs;
  var _paintColor = Colors.black.obs;
  var _paintStroke = 2.0.obs;
  var _selectedFont = 'Arial'.obs;
  var _selectedSize = '20'.obs;

  var _fontWeight = FontWeight.normal.obs;
  var _selectedImage = File('').obs;
  TextStyle selectedStyle = TextStyle();
  Uint8List? _imageFile;
  double? fontsize;


  Rx<Color> get textColor => _color;
  Rx<Color> get paintColor => _paintColor;
  Rx<String> get selectedFont => _selectedFont;
  Rx<String> get selectedSize => _selectedSize;

  Rx<FontWeight> get fontWeight => _fontWeight;
  Rx<double> get paintStroke => _paintStroke;
  var isImageAvailable = false.obs;
  Rx<File> get selectedImage => _selectedImage;
  Uint8List get imageFile => _imageFile!;

  //Create an instance of ScreenshotController
  TabController? tabController;

  updateColor(Color color) {
    _color.value = color;
    TextDisplay.allTexts[TextDisplay.selectedTextIndex].textStyle = TextStyle(
      fontSize: TextDisplay.allTexts[TextDisplay.selectedTextIndex].textStyle.fontSize,
      fontWeight: textPropertiesBloc.fontWeight.value,
      fontFamily: textPropertiesBloc.selectedFont.value,
      color: textPropertiesBloc.textColor.value,
    );
    TextDisplay.allTexts.refresh();
  }

  updatePaintColor(Color color) {
    _paintColor.value = color;
  }

  updatePaintStroke(double strokeWidth) {
    _paintStroke.value = strokeWidth;
  }

  updateFont(String font) {
    _selectedFont.value = font;
    if (font == 'Montserrat')
      selectedStyle = GoogleFonts.montserrat();
    else if (font == 'Baskerville')
      selectedStyle = GoogleFonts.baskervville();
    else if (font == 'Alike')
      selectedStyle = GoogleFonts.alike();
    else if (font == 'NovaSquare')
      selectedStyle = GoogleFonts.novaSquare();
    else if (font == 'Pacifico')
      selectedStyle = GoogleFonts.pacifico();
    else if (font == 'Arial')
      selectedStyle = TextStyle(
        fontFamily: 'arial',
      );
    else if (font == 'Zuume')
      selectedStyle = TextStyle(
        fontFamily: 'Zuume',
      );

    TextDisplay.allTexts[TextDisplay.selectedTextIndex].textStyle =
        selectedStyle.copyWith(
      fontSize:TextDisplay.allTexts[TextDisplay.selectedTextIndex].textStyle.fontSize,
      fontWeight: textPropertiesBloc.fontWeight.value,
      color: textPropertiesBloc.textColor.value,
    );
    TextDisplay.allTexts.refresh();
  }

  updateSize(String size) {
    _selectedSize.value = size;
    if (size == '20')
      fontsize= 20.0;
    else if (size == '24')
      fontsize= 24.0;
    else if (size == '26')
      fontsize= 26.0;
    else if (size == '28')
      fontsize= 28.0;
    else if (size == '30')
      fontsize= 30.0;
    else if (size == '34')
      fontsize= 34.0;
    else if (size == '38')
      fontsize= 38.0;
    else if (size == '40')
      fontsize= 40.0;
    else if (size == '45')
      fontsize= 45.0;
    else if (size == '50')
      fontsize= 50.0;
    else if (size == '55')
      fontsize= 55.0;
    else if (size == '60')
      fontsize= 60.0;
    else if (size == '65')
      fontsize= 65.0;
    else if (size == '70')
      fontsize= 70.0;
    else if (size == '75')
      fontsize= 75.0;
    else if (size == '80')
      fontsize= 80.0;
    else if (size == '85')
      fontsize= 85.0;
    else if (size == '90')
      fontsize= 90.0;
    else if (size == '95')
      fontsize= 95.0;
    else if (size == '100')
      fontsize= 100.0;


    TextDisplay.allTexts[TextDisplay.selectedTextIndex].textStyle =
        selectedStyle.copyWith(
          fontSize: fontsize,
          fontWeight: textPropertiesBloc.fontWeight.value,
          color: textPropertiesBloc.textColor.value,
        );
    TextDisplay.allTexts.refresh();
  }

  updateFontWeight(FontWeight fw) {
    _fontWeight.value = fw;
    TextDisplay.allTexts[TextDisplay.selectedTextIndex].textStyle =
        selectedStyle.copyWith(
      fontSize: fontsize,
      fontWeight: textPropertiesBloc.fontWeight.value,
      color: textPropertiesBloc.textColor.value,
    );
    TextDisplay.allTexts.refresh();
  }

  updateImage(File imagePath) {
    _selectedImage.value = imagePath;
    isImageAvailable.value = true;
    print(isImageAvailable);
  }

  handleSCCapture(Uint8List image){
    _imageFile = image;
  }

  dispose() {
    _color.close();
    _paintColor.close();
    _fontWeight.close();
    _selectedFont.close();
    _paintStroke.close();
    _selectedImage.close();
    _imageFile!.clear();
  }
}

final textPropertiesBloc = TextPropertiesBloc();
