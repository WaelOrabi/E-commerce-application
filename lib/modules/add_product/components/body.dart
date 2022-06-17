// import 'dart:io';
//
// import 'package:cupertino_stepper/cupertino_stepper.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:languages_project/bloc/add_product/add_product_bloc.dart';
// import 'package:languages_project/data/web_services/add_product_web_services.dart';
// import 'package:languages_project/enums.dart';
// import 'package:languages_project/shared/components/button.dart';
// import 'package:languages_project/shared/components/show_toast.dart';
//
// class Body extends StatefulWidget {
//   @override
//   State<Body> createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   File? image;
//
//   final picker = ImagePicker();
//   Future getImage(ImageSource src) async {
//     var pickedFile = await picker.pickImage(source: src);
//     setState(() {
//       if (pickedFile != null) {
//         image = File(pickedFile.path);
//       }
//     });
//   }
//
//   int currentStep = 0;
//
//   final formKey = GlobalKey<FormState>();
//   String? name;
//   String? expirationDate;
//   String? classification;
//   String? price;
//
// //  Map<String,int>  threePeriodPrice;
//   String? quantity;
//   TextEditingController dateinput_first = TextEditingController();
//   TextEditingController dateinput_seconde = TextEditingController();
//   TextEditingController dateinput_third = TextEditingController();
//   TextEditingController price1 = TextEditingController();
//   TextEditingController price2 = TextEditingController();
//   TextEditingController price3 = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController expirationDateController = TextEditingController();
//   TextEditingController classificationController = TextEditingController();
//   TextEditingController priceController = TextEditingController();
//   TextEditingController quantityController = TextEditingController();
//   String categoryid='17';
//   late AddProductBloc addProductBloc;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     addProductBloc = AddProductBloc(productsWebServices: ProductsWebServices());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<AddProductBloc>(
//       create: (context) => addProductBloc,
//       child: BlocConsumer<AddProductBloc, AddProductState>(
//         listener: (context, state) {
//           if (state is AddProductSuccess)
//             showToast(
//                // text: state.addProductModel.message!,
//               text:'sucessssss',
//                 state: ToastStates.SUCCESS);
//           if (state is AddProductFailedState) {
//             showToast(text: state.errorMessage, state: ToastStates.ERROR);
//           }
//         },
//         builder: (context, state) {
//          return Scaffold(
//             appBar: AppBar(
//
//               backgroundColor: Colors.white,
//               elevation: 0.0,
//               centerTitle: true,
//               leading: IconButton(
//                 icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               title: Text('Add Product',
//                 style: TextStyle(
//                     fontFamily: 'Varela',
//                     fontSize: 20.0,
//                     color: Color(0xFF545D68)),
//               ),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.only(
//                 top: 40,
//               ),
//               child: CupertinoPageScaffold(
//                 child: SafeArea(
//                   child: OrientationBuilder(
//                     builder: (BuildContext context, Orientation orientation) {
//                       switch (orientation) {
//                         case Orientation.landscape:
//                           return _buildStepper(StepperType.horizontal);
//                         case Orientation.portrait:
//                           return _buildStepper(StepperType.horizontal);
//                       //case Orientation.portrait:
//                       // return _buildStepper(StepperType.vertical);
//                         default:
//                           throw UnimplementedError(orientation.toString());
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   CupertinoStepper _buildStepper(StepperType type) {
//     final canCancel = currentStep > 0;
//     final canContinue = currentStep < 2;
//     return CupertinoStepper(
//       controlsBuilder: (BuildContext context, ControlsDetails details) {
//         return Padding(
//           padding: const EdgeInsets.only(top: 50),
//           child: Row(
//             children: <Widget>[
//               TextButton(
//                 onPressed:
//                     canCancel ? () => setState(() => --currentStep) : null,
//                 child: const Text('Cancel'),
//               ),
//               Spacer(),
//               TextButton(
//                 onPressed:
//                     canContinue ? () => setState(() => ++currentStep) : null,
//                 child: const Text('Continue'),
//               ),
//             ],
//           ),
//         );
//       },
//       type: type,
//       currentStep: currentStep,
//       onStepTapped: (step) => setState(() => currentStep = step),
//       steps: [
//         for (var i = 0; i < 3; ++i)
//           i == 0
//               ? _buildStep1(
//                   title: Text('Step ${i + 1}'),
//                   isActive: i == currentStep,
//                   state: i == currentStep
//                       ? StepState.editing
//                       : i < currentStep
//                           ? StepState.complete
//                           : StepState.indexed,
//                 )
//               : i == 1
//                   ? _buildStep2(
//                       title: Text('Step ${i + 1}'),
//                       isActive: i == currentStep,
//                       state: i == currentStep
//                           ? StepState.editing
//                           : i < currentStep
//                               ? StepState.complete
//                               : StepState.indexed,
//                     )
//                   : _buildStep3(
//                       title: Text('Step ${i + 1}'),
//                       isActive: i == currentStep,
//                       state: i == currentStep
//                           ? StepState.editing
//                           : i < currentStep
//                               ? StepState.complete
//                               : StepState.indexed,
//                     ),
//       ],
//     );
//   }
//
//   Step _buildStep1({
//     required Widget title,
//     StepState state = StepState.indexed,
//     bool isActive = false,
//   }) {
//     return Step(
//       title: title,
//       state: state,
//       isActive: isActive,
//       content: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width - 20,
//               height: MediaQuery.of(context).size.height / 4,
//               child: GestureDetector(
//                 onTap: () {
//                   showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: Text("Choose Picture from :"),
//                           content: Container(
//                             height: 150,
//                             child: Column(
//                               children: [
//                                 Divider(
//                                   color: Colors.black,
//                                 ),
//                                 Container(
//                                   width: 300,
//                                   color: Color(0xFFF17532),
//                                   child: ListTile(
//                                     leading: Icon(Icons.image),
//                                     title: Text('Gallery'),
//                                     onTap: () {
//                                       getImage(ImageSource.gallery);
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                   width: 300,
//                                   color: Color(0xFFF17532),
//                                   child: ListTile(
//                                     leading: Icon(Icons.image),
//                                     title: Text('Camera'),
//                                     onTap: () {
//                                       getImage(ImageSource.camera);
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       });
//                 },
//                 child: Container(
//                   child: image == null
//                       ? Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Choose the image ",
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                               SizedBox(
//                                   width: MediaQuery.of(context).size.width / 5,
//                                   child: Icon(
//                                     IconData(0xe048,
//                                         fontFamily: 'MaterialIcons'),
//                                     size: 60,
//                                   ))
//                             ],
//                           ),
//                         )
//                       : Container(
//                           decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           image: DecorationImage(
//                               image: FileImage(image!), fit: BoxFit.fill),
//                         )),
//                 ),
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.grey.shade100,
//               ),
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             buildNameFormField(),
//             SizedBox(
//               height: 40,
//             ),
//             buildExpirationDateFormField(),
//             SizedBox(
//               height: 61,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Step _buildStep2({
//     required Widget title,
//     StepState state = StepState.indexed,
//     bool isActive = false,
//   }) {
//     return Step(
//       title: title,
//       state: state,
//       isActive: isActive,
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             // SizedBox(
//             //   height: 40,
//             // ),
//             //buildClassificationFormField(),
//             SizedBox(
//               height: 30,
//             ),
//             buildPriceFormField(),
//             SizedBox(
//               height: 30,
//             ),
//             buildQuantityFormField(),
//             SizedBox(
//               height: 30,
//             ),
//             TextFormField(
//               controller: dateinput_first,
//
//               decoration: InputDecoration(
//                   labelText: "Expiry date first",
//                   hintText: "Chose the expiry date! ",
//                   prefixIcon: Icon(Icons.date_range)),
//               validator: (val) {
//                 if (val!.isEmpty) {
//                   return "You don\'t chose expiry date!";
//                 }
//                 return null;
//               },
//               //  readOnly: true,
//
//               //set it true, so that user will not able to edit text
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                     builder: (BuildContext context, Widget? child) {
//                       return Theme(
//                         data: ThemeData.light().copyWith(
//                           primaryColor: Theme.of(context).accentColor,
//                           accentColor: Theme.of(context).primaryColor,
//                           colorScheme: ColorScheme.light(
//                               primary: Theme.of(context).accentColor),
//                           buttonTheme: ButtonThemeData(
//                               textTheme: ButtonTextTheme.primary),
//                         ),
//                         child: child!,
//                       );
//                     },
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2021),
//                     //DateTime.now() - not to allow to choose before today.
//                     lastDate: DateTime(2030));
//
//                 if (pickedDate != null) {
//                   String formattedDate =
//                       DateFormat('yyyy-MM-dd').format(pickedDate);
//                   setState(() {
//                     dateinput_first.text =
//                         formattedDate; //set output date to TextField value.
//                   });
//                 }
//               },
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               controller: price1,
//               decoration: InputDecoration(
//                   labelText: "Percent first",
//                   hintText: " percent %",
//                   prefixIcon: Icon(Icons.money_off_csred_outlined)),
//               validator: (val) {
//                 if (val!.isEmpty) {
//                   return "Enter price1 ";
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(
//               height: 110,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Step _buildStep3({
//     required Widget title,
//     StepState state = StepState.indexed,
//     bool isActive = false,
//   }) {
//     return Step(
//       title: title,
//       state: state,
//       isActive: isActive,
//       content: Column(
//         children: [
//           SizedBox(
//             height: 30,
//           ),
//           TextFormField(
//             controller: dateinput_seconde,
//
//             decoration: InputDecoration(
//                 labelText: "Expiry date second",
//                 hintText: "Chose the expiry date! ",
//                 prefixIcon: Icon(Icons.date_range)),
//             validator: (val) {
//               if (val!.isEmpty) {
//                 return "You don\'t chose expiry date!";
//               }
//               return null;
//             },
//             readOnly: true,
//
//             //set it true, so that user will not able to edit text
//             onTap: () async {
//               DateTime? pickedDate = await showDatePicker(
//                   builder: (BuildContext context, Widget? child) {
//                     return Theme(
//                       data: ThemeData.light().copyWith(
//                         primaryColor: Theme.of(context).accentColor,
//                         accentColor: Theme.of(context).primaryColor,
//                         colorScheme: ColorScheme.light(
//                             primary: Theme.of(context).accentColor),
//                         buttonTheme:
//                             ButtonThemeData(textTheme: ButtonTextTheme.primary),
//                       ),
//                       child: child!,
//                     );
//                   },
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2021),
//                   //DateTime.now() - not to allow to choose before today.
//                   lastDate: DateTime(2030));
//
//               if (pickedDate != null) {
//                 String formattedDate =
//                     DateFormat('yyyy-MM-dd').format(pickedDate);
//                 setState(() {
//                   dateinput_seconde.text =
//                       formattedDate; //set output date to TextField value.
//                 });
//               }
//             },
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           TextFormField(
//             keyboardType: TextInputType.number,
//             controller: price2,
//             decoration: InputDecoration(
//                 labelText: "Percent second",
//                 hintText: " percent %",
//                 prefixIcon: Icon(Icons.money_off_csred_outlined)),
//             validator: (val) {
//               if (val!.isEmpty) {
//                 return "Enter price2 of product";
//               }
//               return null;
//             },
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           TextFormField(
//             controller: dateinput_third,
//
//             decoration: InputDecoration(
//                 labelText: "Expiry date third",
//                 hintText: "Chose the expiry date! ",
//                 prefixIcon: Icon(Icons.date_range)),
//             validator: (val) {
//               if (val!.isEmpty) {
//                 return "You don\'t chose expiry date!";
//               }
//               return null;
//             },
//             readOnly: true,
//
//             //set it true, so that user will not able to edit text
//             onTap: () async {
//               DateTime? pickedDate = await showDatePicker(
//                   builder: (BuildContext context, Widget? child) {
//                     return Theme(
//                       data: ThemeData.light().copyWith(
//                         primaryColor: Theme.of(context).accentColor,
//                         accentColor: Theme.of(context).primaryColor,
//                         colorScheme: ColorScheme.light(
//                             primary: Theme.of(context).accentColor),
//                         buttonTheme:
//                             ButtonThemeData(textTheme: ButtonTextTheme.primary),
//                       ),
//                       child: child!,
//                     );
//                   },
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2021),
//                   //DateTime.now() - not to allow to choose before today.
//                   lastDate: DateTime(2030));
//
//               if (pickedDate != null) {
//                 String formattedDate =
//                     DateFormat('yyyy-MM-dd').format(pickedDate);
//                 setState(() {
//                   dateinput_third.text =
//                       formattedDate; //set output date to TextField value.
//                 });
//               }
//             },
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           TextFormField(
//             keyboardType: TextInputType.number,
//             controller: price3,
//             decoration: InputDecoration(
//                 labelText: "Percent third",
//                 hintText: " percent %",
//                 prefixIcon: Icon(Icons.money_off_csred_outlined)),
//             validator: (val) {
//               if (val!.isEmpty) {
//                 return "Enter price3 of product";
//               }
//               return null;
//             },
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           BlocBuilder<AddProductBloc, AddProductState>(
//             builder: (context, state) {
//               if (state is AddProductProcessing) {
//                 return const CircularProgressIndicator();
//               }
//               return Button(
//                   press: () {
//                     addProductBloc.addProduct(
//                         image: image,
//                         dateinput_first: dateinput_first.text,
//                         dateinput_seconde: dateinput_seconde.text,
//                         dateinput_third: dateinput_third.text,
//                         price1: int.parse(price1.text),
//                         price2: int.parse(price2.text),
//                         price3:int.parse(price3.text),
//                         name: nameController.text,
//                         expirationDate: expirationDateController.text,
//                         price: int.parse(priceController.text),
//                         category_id: int.parse(categoryid),
//                         quantity: int.parse(quantityController.text));
//                   },
//                   text: 'Add ',
//                   isUpperCase: false,
//                   color: Color(0xFF545D68),
//                   backColor: Color(0xFFFF7643),
//                   width: 150,
//                   height: 60,
//                   borderRadius: 15,
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   TextFormField buildNameFormField() {
//     return TextFormField(
//       keyboardType: TextInputType.name,
//       controller: nameController,
//       onSaved: (newValue) => name = newValue,
//       validator: (value) {
//         print(name);
//         if (value!.isEmpty) {
//           return "Please Enter your Name";
//         }
//         return null;
//       },
//       decoration: const InputDecoration(
//         labelText: "Name",
//         hintText: "Enter your Name",
//         suffixIcon: Icon(
//           Icons.mode_edit, //color: Colors.grey,
//         ),
//       ),
//     );
//   }
//
//   TextFormField buildExpirationDateFormField() {
//     return TextFormField(
//       keyboardType: TextInputType.datetime,
//       controller: expirationDateController,
//       onSaved: (newValue) => expirationDate = newValue,
//       validator: (value) {
//         print(expirationDate);
//         if (value!.isEmpty) {
//           return "Please enter expirationDate ";
//         }
//         return null;
//       },
//       decoration: const InputDecoration(
//         labelText: "Expiration Date",
//         hintText: "Enter expiration Date",
//         suffixIcon: Icon(
//           Icons.date_range,
//           //color: Colors.grey,
//         ),
//       ),
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//             builder: (BuildContext context, Widget? child) {
//               return Theme(
//                 data: ThemeData.light().copyWith(
//                   primaryColor: Theme.of(context).accentColor,
//                   accentColor: Theme.of(context).primaryColor,
//                   colorScheme:
//                       ColorScheme.light(primary: Theme.of(context).accentColor),
//                   buttonTheme:
//                       ButtonThemeData(textTheme: ButtonTextTheme.primary),
//                 ),
//                 child: child!,
//               );
//             },
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(2021),
//             //DateTime.now() - not to allow to choose before today.
//             lastDate: DateTime(2030));
//
//         if (pickedDate != null) {
//           String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//           setState(() {
//             expirationDateController.text =
//                 formattedDate; //set output date to TextField value.
//           });
//         }
//       },
//     );
//   }
//
//   // TextFormField buildClassificationFormField() {
//   //   return TextFormField(
//   //     keyboardType: TextInputType.text,
//   //      controller:classificationController,
//   //     onSaved: (newValue) => classification = newValue,
//   //     validator: (value) {
//   //       print(classification);
//   //       if (value!.isEmpty) {
//   //         return "Please enter classification ";
//   //       }
//   //       return null;
//   //     },
//   //     decoration: const InputDecoration(
//   //       labelText: "Classification",
//   //       hintText: "Enter classification",
//   //       suffixIcon: Icon(
//   //         Icons.category,
//   //         //color: Colors.grey,
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   TextFormField buildPriceFormField() {
//     return TextFormField(
//       keyboardType: TextInputType.number,
//       controller: priceController,
//       onSaved: (newValue) => price = newValue!,
//       validator: (value) {
//         print(price);
//         if (value!.isEmpty) return "Please enter  price";
//       },
//       decoration: const InputDecoration(
//         labelText: "Price",
//         hintText: "Enter Price",
//         suffixIcon: Icon(
//           Icons.money_off_csred_outlined,
//         ),
//       ),
//     );
//   }
//
//   TextFormField buildQuantityFormField() {
//     return TextFormField(
//       keyboardType: TextInputType.number,
//       controller: quantityController,
//       onSaved: (newValue) => quantity = newValue!,
//       validator: (value) {
//         print(quantity);
//         if (value!.isEmpty) {
//           return "Please enter quantity ";
//         }
//         return null;
//       },
//       decoration: const InputDecoration(
//         labelText: "Quantity",
//         hintText: "Enter quantity",
//         suffixIcon: Icon(
//           Icons.event_available,
//           //color: Colors.grey,
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:languages_project/shared/components/themeHelper.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Body extends StatefulWidget {
  static String routeName = "/add_product";

  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

var nameController = TextEditingController();
var categoryController = TextEditingController();
var quantityController = TextEditingController();
var priceController = TextEditingController();

var expiryController = TextEditingController();
var expiryFirstController = TextEditingController();

var percentFirstController = TextEditingController();
final controllerAppBar = ScrollController();

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    percentFirstController.text = "";
    nameController.text = "";
    quantityController.text = "";
    priceController.text = "";
    expiryController.text = "";
    expiryFirstController.text = "";
  }

  File? image;

  Future getImage(ImageSource src) async {
    final pickerFile = await ImagePicker().getImage(source: src);
    setState(() {
      if (pickerFile != null) {
        image = File(pickerFile.path);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:const Color(0xFFFCFAF8),
        appBar: ScrollAppBar(
          controller: controllerAppBar,
          iconTheme: const IconThemeData(color:Colors.white),
          elevation: 1.0,
          backgroundColor:const Color(0xFFF17532),
          centerTitle: true,
          title: const Text(
            "Adding product",
            style: TextStyle(
                fontFamily: 'Varela', fontSize: 20, color:Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.fromLTRB(0, 60, 0, 20),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(children: [
                Form(
                    key: _formKey,
                    child: Column(children: [
                      //Name
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "The name is empty";
                          }
                          return null;
                        },
                        decoration: ThemeHelper().textInputProduct(
                            lableText: 'Name',
                            hintText: 'Enter the name of product',
                            icon:const Icon(Icons.drive_file_rename_outline)),
                      ),

                      const SizedBox(height: 20),

                      //Quantity Available
                      TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: ThemeHelper().textInputProduct(
                            lableText: "Quantity available",
                            hintText:
                                "Enter the quantity available of product.",
                            icon: const Icon(Icons.event_available)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter any your Telecommunications";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      //price
                      TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: ThemeHelper().textInputProduct(
                            lableText: "Price",
                            hintText: "Enter the price",
                            icon: const Icon(Icons.money_off_csred_outlined)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter price of product";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      //Expiry date
                      TextFormField(
                        controller: expiryController,

                        decoration: ThemeHelper().textInputProduct(
                            lableText: "Expiry date",
                            hintText: "Chose the expiry date! ",
                            icon: const Icon(Icons.date_range)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "You don\'t chose expiry date!";
                          }
                          return null;
                        },
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2030));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              expiryController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),

                      //Discount percentage
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3.2,
                        child: Column(
                          children: [
                           const Text(
                              "Discount percentage",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color:Color(0xFFF17532)),
                            ),
                            const SizedBox(height: 30),
                            //First

                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              child: TextFormField(
                                controller: expiryFirstController,
                                decoration: ThemeHelper().textInputProduct(
                                    lableText: "Expiry date",
                                    hintText: "Chose the expiry date! ",
                                    icon: const Icon(Icons.date_range)),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "You don\'t chose expiry date!";
                                  }
                                  return null;
                                },

                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2030));

                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    setState(() {
                                      expiryFirstController.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              child: TextFormField(
                                controller: percentFirstController,
                                keyboardType: TextInputType.number,
                                decoration: ThemeHelper().textInputProduct(
                                  lableText: "Percent",
                                  hintText: "Enter the percent",
                                  icon: const Icon(Icons.money_off),
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Enter price of product";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      ////ImagePicker
                      GestureDetector(
                        child: Container(
                            width: MediaQuery.of(context).size.width - 100,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade200,
                            ),
                            child: Center(
                              child: image == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Add Image',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                        Icon(
                                          Icons.add_a_photo,
                                          size: 50,
                                        )
                                      ],
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: FileImage(image!),
                                          fit: BoxFit.fill),
                                    )),
                            )),
                        onTap: () {
                          getImage(ImageSource.gallery);
                        },
                      ),

                      const SizedBox(height: 45),
                      //Button Add now
                      Container(
                        margin:const EdgeInsets.only(left: 0.0,top: 0.0,right: 0.0,bottom: 20),
                        decoration:BoxDecoration(
                          color:const  Color(0xFFF17532),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Add Now",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {

                            }),
                      ),
                    ])),
              ]),
            ),
        ));
  }

  Theme buildThemeDatePicker(BuildContext context, Widget child) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor: Theme.of(context).accentColor,
        accentColor: Theme.of(context).primaryColor,
        colorScheme: ColorScheme.light(primary: Theme.of(context).accentColor),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      child: child,
    );
  }
}
