class Orderlist {
  late final int? cartid;
  final String? order_number;
  final String customer_name;
  final String customer_address;
  final String? Sub_total;
  final String? total_amount;
  final String? product_name;
  final String? status;
  final String? Deliverytime;
  final int? qty;
  final int? Rate;
  final int? Total;

  Orderlist({
    required this.cartid,
    required this.order_number,
    required this.customer_name,
    required this.customer_address,
    required this.Sub_total,
    required this.total_amount,
    required this.product_name,
    required this.status,
    required this.Deliverytime,
    required this.qty,
    required this.Rate,
    required this.Total,
  });

  Orderlist.fromMap(Map<dynamic, dynamic> res)
      : cartid = res['cartid'],
        order_number = res['order_number'],
        customer_name = res['customer_name'],
        customer_address = res['customer_address'],
        Sub_total = res['Sub_total'],
        total_amount = res['total_amount'],
        product_name = res['product_name'],
        status = res['status'],
        Deliverytime = res['Deliverytime'],
        qty = res['qty'],
        Rate = res['Rate'],
        Total = res['Total'];

  Map<String, Object?> toMap() {
    return {
      "cartid": cartid,
      "order_number": order_number,
      "customer_name": customer_name,
      "customer_address": customer_address,
      "Sub_total": Sub_total,
      "total_amount": total_amount,
      "product_name": product_name,
      "status": status,
      "Deliverytime": Deliverytime,
      "qty": qty,
      "Rate": Rate,
      "Total": Total,
    };
  }
}
