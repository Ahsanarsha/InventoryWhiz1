import 'package:card_club/resources/repoitory.dart';

class AllCardBloc{

  final _repository=Repository();

  var _loadFirstCardsReq;
  var _loadMoreCardsReq;

  dynamic get loadFirstCardsModel => _loadFirstCardsReq;
  dynamic get loadMoreCardsModel => _loadMoreCardsReq;

  loadFirstCardsApi() async {
    dynamic loadFirstCardsModel=await _repository.loadFirstCardsApi();
    _loadFirstCardsReq=loadFirstCardsModel;
  }

  loadMoreCardsApi(int page) async {
    dynamic loadMoreCardsModel=await _repository.loadMoreCardsApi(page);
    _loadMoreCardsReq=loadMoreCardsModel;
  }

  dispose(){
    _loadFirstCardsReq.close();
    _loadMoreCardsReq.close();
  }

}

final allCardBloc=AllCardBloc();