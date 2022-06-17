import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/bloc/bloc_get_all_category/get_all_category_bloc.dart';
import 'package:languages_project/bloc/bloc_get_all_products_from_category/get_all_products_from_category_bloc.dart';
import 'package:languages_project/data/models/get_category_model.dart';
import 'package:languages_project/data/models/search_category.dart';
import 'package:languages_project/data/web_services/get_all_products_from_category_web_services.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/modules/all_categories/components/search_category.dart';
import 'package:languages_project/shared/components/bottom_bar.dart';
import 'package:languages_project/shared/components/show_toast.dart';

import '../add_category/add_category.dart';
import 'components/products_page_for_each_category.dart';

class AllCategories extends StatefulWidget {
  static String routeName = "/all_categories";
  final List<GetCategoryModel>? getAllCategories;
  final SearchCategoryModel? searchCategoryModel;

  const AllCategories(
      {Key? key, this.getAllCategories, this.searchCategoryModel})
      : super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  late GetAllProductsFromCategoryBloc getAllProductsFromCategoryBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProductsFromCategoryBloc = GetAllProductsFromCategoryBloc(
        getAllProductsFromCategoryWebServices:
            GetAllProductsFromCategoryWebServices());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetAllProductsFromCategoryBloc>(
      create: (context) => getAllProductsFromCategoryBloc,
      child: BlocConsumer<GetAllProductsFromCategoryBloc,
          GetAllProductsFromCategoryState>(
        listener: (context, state) {
          if (state is GetAllProductsFromCategorySuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductsPageForEachCtegory(
                          getAllProducts: state.getAllProductsfromCategoryModel,
                        )));

            showToast(
                text:'sucessssss',
                state: ToastStates.SUCCESS);
          }
          if (state is GetAllProductsFromCategoryFailedState) {
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
                  icon: Icon(Icons.search, color: Color(0xFF545D68)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return Search();
                    }));
                  },
                ),
              ],
            ),
            body: Container(
                height: MediaQuery.of(context).size.height - 50.0,
                width: double.infinity,
                child: widget.searchCategoryModel == null
                    ? GridView.count(
                        crossAxisCount: 2,
                        primary: false,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: 0.8,
                        children: <Widget>[
                          ...widget.getAllCategories!.map((category) {
                            return _buildCard(
                                id: category.id!,
                                name: category.name!,
                                description: category.description!,
                                imgPath: category.imgUrl!,
                                context: context,
                                createdAt: category.createdAt!,
                                updatedAt: category.updatedAt!,
                              height: 25.0,
                            );
                          }).toList(),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 50, bottom: 350),
                        child: Container(
                          width: 300,
                          height: 300,
                          child: _buildCard(
                            id: widget.searchCategoryModel!.id!,
                            name: widget.searchCategoryModel!.name!,
                            description:
                                widget.searchCategoryModel!.description!,
                            imgPath: widget.searchCategoryModel!.imgUrl!,
                            context: context,
                            createdAt: widget.searchCategoryModel!.createdAt!,
                            updatedAt: widget.searchCategoryModel!.updatedAt!,
                            height: 40.0,
                          ),
                        ),
                      )),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddCategory.routeName);
              },
              backgroundColor: Color(0xFFF17532),
              child: Icon(Icons.fastfood),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomBar(
              selectedMenu: MenuState.home,
              type: AddCategory.routeName,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(
      {required String name,
      required String description,
      required String imgPath,
      context,
      required String createdAt,
      required String updatedAt,
      required int id,

      double height = 0}) {
    return Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 0.0, left: 10.0, right: 10.0),
        child: InkWell(
            onTap: () {
            getAllProductsFromCategoryBloc.getAllProductsFromCategory(id_category:id);
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
                 SizedBox(height: 43,),
                      Container(
                          height: 140.0,
                        width: 150.0,
                          decoration: BoxDecoration(

                              image: DecorationImage(
                                  image: NetworkImage(
                                      '$baseUrl1/categories/${imgPath}',
                                  ),
                                fit: BoxFit.cover,
                                  ))
                      ),

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
