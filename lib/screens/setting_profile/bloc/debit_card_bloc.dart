import 'package:card_club/resources/repoitory.dart';

class DebitCardBloc {
  final _repository = Repository();

  var _getDebitCardReq;
  var _addDebitCardReq;
  var _updateDebitCardReq;
  var _delDebitCardReq;

  dynamic get getDebitCardModel => _getDebitCardReq;
  dynamic get addDebitCardModel => _addDebitCardReq;
  dynamic get updateDebitCardModel => _updateDebitCardReq;
  dynamic get delDebitCardModel => _delDebitCardReq;

  getDebitCardAPI() async {
    dynamic getDebitCardModel = await _repository.getDebitCardAPI();
    _getDebitCardReq = getDebitCardModel;
  }

  saveDebitCardAPI(
    String cardHolderName,
      String cardNumber,
      String expireMonth,
      String expireYear,
      String cvv,
  ) async {
    dynamic addDebitCardModel = await _repository.saveDebitCardAPI(
      cardHolderName,
      cardNumber,
      expireMonth,
      expireYear,
      cvv,
    );
    _addDebitCardReq = addDebitCardModel;
  }

  updateDebitCardAPI(
      int id,
      String cardHolderName,
      String cardNumber,
      String expireMonth,
      String expireYear,
      String cvv,
      ) async {
    dynamic updateDebitCardModel = await _repository.updateDebitCardAPI(
      id,
      cardHolderName,
      cardNumber,
      expireMonth,
      expireYear,
      cvv,
    );
    _updateDebitCardReq = updateDebitCardModel;
  }

  delDebitCardAPI(int? id) async {
    dynamic delDebitCardModel = await _repository.delDebitCardAPI(id);
    _delDebitCardReq = delDebitCardModel;
  }

  dispose() {
    _getDebitCardReq.close();
    _addDebitCardReq.close();
    _delDebitCardReq.close();
  }
}

final debitCardBloc = DebitCardBloc();
