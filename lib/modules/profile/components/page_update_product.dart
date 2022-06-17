import 'dart:io';

import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:languages_project/bloc/add_product/add_product_bloc.dart';
import 'package:languages_project/bloc/update_product/update_product_bloc.dart';
import 'package:languages_project/data/models/show_my_products.dart';
import 'package:languages_project/data/web_services/add_product_web_services.dart';
import 'package:languages_project/data/web_services/update_product_web_services.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/shared/components/button.dart';
import 'package:languages_project/shared/components/show_toast.dart';
import 'package:languages_project/shared_preferences.dart';

class PageUpdateProduct extends StatefulWidget {
  static String routName = '/update_product';
  final ShowMyProductsModel showMyProductsModel;

  const PageUpdateProduct({Key? key, required this.showMyProductsModel})
      : super(key: key);

  @override
  State<PageUpdateProduct> createState() => _BodyState(showMyProductsModel);
}

class _BodyState extends State<PageUpdateProduct> {
  final ShowMyProductsModel showMyProductsModel;
  File? image;

  final picker = ImagePicker();

  _BodyState(this.showMyProductsModel);

  Future getImage(ImageSource src) async {
    var pickedFile = await picker.pickImage(source: src);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  int currentStep = 0;

  final formKey = GlobalKey<FormState>();
  String? name;
  String? expirationDate;
  String? classification;
  String? price;

//  Map<String,int>  threePeriodPrice;
  String? quantity;
  TextEditingController dateinput_first = TextEditingController();
  TextEditingController dateinput_seconde = TextEditingController();
  TextEditingController dateinput_third = TextEditingController();
  TextEditingController price1 = TextEditingController();
  TextEditingController price2 = TextEditingController();
  TextEditingController price3 = TextEditingController();
  TextEditingController nameProduct = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String categoryid = '17';
  late UpdateProductBloc updateProductBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateProductBloc =
        UpdateProductBloc(updateProductWebServices: UpdateProductWebServices());
    dateinput_first.text = SharedPref.getData(key: 'expiry_date_first');

    dateinput_seconde.text = SharedPref.getData(key: 'expiry_date_second');
    dateinput_third.text = SharedPref.getData(key: 'expiry_date_third');
    price1.text = SharedPref.getData(key: 'first').toString();
    price2.text = SharedPref.getData(key: 'second').toString();
    price3.text = SharedPref.getData(key: 'third').toString();
    nameProduct.text = SharedPref.getData(key: 'name_product');
    expirationDateController.text = SharedPref.getData(key: 'expiration_date');
    priceController.text = SharedPref.getData(key: 'price').toString();
    quantityController.text = SharedPref.getData(key: 'quantity').toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateProductBloc>(
      create: (context) => updateProductBloc,
      child: BlocConsumer<UpdateProductBloc, UpdateProductState>(
        listener: (context, state) {
          if (state is UpdateProductSuccess)
            showToast(
                // text: state.addProductModel.message!,
                text: 'sucessssss',
                state: ToastStates.SUCCESS);
          if (state is UpdateProductFailedState) {
            showToast(text: state.errorMessage, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Add Product',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 20.0,
                    color: Color(0xFF545D68)),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                top: 40,
              ),
              child: CupertinoPageScaffold(
                child: SafeArea(
                  child: OrientationBuilder(
                    builder: (BuildContext context, Orientation orientation) {
                      switch (orientation) {
                        case Orientation.landscape:
                          return _buildStepper(StepperType.horizontal);
                        case Orientation.portrait:
                          return _buildStepper(StepperType.horizontal);
                        //case Orientation.portrait:
                        // return _buildStepper(StepperType.vertical);
                        default:
                          throw UnimplementedError(orientation.toString());
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  CupertinoStepper _buildStepper(StepperType type) {
    final canCancel = currentStep > 0;
    final canContinue = currentStep < 2;
    return CupertinoStepper(
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            children: <Widget>[
              TextButton(
                onPressed:
                    canCancel ? () => setState(() => --currentStep) : null,
                child: const Text('Cancel'),
              ),
              Spacer(),
              TextButton(
                onPressed:
                    canContinue ? () => setState(() => ++currentStep) : null,
                child: const Text('Continue'),
              ),
            ],
          ),
        );
      },
      type: type,
      currentStep: currentStep,
      onStepTapped: (step) => setState(() => currentStep = step),
      steps: [
        for (var i = 0; i < 3; ++i)
          i == 0
              ? _buildStep1(
                  title: Text('Step ${i + 1}'),
                  isActive: i == currentStep,
                  state: i == currentStep
                      ? StepState.editing
                      : i < currentStep
                          ? StepState.complete
                          : StepState.indexed,
                )
              : i == 1
                  ? _buildStep2(
                      title: Text('Step ${i + 1}'),
                      isActive: i == currentStep,
                      state: i == currentStep
                          ? StepState.editing
                          : i < currentStep
                              ? StepState.complete
                              : StepState.indexed,
                    )
                  : _buildStep3(
                      title: Text('Step ${i + 1}'),
                      isActive: i == currentStep,
                      state: i == currentStep
                          ? StepState.editing
                          : i < currentStep
                              ? StepState.complete
                              : StepState.indexed,
                    ),
      ],
    );
  }

  Step _buildStep1({
    required Widget title,
    StepState state = StepState.indexed,
    bool isActive = false,
  }) {
    return Step(
      title: title,
      state: state,
      isActive: isActive,
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.height / 4,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Choose Picture from :"),
                          content: Container(
                            height: 150,
                            child: Column(
                              children: [
                                Divider(
                                  color: Colors.black,
                                ),
                                Container(
                                  width: 300,
                                  color: Color(0xFFF17532),
                                  child: ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text('Gallery'),
                                    onTap: () {
                                      getImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 300,
                                  color: Color(0xFFF17532),
                                  child: ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text('Camera'),
                                    onTap: () {
                                      getImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  child: (showMyProductsModel.product!.imgUrl == null &&
                          image == null)
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Choose the image ",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Icon(
                                    IconData(0xe048,
                                        fontFamily: 'MaterialIcons'),
                                    size: 60,
                                  ))
                            ],
                          ),
                        )
                      : image != null
                          ? Container(
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: FileImage(image!), fit: BoxFit.fill),
                            ))
                          : Container(
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '$baseUrl1/products/${showMyProductsModel.product!.imgUrl}'),
                                  fit: BoxFit.fill),
                            )),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade100,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            buildNameFormField(),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 61,
            ),
          ],
        ),
      ),
    );
  }

  Step _buildStep2({
    required Widget title,
    StepState state = StepState.indexed,
    bool isActive = false,
  }) {
    return Step(
      title: title,
      state: state,
      isActive: isActive,
      content: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: 40,
            // ),
            //buildClassificationFormField(),
            SizedBox(
              height: 30,
            ),
            buildPriceFormField(),
            SizedBox(
              height: 30,
            ),
            buildQuantityFormField(),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: dateinput_first,

              decoration: InputDecoration(
                  labelText: "Expiry date first",
                  hintText: "Chose the expiry date! ",
                  prefixIcon: Icon(Icons.date_range)),
              validator: (val) {
                if (val!.isEmpty) {
                  return "You don\'t chose expiry date!";
                }
                return null;
              },
              //  readOnly: true,

              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: Theme.of(context).accentColor,
                          accentColor: Theme.of(context).primaryColor,
                          colorScheme: ColorScheme.light(
                              primary: Theme.of(context).accentColor),
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child!,
                      );
                    },
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2030));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    dateinput_first.text =
                        formattedDate; //set output date to TextField value.
                  });
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: price1,
              decoration: InputDecoration(
                  labelText: "Percent first",
                  hintText: " percent %",
                  prefixIcon: Icon(Icons.money_off_csred_outlined)),
              validator: (val) {
                if (val!.isEmpty) {
                  return "Enter price1 ";
                }
                return null;
              },
            ),
            SizedBox(
              height: 110,
            ),
          ],
        ),
      ),
    );
  }

  Step _buildStep3({
    required Widget title,
    StepState state = StepState.indexed,
    bool isActive = false,
  }) {
    return Step(
      title: title,
      state: state,
      isActive: isActive,
      content: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          TextFormField(
            // initialValue: showMyProductsModel.product!.saleDate2,
            controller: dateinput_seconde,

            decoration: InputDecoration(
                labelText: "Expiry date second",
                hintText: "Chose the expiry date! ",
                prefixIcon: Icon(Icons.date_range)),
            validator: (val) {
              if (val!.isEmpty) {
                return "You don\'t chose expiry date!";
              }
              return null;
            },
            readOnly: true,

            //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: Theme.of(context).accentColor,
                        accentColor: Theme.of(context).primaryColor,
                        colorScheme: ColorScheme.light(
                            primary: Theme.of(context).accentColor),
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child!,
                    );
                  },
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2030));

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  dateinput_seconde.text =
                      formattedDate; //set output date to TextField value.
                });
              }
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            // initialValue:'${showMyProductsModel.product!.price2}',
            keyboardType: TextInputType.number,
            controller: price2,
            decoration: InputDecoration(
                labelText: "Percent second",
                hintText: " percent %",
                prefixIcon: Icon(Icons.money_off_csred_outlined)),
            validator: (val) {
              if (val!.isEmpty) {
                return "Enter price2 of product";
              }
              return null;
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            // initialValue: showMyProductsModel.product!.saleDate3,
            controller: dateinput_third,

            decoration: InputDecoration(
                labelText: "Expiry date third",
                hintText: "Chose the expiry date! ",
                prefixIcon: Icon(Icons.date_range)),
            validator: (val) {
              if (val!.isEmpty) {
                return "You don\'t chose expiry date!";
              }
              return null;
            },
            readOnly: true,

            //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: Theme.of(context).accentColor,
                        accentColor: Theme.of(context).primaryColor,
                        colorScheme: ColorScheme.light(
                            primary: Theme.of(context).accentColor),
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child!,
                    );
                  },
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2030));

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  dateinput_third.text =
                      formattedDate; //set output date to TextField value.
                });
              }
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            // initialValue: '${showMyProductsModel.product!.price3}',
            keyboardType: TextInputType.number,
            controller: price3,
            decoration: InputDecoration(
                labelText: "Percent third",
                hintText: " percent %",
                prefixIcon: Icon(Icons.money_off_csred_outlined)),
            validator: (val) {
              if (val!.isEmpty) {
                return "Enter price3 of product";
              }
              return null;
            },
          ),
          SizedBox(
            height: 50,
          ),
          BlocBuilder<UpdateProductBloc, UpdateProductState>(
            builder: (context, state) {
              if (state is UpdateProductProcessing) {
                return const CircularProgressIndicator();
              }
              return Button(
                  press: () {
                    print(nameProduct.text);
                    print(priceController.text);
                    print(categoryid);
                    print(quantityController.text);
                    print(price1.text);
                    print(price2.text);
                    print(price3.text);
                    print(showMyProductsModel.product!.id!);
                    print(image);
                    updateProductBloc.updateProduct(
                        name: nameProduct.text,
                        price: int.parse(priceController.text),
                        category_id: int.parse(categoryid),
                        quantity: int.parse(quantityController.text),
                        price1: int.parse(price1.text),
                        price2: int.parse(price2.text),
                        price3: int.parse(price3.text),
                        id_product: showMyProductsModel.product!.id!,
                        image: image);
                  },
                  text: 'Add ',
                  isUpperCase: false,
                  color: Color(0xFF545D68),
                  backColor: Color(0xFFFF7643),
                  width: 150,
                  height: 60,
                  borderRadius: 15,
                  fontSize: 15,
                  fontWeight: FontWeight.bold);
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildNameFormField() {
    print(SharedPref.getData(key: 'name_product'));
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: nameProduct,
      onSaved: (newValue) => name = newValue,
      validator: (value) {
        print(name);
        if (value!.isEmpty) {
          return "Please Enter your Name";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Name",
        hintText: "Enter your Name",
        suffixIcon: Icon(
          Icons.mode_edit, //color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField buildPriceFormField() {
    return TextFormField(
      // initialValue: '${showMyProductsModel.product!.price}',
      keyboardType: TextInputType.number,
      controller: priceController,
      onSaved: (newValue) => price = newValue!,
      validator: (value) {
        print(price);
        if (value!.isEmpty) return "Please enter  price";
      },
      decoration: const InputDecoration(
        labelText: "Price",
        hintText: "Enter Price",
        suffixIcon: Icon(
          Icons.money_off_csred_outlined,
        ),
      ),
    );
  }

  TextFormField buildQuantityFormField() {
    return TextFormField(
      // initialValue: '${showMyProductsModel.product!.quantity}',
      keyboardType: TextInputType.number,
      controller: quantityController,
      onSaved: (newValue) => quantity = newValue!,
      validator: (value) {
        print(quantity);
        if (value!.isEmpty) {
          return "Please enter quantity ";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Quantity",
        hintText: "Enter quantity",
        suffixIcon: Icon(
          Icons.event_available,
          //color: Colors.grey,
        ),
      ),
    );
  }
}
