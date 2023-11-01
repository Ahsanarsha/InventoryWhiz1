import 'dart:convert';

GetReminderModel getReminderModelFromJson(String str) =>
    GetReminderModel.fromJson(json.decode(str));


class GetReminderModel {

  List<Reminders>? reminders;

  GetReminderModel({this.reminders});

  GetReminderModel.fromJson(Map<String, dynamic> json) {
    if (json['reminders'] != null) {
      reminders = <Reminders>[];
      json['reminders'].forEach((v) {
        reminders!.add(new Reminders.fromJson(v));
      });
    }
  }

}

class Reminders {
  int? id;
  int? userId;
  String? title;
  String? dateTime;
  String? createdAt;
  String? updatedAt;
  List<Contacts>? contacts;
  List<Gifts>? gifts;
  List<Relations>? relations;
  List<Cards>? cards;
  List<Groups>? groups;

  Reminders(
      {this.id,
        this.userId,
        this.title,
        this.dateTime,
        this.createdAt,
        this.updatedAt,
        this.contacts,
        this.gifts,
        this.relations,
        this.cards,
        this.groups});

  Reminders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    dateTime = json['date_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new Contacts.fromJson(v));
      });
    }
    if (json['gifts'] != null) {
      gifts = <Gifts>[];
      json['gifts'].forEach((v) {
        gifts!.add(new Gifts.fromJson(v));
      });
    }
    if (json['relations'] != null) {
      relations = <Relations>[];
      json['relations'].forEach((v) {
        relations!.add(new Relations.fromJson(v));
      });
    }
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards!.add(new Cards.fromJson(v));
      });
    }
    if (json['groups'] != null) {
      groups = <Groups>[];
      json['groups'].forEach((v) {
        groups!.add(new Groups.fromJson(v));
      });
    }
  }

}

class Contacts {
  int? id;
  int? userId;
  String? name;
  String? nickName;
  String? email;
  String? streetAddress1;
  String? streetAddress2;
  String? address;
  String? postalCode;
  int? countryId;
  int? stateId;
  int? cityId;
  String? imagePath;
  String? imageName;
  String? phoneNum;
  String? createdAt;
  String? updatedAt;

  Contacts(
      {this.id,
        this.userId,
        this.name,
        this.nickName,
        this.email,
        this.streetAddress1,
        this.streetAddress2,
        this.address,
        this.postalCode,
        this.countryId,
        this.stateId,
        this.cityId,
        this.imagePath,
        this.imageName,
        this.phoneNum,
        this.createdAt,
        this.updatedAt});

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    nickName = json['nick_name'];
    email = json['email'];
    streetAddress1 = json['street_address1'];
    streetAddress2 = json['street_address2'];
    address = json['address'];
    postalCode = json['postal_code'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    imagePath = json['image_path'];
    imageName = json['image_name'];
    phoneNum = json['phone_num'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class Gifts {
  int? id;
  int? giftCategoriesId;
  String? title;
  String? imagePath;
  String? imageName;
  int? qty;
  int? price;
  String? createdAt;
  String? updatedAt;

  Gifts(
      {this.id,
        this.giftCategoriesId,
        this.title,
        this.imagePath,
        this.imageName,
        this.qty,
        this.price,
        this.createdAt,
        this.updatedAt});

  Gifts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    giftCategoriesId = json['gift_categories_id'];
    title = json['title'];
    imagePath = json['image_path'];
    imageName = json['image_name'];
    qty = json['qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class Relations {
  int? id;
  int? userId;
  String? title;
  String? createdAt;
  String? updatedAt;

  Relations(
      {this.id,
        this.userId,
        this.title,
        this.createdAt,
        this.updatedAt});

  Relations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class Cards {
  int? id;
  int? cardCategoriesId;
  String? title;
  String? imagePath;
  String? imageName;
  int? qty;
  int? price;
  String? createdAt;
  String? updatedAt;

  Cards(
      {this.id,
        this.cardCategoriesId,
        this.title,
        this.imagePath,
        this.imageName,
        this.qty,
        this.price,
        this.createdAt,
        this.updatedAt});

  Cards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardCategoriesId = json['card_categories_id'];
    title = json['title'];
    imagePath = json['image_path'];
    imageName = json['image_name'];
    qty = json['qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class Groups {
  int? id;
  int? userId;
  String? title;
  String? imageName;
  String? imagePath;
  String? createdAt;
  String? updatedAt;

  Groups(
      {this.id,
        this.userId,
        this.title,
        this.imageName,
        this.imagePath,
        this.createdAt,
        this.updatedAt});

  Groups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    imageName = json['image_name'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['image_name'] = this.imageName;
    data['image_path'] = this.imagePath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



