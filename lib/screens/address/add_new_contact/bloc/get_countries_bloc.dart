import 'package:card_club/resources/repoitory.dart';

class GetCountriesBloc{

  final _repository=Repository();
  var _getCountriesRequest;

  dynamic get getCountriesModel => _getCountriesRequest;

  getCountriesRequest() async {
    dynamic getCountriesModel=await _repository.getCountriesRequest();
    _getCountriesRequest=getCountriesModel;
  }

  dispose(){
    _getCountriesRequest.close();
  }

}

final getCountriesBloc=GetCountriesBloc();