import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../editor_controller.dart';
import '../text_properties_bloc.dart';

class TextPage extends StatefulWidget {
  const TextPage({Key? key}) : super(key: key);

  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  List<String> primaryFontsList = [
    'Arial',
    'Montserrat',
    'Zuume',
    'Baskerville',
    'Alike',
    'NovaSquare',
    'Pacifico'
  ];

  List<String> primaryFontSize = [
    '20',
    '24',
    '26',
    '28',
    '30',
    '32',
    '34',
    '38',
    '40',
    '45',
    '50',
    '55',
    '60',
    '65',
    '70',
    '75',
    '80',
    '85',
    '90',
    '100'
  ];

  EditorController _editorController = Get.put(EditorController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.all(5),
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
        width: size.width,
        height: size.height * 0.13,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 20,
              margin: EdgeInsets.only(top: 3),
              width: Get.width * .82,
              child: ListView.builder(
                shrinkWrap: true,
                physics:  BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: primaryFontSize.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      textPropertiesBloc.updateSize(primaryFontSize[index]);
                      //_showPopupMenu();
                    },
                    child: Obx(
                          () => Container(
                        decoration: textPropertiesBloc.selectedSize.value ==
                            primaryFontSize[index]
                            ? BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Color(0xff999999)))
                            : BoxDecoration(),
                        padding: index == 0
                            ? EdgeInsets.only(left: 0)
                            : EdgeInsets.symmetric(horizontal: 19),
                        child: Text(
                          primaryFontSize[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            CustomColorPicker(Get.width * 0.800, 0),
            Container(
              height: 20,
              margin: EdgeInsets.only(top: 3),
              width: Get.width * .82,
              child: ListView.builder(
                shrinkWrap: true,
                physics:  BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: primaryFontsList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      textPropertiesBloc.updateFont(primaryFontsList[index]);
                      _showPopupMenu();
                    },
                    child: Obx(
                      () => Container(
                        decoration: textPropertiesBloc.selectedFont.value ==
                                primaryFontsList[index]
                            ? BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: Color(0xff999999)))
                            : BoxDecoration(),
                        padding: index == 0
                            ? EdgeInsets.only(left: 0)
                            : EdgeInsets.symmetric(horizontal: 9),
                        child: Text(
                          primaryFontsList[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }




  void _showPopupMenu() async {
    await showMenu(
      context: context,
      position: _editorController.weightDialoguePosition,
      // RelativeRect.fromLTRB(63, 465, 100, 50),
      items: [
        PopupMenuItem(
          value: 1,
          child: Text("Regular"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Bold"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      FontWeight fw = FontWeight.normal;
      if (value == 1)
        fw = FontWeight.normal;
      else if (value == 2) {
        fw = FontWeight.bold;
      }
      textPropertiesBloc.updateFontWeight(fw);
      // NOTE: even you didn't select item this method will be called with null of value so you should call your call back with checking if value is not null
      if (value != null) print(value);
    });
  }
}

class CustomColorPicker extends StatefulWidget {
  int tabIndex;
  final double width;

  CustomColorPicker(this.width, this.tabIndex);

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState(tabIndex);
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  int tabIndex;

  _CustomColorPickerState(this.tabIndex);

  final List<Color> _colors = [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 128, 0),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 128, 255, 0),
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 0, 255, 128),
    Color.fromARGB(255, 0, 255, 255),
    Color.fromARGB(255, 0, 128, 255),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 127, 0, 255),
    Color.fromARGB(255, 255, 0, 255),
    Color.fromARGB(255, 255, 0, 127),
    Color.fromARGB(255, 128, 128, 128),
  ];
  double _colorSliderPosition = 0;
  Color? _currentColor;

  @override
  initState() {
    super.initState();
    _currentColor = _calculateSelectedColor(_colorSliderPosition);
  }

  _colorChangeHandler(double position) {
    //handle out of bounds positions
    if (position > widget.width) {
      position = widget.width;
    }
    if (position < 0) {
      position = 0;
    }
    setState(() {
      _colorSliderPosition = position;
      _currentColor = _calculateSelectedColor(_colorSliderPosition);
    });
    if (tabIndex == 0)
      textPropertiesBloc.updateColor(_currentColor!);
    else if (tabIndex == 2) {
      print("changing painter color");
      textPropertiesBloc.updatePaintColor(_currentColor!);
    }
  }

  Color _calculateSelectedColor(double position) {
    //determine color
    double positionInColorArray =
        (position / widget.width * (_colors.length - 1));
    print(positionInColorArray);
    int index = positionInColorArray.truncate();
    print(index);
    double remainder = positionInColorArray - index;
    if (remainder == 0.0) {
      _currentColor = _colors[index];
    } else {
      //calculate new color
      int redValue = _colors[index].red == _colors[index + 1].red
          ? _colors[index].red
          : (_colors[index].red +
                  (_colors[index + 1].red - _colors[index].red) * remainder)
              .round();
      int greenValue = _colors[index].green == _colors[index + 1].green
          ? _colors[index].green
          : (_colors[index].green +
                  (_colors[index + 1].green - _colors[index].green) * remainder)
              .round();
      int blueValue = _colors[index].blue == _colors[index + 1].blue
          ? _colors[index].blue
          : (_colors[index].blue +
                  (_colors[index + 1].blue - _colors[index].blue) * remainder)
              .round();
      _currentColor = Color.fromARGB(255, redValue, greenValue, blueValue);
    }
    return _currentColor!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: (DragStartDetails details) {
              print("_-------------------------STARTED DRAG");
              _colorChangeHandler(details.localPosition.dx);
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              _colorChangeHandler(details.localPosition.dx);
            },
            onTapDown: (TapDownDetails details) {
              _colorChangeHandler(details.localPosition.dx);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Container(
                width: widget.width,
                height: 5,
                decoration: BoxDecoration(
                  // border: Border.all(width: 2, color: Colors.grey[800]!),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: _colors),
                ),
                child: CustomPaint(
                  painter: _SliderIndicatorPainter(_colorSliderPosition),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
