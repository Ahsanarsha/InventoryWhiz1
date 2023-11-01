import 'dart:convert';

SingleGroupDetailModel getSingleGroupModelFromJson(String str) =>
    SingleGroupDetailModel.fromJson(json.decode(str));

class SingleGroupDetailModel {
  List<SingleGroup>? group;

  SingleGroupDetailModel({this.group});

  SingleGroupDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['group'] != null) {
      group = <SingleGroup>[];
      json['group'].forEach((v) {
        group!.add(SingleGroup.fromJson(v));
      });
    }
  }

}

class SingleGroup {
  int? id;
  int? userId;
  String? title;
  String? imageName;
  String? imagePath;
  String? createdAt;
  String? updatedAt;
  List<SingleContacts>? contacts;

  SingleGroup(
      {this.id,
        this.userId,
        this.title,
        this.imageName,
        this.imagePath,
        this.createdAt,
        this.updatedAt,
        this.contacts});

  SingleGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    imageName = json['image_name'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['contacts'] != null) {
      contacts = <SingleContacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new SingleContacts.fromJson(v));
      });
    }
  }

}

class SingleContacts {
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
  Pivot? pivot;

  SingleContacts(
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
        this.updatedAt,
        this.pivot});

  SingleContacts.fromJson(Map<String, dynamic> json) {
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

}

class Pivot {
  int? groupId;
  int? contactId;

  Pivot({this.groupId, this.contactId});

  Pivot.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    contactId = json['contact_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['contact_id'] = this.contactId;
    return data;
  }
}