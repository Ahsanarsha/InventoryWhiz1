import 'package:card_club/card_editor/text_properties_bloc.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double width;
  CustomSlider(this.width,);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {

  double _colorSliderPosition = 0;
  double? _currentStroke;
  @override
  initState() {
    super.initState();
    _currentStroke =1;
  }

  _strokeChangeHandler(double position) {
    print("In stroke change Handler");
    print('position '+position.toString());
    //handle out of bounds positions
    if (position > widget.width) {
      position = widget.width;
    }
    if (position < 0) {
      position = 0;
    }
    setState(() {
      _colorSliderPosition = position;
      _currentStroke = _calculateSelectedColor(position);
      textPropertiesBloc.updatePaintStroke(_currentStroke!);
    });

      // textPropertiesBloc.updatePaintColor(_currentColor!);

  }

  double _calculateSelectedColor(double position) {
    return (position / widget.width) * 10;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: (DragStartDetails details) {
              _strokeChangeHandler(details.localPosition.dx);
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              _strokeChangeHandler(details.localPosition.dx);
            },
            onTapDown: (TapDownDetails details) {
              _strokeChangeHandler(details.localPosition.dx);
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 12, top: 6),
              child: Container(
                width: widget.width,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
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