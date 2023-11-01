import 'dart:convert';

PdfModel pdfModelFromJson(String str) => PdfModel.fromJson(json.decode(str));


class PdfModel {

  Data? data;
  String? message;
  int? status;

  PdfModel({this.data, this.message, this.status});

  PdfModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  String? uuid;
  int? userId;
  String? imageType;
  String? imagePath;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.uuid,
        this.userId,
        this.imageType,
        this.imagePath,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userId = json['user_id'];
    imageType = json['image_type'];
    imagePath = json['image_path'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}