class AddProduct {
  Product ? product;
  int  ? likesNum;
  bool ? isLiked;
  int ? currentPrice;
  String ? maxDiscount;
  String ? message;

  AddProduct(
      {this.product,
        this.likesNum,
        this.isLiked,
        this.currentPrice,
        this.maxDiscount,
        this.message});

  AddProduct.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ?  Product.fromJson(json['product']) : null;
    likesNum = json['LikesNum'];
    isLiked = json['is_liked'];
    currentPrice = json['current_price'];
    maxDiscount = json['max_discount'];
    message = json['message'];
  }
}

class Product {
  String ? name;
  String ? price;
  String ? expDate;
  String ? categoryId;
  String ? saleDate1;
  String ? saleDate2;
  String ? saleDate3;
  String ? price1;
  String ? price2;
  String ? price3;
  String ? quantity;
  int ? userId;
  String ? imgUrl;
  String ? updatedAt;
  String ? createdAt;
  int ? id;

  Product(
      {this.name,
        this.price,
        this.expDate,
        this.categoryId,
        this.saleDate1,
        this.saleDate2,
        this.saleDate3,
        this.price1,
        this.price2,
        this.price3,
        this.quantity,
        this.userId,
        this.imgUrl,
        this.updatedAt,
        this.createdAt,
        this.id});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    expDate = json['exp_date'];
    categoryId = json['category_id'];
    saleDate1 = json['sale_date1'];
    saleDate2 = json['sale_date2'];
    saleDate3 = json['sale_date3'];
    price1 = json['price1'];
    price2 = json['price2'];
    price3 = json['price3'];
    quantity = json['quantity'];
    userId = json['user_id'];
    imgUrl = json['img_url'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}