import 'package:card_club/resources/cache_manager.dart';
import 'package:card_club/screens/login/sign_in.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:card_club/utils/connection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> with CacheManager {

  var _connectionController = Get.put(ConnectionController());

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var size=MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: main_color,
          child: ListView(
            physics: ScrollPhysics(),
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(44),
                    bottomLeft: Radius.circular(44),
                  ),
                ),
                height: 60.h,
                width: size.width,
                child: const Image(
                  image: AssetImage('assets/images/launch.png'),
                  filterQuality: FilterQuality.high,
                ),
              ),
              Container(
                height: isPortrait?40.h:220,
                width: size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    SizedBox(height:07.h),

                    Text(
                      'Hi, Nice to Meet\nYou!',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height:02.h),
                    Text(
                      "Let's Create an Account\nfor You.",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height:size.height *0.05),
                    InkWell(
                      onTap: () {
                        //Get.off(()=>CREATE_ACCOUNT());
                        Get.off(() => SignIn());
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(37)),
                        ),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Let's start   ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 20,
                            ),
                          ],
                        )),
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 60,
                      ),
                    ),

                    SizedBox(height: 01.h),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
