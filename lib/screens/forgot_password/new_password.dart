import 'dart:ui';

import 'package:card_club/screens/login/sign_in.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'bloc/forget_password_bloc.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  var _passwordTEC = TextEditingController();
  var _confirmPasswordTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isObscurePass = true;
  bool _isObscureConPass = true;
  var email;

  @override
  void initState() {
    super.initState();
    email = Get.arguments;
  }

  @override
  void dispose() {
    super.dispose();
    _passwordTEC.dispose();
    _confirmPasswordTEC.dispose();

  }

  @override
  Widget build(BuildContext context) {

    print(email);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 30, left: 22, right: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: main_color,
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70.h,
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'New password',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Change your password",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "New password:",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _passwordTEC,
                          obscureText: _isObscurePass,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: main_color,
                              ),
                            ),
                            hintText: "New...",
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                            ),
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
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Confirm password:",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _confirmPasswordTEC,
                          obscureText: _isObscureConPass,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: main_color,
                              ),
                            ),
                            hintText: "Confirm...",
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                            ),
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
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(11),
                          ],
                          validator: (String? value) {
                            if (_confirmPasswordTEC.text.isEmpty)
                              return "confirm_password Required!";
                            else if (_confirmPasswordTEC.text.length <= 5)
                              return "At least_6_characters";
                            else if (_passwordTEC.text !=
                                _confirmPasswordTEC.text)
                              return "password not match!";
                            else
                              return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        var password = _passwordTEC.text.trim();
                        var confirmPassword = _confirmPasswordTEC.text.trim();

                        print(email);

                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (dialogContext) {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: main_color,
                              ));
                            });

                        await forgetPasswordBloc.forgetPasswordRequest(email, password, confirmPassword);

                        Navigator.of(context).pop();

                        if (forgetPasswordBloc.forgetPasswordModel.statusCode == 200) {

                          _snackBar("Message", forgetPasswordBloc.forgetPasswordModel.message);
                          Get.offAll(() => SignIn());

                        } else if (forgetPasswordBloc.forgetPasswordModel.statusCode == 401) {
                          _snackBar("Message", forgetPasswordBloc.forgetPasswordModel.message);
                        } else {
                          _snackBar("Message", "Internal server error");
                        }


                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: 50,
                      margin: const EdgeInsets.only(top: 12),
                      decoration: const BoxDecoration(
                        color: main_color,
                        borderRadius: BorderRadius.all(Radius.circular(37)),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Change password",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
