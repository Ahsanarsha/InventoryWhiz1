import 'package:card_club/resources/repoitory.dart';

class GetCitiesBloc{

  final _repository=Repository();
  var _getCitiesRequest;

  dynamic get getCitiesModel => _getCitiesRequest;

  getCitiesRequest(int id) async {
    dynamic getCitiesModel=await _repository.getCitiesRequest(id);
    _getCitiesRequest=getCitiesModel;
  }

  dispose(){
    _getCitiesRequest.close();
  }

}

final getCitiesBloc=GetCitiesBloc();