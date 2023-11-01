import 'dart:convert';

GetContactModel getContactModelFromJson(String str) =>
    GetContactModel.fromJson(json.decode(str));


class GetContactModel {
  List<ContactsData>? contacts;

  GetContactModel({this.contacts});

  GetContactModel.fromJson(Map<String, dynamic> json) {
    if (json['contacts'] != null) {
      contacts = <ContactsData>[];
      json['contacts'].forEach((v) {
        contacts!.add(new ContactsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactsData {
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
  CountryName? country;
  StateName? state;
  CityName? city;

  ContactsData(
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
        this.country,
        this.state,
        this.city});

  ContactsData.fromJson(Map<String, dynamic> json) {
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
    country =
    json['country'] != null ? new CountryName.fromJson(json['country']) : null;
    state = json['state'] != null ? new StateName.fromJson(json['state']) : null;
    city = json['city'] != null ? new CityName.fromJson(json['city']) : null;
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
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class CountryName {
  int? id;
  String? countryName;

  CountryName({this.id, this.countryName});

  CountryName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_name'] = this.countryName;
    return data;
  }
}

class StateName {
  int? id;
  String? stateName;

  StateName({this.id, this.stateName});

  StateName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_name'] = this.stateName;
    return data;
  }
}

class CityName {
  int? id;
  String? cityName;

  CityName({this.id, this.cityName});

  CityName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_name'] = this.cityName;
    return data;
  }
}