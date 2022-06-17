import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/bloc/bloc_like/like_bloc.dart';
import 'package:languages_project/data/models/get_all_products.dart';
import 'package:languages_project/data/models/get_all_products_from_category.dart';
import 'package:languages_project/data/web_services/like_web_services.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/modules/add_product/add_product_screen.dart';
import 'package:languages_project/modules/all_categories/components/products_page_for_each_category.dart';
import 'package:languages_project/modules/home/home_screen.dart';
import 'package:languages_project/modules/profile/profile_screen.dart';
import 'package:languages_project/shared/components/bottom_bar.dart';
import 'package:languages_project/shared/components/comment.dart';
import 'package:languages_project/shared/components/show_toast.dart';
import 'package:languages_project/shared_preferences.dart';

import '../../../end_points.dart';

class ProductsPageDetailsHomePage extends StatefulWidget {
  final GetAllProductsModel getAllProductsModel;

  const ProductsPageDetailsHomePage(
      {Key? key, required this.getAllProductsModel})
      : super(key: key);

  @override
  State<ProductsPageDetailsHomePage> createState() =>
      _ProductsPageDetailsHomePageState(
          getAllProductsModel: getAllProductsModel);
}

class _ProductsPageDetailsHomePageState
    extends State<ProductsPageDetailsHomePage> {
  final GetAllProductsModel getAllProductsModel;
  late LikeBloc likeBloc;

  _ProductsPageDetailsHomePageState({required this.getAllProductsModel});

  @override
  void initState() {
    super.initState();
    likeBloc = LikeBloc(likeWebServices: LikeWebServices());
  }

  bool like = false;
  IconData icon = Icons.favorite_border;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => likeBloc,
      child: BlocConsumer<LikeBloc, LikeState>(
        listener: (context, state) {
          if (state is LikeSuccess) {
            icon = Icons.favorite;
            like = true;
            SharedPref.saveData(key: 'icon', value: true);
            SharedPref.saveData(
                key: 'like', value: widget.getAllProductsModel.product!.id!);
            SharedPref.saveData(
                key: '${widget.getAllProductsModel.product!.id!}', value: like);
          } else if (state is unLikeSuccess) {
            icon = Icons.favorite_border;
            like = false;
            SharedPref.saveData(key: 'icon', value: false);
            SharedPref.saveData(
                key: 'like', value: widget.getAllProductsModel.product!.id!);
            SharedPref.saveData(
                key: '${widget.getAllProductsModel.product!.id!}', value: like);
            showToast(
                // text: state.addProductModel.message!,
                text: 'sucessssss',
                state: ToastStates.SUCCESS);
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
                  Navigator.of(context).pop();
                },
              ),
              title: Text('Pickup',
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 20.0,
                      color: Color(0xFF545D68))),
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: IconButton(
                          icon: Icon(
                            SharedPref.getData(key: 'icon') == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 40,
                            color: Color(0xFFF17532),
                          ),
                          onPressed: () {
                            if (SharedPref.getData(key: 'like') ==
                                widget.getAllProductsModel.product!.id!) {
                              like = SharedPref.getData(
                                  key:
                                      '${widget.getAllProductsModel.product!.id!}');
                            }
                            print(
                                'iiiiiiiiiiiiid=${widget.getAllProductsModel.product!.id!}');
                            if (like == false) {
                              likeBloc.like(
                                  id_product:
                                      widget.getAllProductsModel.product!.id!);
                            } else if (like == true) {
                              likeBloc.unLike(
                                  id_product:
                                      widget.getAllProductsModel.product!.id!);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      child: Image.network(
                        ('$baseUrl1/products/${widget.getAllProductsModel.product!.imgUrl}'),
                        scale: 1,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Center(
                    child: Text('${widget.getAllProductsModel.product!.price}',
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF17532))),
                  ),
                  Center(
                    child: Text(widget.getAllProductsModel.product!.name!,
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 24.0)),
                  ),
                  SizedBox(height: 80.0),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 250,
                      width: MediaQuery.of(context).size.width - 23,
                      child: Card(
                        color: Color(0xFFF17532).withOpacity(0.4),
                        child: SingleChildScrollView(
                          child: Column(
                            children:  [

                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15,top: 15),
                                child: Text('description:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text('${getAllProductsModel.product!.description!}'),
                              ),
                            ],),
                              Divider(
                                height: 40,
                                thickness: 4,
                                color: Colors.white,
                              ),
                              Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text('quantity:'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text('${getAllProductsModel.product!.quantity!}'),
                                ),
                              ],),
                              Divider(
                                height: 40,
                                thickness: 4,
                                color: Colors.white,
                              ),
                              Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text('views:'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text('${getAllProductsModel.product!.views!}'),
                                ),
                              ],),
                              Divider(
                                height: 40,
                                thickness: 4,
                                color: Colors.white,
                              ),
                              Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text('exp_date:'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text('${getAllProductsModel.product!.expDate!}'),
                                ),
                              ],),
                              Divider(
                                height: 40,
                                thickness: 4,
                                color: Colors.white,
                              ),
                              Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text('created_at:'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text('${getAllProductsModel.product!.createdAt!}'),
                                ),
                              ],),
                              Divider(
                                height: 40,
                                thickness: 4,
                                color: Colors.white,
                              ),
                              Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text('updated_at:'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text('${getAllProductsModel.product!.updatedAt!}'),
                                ),
                              ],),
                            ],
                          ),
                        ),
                      ),
                      // child:
                      // Text('Cold, creamy ice cream sandwiched between delicious deluxe cookies. Pick your favorite deluxe cookies and ice cream flavor.',
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //         fontFamily: 'Varela',
                      //         fontSize: 16.0,
                      //         color: Color(0xFFB4B8B9))
                      // ),
                    ),
                  ),
                  SizedBox(height: 50.0),

                ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Color(0xFFF17532),
              child: Icon(Icons.fastfood),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
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
                    topRight: Radius.circular(25.0),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home),
                      color: Color(0xFF676E79),
                      onPressed: () =>
                          Navigator.pushNamed(context, HomeScreen.routeName),
                    ),
                    IconButton(
                      icon: Icon(Icons.person_outline),
                      color: Color(0xFF676E79),
                      onPressed: () =>
                          Navigator.pushNamed(context, ProfileScreen.routeName),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AddProductScreen.routeName);
                        },
                        icon: Icon(Icons.add_circle_outline_sharp,
                            color: Color(0xFF676E79))),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, CommentScreen.routeName);
                        },
                        icon: Icon(Icons.message_outlined,
                            color: Color(0xFF676E79))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
