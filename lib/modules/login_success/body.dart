import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/bloc/get_all_products/get_all_products_bloc.dart';
import 'package:languages_project/data/models/get_all_products.dart';
import 'package:languages_project/data/web_services/get_all_products_web_services.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/modules/home/components/body.dart';
import 'package:languages_project/modules/home/home_screen.dart';
import 'package:languages_project/shared/components/button.dart';
import 'package:languages_project/shared/components/show_toast.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late GetAllProductsBloc getAllProductsBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProductsBloc=GetAllProductsBloc(getAllProductsWebServices:GetAllProductsWebServices());
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetAllProductsBloc>(
      create: (context)=>getAllProductsBloc,
      child:BlocConsumer<GetAllProductsBloc,GetAllProductsState>(
        listener: (context,state){
          if (state is GetAllProductsSuccess) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeScreen(getAllProductsModel:state.getAllProductsModel!)));
            showToast(
              // text: state.addProductModel.message!,
                text: 'sucessssss',
                state: ToastStates.SUCCESS);
          }
          else if(state is GetAllProductsFailedState)
            {
              showToast(
                // text: state.addProductModel.message!,
                  text: 'error',
                  state: ToastStates.SUCCESS);
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }
        },
        builder: (context,state){
          return SafeArea(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                        margin: const EdgeInsetsDirectional.only(top: 100),
                        child: Image.asset("assets/images/success.png")),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Login Success",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 300,
                    height: 56,
                    child: BlocBuilder<GetAllProductsBloc,GetAllProductsState>(
                        builder: (context, state) {
                          if (state is GetAllProductsProcessing) {
                            return const CircularProgressIndicator();
                          }
                          return Button(
                            isUpperCase: false,
                            borderRadius: 20,
                            fontSize: 18,
                            color: Colors.white,
                            backColor: const Color(0xFFFF7643),
                            text: "Go to home",
                            press: () {
                              getAllProductsBloc.getAllProducts();
                            },
                          );
                        },
                  ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
