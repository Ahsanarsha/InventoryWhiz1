import 'package:card_club/resources/models/all_wishlist_model.dart';
import 'package:card_club/resources/urls.dart';
import 'package:card_club/screens/wishlist/bloc/wishlist_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../resources/models/gift_favorite_model.dart';
import '../home_gift/bloc/gift_bloc.dart';

class UserWishList extends StatefulWidget {
  const UserWishList({Key? key}) : super(key: key);

  @override
  _UserWishListState createState() => _UserWishListState();
}

class _UserWishListState extends State<UserWishList> {
  AllWishListModel model = wishlistBloc.wishlistModel;

  List<Wishlist> wishlist = [];

  @override
  void initState() {
    super.initState();
    wishlist = model.wishlist!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 35, left: 22, right: 22),
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
                  'WishList',
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: wishlist.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return _myGiftWidget(wishlist[index]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myGiftWidget(Wishlist wishlist) {
    String finalUrl;

    try {
      String cardImage = wishlist.giftId.isNull
          ? wishlist.card!.imagePath.toString()
          : wishlist.gift!.imagePath.toString();
      finalUrl = imageUrl + cardImage;
    } catch (error) {
      print(error);
      finalUrl = "https://i.postimg.cc/7L3ns8jq/Group-60.png";
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 10),
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
              borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                    top: 7,
                  ),
                  child: wishlist.giftId.isNull
                      ? Text(
                    wishlist.card!.title.toString(),
                  )
                      : Text(
                    wishlist.gift!.title.toString(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 17, right: 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        wishlist.giftId.isNull?
                        Text(
                          "\$" + wishlist.card!.price.toString(),
                          style: TextStyle(
                              color: price_color,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ):Text(
                          "\$" + wishlist.gift!.price.toString(),
                          style: TextStyle(
                              color: price_color,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),

                        InkWell(
                          onTap: () {
                            _removeFromWisList(wishlist.id, context);
                          },
                          child: Icon(
                            Icons.favorite_outlined,
                            color: Colors.red,
                          ),
                        ),

                        // Text(
                        //   gd.timeAgo,
                        // ),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _removeFromWisList(int? giftID, BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await giftBloc.removeFromWishListAPI(giftID);
    await wishlistBloc.wishlistRequest();

    Navigator.of(context).pop();

    GiftFavoriteModel modelF = giftBloc.removeFromWihListModel;
    AllWishListModel wishListModel = wishlistBloc.wishlistModel;

    setState(() {
      wishlist = wishListModel.wishlist!;
    });

    Get.snackbar("WishList", modelF.message.toString());
  }
}
