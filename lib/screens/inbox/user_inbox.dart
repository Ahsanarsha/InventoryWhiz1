import 'package:card_club/resources/models/get_notification_model.dart';
import 'package:card_club/screens/inbox/bloc/notification_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'inbox_detail.dart';

class UserInbox extends StatefulWidget {
  const UserInbox({Key? key}) : super(key: key);

  @override
  _UserInboxState createState() => _UserInboxState();
}

class _UserInboxState extends State<UserInbox> {
  GetNotificationModel? _getNotificationModel;

  @override
  void initState() {
    super.initState();
    _getNotificationModel = notificationBloc.notificationModel;
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

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
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                    height: isPortrait ? 30.h : 22.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 0.75))
                      ],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(44),
                        bottomLeft: Radius.circular(44),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              top: isPortrait ? 45 : 10, left: 20, right: 22),
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
                          margin: EdgeInsets.only(
                              top: isPortrait ? 05.h : 02.h, bottom: 10),
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.all(Radius.circular(37)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: TextField(
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
              Container(
                padding: const EdgeInsets.only(top: 50, left: 30),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Inbox',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.90),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, top: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'New notifications (${_getNotificationModel!.unviewedCount})',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black87,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _getNotificationModel!.notification!.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return _myInboxWidget(
                          _getNotificationModel!.notification![index], index);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myInboxWidget(NotificationData notification, int index) {
    int days = remainingDays(notification.createdAt);

    print(days);

    return Column(
      children: [
        InkWell(
          onTap: () {
            int id = notification.id!;
            getSingleNotificationApi(context, id);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 22, right: 22, bottom: 0),
            height: 105,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: main_color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${notification.message!.substring(0, 1)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
                        child: notification.viewed == 0
                            ? Text(
                                '${notification.subject}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                ),
                              )
                            : Text(
                                '${notification.subject}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  color: Colors.black45,
                                ),
                              ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 17, right: 17),
                        child: Text(
                          'Seen - $days days ago',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.black12,
          height: 1,
        )
      ],
    );
  }

  int remainingDays(String? dateTime) {
    final birthday = DateFormat("yyyy-MM-dd").parse(dateTime!);
    final date2 = DateTime.now();
    return date2.difference(birthday).inDays;
  }

  getSingleNotificationApi(BuildContext context, int id) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await notificationBloc.getSingleNotificationAPI(id);
    await notificationBloc.getNotificationAPI();

    GetNotificationModel _model = notificationBloc.notificationModel;

    Navigator.of(context).pop();

    setState(() {
      _getNotificationModel = _model;
    });

    Get.to(() => InboxDetail());
  }
}
