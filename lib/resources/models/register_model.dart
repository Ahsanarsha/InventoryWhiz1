import 'dart:convert';
import 'package:http/src/response.dart';

RegisterModel registerModelFromJson(Response response,String str) =>
    RegisterModel.fromJson(response,json.decode(str));


class RegisterModel {
  int? statusCode;
  var status;
  String? message;
  Data? data;

  RegisterModel({this.statusCode,this.status, this.message, this.data});

  RegisterModel.fromJson(Response response,Map<String, dynamic> json) {
    statusCode=response.statusCode;
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;

  Data({this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}