import 'package:card_club/resources/repoitory.dart';

class LoginBloc {

  final _repository = Repository();
  var _loginReq;

  dynamic get loginModel => _loginReq;

  loginRequest(var email,var password,var fcmToken) async {
    dynamic loginModel = await _repository.sendLoginRequest(email, password,fcmToken);
    _loginReq = loginModel;
  }

  dispose() {
    _loginReq.close();
  }
}

final loginBloc = LoginBloc();
