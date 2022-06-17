import 'package:flutter/material.dart';
import 'package:languages_project/data/models/get_all_products_from_category.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/modules/all_categories/components/product_detail_page_for_products_category.dart';
import 'package:languages_project/shared/components/search_products.dart';
import 'package:languages_project/shared_preferences.dart';

class ProductsPageForEachCtegory extends StatefulWidget {
final List<GetAllProductsFromCategoryModel> ? getAllProducts;
  ProductsPageForEachCtegory({Key? key, this.getAllProducts}) : super(key: key);

  @override
  State<ProductsPageForEachCtegory> createState() => _ProductsPageForEachCtegoryState();
}

class _ProductsPageForEachCtegoryState extends State<ProductsPageForEachCtegory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAF8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Shop now',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF545D68)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return const Search();
              }));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: GridView.count(
          crossAxisCount: 2,
          primary: false,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 0.7,
          children: <Widget>[
          ...widget.getAllProducts!.map((allProducts) {
            return _buildCard(name:allProducts.product!.name!,
                price:allProducts.product!.price!,
                imgPath:allProducts.product!.imgUrl!,
              price1:allProducts.product!.price1!,
              price2:allProducts.product!.price2!,
              price3:allProducts.product!.price3!,
                quantity:allProducts.product!.quantity!,
              views:allProducts.product!.views!,
                description:allProducts.product!.description!,
                exp_date:allProducts.product!.expDate!,
                sale_date1:allProducts.product!.saleDate1!,
              sale_date2:allProducts.product!.saleDate2!,
              sale_date3:allProducts.product!.saleDate3!,
                created_at:allProducts.product!.createdAt!,
                updated_at:allProducts.product!.updatedAt!,
                LikesNum:allProducts.likesNum!,
                current_price:allProducts.currentPrice!,
                max_discount:allProducts.maxDiscount!,
              getAllProducts: allProducts,
               );
          })
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required dynamic name,required dynamic price,required dynamic imgPath,
    required dynamic price1,required dynamic price2,required dynamic price3,
    required dynamic quantity,
    required dynamic views,
    required dynamic description,
    required dynamic exp_date,
    required dynamic sale_date1,
    required dynamic sale_date2,
    required dynamic sale_date3,
    required dynamic created_at,
    required dynamic updated_at,
    required dynamic LikesNum,
    required dynamic current_price,
    required dynamic max_discount,
    required GetAllProductsFromCategoryModel getAllProducts,
  }) {
    return Stack(
      children: [
        Padding(
            padding:
                const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
            child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductsPageDetailsCategoryHomePage(getAllProductsFromCategoryModel:getAllProducts)));
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3.0,
                              blurRadius: 5.0)
                        ],
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Column(children: [

                        Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage('$baseUrl1/products/$imgPath'),
                                    fit: BoxFit.cover))),
                        SizedBox(height: 7.0),
                        Text('\$$price',
                            style: TextStyle(
                                color: Color(0xFFCC8053),
                                fontFamily: 'Varela',
                                fontSize: 14.0)),
                        Text(name,
                            style: TextStyle(
                                color: Color(0xFF575E67),
                                fontFamily: 'Varela',
                                fontSize: 14.0)),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                        Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                    Icon(Icons.visibility ,
                                        color: Color(0xFFD17E50), size: 12.0),
                                    Text('${getAllProducts.product!.views}',
                                        style: TextStyle(
                                            fontFamily: 'Varela',
                                            color: Color(0xFFD17E50),
                                            fontSize: 12.0))
                                ]))
                      ]
                        ),
                    )
            ))),
//         Padding(
//           padding: EdgeInsets.only(left:5,top: 5,right: 5),
//           child: Container(
//             width: double.infinity,
//             height: 40,
//             color: Colors.black.withOpacity(0.1),
//             child:Padding(
//                 padding: EdgeInsets.all(5.0),
//                 child: Row(
//                     children: [
// if(SharedPref.getData(key:'icon')!=null)
//   Icon(SharedPref.getData(key:'icon'),color: Color(0xFFEF7532)),
//             if(SharedPref.getData(key:'icon')==null)
//                       Icon(Icons.favorite_border,color: Color(0xFFEF7532) ,),
//
//
//                     ])),
//           ),
//         ),
      ],
    );
  }
}
