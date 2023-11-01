import 'package:card_club/resources/cache_manager.dart';
import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/resources/models/register_error_model.dart';
import 'package:card_club/resources/models/register_model.dart';
import 'package:card_club/screens/dob/user_birthday.dart';
import 'package:card_club/screens/home_card/bloc/all_card_bloc.dart';
import 'package:card_club/screens/home_gift/bloc/get_gift_by_id_bloc.dart';
import 'package:card_club/screens/profile/bloc/user_profile_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../resources/models/gift_category_model.dart';
import 'bloc/register_bloc.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key? key}) : super(key: key);

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> with CacheManager {
  List<String> data = [];
  var token = '';
  var fValue;

  @override
  void initState() {
    super.initState();
    data = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    print(data);

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
                        color: Colors.black.withOpacity(0.75),
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        "Enter the 4-digit code we sent to you at \n${data[2]}.",
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
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          token = v;
                          print(v);
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
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
                                height: 08.h,
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

                                    await registerBloc.otpRequest(data[2]);

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
                                height: 08.h,
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
                                    var firstName = data[0];
                                    var lastName = data[1];
                                    var email = data[2];
                                    var phone = data[3];
                                    var password = data[4];
                                    var passwordConfirm = data[5];

                                    if (token.length != 4 && token.isEmpty) {
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

                                      FirebaseMessaging.instance
                                          .getToken()
                                          .then((value) async {
                                        print('Token value is :: $value');
                                        this.fValue = value;

                                        await registerBloc.registerRequest(
                                          firstName + " " + lastName,
                                          email,
                                          password,
                                          passwordConfirm,
                                          fValue,
                                          token,
                                          phone,
                                        );

                                        if (registerBloc.registerModel.statusCode == 200) {
                                          RegisterModel registerModel =
                                              registerBloc.registerModel;

                                          if (registerModel.status == 401) {
                                            Navigator.of(context).pop();
                                            _snackBar("Message!",
                                                "Please enter the valid OTP.");
                                          } else {
                                            saveToken(registerModel.data!.token);
                                            saveIsLogin(true);

                                            //todo::get Information of user
                                            await userProfileBloc.userProfileRequest();
                                            await getGiftBYIdBloc.giftCategoryRequest();
                                            GiftCategoryModel model=getGiftBYIdBloc.giftCategoryModel;
                                            int id=model.data![0].id!;
                                            await getGiftBYIdBloc.getGiftByIdRequest(id);


                                            Navigator.of(context).pop();
                                            _snackBar("status", registerModel.status.toString());

                                            Get.offAll(UserBirthday());
                                          }
                                        } else {
                                          Navigator.of(context).pop();

                                          RegisterErrorModel errorModel =
                                              registerBloc.registerModel;
                                          _snackBar(
                                              "Message",
                                              "" +
                                                  errorModel.errors!.email
                                                      .toString());
                                        }
                                      });
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
