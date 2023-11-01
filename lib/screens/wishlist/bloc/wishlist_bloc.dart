
import 'package:card_club/resources/repoitory.dart';

class WishListBloc {

  final _repository = Repository();
  var _wishlistReq;

  dynamic get wishlistModel => _wishlistReq;

  wishlistRequest() async {
    dynamic wishlistModel = await _repository.getAllWishListRequest();
    _wishlistReq = wishlistModel;
  }

  dispose() {
    _wishlistReq.close();
  }
}

final wishlistBloc = WishListBloc();