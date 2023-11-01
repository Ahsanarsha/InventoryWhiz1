import 'package:card_club/resources/cache_manager.dart';
import 'package:card_club/resources/models/social_model.dart';
import 'package:card_club/screens/dob/user_birthday.dart';
import 'package:card_club/screens/home_card/bloc/all_card_bloc.dart';
import 'package:card_club/screens/home_gift/bloc/get_gift_by_id_bloc.dart';
import 'package:card_club/screens/profile/bloc/user_profile_bloc.dart';
import 'package:card_club/screens/register/bloc/social_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonenumbers/phonenumbers.dart';
import 'package:sizer/sizer.dart';

import '../resources/models/get_gift_by_id_model.dart';
import '../resources/models/gift_category_model.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> with CacheManager {
  final formKey = GlobalKey<FormState>();
  final _phoneTEC = PhoneNumberEditingController.fromCountryCode('US');

  List<String> list = [];

  @override
  void initState() {
    super.initState();
    list = Get.arguments;
  }

  @override
  void dispose() {
    super.dispose();
    _phoneTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ListView(physics: BouncingScrollPhysics(), children: [
        Container(
            height: 200,
            decoration: new BoxDecoration(
              color: main_color,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.75))
              ],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(44),
                bottomLeft: Radius.circular(44),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 35, left: 16, right: 16),
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: main_color,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Image.asset(
                    'assets/images/phone_number.png',
                    height: 100,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            )),
        SizedBox(
          height: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              'Mobile Verification',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Please enter your mobile number.',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 60, right: 60),
            child: PhoneNumberFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              countryCodeWidth: 40,
              controller: _phoneTEC,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 35),
          height: 08.h,
          padding: EdgeInsets.symmetric(horizontal: 120),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: main_color,
              elevation: 0.0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () async {
              var email = list[0];
              var name = list[1];
              var uid = list[2];
              var providerName = list[3];
              String phoneNumber = _phoneTEC.value.toString();

              if (formKey.currentState!.validate()) {
                savePhoneNumberAPI(
                  context,
                  name,
                  email,
                  uid,
                  phoneNumber,
                  providerName,
                );
              }
            },
            child: Text(
              "Next",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  savePhoneNumberAPI(
    BuildContext context,
    String name,
    String email,
    String uid,
    String phoneNumber,
    String providerName,
  ) {

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    FirebaseMessaging.instance.getToken().then((value) async {
      print('Token value is :: $value');

      await socialBloc.socialRequest(
        name,
        email,
        value,
        uid,
        phoneNumber,
        providerName,
      );

      if (socialBloc.socialModel.success == true) {
        SocialModel socialModel = socialBloc.socialModel;

        saveToken(socialModel.token);
        saveIsLogin(true);

        //todo::get Information of user
        await userProfileBloc.userProfileRequest();
        await getGiftBYIdBloc.giftCategoryRequest();
        GiftCategoryModel model=getGiftBYIdBloc.giftCategoryModel;
        int id=model.data![0].id!;
        await getGiftBYIdBloc.getGiftByIdRequest(id);

        Navigator.of(context).pop();

        Get.offAll(UserBirthday());
      }
    });
  }
}
