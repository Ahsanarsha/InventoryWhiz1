import 'package:card_club/resources/repoitory.dart';

class InterestBloc {

  final _repository = Repository();

  var _addInterestReq;
  var _getInterestReq;
  var _delInterestReq;

  dynamic get addInterestModel => _addInterestReq;
  dynamic get getInterestModel => _getInterestReq;
  dynamic get delInterestModel => _delInterestReq;

  saveInterestAPI(var title) async {
    dynamic addInterestModel = await _repository.saveInterestAPI(title);
    _addInterestReq = addInterestModel;
  }

  getAllInterestAPI() async {
    dynamic getInterestModel = await _repository.getAllInterestAPI();
    _getInterestReq = getInterestModel;
  }

  delInterestAPI(int? id) async {
    dynamic delInterestModel = await _repository.delInterestAPI(id);
    _delInterestReq = delInterestModel;
  }


  dispose() {
    _addInterestReq.close();
    _getInterestReq.close();
    _delInterestReq.close();
  }
}

final interestBloc = InterestBloc();
