import 'dart:convert';

GetSingleOrderModel getSingleOrderModelFromJson(String str) =>
    GetSingleOrderModel.fromJson(json.decode(str));


class GetSingleOrderModel {
  Data? data;

  GetSingleOrderModel({this.data});

  GetSingleOrderModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  Order? order;
  List<Cart>? cart;

  Data({this.order, this.cart});

  Data.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
  }

}

class Order {
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
  Payment? payment;
  Address? address;
  User? user;

  Order(
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
        this.updatedAt,
        this.payment,
        this.address,
        this.user});

  Order.fromJson(Map<String, dynamic> json) {
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
    payment =
    json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

}

class Payment {
  int? id;
  String? refType;
  int? refId;
  int? userId;
  String? title;
  dynamic? amount;
  String? cardNumber;
  String? cardType;
  String? transactionId;
  String? balanceTransaction;
  String? paymentMethod;
  String? receiptUrl;
  String? createdAt;
  String? updatedAt;

  Payment(
      {this.id,
        this.refType,
        this.refId,
        this.userId,
        this.title,
        this.amount,
        this.cardNumber,
        this.cardType,
        this.transactionId,
        this.balanceTransaction,
        this.paymentMethod,
        this.receiptUrl,
        this.createdAt,
        this.updatedAt});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refType = json['ref_type'];
    refId = json['ref_id'];
    userId = json['user_id'];
    title = json['title'];
    amount = json['amount'];
    cardNumber = json['card_number'];
    cardType = json['card_type'];
    transactionId = json['transaction_id'];
    balanceTransaction = json['balance_transaction'];
    paymentMethod = json['payment_method'];
    receiptUrl = json['receipt_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class Address {
  int? id;
  int? userId;
  String? addressName;
  String? streetAddress1;
  String? streetAddress2;
  String? postalCode;
  int? countryId;
  int? stateId;
  int? cityId;
  int? status;
  String? createdAt;
  String? updatedAt;

  Address(
      {this.id,
        this.userId,
        this.addressName,
        this.streetAddress1,
        this.streetAddress2,
        this.postalCode,
        this.countryId,
        this.stateId,
        this.cityId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressName = json['address_name'];
    streetAddress1 = json['street_address1'];
    streetAddress2 = json['street_address2'];
    postalCode = json['postal_code'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class User {
  int? id;
  String? uuid;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? providerName;
  String? dob;
  String? role;
  String? deviceKey;
  String? phoneNum;
  int? status;
  String? cityId;
  String? stateId;
  String? countryId;
  String? salary;
  String? zipCode;
  String? companyRole;
  String? companyName;
  String? imageName;
  String? imagePath;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.uuid,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.providerName,
        this.dob,
        this.role,
        this.deviceKey,
        this.phoneNum,
        this.status,
        this.cityId,
        this.stateId,
        this.countryId,
        this.salary,
        this.zipCode,
        this.companyRole,
        this.companyName,
        this.imageName,
        this.imagePath,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    providerName = json['provider_name'];
    dob = json['dob'];
    role = json['role'];
    deviceKey = json['device_key'];
    phoneNum = json['phone_num'];
    status = json['status'];
    cityId = json['city_id'];
    stateId = json['state_id'];
    countryId = json['country_id'];
    salary = json['salary'];
    zipCode = json['zip_code'];
    companyRole = json['company_role'];
    companyName = json['company_name'];
    imageName = json['image_name'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class Cart {
  int? id;
  int? userId;
  String? cardId;
  int? giftId;
  String? itemType;
  int? quantity;
  int? orderId;
  String? createdAt;
  String? updatedAt;
  String? card;
  Gift? gift;

  Cart(
      {this.id,
        this.userId,
        this.cardId,
        this.giftId,
        this.itemType,
        this.quantity,
        this.orderId,
        this.createdAt,
        this.updatedAt,
        this.card,
        this.gift});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cardId = json['card_id'];
    giftId = json['gift_id'];
    itemType = json['item_type'];
    quantity = json['quantity'];
    orderId = json['order_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    card = json['card'];
    gift = json['gift'] != null ? new Gift.fromJson(json['gift']) : null;
  }

}

class Gift {
  int? id;
  int? giftCategoriesId;
  String? title;
  String? imagePath;
  String? imageName;
  int? qty;
  int? price;
  String? createdAt;
  String? updatedAt;

  Gift(
      {this.id,
        this.giftCategoriesId,
        this.title,
        this.imagePath,
        this.imageName,
        this.qty,
        this.price,
        this.createdAt,
        this.updatedAt});

  Gift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    giftCategoriesId = json['gift_categories_id'];
    title = json['title'];
    imagePath = json['image_path'];
    imageName = json['image_name'];
    qty = json['qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}