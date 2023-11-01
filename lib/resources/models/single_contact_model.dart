import 'dart:convert';

SingleContactModel singleContactModelFromJson(String str) =>
    SingleContactModel.fromJson(json.decode(str));


class SingleContactModel {

  Data? data;
  int? status;

  SingleContactModel({this.data, this.status});

  SingleContactModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

}

class Data {
  int? id;
  int? userId;
  String? name;
  String? nickName;
  String? email;
  String? streetAddress1;
  String? streetAddress2;
  String? address;
  String? postalCode;
  int? countryId;
  int? stateId;
  int? cityId;
  String? imagePath;
  String? imageName;
  String? phoneNum;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.name,
        this.nickName,
        this.email,
        this.streetAddress1,
        this.streetAddress2,
        this.address,
        this.postalCode,
        this.countryId,
        this.stateId,
        this.cityId,
        this.imagePath,
        this.imageName,
        this.phoneNum,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    nickName = json['nick_name'];
    email = json['email'];
    streetAddress1 = json['street_address1'];
    streetAddress2 = json['street_address2'];
    address = json['address'];
    postalCode = json['postal_code'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    imagePath = json['image_path'];
    imageName = json['image_name'];
    phoneNum = json['phone_num'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}