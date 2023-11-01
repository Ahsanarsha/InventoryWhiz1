import 'package:card_club/resources/models/user_update_detail_model.dart';
import 'package:card_club/screens/dob/bloc/user_update_detail_bloc.dart';
import 'package:card_club/screens/reminders/create_reminders.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UserBirthday extends StatefulWidget {
  const UserBirthday({Key? key}) : super(key: key);

  @override
  _UserBirthdayState createState() => _UserBirthdayState();
}

class _UserBirthdayState extends State<UserBirthday> {
  final DateRangePickerController _controller = DateRangePickerController();
  String _apiDate = DateFormat('yyyy/MM/dd').format(DateTime.now()).toString();
  String _showDate = DateFormat('MM/dd/yyyy').format(DateTime.now()).toString();

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {
        _apiDate = DateFormat('yyyy/MM/dd').format(args.value).toString();
        _showDate = DateFormat('MM/dd/yyyy').format(args.value).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    alignment: Alignment.topRight,
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
                        Get.off(CreateReminder());
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    )),
                const SizedBox(height: 10),
                Text(
                  'Birthday!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.75),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Help friends celebrate your birthday when \nit\'s time to celebrate... you!',
                    style: TextStyle(fontSize: 14, fontFamily: 'Montserrat'),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 15,top: 10,bottom: 10,right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _showDate,
                        style: const TextStyle(
                            fontSize: 16, fontFamily: 'Montserrat'),
                      ),
                      Image(
                        height: 20,
                        width: 20,
                        color: Colors.black,
                        image: AssetImage(
                          'assets/icons/ic_calendar.png',
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SfDateRangePicker(
                        controller: _controller,
                        initialSelectedDate: DateTime.now(),
                        todayHighlightColor: Colors.grey[400],
                        initialDisplayDate: DateTime.now(),
                        selectionColor: Color(0xFF2D4D31),
                        selectionShape: DateRangePickerSelectionShape.rectangle,
                        selectionTextStyle: TextStyle(color: Colors.white),
                        view: DateRangePickerView.month,
                        onSelectionChanged: selectionChanged,
                        monthViewSettings: DateRangePickerMonthViewSettings(
                          viewHeaderStyle: DateRangePickerViewHeaderStyle(
                            textStyle:
                                TextStyle(color: Colors.grey[400], fontSize: 13),
                          ),
                          firstDayOfWeek: 1,
                          dayFormat: 'EEE',
                        ),
                        showNavigationArrow: true,
                        headerStyle: DateRangePickerHeaderStyle(
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        monthCellStyle: const DateRangePickerMonthCellStyle(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      height: 50,
                      child: FlatButton(
                        onPressed: () async {
                          if (_apiDate.isEmpty) {
                            _snackBar("Required", "Date of Birth");
                          } else {
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
                                .sendUpdateDOBRequest(_apiDate);
                            Navigator.of(context).pop();

                            UserUpdateDetailModel model =
                                userUpdateDetailBloc.userUpdateDOBModel;
                            _snackBar("Date Of Birth!", model.message);

                            Get.off(CreateReminder());
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        color: main_color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _snackBar(var title, var message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.black45, colorText: Colors.white);
  }
}
