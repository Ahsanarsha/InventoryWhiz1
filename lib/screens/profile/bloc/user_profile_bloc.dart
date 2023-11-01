import 'package:card_club/resources/repoitory.dart';

class UserProfileBloc{

  final _repository=Repository();
  var _userProfileRequest;

  dynamic get userProfileModel => _userProfileRequest;

  userProfileRequest() async{
    dynamic userProfileModel =await _repository.sendUserProfileRequest();
    _userProfileRequest=userProfileModel;
  }

  dispose(){
    _userProfileRequest.close();
  }

}

final userProfileBloc = UserProfileBloc();