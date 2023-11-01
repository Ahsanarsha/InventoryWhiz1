import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));


class UserProfileModel {
  int? id;
  String? uuid;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? providerName;
  String? dob;
  String? role;
  String? deviceKey;
  int? cityId;
  int? stateId;
  int? countryId;
  String? salary;
  String? zipCode;
  String? companyRole;
  String? companyName;
  String? imageName;
  String? imagePath;
  String? createdAt;
  String? updatedAt;

  UserProfileModel(
      {this.id,
        this.uuid,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.providerName,
        this.dob,
        this.role,
        this.deviceKey,
        this.cityId,
        this.stateId,
        this.countryId,
        this.salary,
        this.zipCode,
        this.companyRole,
        this.companyName,
        this.imageName,
        this.imagePath,
        this.createdAt,
        this.updatedAt});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    providerName = json['provider_name'];
    dob = json['dob'];
    role = json['role'];
    deviceKey = json['device_key'];
    cityId = json['city_id'];
    stateId = json['state_id'];
    countryId = json['country_id'];
    salary = json['salary'];
    zipCode = json['zip_code'];
    companyRole = json['company_role'];
    companyName = json['company_name'];
    imageName = json['image_name'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['provider_name'] = this.providerName;
    data['dob'] = this.dob;
    data['role'] = this.role;
    data['device_key'] = this.deviceKey;
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    data['country_id'] = this.countryId;
    data['salary'] = this.salary;
    data['zip_code'] = this.zipCode;
    data['company_role'] = this.companyRole;
    data['company_name'] = this.companyName;
    data['image_name'] = this.imageName;
    data['image_path'] = this.imagePath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}