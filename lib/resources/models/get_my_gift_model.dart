import 'dart:convert';

GetMyGiftModel getMyGiftsModelFromJson(String str) =>
    GetMyGiftModel.fromJson(json.decode(str));


class GetMyGiftModel {
  List<MyGifts>? myGifts;
  int? status;

  GetMyGiftModel({this.myGifts, this.status});

  GetMyGiftModel.fromJson(Map<String, dynamic> json) {
    if (json['myGifts'] != null) {
      myGifts = <MyGifts>[];
      json['myGifts'].forEach((v) {
        myGifts!.add(new MyGifts.fromJson(v));
      });
    }
    status = json['status'];
  }

}

class MyGifts {
  int? id;
  int? giftCategoriesId;
  String? title;
  String? imagePath;
  String? imageName;
  int? qty;
  int? price;
  String? createdAt;
  String? updatedAt;

  MyGifts(
      {this.id,
        this.giftCategoriesId,
        this.title,
        this.imagePath,
        this.imageName,
        this.qty,
        this.price,
        this.createdAt,
        this.updatedAt});

  MyGifts.fromJson(Map<String, dynamic> json) {
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