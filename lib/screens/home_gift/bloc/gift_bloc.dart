import 'package:card_club/resources/repoitory.dart';

class GiftBloc{

  final _repository=Repository();

  var _addToWishListRequest;
  var _removeFromWishListRequest;

  dynamic get addToWishListModel => _addToWishListRequest;
  dynamic get removeFromWihListModel => _removeFromWishListRequest;

  addToWishListAPI(String endPoint,int id) async {
    dynamic addToWishListModel=await _repository.addToWishListAPI(endPoint,id);
    _addToWishListRequest=addToWishListModel;
  }

  removeFromWishListAPI(var id) async {
    dynamic removeFromWihListModel=await _repository.removeFromWishListAPI(id);
    _removeFromWishListRequest=removeFromWihListModel;
  }

  dispose(){
    _addToWishListRequest.close();
    _removeFromWishListRequest.close();
  }

}

final giftBloc=GiftBloc();