import 'dart:io';
import 'dart:typed_data';

import 'package:card_club/bottom_navigation.dart';
import 'package:card_club/utils/static_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' show get;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../utils/app_colors.dart';

class ImageDisplay extends StatelessWidget {
  final Uint8List imageData;

  ImageDisplay(this.imageData);

  ScreenshotController screenshotController = ScreenshotController();

  final pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                _createPDF(context);

              },
              child: Text(
                'Share This Testing Pdf',
              ),
            ),
          ),
        ),
      ),
    );
    // );
  }

  Future<void> _createPDF(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    var response = await get(Uri.parse(StaticData.card_url));
    var data = response.bodyBytes;
    ByteData imageBytes = await rootBundle.load('assets/pdf_logo.png');
    List<int> values = imageBytes.buffer.asUint8List();
    PdfDocument document = PdfDocument();
    final image1 = document.pages.add();
    final image2 = document.pages.add();
    final image3 = document.pages.add();

    image1.graphics
        .drawString('', PdfStandardFont(PdfFontFamily.helvetica, 30));

    image1.graphics.drawImage(
      PdfBitmap(data),    // Card Url Empty
      const Rect.fromLTWH(
        0,
        100,
        440,
        550,
      ),
    );

    image2.graphics
        .drawString('', PdfStandardFont(PdfFontFamily.helvetica, 30));

    image2.graphics.drawImage(
      PdfBitmap(imageData),
      const Rect.fromLTWH(
        0,
        100,
        440,
        550,
      ),
    );

    image3.graphics
        .drawString('', PdfStandardFont(PdfFontFamily.helvetica, 30));

    image3.graphics.drawImage(
      PdfBitmap(values),
      const Rect.fromLTWH(
        0,
        100,
        440,
        550,
      ),
    );

    List<int> bytes = document.save();
    document.dispose();

    Navigator.of(context).pop();

    saveAndLaunchFile(bytes, 'CardClub.pdf');
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())!.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);

    await Share.shareFiles(['$path/$fileName'], text: 'Great picture');

    Get.offAll(() => BottomNavigation(), arguments: 1);

    //todo::launch pdf in system apps
    //OpenFile.open('$path/$fileName');
  }
}
