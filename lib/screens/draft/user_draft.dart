import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'draft_model.dart';

class UserDraft extends StatefulWidget {
  const UserDraft({Key? key}) : super(key: key);

  @override
  _UserDraftState createState() => _UserDraftState();
}

class _UserDraftState extends State<UserDraft> {
  static List<String> draftName = [
    'eGift Cards',
    'eGift Cards',
    'eGift Cards',
    'eGift Cards',
    'eGift Cards',
    'eGift Cards',
    'eGift Cards',
    'eGift Cards',
    'eGift Cards',
    'eGift Cards'
  ];
  static List<String> draftImages = [
    'https://i.postimg.cc/66YBv8jh/Group-59.png',
    'https://i.postimg.cc/7L3ns8jq/Group-60.png',
    'https://i.postimg.cc/66YBv8jh/Group-59.png',
    'https://i.postimg.cc/7L3ns8jq/Group-60.png',
    'https://i.postimg.cc/66YBv8jh/Group-59.png',
    'https://i.postimg.cc/7L3ns8jq/Group-60.png',
    'https://i.postimg.cc/66YBv8jh/Group-59.png',
    'https://i.postimg.cc/7L3ns8jq/Group-60.png',
    'https://i.postimg.cc/66YBv8jh/Group-59.png',
    'https://i.postimg.cc/7L3ns8jq/Group-60.png'
  ];
  static List<String> draftPrice = [
    '11.9',
    '14.6',
    '12.9',
    '15.3',
    '16.8',
    '13.9',
    '17.0',
    '18.3',
    '19.1',
    '12.3',
  ];

  static List<String> draftEdit = [
    'Edit',
    'Edit',
    'Edit',
    'Edit',
    'Edit',
    'Edit',
    'Edit',
    'Edit',
    'Edit',
    'Edit'
  ];

  List<DraftModel> draftData = [];

  @override
  void initState() {
    super.initState();

    initMyList();
  }

  void initMyList() {
    draftData = List.generate(
        draftName.length,
        (index) => DraftModel(draftName[index], draftImages[index],
            draftPrice[index], draftEdit[index]));
  }

  @override
  Widget build(BuildContext context) {
    initMyList();

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    print(isPortrait);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 35, left: 22, right: 22),
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

              SizedBox(height: 30),

              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Drafts',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.75),
                  ),
                ),
              ),

              SizedBox(height: 30),

              Expanded(
                child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 40,
                      crossAxisSpacing: 40,
                      childAspectRatio: isPortrait? 0.62:1,
                    ),
                    itemCount: draftData.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return _myDraftWidget(draftData[index]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myDraftWidget(DraftModel data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[


          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data.imageUrl),
                fit: BoxFit.fill,
              ),
              borderRadius:BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            height: 150,
            width:MediaQuery.of(context).size.width,
          ),

          SizedBox(height:10),
          Text(data.name,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
          ),
          ),

          SizedBox(height:20),

          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$" + data.price,
                  style: TextStyle(
                    color: price_color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  data.edit,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ])
        ],
      ),
    );
  }
}
