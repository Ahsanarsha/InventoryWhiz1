import 'dart:convert';

AllWishListModel allWishListModelFromJson(String str) =>
    AllWishListModel.fromJson(json.decode(str));


class AllWishListModel {
  String? message;
  List<Wishlist>? wishlist;

  AllWishListModel({this.message, this.wishlist});

  AllWishListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(new Wishlist.fromJson(v));
      });
    }
  }
}

class Wishlist {
  int? id;
  int? userId;
  int? cardId;
  int? giftId;
  String? createdAt;
  String? updatedAt;
  Card? card;
  Gift? gift;

  Wishlist(
      {this.id,
        this.userId,
        this.cardId,
        this.giftId,
        this.createdAt,
        this.updatedAt,
        this.card,
        this.gift});

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cardId = json['card_id'];
    giftId = json['gift_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    card = json['card'] != null ? new Card.fromJson(json['card']) : null;
    gift = json['gift'] != null ? new Gift.fromJson(json['gift']) : null;
  }

}

class Card {
  int? id;
  int? cardCategoriesId;
  String? title;
  String? scope;
  String? imagePath;
  String? imageName;
  int? soldQuantity;
  int? qty;
  int? price;
  String? createdAt;
  String? updatedAt;

  Card(
      {this.id,
        this.cardCategoriesId,
        this.title,
        this.scope,
        this.imagePath,
        this.imageName,
        this.soldQuantity,
        this.qty,
        this.price,
        this.createdAt,
        this.updatedAt});

  Card.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardCategoriesId = json['card_categories_id'];
    title = json['title'];
    scope = json['scope'];
    imagePath = json['image_path'];
    imageName = json['image_name'];
    soldQuantity = json['sold_quantity'];
    qty = json['qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Gift {
  int? id;
  int? giftCategoriesId;
  String? title;
  String? imagePath;
  String? imageName;
  int? soldQuantity;
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
        this.soldQuantity,
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
    soldQuantity = json['sold_quantity'];
    qty = json['qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}