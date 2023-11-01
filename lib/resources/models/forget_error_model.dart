import 'dart:convert';
import 'package:http/src/response.dart';

ForgetErrorModel forgetErrorModelFromJson(Response response,String str) =>
    ForgetErrorModel.fromJson(response,json.decode(str));


class ForgetErrorModel {

  int? statusCode;
  String? message;
  Errors? errors;

  ForgetErrorModel({this.statusCode,this.message, this.errors});

  ForgetErrorModel.fromJson(Response response,Map<String, dynamic> json) {
    statusCode =response.statusCode;
    message = json['message'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

}

class Errors {
  List<String>? password;

  Errors({this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    password = json['password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    return data;
  }
}