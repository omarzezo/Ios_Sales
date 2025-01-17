class ProductModel {
  int? id;
  String? productName;
  String? productAmount;
  String? productPrice;


  ProductModel(
      int id,
      String productName,
      String productAmount,
      String productPrice,
      ) {
    this.id = id;
    this.productName = productName;
    this.productAmount = productAmount;
    this.productPrice = productPrice;
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    productAmount = json['productAmount'];
    productPrice = json['productPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productName'] = this.productName;
    data['productAmount'] = this.productAmount;
    data['productPrice'] = this.productPrice;
    return data;
  }
}