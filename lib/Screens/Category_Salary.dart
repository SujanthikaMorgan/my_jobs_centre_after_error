// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:my_jobs_center/mysql.dart';
import './Profile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:html2md/html2md.dart' as html2md;

class Category_Salary extends StatefulWidget {
  static const String idScreen = "Category_Salary";
  const Category_Salary({Key? key}) : super(key: key);

  @override
  _Category_SalaryState createState() => _Category_SalaryState();
}

class _Category_SalaryState extends State<Category_Salary> {
  final formKey = GlobalKey<FormState>();
  String categoryMain = '-';
  String categorySub = '-';
  // String mainCatIdSel = '';
  String mainCatIdSel = '';
  String subCatIdSel = '';
  String mainCatIdSelName = '-';
  bool isSalChanged = false;

  bool isSpin = true;
  var db = new Mysql();
  var resultCatMain;
  var resultCatMainSelected;
  var resultCatSubSelected;
  var resultCatMainSelectedName;
  var resultCatSubSelectedName;
  var resultCatMainID;
  var resultCatSub;
  var resultSalary;
  var resultCatSubID;
  var salMin;
  var salMax;
  var salMinText;
  var salMaxText;
  List<String> categoryMainList = ['-'];
  List<String> categorySubList = ['-'];
  late TextEditingController _controllerSalMin;
  late TextEditingController _controllerSalMax;
  String salary = "";
  List<String> splittedSalary = [];
  Map mainCatMap = {};
  var mainCatMapKeys = [];
  Map categoryDetailsResponse = {};
  List mainCatMapKeysInt = [];
  List<String> categoryMainList1 = [];
  Map subCatMap = {};
  var subCatMapKeys = [];
  List<String> categorySubList1 = [];
  Map mainCatIdMap = {};
  Map subCatIdMap = {};
  Map updateMap = {};

  @override
  void initState() {
    _controllerSalMin =
        TextEditingController(text: userDetailsResponse["sal_min"]);
    _controllerSalMax =
        TextEditingController(text: userDetailsResponse["sal_max"]);
    setState(() {
      salMinText = userDetailsResponse["sal_min"];
      salMaxText = userDetailsResponse["sal_max"];
    });
    categoriesFetched();
    setState(() {
      categoryMain = (userDetailsResponse["main_cat"] == null)
          ? "-"
          : userDetailsResponse["main_cat"];
      categorySub = (userDetailsResponse["sub_cat"] == null)
          ? "-"
          : userDetailsResponse["sub_cat"];
    });

    // _dbCheckCategoryMain();
    // _dbCheckSalary();
  }

  //------------------catefory retrieve-------
  Future categoriesFetched() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_cat_sal');
    var url = Uri.parse(defaultUrl + 'mob_cat_sal');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    // var response = await http.post(urrr, body: json.encode(data));
    var response = await http.post(url);
    categoryDetailsResponse = jsonDecode(response.body);
    mainCatMap = categoryDetailsResponse["main_cat"];
    mainCatMap.forEach((k, v) => mainCatMapKeys.add(Applied(k)));
    print(mainCatMapKeys);
    // mainCatMapKeys.sort();
    // print(mainCatMapKeys);
    print(mainCatMap[mainCatMapKeys[0].toString()]);
    for (int i = 0; i < mainCatMapKeys.length; i++) {
      categoryMainList1
          .add(mainCatMap[mainCatMapKeys[i].toString()]["cat_name"]);
      mainCatIdMap[mainCatMap[mainCatMapKeys[i].toString()]["cat_name"]] =
          mainCatMap[mainCatMapKeys[i].toString()]["cat_id"];
    }
    categoryMainList1.sort();
    categoryMainList1.insert(0, "-");
    print("======================================");
    print(categoryMainList1);
    print("======================================");

    print(mainCatMap);
    if (userDetailsResponse["main_cat"] != null) {
      getSubCatList();
    } else {
      categorySubList1.insert(0, "-");
    }
    setState(() {
      isSpin = false;
    });

