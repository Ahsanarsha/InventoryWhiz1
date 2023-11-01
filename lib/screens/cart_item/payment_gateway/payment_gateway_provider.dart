import 'dart:developer';

import 'package:card_club/screens/cart_item/payment_gateway/get_transaction_model.dart';
import 'package:http/http.dart' show Client;
import 'env.dart';

class Provider{

  Client client = Client();

  getTransactionDetailApi(var transactionID) async {
    print("Call Get All Data From Stripe");
    final response = await client.get(
      Uri.parse('https://api.stripe.com/v1/payment_intents/$transactionID'),
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded'
        });

    print(response.statusCode == 200 ? 'Status OK' : response.body.toString());

    if (response.statusCode == 200) {
      log('Get All Data From Stripe: ${response.body.toString()}');
      return getPaymentResponseFromJson(response.body.toString());
    }
  }



}