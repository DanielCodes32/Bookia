double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

class CartItem {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductImage;
  String? itemProductPrice;
  int? itemProductDiscount;
  double? itemProductPriceAfterDiscount;
  int? itemProductStock;
  int? itemQuantity;
  double? itemTotal;

  CartItem({
    this.itemId,
    this.itemProductId,
    this.itemProductName,
    this.itemProductImage,
    this.itemProductPrice,
    this.itemProductDiscount,
    this.itemProductPriceAfterDiscount,
    this.itemProductStock,
    this.itemQuantity,
    this.itemTotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    itemId: _toInt(json['item_id']),
    itemProductId: _toInt(json['item_product_id']),
    itemProductName: json['item_product_name'] as String?,
    itemProductImage: json['item_product_image'] as String?,
    itemProductPrice: json['item_product_price']?.toString(),
    itemProductDiscount: _toInt(json['item_product_discount']),
    itemProductPriceAfterDiscount: _toDouble(
      json['item_product_price_after_discount'],
    ),
    itemProductStock: _toInt(json['item_product_stock']),
    itemQuantity: _toInt(json['item_quantity']),
    itemTotal: _toDouble(json['item_total']),
  );

  Map<String, dynamic> toJson() => {
    'item_id': itemId,
    'item_product_id': itemProductId,
    'item_product_name': itemProductName,
    'item_product_image': itemProductImage,
    'item_product_price': itemProductPrice,
    'item_product_discount': itemProductDiscount,
    'item_product_price_after_discount': itemProductPriceAfterDiscount,
    'item_product_stock': itemProductStock,
    'item_quantity': itemQuantity,
    'item_total': itemTotal,
  };
}
