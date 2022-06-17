
class GetAllProductsFromCategoryModel{
  Product ? product;
  int ? likesNum;
  var currentPrice;
 dynamic ? maxDiscount;
  GetAllProductsFromCategoryModel.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    likesNum = json['LikesNum'];
    currentPrice = json['current_price']*1.0;
    maxDiscount = json['max_discount'];
  }
}

class Product {
  int ? id;
  String ? name;
  var price;
  var price1;
  var price2;
  var price3;
  String ? description;
  String ? imgUrl;
  int ? quantity;
  int ? views;
  String ? expDate;
  String ? saleDate1;
  String ? saleDate2;
  String ? saleDate3;
  int ? categoryId;
  int ? userId;
  String ? createdAt;
  String ? updatedAt;
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price']*1.0;
    price1 = json['price1']*1.0;
    price2 = json['price2']*1.0;
    price3 = json['price3']*1.0;
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