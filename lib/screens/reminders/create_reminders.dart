import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/resources/models/get_reminder_model.dart';
import 'package:card_club/screens/reminders/create_reminder_recipient.dart';
import 'package:card_club/screens/reminders/bloc/relation_bloc.dart';
import 'package:card_club/screens/reminders/bloc/reminder_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_stack/image_stack.dart';
import 'package:sizer/sizer.dart';

import '../../bottom_navigation.dart';
import '../../resources/models/get_relation_model.dart';
import '../../resources/urls.dart';

class CreateReminder extends StatefulWidget {
  const CreateReminder({Key? key}) : super(key: key);

  @override
  _CreateReminderState createState() => _CreateReminderState();
}

class _CreateReminderState extends State<CreateReminder> {
  var _key = GlobalKey<FormFieldState>();

  var _titleETC = TextEditingController();
  var _relationETC = TextEditingController();

  String _date = "20000-1-01";
  String _time = "00:00:00";

  List<String> contacts = [];
  List<Contacts> contactsList = [];
  List<RelationData>? relationList = [];
  List<String> images = [];

  @override
  void dispose() {
    _titleETC.dispose();
    _relationETC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getRelationApi();
  }

  @override
  Widget build(BuildContext context) {
    try {
      print("Selected Contact length= " + contactsList.length.toString());
    } catch (error) {
      print(error);
      contactsList = [];
    }

    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.045),
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
                        images=[];
                        Get.offAll(() => BottomNavigation(), arguments: 0);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),
                  Text(
                    'Create New Reminder',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Colors.black.withOpacity(0.75),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Title',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Colors.black.withOpacity(0.75),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: _titleETC,
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
                        hintText: "Event...",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Date & Time',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Colors.black.withOpacity(0.75),
                    ),
                  ),
                  SizedBox(height: size.height * 0.022),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              DatePicker.showDatePicker(context,
                                  theme: DatePickerTheme(
                                    containerHeight: 210.0,
                                    doneStyle: TextStyle(
                                      color: main_color,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    ),
                                    cancelStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  showTitleActions: true,
                                  minTime: DateTime(2000, 1, 1),
                                  maxTime: DateTime(2022, 12, 31),
                                  onConfirm: (date) {
                                setState(() {
                                  _date =
                                      '${date.year}-${date.month}-${date.day}';
                                });
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    " $_date",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Image(
                                    height: 20,
                                    width: 20,
                                    image: AssetImage(
                                      'assets/icons/ic_calendar.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              DatePicker.showTimePicker(context,
                                  theme: DatePickerTheme(
                                    containerHeight: 210.0,
                                    doneStyle: TextStyle(
                                      color: main_color,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    ),
                                    cancelStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  showSecondsColumn: true,
                                  showTitleActions: true, onConfirm: (time) {
                                setState(() {
                                  _time =
                                      '${time.hour}:${time.minute}:${time.second}';
                                });
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                              setState(() {});
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    " $_time",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Image(
                                    height: 20,
                                    width: 20,
                                    image: AssetImage(
                                      'assets/icons/ic_clock.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),
                  Text(
                    'Relationship',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Colors.black.withOpacity(0.75),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    child: DropdownButtonFormField(
                        key: _key,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                        ),
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
                          hintText: "Mother",
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontFamily: 'Montserrat',
                          ),
                          // filled: true,
                        ),
                        // value: _selected,
                        items: relationList
                            ?.map<DropdownMenuItem<RelationData>>(
                                (RelationData value) {
                          return DropdownMenuItem<RelationData>(
                            value: value,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      value.title!,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      _key.currentState!.reset();
                                      int id = value.id!;
                                      delRelation(context, id);
                                    },
                                    child: Icon(Icons.delete),
                                  ),
                                ]),
                          );
                        }).toList(),
                        onChanged: (RelationData? value) {
                          print(value!.title);
                        }),
                  ),
                  SizedBox(height: 02.h),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        showAddRelationDialog();
                      },
                      child: Container(
                        height: 05.h,
                        width: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image(
                              height: 15,
                              width: 15,
                              image: AssetImage(
                                'assets/icons/ic_plus.png',
                              ),
                            ),
                            Text(
                              'Add relations',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 06.h),
                  Text(
                    'Add recipient',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Colors.black.withOpacity(0.75),
                    ),
                  ),
                  SizedBox(height: 02.h),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        ImageStack(
                          imageList: images,
                          imageRadius: 45,
                          imageCount: images.length,
                          imageBorderWidth: 1,
                          totalCount: images.length,
                          backgroundColor: Colors.transparent,
                          imageBorderColor: main_color,
                          extraCountBorderColor: Colors.black,
                        ),

                        InkWell(
                          onTap: () {
                            _awaitReturnValueRecipient(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/sign.png'),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  SizedBox(height: 04.h),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: 50,
                      child: FlatButton(
                          onPressed: () async {
                            var title = _titleETC.text.trim();
                            var dateTime = _date + " " + _time;

                            if (title.isEmpty) {
                              _snackBar("Required!", "Title of event");
                            } else if (_date == '20000-1-01') {
                              _snackBar("Required!", "date");
                            } else if (_time == '00:00:00') {
                              _snackBar("Required!", "time");
                            } else {
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

                              List<int> relationIds = [];
                              List<int> groupIds = [];

                              await reminderBloc.saveReminderAPI(
                                contacts,
                                0,
                                '',
                                relationIds,
                                groupIds,
                                title,
                                dateTime,
                              );
                              CommonModel model =
                                  reminderBloc.createReminderModel;
                              Navigator.of(context).pop();
                              Get.snackbar("Message", model.message.toString());

                              Get.offAll(() => BottomNavigation(),
                                  arguments: 0);
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: main_color,
                          child: const Text(
                            'Create reminder',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          )),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAddRelationDialog() {
    _relationETC.text = "";

    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.1),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 200,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 00,
                    ),
                    Text(
                      'Add Relation',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Add a custom relation.',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: Colors.black.withOpacity(0.30),
                      ),
                    ),
                    TextFormField(
                      controller: _relationETC,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: main_color),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.10),
                          ),
                        ),
                        contentPadding: EdgeInsets.only(top: 20),
                        hintText: "Relation...",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          color: Colors.black.withOpacity(0.20),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(top: 25),
                              decoration: const BoxDecoration(
                                color: main_color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(37)),
                              ),
                              child: const Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              Get.back();
                              var title = _relationETC.text.trim().toString();

                              if (title.isNotEmpty) {
                                saveRelation(context, title);
                              } else {
                                _snackBar("Message!", "Please enter relation.");
                              }
                            },
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(top: 25),
                              decoration: const BoxDecoration(
                                color: main_color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(37)),
                              ),
                              child: const Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 4), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }


   _awaitReturnValueRecipient(BuildContext context) async {
    contactsList = [];
    contacts = [];
    images = [];

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateReminderRecipient(),
        ));

    setState(() {
      contactsList = result;
      if (contactsList.isNotEmpty) {
        contactsList.forEach((element) {
          contacts.add(element.id.toString());
          images.add(imageUrl + element.imagePath!);
          print(contacts);
        });
      }
    });
  }

  _snackBar(var title, var message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black12,
      colorText: Colors.white,
    );
  }

   saveRelation(BuildContext context, String title) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await relationBloc.saveRelationAPI(title);
    getRelationApi();

    if (relationBloc.addRelationModel.status == 200) {
      Navigator.of(context).pop();
      _snackBar("Interest", relationBloc.addRelationModel.message);
    }
  }

  void getRelationApi() async {
    await relationBloc.getRelationAPI();

    GetRelationModel model = relationBloc.getRelationModel;

    setState(() {
      relationList = model.relation!;
    });
  }

  void delRelation(BuildContext context, int id) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await relationBloc.delRelationAPI(id);
    getRelationApi();

    CommonModel model = relationBloc.delRelationModel;
    Navigator.of(context).pop();
    _snackBar("Message", model.message);
  }
}
