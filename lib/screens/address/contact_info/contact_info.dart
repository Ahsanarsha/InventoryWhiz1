import 'package:card_club/resources/models/single_contact_model.dart';
import 'package:card_club/resources/urls.dart';
import 'package:card_club/screens/address/all_contacts/bloc/all_contact_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../bottom_navigation.dart';
import '../../../resources/models/common_model.dart';
import '../add_new_contact/bloc/get_countries_bloc.dart';
import '../add_new_contact/update_contact.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({Key? key}) : super(key: key);

  @override
  _ContactInfoState createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  SingleContactModel model = getAllContactBloc.getSingleContactModel;

  List<String> temp = [];
  int index = 0;

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      border: Border.all(
        color: Colors.black12,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    index = Get.arguments;
    temp.add(model.data!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    String finalUrl = '';

    try {
      String imagePath = model.data!.imagePath!.toString();
      finalUrl = imageUrl + imagePath;
    } catch (error) {
      finalUrl = 'https://i.postimg.cc/mDrQwBDL/user3.png';
    }

    String? state = '';
    String? country = '';
    String? city = '';

    try {
      state = model.data!.stateId.toString();
      country = model.data!.countryId.toString();
      city = model.data!.cityId.toString();
    } catch (error) {
      state = 'state';
      country = 'country';
      city = 'city';
    }

    return Scaffold(
      backgroundColor: main_color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 35, left: 04.h),
                        height: 07.h,
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
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(
                              color: main_color,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 35, right: 0),
                        child: PopupMenuButton(
                          elevation: 3.2,
                          icon: ImageIcon(
                            AssetImage('assets/icons/ic_more.png'),
                            color: Colors.white,
                          ),
                          color: Colors.white,
                          offset: Offset(-20, 50),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Container(
                                width: 130,
                                padding: EdgeInsets.all(10),
                                decoration: myBoxDecoration(),
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black45,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Container(
                                width: 130,
                                padding: EdgeInsets.all(10),
                                decoration: myBoxDecoration(),
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black45,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              value: 2,
                            ),
                          ],
                          onSelected: (int item) async {
                            FocusScope.of(context).requestFocus(FocusNode());

                            if (item == 1) {
                              updateContact(context);
                            } else if (item == 2) {
                              deleteContact(context, temp);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 90.h,
                    margin: EdgeInsets.only(top: 90),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 25.h, left: 05.h),
                          child: Text(
                            "About",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 04.h, left: 07.h),
                          child: Column(
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${model.data!.address}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ]),
                              SizedBox(height: 02.h),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Role',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ]),
                              SizedBox(height: 02.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${model.data!.email}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 02.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${model.data!.postalCode}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 02.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '$state',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 02.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '$country',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 02.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '$city',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 50,
                    left: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        finalUrl != ''
                            ? ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)),
                                child: ImageCacheing(
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                    url: finalUrl,
                                    loadingWidget: Center(
                                      child: CircularProgressIndicator(),
                                    )),
                              )
                            : CircleAvatar(
                                radius: 65,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                  'assets/images/contact_image.png',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.fill,
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                '${model.data!.name}',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Family group member",
                              style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateContact(BuildContext context) async {
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
    Get.to(UpdateContact(), arguments: index);
  }

  deleteContact(BuildContext context, List<String> id) async {
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

    await getAllContactBloc.delContactsRequest(temp);
    await getAllContactBloc.getAllContactRequest();

    Navigator.of(context).pop();
    CommonModel model = getAllContactBloc.delContactModel;

    _snackBar("Contact", model.message.toString());

    Get.offAll(() => BottomNavigation(), arguments: 4);
  }

  _snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black12,
      colorText: Colors.white,
    );
  }
}
