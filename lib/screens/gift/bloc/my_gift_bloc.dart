import '../../../resources/repoitory.dart';

class MyGiftsBloc{

  final _repository=Repository();
  var _myGiftsRequest;

  dynamic get myGiftsModel => _myGiftsRequest;

  myGiftsApi() async{
    dynamic myGiftsModel =await _repository.getMyGiftsAPI();
    _myGiftsRequest=myGiftsModel;
  }

  dispose(){
    _myGiftsRequest.close();
  }

}

final myGiftsBloc = MyGiftsBloc();