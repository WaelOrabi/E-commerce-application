import 'package:flutter/material.dart';
import 'package:languages_project/data/models/show_my_products.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/modules/profile/components/page_detalis_my_products.dart';
import 'package:languages_project/shared/components/bottom_bar.dart';
import 'package:languages_project/modules/all_categories/components/product_detail_page_for_products_category.dart';
import 'package:languages_project/shared/components/search_products.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class MyProducts extends StatefulWidget {
  static String routeName = "/show_my_products";
  final List<ShowMyProductsModel>? showMyProductsModel;

  const MyProducts({Key? key, required this.showMyProductsModel})
      : super(key: key);

  @override
  State<MyProducts> createState() => _MyProductsState(showMyProductsModel);
}

class _MyProductsState extends State<MyProducts> {
  final List<ShowMyProductsModel>? showMyProductsModel;
  final controllerAppBar = ScrollController();
  _MyProductsState(this.showMyProductsModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controllerAppBar,
        iconTheme: IconThemeData(color: Color(0xFF545D68)),
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Shop now',
          style: TextStyle(
              fontFamily: 'Varela', fontSize: 20, color: Color(0xFF545D68)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return Search();
                  }),
                );
              },
              icon: Icon(Icons.search, color: Color(0xFF545D68)))
        ],
      ),
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
              ...widget.showMyProductsModel!.map((myProducts) {
                return _buildCard(
                    myProducts.product!.name!,
                    myProducts.product!.price!,
                    myProducts.product!.imgUrl!,
                    myProducts.product!.views!,
                    myProducts,
                    myProducts.likesNum!,
                    context);
              })
            ],
          )),
      bottomNavigationBar: BottomBar(
        selectedMenu: MenuState.myProducts,
        type: MyProducts.routeName,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.fastfood),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildCard(String name, int price, String imgPath, int views,
  ShowMyProductsModel showMyProductsModel, int LikesNum, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder:(context)=>
                 MyProductsPageDetailsHomePage(showMyProductsModel: showMyProductsModel,)
             ));
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
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(top: 50),
                    ),
                  Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage('$baseUrl1/products/$imgPath'),
                              fit: BoxFit.cover))),
                  SizedBox(height: 7.0),
                  Text('${price}',
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Text(name,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),

                ]))));
  }
}
