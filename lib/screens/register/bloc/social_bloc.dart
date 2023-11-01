import 'package:card_club/resources/repoitory.dart';

class SocialBloc {
  final _repository = Repository();
  var _socialReq;

  dynamic get socialModel => _socialReq;

  socialRequest(
    var name,
    var email,
    var deviceKey,
    var uuid,
    var phoneNum,
    var providerName,
  ) async {
    dynamic socialModel = await _repository.sendSocialRequest(
    name,
    email,
    deviceKey,
    uuid,
    phoneNum,
    providerName,
    );
    _socialReq = socialModel;
  }

  dispose() {
    _socialReq.close();
  }
}

final socialBloc = SocialBloc();
