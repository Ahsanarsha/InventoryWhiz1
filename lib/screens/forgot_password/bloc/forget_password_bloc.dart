import 'package:card_club/resources/repoitory.dart';

class ForgetPasswordBloc {
  final _repository = Repository();

  var _forgetEmailReq;
  var _forgetOtpReq;
  var _forgetPasswordReq;
  var _changePasswordReq;

  dynamic get forgetEmailModel => _forgetEmailReq;
  dynamic get forgetOtpModel => _forgetOtpReq;
  dynamic get forgetPasswordModel => _forgetPasswordReq;
  dynamic get changePasswordModel => _changePasswordReq;

  forgetEmailRequest(var email) async {
    dynamic forgetEmailModel = await _repository.postForgetEmailRequest(email);
    _forgetEmailReq = forgetEmailModel;
  }

  forgetOtpRequest(var email,var otp) async {
    dynamic forgetOtpModel = await _repository.postForgetOtpRequest(email,otp);
    _forgetOtpReq = forgetOtpModel;
  }

  forgetPasswordRequest(var email, var password, var confirmPassword) async {
    dynamic forgetPasswordModel = await _repository.postForgetPasswordRequest(
        email, password, confirmPassword);
    _forgetPasswordReq = forgetPasswordModel;
  }

  changePasswordRequest(var oldPassword, var password, var confirmPassword) async {
    dynamic changePasswordModel = await _repository.postChangePasswordRequest(
        oldPassword, password, confirmPassword);
    _changePasswordReq = changePasswordModel;
  }

  dispose() {
    _forgetEmailReq.close();
    _forgetOtpReq.close();
    _forgetPasswordReq.close();
    _changePasswordReq.close();
  }
}

final forgetPasswordBloc = ForgetPasswordBloc();
