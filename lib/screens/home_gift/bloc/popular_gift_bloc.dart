import 'package:card_club/resources/repoitory.dart';

class GetPopularGiftBloc{

  final _repository=Repository();

  var _getPopularGiftRequest;
  var _loadMoreGiftRequest;

  dynamic get getPopularGiftModel => _getPopularGiftRequest;
  dynamic get loadMoreGiftModel => _loadMoreGiftRequest;

  getPopularGiftRequest() async {
    dynamic getPopularGiftModel=await _repository.getPopularGiftAPI();
    _getPopularGiftRequest=getPopularGiftModel;
  }

  loadMoreGiftRequest(int page) async {
    dynamic loadMoreGiftModel=await _repository.loadMorePopularGiftAPI(page);
    _getPopularGiftRequest=loadMoreGiftModel;
  }

  dispose(){
    _getPopularGiftRequest.close();
    _loadMoreGiftRequest.close();
  }

}

final getPopularGiftBloc=GetPopularGiftBloc();