import 'dart:convert';

GetDebitCardModel getDebitCardModelFromJson(String str) =>
    GetDebitCardModel.fromJson(json.decode(str));


class GetDebitCardModel {
  PaymentCard? paymentCard;

  GetDebitCardModel({this.paymentCard});

  GetDebitCardModel.fromJson(Map<String, dynamic> json) {
    paymentCard = json['payment_card'] != null
        ? new PaymentCard.fromJson(json['payment_card'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentCard != null) {
      data['payment_card'] = this.paymentCard!.toJson();
    }
    return data;
  }
}

class PaymentCard {
  int? id;
  int? userId;
  String? cardHolderName;
  String? cardNumber;
  String? expireMonth;
  String? expireYear;
  String? cvv;
  String? createdAt;
  String? updatedAt;

  PaymentCard(
      {this.id,
        this.userId,
        this.cardHolderName,
        this.cardNumber,
        this.expireMonth,
        this.expireYear,
        this.cvv,
        this.createdAt,
        this.updatedAt});

  PaymentCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cardHolderName = json['card_holder_name'];
    cardNumber = json['card_number'];
    expireMonth = json['expire_month'];
    expireYear = json['expire_year'];
    cvv = json['cvv'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['card_holder_name'] = this.cardHolderName;
    data['card_number'] = this.cardNumber;
    data['expire_month'] = this.expireMonth;
    data['expire_year'] = this.expireYear;
    data['cvv'] = this.cvv;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}