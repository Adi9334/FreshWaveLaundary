class CouponModel {
  final discounttype;
  final discount;
  final ordertype;
  final minimumorder;
  final code;
  final expirydate;
  final imagePath;

  CouponModel(
      {this.discounttype,
      this.discount,
      this.ordertype,
      this.minimumorder,
      this.code,
      this.expirydate,
      this.imagePath});

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
        discounttype: json['coupon_discount_type'],
        discount: json['coupon_discount'],
        ordertype: json['coupon_order_type'],
        minimumorder: json['coupon_minium_order'],
        code: json['coupon_code'],
        expirydate: json['coupon_expiry_date'],
        imagePath: json['coupon_imageURL']);
  }
}
