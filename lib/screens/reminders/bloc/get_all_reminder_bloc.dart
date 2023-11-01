import 'package:card_club/resources/models/get_reminder_model.dart';
import 'package:card_club/resources/repoitory.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GetReminderBloc {

  final _repository = Repository();

  var _getReminderReq;
  var _delReminderReq;


  List<Reminders> getReminderOnDateReq = [];
  var showFilters = false.obs;

  dynamic get getReminderModel => _getReminderReq;
  dynamic get getReminderOnDateModel => getReminderOnDateReq;
  dynamic get delReminderModel => _delReminderReq;

  getReminderRequest() async {
    dynamic getReminderModel = await _repository.getReminderRequest();
    _getReminderReq = getReminderModel;
    filterDate(DateTime.now());
  }


  getReminderOnDateRequest(var date) async {
    dynamic getReminderOnDateModel = await _repository.getReminderOnDateRequest(date);
    getReminderOnDateReq = getReminderOnDateModel;
  }

  filterDate(DateTime selectedDate){
    showFilters.value = false;
    GetReminderModel allReminders = _getReminderReq;
    getReminderOnDateReq  = <Reminders>[];
    List<Reminders> reminder = allReminders.reminders!;
    reminder.forEach((element) {
      DateTime reminderDate = DateTime.parse(element.dateTime!);
      if(reminderDate.day ==
          selectedDate.day && reminderDate.month ==
          selectedDate.month){

       getReminderOnDateReq.add(element);
      }
    });
    showFilters.value = true;
  }

  delReminderRequest(int id) async {
    dynamic delReminderModel = await _repository.delReminderRequest(id);
    _delReminderReq = delReminderModel;
  }

  dispose() {
    _getReminderReq.close();
    getReminderOnDateReq.clear();
    _delReminderReq.close();

  }
}

final getReminderBloc = GetReminderBloc();
