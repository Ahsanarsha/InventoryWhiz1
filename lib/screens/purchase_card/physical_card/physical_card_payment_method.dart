import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:card_club/resources/models/pdf_model.dart';
import 'package:card_club/screens/cart_item/payment_gateway/env.dart';
import 'package:card_club/screens/cart_item/payment_gateway/get_transaction_model.dart';
import 'package:card_club/screens/cart_item/payment_gateway/place_order_bloc.dart';
import 'package:card_club/screens/purchase_card/physical_card/set_card_date.dart';
import 'package:card_club/utils/static_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pay/pay.dart' as pay;
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:http/http.dart' show get;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../../bottom_navigation.dart';
import '../../../card_editor/text_properties_bloc.dart';
import '../../../utils/app_colors.dart';
import '../bloc/upload_pdf_bloc.dart';

class PhysicalCardPaymentMethod extends StatefulWidget {
  const PhysicalCardPaymentMethod({Key? key}) : super(key: key);

  @override
  _PhysicalCardPaymentMethodState createState() => _PhysicalCardPaymentMethodState();
}

class _PhysicalCardPaymentMethodState extends State<PhysicalCardPaymentMethod> {
  bool pressAttention = false;

  final kApiUrl = defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:4242'
      : 'http://localhost:4242';

  Map<String, dynamic>? paymentIntentData;

  //todo::generate card
  Uint8List imageData=textPropertiesBloc.imageFile;
  var screenshotController = ScreenshotController();
  final pdf = pw.Document();

  @override
  void initState() {
    super.initState();
    print(StaticData.grandTotalFinal);
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
                  });
                  await makePayment(
                      CardPurchase.grandTotalFinal, context); //1122.35
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: pressAttention ? main_color : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
    print(grandTotalFinal);
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
    return value;
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

  getTransactionDetailApi(BuildContext context, String transactionID) async {
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

    await _createPDF(context,paymentModel);
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

      _snackBar('Payment', 'Apple Pay payment successfully completed');
    } catch (e) {
      _snackBar('Error', '${e.toString()}');
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
      final token =
          paymentResult['paymentMethodData']['tokenizationData']['token'];
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
      final isValidKey =
          !profile.contains('<pk_test_qblFNYngBkEdjEZ16jxxoWSM>');
      assert(
        isValidKey,
        'No stripe publishable key added to assets/google_pay_payment_profile.json',
      );
    }
  }

  Future<void> _createPDF(BuildContext context, GetTransactionModel model) async {

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
                color: main_color,
              ));
        });

    var response = await get(Uri.parse(StaticData.card_url));
    var data = response.bodyBytes;
    ByteData imageBytes = await rootBundle.load('assets/pdf_logo.png');
    List<int> values = imageBytes.buffer.asUint8List();
    PdfDocument document = PdfDocument();
    final image1 = document.pages.add();
    final image2 = document.pages.add();
    final image3 = document.pages.add();

    image1.graphics
        .drawString('', PdfStandardFont(PdfFontFamily.helvetica, 30));

    image1.graphics.drawImage(
      PdfBitmap(data),
      const Rect.fromLTWH(
        0,
        100,
        440,
        550,
      ),
    );

    image2.graphics
        .drawString('', PdfStandardFont(PdfFontFamily.helvetica, 30));

    image2.graphics.drawImage(
      PdfBitmap(imageData),
      const Rect.fromLTWH(
        0,
        100,
        440,
        550,
      ),
    );

    image3.graphics
        .drawString('', PdfStandardFont(PdfFontFamily.helvetica, 30));

    image3.graphics.drawImage(
      PdfBitmap(values),
      const Rect.fromLTWH(
        0,
        100,
        440,
        550,
      ),
    );

    List<int> bytes = document.save();
    document.dispose();

    await saveAndLaunchFile(bytes, 'CardClub.pdf',model);
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName, GetTransactionModel model) async {

    String transactionID = model.id!;
    String last4 = model.charges!.data![0].paymentMethodDetails!.card!.last4!;
    String brand = model.charges!.data![0].paymentMethodDetails!.card!.brand!;
    String paymentID = model.paymentMethod!;
    String receiptUrl = model.charges!.data![0].receiptUrl!;
    String balanceTransaction = model.charges!.data![0].balanceTransaction!;

    final path = (await getExternalStorageDirectory())!.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);

    await uploadPdfBloc.uploadPdfApi('$path/$fileName');
    PdfModel pdfModel = uploadPdfBloc.uploadPdfModel;

    int pdfId = pdfModel.data!.id!;

    await placeOrderBloc.placeOrderApi(
        CardPurchase.addressID!,
        CardPurchase.subTotalFinal!,
        CardPurchase.shippingFee!,
        CardPurchase.grandTotalFinal!,
        CardPurchase.shippingName!,
        last4,
        brand,
        transactionID,
        paymentID,
        [],
        pdfId);

    Navigator.of(context).pop();

    Get.to(() => SetCardDate());

    //todo::launch pdf in system apps
    //OpenFile.open('$path/$fileName');
  }


}

const _paymentItems = [
  pay.PaymentItem(
    label: 'Total',
    amount: '0.01',
    status: pay.PaymentItemStatus.final_price,
  )
];
