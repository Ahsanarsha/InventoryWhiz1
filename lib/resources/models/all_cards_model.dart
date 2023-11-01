import 'dart:convert';

AllCardModel allCardsModelFromJson(String str) => AllCardModel.fromJson(json.decode(str));


class AllCardModel {

  Data? data;

  AllCardModel({this.data});

  AllCardModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<Cards>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Cards>[];
      json['data'].forEach((v) {
        data!.add(new Cards.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}

class Cards {
  int? id;
  int? cardCategoriesId;
  String? title;
  String? scope;
  String? imagePath;
  String? imageName;
  int? soldQuantity;
  int? qty;
  int? price;
  String? createdAt;
  String? updatedAt;

  Cards(
      {this.id,
        this.cardCategoriesId,
        this.title,
        this.scope,
        this.imagePath,
        this.imageName,
        this.soldQuantity,
        this.qty,
        this.price,
        this.createdAt,
        this.updatedAt});

  Cards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardCategoriesId = json['card_categories_id'];
    title = json['title'];
    scope = json['scope'];
    imagePath = json['image_path'];
    imageName = json['image_name'];
    soldQuantity = json['sold_quantity'];
    qty = json['qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
