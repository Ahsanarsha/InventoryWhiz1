import 'package:http/src/response.dart';
import 'dart:convert';

RegisterErrorModel registerErrorModelFromJson(Response response,String str) =>
    RegisterErrorModel.fromJson(response,json.decode(str));

String registerErrorModelToJson(RegisterErrorModel data) => json.encode(data.toJson());

class RegisterErrorModel {
  int? statusCode;
  String? message;
  Errors? errors;

  RegisterErrorModel({this.statusCode,this.message, this.errors});

  RegisterErrorModel.fromJson(Response response,Map<String, dynamic> json) {
    statusCode=response.statusCode;
    message = json['message'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? email;

  Errors({this.email});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}