import '../../../../resources/repoitory.dart';

class ShippingBloc {

  final _repository = Repository();

  var _saveShippingAddressRequest;
  var _getShippingAddressRequest;
  var _updateShippingAddressRequest;
  var _getShippingRatesRequest;

  dynamic get savaShippingAddressModel => _saveShippingAddressRequest;
  dynamic get getShippingAddressModel => _getShippingAddressRequest;
  dynamic get updateShippingAddressModel => _updateShippingAddressRequest;
  dynamic get getShippingRatesModel => _getShippingRatesRequest;

  saveShippingAddressRequest(
    String addressName,
    String streetAddress1,
    String streetAddress2,
    int postalCode,
    int countryID,
    int stateID,
    int cityID,
  ) async {
    dynamic savaShippingAddressModel = await _repository.saveShippingAddressAPI(
      addressName,
      streetAddress1,
      streetAddress2,
      postalCode,
      countryID,
      stateID,
      cityID,
    );
    _saveShippingAddressRequest = savaShippingAddressModel;
  }

  getShippingAddressRequest() async {
    dynamic getShippingAddressModel = await _repository.getShippingAddressAPI();
    _getShippingAddressRequest = getShippingAddressModel;
  }


  updateShippingAddressRequest(
      int id,
      String addressName,
      String streetAddress1,
      String streetAddress2,
      int postalCode,
      int countryID,
      int stateID,
      int cityID,
      int status,
      ) async {
    dynamic updateShippingAddressModel = await _repository.editShippingAddressAPI(
      id,
      addressName,
      streetAddress1,
      streetAddress2,
      postalCode,
      countryID,
      stateID,
      cityID,
      status,
    );
    _updateShippingAddressRequest = updateShippingAddressModel;
  }

  getShippingRatesApi(int addressId) async {
    dynamic getShippingRatesModel = await _repository.getShippingRatesAPI(addressId);
    _getShippingRatesRequest = getShippingRatesModel;
  }

  dispose() {
    _saveShippingAddressRequest.close();
    _getShippingAddressRequest.close();
    _updateShippingAddressRequest.close();
    _getShippingRatesRequest.close();
  }
}

var shippingBloc = ShippingBloc();
