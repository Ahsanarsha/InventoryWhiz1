import 'dart:convert';
import 'package:http/src/response.dart';

LoginModel loginModelFromJson(Response response,String str) =>
    LoginModel.fromJson(response,json.decode(str));

class LoginModel {

  int? statusCode;
  String? message;
  String? token;

  LoginModel({this.statusCode,this.message, this.token});

  LoginModel.fromJson(Response response,Map<String, dynamic> json) {
    statusCode =response.statusCode;
    message = json['message'];
    token = json['token'];
  }
}