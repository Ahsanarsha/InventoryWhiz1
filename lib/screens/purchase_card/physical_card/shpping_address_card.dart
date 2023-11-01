import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/screens/cart_item/shipping/bloc/shipping_bloc.dart';
import 'package:card_club/screens/cart_item/shipping/bloc/shipping_model.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../resources/models/edit_shipping_address_model.dart';
import '../../../resources/models/get_shipping_address_model.dart';
import '../../address/add_new_contact/bloc/get_countries_bloc.dart';
import '../../../utils/static_data.dart';
import '../../cart_item/check_out_item.dart';
import '../../cart_item/shipping/add_shipping_address.dart';
import '../../sign_card/add_reciepent_to_sign.dart';
import 'check_out_item_card.dart';

class ShippingAddressCard extends StatefulWidget {
  const ShippingAddressCard({Key? key}) : super(key: key);

  @override
  _ShippingAddressCardState createState() => _ShippingAddressCardState();
}

class _ShippingAddressCardState extends State<ShippingAddressCard> {

  var _titleTEC = TextEditingController();

  GetShippingAddressModel _addressModel = shippingBloc.getShippingAddressModel;

  List<ShippingModel>? list = [];

  @override
  void initState() {
    super.initState();

    if (_addressModel.address!.isNotEmpty) {
      _addressModel.address!.forEach((element) {
        if (element.status == 1) {
          list!.add(ShippingModel(
            element.id,
            element.addressName,
            element.streetAddress1!,
            element.postalCode!,
          ));
        }
      });
    }
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
            SizedBox(height: 05.h),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Add Your Shipping Address',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 02.h),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black12, width: 2),
              ),
              child: TextButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: main_color,
                          ),
                        );
                      });

                  await getCountriesBloc.getCountriesRequest();

                  Navigator.of(context).pop();

                  Get.to(() => AddShippingAddress());
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
            SizedBox(height: 06.h),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Your Shipping Address',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showShippingAddressDialog();
                    },
                    child: Text(
                      'Change',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: main_color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black12, width: 2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        list!.isNotEmpty
                            ? Text('${list![0].addressName}')
                            : Text("Address Name"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        list!.isNotEmpty
                            ? Text('${list![0].streetAddress1}')
                            : Text("Street Address 1"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      children: [
                        list!.isNotEmpty
                            ? Text('${list![0].postalCode}')
                            : Text("Post Code"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  if (_addressModel.address!.isNotEmpty) {
                    int addressId = list![0].id!;

                    CardPurchase.addressID = addressId;

                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (dialogContext) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: main_color,
                          ));
                        });

                    await shippingBloc.getShippingRatesApi(addressId);

                    if (shippingBloc.getShippingRatesModel.statusCode == 200) {
                      Navigator.of(context).pop();
                      Get.to(() => CheckOutItemCard());
                    } else {
                      CommonModel shippingModel = shippingBloc.getShippingRatesModel;
                      Navigator.of(context).pop();
                      _snackBar("Message!", shippingModel.message.toString());
                    }
                  } else {
                    _snackBar("Shipping Address", "please add address.");
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 07.h,
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
                            "Next",
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

  showShippingAddressDialog() {
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.1),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 200,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _addressModel.address!.length != 0
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: _addressModel.address!.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                margin: EdgeInsets.all(3),
                                child: Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${_addressModel.address![index].addressName}",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          int id =
                                              _addressModel.address![index].id!;
                                          Navigator.pop(context);
                                          changeAddress(id);
                                        },
                                        child: _addressModel
                                                    .address![index].status ==
                                                1
                                            ? Icon(
                                                Icons.radio_button_checked,
                                                color: main_color,
                                              )
                                            : Icon(
                                                Icons.radio_button_off,
                                                color: main_color,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : Container(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text("No Shipping Address found!"),
                            ),
                          ),
                  ),
                ],
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

   _snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black12,
      colorText: Colors.white,
    );
  }

  changeAddress(int id) async {
    list = [];
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await shippingBloc.updateShippingAddressRequest(
      id,
      '',
      '',
      '',
      0,
      0,
      0,
      0,
      1,
    );

    EditShippingAddressModel addressModel =
        shippingBloc.updateShippingAddressModel;

    await shippingBloc.getShippingAddressRequest();

    Navigator.of(context).pop();

    setState(() {
      _addressModel = shippingBloc.getShippingAddressModel;
      int id = addressModel.address!.id!;
      String addressName = addressModel.address!.addressName!;
      String streetAddress1 = addressModel.address!.streetAddress1!;
      String postalCode = addressModel.address!.postalCode!;

      list!.add(ShippingModel(
        id,
        addressName,
        streetAddress1,
        postalCode,
      ));
    });

    print(list!.length);
  }
}
