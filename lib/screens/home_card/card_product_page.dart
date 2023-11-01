import 'package:card_club/card_editor/editor_home.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';

import '../../resources/models/all_cards_model.dart';
import '../../resources/models/gift_favorite_model.dart';
import '../../resources/urls.dart';
import '../../utils/static_data.dart';
import '../home_gift/bloc/gift_bloc.dart';
import '../home_gift/gift_product_page.dart';
import '../reminders/create_reminder_on_product.dart';

class CardProductPage extends StatefulWidget {
  CardProductPage({Key? key}) : super(key: key);

  @override
  _CardProductPageState createState() => _CardProductPageState();
}

class _CardProductPageState extends State<CardProductPage> {
  List<Cards> cardList = [];

  @override
  void initState() {
    super.initState();
    cardList = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    String image = imageUrl + cardList[0].imagePath!;
    int? price = cardList[0].price!;

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
                child: ImageCacheing(
                    fit: BoxFit.cover,
                    url: imageUrl + cardList[0].imagePath.toString(),
                    loadingWidget: Center(
                      child: CircularProgressIndicator(),
                    )),
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
                              "\$ ${cardList[0].price}",
                              style: TextStyle(
                                fontSize: 16,
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
                            int id = cardList[0].id!;
                            _addReminderOnProduct('card_id', id);
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
                              image: AssetImage(
                                'assets/icons/ic_calendar.png',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            int? id = cardList[0].id;
                            _addToWisList(context, id);
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
                              image: AssetImage(
                                'assets/icons/ic_heart.png',
                              ),
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
                        onPressed: () {

                          StaticData.card_url = image;
                          CardPurchase.cardPrice=price.toDouble();

                          Get.to(() => EditorHome());
                        },
                        child: Text(
                          "Select",
                          style: TextStyle(
                            fontSize: 16,
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

  _addReminderOnProduct(String type, int id) async {
    List<Product> list = [];
    list.add(Product(id: id, type: type));
    Get.to(() => CreateReminderOnProduct(), arguments: list);
  }

  _addToWisList(BuildContext context, int? giftID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await giftBloc.addToWishListAPI('card_id', giftID!);

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
