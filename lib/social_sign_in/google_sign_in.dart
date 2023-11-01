import 'package:card_club/resources/cache_manager.dart';
import 'package:card_club/resources/models/social_model.dart';
import 'package:card_club/screens/home_card/bloc/all_card_bloc.dart';
import 'package:card_club/screens/home_gift/bloc/get_gift_by_id_bloc.dart';
import 'package:card_club/screens/profile/bloc/user_profile_bloc.dart';
import 'package:card_club/screens/register/bloc/social_bloc.dart';
import 'package:card_club/social_sign_in/phone_number.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../bottom_navigation.dart';
import '../resources/models/gift_category_model.dart';

class GoogleSignInProvider extends ChangeNotifier with CacheManager{

  final googleSingIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future googleLogin(BuildContext context) async {

    final googleUser = await googleSingIn.signIn();

    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;


    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    print(credential);

   UserCredential userCredential = await auth.signInWithCredential(credential);
    notifyListeners();

    final User? user = auth.currentUser;
    final uid = user!.uid.toString();

    var email=userCredential.user!.email;
    var name=userCredential.user!.displayName;

    print(email);
    print(name);
    print(uid);


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
        "",
        "google",
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

        Get.offAll(BottomNavigation(),arguments: 0);
      }else if(socialBloc.socialModel.message.contains("phone_num required")) {

        List<String?> list=[email,name,uid,"google"];

        Navigator.of(context).pop();

        Get.to(PhoneNumber(),arguments: list);

      }
    });

  }


}
