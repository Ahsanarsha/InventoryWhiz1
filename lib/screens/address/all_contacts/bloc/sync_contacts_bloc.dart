import 'package:card_club/resources/repoitory.dart';

class SyncContactsBloc {

  final _repository = Repository();

  var _getSyncContactAPI;
  var _addSyncContactAPI;

  dynamic get getSyncContactsModel => _getSyncContactAPI;
  dynamic get addSyncContactsModel => _addSyncContactAPI;

  getSyncContactsAPI(List<String> contacts) async {
    dynamic getSyncContactsModel = await _repository.getSyncContactAPI(contacts);
    _getSyncContactAPI = getSyncContactsModel;
  }

  addSyncContactsAPI(List<int> ids) async {
    dynamic addSyncContactsModel = await _repository.addSyncContactAPI(ids);
    _addSyncContactAPI = addSyncContactsModel;
  }


  dispose() {
    _getSyncContactAPI.close();
    _addSyncContactAPI.close();
  }
}

final syncContactsBloc = SyncContactsBloc();