    // Getting Server response into variable.
    // print(userDetailsResponse.body.toString());
    // Map a = jsonDecode(userDetailsResponse.body);
    // print(a["name"]);
  }

  getSubCatList() {
    // categorySubList1.clear();
    subCatMapKeys.clear();
    subCatMap = categoryDetailsResponse["sub_cat"];
    subCatMap.forEach((k, v) => subCatMapKeys.add(Applied(k)));
    print(subCatMapKeys);
    // mainCatMapKeys.sort();
    // print(mainCatMapKeys);
    // print(subCatMap[subCatMapKeys[0].toString()]);
    for (int i = 0; i < subCatMapKeys.length; i++) {
      if (subCatMap[subCatMapKeys[i].toString()]["main_cat_name"] ==
          categoryMain) {
        categorySubList1
            .add(subCatMap[subCatMapKeys[i].toString()]["sub_cat_name"]);
        subCatIdMap[subCatMap[subCatMapKeys[i].toString()]["sub_cat_name"]] =
            subCatMap[subCatMapKeys[i].toString()]["sub_cat_id"];
      }
    }
    categorySubList1.sort();
    categorySubList1.insert(0, "-");
    print(categorySubList1);
    setState(() {
      isSpin = false;
    });
  }

  getMainCatId() {
    print(mainCatIdMap[categoryMain]);
  }

  getSubCatId() {
    print(subCatIdMap[categorySub]);
  }

  splitSalary() {
    // if (salary != null) {
    // splittedSalary = salary.split("-");
    // if (isSalChanged) {
    // salMin = 'd5';
    salMin = salMinText.replaceAll(RegExp(','), '');
    salMax = salMaxText.replaceAll(RegExp(','), '');
    print(int.tryParse(salMin) != null);
    if ((int.tryParse(salMin) != null) && (int.tryParse(salMax) != null)) {
      setState(() {
        updateMap['sal_min'] = int.tryParse(salMin);
        updateMap['sal_max'] = int.tryParse(salMax);
        print(salMin);
      });

      // print(splittedSalary);
      setUserData();
    } else {
      Fluttertoast.showToast(msg: "Salary contains invalid characters");
    }
    // }
    // }

    // print(mainCatIdSel);
    // print(subCatIdSel);
    // updateCatSalary();
  }

  setUserData() {
    updateMap['main_cat'] = mainCatIdMap[categoryMain];
    updateMap['sub_cat'] = subCatIdMap[categorySub];
    updateMap['id'] = userDetailsResponse['id'];
    catAndSalaryUpdate();
  }

  Future catAndSalaryUpdate() async {
    // var url =
    // Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_update_sal_and_cat');
    var url = Uri.parse(defaultUrl + 'mob_update_sal_and_cat');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(updateMap));
    // var response = await http.post(url);
    var catAndSalUpdateMsg = jsonDecode(response.body);

    if (catAndSalUpdateMsg == 'Successfully Updated') {
      Fluttertoast.showToast(msg: "Updated Successfully");
      Navigator.popAndPushNamed(context, Profile.idScreen);
    }
  }

  //------------------------------Old----------------------------------------

//   void _dbCheckCategoryMain() {
//     db.getConnection().then((value) async {
//       resultCatMain = await value.query(
//         'select `cat_name` from `job_catagory_main` order by `cat_order`',
//       );
//     }).then((value) {
//       // setUserDetails();
//       setCatMainList();
//     }).then((value) => _dbCheckCategoryMainSelected());
//   }

//   void setCatMainList() {
//     for (var row in resultCatMain) {
//       categoryMainList.add(row[0].toString());
//     }
//   }

// //------------------------------------------------------
//   void _dbCheckCategoryMainSelected() {
//     db.getConnection().then((value) async {
//       resultCatMainSelected = await value.query(
//         'select `category` from `job_user` where id = ?',
//         [userID],
//       );
//     }).then((value) {
//       // setUserDetails();
//       setCatMainListMainSelected();
//     }).then((value) => _dbCheckCategoryMainSelectedName());
//   }

//   void setCatMainListMainSelected() {
//     for (var row in resultCatMainSelected) {
//       setState(() {
//         mainCatIdSel = row[0].toString();
//         mainCatIdSel = row[0].toString();
//       });
//     }
//     setState(() {
//       isSpin = false;
//     });
//   }

//   void _dbCheckCategoryMainSelectedName() {
//     db
//         .getConnection()
//         .then((value) async {
//           resultCatMainSelectedName = await value.query(
//             'select `cat_name` from `job_catagory_main` where cat_id = ?',
//             [mainCatIdSel],
//           );
//         })
//         .then((value) {
//           // setUserDetails();
//           setCatMainListMainSelectedName();
//         })
//         .then((value) => _dbCheckCategorySubSelected())
//         .then((value) => _dbCheckCategorySub());
//   }

//   void setCatMainListMainSelectedName() {
//     for (var row in resultCatMainSelectedName) {
//       setState(() {
//         categoryMain = row[0];
//       });
//     }
//     setState(() {
//       isSpin = false;
//     });
//   }

// //--------------------------------------------------------------------------------
//   void _dbCheckCategorySubSelected() {
//     db.getConnection().then((value) async {
//       resultCatSubSelected = await value.query(
//         'select `subcategory` from `job_user` where id = ?',
//         [userID],
//       );
//     }).then((value) {
//       // setUserDetails();
//       setCatMainListSubSelected();
//     }).then((value) => _dbCheckCategorySubSelectedName());
//   }

//   void setCatMainListSubSelected() {
//     for (var row in resultCatSubSelected) {
//       setState(() {
//         subCatIdSel = row[0].toString();
//       });
//     }
//   }

