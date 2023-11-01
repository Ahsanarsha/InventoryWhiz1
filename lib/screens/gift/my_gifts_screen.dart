import 'package:card_club/resources/models/get_my_gift_model.dart';
import 'package:card_club/screens/gift/bloc/my_gift_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../resources/urls.dart';

class MyGiftsScreen extends StatefulWidget {
  const MyGiftsScreen({Key? key}) : super(key: key);

  @override
  _MyGiftsScreenState createState() => _MyGiftsScreenState();
}

class _MyGiftsScreenState extends State<MyGiftsScreen> {
  GetMyGiftModel _getMyGiftModel = myGiftsBloc.myGiftsModel;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 45, left: 22, right: 22),
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
              Container(
                padding: const EdgeInsets.only(bottom: 10, top: 20, left: 5),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'My Gifts',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              SizedBox(height: 04.h),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _getMyGiftModel.myGifts!.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return _myGiftWidget(_getMyGiftModel.myGifts![index]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myGiftWidget(MyGifts myGifts) {

    String imagePath = myGifts.imagePath!.toString();
    String finalUrl = imageUrl + imagePath;

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 15),
      height: 105,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(finalUrl),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            height: 105,
            width: 105,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 17,
                    right: 17,
                    top: 5,
                  ),
                  child: Text(
                    '${myGifts.title}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 17, right: 17),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '\$ ${myGifts.title}',
                          style: TextStyle(
                            color: price_color,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          'time ago ${myGifts.createdAt}',
                          style: const TextStyle(
                            color: Colors.black45,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
