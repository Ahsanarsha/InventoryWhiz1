import 'dart:convert';
import 'package:http/src/response.dart';

LoginErrorModel loginErrorModelFromJson(Response response,String str) =>
    LoginErrorModel.fromJson(response,json.decode(str));


class LoginErrorModel {
  int? statusCode;
  String? message;

  LoginErrorModel({this.statusCode,this.message});

  LoginErrorModel.fromJson(Response response,Map<String, dynamic> json) {
    statusCode=response.statusCode;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}