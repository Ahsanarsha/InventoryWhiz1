import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

import '../../../bottom_navigation.dart';



class SetCardDate extends StatefulWidget {
  const SetCardDate({Key? key}) : super(key: key);

  @override
  _SetCardDateState createState() => _SetCardDateState();
}

class _SetCardDateState extends State<SetCardDate> {

  String _date = "01/01/2000";
  String _time = "00:00:00";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Material(
          color: Colors.white,
          child:  Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: 50,
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            child: FlatButton(
                onPressed: () {
                  Get.offAll(BottomNavigation(),arguments: 1);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: main_color,
                child: const Text(
                  'Order Card',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          )
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height*0.05),
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
                SizedBox(height: size.height*0.06),
                const Text(
                  'Set Date & Time',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height*0.06),
                const Text(
                  'Date & Time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height:  size.height*0.02),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Expanded(
                      flex: 1,
                      child:Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.black12)),
                        child: SizedBox(
                          height:  size.height*0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        " $_date",
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        theme: const DatePickerTheme(
                                          containerHeight: 210.0,
                                        ),
                                        showTitleActions: true,
                                        minTime: DateTime(2022, 1, 1),
                                        maxTime: DateTime(2030, 12, 31),
                                        onConfirm: (date) {
                                          _date =
                                          '${date.day}/${date.month}/${date.year}';
                                          setState(() {});
                                        },
                                        currentTime: DateTime.now().add(Duration(days: 7)),
                                        locale: LocaleType.en);
                                  },
                                  icon: const Icon(
                                    Icons.date_range_outlined,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child:Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.black12)),
                        child: SizedBox(
                          height: size.height*0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        " $_time",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        width: size.width*0.01,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            DatePicker.showTimePicker(context,
                                                theme: DatePickerTheme(
                                                  containerHeight: MediaQuery.of(context).size.height * 0.30,
                                                ),
                                                showTitleActions: true,
                                                onConfirm: (time) {
                                                  _time =
                                                  '${time.hour} : ${time.minute} : ${time.second}';
                                                  setState(() {});
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.en);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.schedule_rounded,
                                            color: Colors.grey,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
