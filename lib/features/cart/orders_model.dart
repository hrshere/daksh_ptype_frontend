class OrdersModel {
  int? totalQuantity;
  int? totalPrice;
  List<OrderProducts>? orderProducts;
  String? userEmail;

  OrdersModel(
      {this.totalQuantity,
        this.totalPrice,
        this.orderProducts,
        this.userEmail});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    totalQuantity = json['total_quantity'];
    totalPrice = json['total_price'];
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(new OrderProducts.fromJson(v));
      });
    }
    userEmail = json['user_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_quantity'] = this.totalQuantity;
    data['total_price'] = this.totalPrice;
    if (this.orderProducts != null) {
      data['order_products'] =
          this.orderProducts!.map((v) => v.toJson()).toList();
    }
    data['user_email'] = this.userEmail;
    return data;
  }
}

class OrderProducts {
  int? product;
  int? quantity;

  OrderProducts({this.product, this.quantity});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['quantity'] = this.quantity;
    return data;
  }
}
