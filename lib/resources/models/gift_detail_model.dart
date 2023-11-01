import 'dart:convert';

GiftDetailModel giftDetailModelFromJson(String str) => GiftDetailModel.fromJson(json.decode(str));

class GiftDetailModel {

  Gift? gift;

  GiftDetailModel({this.gift});

  GiftDetailModel.fromJson(Map<String, dynamic> json) {
    gift = json['gift'] != null ? new Gift.fromJson(json['gift']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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