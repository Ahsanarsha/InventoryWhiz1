import 'package:card_club/resources/repoitory.dart';

class UserUpdateDetailBloc {

  final _repository = Repository();

  var _userUpdateDOBReq;
  var _userUpdateAboutYouReq;
  var _userUpdateNameReq;
  var _userUpdateImageReq;

  dynamic get userUpdateDOBModel => _userUpdateDOBReq;
  dynamic get userUpdateAboutYouModel => _userUpdateAboutYouReq;
  dynamic get userUpdateNameModel => _userUpdateNameReq;
  dynamic get userUpdateImageModel => _userUpdateImageReq;

  sendUpdateDOBRequest(var dobDate) async {
    dynamic userUpdateDetailModel = await _repository.sendUpdateDOB(dobDate);
    _userUpdateDOBReq = userUpdateDetailModel;
  }

  sendUpdateAboutRequest(
    var cityID,
    var stateID,
    var countryID,
    var salary,
    var zipCode,
    var companyRole,
    var companyName,
  ) async {
    dynamic userUpdateAboutYouModel = await _repository.sendUpdateAboutYou(
      cityID,
      stateID,
      countryID,
      salary,
      zipCode,
      companyRole,
      companyName,
    );

    _userUpdateAboutYouReq = userUpdateAboutYouModel;
  }

    sendUserUpdateNameRequest(var name) async {
      dynamic userUpdateNameModel = await _repository.sendUpdateUserName(name);
      _userUpdateNameReq = userUpdateNameModel;
  }

  sendUserUpdateImageRequest(String imagePath) async {
    dynamic userUpdateImageModel = await _repository.sendUpdateImage(imagePath);
    _userUpdateImageReq = userUpdateImageModel;
  }

  dispose() {
    _userUpdateAboutYouReq.close();
    _userUpdateAboutYouReq.close();
    _userUpdateNameReq.close();
    _userUpdateImageReq.close();
  }
}

final userUpdateDetailBloc = UserUpdateDetailBloc();
