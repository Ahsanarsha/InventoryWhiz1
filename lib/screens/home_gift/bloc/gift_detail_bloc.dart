import 'package:card_club/resources/repoitory.dart';

class GiftDetailBloc{

  final _repository=Repository();
  var _giftDetailRequest;

  dynamic get giftDetailModel => _giftDetailRequest;

  giftDetailRequest(var id) async {
    dynamic giftDetailModel=await _repository.getGiftDetailRequest(id);
    _giftDetailRequest=giftDetailModel;
  }

  dispose(){
    _giftDetailRequest.close();
  }

}

final giftDetailBloc=GiftDetailBloc();