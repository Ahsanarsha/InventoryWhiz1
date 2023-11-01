import '../../../resources/repoitory.dart';

class OrderBloc{

  final _repository=Repository();

  var _getAllOrderRequest;
  var _getSingleOrderRequest;

  dynamic get getAllOrderModel => _getAllOrderRequest;
  dynamic get getSingleOrderModel => _getSingleOrderRequest;

  getOrderApi() async{
    dynamic getAllOrderModel =await _repository.getOrdersAPI();
    _getAllOrderRequest=getAllOrderModel;
  }

  getSingleOrderApi(int id) async{
    dynamic getSingleOrderModel =await _repository.getSingleOrderAPI(id);
    _getSingleOrderRequest=getSingleOrderModel;
  }

  dispose(){
    _getAllOrderRequest.close();
    _getSingleOrderRequest.close();
  }

}

final orderBloc = OrderBloc();