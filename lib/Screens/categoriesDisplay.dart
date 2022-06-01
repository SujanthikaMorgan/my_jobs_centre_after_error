// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/Screens/allJobsWithCats.dart';
import 'package:my_jobs_center/Screens/catSubAllDisplayPage.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:http/http.dart' as http;

class CategoriesDisplayPage extends StatefulWidget {
  const CategoriesDisplayPage({Key? key}) : super(key: key);

  @override
  _CategoriesDisplayPageState createState() => _CategoriesDisplayPageState();
}

class _CategoriesDisplayPageState extends State<CategoriesDisplayPage> {
  Map mainCatMap = {};
  var mainCatMapKeys = [];
  List<String> categoryMainList1 = [];
  Map mainCatIdMap = {};
  Map mainCatImageMap = {};
  Map categoryDetailsResponse = {};
  bool isSpin = true;
  Map subCatMap = {};
  var subCatMapKeys = [];
  List<String> categorySubList1 = [];
  Map subCatIdMap = {};
  Map subCatImageMap = {};
  String categoryMain = '';

  Future categoriesFetched() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_cat_sal');
    var url = Uri.parse(defaultUrl + 'mob_cat_sal');

    var response = await http.post(url);
    categoryDetailsResponse = jsonDecode(response.body);
    mainCatMap = categoryDetailsResponse["main_cat"];
    mainCatMap.forEach((k, v) => mainCatMapKeys.add(Applied(k)));
    print(mainCatMapKeys);

    print(mainCatMap[mainCatMapKeys[0].toString()]);
    for (int i = 0; i < mainCatMapKeys.length; i++) {
      categoryMainList1.add(mainCatMap[mainCatMapKeys[i].toString()]["cat_name"]);
      mainCatIdMap[mainCatMap[mainCatMapKeys[i].toString()]["cat_name"]] =
          mainCatMap[mainCatMapKeys[i].toString()]["cat_id"];
      mainCatImageMap[mainCatMap[mainCatMapKeys[i].toString()]["cat_name"]] =
          mainCatMap[mainCatMapKeys[i].toString()]["picture"];
    }
    categoryMainList1.sort();
  }

  @override
  void initState() {
    categoriesFetched().then((value) {
      setState(() {
        isSpin = false;
      });
    });
    super.initState();
  }

  Future getSubCatList() async {
    // categorySubList1.clear();
    if (subCatMapKeys.isNotEmpty) {
      subCatMapKeys.clear();
    }
    // if (subCatMap.isNotEmpty) {
    //   subCatMap.clear();
    // }
    if (categorySubList1.isNotEmpty) {
      categorySubList1.clear();
    }
    if (subCatIdMap.isNotEmpty) {
      subCatIdMap.clear();
    }
    if (subCatImageMap.isNotEmpty) {
      subCatImageMap.clear();
    }

    subCatMap = categoryDetailsResponse["sub_cat"];
    subCatMap.forEach((k, v) => subCatMapKeys.add(Applied(k)));
    print(subCatMapKeys);
    // mainCatMapKeys.sort();
    // print(mainCatMapKeys);
    // print(subCatMap[subCatMapKeys[0].toString()]);
    for (int i = 0; i < subCatMapKeys.length; i++) {
      if (subCatMap[subCatMapKeys[i].toString()]["main_cat_name"] == categoryMain) {
        categorySubList1.add(subCatMap[subCatMapKeys[i].toString()]["sub_cat_name"]);
        subCatIdMap[subCatMap[subCatMapKeys[i].toString()]["sub_cat_name"]] =
            subCatMap[subCatMapKeys[i].toString()]["sub_cat_id"];
        subCatImageMap[subCatMap[subCatMapKeys[i].toString()]["sub_cat_name"]] =
            subCatMap[subCatMapKeys[i].toString()]["picture"];
      }
    }
    categorySubList1.sort();
    print(categorySubList1);
    setState(() {
      isSpin = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'All Jobs',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: const Color(0xff1d1d1d),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xffF9FAFF),
      ),
      body: isSpin
          ? Center(
              child: CupertinoActivityIndicator(
                animating: isSpin,
                radius: 15,
              ),
            )
          : Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 10,
                primary: false,
                shrinkWrap: true,
                children: [
                  for (int i = 0; i < categoryMainList1.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          categoryMain = categoryMainList1[i];
                        });
                        getSubCatList().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CatSubAllDisplayPage(
                                        subCatMap: subCatMap,
                                        subCategoryList: categorySubList1,
                                        subCatIdMap: subCatIdMap,
                                        subCatImageMap: subCatImageMap,
                                        mainCatId:
                                            mainCatIdMap[categoryMainList1[i]].toString(),
                                        mainCatName: categoryMainList1[i],
                                      )));
                        });
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => AllJObsWithCats(
                        //               catId:
                        //                   mainCatIdMap[categoryMainList1[i]].toString(),
                        //             )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 112,
                        height: 87,
                        // color: isFav ? Color(0xffDD312D) : Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                image: NetworkImage(
                                  mainCatImageMap[categoryMainList1[i]],
                                ),
                              ),
                              Text(
                                categoryMainList1[i],
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 9,
                                  // color: const Color(0xff444444),
                                  color: Color(0xff444444),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
    );
  }
}

class Applied {
  String recieved;

  Applied(this.recieved);

  @override
  String toString() {
    return '${this.recieved}';
  }
}
