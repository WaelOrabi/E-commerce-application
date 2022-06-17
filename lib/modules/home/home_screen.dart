import'package:flutter/material.dart';
import 'package:languages_project/data/models/get_all_products.dart';
import 'package:languages_project/modules/home/components/body.dart';
class HomeScreen extends StatelessWidget {
  final List<GetAllProductsModel> ? getAllProductsModel;
  static String routeName = "/home_screen";
  const HomeScreen({Key? key, required this.getAllProductsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Body(getAllProductsModel: getAllProductsModel!,);
  }
}
