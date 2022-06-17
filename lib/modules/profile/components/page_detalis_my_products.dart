import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/bloc/bloc_like/like_bloc.dart';
import 'package:languages_project/data/models/get_all_products.dart';
import 'package:languages_project/data/models/get_all_products_from_category.dart';
import 'package:languages_project/data/models/show_my_products.dart';
import 'package:languages_project/data/web_services/deleteproduct_web_services.dart';
import 'package:languages_project/data/web_services/like_web_services.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/modules/add_product/add_product_screen.dart';
import 'package:languages_project/modules/all_categories/components/products_page_for_each_category.dart';
import 'package:languages_project/modules/home/home_screen.dart';
import 'package:languages_project/modules/profile/components/page_update_product.dart';
import 'package:languages_project/modules/profile/profile_screen.dart';
import 'package:languages_project/shared/components/bottom_bar.dart';
import 'package:languages_project/shared/components/comment.dart';
import 'package:languages_project/shared/components/show_toast.dart';
import 'package:languages_project/shared_preferences.dart';

import '../../../end_points.dart';

class MyProductsPageDetailsHomePage extends StatefulWidget {
final ShowMyProductsModel showMyProductsModel;
  const MyProductsPageDetailsHomePage(
      {Key? key, required this.showMyProductsModel})
      : super(key: key);

  @override
  State<MyProductsPageDetailsHomePage> createState() =>
      _MyProductsPageDetailsHomePageState(showMyProductsModel:showMyProductsModel);
}

class _MyProductsPageDetailsHomePageState
    extends State<MyProductsPageDetailsHomePage> {
  final ShowMyProductsModel showMyProductsModel;
  late LikeBloc likeBloc;

  _MyProductsPageDetailsHomePageState({required this.showMyProductsModel});
 late DeleteProductWebServices deleteProductWebServices;
  @override
  void initState() {
    super.initState();
    likeBloc = LikeBloc(likeWebServices: LikeWebServices());
 deleteProductWebServices=DeleteProductWebServices();
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
                key: 'like', value: widget.showMyProductsModel.product!.id!);
            SharedPref.saveData(
                key: '${widget.showMyProductsModel.product!.id!}', value: like);
          } else if (state is unLikeSuccess) {
            icon = Icons.favorite_border;
            like = false;
            SharedPref.saveData(key: 'icon', value: false);
            SharedPref.saveData(
                key: 'like', value: widget.showMyProductsModel.product!.id!);
            SharedPref.saveData(
                key: '${widget.showMyProductsModel.product!.id!}', value: like);
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
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit_rounded, color: Color(0xFF545D68)),
                  onPressed: () {
                    SharedPref.saveData(key:'name_product', value:showMyProductsModel.product!.name);
                    print('sharrre=${SharedPref.getData(key:'name_product')}');
                    SharedPref.saveData(key:'expiration_date', value:showMyProductsModel.product!.expDate);
                    SharedPref.saveData(key:'price', value: showMyProductsModel.product!.price);
                    SharedPref.saveData(key:'quantity', value:showMyProductsModel.product!.quantity);
                    SharedPref.saveData(key:'expiry_date_first', value:showMyProductsModel.product!.saleDate1);
                    SharedPref.saveData(key:'first', value:showMyProductsModel.product!.price1);
                    SharedPref.saveData(key:'expiry_date_second', value:showMyProductsModel.product!.saleDate2);
                    SharedPref.saveData(key:'second', value:showMyProductsModel.product!.price2);
                    SharedPref.saveData(key:'expiry_date_third', value:showMyProductsModel.product!.saleDate3);
                    SharedPref.saveData(key:'third', value:showMyProductsModel.product!.price3);
                   Navigator.push(context, MaterialPageRoute(builder:(context){
                     return PageUpdateProduct(showMyProductsModel: showMyProductsModel,);
                   }));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete_rounded, color: Color(0xFF545D68)),
                  onPressed: () {
                    DeleteProductWebServices.DeleteProduct(url:'/products/${showMyProductsModel.product!.id}')
                    ;
                  },
                ),
              ],
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  SizedBox(height: 30.0),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      child: Image.network(
                        ('$baseUrl1/products/${showMyProductsModel.product!.imgUrl}'),
                        scale: 1,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 80.0),
                  Center(
                    child: Text('${showMyProductsModel.product!.price}',
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF17532))),
                  ),
                  Center(
                    child: Text(showMyProductsModel.product!.name!,
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
                                  child: Text('${showMyProductsModel.product!.description!}'),
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
                                  child: Text('${showMyProductsModel.product!.quantity!}'),
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
                                  child: Text('${showMyProductsModel.product!.views!}'),
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
                                  child: Text('${showMyProductsModel.product!.expDate!}'),
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
                                  child: Text('${showMyProductsModel.product!.createdAt!}'),
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
                                  child: Text('${showMyProductsModel.product!.updatedAt!}'),
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
