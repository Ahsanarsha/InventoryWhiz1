import 'dart:convert';

GetCartItemsModel getCartItemModelFromJson(String str) =>
    GetCartItemsModel.fromJson(json.decode(str));


class GetCartItemsModel {

  List<Cart>? cart;
  int? status;

  GetCartItemsModel({this.cart, this.status});

  GetCartItemsModel.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Cart {
  int? id;
  int? userId;
  String? cardId;
  int? giftId;
  String? createdAt;
  String? updatedAt;
  String? card;
  Gift? gift;

  Cart(
      {this.id,
        this.userId,
        this.cardId,
        this.giftId,
        this.createdAt,
        this.updatedAt,
        this.card,
        this.gift});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cardId = json['card_id'];
    giftId = json['gift_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    card = json['card'];
    gift = json['gift'] != null ? new Gift.fromJson(json['gift']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['card_id'] = this.cardId;
    data['gift_id'] = this.giftId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['card'] = this.card;
    if (this.gift != null) {
      data['gift'] = this.gift!.toJson();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gift_categories_id'] = this.giftCategoriesId;
    data['title'] = this.title;
    data['image_path'] = this.imagePath;
    data['image_name'] = this.imageName;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}