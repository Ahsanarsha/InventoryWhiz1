import 'package:card_club/resources/repoitory.dart';

class CartBloc{

  final _repository=Repository();

  var _addToCartRequest;
  var _getCartRequest;
  var _delCartRequest;

  dynamic get addToCartModel => _addToCartRequest;
  dynamic get getCartModel => _getCartRequest;
  dynamic get delCartModel => _delCartRequest;

  addToCartRequest(int id,String type) async {
    dynamic addToCartModel=await _repository.addToCartRequest(id,type);
    _addToCartRequest=addToCartModel;
  }

  getCartRequest() async {
    dynamic getCartModel=await _repository.getCartItemsRequest();
    _getCartRequest=getCartModel;
  }

  delCartRequest(int id) async {
    dynamic delCartModel=await _repository.delCartItemsRequest(id);
    _delCartRequest=delCartModel;
  }

  dispose(){
    _addToCartRequest.close();
    _getCartRequest.close();
    _delCartRequest.close();
  }

}

final cartBloc=CartBloc();