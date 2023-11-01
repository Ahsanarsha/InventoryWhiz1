import 'dart:convert';

UserUpdateDetailModel userUpdateDetailModelFromJson(String str) =>
    UserUpdateDetailModel.fromJson(json.decode(str));


class UserUpdateDetailModel {

  String? message;
  User? user;

  UserUpdateDetailModel({this.message, this.user});

  UserUpdateDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? uuid;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? providerName;
  String? dob;
  String? role;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.uuid,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.providerName,
        this.dob,
        this.role,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    providerName = json['provider_name'];
    dob = json['dob'];
    role = json['role'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}