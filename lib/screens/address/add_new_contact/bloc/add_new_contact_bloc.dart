import 'package:card_club/resources/repoitory.dart';

class AddNewContactBloc {

  final _repository = Repository();

  var _addNewContactRequest;
  var _updateContactRequest;

  dynamic get addNewContactModel => _addNewContactRequest;
  dynamic get updateContactModel => _updateContactRequest;

  addNewContactAPI(
    var name,
    var nickName,
    var phoneNumber,
    var email,
    var streetAddress1,
    var streetAddress2,
    var address,
    var postalCode,
    var countryID,
    var stateID,
    var cityID,
    String imagePath,
  ) async {
    dynamic addNewContactModel = await _repository.addNewContactAPI(
      name,
      nickName,
      phoneNumber,
      email,
      streetAddress1,
      streetAddress2,
      address,
      postalCode,
      countryID,
      stateID,
      cityID,
      imagePath,
    );
    _addNewContactRequest = addNewContactModel;
  }


  updateContactRequest(
      var id,
      var name,
      var nickName,
      var phoneNumber,
      var email,
      var streetAddress1,
      var streetAddress2,
      var address,
      var postalCode,
      var countryID,
      var stateID,
      var cityID,
      String? imagePath,
      ) async {
    dynamic updateContactModel = await _repository.updateContactRequest(
      id,
      name,
      nickName,
      phoneNumber,
      email,
      streetAddress1,
      streetAddress2,
      address,
      postalCode,
      countryID,
      stateID,
      cityID,
      imagePath!,
    );
    _updateContactRequest = updateContactModel;
  }


  dispose() {
    _addNewContactRequest.close();
    _updateContactRequest.close();
  }
}

final addNewContactBloc = AddNewContactBloc();
