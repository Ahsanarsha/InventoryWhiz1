import 'package:card_club/resources/cache_manager.dart';
import 'package:card_club/resources/models/login_error_model.dart';
import 'package:card_club/resources/models/login_model.dart';
import 'package:card_club/resources/models/user_profile_model.dart';
import 'package:card_club/screens/forgot_password/enter_email.dart';
import 'package:card_club/screens/home_card/bloc/all_card_bloc.dart';
import 'package:card_club/screens/home_gift/bloc/get_gift_by_id_bloc.dart';
import 'package:card_club/screens/login/bloc/login_bloc.dart';
import 'package:card_club/screens/profile/bloc/user_profile_bloc.dart';
import 'package:card_club/screens/register/sign_up.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:card_club/utils/connection_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../bottom_navigation.dart';
import '../../resources/models/get_gift_by_id_model.dart';
import '../../resources/models/gift_category_model.dart';
import '../../social_sign_in/facebook_sign_in.dart';
import '../../social_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with CacheManager {
  var _connectionController = Get.put(ConnectionController());

  _handleGoogleSignIn() {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    provider.googleLogin(context);
  }

  final formKey = GlobalKey<FormState>();

  var _emailTEC = TextEditingController();
  var _passwordTEC = TextEditingController();
  bool _isObscurePass = true;

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _passwordTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [main_color, Colors.white],
            stops: [0.1, 0.6],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: ListView(
            children: <Widget>[
              SizedBox(height: 08.h),
              Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(37)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        offset: Offset(0.0, 0.75))
                  ],
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 01.h),
                      Container(
                        child: const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: const Text(
                          'Sign in your Account',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 03.h),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _emailTEC,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                focusColor: main_color,
                                contentPadding: EdgeInsets.only(top: 15),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: main_color),
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black26,
                                ),
                              ),
                              style: TextStyle(fontSize: 16),
                              cursorColor: main_color,
                              validator: (String? value) {
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(_emailTEC.text);
                                if (_emailTEC.text.isEmpty)
                                  return "Email Required!";
                                if (emailValid != true)
                                  return "Invalid Email";
                                else
                                  return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _passwordTEC,
                              obscureText: _isObscurePass,
                              decoration: InputDecoration(
                                focusColor: main_color,
                                contentPadding: EdgeInsets.only(top: 20),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: main_color),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                                suffixIcon: IconButton(
                                  color: main_color,
                                  icon: Icon(
                                    _isObscurePass
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {},
                                  // onPressed: () {
                                  //   setState(() {
                                  //     _isObscurePass = !_isObscurePass;
                                  //   });
                                  // },
                                ),
                              ),
                              style: TextStyle(fontSize: 16),
                              cursorColor: main_color,
                              validator: (String? value) {
                                if (_passwordTEC.text.isEmpty)
                                  return "Password Required!";
                                else if (_passwordTEC.text.length <= 5)
                                  return "At least_6_characters";
                                else
                                  return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 01.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => EnterEmail());
                              },
                              child: Text(
                                "Forgot password?",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 07.h,
                            margin: EdgeInsets.only(top: 32, bottom: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: main_color,
                                elevation: 0.0,
                                //shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                              onPressed: () async {
                                var status =
                                    _connectionController.internetStatus.value;
                                var email = _emailTEC.text.trim();
                                var password = _passwordTEC.text.trim();
                                if (formKey.currentState!.validate()) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  loginUser(context, email, password);
                                }
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                alignment: Alignment.center,
                child: const Text(
                  "-OR-",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  var status = _connectionController.internetStatus.value;
                  // status == 1
                  //     ? AuthService().fbSignIn(context)
                  //     : _snackBar(
                  //         "Internet", "Check your Internet Connection.");

                  AuthService().fbSignIn(context);
                },
                child: Container(
                  height: 07.h,
                  margin: const EdgeInsets.only(top: 12, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(37)),
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/facebook.png',
                        height: 24,
                        width: 24,
                      ),
                      SizedBox(
                        width: 03.h,
                      ),
                      Text(
                        "Sign in with Facebook",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  var status = _connectionController.internetStatus.value;

                  // status == 1
                  //     ? _handleGoogleSignIn()
                  //     : _snackBar(
                  //         "Internet", "Check your Internet Connection.");

                  _handleGoogleSignIn();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 12, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(37)),
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        height: 24,
                        width: 24,
                      ),
                      SizedBox(
                        width: 03.h,
                      ),
                      Text(
                        "Sign in with Google     ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                  height: 07.h,
                ),
              ),
              SizedBox(height: 08.h),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "if you don't have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(
                      width: 01.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.off(() => SignUp(),
                            transition: Transition.leftToRight);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xFFFF2F2F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 02.h),
            ],
          ),
        ));
  }

  loginUser(BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: main_color,
            ),
          );
        });

    FirebaseMessaging.instance.getToken().then((value) async {
      print('Token value is :: $value');

      await loginBloc.loginRequest(email, password, value);

      if (loginBloc.loginModel.statusCode == 200) {
        LoginModel loginModel = loginBloc.loginModel;
        saveToken(loginModel.token);
        saveIsLogin(true);

        //todo::get Information of user
        await userProfileBloc.userProfileRequest();
        await getGiftBYIdBloc.giftCategoryRequest();

        GiftCategoryModel model = getGiftBYIdBloc.giftCategoryModel;
        int id = model.data![0].id!;

        await getGiftBYIdBloc.getGiftByIdRequest(id);
        UserProfileModel profileModel = userProfileBloc.userProfileModel;

        Navigator.of(context).pop();
        _snackBar('UserName::', profileModel.name.toString());

        Get.off(BottomNavigation(), arguments: 0);
      } else {
        Navigator.of(context).pop();
        LoginErrorModel errorModel = loginBloc.loginModel;
        _snackBar("Message", errorModel.message.toString());
      }
    });
  }

  _snackBar(var title, var message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black12,
      colorText: Colors.white,
    );
  }
}
