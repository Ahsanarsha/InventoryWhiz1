import 'package:card_club/resources/repoitory.dart';

class GetStatesBloc{

  final _repository=Repository();
  var _getStatesRequest;

  dynamic get getStatesModel => _getStatesRequest;

  getStatesRequest(int id) async {
    dynamic getStatesModel=await _repository.getStatesByCountryRequest(id);
    _getStatesRequest=getStatesModel;
  }

  dispose(){
    _getStatesRequest.close();
  }

}

final getStatesBloc=GetStatesBloc();