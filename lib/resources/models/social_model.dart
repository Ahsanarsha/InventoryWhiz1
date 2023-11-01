import 'dart:convert';

SocialModel socialModelFromJson(String str) =>
    SocialModel.fromJson(json.decode(str));

class SocialModel {

  bool? success;
  String? token;
  String? message;

  SocialModel({this.success, this.token,this.message});

  SocialModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}