import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/resources/models/get_cart_items_model.dart';
import 'package:card_club/resources/models/get_shipping_address_model.dart';
import 'package:card_club/screens/cart_item/bloc/cart_bloc.dart';
import 'package:card_club/screens/cart_item/shipping/bloc/shipping_bloc.dart';
import 'package:card_club/screens/cart_item/shipping/select_shpping_address.dart';
import 'package:card_club/utils/static_data.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../../resources/urls.dart';
import '../address/add_new_contact/bloc/get_countries_bloc.dart';
import 'shipping/add_shipping_address.dart';
import 'check_out_item.dart';
import 'model/cart_model.dart';

class CartItems extends StatefulWidget {
  const CartItems({Key? key}) : super(key: key);

  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  late GetCartItemsModel model;

  List<String?> temp = [];

  @override
  void initState() {
    super.initState();
    model = cartBloc.getCartModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: 90.h,
            height: 07.h,
            margin: EdgeInsets.only(left: 30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: main_color,
                elevation: 0.0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
              onPressed: () async{
                if (temp.length != 0) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (dialogContext) {
                        return Center(
                            child: CircularProgressIndicator(
                              color: main_color,
                            ));
                      });

                  await shippingBloc.getShippingAddressRequest();
                  shippingBloc.getShippingAddressModel;

                  Navigator.of(context).pop();
                  Get.to(() => SelectShippingAddress());

                } else {
                  _snackBar(
                      "Cart", "First select item which you want to checkout!");
                }
              },
              child: Text(
                "Start checkout",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            )),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 45, left: 20, right: 22),
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
                padding: const EdgeInsets.only(bottom: 10, top: 20, left: 22),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Cart',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 05.h),
              model.cart!.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.cart!.length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return _myCartWidget(model.cart![index], index);
                          }))
                  : Container(
                      height: 50.h,
                      width: 50.h,
                      child: LottieBuilder.asset(
                        'assets/animation/empty_cart.json',
                        height: 50.h,
                        width: 50.h,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _myCartWidget(Cart card, int index) {
    var size = MediaQuery.of(context).size;

    String finalUrl='';

    try{
      String imagePath = card.gift!.imagePath!.toString();
      finalUrl = imageUrl + imagePath;
    }catch(error){
      finalUrl='https://i.postimg.cc/bwR19xGd/Group-58.png';
    }




    return Container(
      margin: EdgeInsets.only(bottom: index == model.cart!.length - 1 ? 50 : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "${card.gift!.title.toString()}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    offset: Offset(-20, 40),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset(
                                    'assets/icons/ic_delete.png',
                                    width: 20,
                                    height: 20,
                                  )),
                              SizedBox(width: 5),
                              Text(
                                "Delete",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          )),
                    ],
                    onSelected: (value) async {
                      if (value == 1) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (dialogContext) {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: main_color,
                              ));
                            });

                        await cartBloc.delCartRequest(card.id!);
                        await cartBloc.getCartRequest();

                        CommonModel commonModel = cartBloc.delCartModel;

                        if (commonModel.status == 200) {
                          setState(() {
                            model = cartBloc.getCartModel;
                          });
                          Navigator.of(context).pop();
                          _snackBar("Item", commonModel.message.toString());
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(finalUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            height: 150,
            width: size.width * 0.90,
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Text(
              "${card.gift!.imageName.toString()}",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "\$" + card.gift!.price.toString(),
                    style: const TextStyle(
                      color: price_color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (temp.contains(card.id.toString())) {
                          temp.remove(card.id.toString());
                          StaticData.cartList.removeWhere((data) => data.id == card.id);
                        } else {
                          temp.add(card.id.toString());

                          final data = CartModel(
                            id: card.id!,
                            name: card.gift!.title,
                            image: card.gift!.imagePath,
                            price: card.gift!.price,
                          );
                          StaticData.cartList.add(data);
                        }
                      });
                    },
                    child: temp.contains(card.id.toString())
                        ? Icon(
                            Icons.radio_button_checked,
                            color: main_color,
                          )
                        : Icon(
                            Icons.radio_button_off,
                            color: Colors.black26,
                          ),
                  ),
                ]),
          ),
          SizedBox(height: size.height * 0.04)
        ],
      ),
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
}
