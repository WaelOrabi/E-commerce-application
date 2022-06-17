class SearchProductModel {
  Product? product;
  String? categoryName;
  int? likesNum;
  int? currentPrice;
  int? maxDiscount;

  SearchProductModel(
      {this.product,
        this.categoryName,
        this.likesNum,
        this.currentPrice,
        this.maxDiscount});

  SearchProductModel.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    categoryName = json['category_name'];
    likesNum = json['LikesNum'];
    currentPrice = json['current_price'];
    maxDiscount = json['max_discount'];
  }

}

class Product {
  int? id;
  String? name;
  int? price;
  int? price1;
  int? price2;
  int? price3;
  String? description;
  String? imgUrl;
  int? quantity;
  int? views;
  String? expDate;
  String? saleDate1;
  String? saleDate2;
  String? saleDate3;
  int? categoryId;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
        this.name,
        this.price,
        this.price1,
        this.price2,
        this.price3,
        this.description,
        this.imgUrl,
        this.quantity,
        this.views,
        this.expDate,
        this.saleDate1,
        this.saleDate2,
        this.saleDate3,
        this.categoryId,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    price1 = json['price1'];
    price2 = json['price2'];
    price3 = json['price3'];
    description = json['description'];
    imgUrl = json['img_url'];
    quantity = json['quantity'];
    views = json['views'];
    expDate = json['exp_date'];
    saleDate1 = json['sale_date1'];
    saleDate2 = json['sale_date2'];
    saleDate3 = json['sale_date3'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}