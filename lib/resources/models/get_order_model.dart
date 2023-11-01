import 'dart:convert';

GetOrderModel getOrdersModelFromJson(String str) =>
    GetOrderModel.fromJson(json.decode(str));


class GetOrderModel {
  List<OrderData>? order;

  GetOrderModel({this.order});

  GetOrderModel.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = <OrderData>[];
      json['order'].forEach((v) {
        order!.add(new OrderData.fromJson(v));
      });
    }
  }

}

class OrderData {
  int? id;
  int? userId;
  int? addressId;
  String? subTotal;
  String? shippingFee;
  String? grandTotal;
  String? shippingService;
  int? orderStatus;
  int? paymentId;
  String? createdAt;
  String? updatedAt;

  OrderData(
      {this.id,
        this.userId,
        this.addressId,
        this.subTotal,
        this.shippingFee,
        this.grandTotal,
        this.shippingService,
        this.orderStatus,
        this.paymentId,
        this.createdAt,
        this.updatedAt});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressId = json['address_id'];
    subTotal = json['sub_total'];
    shippingFee = json['shipping_fee'];
    grandTotal = json['grand_total'];
    shippingService = json['shipping_service'];
    orderStatus = json['order_status'];
    paymentId = json['payment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}