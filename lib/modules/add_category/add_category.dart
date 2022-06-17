import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:languages_project/bloc/add_category/add_category_bloc.dart';
import 'package:languages_project/data/web_services/add_category_web_services.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/shared/components/button.dart';
import 'package:languages_project/shared/components/show_toast.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class AddCategory extends StatefulWidget {
  static String routeName = "/add_category";

  const AddCategory({Key? key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final controllerAppBar = ScrollController();
  TextEditingController nameController = TextEditingController();
  TextEditingController desecriptionController = TextEditingController();
  File? image;

  final picker = ImagePicker();

  Future getImage(ImageSource src) async {
    var pickedFile = await picker.pickImage(source: src);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  late AddCategoryBloc addCategoryBloc;

  void initState() {
    // TODO: implement initState
    super.initState();
    addCategoryBloc =
        AddCategoryBloc(addCategoryWebServices: AddCategoryWebServices());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddCategoryBloc>(
        create: (context) => addCategoryBloc,
        child: BlocConsumer<AddCategoryBloc,AddCategoryState>(
          listener: (context, state) {
            if (state is AddCategorySuccess) {
              showToast(
                  text: 'product added successfully',
                  state: ToastStates.SUCCESS);
            }
            if (state is AddCategoryFailedState) {
              showToast(text: state.errorMessage, state: ToastStates.ERROR);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: ScrollAppBar(
                controller: controllerAppBar,
                iconTheme: const IconThemeData(color:Colors.white),
                elevation: 1.0,
                backgroundColor:const Color(0xFFF17532),
                centerTitle: true,
                title: const Text(
                  "Adding Category",
                  style: TextStyle(
                      fontFamily: 'Varela', fontSize: 20, color:Colors.white),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
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
                            child: image == null
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Choose the image ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Icon(
                                              IconData(0xe048,
                                                  fontFamily: 'MaterialIcons'),
                                              size: 60,
                                            ))
                                      ],
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: FileImage(image!),
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
                        height: 60,
                      ),
                      buildNameFormField(),
                      SizedBox(
                        height: 40,
                      ),
                      buildDescriptionFormField(),
                      SizedBox(
                        height: 60,
                      ),
                      BlocBuilder<AddCategoryBloc, AddCategoryState>(
                          builder: (context, state) {
                            if (state is AddCategoryProcessing) {
                              return const CircularProgressIndicator();
                            }
                        return Button(
                            press: () {
                              addCategoryBloc.addCategory(
                                  image: image,
                                  name: nameController.text,
                                  description: desecriptionController.text);
                            },
                            text: 'Add ',
                            isUpperCase: false,
                            color:Colors.white,
                            backColor: Color(0xFFFF7643),
                            width: 200,
                            height: 60,
                            borderRadius: 15,
                            fontSize: 15,
                            fontWeight: FontWeight.bold);
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: nameController,
      validator: (value) {
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

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: desecriptionController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Description";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Description",
        hintText: "Enter your Descrition",
        suffixIcon: Icon(
          Icons.mode_edit, //color: Colors.grey,
        ),
      ),
    );
  }
}
