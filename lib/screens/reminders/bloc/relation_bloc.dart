import 'package:card_club/resources/repoitory.dart';

class RelationBloc {

  final _repository = Repository();

  var _addRelationReq;
  var _getRelationReq;
  var _delRelationReq;

  dynamic get addRelationModel => _addRelationReq;
  dynamic get getRelationModel => _getRelationReq;
  dynamic get delRelationModel => _delRelationReq;

  saveRelationAPI(var title) async {
    dynamic addRelationModel = await _repository.saveRelationAPI(title);
    _addRelationReq = addRelationModel;
  }

  getRelationAPI() async {
    dynamic getRelationModel = await _repository.getAllRelationAPI();
    _getRelationReq = getRelationModel;
  }

  delRelationAPI(int id) async {
    dynamic delInterestModel = await _repository.delRelationAPI(id);
    _delRelationReq = delInterestModel;
  }


  dispose() {
    _addRelationReq.close();
    _getRelationReq.close();
    _delRelationReq.close();
  }
}

final relationBloc = RelationBloc();
