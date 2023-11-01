import 'package:card_club/resources/urls.dart';
import 'package:card_club/screens/reminders/update_reminder.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:sizer/sizer.dart';

import '../../resources/models/common_model.dart';
import '../../resources/models/not_added_contacts_model.dart';
import '../../utils/static_data.dart';
import '../groups/bloc/group_bloc.dart';
import 'bloc/get_all_reminder_bloc.dart';
import 'bloc/reminder_bloc.dart';

class UpdateReminderRecipient extends StatefulWidget {
  const UpdateReminderRecipient({Key? key}) : super(key: key);

  @override
  _UpdateReminderRecipientState createState() =>
      _UpdateReminderRecipientState();
}

class _UpdateReminderRecipientState extends State<UpdateReminderRecipient> {
  var _searchTEC = TextEditingController();

  NotAddedContactsModel model = groupBloc.getNotAddedContactsModel;

  List<GroupContacts> groupList = [];
  List<GroupContacts> _filteredList = [];
  List<GroupContacts> newContactsIds = [];
  List<String> temp = [];
  List<int> relationList = [];

  bool isLoading = false;
  int reminderId = 0;

  @override
  void initState() {
    super.initState();
    groupList = model.contacts!;
    temp = [];
    reminderId = Get.arguments;
  }

  @override
  void dispose() {
    _searchTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          // margin: const EdgeInsets.only(top: 35, left: 22, right: 22),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
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
                                  addContactsInReminder(context, reminderId);
                                },
                                child: Text(
                                  "Done",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 03.h),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 04.h),
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 07.h,
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
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.12,
                padding: EdgeInsets.only(top: 30, left: 22, right: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Recipient',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.75),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Who is the recipient?',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                        color: main_color,
                      ))
                    : groupList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: _searchTEC.text.isEmpty
                                ? groupList.length
                                : _filteredList.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return _searchTEC.text.isEmpty
                                  ? _myContactsWidget(groupList[index], index)
                                  : _myContactsWidget(
                                      _filteredList[index], index);
                            })
                        : Container(
                            child: Center(
                              child: Text('There is no contacts'),
                            ),
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myContactsWidget(GroupContacts contacts, int index) {
    String finalUrl = '';
    try {
      String imagePath = contacts.imagePath!.toString();
      finalUrl = imageUrl + imagePath;
    } catch (error) {
      finalUrl = 'https://i.postimg.cc/mDrQwBDL/user3.png';
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 22, right: 22, bottom: 0),
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
                  borderRadius: BorderRadius.all(Radius.circular(16)),
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
                        contacts.name.toString(),
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
                    if (temp.contains(contacts.id.toString())) {
                      temp.remove(contacts.id.toString());

                      newContactsIds
                          .removeWhere((data) => data.id == contacts.id);
                    } else {
                      temp.add(contacts.id.toString());

                      newContactsIds.add(GroupContacts(id: contacts.id));
                    }
                    print(contacts.id);
                  });

                  print(temp);
                  print(newContactsIds);
                },
                child: temp.contains(contacts.id.toString())
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
    _filteredList = [];
    for (int i = 0; i < groupList.length; ++i) {
      print(groupList[i].name);

      var name = groupList[i].name;
      var imagePath = groupList[i].imagePath;
      var id = groupList[i].id;

      if (name!.contains(_searchTEC.text.toLowerCase())) {
        _filteredList
            .add(GroupContacts(name: name, imagePath: imagePath, id: id));
      }
      setState(() {
        print(_filteredList.length);
      });
    }
  }

  addContactsInReminder(BuildContext context, int reminderId) async {
    int index = StaticData.reminderIndex;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await reminderBloc.updateReminderAPI(
      reminderId,
      temp,
      relationList,
      '',
      '',
    );
    await getReminderBloc.getReminderRequest();

    CommonModel commonModel = reminderBloc.updateReminderModel;
    NotAddedContactsModel model = groupBloc.getNotAddedContactsModel;

    setState(() {
      temp = [];
      groupList = model.contacts!;
    });
    _snackBar("Message", commonModel.message.toString());
    Navigator.of(context).pop();

    Get.off(() => UpdateReminder(), arguments: index);
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
