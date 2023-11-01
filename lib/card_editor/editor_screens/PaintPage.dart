import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Paint/Draawing.dart';
import '../custom_slider.dart';
import 'TextPage.dart';

class PaintPage extends StatefulWidget {
  PaintPage({Key? key}) : super(key: key);

  static late ui.Image _image;
  static List<DrawingArea?> points = [];
  static Color? selected = Colors.black;
  static double? stroke;

  @override
  _PaintPageState createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> {
  @override
  void initState() {
    super.initState();
    PaintPage.selected = Colors.black;
    PaintPage.stroke = 2;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          margin: EdgeInsets.all(5),
          width: size.width,
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12.withOpacity(0.080),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 0.75))
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              CustomColorPicker(Get.width * 0.80, 2),
              CustomSlider(
                Get.width * 0.80,
              ),
            ]),
          )),
    );
  }
}
