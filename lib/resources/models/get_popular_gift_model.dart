import 'dart:convert';

GetPopularGiftModel getPopularGiftFromJson(String str) =>
    GetPopularGiftModel.fromJson(json.decode(str));


class GetPopularGiftModel {
  PopularGifts? popularGifts;

  GetPopularGiftModel({this.popularGifts});

  GetPopularGiftModel.fromJson(Map<String, dynamic> json) {
    popularGifts = json['popularGifts'] != null
        ? new PopularGifts.fromJson(json['popularGifts'])
        : null;
  }
}

class PopularGifts {
  int? currentPage;
  List<DataModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  PopularGifts(
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

  PopularGifts.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(new DataModel.fromJson(v));
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

class DataModel {
  int? id;
  int? giftCategoriesId;
  String? title;
  String? imagePath;
  String? imageName;
  int? soldQuantity;
  int? qty;
  int? price;
  String? createdAt;
  String? updatedAt;
  List<Wishlist>? wishlist;

  DataModel(
      {this.id,
        this.giftCategoriesId,
        this.title,
        this.imagePath,
        this.imageName,
        this.soldQuantity,
        this.qty,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.wishlist});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    giftCategoriesId = json['gift_categories_id'];
    title = json['title'];
    imagePath = json['image_path'];
    imageName = json['image_name'];
    soldQuantity = json['sold_quantity'];
    qty = json['qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(new Wishlist.fromJson(v));
      });
    }
  }

}

class Wishlist {
  int? id;
  int? userId;
  Null? cardId;
  int? giftId;
  String? createdAt;
  String? updatedAt;

  Wishlist(
      {this.id,
        this.userId,
        this.cardId,
        this.giftId,
        this.createdAt,
        this.updatedAt});

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cardId = json['card_id'];
    giftId = json['gift_id'];
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
}