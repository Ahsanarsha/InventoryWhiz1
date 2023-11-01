import 'package:card_club/resources/models/get_interest_model.dart';
import 'package:card_club/screens/setting_profile/bloc/interest_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class YourInterest extends StatefulWidget {
  const YourInterest({Key? key}) : super(key: key);

  @override
  _YourInterestState createState() => _YourInterestState();
}

class _YourInterestState extends State<YourInterest> {
  var _titleTEC = TextEditingController();

  List<Interest>? list = [];

  @override
  void initState() {
    super.initState();
    getInterestApi(context);
  }

  @override
  void dispose() {
    super.dispose();
    _titleTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 37, left: 22, right: 22),
        child: ListView(
          physics: BouncingScrollPhysics(),
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              margin: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'My interest(s)',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black12, width: 2),
                    ),
                    child: TextButton(
                      onPressed: () {
                        showAddInterestDialog();
                      },
                      child: const Text(
                        '+',
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'My Interests',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: list!.length != 0
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: list!.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Slidable(
                                key: ValueKey(index),
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) async {
                                        int? id = list![index].id;

                                        list!.removeAt(index);
                                        await interestBloc.delInterestAPI(id);
                                        getInterestApi(context);

                                        _snackBar("Interest", interestBloc.delInterestModel.message);
                                      },
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  margin: EdgeInsets.all(3),
                                  child: Padding(
                                    padding: EdgeInsets.all(7),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${list![index].title}",
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                        : Container(
                            child: Text("No interest found!"),
                          ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 50,
                  margin: const EdgeInsets.only(top: 12),
                  decoration: const BoxDecoration(
                    color: main_color,
                    borderRadius: BorderRadius.all(Radius.circular(37)),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Save changes",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAddInterestDialog() {

    _titleTEC.text='';

    showGeneralDialog(
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.1),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 35.h,
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
                      'Interest',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Add your interest.',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: Colors.black.withOpacity(0.30),
                      ),
                    ),
                    TextFormField(
                      controller: _titleTEC,
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
                        hintText: "Interest...",
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
                          child: GestureDetector(
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
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);

                              var title = _titleTEC.text.trim();

                              if (title.isNotEmpty) {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (dialogContext) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                        color: main_color,
                                      ));
                                    });

                                await interestBloc.saveInterestAPI(title);
                                getInterestApi(context);

                                if (interestBloc.addInterestModel.status ==
                                    200) {
                                  Navigator.of(context).pop();
                                  _snackBar("Interest",
                                      interestBloc.addInterestModel.message);
                                }
                              } else {
                                _snackBar(
                                    "Message", "Please enter your interest.");
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

  void _snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black12,
      colorText: Colors.white,
    );
  }

  void getInterestApi(BuildContext context) async {
    await interestBloc.getAllInterestAPI();

    GetInterestModel model = interestBloc.getInterestModel;

    setState(() {
      list = model.interest!;
    });
  }
}