//   void _dbCheckCategorySubSelectedName() {
//     db.getConnection().then((value) async {
//       resultCatSubSelectedName = await value.query(
//         'select `sub_cat_name` from `job_catagory_sub` where sub_cat_id = ?',
//         [subCatIdSel],
//       );
//     }).then((value) {
//       // setUserDetails();
//       setCatMainListSubSelectedName();
//     });
//   }

//   void setCatMainListSubSelectedName() {
//     for (var row in resultCatSubSelectedName) {
//       // categorySubList.add(row[0]);
//       setState(() {
//         categorySub = row[0];
//       });
//     }
//     print(categorySub);
//     setState(() {
//       isSpin = false;
//     });
//   }

// //--------------------------------------------------------------------------------
//   void selectMainCatId() {
//     db.getConnection().then((value) async {
//       resultCatMainID = await value.query(
//         'select `cat_id` from `job_catagory_main` where cat_name=?',
//         [categoryMain],
//       );
//     }).then((value) {
//       // setUserDetails();
//       setCatMainId();
//     }).then((value) => _dbCheckCategorySub());
//   }

//   void setCatMainId() {
//     for (var row in resultCatMainID) {
//       setState(() {
//         mainCatIdSel = row[0].toString();
//       });
//     }
//   }

//   void _dbCheckCategorySub() {
//     db.getConnection().then((value) async {
//       resultCatSub = await value.query(
//         'select `sub_cat_name` from `job_catagory_sub` where main_cat_id=? order by `cat_order`',
//         [mainCatIdSel],
//       );
//     }).then((value) {
//       // setUserDetails();
//       setCatSubList();
//     });
//   }

//   void setCatSubList() {
//     for (var row in resultCatSub) {
//       categorySubList.add(row[0].toString());
//     }
//     setState(() {
//       isSpin = false;
//     });
//   }

//   void selectSubCatId() {
//     if (categorySub != '-') {
//       db.getConnection().then((value) async {
//         resultCatSubID = await value.query(
//           'select `sub_cat_id` from `job_catagory_sub` where sub_cat_name=?',
//           [categorySub],
//         );
//       }).then((value) {
//         // setUserDetails();
//         setCatSubId();
//       });
//     }
//   }

//   void setCatSubId() {
//     for (var row in resultCatSubID) {
//       setState(() {
//         subCatIdSel = row[0].toString();
//       });
//     }
//   }

//   void _dbCheckSalary() {
//     db.getConnection().then((value) async {
//       resultSalary = await value.query(
//         'select `salary_min`,`salary_max` from `job_user` where id = ?',
//         [userID],
//       );
//     }).then((value) {
//       // setUserDetails();
//       setSalary();
//     });
//   }

//   void setSalary() {
//     for (var row in resultSalary) {
//       setState(() {
//         salMin = row[0].toString();
//         salMax = row[1].toString();
//         _controllerSalMin = TextEditingController(text: '$salMin-$salMax');
//       });
//     }
//     print(salMin);
//     print(salMax);
//     // setState(() {
//     //   _controllerSal = TextEditingController(text: salMin + '-' + salMax);
//     // });
//   }

//   // splitSalary() {
//   //   // if (salary != null) {
//   //   splittedSalary = salary.split("-");
//   //   if (isSalChanged) {
//   //     salMin = splittedSalary[0];
//   //     salMax = splittedSalary[1];
//   //   }
//   //   // }

//   //   print(splittedSalary);
//   //   print(mainCatIdSel);
//   //   print(subCatIdSel);
//   //   // updateCatSalary();
//   // }

