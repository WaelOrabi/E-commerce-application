import 'package:flutter/material.dart';
import 'package:languages_project/data/models/get_all_products.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/modules/all_categories/components/product_detail_page_for_products_category.dart';
import 'package:languages_project/modules/home/components/product_details_page_for_product_home.dart';

class ProductsPage extends StatefulWidget {
  final List<GetAllProductsModel>? getAllProductsModel;

  const ProductsPage({Key? key, this.getAllProductsModel}) : super(key: key);

  @override
  State<ProductsPage> createState() =>
      _ProductsPageState(getAllProductsModel: getAllProductsModel!);
}

class _ProductsPageState extends State<ProductsPage> {
  final List<GetAllProductsModel>? getAllProductsModel;

  _ProductsPageState({required this.getAllProductsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: Container(
          padding: EdgeInsets.only(right: 15.0, left: 15, top: 15),
          child: GridView.count(
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: 0.8,
            children: <Widget>[
              ...widget.getAllProductsModel!.map((products) {
                return _buildCard(
                    name: products.product!.name!,
                    context: context,
                    description: products.product!.description!,
                    getAllProductsModel: products,
                    imgPath: products.product!.imgUrl!);
              })
            ],
          )),
    );
  }

  Widget _buildCard(
      {required String name,
      required String description,
      required String imgPath,
      required GetAllProductsModel getAllProductsModel,
      context,
      double height = 0}) {
    return Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 0.0, left: 10.0, right: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductsPageDetailsHomePage(
                            getAllProductsModel: getAllProductsModel,
                          )));
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
              child: Column(
                children: [
                  SizedBox(
                    height: 43,
                  ),
                  Container(
                      height: 140.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(
                          '$baseUrl1/products/${imgPath}',
                        ),
                        fit: BoxFit.cover,
                      ))),
                  SizedBox(height: height),
                  Text(name,
                      style: const TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 18.0)),
                ],
              ),
            )));
  }
}
