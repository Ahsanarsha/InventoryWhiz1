import 'dart:convert';

GetRelationModel getRelationModelFromJson(String str) =>
    GetRelationModel.fromJson(json.decode(str));



class GetRelationModel {
  List<RelationData>? relation;

  GetRelationModel({this.relation});

  GetRelationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      relation = <RelationData>[];
      json['data'].forEach((v) {
        relation!.add(new RelationData.fromJson(v));
      });
    }
  }

}

class RelationData {
  int? id;
  int? userId;
  String? title;
  String? createdAt;
  String? updatedAt;

  RelationData({this.id, this.userId, this.title, this.createdAt, this.updatedAt});

  RelationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}