import 'dart:convert';


GetGiftByIDModel getGiftByIDModelFromJson(String str) =>
    GetGiftByIDModel.fromJson(json.decode(str));

class GetGiftByIDModel {

  List<GiftsData>? giftsData;

  GetGiftByIDModel({this.giftsData});

  GetGiftByIDModel.fromJson(Map<String, dynamic> json) {
    if (json['gifts'] != null) {
      giftsData = <GiftsData>[];
      json['gifts'].forEach((v) {
        giftsData!.add(new GiftsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.giftsData != null) {
      data['gifts'] = this.giftsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GiftsData {

  int? id;
  int? giftCategoriesId;
  String? title;
  String? imagePath;
  String? imageName;
  int? qty;
  int? price;
  String? createdAt;
  String? updatedAt;
  List<Wishlist>? wishlist;

  GiftsData(
      {this.id,
        this.giftCategoriesId,
        this.title,
        this.imagePath,
        this.imageName,
        this.qty,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.wishlist});

  GiftsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    giftCategoriesId = json['gift_categories_id'];
    title = json['title'];
    imagePath = json['image_path'];
    imageName = json['image_name'];
    qty = json['qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(new Wishlist.fromJson(v));
      });
    }
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
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wishlist {
  int? id;
  int? userId;
  Null? cardId;
  int? giftId;
  String? createdAt;
  String? updatedAt;

  Wishlist(
      {this.id,
        this.userId,
        this.cardId,
        this.giftId,
        this.createdAt,
        this.updatedAt});

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cardId = json['card_id'];
    giftId = json['gift_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['card_id'] = this.cardId;
    data['gift_id'] = this.giftId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}