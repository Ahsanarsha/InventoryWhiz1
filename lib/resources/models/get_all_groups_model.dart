import 'dart:convert';

GetAllGroupsModel getAllGroupsModelFromJson(String str) =>
    GetAllGroupsModel.fromJson(json.decode(str));


class GetAllGroupsModel {
  List<Groups>? groups;

  GetAllGroupsModel({this.groups});

  GetAllGroupsModel.fromJson(Map<String, dynamic> json) {
    if (json['groups'] != null) {
      groups = <Groups>[];
      json['groups'].forEach((v) {
        groups!.add(new Groups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.groups != null) {
      data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Groups {
  int? id;
  int? userId;
  String? title;
  String? imageName;
  String? imagePath;
  String? createdAt;
  String? updatedAt;
  List<Contacts>? contacts;

  Groups(
      {this.id,
        this.userId,
        this.title,
        this.imageName,
        this.imagePath,
        this.createdAt,
        this.updatedAt,
        this.contacts});

  Groups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    imageName = json['image_name'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new Contacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['image_name'] = this.imageName;
    data['image_path'] = this.imagePath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contacts {
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

  Contacts(
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

  Contacts.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['nick_name'] = this.nickName;
    data['email'] = this.email;
    data['street_address1'] = this.streetAddress1;
    data['street_address2'] = this.streetAddress2;
    data['address'] = this.address;
    data['postal_code'] = this.postalCode;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['image_path'] = this.imagePath;
    data['image_name'] = this.imageName;
    data['phone_num'] = this.phoneNum;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
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