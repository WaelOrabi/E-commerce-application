import 'package:flutter/material.dart';

class BaseWidget extends InheritedWidget{
  BaseWidget({Key ? key,required this.child}) : super(key: key,child: child);
  final formKey=GlobalKey<FormState>();
  String ? name;
  String ? expirationDate;
  String ? classification;
  String ? contactInformation;
//  Map<String,int>  threePeriodPrice;
 String ? quantity;
  TextEditingController  nameController=TextEditingController();
  TextEditingController  expirationDateController=TextEditingController();
  TextEditingController  classificationController=TextEditingController();
  TextEditingController  contactInformationController=TextEditingController();
  TextEditingController   quantityController=TextEditingController();
  final Widget child;
  static BaseWidget? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<BaseWidget>();
  }
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

}