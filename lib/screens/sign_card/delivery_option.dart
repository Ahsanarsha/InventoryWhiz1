import 'package:card_club/screens/purchase_card/physical_card/set_card_date.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cart_item/shipping/bloc/shipping_bloc.dart';
import '../cart_item/shipping/select_shpping_address.dart';
import '../purchase_card/ecard/ecard_payment_method.dart';
import '../purchase_card/physical_card/shpping_address_card.dart';

class DeliveryOption extends StatefulWidget {
  const DeliveryOption({Key? key}) : super(key: key);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<DeliveryOption> {

  bool pressAttention1 = false;
  bool pressAttention2 = false;

  String selected = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
          color: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: 50,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: FlatButton(
                onPressed: () async{
                  if (selected == 'Digital') {
                    Get.to(()=>ECardPaymentMethod());
                  } else if (selected == 'Physical') {
                    _snackBar('Share', 'Physical Card.');

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

                    Get.to(() => ShippingAddressCard());
                  } else {
                    _snackBar('Please', 'The Delivery First.');
                  }

                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: main_color,
                child: const Text(
                  'Send',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          )),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 00),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 30),
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
                SizedBox(height: 50),
                Text(
                  'Choose your delivery method',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: Colors.black87,
                  ),
                ),
                const Text(
                  'How will we be delivering this card/gift to \nyour recipient?',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 60),

                GestureDetector(
                  onTap: () {
                    selected = 'Digital';

                    setState(() {
                      pressAttention1 = !pressAttention1;
                      if (pressAttention2 == true) {
                        pressAttention2 = false;
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: pressAttention1 ? main_color : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: Colors.black12, width: 1),
                    ),
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13, left: 20),
                      child: Text(
                        "Send a Digital Card",
                        textAlign: TextAlign.start,
                        style: pressAttention1
                            ? TextStyle(fontSize: 16, color: Colors.white)
                            : TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    selected = 'Physical';
                    setState(() {
                      pressAttention2 = !pressAttention2;
                      if (pressAttention1 == true) {
                        pressAttention1 = false;
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: pressAttention2 ? main_color : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: Colors.black12, width: 1),
                    ),
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13, left: 20),
                      child: Text(
                        "Send a physical card",
                        textAlign: TextAlign.start,
                        style: pressAttention2
                            ? TextStyle(fontSize: 16, color: Colors.white)
                            : TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 170),
              ],
            ),
          ),
        ),
      ),
    );
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
