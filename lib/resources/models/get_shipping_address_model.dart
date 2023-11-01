import 'dart:convert';

GetShippingAddressModel getShippingAddressModelFromJson(String str) =>
    GetShippingAddressModel.fromJson(json.decode(str));


class GetShippingAddressModel {
  List<Address>? address;
  int? status;

  GetShippingAddressModel({this.address, this.status});

  GetShippingAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    status = json['status'];
  }

}

class Address {
  int? id;
  int? userId;
  String? addressName;
  String? streetAddress1;
  String? streetAddress2;
  String? postalCode;
  int? countryId;
  int? stateId;
  int? cityId;
  int? status;
  String? createdAt;
  String? updatedAt;

  Address(
      {this.id,
        this.userId,
        this.addressName,
        this.streetAddress1,
        this.streetAddress2,
        this.postalCode,
        this.countryId,
        this.stateId,
        this.cityId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressName = json['address_name'];
    streetAddress1 = json['street_address1'];
    streetAddress2 = json['street_address2'];
    postalCode = json['postal_code'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}