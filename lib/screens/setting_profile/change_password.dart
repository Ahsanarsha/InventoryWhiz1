import 'package:card_club/resources/models/user_profile_model.dart';
import 'package:card_club/screens/forgot_password/bloc/forget_password_bloc.dart';
import 'package:card_club/screens/profile/bloc/user_profile_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../resources/models/common_model.dart';
import 'edit_user_profile.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var _oldPasswordTEC = TextEditingController();
  var _passwordTEC = TextEditingController();
  var _confirmPasswordTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isObscureOldPass = true;
  bool _isObscurePass = true;
  bool _isObscureConPass = true;

  UserProfileModel model = userProfileBloc.userProfileModel;

  @override
  void dispose() {
    super.dispose();
    _oldPasswordTEC.dispose();
    _passwordTEC.dispose();
    _confirmPasswordTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 30, left: 22, right: 22),
          child: ListView(
            physics: BouncingScrollPhysics(),
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
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Change password',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 01.h),
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
                      SizedBox(height: 06.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Old password:",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 02.h),
                      TextFormField(
                        controller: _oldPasswordTEC,
                        obscureText: _isObscureOldPass,
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
                          hintText: "Old...",
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                          ),
                          suffixIcon: IconButton(
                            color: main_color,
                            icon: Icon(
                              _isObscureOldPass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscureOldPass = !_isObscureOldPass;
                              });
                            },
                          ),
                        ),
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(11),
                        ],
                        validator: (String? value) {
                          if (_oldPasswordTEC.text.trim().isEmpty)
                            return "password Required!";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 08.h),
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
                      SizedBox(height: 02.h),
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

                          if (_passwordTEC.text.trim().isEmpty)
                            return "password Required!";
                          else if (_passwordTEC.text.trim().length <= 5)
                            return "At least_6_characters";
                          else if (!regExp
                              .hasMatch(_passwordTEC.text.trim().toString()))
                            return "Please use correct format.eg:Abc1@";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 03.h),
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
                      SizedBox(height: 02.h),
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
                          if (_confirmPasswordTEC.text.trim().isEmpty)
                            return "confirm_password Required!";
                          else if (_confirmPasswordTEC.text.trim().length <= 5)
                            return "At least_6_characters";
                          else if (_passwordTEC.text.trim() !=
                              _confirmPasswordTEC.text.trim())
                            return "password not match!";
                          else
                            return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () async {
                    var oldPassword = _oldPasswordTEC.text.trim();
                    var password = _passwordTEC.text.trim();
                    var confirmPassword = _confirmPasswordTEC.text.trim();

                    print(oldPassword);
                    print(password);
                    print(confirmPassword);

                    if (model.providerName == "google" ||
                        model.providerName == "facebook") {
                      _snackBar("Message!",
                          "You can't change the password because social login");
                    } else {
                      if (formKey.currentState!.validate())
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (dialogContext) {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: main_color,
                              ));
                            });

                      await forgetPasswordBloc.changePasswordRequest(
                          oldPassword, password, confirmPassword);

                      CommonModel commonModel =
                          forgetPasswordBloc.changePasswordModel;

                      print(commonModel.statusCode);

                      if (commonModel.statusCode == 200) {
                        if (commonModel.message
                            .toString()
                            .contains("not match")) {
                          Navigator.of(context).pop();
                          _snackBar("Message!", commonModel.message.toString());
                        } else {
                          _snackBar("Message!", commonModel.message.toString());
                          Get.off(() => EditUserProfile());
                        }
                      } else if (commonModel.statusCode == 422) {
                        _snackBar("Message!", commonModel.message.toString());
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
              SizedBox(height: 02.h),
            ],
          ),
        ),
      ),
    );
  }

  _snackBar(var title, var message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black45,
      colorText: Colors.white,
    );
  }
}
