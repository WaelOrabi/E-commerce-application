import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/bloc/bloc_search_category/search_category_bloc.dart';
import 'package:languages_project/bloc/search_product/search_product_bloc.dart';
import 'package:languages_project/data/web_services/search_category_web_services.dart';
import 'package:languages_project/data/web_services/search_products_web_services.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/modules/all_categories/all_categories_screen.dart';
import 'package:languages_project/shared/components/button.dart';
import 'package:languages_project/shared/components/show_toast.dart';

import 'package:search_choices/search_choices.dart';

class ExampleNumber {
  int number;

  static final Map<int, String> map = {
    0: "zero",
    1: "one",
    2: "two",
    3: "three",
    4: "four",
    5: "five",
    6: "six",
    7: "seven",
    8: "eight",
    9: "nine",
    10: "ten",
    11: "eleven",
    12: "twelve",
    13: "thirteen",
    14: "fourteen",
    15: "fifteen",
  };

  String get numberString {
    return ((map.containsKey(number) ? map[number] : "unknown") ?? "unknown");
  }

  ExampleNumber(this.number);

  // String toString() {
  //   return ("$number $numberString");
  // }

  static List<ExampleNumber> get list {
    return (map.keys.map((num) {
      return (ExampleNumber(num));
    })).toList();
  }
}

class Search extends StatefulWidget {
  static final navKey = GlobalKey<NavigatorState>();
  static String routeName = "/search";

  const Search({Key? navKey}) : super(key: navKey);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //bool asTabs = false;
  String? selectedValueNameDialog;
  String ?selectedValueDateToDialog;
  String ? selectedValueDateFromDialog;
  String? selectedValueCategoryDialog;

  // String? selectedValueSingleDialogDarkMode;
  List<DropdownMenuItem> items = [];
  List<DropdownMenuItem> editableItems = [];
  final _formKey = GlobalKey<FormState>();
  String inputString = "";
  TextFormField? input;
  List<DropdownMenuItem<ExampleNumber>> numberItems =
      ExampleNumber.list.map((exNum) {
    return (DropdownMenuItem(child: Text(exNum.numberString), value: exNum));
  }).toList();

  static const String appTitle = "Search ";
  final String loremIpsum =
      "prrroduct0  prrroduct100  ,  2022-01-01T15:13:59.000000Z,  do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  late SearchProductBloc searchProductBloc;

  @override
  void initState() {
    searchProductBloc = SearchProductBloc(SearchProductsWebServices());
    String wordPair = "";
    loremIpsum
        .toLowerCase()
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
              return (item.value == wordPair);
            }) ==
            -1) {
          items.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }
    });
    input = TextFormField(
      validator: (value) {
        return ((value?.length ?? 0) < 6
            ? "must be at least 6 characters long"
            : null);
      },
      initialValue: inputString,
      onChanged: (value) {
        inputString = value;
      },
      autofocus: true,
    );
    super.initState();
  }

  List<Widget> get appBarActions {
    return ([
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> widgets;
    widgets = {
      "name": SearchChoices.single(
        items: items,
        value: selectedValueNameDialog,
        hint: "Select one",
        searchHint: "Select one",
        onChanged: (value) {
          setState(() {
            selectedValueNameDialog = value;
          });
        },
        isExpanded: true,
      ),
      "date_from": SearchChoices.single(
        items: items,
        value: selectedValueDateFromDialog,
        hint: "Select one",
        searchHint: "Select one",
        onChanged: (value) {
          setState(() {
            selectedValueDateFromDialog = value;
          });
        },
        isExpanded: true,
      ),
      "date_to": SearchChoices.single(
        items: items,
        value: selectedValueDateToDialog,
        hint: "Select one",
        searchHint: "Select one",
        onChanged: (value) {
          setState(() {
            selectedValueDateToDialog = value;
          });
        },
        isExpanded: true,
      ),
      "Category": SearchChoices.single(
        items: items,
        value: selectedValueCategoryDialog,
        hint: "Select one",
        searchHint: "Select one",
        onChanged: (value) {
          setState(() {
            selectedValueCategoryDialog = value;
          });
        },
        isExpanded: true,
      ),
      "Search": Text(''),
    };
    return BlocProvider<SearchProductBloc>(
      create: (context) => searchProductBloc,
      child: BlocConsumer<SearchProductBloc, SearchProductState>(
          listener: (contetxt, state) {
        if (state is SearchProductSuccess) {
          showToast(text: 'success', state: ToastStates.ERROR);
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => AllCategories(
          //         searchCategoryModel: state.searchProductModel)));
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_outlined),
            ),
            title: const Text(appTitle),
            actions: appBarActions,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: widgets
                  .map((k, v) {
                    return (MapEntry(
                        k,
                        Center(
                            child: k != "Search"
                                ? Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    margin: EdgeInsets.all(20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text("$k:"),
                                          v,
                                        ],
                                      ),
                                    ))
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      BlocBuilder<SearchProductBloc,
                                          SearchProductState>(
                                        builder: (context, state) {
                                          if (state
                                              is SearchCategoryProcessing) {
                                            return const CircularProgressIndicator();
                                          }
                                          return Button(
                                              press: () {
                                                // searchProductBloc.searchProduct(name_Product:selectedValueNameDialog!.replaceAll(' ', '') , category_name:selectedValueCategoryDialog!
                                                //     .replaceAll(
                                                //     ' ',
                                                //     '') , date_from: selectedValueDateFromDialog!
                                                //     .replaceAll(
                                                //     ' ',
                                                //     ''), date_to: selectedValueDateToDialog!.replaceAll(' ', ''));


                                                },

                                              text: "Search",
                                              width: 150,
                                              borderRadius: 18,
                                              isUpperCase: false,
                                              backColor:
                                                  const Color(0xFFF17532));
                                        },
                                      ),
                                    ],
                                  ))));
                  })
                  .values
                  .toList()
                ..add(
                  const Center(
                    child: SizedBox(
                      height: 500,
                    ),
                  ),
                ), //prevents scrolling issues at the end of the list of Widgets
            ),
          ),
        );
      }),
    );
  }
}
