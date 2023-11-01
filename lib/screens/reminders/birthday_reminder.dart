import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/resources/models/get_reminder_model.dart';
import 'package:card_club/screens/reminders/update_reminder.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:sizer/sizer.dart';

import '../../calender/flutter_neat_and_clean_calendar.dart';
import '../../resources/urls.dart';
import '../../utils/static_data.dart';
import 'bloc/get_all_reminder_bloc.dart';
import 'create_reminders.dart';

class Birthday extends StatefulWidget {
  const Birthday({Key? key}) : super(key: key);

  @override
  _BirthdayState createState() => _BirthdayState();
}

class _BirthdayState extends State<Birthday> {
  var _tempDate = DateTime.now();
  var isPastDate = false;

  List<Reminders> reminderList = [];

  bool? isSpecialDate = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    getAllReminder(context);
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: main_color,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              calender(),
              bottomDetailsSheet(),
            ],
          ),
        ),
      ),
    );
  }

  Widget calender() {
    return Container(
      height: 45.h,
      color: main_color,
      child: Padding(
        padding: EdgeInsets.fromLTRB(3, 20, 3, 0),
        child: Calendar(
          isExpandable: false,
          hideTodayIcon: true,
          isExpanded: true,
          hideArrows: true,
          onExpandStateChanged: (bool) {
            print(bool);
          },
          startOnMonday: true,
          initialDate: DateTime.now(),
          onDateSelected: selectionChanged,
          dayBuilder: cellBuilder,
          weekDays: const ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
          locale: 'en-US',
          datePickerType: DatePickerType.hidden,
          dayOfWeekStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
          displayMonthTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget bottomDetailsSheet() {
    var size = MediaQuery.of(context).size;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0),
            ),
          ),
          child: Stack(children: [
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: ListView(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reminderList.isNotEmpty
                            ? Obx(() => getReminderBloc.showFilters.value
                                ? getReminderBloc.getReminderOnDateModel.isEmpty
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 5.h),
                                        child: Text('no reminder exist'))
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: getReminderBloc
                                            .getReminderOnDateModel.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return _myCalenderWidget(
                                              getReminderBloc
                                                      .getReminderOnDateModel[
                                                  index],
                                              index);
                                        },
                                      )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: reminderList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _myCalenderWidget(
                                          reminderList[index], index);
                                    },
                                  ))
                            : Container(
                                child: Center(
                                  child: Text('There is not reminder'),
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 165, right: 165, bottom: 20, top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: const Divider(
                  height: 5,
                  color: Colors.black12,
                  thickness: 6,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Reminder(s)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: size.width * 0.42),
                  SizedBox(
                    width: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CreateReminder());
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        color: const Color(0xFFf2cfd4),
                        borderRadius: new BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }

  Widget _myCalenderWidget(Reminders reminders, int index) {
    var size = MediaQuery.of(context).size;
    int days = remainingDays(reminders.dateTime).abs();

    List<Contacts>? citiesList = reminders.contacts;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                width: size.width * 0.25,
                height: size.height * 0.25,
                child: Text(
                  date(reminders.dateTime.toString()),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color(0xFF2D4D31),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: Text(
                              "${reminders.title}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.black45,
                                          size: 20,
                                        ),
                                      ),
                                      Text("Edit")
                                    ],
                                  )),
                              PopupMenuItem(
                                  value: 2,
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.black45,
                                          size: 20,
                                        ),
                                      ),
                                      Text("Delete")
                                    ],
                                  )),
                            ],
                            onSelected: (value) async {
                              if (value == 1) {
                                updateReminder(context, reminders.id, index);
                              } else {
                                deleteReminder(context, reminders.id);
                              }
                            },
                          ),
                        ],
                      ),
                      if (days == 0)
                        Text(
                          "$days Days Remaining",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        )
                      else
                        isPastDate
                            ? Text(
                                "$days Days Remaining",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              )
                            : Text(
                                "$days Event Gone",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                      SizedBox(height: size.height * 0.06),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(left: 3),
                        child: Text(
                          "Add more recipients:",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.48,
                        height: 40,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            //    side:  const BorderSide(color: Colors.grey)
                          ),
                          color: Colors.white,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Contacts>(
                              hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "${citiesList!.length} Members",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              isExpanded: true,
                              onChanged: (Contacts? newValue) async {
                                FocusScope.of(context).unfocus();

                                setState(() {
                                  // cityName = newValue!.name;
                                  // cityID = newValue.id;
                                });
                              },
                              items: citiesList.map<DropdownMenuItem<Contacts>>(
                                  (Contacts value) {
                                return DropdownMenuItem<Contacts>(
                                  value: value,
                                  child: Padding(
                                    padding: EdgeInsets.all(02),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          child: value.imagePath != null
                                              ? ImageCacheing(
                                                  height: 40,
                                                  width: 40,
                                                  fit: BoxFit.cover,
                                                  url: imageUrl +
                                                      value.imagePath
                                                          .toString(),
                                                  loadingWidget: Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ))
                                              : Image.asset(
                                                  'assets/images/user2.png'),
                                        ),
                                        SizedBox(width: 02.h),
                                        Flexible(
                                          child: Text(
                                            "${value.name}",
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.black87,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: size.height * 0.045),
        DottedLine(dashColor: Colors.grey),
        SizedBox(height: size.height * 0.045),
      ],
    );
  }

  getAllReminder(BuildContext context) async {
    await getReminderBloc.getReminderRequest();

    GetReminderModel model = getReminderBloc.getReminderModel;

    setState(() {
      reminderList = model.reminders!;
    });
  }

  selectionChanged(dynamic date) async {
    _tempDate = date;
    getReminderBloc.filterDate(date);
  }

  bool isSpecialDay(DateTime date) {
    bool result = false;
    reminderList.forEach((element) {
      DateTime dateTime = DateTime.parse(element.dateTime!.substring(0, 10));
      if (date == dateTime) {
        //print("in if else =" + dateTime.toString());
        result = true;
      }
    });
    return result;
  }

  bool isSameDate(DateTime date, DateTime dateTime) {
    if (date.year == dateTime.year &&
        date.month == dateTime.month &&
        date.day == dateTime.day) {
      return true;
    }
    return false;
  }

  bool isBlackedDate(DateTime date) {
    if (date.day == 17 || date.day == 18) {
      return true;
    }
    return false;
  }

  BoxDecoration? _boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(7)),
    border: Border.all(
      color: Colors.white,
      width: 2,
    ),
  );

  BoxDecoration? __boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    border: Border.all(
      color: Colors.white,
      width: 2,
    ),
  );

  Widget cellBuilder(BuildContext context, dynamic dateTime) {
    final bool isToday = isSameDate(dateTime, DateTime.now());
    final bool isSpecialDate = isSpecialDay(dateTime);
    print(isSpecialDate);

    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      decoration: isToday
          ? _boxDecoration
          : dateTime == _tempDate
              ? __boxDecoration
              : null,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            dateTime.day.toString(),
            style: TextStyle(
              color: isToday ? main_color : Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          isSpecialDate
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isToday
                        ? Container()
                        : Icon(
                            Icons.event_available,
                            size: 10,
                            color: Colors.white,
                          )
                  ],
                )
              : Container()
        ],
      ),
    );
  }

  int remainingDays(String? dateTime) {
    final birthday = DateFormat("yyyy-MM-dd").parse(dateTime!);
    final date2 = DateTime.now();
    isPastDate = date2.difference(birthday).isNegative;
    return date2.difference(birthday).inDays;
  }

  String date(String? dateTime) {
    final date = DateFormat("yyyy-MM-dd").parse(dateTime!);
    return date.toString().substring(0, 10);
  }

  deleteReminder(BuildContext context, int? id) async {
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

    await getReminderBloc.delReminderRequest(id!);
    getAllReminder(context);
    getReminderBloc.filterDate(_tempDate);

    Get.back();

    CommonModel model = getReminderBloc.delReminderModel;

    Get.snackbar("Message", model.message.toString());
  }

  updateReminder(BuildContext context, int? id, int index) async {
    StaticData.reminderIndex = index;
    Get.to(() => UpdateReminder(), arguments: index);
  }
}
