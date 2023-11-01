import '../../../resources/repoitory.dart';

class NotificationBloc {

  final _repository = Repository();

  var _notificationReq;
  var _singleNotificationReq;

  dynamic get notificationModel => _notificationReq;
  dynamic get singleNotificationModel => _singleNotificationReq;

  getNotificationAPI() async {
    dynamic notificationModel = await _repository.getNotificationAPI();
    _notificationReq = notificationModel;
  }

  getSingleNotificationAPI(int id) async {
    dynamic singleNotificationModel = await _repository.getSingleNotificationAPI(id);
    _singleNotificationReq = singleNotificationModel;
  }

  dispose() {
    _notificationReq.close();
    _singleNotificationReq.close();
  }
}

final notificationBloc = NotificationBloc();