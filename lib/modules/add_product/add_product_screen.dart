import 'package:flutter/material.dart';
import 'components/body.dart';
class AddProductScreen extends StatefulWidget {
  static String routeName="/add_product_screen";
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}
