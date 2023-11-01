import 'dart:convert';
import 'package:http/src/response.dart';

CommonModel commonModelFromJson(Response response, String str) =>
    CommonModel.fromJson(response, json.decode(str));

class CommonModel {
  int? statusCode;
  String? message;
  int? status;
  Errors? errors;

  CommonModel({this.statusCode, this.message, this.status});

  CommonModel.fromJson(Response response, Map<String, dynamic> json) {
    statusCode = response.statusCode;
    message = json['message'];
    status = json['status'];
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
