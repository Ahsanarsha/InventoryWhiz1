//File not in use

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ImagePropertiesBloc {
//
//   var _zoom = 0.0.obs;
//   Rx<double> get zoomStroke => _zoom;
//   late TapDownDetails _tapDetails;
//
//
//   handleTapDown(TapDownDetails details) {
//
//     _tapDetails = details;
//   }
//
//   updateZoom(double zoom) {
//
//       final position = _tapDetails.localPosition;
//       // For a 3x zoom
//       if(zoom == 2.0){
//         _zoom.value = (Matrix4.identity()
//           ..translate(-position.dx, -position.dy)
//           ..scale(2.0)) as double;
//
//       }else
//       if(zoom == 2.5){
//         _zoom.value = (Matrix4.identity()
//           ..translate(-position.dx, -position.dy)
//           ..scale(2.5)) as double;
//
//       }
//       else if(zoom ==3.0){
//
//       _zoom.value = (Matrix4.identity()
//         ..translate(-position.dx * 2, -position.dy * 2)
//         ..scale(3.0)) as double;
//       // Fox a 2x zoom
//       // ..translate(-position.dx, -position.dy)
//       // ..scale(2.0);
//     }
//   }
//
//
// }
// final imagePropertiesBloc = ImagePropertiesBloc();