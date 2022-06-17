import 'package:flutter/material.dart';
import 'package:languages_project/modules/all_categories/components/products_page_for_each_category.dart';
import 'package:languages_project/modules/all_categories/components/product_detail_page_for_products_category.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: GridView.count(
        crossAxisCount: 2,
        primary: false,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 0.9,
        children: <Widget>[
          _buildCard('Cookie mint', '\$3.99', 'assets/images/cookiemint.jpg',
              false, false, context),
          _buildCard('Cookie cream', '\$5.99', 'assets/images/cookiecream.jpg',
              true, false, context),
          _buildCard('Cookie classic', '\$1.99',
              'assets/images/cookieclassic.jpg', false, true, context),
          _buildCard('Cookie choco', '\$2.99', 'assets/images/cookiechoco.jpg',
              false, false, context),
          _buildCard('Cookie mint', '\$3.99', 'assets/images/cookiemint.jpg',
              false, false, context),
          _buildCard('Cookie cream', '\$5.99', 'assets/images/cookiecream.jpg',
              true, false, context),
          _buildCard('Cookie classic', '\$1.99',
              'assets/images/cookieclassic.jpg', false, true, context),
          _buildCard('Cookie choco', '\$2.99', 'assets/images/cookiechoco.jpg',
              false, false, context),
          _buildCard('Cookie mint', '\$3.99', 'assets/images/cookiemint.jpg',
              false, false, context),
          _buildCard('Cookie cream', '\$5.99', 'assets/images/cookiecream.jpg',
              true, false, context),
          _buildCard('Cookie classic', '\$1.99',
              'assets/images/cookieclassic.jpg', false, true, context),
          _buildCard('Cookie choco', '\$2.99', 'assets/images/cookiechoco.jpg',
              false, false, context),
          _buildCard('Cookie mint', '\$3.99', 'assets/images/cookiemint.jpg',
              false, false, context),
          _buildCard('Cookie cream', '\$5.99', 'assets/images/cookiecream.jpg',
              true, false, context),
          _buildCard('Cookie classic', '\$1.99',
              'assets/images/cookieclassic.jpg', false, true, context),
          _buildCard('Cookie choco', '\$2.99', 'assets/images/cookiechoco.jpg',
              false, false, context),
          _buildCard('Cookie mint', '\$3.99', 'assets/images/cookiemint.jpg',
              false, false, context),
          _buildCard('Cookie cream', '\$5.99', 'assets/images/cookiecream.jpg',
              true, false, context),
          _buildCard('Cookie classic', '\$1.99',
              'assets/images/cookieclassic.jpg', false, true, context),
          _buildCard('Cookie choco', '\$2.99', 'assets/images/cookiechoco.jpg',
              false, false, context),
          _buildCard('Cookie mint', '\$3.99', 'assets/images/cookiemint.jpg',
              false, false, context),
          _buildCard('Cookie cream', '\$5.99', 'assets/images/cookiecream.jpg',
              true, false, context),
          _buildCard('Cookie classic', '\$1.99',
              'assets/images/cookieclassic.jpg', false, true, context),
          _buildCard('Cookie choco', '\$2.99', 'assets/images/cookiechoco.jpg',
              false, false, context),
        ],
      ),
    );
  }

  Widget _buildCard(String name, String price, String imgPath, bool added,
      bool isFavorite, context) {
    return Padding(
        padding: EdgeInsets.only(top: 15.0, bottom: 10.0, left: 15, right: 0.0),
        child: InkWell(
            onTap: () {
            //  Navigator.of(context).push(MaterialPageRoute(
             //     builder: (context) => ProductsPageForEachCtegory()));
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
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(imgPath),
                              fit: BoxFit.contain))),
                  SizedBox(height: 9.0),
                  Text(name,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 18.0)),
                ]))));
  }
}
