import 'package:card_club/resources/models/get_single_notification_model.dart';
import 'package:card_club/screens/inbox/bloc/notification_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class InboxDetail extends StatefulWidget {
  const InboxDetail({Key? key}) : super(key: key);

  @override
  _InboxDetailState createState() => _InboxDetailState();
}

class _InboxDetailState extends State<InboxDetail> {

  GetSingleNotificationModel _modelSingle=notificationBloc.singleNotificationModel;

  @override
  Widget build(BuildContext context) {

    int days=remainingDays(_modelSingle.notification!.createdAt);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 35, left: 20, right: 22),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                SizedBox(height: 40),
                Text(
                  '${_modelSingle.notification!.subject}',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.75),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: main_color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${_modelSingle.notification!.subject!.substring(0, 1)}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 17, right: 17),
                      child: Text(
                        'Seen - $days days ago',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black12,
                  height: 1,
                ),
                SizedBox(height: 20),
                Text(
                  "Sender/Name",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.75),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Florence Pugh",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Email/Phone",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.75),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Florence@gmail.com / (760) 700-7007",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "File",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.75),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  color: main_color,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 07.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "File name",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Image(
                        height: 20,
                        width: 20,
                        image: AssetImage(
                          'assets/icons/ic_download.png',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Details",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.75),
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('${_modelSingle.notification!.message}',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int remainingDays(String? dateTime) {
    final birthday = DateFormat("yyyy-MM-dd").parse(dateTime!);
    final date2 = DateTime.now();
    return date2.difference(birthday).inDays;
  }
}
