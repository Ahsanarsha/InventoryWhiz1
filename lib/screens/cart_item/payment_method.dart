import 'dart:convert';

import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/screens/cart_item/payment_gateway/env.dart';
import 'package:card_club/screens/cart_item/payment_gateway/get_transaction_model.dart';
import 'package:card_club/screens/cart_item/payment_gateway/place_order_bloc.dart';
import 'package:card_club/utils/static_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pay/pay.dart' as pay;

import '../../bottom_navigation.dart';
import '../../utils/app_colors.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool pressAttention = false;
  bool pressAttention1 = false;
  bool pressAttention2 = false;
  bool pressAttention3 = false;

  final kApiUrl = defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:4242'
      : 'http://localhost:4242';

  Map<String, dynamic>? paymentIntentData;

  @override
  void initState() {
    super.initState();

    print('-----------------------');
    print(StaticData.addressID);
    print(StaticData.shippingName);
    print(StaticData.shippingFee);
    print(StaticData.subTotalFinal);
    print(StaticData.grandTotalFinal);
    print(StaticData.cartList);
    print('-----------------------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 00),
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
              SizedBox(height: 50),
              Text(
                'Payment method',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  color: Colors.black87,
                ),
              ),
              Text(
                'Select a payment method.',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 60),
              InkWell(
                onTap: () async {
                  setState(() {
                    pressAttention = !pressAttention;
                    if (pressAttention2 == true) {
                      pressAttention2 = false;
                    }
                    if (pressAttention1 == true) {
                      pressAttention1 = false;
                    }
                    if (pressAttention3 == true) {
                      pressAttention3 = false;
                    }
                  });

                  await makePayment(
                      StaticData.grandTotalFinal, context); //1122.35
                  //await payViaNewCard(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: pressAttention ? main_color : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13, left: 20),
                    child: Text(
                      "Credit/Debit card",
                      textAlign: TextAlign.start,
                      style: pressAttention
                          ? TextStyle(fontSize: 16, color: Colors.white)
                          : TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ),
              ),
              pay.ApplePayButton(
                paymentConfigurationAsset: 'apple_pay_payment_profile.json',
                paymentItems: _paymentItems,
                margin: const EdgeInsets.only(top: 15),
                onPaymentResult: onApplePayResult,
                loadingIndicator: Center(
                  child: CircularProgressIndicator(),
                ),
                childOnError: Text('Apple Pay is not available in this device'),
                onError: (e) {
                  print(e.toString());
                  _snackBar('Problem',
                      'There was an error while trying to perform the payment');
                },
              ),
              const SizedBox(height: 15),
              pay.GooglePayButton(
                paymentConfigurationAsset: 'google_pay_payment_profile.json',
                paymentItems: _paymentItems,
                margin: const EdgeInsets.only(top: 15),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                onPressed: () async {
                  // 1. Add your stripe publishable key to assets/google_pay_payment_profile.json
                  await debugChangedStripePublishableKey();
                },
                childOnError:
                    Text('Google Pay is not available in this device'),
                onError: (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'There was an error while trying to perform the payment'),
                    ),
                  );
                },
              ),
              // const SizedBox(height: 15),
              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       pressAttention1 = !pressAttention1;
              //       if (pressAttention3 == true) {
              //         pressAttention3 = false;
              //       }
              //       if (pressAttention2 == true) {
              //         pressAttention2 = false;
              //       }
              //       if (pressAttention == true) {
              //         pressAttention = false;
              //       }
              //     });
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: pressAttention1 ? main_color : Colors.white,
              //       borderRadius: BorderRadius.all(Radius.circular(30)),
              //       border: Border.all(color: Colors.black12, width: 1),
              //     ),
              //     width: MediaQuery.of(context).size.width * 0.90,
              //     height: 45,
              //     child: Padding(
              //       padding: const EdgeInsets.only(top: 13, left: 20),
              //       child: Text(
              //         "Paypal standard",
              //         textAlign: TextAlign.start,
              //         style: pressAttention1
              //             ? TextStyle(fontSize: 16, color: Colors.white)
              //             : TextStyle(fontSize: 16, color: Colors.black54),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 15),
              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       pressAttention2 = !pressAttention2;
              //       if (pressAttention == true) {
              //         pressAttention = false;
              //       }
              //       if (pressAttention1 == true) {
              //         pressAttention1 = false;
              //       }
              //       if (pressAttention3 == true) {
              //         pressAttention3 = false;
              //       }
              //     });
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: pressAttention2 ? main_color : Colors.white,
              //       borderRadius: BorderRadius.all(Radius.circular(30)),
              //       border: Border.all(color: Colors.black12, width: 1),
              //     ),
              //     width: MediaQuery.of(context).size.width * 0.90,
              //     height: 45,
              //     child: Padding(
              //       padding: const EdgeInsets.only(top: 13, left: 20),
              //       child: Text(
              //         "Apple Pay",
              //         textAlign: TextAlign.start,
              //         style: pressAttention2
              //             ? TextStyle(fontSize: 16, color: Colors.white)
              //             : TextStyle(fontSize: 16, color: Colors.black54),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 15),
              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       pressAttention3 = !pressAttention3;
              //       if (pressAttention == true) {
              //         pressAttention = false;
              //       }
              //       if (pressAttention1 == true) {
              //         pressAttention1 = false;
              //       }
              //       if (pressAttention2 == true) {
              //         pressAttention2 = false;
              //       }
              //     });
              //
              //     // nativePaymentMethod(context);
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: pressAttention3 ? main_color : Colors.white,
              //       borderRadius: BorderRadius.all(Radius.circular(30)),
              //       border: Border.all(color: Colors.black12, width: 1),
              //     ),
              //     width: MediaQuery.of(context).size.width * 0.90,
              //     height: 45,
              //     child: Padding(
              //       padding: const EdgeInsets.only(top: 13, left: 20),
              //       child: Text(
              //         "Google Pay",
              //         textAlign: TextAlign.start,
              //         style: pressAttention3
              //             ? TextStyle(fontSize: 16, color: Colors.white)
              //             : TextStyle(fontSize: 16, color: Colors.black54),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 170),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 50,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: FlatButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: main_color,
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment(
      double? grandTotalFinal, BuildContext context) async {
    try {
      paymentIntentData = await createPaymentIntent(grandTotalFinal.toString(),
          'USD'); //1120.3 json.decode(response.body);
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});
      //todo::Display payment sheet
      displayPaymentSheet(context);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        //todo::get  data from map
        dataWithMap(paymentIntentData);

        _snackBar("Payment", "Paid Successfully");
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('Display Payment Sheet = $e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    String total = calculateAmount(amount);

    try {
      Map<String, dynamic> body = {
        'amount': total,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer $stripeSecretKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    var arr = amount.split('.');
    final value = arr[0] + arr[1];
    return '2000';
  }

  dataWithMap(Map<String, dynamic>? paymentIntentData) {
    String paymentID = paymentIntentData!['id'].toString();

    print('payment ID = ' + paymentID);
    print('payment Client Secret = ' +
        paymentIntentData['client_secret'].toString());
    print('payment amount = ' + paymentIntentData['amount'].toString());

    print('payment All Response' + paymentIntentData.toString());

    getTransactionDetailApi(context, paymentID);
  }

  void getTransactionDetailApi(
      BuildContext context, String transactionID) async {
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

    await placeOrderBloc.getTransactionDetailAPI(transactionID);
    GetTransactionModel paymentModel = placeOrderBloc.getTransactionModel;

    print(paymentModel.charges!.data![0].paymentMethodDetails!.card!.last4);

    orderPlaceApi(context, paymentModel);
  }

  orderPlaceApi(BuildContext context, GetTransactionModel model) async {
    List<String> cartIds = [];

    StaticData.cartList.forEach((element) {
      cartIds.add(element.id!.toString());
    });

    String transactionID = model.id!;
    String last4 = model.charges!.data![0].paymentMethodDetails!.card!.last4!;
    String brand = model.charges!.data![0].paymentMethodDetails!.card!.brand!;
    String paymentID = model.paymentMethod!;
    String receiptUrl = model.charges!.data![0].receiptUrl!;
    String balanceTransaction = model.charges!.data![0].balanceTransaction!;

    await placeOrderBloc.placeOrderApi(
      StaticData.addressID!,
      StaticData.subTotalFinal!,
      StaticData.shippingFee!,
      StaticData.grandTotalFinal!,
      StaticData.shippingName!,
      last4,
      brand,
      transactionID,
      paymentID,
      cartIds,
       0,
    );

    Navigator.of(context).pop();

    CommonModel _commonModel = placeOrderBloc.placeOrderModel;
    _snackBar("Message", _commonModel.message.toString());
    clearStaticData();

    Get.offAll(() => BottomNavigation(), arguments: 0);
  }

  clearStaticData() {
    StaticData.addressID = null;
    StaticData.shippingName = null;
    StaticData.shippingFee = null;
    StaticData.subTotalFinal = null;
    StaticData.grandTotalFinal = null;
    StaticData.cartList = [];
  }

  _snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black12,
      colorText: Colors.white,
    );
  }

  Future<void> onApplePayResult(paymentResult) async {
    try {
      //debugPrint(paymentResult.toString());
      // 1. Get Stripe token from payment result
      final token = await Stripe.instance.createApplePayToken(paymentResult);
      print(token.id);
      // 2. fetch Intent Client Secret from backend
      final response = await fetchPaymentIntentClientSecret();
      final clientSecret = response['clientSecret'];

      final params = PaymentMethodParams.cardFromToken(token: token.id);

      // 3. Confirm Apple pay payment method
      await Stripe.instance.confirmPayment(clientSecret, params);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Apple Pay payment successfully completed')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<Map<String, dynamic>> fetchPaymentIntentClientSecret() async {
    final url = Uri.parse('$kApiUrl/create-payment-intent');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': 'example@gmail.com',
        'currency': 'usd',
        'items': [
          {'id': 'id'}
        ],
        'request_three_d_secure': 'any',
      }),
    );
    return json.decode(response.body);
  }

  Future<void> onGooglePayResult(paymentResult) async {
    try {
      // 1. Add your stripe publishable key to assets/google_pay_payment_profile.json

      debugPrint(paymentResult.toString());
      // 2. fetch Intent Client Secret from backend
      final response = await fetchPaymentIntentClientSecret();
      final clientSecret = response['clientSecret'];
      final token = paymentResult['paymentMethodData']['tokenizationData']['token'];
      final tokenJson = Map.castFrom(json.decode(token));
      print(tokenJson);

      final params = PaymentMethodParams.cardFromToken(
        token: tokenJson['id'], // TODO extract the actual token
      );

      // 3. Confirm Google pay payment method
      await Stripe.instance.confirmPayment(
        clientSecret,
        params,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Google Pay payment successfully completed')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> debugChangedStripePublishableKey() async {
    if (kDebugMode) {
      final profile =
          await rootBundle.loadString('assets/google_pay_payment_profile.json');
      final isValidKey = !profile.contains('<pk_test_qblFNYngBkEdjEZ16jxxoWSM>');
      assert(
        isValidKey,
        'No stripe publishable key added to assets/google_pay_payment_profile.json',
      );
    }
  }
}

const _paymentItems = [
  pay.PaymentItem(
    label: 'Total',
    amount: '0.01',
    status: pay.PaymentItemStatus.final_price,
  )
];
