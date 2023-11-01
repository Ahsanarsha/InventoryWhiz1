import 'package:card_club/screens/address/all_contacts/all_contacts.dart';
import 'package:card_club/screens/home_card/Cards.dart';
import 'package:card_club/screens/home_gift/Gifts.dart';
import 'package:card_club/screens/profile/user_profile.dart';
import 'package:card_club/screens/reminders/birthday_reminder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> _bottomNavigationPages = [
    Birthday(),
    EditCard(),
    Gifts(),
    UserProfile(),
    AllContacts(),
  ];

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex=Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _bottomNavigationPages[_currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white, spreadRadius: 0, blurRadius: 1),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: GNav(
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    gap: 8,
                    activeColor: Colors.black45,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    duration: Duration(milliseconds: 400),
                    tabBackgroundColor: Colors.grey[100]!,
                    color: Colors.black54,
                    tabs: [
                      GButton(
                        icon: Icons.calendar_today_outlined,
                        iconColor: Colors.black45,
                        text: 'Calendar',
                        textStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      GButton(
                        icon: Icons.card_giftcard_outlined,
                        iconColor: Colors.black45,
                        text: 'Cards',
                        textStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      GButton(
                        icon: Icons.shopping_bag_outlined,
                        iconColor: Colors.black45,
                        text: 'Gifts',
                        textStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      GButton(
                        icon: Icons.person_outline,
                        iconColor: Colors.black45,
                        text: 'Profile',
                        textStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      GButton(
                        icon: Icons.contacts_outlined,
                        iconColor: Colors.black45,
                        text: 'Address',
                        textStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                    selectedIndex: _currentIndex,
                    onTabChange: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Future<bool> _onBackPressed() {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Confirm'),
  //         content: Text('Do you want to exit the App'),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text('No'),
  //             onPressed: () {
  //               Navigator.of(context).pop(false); //Will not exit the App
  //             },
  //           ),
  //           FlatButton(
  //             child: Text('Yes'),
  //             onPressed: () {
  //               Navigator.of(context).pop(true); //Will exit the App
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   ) ?? false;
  // }

   showShippingAddressDialog() {
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
              borderRadius: BorderRadius.circular(10),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Text('data'),

                  Row(
                    children: [

                      Text('Cancel'),

                      Text('Close'),

                    ],
                  )

                ],
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

}
