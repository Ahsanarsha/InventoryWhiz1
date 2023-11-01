import 'dart:convert';
import 'package:http/src/response.dart';

GetShippingRatesModel getShippingRatesModelFromJson(Response response,String str) =>
    GetShippingRatesModel.fromJson(response,json.decode(str));

class GetShippingRatesModel {

  ShippingRates? shippingRates;
  int? status;
  int? statusCode;

  GetShippingRatesModel({this.statusCode,this.shippingRates, this.status});

  GetShippingRatesModel.fromJson(Response response,Map<String, dynamic> json) {
    statusCode =response.statusCode;
    shippingRates = json['shipping_rates'] != null
        ? new ShippingRates.fromJson(json['shipping_rates'])
        : null;
    status = json['status'];
  }

}

class ShippingRates {
  List<Rates>? rates;
  int? lowestOrSelectedRateIndex;

  ShippingRates({this.rates, this.lowestOrSelectedRateIndex});

  ShippingRates.fromJson(Map<String, dynamic> json) {
    if (json['rates'] != null) {
      rates = <Rates>[];
      json['rates'].forEach((v) {
        rates!.add(new Rates.fromJson(v));
      });
    }
    lowestOrSelectedRateIndex = json['lowest_or_selected_rate_index'];
  }

}

class Rates {
  String? enc;
  String? service;
  var rate;
  bool? selected;

  Rates({this.enc, this.service, this.rate, this.selected});

  Rates.fromJson(Map<String, dynamic> json) {
    enc = json['enc'];
    service = json['service'];
    rate = json['rate'];
    selected = json['selected'];
  }

}