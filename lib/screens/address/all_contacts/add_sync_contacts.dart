import 'package:card_club/bottom_navigation.dart';
import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/resources/models/get_contact_sync_model.dart';
import 'package:card_club/resources/urls.dart';
import 'package:card_club/screens/address/all_contacts/bloc/all_contact_bloc.dart';
import 'package:card_club/screens/address/all_contacts/bloc/sync_contacts_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:sizer/sizer.dart';

class AddSyncContacts extends StatefulWidget {
  @override
  _AddSyncContactsState createState() => _AddSyncContactsState();
}

class _AddSyncContactsState extends State<AddSyncContacts> {
  var _searchTEC = TextEditingController();
  GetContactSyncModel model = syncContactsBloc.getSyncContactsModel;

  List<Users> _searchList = [];
  List<int> _selectedList = [];

  @override
  void dispose() {
    super.dispose();
    _searchTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Container(
                    height: 25.h,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            offset: Offset(0.0, 0.75))
                      ],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(44),
                        bottomLeft: Radius.circular(44),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 05.h,
                              margin:
                                  EdgeInsets.only(top: 30, left: 22, right: 22),
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
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Back",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                height: 05.h,
                                margin: EdgeInsets.only(
                                    top: 30, left: 22, right: 22),
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
                                    addContactAfterSync(context);
                                  },
                                  child: Text(
                                    "Add Friend",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 35, bottom: 10),
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.all(Radius.circular(37)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: TextField(
                              controller: _searchTEC,
                              onSubmitted: (value) {
                                setState(() {
                                  _searchTEC.clear();
                                });
                              },
                              onChanged: (value) {
                                _searchFunction(value);
                              },
                              decoration: InputDecoration(
                                hintText: "",
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.search,
                                  size: 35,
                                  color: Colors.black12,
                                ),
                              ),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(height: 02.h),
              Expanded(
                child: model.users!.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchTEC.text.isEmpty
                            ? model.users!.length
                            : _searchList.length,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return _searchTEC.text.isEmpty
                              ? _myContactsWidget(model.users![index], index)
                              : _myContactsWidget(_searchList[index], index);
                        })
                    : Container(
                        child: Center(
                          child: Text('No contacts match.'),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myContactsWidget(Users user, int index) {
    String finalUrl = '';
    try {
      String imagePath = user.imagePath!.toString();
      finalUrl = imageUrl + imagePath;
    } catch (error) {
      finalUrl = 'https://i.postimg.cc/mDrQwBDL/user3.png';
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 22, right: 22, bottom: 10),
      height: 105,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
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
                        user.name.toString(),
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
                  setState(() {
                    if (_selectedList.contains(user.id!)) {
                      _selectedList.remove(user.id!);
                    } else {
                      _selectedList.add(user.id!);
                    }
                    print(user.id);
                  });

                  print(_selectedList);
                },
                child: _selectedList.contains(user.id!)
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

  _searchFunction(String value) {
    _searchList = [];
    for (int i = 0; i < model.users!.length; ++i) {
      print(model.users![i].name);

      var name = model.users![i].name;
      var imagePath = model.users![i].imagePath;
      var id = model.users![i].id;

      if (name!.contains(value.toUpperCase()) ||
          name.contains(value.toLowerCase())) {
        _searchList.add(
          Users(
            name: name,
            imagePath: imagePath,
            id: id,
          ),
        );
      }
    }
  }

  _snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black12,
      colorText: Colors.white,
    );
  }

  addContactAfterSync(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await syncContactsBloc.addSyncContactsAPI(_selectedList);
    await getAllContactBloc.getAllContactRequest();

    CommonModel model = syncContactsBloc.addSyncContactsModel;

    if (model.status == 200) {
      Navigator.of(context).pop();
      _snackBar('Message', model.message.toString());
      Get.offAll(() => BottomNavigation(), arguments: 4);
    } else {
      _snackBar('Message', 'Something went wrong!');
      Navigator.of(context).pop();
    }
  }
}
