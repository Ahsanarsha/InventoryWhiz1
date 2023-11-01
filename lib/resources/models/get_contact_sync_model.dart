import 'dart:convert';

GetContactSyncModel getContactSyncModelFromJson(String str) =>
    GetContactSyncModel.fromJson(json.decode(str));

class GetContactSyncModel {
  List<Users>? users;

  GetContactSyncModel({this.users});

  GetContactSyncModel.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

}

class Users {
  int? id;
  String? name;
  String? email;
  String? phoneNum;
  String? imageName;
  String? imagePath;

  Users(
      {this.id,
        this.name,
        this.email,
        this.phoneNum,
        this.imageName,
        this.imagePath});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNum = json['phone_num'];
    imageName = json['image_name'];
    imagePath = json['image_path'];
  }

}