class CartModel {
  int? addressID;
  int? shippingFee;
  int? subTotal;
  int? grandTotal;
  int? id;
  String? name;
  String? image;
  int? price;

  CartModel(
      {this.addressID,
      this.shippingFee,
      this.subTotal,
      this.grandTotal,
      this.id,
      this.name,
      this.image,
      this.price});
}
