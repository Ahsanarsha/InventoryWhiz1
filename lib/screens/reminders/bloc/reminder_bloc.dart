import 'package:card_club/resources/repoitory.dart';

class ReminderBloc {

  final _repository = Repository();

  var _createReminderReq;
  var _updateReminderReq;


  dynamic get createReminderModel => _createReminderReq;
  dynamic get updateReminderModel => _updateReminderReq;


  saveReminderAPI(
      List<String> contacts,
      int productId,
      String productType,
      List<int> relationIds,
      List<int> groupIds,
      var groupsName,
      var date,
  ) async {
    dynamic createReminderModel = await _repository.saveReminderAPI(
      contacts,
      productId,
      productType,
      relationIds,
      groupIds,
      groupsName,
      date,
    );
    _createReminderReq = createReminderModel;
  }

  updateReminderAPI(
      int id,
      List<String> contacts,
      List<int> relationIds,
      var groupsName,
      var date,
      ) async {
    dynamic updateReminderModel = await _repository.updateReminderAPI(
      id,
      contacts,
      relationIds,
      groupsName,
      date,
    );
    _updateReminderReq = updateReminderModel;
  }



  dispose() {
    _createReminderReq.close();
    _updateReminderReq.close();
  }
}

final reminderBloc = ReminderBloc();
