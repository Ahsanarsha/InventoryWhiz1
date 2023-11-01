import 'package:card_club/resources/repoitory.dart';

class RegisterBloc {
  final _repository = Repository();
  var _registerReq;
  var _otpReq;

  dynamic get registerModel => _registerReq;
  dynamic get otpModel => _otpReq;

  otpRequest(var email) async {
    dynamic otpModel = await _repository.sendOtpRequest(email);
    _otpReq = otpModel;
  }

  registerRequest(
    var name,
    var email,
    var password,
    var passwordConfirmation,
    var deviceKey,
    var token,
    var phoneNum,
  ) async {
    dynamic registerModel = await _repository.sendRegisterRequest(
      name,
      email,
      password,
      passwordConfirmation,
      deviceKey,
      token,
      phoneNum,
    );
    _registerReq = registerModel;
  }

  dispose() {
    _registerReq.close();
    _otpReq.close();
  }
}

final registerBloc = RegisterBloc();
