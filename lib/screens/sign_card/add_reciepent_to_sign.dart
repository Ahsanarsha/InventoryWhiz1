import 'package:card_club/screens/address/member/select_member.dart';
import 'package:card_club/screens/groups/create_grop.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:sizer/sizer.dart';

import '../../resources/models/get_all_groups_model.dart';
import '../../resources/urls.dart';
import '../address/contact_info/contact_info.dart';
import '../groups/bloc/group_bloc.dart';
import 'delivery_option.dart';

class AddReciepentToSign extends StatefulWidget {
  const AddReciepentToSign({Key? key}) : super(key: key);

  @override
  _AddReciepentToSignState createState() => _AddReciepentToSignState();
}

class _AddReciepentToSignState extends State<AddReciepentToSign> {
  GetAllGroupsModel _allGroupsModel = groupBloc.getAllGroupsModel;

  List<Groups>? groupsList = [];
  List<String> temp = [];

  bool pressAttention = false;

  @override
  void initState() {
    super.initState();
    groupsList = _allGroupsModel.groups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 22, right: 22),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                          if(temp.isEmpty && !pressAttention){
                            _snackBar('Message', 'Please select first');
                          }else if(pressAttention && temp.isEmpty){
                            _snackBar('Message', 'Just for me.');
                            Get.to(DeliveryOption());
                          }else if(!pressAttention && temp.isNotEmpty){
                            _snackBar('Message', 'Send in group.');
                            Get.to(()=>SelectMember());
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),

              SizedBox(height: 10.h),

              InkWell(
                onTap: () {
                  setState(() {
                    temp=[];
                    pressAttention = !pressAttention;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: pressAttention ? main_color : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13, left: 20),
                    child: Text(
                      "This is just from me",
                      textAlign: TextAlign.start,
                      style: pressAttention
                          ? TextStyle(fontSize: 16, color: Colors.white)
                          : TextStyle(
                          fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 03.h),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 53,
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "I’d like to add_cont a team or group to also sign this card.",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 02.h),

              InkWell(
                onTap: () {
                  Get.to(() => CreateGroup());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(
                      color: Colors.black12,
                      width: 1,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13, left: 20),
                    child: Text(
                      "Add a Group",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 02.h),

              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: groupsList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _myGroupsWidget(groupsList![index], index);
                  }),

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
                      onPressed: () {},
                      child: Text(
                        "Save Changes",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _myGroupsWidget(Groups groups, int index) {
    String finalUrl = '';
    try {
      String imagePath = groups.imagePath!.toString();
      finalUrl = imageUrl + imagePath;
    } catch (error) {
      finalUrl = 'https://i.postimg.cc/mDrQwBDL/user3.png';
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: index == groupsList!.length - 1 ? 80 : 10),
      height: 105,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Get.to(() => ContactInfo(), arguments: index);
                },
                child: Container(
                  height: 72,
                  width: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: ImageCacheing(
                        height: 72,
                        width: 72,
                        fit: BoxFit.cover,
                        url: finalUrl,
                        loadingWidget: Center(
                          child: CircularProgressIndicator(),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 17,
                        right: 17,
                      ),
                      child: Text(
                        groups.title.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  index = index;
                  setState(() {
                    pressAttention = false;
                    if (temp.contains(groups.id.toString())) {
                      temp.remove(groups.id.toString());
                    } else {
                      temp.add(groups.id.toString());
                    }
                    print(groups.id);
                  });
                  print(temp);
                },
                child: temp.contains(groups.id.toString())
                    ? Icon(
                        Icons.radio_button_checked,
                        color: main_color,
                      )
                    : Icon(
                        Icons.radio_button_off,
                        color: Colors.black26,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
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
