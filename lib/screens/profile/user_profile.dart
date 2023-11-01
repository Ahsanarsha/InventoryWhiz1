import 'package:card_club/resources/cache_manager.dart';
import 'package:card_club/resources/models/user_profile_model.dart';
import 'package:card_club/resources/urls.dart';
import 'package:card_club/screens/draft/user_draft.dart';
import 'package:card_club/screens/gift/bloc/my_gift_bloc.dart';
import 'package:card_club/screens/gift/my_gifts_screen.dart';
import 'package:card_club/screens/inbox/bloc/notification_bloc.dart';
import 'package:card_club/screens/inbox/user_inbox.dart';
import 'package:card_club/screens/login/sign_in.dart';
import 'package:card_club/screens/order/bloc/order_bloc.dart';
import 'package:card_club/screens/profile/bloc/user_profile_bloc.dart';
import 'package:card_club/screens/reminders/birthday_reminder.dart';
import 'package:card_club/screens/setting_profile/edit_user_profile.dart';
import 'package:card_club/screens/wishlist/bloc/wishlist_bloc.dart';
import 'package:card_club/screens/wishlist/user_wishlist.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';

import '../../social_sign_in/facebook_sign_in.dart';
import '../dob/user_birthday.dart';
import '../order/all_order.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> with CacheManager {
  static List<String> itemTitle = [
    'My Gifts',
    'Inbox',
    'Order Status',
    'Drafts',
    'Wish List',
    'Received',
    'Reminders',
    'Settings',
    'Log Out',
  ];
  static List<String> itemImages = [
    'assets/images/giftbox.png',
    'assets/images/mail.png',
    'assets/images/order_status.png',
    'assets/images/draft.png',
    'assets/images/wish_list.png',
    'assets/images/received.png',
    'assets/images/reminders.png',
    'assets/images/setting.png',
    'assets/images/logout.png',
  ];

  List<ProfileData> profileData = [];
  UserProfileModel profileModel = userProfileBloc.userProfileModel;

  var globalIndex;

  void initMyList() {
    profileData = List.generate(
        itemTitle.length,
        (index) => ProfileData(
              itemTitle[index],
              itemImages[index],
            ));
  }

  @override
  Widget build(BuildContext context) {
    initMyList();
    String finalUrl = '';
    try {
      String imagePath = profileModel.imagePath!.toString();
      finalUrl = imageUrl + imagePath;
      print(finalUrl);
    } catch (error) {
      print(error);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(left: 16),
          child: ListView(physics: BouncingScrollPhysics(), children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 50),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(35), // Image radius
                  child: finalUrl != ''
                      ? ImageCacheing(
                          fit: BoxFit.cover,
                          url: finalUrl,
                          loadingWidget: Center(
                            child: CircularProgressIndicator(),
                          ))
                      : Image.asset('assets/images/circularperson.png'),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    profileModel.name.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage(
                      'assets/images/birthday_cake.png',
                    ),
                    color: Colors.black,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      profileModel.dob.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  Flexible(
                    child: Text(
                      profileModel.email.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: profileData.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var obj = profileData[index];

                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        setState(() {
                          globalIndex = index;
                        });

                        if (index == 0) {
                          //My Gift
                          myGifts(context);
                        } else if (index == 1) {
                          //Inbox
                         myInbox(context);
                        } else if (index == 2) {
                          //Order status
                         myOrderStatus(context);
                        } else if (index == 3) {
                          //Draft
                          Get.to(UserDraft());
                        } else if (index == 4) {
                          //My MyWishList
                          myWishList(context);
                        } else if (index == 5) {
                          //Received
                          Get.snackbar("Items", "No item yet Received");
                        } else if (index == 6) {
                          //Reminder
                          Get.to(()=>Birthday());
                        } else if (index == 7) {
                          //Setting
                          Get.to(()=>EditUserProfile());
                        } else {
                          //Logout
                          removeId();
                          removeNumber();
                          removeToken();
                          saveIsLogin(false);
                          AuthService().signOut();

                          Get.offAll(() => SignIn());
                        }
                      },
                      child: Container(
                        decoration: index == globalIndex
                            ? BoxDecoration(
                                color: main_color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(37)),
                              )
                            : null,
                        width: MediaQuery.of(context).size.width * 0.80,
                        margin: index == 8
                            ? EdgeInsets.only(top: 30, bottom: 80)
                            : EdgeInsets.only(top: 15),
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 26),
                              child: Image.asset(
                                profileData[index].itemImage,
                                height: 24,
                                width: 24,
                                color: index == globalIndex
                                    ? Colors.white
                                    : Colors.black45,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 26),
                              child: Text(
                                profileData[index].itemTile,
                                style: index == globalIndex
                                    ? TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                      )
                                    : TextStyle(
                                        fontSize: 16,
                                        color: Colors.black.withOpacity(0.85),
                                        fontFamily: 'Montserrat',
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }


  myGifts(BuildContext context) async{
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
                color: main_color,
              ));
        });
    await myGiftsBloc.myGiftsApi();
    Navigator.of(context).pop();

    Get.to(() => MyGiftsScreen());
  }

  myInbox(BuildContext context) async{
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
                color: main_color,
              ));
        });

    await notificationBloc.getNotificationAPI();

    Navigator.of(context).pop();
    Get.to(() => UserInbox());
  }

  myOrderStatus(BuildContext context) async{
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
                color: main_color,
              ));
        });

    await orderBloc.getOrderApi();

    Navigator.of(context).pop();
    Get.to(() => AllOrderScreen());
  }

  myDraft(BuildContext context) async{

  }

  myWishList(BuildContext context) async{
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
                color: main_color,
              ));
        });

    await wishlistBloc.wishlistRequest();

    Navigator.of(context).pop();

    Get.to(() => UserWishList());
  }

}

class ProfileData {
  final String itemTile, itemImage;
  ProfileData(this.itemTile, this.itemImage);
}
