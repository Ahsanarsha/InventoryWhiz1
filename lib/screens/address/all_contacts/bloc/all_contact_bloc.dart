import 'package:card_club/resources/repoitory.dart';

class GetAllContactBloc {

  final _repository = Repository();

  var _getAllContactRequest;
  var _getSingleContactAPI;
  var _delContactRequest;

  dynamic get getAllContactModel => _getAllContactRequest;
  dynamic get getSingleContactModel => _getSingleContactAPI;
  dynamic get delContactModel => _delContactRequest;

  getAllContactRequest() async {
    dynamic getAllContactModel = await _repository.getAllContactRequest();
    _getAllContactRequest = getAllContactModel;
  }

  getSingleContactAPI(int id) async {
    dynamic getSingleContactModel = await _repository.getSingleContactAPI(id);
    _getSingleContactAPI = getSingleContactModel;
  }

  delContactsRequest(List<String> listIds) async {
    dynamic delContactModel = await _repository.delContactsRequest(listIds);
    _delContactRequest = delContactModel;
  }

  dispose() {
    _getAllContactRequest.close();
    _getSingleContactAPI.close();
    _delContactRequest.close();
  }
}

final getAllContactBloc = GetAllContactBloc();
