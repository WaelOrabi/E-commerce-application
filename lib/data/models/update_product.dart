class UpdateProductModel {
  Product? product;
  String? facebookUrl;
  String? whatsappUrl;
  String? phoneNumber;
  int? likesNum;
  int? currentPrice;
  String? maxDiscount;
  bool? isLiked;

  UpdateProductModel(
      {this.product,
        this.facebookUrl,
        this.whatsappUrl,
        this.phoneNumber,
        this.likesNum,
        this.currentPrice,
        this.maxDiscount,
        this.isLiked});

  UpdateProductModel.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    facebookUrl = json['facebook_url'];
    whatsappUrl = json['whatsapp_url'];
    phoneNumber = json['phone_number'];
    likesNum = json['LikesNum'];
    currentPrice = json['current_price'];
    maxDiscount = json['max_discount'];
    isLiked = json['is_liked'];
  }
}

class Product {
  dynamic ? id;
  String? name;
  int? price;
  String? price1;
  String? price2;
  int? price3;
  String? description;
  String? imgUrl;
  String? quantity;
  int? views;
  String? expDate;
  String? saleDate1;
  String? saleDate2;
  String? saleDate3;
  String? categoryId;
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