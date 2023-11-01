import 'package:card_club/screens/sign_card/delivery_option.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'member_model.dart';

class SelectMember extends StatefulWidget {
  const SelectMember({Key? key}) : super(key: key);

  @override
  _SelectMemberState createState() => _SelectMemberState();
}

class _SelectMemberState extends State<SelectMember> {
  late int selectedRadio;

  static List<String> contactImage = [
    'https://picsum.photos/200/300?random=1',
    'https://source.unsplash.com/user/c_v_r',
    'https://source.unsplash.com/user/c_v_r',
    'https://source.unsplash.com/user/c_v_r',
    'https://source.unsplash.com/user/c_v_r',
    'https://source.unsplash.com/user/c_v_r',
    'https://source.unsplash.com/user/c_v_r',
    'https://source.unsplash.com/user/c_v_r',
    'https://source.unsplash.com/user/c_v_r',
    'https://source.unsplash.com/user/c_v_r'
  ];

  static List<String> contactName = [
    'Anu',
    'Bill',
    'William',
    'Jane',
    'Anu',
    'Bill',
    'Jane',
    'William',
    'Anu',
    'William'
  ];

  List<MemberData> memberData = [];

  @override
  void initState() {
    super.initState();

    selectedRadio = 0;
    initMyList();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void initMyList() {
    memberData = List.generate(contactName.length,
        (index) => MemberData(contactImage[index], contactName[index]));
  }

  @override
  Widget build(BuildContext context) {
    initMyList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 5.0)],
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
                            margin: const EdgeInsets.only(
                                top: 35, left: 22, right: 22),
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
                              margin: const EdgeInsets.only(
                                  top: 35, left: 22, right: 22),
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
                                  showConfirmDialog();
                                },
                                child: Text(
                                  "Next",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "FAMILY",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.all(Radius.circular(37)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.search),
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
                height: MediaQuery.of(context).size.height * 0.14,
                padding: EdgeInsets.only(top: 30, left: 22, right: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Select members',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Text(
                      'Select group members to be included.',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: contactName.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return _myContactsWidget(memberData[index]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myContactsWidget(MemberData data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 22, right: 22, bottom: 10),
      height: 105,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(data.image), fit: BoxFit.fill),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            height: 72,
            width: 72,
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
                    data.name,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Radio(
            value: 1,
            groupValue: selectedRadio,
            activeColor: main_color,
            onChanged: (val) {
              print("Radio $val");
              setSelectedRadio(val as int);
            },
          ),
        ],
      ),
    );
  }

  showConfirmDialog() {
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.30,
            margin: const EdgeInsets.only(
                bottom: 50, left: 20, right: 20, top: 100),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Confirm?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),

                      Text(
                        "Are you sure you want to add_cont these members?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
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
                                margin:
                                    const EdgeInsets.only(top: 32, bottom: 10),
                                decoration: BoxDecoration(
                                  color: main_color_light,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(37)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "No",
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
                              onTap: () {
                                Get.to(DeliveryOption());
                              },
                              child: Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.only(top: 32, bottom: 10),
                                decoration: const BoxDecoration(
                                  color: main_color,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(37)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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
}
