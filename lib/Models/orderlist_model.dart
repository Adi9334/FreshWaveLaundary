class orderlist_model {
  final name;
  final order_id;
  final order_date;
  final order_status;
  final List<OrderItem>? item;
  final amount;
  final order_tax;
  final order_mrp;
  final order_total_afterdis;
  final order_discount;
  final order_promocode;
  final order_delivery_charges;
  final order_handling_charges;
  final order_total_price;
  final order_payment_mode;
  final order_delivery_type;
  final order_delivery_slot;
  final order_delivered_at;

  orderlist_model(
      {required this.name,
      required this.order_id,
      required this.order_date,
      required this.order_status,
      this.item,
      required this.amount,
      required this.order_tax,
      required this.order_mrp,
      required this.order_total_afterdis,
      required this.order_discount,
      required this.order_promocode,
      required this.order_delivery_charges,
      required this.order_handling_charges,
      required this.order_total_price,
      required this.order_payment_mode,
      required this.order_delivery_type,
      required this.order_delivery_slot,
      required this.order_delivered_at});

  factory orderlist_model.fromJson(Map<String, dynamic> json) {
    return orderlist_model(
        name: json['service_name'],
        order_id: json['id'],
        order_date: json['order_date'],
        order_status: json['order_status'],
        item: (json['order_items'] as List)
            .map((item) => OrderItem.fromJson(item))
            .toList(),
        amount: json['total_price'],
        order_tax: json['order_tax'],
        order_mrp: json['order_mrp'],
        order_total_afterdis: json['order_total_afterdis'],
        order_discount: json['order_discount'],
        order_promocode: json['order_promocode'],
        order_delivery_charges: json['order_delivery_charges'],
        order_handling_charges: json['order_handling_charges'],
        order_total_price: json['order_total_price'],
        order_payment_mode: json['order_payment_mode'],
        order_delivery_type: json['order_delivery_type'],
        order_delivery_slot: json['order_delivery_slot'],
        order_delivered_at: json['order_delivered_at']);
  }
}

class OrderItem {
  final itemID;
  final itemName;
  final itemQuantity;
  final itemAmount;
  final itemImage;

  OrderItem({
    required this.itemID,
    required this.itemName,
    required this.itemQuantity,
    required this.itemAmount,
    required this.itemImage,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        itemID: json['item_id'],
        itemName: json['order_item_name'],
        itemQuantity: json['order_item_quantity'],
        itemAmount: json['order_item_price'],
        itemImage: json['order_item_imageURL']);
  }
}
