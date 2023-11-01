import 'package:card_club/screens/cart_item/payment_gateway/payment_gateway_provider.dart';

class PaymentGatewayRepo{

  final apiProvider = Provider();

  Future<dynamic> getTransactionDetailApi(dynamic transactionID) =>
      apiProvider.getTransactionDetailApi(transactionID);

}

