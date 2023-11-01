import 'dart:io';

import 'package:card_club/resources/models/user_profile_model.dart';
import 'package:card_club/resources/models/user_update_detail_model.dart';
import 'package:card_club/resources/urls.dart';
import 'package:card_club/screens/address/add_new_contact/bloc/get_countries_bloc.dart';
import 'package:card_club/screens/dob/bloc/user_update_detail_bloc.dart';
import 'package:card_club/screens/inbox/user_inbox.dart';
import 'package:card_club/screens/profile/bloc/user_profile_bloc.dart';
import 'package:card_club/screens/setting_profile/bloc/debit_card_bloc.dart';
import 'package:card_club/screens/setting_profile/change_password.dart';
import 'package:card_club/screens/setting_profile/your_interest.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../dob/update_user_birthday.dart';
import '../inbox/bloc/notification_bloc.dart';
import 'about_you.dart';
import 'add_debit_card.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({Key? key}) : super(key: key);

  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  var _userName = TextEditingController();
  UserProfileModel profileModel = userProfileBloc.userProfileModel;
  File? imageFile;
  var userName;
  var oldName;
  String finalUrl = '';

  @override
  void dispose() {
    super.dispose();
    _userName.dispose();
  }

  @override
  void initState() {
    super.initState();
    userName = profileModel.name.toString();
    oldName = profileModel.name.toString();

    try {
      String imagePath = profileModel.imagePath!.toString();
      finalUrl = imageUrl + imagePath;
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showBottomSheet();
                    },
                    child: imageFile == null
                        ? Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.center,
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(60), // Image radius
                                  child: finalUrl != ''
                                      ? ImageCacheing(
                                          fit: BoxFit.cover,
                                          url: finalUrl,
                                          loadingWidget: Center(
                                            child: CircularProgressIndicator(),
                                          ))
                                      : Image.asset(
                                          'assets/images/circularperson.png'),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(imageFile!),
                                    fit: BoxFit.fill),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 14.0,
                                      offset: Offset(0.0, 0.75))
                                ],
                              ),
                            ),
                          ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  userName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black.withOpacity(0.85),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.mode_edit_sharp),
                                  color: main_color,
                                  iconSize: 20,
                                  onPressed: () {
                                    openAlertBox();
                                  },
                                )
                              ],
                            ),
                            Text(
                              profileModel.email.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
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
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(8),
                            decoration: new BoxDecoration(
                              color: main_color,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Image(
                              image: AssetImage('assets/icons/ic_mail.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 05.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
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

                          await getCountriesBloc.getCountriesRequest();

                          Navigator.of(context).pop();

                          Get.to(() => AboutYou());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.055,
                                  height: size.height * 0.03,
                                  padding: EdgeInsets.all(4),
                                  decoration: new BoxDecoration(
                                    color: main_color,
                                    borderRadius: new BorderRadius.circular(3),
                                  ),
                                  child: Image.asset(
                                    'assets/images/question_mark.png',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size.width * 0.03),
                            Container(
                              width: size.width * 0.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'About you...',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 02.h),
                      InkWell(
                        onTap: () {
                          Get.to(() => YourInterest());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.055,
                                  height: size.height * 0.03,
                                  padding: EdgeInsets.all(4),
                                  decoration: new BoxDecoration(
                                    color: main_color,
                                    borderRadius: new BorderRadius.circular(3),
                                  ),
                                  child: Image.asset(
                                    'assets/images/info.png',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size.width * 0.03),
                            Container(
                              width: size.width * 0.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Your Interests...',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 02.h),
                      InkWell(
                        onTap: () async {
                          Get.to(() => UpdateUserBirthday());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.055,
                                  height: size.height * 0.03,
                                  decoration: BoxDecoration(
                                    color: main_color,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.cake,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size.width * 0.03),
                            Container(
                              width: size.width * 0.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Add Yor Birthday',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 05.h),
                      InkWell(
                        onTap: () {
                          Get.to(() => ChangePassword());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.055,
                                  height: size.height * 0.03,
                                  padding: EdgeInsets.all(4),
                                  decoration: new BoxDecoration(
                                    color: main_color,
                                    borderRadius: new BorderRadius.circular(3),
                                  ),
                                  child: Image.asset(
                                    'assets/icons/ic_change_password.png',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size.width * 0.03),
                            Container(
                              width: size.width * 0.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Change password',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 02.h),
                      InkWell(
                        onTap: () async {
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

                          await debitCardBloc.getDebitCardAPI();

                          Navigator.of(context).pop();

                          Get.to(() => AddDebitCard());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.055,
                                  height: size.height * 0.03,
                                  padding: EdgeInsets.all(4),
                                  decoration: new BoxDecoration(
                                    color: main_color,
                                    borderRadius: new BorderRadius.circular(3),
                                  ),
                                  child: Image.asset(
                                    'assets/icons/ic_change_password.png',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size.width * 0.03),
                            Container(
                              width: size.width * 0.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Card information',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.07,
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
                                if (oldName != userName && imageFile != null) {
                                  updateNameAndProfile();
                                } else if (oldName != userName) {
                                  updateName();
                                } else if (imageFile != null) {
                                  updateProfile();
                                }
                              },
                              child: Text(
                                "Save Changes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            )),
                      ),
                      SizedBox(height: 02.h),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  openAlertBox() {
    var size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 80.h,
              height: 35.h,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: _userName,
                      decoration: InputDecoration(
                        hintText: 'Enter your name...',
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your changes will be save after click the "Save Changes" Button',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: main_color,
                              elevation: 0.0,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: () {
                              var changedName = _userName.text.trim();

                              Navigator.pop(context);

                              if (changedName != '') {
                                setState(() {
                                  userName = changedName;
                                  print(changedName);
                                  print(userName);
                                });
                              }
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  // Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  showBottomSheet() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text('Gallery'),
            onPressed: () {
              _getFromGallery();
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              _getFromCamera();
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  updateName() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await userUpdateDetailBloc.sendUserUpdateNameRequest(userName);
    await userProfileBloc.userProfileRequest();
    Navigator.of(context).pop();

    UserUpdateDetailModel model = userUpdateDetailBloc.userUpdateNameModel;
    Get.snackbar("Message!", model.message.toString());
  }

  updateProfile() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await userUpdateDetailBloc
        .sendUserUpdateImageRequest(imageFile!.path.toString());
    await userProfileBloc.userProfileRequest();
    Navigator.of(context).pop();

    UserUpdateDetailModel model = userUpdateDetailBloc.userUpdateImageModel;
    Get.snackbar("Message!", model.message.toString());
  }

  updateNameAndProfile() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await userUpdateDetailBloc.sendUserUpdateImageRequest(imageFile!.path.toString());
    await userUpdateDetailBloc.sendUserUpdateNameRequest(userName);
    await userProfileBloc.userProfileRequest();
    Navigator.of(context).pop();

    UserUpdateDetailModel model = userUpdateDetailBloc.userUpdateNameModel;
    Get.snackbar("Message!", model.message.toString());
  }
}
