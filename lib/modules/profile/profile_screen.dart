// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/bloc/bloc_log_out/log_out_bloc.dart';
import 'package:languages_project/bloc/delete_account/delete_account_bloc.dart';
import 'package:languages_project/data/models/show_information_user.dart';
import 'package:languages_project/data/web_services/delete_account_web_services.dart';
import 'package:languages_project/data/web_services/log_out_web_services.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/modules/profile/components/profile_menu.dart';
import 'package:languages_project/modules/profile/components/profile_picture.dart';
import 'package:languages_project/modules/splash/spalsh_screen.dart';
import 'package:languages_project/shared/components/bottom_bar.dart';
import 'package:languages_project/shared/components/show_toast.dart';
import 'package:languages_project/shared_preferences.dart';

import 'components/custom_appbar.dart';
import 'components/update_my_information.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  final ShowInformationUserModel? showInformationUserModel;

  const ProfileScreen({Key? key, this.showInformationUserModel})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(
      showInformationUserModel:
          showInformationUserModel);
}

class _ProfileScreenState extends State<ProfileScreen> {
  //late DeleteBloc authBloc;
  final ShowInformationUserModel? showInformationUserModel;

  _ProfileScreenState({required this.showInformationUserModel});

  late LogOutBloc logOutBloc;
  late DeleteAccountBloc deleteAccountBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logOutBloc = LogOutBloc(logOutWebServices: LogOutWebServices());
    deleteAccountBloc =
        DeleteAccountBloc(deleteAccountWebServices: DeleteAccountWebServices());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeleteAccountBloc>(create: (context) => deleteAccountBloc),
        BlocProvider<LogOutBloc>(create: (context) => logOutBloc),
      ],
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox.fromSize(
                size:const Size.fromHeight(200.0),
                child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      RoundedAppBar(),
                      Positioned(
                        right: 130,
                        bottom: -35,
                        child: ProfilePicture(
                          imgUrl: showInformationUserModel!.profImgUrl,
                        ),
                      ),
                    ])),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.only(left: 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${showInformationUserModel!.name}',
                    style:const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Varela',
                        fontSize: 20,
                        color: Color(0xFF545D68)),
                  ),
                 const SizedBox(height: 10),
                  Text(
                    '+963 ${showInformationUserModel!.phoneNumber}',
                    style:const TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
           const SizedBox(height: 30),
            BlocConsumer<LogOutBloc, LogOutState>(
              listener: (context, state) {
                if (state is LogOutSuccess) {
                  SharedPref.removeData(key: 'token');
                  if (state.LogOutMessage.toString().contains('logged')) {
                    showToast(
                        // text: state.addProductModel.message!,
                        text: "This account has been successfully logged out",
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
                return ProfileMenu(
                  text: "Log Out",
                  icon: Icons.logout,
                  press: () {
                    logOutBloc.LogOut();
                  },
                );
              },
            ),
            BlocConsumer<DeleteAccountBloc, DeleteAccountState>(
              listener: (context, state) {
                if (state is DeleteAccountSuccess) {
                  SharedPref.removeData(key: 'token');
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
                return ProfileMenu(
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
                                    onPressed: () =>
                                        deleteAccountBloc.DeleteAccount(),
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ));
                    });
              },
            ),
            ProfileMenu(
              text: "Edit",
              icon: Icons.edit,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UpdateMyInformationScreen();
                }));
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor:const Color(0xFFF17532),
          child:const Icon(Icons.fastfood),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBar(
          selectedMenu: MenuState.profile,
          type: ProfileScreen.routeName,
        ),
      ),
    );
  }
}
