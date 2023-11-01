import 'package:card_club/resources/cache_manager.dart';
import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/screens/forgot_password/bloc/forget_password_bloc.dart';
import 'package:card_club/screens/register/bloc/register_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import 'new_password.dart';

class PasswordVerifyOtp extends StatefulWidget {
  const PasswordVerifyOtp({Key? key}) : super(key: key);

  @override
  _PasswordVerifyOtpState createState() => _PasswordVerifyOtpState();
}

class _PasswordVerifyOtpState extends State<PasswordVerifyOtp> with CacheManager {

  var email = '';
  String firstPart = '';
  String secondPart = '';
  var token = '';
  List<String> string = [];

  @override
  void initState() {
    super.initState();
    email = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    print(email);
    var string = email.split('@');
    firstPart = string[0].substring(0, 2);
    secondPart = string[1];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: (Colors.white),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ((MediaQuery.of(context).size.height * 0.10)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "OTP sent!",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        "Enter the 4-digit code we sent to you at \n$firstPart********@$secondPart.",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 50, left: 60.0, right: 60.0),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 4,
                        obscureText: false,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            activeFillColor: Colors.white,
                            selectedColor: Colors.white,
                            activeColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            inactiveColor: Colors.grey),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: null,
                        controller: null,
                        keyboardType: TextInputType.text,
                        onCompleted: (v) {
                          token = v;
                          print(v);
                        },
                        onChanged: (v) {
                          token = v;
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          return true;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                                height: 10.h,
                                margin: EdgeInsets.only(
                                    top: 32, bottom: 10, left: 16),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: main_color_light,
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (dialogContext) {
                                          return Center(
                                              child: CircularProgressIndicator(
                                            color: main_color,
                                          ));
                                        });

                                    await registerBloc.otpRequest(email);

                                    Navigator.of(context).pop();

                                    CommonModel commonModel =
                                        registerBloc.otpModel;
                                    _snackBar("Check Your Email!",
                                        commonModel.message.toString());
                                  },
                                  child: Text(
                                    "Resend OTP",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                height: 10.h,
                                margin: EdgeInsets.only(
                                    top: 32, bottom: 10, right: 16),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: main_color,
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (token.length != 4 || token.isEmpty) {
                                      _snackBar(
                                          "Required", "Verification_code");
                                    } else {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (dialogContext) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: main_color,
                                            ));
                                          });

                                      await forgetPasswordBloc.forgetOtpRequest(
                                          email, token);

                                      Navigator.of(context).pop();

                                      if (forgetPasswordBloc.forgetOtpModel.statusCode == 200) {
                                        _snackBar("Message", forgetPasswordBloc.forgetOtpModel.message);
                                        Get.to(() => NewPassword(), arguments: email);
                                      }else if(forgetPasswordBloc.forgetOtpModel.statusCode == 401){
                                        _snackBar("Message", forgetPasswordBloc.forgetOtpModel.message);
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Confirm",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _snackBar(var title, var message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.black45, colorText: Colors.white);
  }
}
