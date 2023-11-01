import 'dart:convert';

GiftFavoriteModel giftFavoriteModelFromJson(String str) =>
    GiftFavoriteModel.fromJson(json.decode(str));


class GiftFavoriteModel {
  String? message;
  bool? isFavourite;

  GiftFavoriteModel({this.message, this.isFavourite});

  GiftFavoriteModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['is_favourite'] = this.isFavourite;
    return data;
  }
}
