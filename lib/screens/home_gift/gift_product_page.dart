import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/resources/models/gift_detail_model.dart';
import 'package:card_club/resources/urls.dart';
import 'package:card_club/screens/cart_item/bloc/cart_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/models/gift_favorite_model.dart';
import '../reminders/create_reminder_on_product.dart';
import 'bloc/gift_bloc.dart';

class GiftProductPage extends StatefulWidget {
  GiftProductPage({Key? key}) : super(key: key);

  @override
  _GiftProductPageState createState() => _GiftProductPageState();
}

class _GiftProductPageState extends State<GiftProductPage> {
  GiftDetailModel? model;

  @override
  void initState() {
    super.initState();
    model = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    String cardImage = model!.gift!.imagePath.toString();
    String finalUrl = imageUrl + cardImage;
    print(finalUrl);

    return Scaffold(
      backgroundColor: Color(0xFFE4E3E8),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 35, left: 20, right: 22),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
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
                  style: TextStyle(color: main_color),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Image.network(
                  finalUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              color: Color(0xFFE4E3E8),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF2D4D31),
                              elevation: 0.0,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.0),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "\$" + model!.gift!.price.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            int id = model!.gift!.id!;
                           _addReminderOnProduct('gift_id',id);
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            padding: EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Image(
                                image:
                                    AssetImage('assets/icons/ic_calendar.png')),
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            int giftID = model!.gift!.id!;
                            _addToWisList(giftID);
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            padding: EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Image(
                              image: AssetImage('assets/icons/ic_heart.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF2D4D31),
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                        ),
                        onPressed: () async {
                          _addCartItem();
                        },
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _addCartItem() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    int? id = model!.gift!.id;

    await cartBloc.addToCartRequest(id!, "gift");

    CommonModel commonModel = cartBloc.addToCartModel;

    if (commonModel.status == 200) {
      _snackBar("Message", commonModel.message);
      Navigator.pop(context);
    }
  }

  _addReminderOnProduct(String type,int id) async{
    List<Product> list=[];
    list.add(Product(id: id,type: type));
    Get.to(()=>CreateReminderOnProduct(),arguments: list);

  }

  _addToWisList(int? giftID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await giftBloc.addToWishListAPI('gift_id',giftID!);

    GiftFavoriteModel modelF = giftBloc.addToWishListModel;

    Navigator.of(context).pop();

    _snackBar('Favorite', modelF.message.toString());
  }

  _snackBar(var title, var message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black45,
      colorText: Colors.white,
    );
  }
}

class Product{
  
  int? id;
  String? type;

  Product({this.id, this.type});
}
