import '../screens/cart_item/model/cart_model.dart';

class StaticData {

  static int? addressID = 0;
  static String? shippingName = '';
  static double? shippingFee = 0;
  static int? subTotalFinal = 0;
  static double? grandTotalFinal = 0;
  static List<CartModel> cartList = [];

  //todo::for reminder index
  static int reminderIndex = 0;
  //todo::for card url
  static String card_url ="";
}

class CardPurchase{

  static int? addressID = 0;
  static double? cardPrice;
  static String? shippingName = '';
  static double? shippingFee = 0;
  static int? subTotalFinal = 0;
  static double? grandTotalFinal = 0;
  static String? apneLiyeYaGroupMein;

}
