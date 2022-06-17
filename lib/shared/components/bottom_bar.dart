import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/bloc/get_all_products/get_all_products_bloc.dart';
import 'package:languages_project/bloc/show_my_products/show_my_products_bloc.dart';
import 'package:languages_project/data/web_services/get_all_products_web_services.dart';
import 'package:languages_project/data/web_services/show_my_product_web_services.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/modules/add_category/add_category.dart';
import 'package:languages_project/modules/add_product/add_product_screen.dart';
import 'package:languages_project/modules/home/home_screen.dart';
import 'package:languages_project/modules/profile/components/show_my_products.dart';
import 'package:languages_project/shared/components/show_toast.dart';

class BottomBar extends StatefulWidget {
  final MenuState selectedMenu;
  final String type;

  const BottomBar({Key? key, required this.selectedMenu, required this.type})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late ShowMyProductsBloc showMyProductsBloc;
  late GetAllProductsBloc getAllProductsBloc;

  @override
  void initState() {
    super.initState();

    showMyProductsBloc = ShowMyProductsBloc(
        showMyProductsWebServices: ShowMyProductsWebServices());
    getAllProductsBloc = GetAllProductsBloc(
        getAllProductsWebServices: GetAllProductsWebServices());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShowMyProductsBloc>(
          create: (context) => showMyProductsBloc,
        ),
        BlocProvider<GetAllProductsBloc>(
          create: (context) => getAllProductsBloc,
        ),
      ],
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width / 2 - 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      BlocConsumer<GetAllProductsBloc, GetAllProductsState>(
                        listener: (context, state) {
                          if (state is GetAllProductsSuccess) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeScreen(
                                  getAllProductsModel:
                                      state.getAllProductsModel);
                            }));
                          }
                          if (state is GetAllProductsFailedState) {
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          }
                        },
                        builder: (context, state) {
                          return IconButton(
                              icon: Icon(Icons.home),
                              color: MenuState.home == widget.selectedMenu
                                  ? Color(0xFFFF7643)
                                  : Color(0xFFB6B6B6),
                              onPressed: () {
                                getAllProductsBloc.getAllProducts();
                              });
                        },
                      ),
                      IconButton(
                          icon: Icon(Icons.category_rounded),
                          color:  Color(0xFFB6B6B6),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AddCategory.routeName);
                          }),
                    ],
                  )),
              Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width / 2 - 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AddProductScreen.routeName);
                          },
                          icon: Icon(
                            Icons.add_circle_outline_sharp,
                            color: Color(0xFFB6B6B6),
                          )),
                      BlocConsumer<ShowMyProductsBloc, ShowMyProductsState>(
                        listener: (context, state) {
                          if (state is ShowMyProductsSuccess) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyProducts(
                                    showMyProductsModel:
                                        state.showMyProductsModel)));
                          }
                          if (state is ShowMyProductsFailedState) {
                            showToast(
                                text: state.errorMessage,
                                state: ToastStates.SUCCESS);
                          }
                        },
                        builder: (context, state) {
                          return IconButton(
                            icon: Icon(
                              Icons.shopping_basket,
                              color: MenuState.myProducts == widget.selectedMenu
                                  ? Color(0xFFFF7643)
                                  : Color(0xFFB6B6B6),
                            ),
                            onPressed: () {
                              showMyProductsBloc.showMyProducts();
                            },
                          );
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
