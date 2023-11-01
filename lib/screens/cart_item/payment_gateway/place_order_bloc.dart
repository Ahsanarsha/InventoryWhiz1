import 'package:card_club/resources/repoitory.dart';
import 'package:card_club/screens/cart_item/payment_gateway/payment_gateway_repos.dart';

class PlaceOrderBloc {

  final _repository = Repository();
  final _paymentRepo = PaymentGatewayRepo();

  var _placeOrderRequest;
  var _getTransactionRequest;

  dynamic get placeOrderModel => _placeOrderRequest;
  dynamic get getTransactionModel => _getTransactionRequest;

  placeOrderApi(
    int addressId,
    int subTotal,
    double shippingFee,
    double grandTotal,
    String shippingService,
    String cardNumber,
    String cardType,
    String transactionId,
    String paymentMethod,
    List<String> cartIds,
      int pdfId,
  ) async {
    dynamic placeOrderModel = await _repository.placeOrderApi(
      addressId,
      subTotal,
      shippingFee,
      grandTotal,
      shippingService,
      cardNumber,
      cardType,
      transactionId,
      paymentMethod,
      cartIds,
        pdfId
    );
    _placeOrderRequest = placeOrderModel;
  }


  getTransactionDetailAPI(var transactionID) async {
    dynamic getTransactionModel = await _paymentRepo.getTransactionDetailApi(transactionID);
    _getTransactionRequest = getTransactionModel;
  }

  dispose() {
    _placeOrderRequest.close();
    _getTransactionRequest.close();
  }
}

final placeOrderBloc = PlaceOrderBloc();
