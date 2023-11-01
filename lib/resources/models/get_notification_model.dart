import 'dart:convert';

GetNotificationModel getNotificationModelFromJson(String str) =>
    GetNotificationModel.fromJson(json.decode(str));

class GetNotificationModel {

  int? unviewedCount;
  List<NotificationData>? notification;

  GetNotificationModel({this.unviewedCount, this.notification});

  GetNotificationModel.fromJson(Map<String, dynamic> json) {
    unviewedCount = json['unviewedCount'];
    if (json['notification'] != null) {
      notification = <NotificationData>[];
      json['notification'].forEach((v) {
        notification!.add(new NotificationData.fromJson(v));
      });
    }
  }

}

class NotificationData {
  int? id;
  String? type;
  int? userId;
  int? orderId;
  String? invoiceId;
  int? orderStatus;
  String? subject;
  String? message;
  String? emailSent;
  int? viewed;
  String? dismissed;
  String? alertType;
  String? redirectLink;
  String? createdAt;
  String? updatedAt;

  NotificationData(
      {this.id,
        this.type,
        this.userId,
        this.orderId,
        this.invoiceId,
        this.orderStatus,
        this.subject,
        this.message,
        this.emailSent,
        this.viewed,
        this.dismissed,
        this.alertType,
        this.redirectLink,
        this.createdAt,
        this.updatedAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    orderId = json['order_id'];
    invoiceId = json['invoice_id'];
    orderStatus = json['order_status'];
    subject = json['subject'];
    message = json['message'];
    emailSent = json['email_sent'];
    viewed = json['viewed'];
    dismissed = json['dismissed'];
    alertType = json['alert_type'];
    redirectLink = json['redirect_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}