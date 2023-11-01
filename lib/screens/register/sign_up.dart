import 'package:card_club/resources/cache_manager.dart';
import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/screens/login/sign_in.dart';
import 'package:card_club/screens/register/bloc/register_bloc.dart';
import 'package:card_club/screens/register/verify_otp.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:card_club/utils/connection_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with CacheManager {
  final formKey = GlobalKey<FormState>();

  var _firstNameTEC = TextEditingController();
  var _lastNameTEC = TextEditingController();
  var _emailTEC = TextEditingController();
  var _phoneTEC = TextEditingController();
  var _passwordTEC = TextEditingController();
  var _password_confirmTEC = TextEditingController();

  bool _isObscurePass = true;
  bool _isObscureConPass = true;

  var _connectionController = Get.put(ConnectionController());

  @override
  void dispose() {
    super.dispose();
    _firstNameTEC.dispose();
    _lastNameTEC.dispose();
    _emailTEC.dispose();
    _phoneTEC.dispose();
    _passwordTEC.dispose();
    _password_confirmTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        body: ListView(children: [
          SizedBox(height: 80),
          Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 0.75))
              ],

              //boxShadow: [BoxShadow(blurRadius: 0.02)],
              borderRadius: BorderRadius.all(
                Radius.circular(37),
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Create your Account',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameTEC,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            focusColor: main_color,
                            contentPadding: EdgeInsets.only(top: 15),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: main_color),
                            ),
                            hintText: "First name",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            ),
                          ),
                          style: TextStyle(fontSize: 16),
                          cursorColor: main_color,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z]')),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (String? value) {
                            if (_firstNameTEC.text.isEmpty)
                              return " first_name Required!";
                            else
                              return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameTEC,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            focusColor: main_color,
                            contentPadding: EdgeInsets.only(top: 15),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: main_color),
                            ),
                            hintText: "Last name",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            ),
                          ),
                          style: TextStyle(fontSize: 16),
                          cursorColor: main_color,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z]')),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (String? value) {
                            if (_lastNameTEC.text.isEmpty)
                              return "last_name Required!";
                            else
                              return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _emailTEC,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            focusColor: main_color,
                            contentPadding: EdgeInsets.only(top: 15),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: main_color),
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(
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
                              return "email Required!";
                            if (emailValid != true)
                              return "invalid Email";
                            else
                              return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _phoneTEC,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            focusColor: main_color,
                            contentPadding: EdgeInsets.only(top: 15),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: main_color),
                            ),
                            hintText: "Phone Number",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            ),
                          ),
                          style: TextStyle(fontSize: 16),
                          cursorColor: main_color,
                          validator: (String? value) {
                            if (_phoneTEC.text.isEmpty) {
                              return 'Please enter mobile number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _passwordTEC,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _isObscurePass,
                          decoration: InputDecoration(
                            focusColor: main_color,
                            contentPadding: EdgeInsets.only(top: 20),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: main_color),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.black26),
                            suffixIcon: IconButton(
                              color: main_color,
                              icon: Icon(
                                _isObscurePass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscurePass = !_isObscurePass;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(fontSize: 16),
                          cursorColor: main_color,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(11),
                          ],
                          validator: (String? value) {
                            String pattern =
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
                            RegExp regExp = new RegExp(pattern);

                            if (_passwordTEC.text.isEmpty)
                              return "password Required!";
                            else if (_passwordTEC.text.length <= 5)
                              return "At least_6_characters";
                            else if (!regExp
                                .hasMatch(_passwordTEC.text.toString()))
                              return "Please use correct format.eg:Abc1@";
                            else
                              return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _password_confirmTEC,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _isObscureConPass,
                          decoration: InputDecoration(
                            focusColor: main_color,
                            contentPadding: EdgeInsets.only(top: 20),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: main_color),
                            ),
                            hintText: "Confirm password",
                            hintStyle: TextStyle(color: Colors.black26),
                            suffixIcon: IconButton(
                              color: main_color,
                              icon: Icon(
                                _isObscureConPass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscureConPass = !_isObscureConPass;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(fontSize: 16),
                          cursorColor: main_color,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(13),
                          ],
                          validator: (String? value) {
                            if (_passwordTEC.text.isEmpty)
                              return "confirm_password Required!";
                            else if (_passwordTEC.text.length <= 5)
                              return "At least_6_characters";
                            else if (_passwordTEC.text !=
                                _password_confirmTEC.text)
                              return "password not match!";
                            else
                              return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: 50,
                      margin: EdgeInsets.only(top: 32, bottom: 10),
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
                          FocusManager.instance.primaryFocus?.unfocus();

                          var status =
                              _connectionController.internetStatus.value;
                          print(status);

                          var firstName = _firstNameTEC.text.trim();
                          var lastName = _lastNameTEC.text.trim();
                          var email = _emailTEC.text.trim();
                          var phone = _phoneTEC.text.trim();
                          var password = _passwordTEC.text.trim();
                          var passwordConfirm =
                              _password_confirmTEC.text.trim();

                          List<String> data = [
                            firstName,
                            lastName,
                            email,
                            phone,
                            password,
                            passwordConfirm,
                          ];

                          if (formKey.currentState!.validate()) {
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

                            CommonModel commonModel = registerBloc.otpModel;
                            _snackBar("Check Your Email!",
                                commonModel.message.toString());

                            Navigator.of(context).pop();

                            Get.to(VerifyOtp(), arguments: data);
                          }
                        },
                        child: Text(
                          "Create account",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 12, left: 40, right: 40),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            margin:
                EdgeInsets.only(left: 5.h, right: 5.h, top: 3.h, bottom: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Get.off(() => SignIn(), transition: Transition.rightToLeft);
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: Color(0xFFFF2F2F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ]),
      ),
    );
  }

  void _snackBar(var title, var message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.black45, colorText: Colors.white);
  }

  String? validateMobile(String value) {
    return null;
  }
}
