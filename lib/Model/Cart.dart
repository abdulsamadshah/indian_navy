class Cart {
  late final int? id;
  final String? productid;
  final String productname;
  final String productimage;
  final String? productprice;
  final String? finaltotalprice;
  final int? quantity;
  final int? pack_size;
  final int? userid;

  Cart({
    required this.id,
    required this.productid,
    required this.productname,
    required this.productimage,
    required this.productprice,
    required this.finaltotalprice,
    required this.quantity,
    required this.pack_size,
    required this.userid,
  });

  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        productid = res['productid'],
        productname = res['productname'],
        productimage = res['productimage'],
        productprice = res['productprice'],
        finaltotalprice = res['finaltotalprice'],
        quantity = res['quantity'],
        pack_size = res['pack_size'],
        userid = res['userid'];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "productid": productid,
      "productname": productname,
      "productimage": productimage,
      "productprice": productprice,
      "finaltotalprice": finaltotalprice,
      "quantity": quantity,
      "pack_size": pack_size,
      "userid": userid,
    };
  }
}
