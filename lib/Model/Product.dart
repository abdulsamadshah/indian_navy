class Product {
  List<ProductDetails>? productDetails;
  String? status;

  Product({this.productDetails, this.status});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class ProductDetails {
  String? productId;
  String? productName;
  String? categoryId;
  String? subCategoryId;
  String? imageName;
  Null? gst;
  String? stockQty;
  String? packSize;
  String? price;
  String? packSize1;
  String? price1;
  String? unitName;
  String? description;
  String? termsConditions;
  String? hsnCode;
  String? vendorSku;
  String? sku2;
  String? mrp;
  String? buyingPrice;
  String? approval;
  String? returnPolicy;
  String? isPrime;

  ProductDetails(
      {this.productId,
      this.productName,
      this.categoryId,
      this.subCategoryId,
      this.imageName,
      this.gst,
      this.stockQty,
      this.packSize,
      this.price,
      this.packSize1,
      this.price1,
      this.unitName,
      this.description,
      this.termsConditions,
      this.hsnCode,
      this.vendorSku,
      this.sku2,
      this.mrp,
      this.buyingPrice,
      this.approval,
      this.returnPolicy,
      this.isPrime});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    imageName = json['image_name'];
    gst = json['gst'];
    stockQty = json['stock_qty'];
    packSize = json['pack_size'];
    price = json['price'];
    packSize1 = json['pack_size1'];
    price1 = json['price1'];
    unitName = json['unit_name'];
    description = json['description'];
    termsConditions = json['terms_conditions'];
    hsnCode = json['hsn_code'];
    vendorSku = json['vendor_sku'];
    sku2 = json['sku2'];
    mrp = json['Mrp'];
    buyingPrice = json['buying_price'];
    approval = json['approval'];
    returnPolicy = json['return_policy'];
    isPrime = json['is_prime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['image_name'] = this.imageName;
    data['gst'] = this.gst;
    data['stock_qty'] = this.stockQty;
    data['pack_size'] = this.packSize;
    data['price'] = this.price;
    data['pack_size1'] = this.packSize1;
    data['price1'] = this.price1;
    data['unit_name'] = this.unitName;
    data['description'] = this.description;
    data['terms_conditions'] = this.termsConditions;
    data['hsn_code'] = this.hsnCode;
    data['vendor_sku'] = this.vendorSku;
    data['sku2'] = this.sku2;
    data['Mrp'] = this.mrp;
    data['buying_price'] = this.buyingPrice;
    data['approval'] = this.approval;
    data['return_policy'] = this.returnPolicy;
    data['is_prime'] = this.isPrime;
    return data;
  }
}