import 'package:card_club/resources/models/get_shipping_rates_model.dart';
import 'package:card_club/screens/cart_item/payment_method.dart';
import 'package:card_club/screens/cart_item/shipping/bloc/shipping_bloc.dart';
import 'package:card_club/utils/static_data.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../resources/urls.dart';
import 'model/cart_model.dart';

class CheckOutItem extends StatefulWidget {
  const CheckOutItem({Key? key}) : super(key: key);

  @override
  _CheckOutItemState createState() => _CheckOutItemState();
}

class _CheckOutItemState extends State<CheckOutItem> {
  List<String> temp = [];

  GetShippingRatesModel _getRatesModel = shippingBloc.getShippingRatesModel;

  double subTotal = 0;
  double grandTotal=0;
  String imagePath = "";

  @override
  void initState() {
    super.initState();

    imagePath = StaticData.cartList[0].image!;
    setState(() {
      StaticData.cartList.forEach((element) {
        subTotal += element.price!;
      });

      grandTotal=subTotal.toDouble();

    });


  }

  Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 05.h),
              Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "eGift Cards",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
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
                          image: imagePath.isNotEmpty
                              ? NetworkImage(imageUrl + imagePath)
                              : NetworkImage(
                                  "https://i.postimg.cc/bwR19xGd/Group-58.png"),
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
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "eGift Cards",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: StaticData.cartList.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return _itemsGifts(StaticData.cartList[index]);
                      },
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(bottom: 10, top: 20, left: 22),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Shipping (for physical cards only):',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _getRatesModel.shippingRates!.rates!.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return _shippingRates(
                            _getRatesModel.shippingRates!.rates![index]);
                      },
                    ),
                    SizedBox(height: size.height * 0.04),
                    Container(
                      padding:
                          const EdgeInsets.only(bottom: 10, top: 20, left: 22),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Total:',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Your Total",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Text(
                            '\$ $grandTotal',
                            style: const TextStyle(
                              color: price_color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: 90.h,
                    height: 07.h,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: main_color,
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      onPressed: () {
                        if(temp.length!=0){
                          StaticData.subTotalFinal=subTotal.toInt();
                          StaticData.grandTotalFinal=grandTotal;
                          Get.to(() => PaymentMethod());
                        }else{
                          _snackBar("Shipping Method", "Please select first.");
                        }

                      },
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemsGifts(CartModel cart) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Text(
              "${cart.name}",
              maxLines: 2,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.60,
          ),
          Text(
            '\$ ${cart.price}',
            style: const TextStyle(
              color: price_color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _shippingRates(Rates rates) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Text(
              '${rates.service}',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Text(
                '\$ ${rates.rate}',
                style: const TextStyle(
                  color: price_color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),

              InkWell(
                onTap: () {
                  temp=[];
                  grandTotal=0.0;
                  _snackBar("Price", '${rates.rate!.toDouble()}');
                  print(subTotal);

                  setState(() {
                    if (temp.contains(rates.service.toString())) {
                      temp.remove(rates.service.toString());
                    } else {
                      temp.add(rates.service.toString());
                      StaticData.shippingName=rates.service.toString();
                    }
                    print(rates.service.toString());
                    grandTotal=subTotal+rates.rate!.toDouble();
                  });

                  StaticData.shippingFee=rates.rate;

                  print(temp);
                },
                child: temp.contains(rates.service.toString())
                    ? Icon(
                  Icons.radio_button_checked,
                  color: main_color,
                )
                    : Icon(
                  Icons.radio_button_off,
                  color: Colors.black26,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }


   _snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black12,
      colorText: Colors.white,
    );
  }

}
