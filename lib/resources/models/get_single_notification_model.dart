import 'dart:convert';

GetSingleNotificationModel getSingleNotificationModelFromJson(String str) =>
    GetSingleNotificationModel.fromJson(json.decode(str));

class GetSingleNotificationModel {
  Notification? notification;

  GetSingleNotificationModel({this.notification});

  GetSingleNotificationModel.fromJson(Map<String, dynamic> json) {
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
  }
}

class Notification {
  int? id;
  String? type;
  int? userId;
  int? orderId;
  Null? invoiceId;
  int? orderStatus;
  String? subject;
  String? message;
  String? emailSent;
  String? viewed;
  String? dismissed;
  String? alertType;
  Null? redirectLink;
  String? createdAt;
  String? updatedAt;

  Notification(
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

  Notification.fromJson(Map<String, dynamic> json) {
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