import 'dart:convert';

GetInterestModel getInterestModelFromJson(String str) =>
    GetInterestModel.fromJson(json.decode(str));

class GetInterestModel {

  List<Interest>? interest;
  int? status;

  GetInterestModel({this.interest, this.status});

  GetInterestModel.fromJson(Map<String, dynamic> json) {
    if (json['interest'] != null) {
      interest = <Interest>[];
      json['interest'].forEach((v) {
        interest!.add(new Interest.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.interest != null) {
      data['interest'] = this.interest!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Interest {
  int? id;
  int? userId;
  String? title;
  String? createdAt;
  String? updatedAt;

  Interest({this.id, this.userId, this.title, this.createdAt, this.updatedAt});

  Interest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}