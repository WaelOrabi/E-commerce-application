import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/bloc/bloc_get_all_category/get_all_category_bloc.dart';
import 'package:languages_project/bloc/bloc_log_out/log_out_bloc.dart';
import 'package:languages_project/bloc/delete_account/delete_account_bloc.dart';
import 'package:languages_project/data/models/get_all_products.dart';
import 'package:languages_project/data/web_services/get_all_category_web_services.dart';
import 'package:languages_project/data/web_services/delete_account_web_services.dart';
import 'package:languages_project/data/web_services/log_out_web_services.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/modules/all_categories/all_categories_screen.dart';
import 'package:languages_project/modules/home/components/drawer_menu.dart';
import 'package:languages_project/modules/home/components/products_page.dart';
import 'package:languages_project/modules/home/home_screen.dart';
import 'package:languages_project/modules/profile/components/profile_picture.dart';
import 'package:languages_project/modules/splash/spalsh_screen.dart';
import 'package:languages_project/shared/components/bottom_bar.dart';
import 'package:languages_project/shared/components/search_products.dart';
import 'package:languages_project/shared/components/show_toast.dart';
import 'package:languages_project/shared_preferences.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

import '../../../bloc/show_information_user/show_information_user_bloc.dart';
import '../../../data/web_services/show_information_user_web_services.dart';
import '../../profile/profile_screen.dart';

class Body extends StatefulWidget {
  final List<GetAllProductsModel>? getAllProductsModel;

  const Body({Key? key, required this.getAllProductsModel}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _BodyState createState() => _BodyState(getAllProductsModel!);
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late ShowInformationUserBloc showInformationUserBloc;
  final List<GetAllProductsModel>? getAllProductsModel;
  final controllerAppBar = ScrollController();
  late GetAllCategoryBloc getAllCategoryBloc;
  late DeleteAccountBloc deleteAccountBloc;
  late LogOutBloc logOutBloc;

  _BodyState(this.getAllProductsModel);

  @override
  void initState() {
    super.initState();
    showInformationUserBloc = ShowInformationUserBloc(
        showInformationUserWebServices: ShowInformationUserWebServices());
    getAllCategoryBloc = GetAllCategoryBloc(
        getAllCategoryWebServices: GetAllCategoryWebServices());
    logOutBloc = LogOutBloc(logOutWebServices: LogOutWebServices());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShowInformationUserBloc>(
            create: (context) => showInformationUserBloc),
        BlocProvider<GetAllCategoryBloc>(
          create: (context) => getAllCategoryBloc,
        ),
        BlocProvider<DeleteAccountBloc>(create: (context) {
          deleteAccountBloc = DeleteAccountBloc(
              deleteAccountWebServices: DeleteAccountWebServices());
          return deleteAccountBloc;
        }),
        BlocProvider<LogOutBloc>(
          create: (context) => logOutBloc,
        ),
      ],
      child: Scaffold(
        appBar: ScrollAppBar(
          controller: controllerAppBar,
          iconTheme: const IconThemeData(color: Color(0xFF545D68)),
          elevation: 1.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Shop now',
            style: TextStyle(
                fontFamily: 'Varela', fontSize: 20, color: Color(0xFF545D68)),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return const Search();
                    }),
                  );
                },
                icon: const Icon(Icons.search, color: Color(0xFF545D68)))
          ],
        ),
        drawer: Drawer(
          backgroundColor: const Color(0xFFFF7643).withOpacity(0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50, left: 30),
                child: ProfilePicture(),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      SharedPref.getData(key: 'name_user') ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Varela',
                          fontSize: 20,
                          color: Color(0xFF545D68)),
                    ),
                    Text(
                      SharedPref.getData(key: 'email_user') ?? '',
                      style: const TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade900,
              ),
              Expanded(
                child: ListView(
                  children: [
                    BlocConsumer<ShowInformationUserBloc,
                        ShowInformationUserState>(
                      listener: (context, state) {
                        if (state is ShowInformationUserSuccess) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                    showInformationUserModel:
                                        state.showInformationUserModel,
                                  )));
                        }
                        if (state is ShowInformationUserFailedState) {
                          showToast(
                              text: state.errorMessage,
                              state: ToastStates.SUCCESS);
                        }
                      },
                      builder: (context, state) {
                        return DrawerMenu(
                            text: "Show Profile",
                            icon: Icons.person_outline,
                            press: () {
                              showInformationUserBloc.showInformation();
                            });
                      },
                    ),
                    BlocConsumer<GetAllCategoryBloc, GetAllCategoryState>(
                      listener: (context, state) {
                        if (state is GetAllCategorySuccess) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AllCategories(
                                    getAllCategories: state.getAllCategories,
                                  )));
                        }
                        if (state is GetAllCategoryFailedState) {
                          showToast(
                              text: state.errorMessage,
                              state: ToastStates.ERROR);
                        }
                      },
                      builder: (context, state) {
                        return DrawerMenu(
                          text: "All Categories",
                          icon: Icons.category,
                          press: () {
                            getAllCategoryBloc.getAllCategory();
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocConsumer<DeleteAccountBloc, DeleteAccountState>(
                      listener: (context, state) {
                        if (state is DeleteAccountSuccess) {
                          SharedPref.removeData(
                              key: 'token'); //هون عم احذف التوكن
                          if (state.DeleteAccountMessage.toString()
                              .contains('Account')) {
                            showToast(
                                text: "Account has been deleted successfully",
                                state: ToastStates.SUCCESS);
                          }
                          Navigator.of(context)
                              .pushReplacementNamed(SplashScreen.routeName);
                        } else if (state is DeleteAccountFailedState) {
                          showToast(
                              text: state.errorMessage,
                              state: ToastStates.SUCCESS);
                        }
                      },
                      builder: (context, state) {
                        return DrawerMenu(
                            text: "Delete Account",
                            icon: Icons.delete,
                            press: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text('Delete Account'),
                                        content: const Text(
                                            'are you sure you want to delete your account ?\nAll you products will be delete'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () => deleteAccountBloc
                                                .DeleteAccount(),
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      ));
                            });
                      },
                    ),
                    BlocConsumer<LogOutBloc, LogOutState>(
                      listener: (context, state) {
                        if (state is LogOutSuccess) {
                          SharedPref.removeData(
                              key: 'token'); //هون عم احذف التوكن
                          if (state.LogOutMessage.toString()
                              .contains('logged')) {
                            showToast(
                                text:
                                    "This account has been successfully logged out",
                                state: ToastStates.SUCCESS);
                          }

                          Navigator.of(context)
                              .pushReplacementNamed(SplashScreen.routeName);
                        } else if (state is LogOutFailedState) {
                          showToast(
                              text: state.errorMessage,
                              state: ToastStates.SUCCESS);
                          Navigator.of(context)
                              .pushReplacementNamed(SplashScreen.routeName);
                        }
                      },
                      builder: (context, state) {
                        return DrawerMenu(
                            text: "Logout Account",
                            icon: Icons.logout,
                            press: () {
                              logOutBloc.LogOut();
                            });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: ProductsPage(getAllProductsModel: getAllProductsModel!),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFFF17532),
          child: const Icon(Icons.fastfood),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBar(
          selectedMenu: MenuState.home,
          type: HomeScreen.routeName,
        ),
      ),
    );
  }
}
