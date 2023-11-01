import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionController extends GetxController {

  var internetStatus=0.obs;
  late StreamSubscription<InternetConnectionStatus> _listener;

  @override
  void onInit() {
    _listener=InternetConnectionChecker().onStatusChange.listen((event) {

      switch(event){
        case InternetConnectionStatus.connected:internetStatus.value=1;
        break;
        case InternetConnectionStatus.disconnected:internetStatus.value=0;
        break;
      }
    });
    super.onInit();
  }
  @override
  void onClose(){
    _listener.cancel();
    super.onClose();
  }
  @override
  void onReady() {
    super.onReady();
  }
}