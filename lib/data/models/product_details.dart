class ProductDetails{
 late final String name;
 late final String image;
 late final String expirationDate;
late final  String category;
 late final List<dynamic> contactInformation;
late final  int availableQuantityOfTheProduct;
 late final List<dynamic>thePriceIsInThreePeriods;
static Map <String,dynamic> product=new Map<String, dynamic>();
  ProductDetails(this.name, this.image, this.expirationDate, this.category, this.contactInformation, this.availableQuantityOfTheProduct, this.thePriceIsInThreePeriods);
  ProductDetails.fromjson(Map<String,dynamic> json){
    name=json["name"];
    image=json["image"];
    expirationDate=json["expiration_date"];
    category=json["category"];
    contactInformation=json["contact_information"];
    availableQuantityOfTheProduct=json["available_QuantityOfTheProduct"];
    thePriceIsInThreePeriods=json["price_in_three_periods"];
  }
 ProductDetails.toJson( {required String name,
   required String image,
   required String expirationDate,
   required String category,
   required List<dynamic> contactInformation,
   required int availableQuantityOfTheProduct,
   required List<dynamic> thePriceIsInThreePeriods}) {
   product['name']=this.name;
  product['image']=this.image;
 product['expiration_date']=this.expirationDate;
  product['category']=this.category;
  product['contact_information']=this.contactInformation;
  product['available_QuantityOfTheProduct']=this.availableQuantityOfTheProduct;
  product['price_in_three_periods']=this.thePriceIsInThreePeriods;
 }

}