//   updateCatSalary() {
//     if (categorySub == '-') {
//       db.getConnection().then((value) async {
//         resultCatSub = await value.query(
//           'update job_user set category=?,subcategory=?,salary_min=?,salary_max=? where id=?',
//           [mainCatIdSel, null, salMin, salMax, userID],
//         );
//       }).then((value) => Navigator.pop(context));
//     } else {
//       db.getConnection().then((value) async {
//         resultCatSub = await value.query(
//           'update job_user set category=?,subcategory=?,salary_min=?,salary_max=? where id=?',
//           [mainCatIdSel, subCatIdSel, salMin, salMax, userID],
//         );
//       }).then((value) => Navigator.pop(context));
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isSpin,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Category & Salary',
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
        backgroundColor: const Color(0xfff7f9fc),
        body: isSpin
            ? CupertinoActivityIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 35,
                    right: 35,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                        ),
                        child: Text(
                          'Category',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: const Color(0xff132144),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xffffffff),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: categoryMain,
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/designIcon.PNG")),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Color(0xff444444)),
                              // underline: Container(
                              //   height: 2,
                              //   color: Colors.deepPurpleAccent,
                              // ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  categoryMain = newValue!;
                                  categorySubList1.clear();
                                  isSpin = true;
                                });
                                setState(() {
                                  categorySub = '-';
                                });
                                categorySubList.clear();
                                categorySubList.add('-');
                                // selectMainCatId();
                                print(categoryMain);
                                getMainCatId();

                                getSubCatList();
                              },
                              items: categoryMainList1
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xffffffff),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.6),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: categorySub,
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/designIcon.PNG")),
                                ),
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Color(0xff444444)),
                                // underline: Container(
                                //   height: 2,
                                //   color: Colors.deepPurpleAccent,
                                // ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    categorySub = newValue!;
                                    // selectSubCatId();
                                  });
                                  print(categorySub);
                                  getSubCatId();
                                },
                                items: categorySubList1
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      overflow: TextOverflow.clip,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Expected Salary',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: const Color(0xff132144),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xffffffff),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(50),
                                  ],
                                  controller: _controllerSalMin,
                                  decoration: InputDecoration(
                                    prefix: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: MarkdownBody(
                                        data: (userDetailsResponse[
                                                    "currencyFormat"] ==
                                                null)
                                            ? html2md.convert("&#36;")
                                            : html2md.convert(
                                                userDetailsResponse[
                                                    "currencyFormat"]),
                                        styleSheet:
                                            MarkdownStyleSheet.fromTheme(
                                          ThemeData(
                                            textTheme: TextTheme(
                                              bodyText2: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    suffix: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        "to",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'min salary',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 12,
                                      color: const Color(0xe5444444),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    setState(() {
                                      salMinText = value;
                                      // isSalChanged = true;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(50),
                                  ],
                                  controller: _controllerSalMax,
                                  decoration: InputDecoration(
                                    prefix: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: MarkdownBody(
                                        data: (userDetailsResponse[
                                                    "currencyFormat"] ==
                                                null)
                                            ? html2md.convert("&#36;")
                                            : html2md.convert(
                                                userDetailsResponse[
                                                    "currencyFormat"]),
                                        styleSheet:
                                            MarkdownStyleSheet.fromTheme(
                                          ThemeData(
                                            textTheme: TextTheme(
                                              bodyText2: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // suffix: Text(
                                    //   userDetailsResponse["currencyFormat"],
                                    //   style: TextStyle(
                                    //     fontSize: 16,
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    // ),
                                    // suffixIcon: Image(
                                    //   image:
                                    //       AssetImage("assets/images/salaryIcon.PNG"),
                                    // ),
                                    border: InputBorder.none,
                                    hintText: 'max salary',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 12,
                                      color: const Color(0xe5444444),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    setState(() {
                                      salMaxText = value;
                                      // isSalChanged = true;
                                    });
                                  },
                                ),
                              ),
                              Image(
                                image:
                                    AssetImage("assets/images/salaryIcon.PNG"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Container(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth:
                                    MediaQuery.of(context).size.width - 100,
                                minHeight: 45,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10.0,
                                  primary: Color(0xffDD312D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                onPressed: () {
                                  splitSalary();
                                },
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.white,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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

const String _svg_v141r =
    '<svg viewBox="23.0 4.0 1.3 4.0" ><path transform="translate(23.0, 4.0)" d="M 0 0 L 0 4 C 0.8047311305999756 3.661223411560059 1.328037977218628 2.873133182525635 1.328037977218628 2 C 1.328037977218628 1.126866698265076 0.8047311305999756 0.3387765288352966 0 0" fill="#000000" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ltg2cz =
    '<svg viewBox="315.7 17.3 15.3 11.0" ><path transform="translate(315.69, 17.33)" d="M 7.41510009765625 10.87290000915527 L 5.417099952697754 8.856900215148926 C 5.355900287628174 8.796600341796875 5.321700096130371 8.712900161743164 5.323500156402588 8.626500129699707 C 5.325300216674805 8.54010009765625 5.363100051879883 8.458200454711914 5.427000045776367 8.400600433349609 C 6.702300071716309 7.321500301361084 8.570700645446777 7.321500301361084 9.846000671386719 8.400600433349609 C 9.910799980163574 8.458200454711914 9.947700500488281 8.54010009765625 9.94950008392334 8.626500129699707 C 9.951300621032715 8.712900161743164 9.917099952697754 8.796600341796875 9.855899810791016 8.856900215148926 L 7.857900142669678 10.87290000915527 C 7.799400329589844 10.93230056762695 7.720200061798096 10.96560001373291 7.636500358581543 10.96560001373291 C 7.553699970245361 10.96560001373291 7.473600387573242 10.93230056762695 7.41510009765625 10.87290000915527 Z M 10.93050003051758 7.343100070953369 C 10.02780055999756 6.525900363922119 8.85420036315918 6.073200225830078 7.636500358581543 6.073200225830078 C 6.419700145721436 6.073200225830078 5.247000217437744 6.525900363922119 4.345200061798096 7.343100070953369 C 4.222800254821777 7.458300113677979 4.030200004577637 7.456500053405762 3.911400079727173 7.336800098419189 L 2.757600069046021 6.170400142669678 C 2.696400165557861 6.109200000762939 2.662199974060059 6.026400089263916 2.663100004196167 5.940000057220459 C 2.664000034332275 5.853600025177002 2.699100017547607 5.771699905395508 2.761199951171875 5.711400032043457 C 5.509799957275391 3.154500007629395 9.765900611877441 3.154500007629395 12.51360034942627 5.711400032043457 C 12.5757007598877 5.771699905395508 12.6117000579834 5.853600025177002 12.61260032653809 5.940000057220459 C 12.61350059509277 6.026400089263916 12.57929992675781 6.109200000762939 12.51900005340576 6.170400142669678 L 11.36430072784424 7.336800098419189 C 11.30341243743896 7.397687435150146 11.22391605377197 7.428067684173584 11.14436626434326 7.428062438964844 C 11.06752777099609 7.428057193756104 10.99063968658447 7.399701595306396 10.93050003051758 7.343100070953369 Z M 13.59000015258789 4.655700206756592 C 11.98350048065186 3.129300117492676 9.852300643920898 2.276999950408936 7.636500358581543 2.276999950408936 C 5.420700073242188 2.276999950408936 3.289499998092651 3.128400087356567 1.683000087738037 4.655700206756592 C 1.562399983406067 4.773600101470947 1.368900060653687 4.77180004119873 1.249199986457825 4.652100086212158 L 0.09360000491142273 3.485700130462646 C 0.0333000011742115 3.424499988555908 -0.0009000000427477062 3.342600107192993 0 3.257100105285645 C 0.0009000000427477062 3.171600103378296 0.03510000184178352 3.089699983596802 0.09630000591278076 3.029400110244751 C 4.310999870300293 -1.00980007648468 10.96110057830811 -1.00980007648468 15.17670059204102 3.029400110244751 C 15.23700046539307 3.089699983596802 15.2721004486084 3.171600103378296 15.2721004486084 3.257100105285645 C 15.27300071716309 3.342600107192993 15.23880004882812 3.424499988555908 15.17850017547607 3.485700130462646 L 14.02290058135986 4.652100086212158 C 13.96281909942627 4.712636947631836 13.88365459442139 4.743017196655273 13.80445384979248 4.743010520935059 C 13.72704887390137 4.743004322052002 13.64960861206055 4.713973522186279 13.59000015258789 4.655700206756592 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_renyrk =
    '<svg viewBox="293.7 17.7 17.0 10.7" ><path transform="translate(293.67, 17.67)" d="M 15.00030040740967 10.6668004989624 C 14.44770050048828 10.6668004989624 14.00040054321289 10.21860027313232 14.00040054321289 9.666900634765625 L 14.00040054321289 0.9999000430107117 C 14.00040054321289 0.4473000168800354 14.44770050048828 0 15.00030040740967 0 L 16.00020027160645 0 C 16.55190086364746 0 17.00010108947754 0.4473000168800354 17.00010108947754 0.9999000430107117 L 17.00010108947754 9.666900634765625 C 17.00010108947754 10.21860027313232 16.55190086364746 10.6668004989624 16.00020027160645 10.6668004989624 L 15.00030040740967 10.6668004989624 Z M 10.33290004730225 10.6668004989624 C 9.781200408935547 10.6668004989624 9.333000183105469 10.21860027313232 9.333000183105469 9.666900634765625 L 9.333000183105469 3.333600044250488 C 9.333000183105469 2.781000137329102 9.781200408935547 2.333699941635132 10.33290004730225 2.333699941635132 L 11.33370018005371 2.333699941635132 C 11.88539981842041 2.333699941635132 12.33360004425049 2.781000137329102 12.33360004425049 3.333600044250488 L 12.33360004425049 9.666900634765625 C 12.33360004425049 10.21860027313232 11.88539981842041 10.6668004989624 11.33370018005371 10.6668004989624 L 10.33290004730225 10.6668004989624 Z M 5.666399955749512 10.6668004989624 C 5.114700317382812 10.6668004989624 4.666500091552734 10.21860027313232 4.666500091552734 9.666900634765625 L 4.666500091552734 5.666399955749512 C 4.666500091552734 5.114700317382812 5.114700317382812 4.666500091552734 5.666399955749512 4.666500091552734 L 6.666300296783447 4.666500091552734 C 7.218900203704834 4.666500091552734 7.667099952697754 5.114700317382812 7.667099952697754 5.666399955749512 L 7.667099952697754 9.666900634765625 C 7.667099952697754 10.21860027313232 7.218900203704834 10.6668004989624 6.666300296783447 10.6668004989624 L 5.666399955749512 10.6668004989624 Z M 0.9999000430107117 10.6668004989624 C 0.4473000168800354 10.6668004989624 0 10.21860027313232 0 9.666900634765625 L 0 7.667099952697754 C 0 7.114500045776367 0.4473000168800354 6.666300296783447 0.9999000430107117 6.666300296783447 L 1.999800086021423 6.666300296783447 C 2.5524001121521 6.666300296783447 2.99970006942749 7.114500045776367 2.99970006942749 7.667099952697754 L 2.99970006942749 9.666900634765625 C 2.99970006942749 10.21860027313232 2.5524001121521 10.6668004989624 1.999800086021423 10.6668004989624 L 0.9999000430107117 10.6668004989624 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_lgk =
    '<svg viewBox="0.0 0.0 20.0 20.0" ><path  d="M 0 0 L 20.0029296875 0 L 20.0029296875 20.0029296875 L 0 20.0029296875 L 0 0 Z" fill="none" fill-opacity="0.35" stroke="none" stroke-width="1" stroke-opacity="0.35" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bpzqn =
    '<svg viewBox="10.3 1.6 3.7 7.6" ><path transform="translate(10.26, 1.57)" d="M 1.858601927757263 0 C 0.8334518074989319 0 0 0.8334391117095947 0 1.858589172363281 L 0 5.725834369659424 C 0 6.750984191894531 0.8334518074989319 7.584449291229248 1.858601927757263 7.584449291229248 C 2.883752107620239 7.584449291229248 3.717216491699219 6.750984191894531 3.717216491699219 5.725834369659424 L 3.717216491699219 1.858589172363281 C 3.717216491699219 0.8417736291885376 2.883752107620239 0 1.858601927757263 0 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_efspc6 =
    '<svg viewBox="15.2 5.9 3.2 3.2" ><path transform="translate(15.2, 5.93)" d="M 1.61689281463623 0 C 0.7250954508781433 0 0 0.7251081466674805 0 1.616905450820923 L 0 2.925436496734619 C 0 3.100462198257446 0.1416787654161453 3.242153644561768 0.3167043924331665 3.242153644561768 L 1.625235438346863 3.242153644561768 C 2.517032861709595 3.242153644561768 3.242141008377075 2.517045497894287 3.242141008377075 1.625248193740845 C 3.242141008377075 0.7334508895874023 2.508690118789673 0 1.61689281463623 0 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_cx7huk =
    '<svg viewBox="1.4 5.8 7.6 3.7" ><path transform="translate(1.36, 5.83)" d="M 5.725834369659424 0 L 1.858601927757263 0 C 0.8334518074989319 0 0 0.833464503288269 0 1.858614683151245 C 0 2.883764743804932 0.8334518074989319 3.71722936630249 1.858601927757263 3.71722936630249 L 5.725834369659424 3.71722936630249 C 6.750984191894531 3.71722936630249 7.584436416625977 2.883764743804932 7.584436416625977 1.858614683151245 C 7.584436416625977 0.833464503288269 6.750984191894531 0 5.725834369659424 0 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_hvz7 =
    '<svg viewBox="5.7 1.4 3.2 3.2" ><path transform="translate(5.71, 1.35)" d="M 1.61689281463623 0 C 0.7250954508781433 0 0 0.7251081466674805 0 1.616905450820923 C 0 2.508702993392944 0.7250954508781433 3.233810901641846 1.61689281463623 3.233810901641846 L 2.925423860549927 3.233810901641846 C 3.100449562072754 3.233810901641846 3.242141008377075 3.092119455337524 3.242141008377075 2.917093753814697 L 3.242141008377075 1.608562827110291 C 3.233806371688843 0.7334346771240234 2.508690118789673 0 1.61689281463623 0 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_hkhliw =
    '<svg viewBox="6.0 10.9 3.7 7.6" ><path transform="translate(6.0, 10.86)" d="M 1.858601927757263 0 C 0.8334518074989319 0 0 0.833464503288269 0 1.858614683151245 L 0 5.725834369659424 C 0 6.750984191894531 0.8334518074989319 7.584449291229248 1.858601927757263 7.584449291229248 C 2.883752107620239 7.584449291229248 3.717216491699219 6.750984191894531 3.717216491699219 5.725834369659424 L 3.717216491699219 1.858614683151245 C 3.717216491699219 0.833464503288269 2.883752107620239 0 1.858601927757263 0 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lo9g47 =
    '<svg viewBox="1.5 10.9 3.2 3.2" ><path transform="translate(1.54, 10.86)" d="M 2.925423860549927 0 L 1.61689281463623 0 C 0.7250954508781433 0 0 0.7251081466674805 0 1.616905450820923 C 0 2.508702993392944 0.7250954508781433 3.233810901641846 1.61689281463623 3.233810901641846 C 2.508690118789673 3.233810901641846 3.233798265457153 2.508702993392944 3.233798265457153 1.616905450820923 L 3.233798265457153 0.308374434709549 C 3.233798265457153 0.1416833400726318 3.092114925384521 0 2.925423860549927 0 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ntko =
    '<svg viewBox="11.0 10.5 7.6 3.7" ><path transform="translate(11.03, 10.48)" d="M 5.725834369659424 0 L 1.858601927757263 0 C 0.8334518074989319 0 0 0.8334391117095947 0 1.858589172363281 C 0 2.883739471435547 0.8334518074989319 3.717203855514526 1.858601927757263 3.717203855514526 L 5.725834369659424 3.717203855514526 C 6.750984191894531 3.717203855514526 7.584436416625977 2.883739471435547 7.584436416625977 1.858589172363281 C 7.584436416625977 0.8334391117095947 6.750984191894531 0 5.725834369659424 0 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_o7y2d =
    '<svg viewBox="11.0 15.4 3.2 3.2" ><path transform="translate(11.03, 15.39)" d="M 1.625235438346863 0 L 0.316717118024826 0 C 0.1416914910078049 0 0 0.1416914910078049 0 0.316717118024826 L 0 1.625248193740845 C 0 2.517045497894287 0.7251081466674805 3.242128133773804 1.616905450820923 3.242128133773804 C 2.508702993392944 3.242128133773804 3.233810901641846 2.517045497894287 3.233810901641846 1.625248193740845 C 3.242145538330078 0.7251163125038147 2.517032861709595 0 1.625235438346863 0 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_nhdzpe =
    '<svg viewBox="0.0 0.0 20.0 20.0" ><path  d="M 0 0 L 20.0029296875 0 L 20.0029296875 20.0029296875 L 0 20.0029296875 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vibqqs =
    '<svg viewBox="5.4 1.8 5.5 5.4" ><path transform="translate(5.44, 1.83)" d="M 5.475356101989746 0.1864468902349472 L 3.272416353225708 5.314451694488525 L 1.069476962089539 5.314451694488525 C 0.703843891620636 5.314451694488525 0.347351461648941 5.341873645782471 0 5.415000438690186 L 0.9140828251838684 3.22120213508606 L 0.9506461024284363 3.13893461227417 L 1.005491495132446 2.992681503295898 C 1.03291392326355 2.928695678710938 1.051195502281189 2.873850345611572 1.078618049621582 2.82814621925354 C 2.138953924179077 0.3692633807659149 3.327261447906494 -0.3985660970211029 5.475356101989746 0.1864468902349472 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_u7jyis =
    '<svg viewBox="9.7 2.3 7.5 5.1" ><path transform="translate(9.71, 2.3)" d="M 7.413211345672607 5.091441631317139 L 7.3949294090271 5.082300662994385 C 6.846479892730713 4.926906108856201 6.288888931274414 4.844639301300049 5.722157955169678 4.844639301300049 L 0 4.844639301300049 L 2.056686401367188 0.06398573517799377 L 2.084108591079712 0 C 2.212080240249634 0.04570414125919342 2.349193096160889 0.1096900105476379 2.486305475234985 0.1553941518068314 L 4.506428718566895 1.005491018295288 C 5.63075065612793 1.471673250198364 6.416862010955811 1.956137537956238 6.901325702667236 2.541150331497192 C 6.983592987060547 2.650840282440186 7.056719779968262 2.751389026641846 7.129846096038818 2.870219945907593 C 7.212113857269287 2.998191595077515 7.276100158691406 3.126163244247437 7.312663555145264 3.263275861740112 C 7.349226951599121 3.345543146133423 7.376647472381592 3.418669700622559 7.3949294090271 3.500937223434448 C 7.532041549682617 3.967119693756104 7.541183471679688 4.497287750244141 7.413211345672607 5.091441631317139 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rvrv6s =
    '<svg viewBox="11.4 14.9 1.0 1.2" ><path transform="translate(11.44, 14.93)" d="M 0 1.21573007106781 L 0.2285207062959671 1.21573007106781 C 0.5027455687522888 1.21573007106781 0.7312655448913574 0.9689274430274963 0.7312655448913574 0.6672800183296204 C 0.7312655448913574 0.2833652794361115 0.6215755343437195 0.2285203486680984 0.3839139938354492 0.1371120810508728 L 0 0 L 0 1.21573007106781 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_roz469 =
    '<svg viewBox="2.0 8.5 17.8 11.6" ><path transform="translate(2.05, 8.52)" d="M 14.67103004455566 0.1828172653913498 C 14.25969314575195 0.06398650258779526 13.8300724029541 0 13.38217163085938 0 L 4.460724353790283 0 C 3.839148044586182 0 3.254134893417358 0.1188310906291008 2.705684900283813 0.3564926087856293 C 1.115180850028992 1.042054772377014 0 2.623417854309082 0 4.460724353790283 L 0 6.243185520172119 C 0 6.462565422058105 0.018281614407897 6.672805786132812 0.04570409655570984 6.892185211181641 C 0.2468023151159286 9.798969268798828 1.800742745399475 11.35291004180908 4.707526206970215 11.54486751556396 C 4.917765140533447 11.57228946685791 5.128005027770996 11.5905704498291 5.356525897979736 11.5905704498291 L 12.48637104034424 11.5905704498291 C 15.86847877502441 11.5905704498291 17.65093803405762 9.981784820556641 17.82461547851562 6.78249454498291 C 17.83375549316406 6.608819007873535 17.84289741516113 6.426002025604248 17.84289741516113 6.243185520172119 L 17.84289741516113 4.460724353790283 C 17.84289741516113 2.440601110458374 16.49919509887695 0.7404078245162964 14.67103004455566 0.1828172653913498 Z M 10.09147453308105 5.649032115936279 C 10.51195240020752 5.795285224914551 11.07868385314941 6.106072902679443 11.07868385314941 7.075000762939453 C 11.07868385314941 7.906816005706787 10.42968559265137 8.574097633361816 9.625292778015137 8.574097633361816 L 9.396772384643555 8.574097633361816 L 9.396772384643555 8.775195121765137 C 9.396772384643555 9.040279388427734 9.186532974243164 9.250518798828125 8.921448707580566 9.250518798828125 C 8.656364440917969 9.250518798828125 8.446125030517578 9.040279388427734 8.446125030517578 8.775195121765137 L 8.446125030517578 8.574097633361816 L 8.363858222961426 8.574097633361816 C 7.48633861541748 8.574097633361816 6.764213562011719 7.83368968963623 6.764213562011719 6.919606685638428 C 6.764213562011719 6.654522895812988 6.974452018737793 6.444284915924072 7.239535808563232 6.444284915924072 C 7.50462007522583 6.444284915924072 7.714859485626221 6.654522895812988 7.714859485626221 6.919606685638428 C 7.714859485626221 7.303521633148193 8.007366180419922 7.623450756072998 8.363858222961426 7.623450756072998 L 8.446125030517578 7.623450756072998 L 8.446125030517578 6.078651428222656 L 7.751422882080078 5.831848621368408 C 7.330944538116455 5.685595512390137 6.764213562011719 5.374807357788086 6.764213562011719 4.405879974365234 C 6.764213562011719 3.574064254760742 7.413211345672607 2.906783580780029 8.217604637145996 2.906783580780029 L 8.446125030517578 2.906783580780029 L 8.446125030517578 2.705685138702393 C 8.446125030517578 2.440601110458374 8.656364440917969 2.2303626537323 8.921448707580566 2.2303626537323 C 9.186532974243164 2.2303626537323 9.396772384643555 2.440601110458374 9.396772384643555 2.705685138702393 L 9.396772384643555 2.906783580780029 L 9.479039192199707 2.906783580780029 C 10.35655879974365 2.906783580780029 11.07868385314941 3.647191047668457 11.07868385314941 4.56127405166626 C 11.07868385314941 4.826357841491699 10.86844539642334 5.036596775054932 10.60336112976074 5.036596775054932 C 10.33827686309814 5.036596775054932 10.12803745269775 4.826357841491699 10.12803745269775 4.56127405166626 C 10.12803745269775 4.177359104156494 9.835531234741211 3.85742974281311 9.479039192199707 3.85742974281311 L 9.396772384643555 3.85742974281311 L 9.396772384643555 5.402229309082031 L 10.09147453308105 5.649032115936279 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_hcx =
    '<svg viewBox="9.8 12.4 1.0 1.2" ><path transform="translate(9.76, 12.38)" d="M 0 0.5484500527381897 C 0 0.9323647618293762 0.1096900552511215 0.9872097373008728 0.3473515808582306 1.078618049621582 L 0.7312655448913574 1.21573007106781 L 0.7312655448913574 1.77635683940025e-15 L 0.5027448534965515 1.77635683940025e-15 C 0.2193791717290878 1.526195214019129e-16 0 0.2468027025461197 0 0.5484500527381897 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_legg46 =
    '<svg viewBox="0.0 0.0 21.9 21.9" ><path  d="M 0 0 L 21.93798828125 0 L 21.93798828125 21.93798828125 L 0 21.93798828125 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vaojpw =
    '<svg viewBox="16.0 64.0 9.3 16.2" ><path transform="translate(4.75, 57.81)" d="M 14.0435905456543 14.29483032226562 L 20.17609024047852 8.167134284973145 C 20.62966156005859 7.713561058044434 20.62966156005859 6.980021953582764 20.17609024047852 6.531252384185791 C 19.7225170135498 6.07767915725708 18.98897743225098 6.082482814788818 18.53540420532227 6.531252384185791 L 11.58770942687988 13.47483253479004 C 11.14854526519775 13.91399383544922 11.13893890380859 14.61802864074707 11.55408477783203 15.07159996032715 L 18.53060150146484 22.06252670288086 C 18.75704574584961 22.28896903991699 19.05622673034668 22.40013313293457 19.35060119628906 22.40013313293457 C 19.64497756958008 22.40013313293457 19.94415664672852 22.28896903991699 20.17060089111328 22.06252670288086 C 20.62417221069336 21.60895347595215 20.62417221069336 20.87541389465332 20.17060089111328 20.42664337158203 L 14.0435905456543 14.29483032226562 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
