import 'package:card_club/resources/repoitory.dart';

class GetGiftByIdBloc{

  final _repository=Repository();

  var _giftCategoryRequest;
  var _getGiftByIdRequest;

  dynamic get giftCategoryModel => _giftCategoryRequest;
  dynamic get getGiftByIdModel => _getGiftByIdRequest;

  getGiftByIdRequest(var id) async {
    dynamic getGiftByIdModel=await _repository.sendGiftBYIdRequest(id);
    _getGiftByIdRequest=getGiftByIdModel;
  }

  giftCategoryRequest() async {
    dynamic giftCategoryModel=await _repository.sendGiftCategoryRequest();
    _giftCategoryRequest=giftCategoryModel;
  }

  dispose(){
    _getGiftByIdRequest.close();
    _giftCategoryRequest.close();
  }

}

final getGiftBYIdBloc=GetGiftByIdBloc();