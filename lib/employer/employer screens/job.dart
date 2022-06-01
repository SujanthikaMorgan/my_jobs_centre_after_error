// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unnecessary_new

import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:markdown/markdown.dart' as markdownToHtml;
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:my_jobs_center/employer/widget/adlimit.dart';

import 'package:path/path.dart' as path;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_jobs_center/employer/employer%20screens/jobPost.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/dropdownsearchwidget.dart';
import 'package:my_jobs_center/employer/widget/formwidget.dart';
import 'package:my_jobs_center/employer/widget/pallette.dart';
import 'package:http/http.dart' as http;
import 'package:my_jobs_center/employer/widget/searchcity.dart';
import 'package:my_jobs_center/globalVariables.dart';

import 'package:html2md/html2md.dart' as html2md;

import '../../Screens/HomeJob.dart';

class Job extends StatefulWidget {
  static const String idScreen = "job";
  const Job({Key? key}) : super(key: key);

  @override
  _JobState createState() => _JobState();
}

class _JobState extends State<Job> {
  Map<String, dynamic>? paymentIntentData;
  TextEditingController controllercity = TextEditingController();

  bool isChecked = false;
  bool value = false;
  int val = 0;
  bool isFeaturedheck = false;
  bool isUrgentCheckd = false;
  bool isHighiLightCheckd = false;
  String compname = 'Select a company';
  var companies = ['Select a company'];
  // String compname = '[+] New Company';
  // var companies = ['[+] New Company'];
  String salarytypeSelected = 'Per Month Salary';
  var salaryTypes = [
    'Per Hour Salary',
    'Per Day Salary',
    'Per Week Salary',
    'Per Month Salary',
    'Per Year Salary',
  ];
  List<String> jobTypes = [
    "Full Time",
    "Part Time",
    "Temporary",
    "Permanent",
    "Internship",
    "Freelancer"
  ];
  String jobTypeSelected = "Full Time";
  var cities = ['matale', 'London', 'Kandy'];

  String companyName = "";
  String companyDescription = "";
  String category = "";
  String title = "";
  String description = "";
  String jobType = "";
  String salMax = "";
  String salMin = "";
  String salType = '';
  bool isNegotiable = false;
  String phoneNumber = "";
  bool isHidePhone = false;
  String city = "";
  String tags = "";
  bool isFree = false;
  Map alljobs = {};
  var allJobsList = [];
  Map allCompanies = {};
  var allCompaniesList = [];
  //------------------catefory retrieve-------
  Map categoryDetailsResponse = {};
  Map mainCatMap = {};
  var mainCatMapKeys = [];
  List<String> categoryMainList1 = [];
  Map mainCatIdMap = {};
  List<String> categorySubList1 = [];
  bool isSpin = true;
  Map subCatMap = {};
  var subCatMapKeys = [];
  String categoryMain = 'Select Main Category';
  String categorySub = 'Select Sub Category';
  List<String> categorySubList = ['Select Sub Category'];
  List<String> categoryMainList = ['Select Main Category'];
  Map subCatIdMap = {};
  Map pageData = {};
  File? fileComp;
  String fileNameDispComp = "";
  File? fileJob;
  String fileNameDispJob = "";
  Dio dio = new Dio();
  String applicationURL = "";
  int jobTypeId = 4;
  int salTypeId = 6;
  bool isNewCompany = true;
  int companyId = 0;
  Map idMap = {};
  Map fetchedCities = {};
  Map fetchedGroupInfo = {};
  String selectedCityIndex = "0";
  int price = 0;
  bool canPost = true;
  bool isPaid = false;
  int urgentBalance = 0;
  int featureBalance = 0;
  int highlightBalane = 0;
  bool isUrgentBalUsed = false;
  bool isFeaturedBalUsed = false;
  bool isHighlighBalUsed = false;

  List<String> _kOptions = [];

  Future checkExceedsLimit() async {
    var url = Uri.parse(defaultUrl + 'mob_ad_limit_check');
    var response =
        await http.post(url, body: json.encode({"user_id": userDetailsResponse['id']}));
    print(response.body);
    if (response.body == '"Can Post"') {
      setState(() {
        canPost = true;
      });
    } else {
      setState(() {
        canPost = false;
      });
    }
  }

  Future getPaymentDetails() async {
    var url = Uri.parse(defaultUrl + 'mob_get_post_payment_details');
    var response =
        await http.post(url, body: json.encode({"user_id": userDetailsResponse['id']}));

    fetchedGroupInfo = jsonDecode(response.body);
    print("mobile payment details");
    print(fetchedGroupInfo);
    print("mobile payment details ends ------------------------------");
  }

  Future citiesFetched() async {
    var url = Uri.parse(defaultUrl + 'mob_get_cities');
    var response = await http.post(url,
        body: json.encode({'country_code': userDetailsResponse['country_code']}));

    fetchedCities = jsonDecode(response.body);
    print(fetchedCities);
    setState(() {
      for (int i = 0; i < fetchedCities['cities'].length; i++) {
        _kOptions.add(fetchedCities['cities'][i]);
      }
    });
  }

  Future categoriesFetched() async {
    var url = Uri.parse(defaultUrl + 'mob_cat_sal');
    var response = await http.post(url);
    categoryDetailsResponse = jsonDecode(response.body);
    mainCatMap = categoryDetailsResponse["main_cat"];
    mainCatMap.forEach((k, v) => mainCatMapKeys.add(Applied(k)));
    print(mainCatMapKeys);
    // mainCatMapKeys.sort();
    // print(mainCatMapKeys);
    print(mainCatMap[mainCatMapKeys[0].toString()]);
    for (int i = 0; i < mainCatMapKeys.length; i++) {
      categoryMainList1.add(mainCatMap[mainCatMapKeys[i].toString()]["cat_name"]);
      mainCatIdMap[mainCatMap[mainCatMapKeys[i].toString()]["cat_name"]] =
          mainCatMap[mainCatMapKeys[i].toString()]["cat_id"];
    }
    categoryMainList1.sort();
    categoryMainList1.insert(0, "Select Main Category");
    print("======================================");
    print(categoryMainList1);
    print("======================================");

    print(mainCatMap);
    if (userDetailsResponse["main_cat"] != null) {
      getSubCatList();
    } else {
      categorySubList1.insert(0, "Select Sub Category");
    }
    setState(() {
      isSpin = false;
    });

    // Getting Server response into variable.
    // print(userDetailsResponse.body.toString());
    // Map a = jsonDecode(userDetailsResponse.body);
    // print(a["name"]);
  }

  Future selectFileComp() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      fileNameDispComp = result.files.single.name;
    });

    setState(() => fileComp = File(path));
  }

  Future selectFileJob() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      fileNameDispJob = result.files.single.name;
    });

    setState(() => fileJob = File(path));
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
      if (subCatMap[subCatMapKeys[i].toString()]["main_cat_name"] == categoryMain) {
        categorySubList1.add(subCatMap[subCatMapKeys[i].toString()]["sub_cat_name"]);
        subCatIdMap[subCatMap[subCatMapKeys[i].toString()]["sub_cat_name"]] =
            subCatMap[subCatMapKeys[i].toString()]["sub_cat_id"];
      }
    }
    categorySubList1.sort();
    categorySubList1.insert(0, "Select Sub Category");
    print(categorySubList1);
    setState(() {
      isSpin = false;
    });
  }

  Future gettingAllJobs() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_companies');
    var url = Uri.parse(defaultUrl + 'mob_my_companies');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    setState(() {
      pageData["limit"] = 1000;
      pageData['offset'] = 1;
      pageData['id'] = userDetailsResponse['id'];
    });
    var response = await http.post(url, body: json.encode(pageData));
    // var response = await http.post(url);
    try {
      alljobs = jsonDecode(response.body);
      print(alljobs);

      alljobs['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print("-------------------------------------------------");
      print(allJobsList);
      print("-------------------------------------------------");

      print(alljobs['all'][allJobsList[0].toString()]);
      print("-------------------------------------------------");
    } catch (error) {
      print("error");
    }

    // print(appliedJobs);
    // print(appliedJobs
    //     .map((i, element) => MapEntry(i, print(appliedJobs[i].toString()))));
    setState(() {
      isSpin = false;
    });
  }

  Future createPost() async {
    String uploadurl = defaultUrl + "mob_post_job";
    FormData formdata = FormData.fromMap({
      "company_logo": (fileComp != null)
          ? await MultipartFile.fromFile(fileComp!.path,
              filename: path.basename(fileComp!.path)
              //show only filename from path
              )
          : null,
      "job_image": (fileJob != null)
          ? await MultipartFile.fromFile(fileJob!.path,
              filename: path.basename(fileJob!.path)
              //show only filename from path
              )
          : null,
      "user_id": userDetailsResponse['id'],
      "username": userDetailsResponse['username'],
      "company_name": companyName,
      "isCreateCompany": isNewCompany ? true : null,
      "company": isNewCompany ? companyName : idMap[compname],
      "company_desc": markdownToHtml.markdownToHtml(companyDescription),
      "catid": mainCatIdMap[categoryMain],
      "subcatid": subCatIdMap[categorySub],
      "content": markdownToHtml.markdownToHtml(description),
      "job_type": jobTypeId,
      "salary_min": salMin,
      "salary_max": salMax,
      "salary_type": salTypeId,
      "negotiable": isNegotiable,
      "phone": phoneNumber,
      "hide_phone": isHidePhone,
      "application_url": applicationURL,
      "city": selectedCityIndex,
      "tags": tags,
      "company_enable": true,
      "job_image_field": true,
      "submit": true,
      "title": title,
      "usernameG": username_glob,
      "passwordG": password_glob,
      "featured": isFeaturedheck ? 1 : 0,
      "highlighted": isHighiLightCheckd ? 1 : 0,
      "urgent": isUrgentCheckd ? 1 : 0,
      "isPaid": isPaid ? 1 : 0,
      "amount": price,
      "group_id": fetchedGroupInfo['group_id'],
      "isUrgeBalUsed": isUrgentBalUsed ? 1 : 0,
      "isFeatBalUsed": isFeaturedBalUsed ? 1 : 0,
      "isHighBalUsed": isHighlighBalUsed ? 1 : 0,
      'payment_method_id': "2",

      //mainCatIdMap[categoryMain]

      // "name": fileName,
      // "id": userDetailsResponse["id"],
      // "username": userDetailsResponse["username"],
      // "name": fileName,
    });

    print(formdata.fields);

    var response = await dio.post(
      uploadurl,
      data: formdata,
      options: Options(
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
        // headers: headers,
      ),
      // onSendProgress: (int sent, int total) {
      //   String percentage = (sent / total * 100).toStringAsFixed(2);
      //   setState(() {
      //     progress = "$sent" +
      //         " Bytes of " "$total Bytes - " +
      //         percentage +
      //         " % uploaded";
      //     //update the progress
      //   });
      // },
    );

    if (response.statusCode == 200) {
      print(response.toString());
      print(response.data);

      if (response.data == '{"errors" : [{"message":"Application Url is invalid."}]}') {
        Fluttertoast.showToast(msg: "Application Url is invalid.");
      } else {
        Fluttertoast.showToast(msg: "Successfully Posted");
        setState(() {
          isSpin = false;
        });
        gettingProfileData();
      }

      // setState(() {});
      //print response from server
    } else {
      print("Error during connection to server.");
      print(response.statusMessage);
      setState(() {
        isSpin = false;
      });
      Fluttertoast.showToast(
          msg: "Something went wrong. Try again later. (Error : ${response.statusCode})");
    }
  }

  Future gettingAllCompanies() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_companies');
    var url = Uri.parse(defaultUrl + 'mob_my_companies');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    setState(() {
      pageData["limit"] = 10000;
      pageData['offset'] = 1;
      pageData['id'] = userDetailsResponse['id'];
    });
    var response = await http.post(url, body: json.encode(pageData));
    // var response = await http.post(url);
    try {
      allCompanies = jsonDecode(response.body);
      print(allCompanies);

      allCompanies['all'].forEach((k, v) => allCompaniesList.add(Applied(k)));
      print("-------------------------------------------------");
      print(allCompaniesList);
      print("-------------------------------------------------");

      print(allCompanies['all'][allCompaniesList[0].toString()]);
      print("-------------------------------------------------");
      for (int i = 0; i < allCompaniesList.length; i++) {
        setState(() {
          companies.add(allCompanies['all'][allCompaniesList[i].toString()]["name"]);
          idMap[allCompanies['all'][allCompaniesList[i].toString()]["name"]] =
              allCompanies['all'][allCompaniesList[i].toString()]["id"];
        });
      }
      setState(() {
        companies.add('[+] New Company');
      });
      print(idMap);
    } catch (error) {
      print("error");
    }

    // print(appliedJobs);
    // print(appliedJobs
    //     .map((i, element) => MapEntry(i, print(appliedJobs[i].toString()))));
    setState(() {
      isSpin = false;
    });
  }

  Future gettingProfileData() async {
    var url = Uri.parse(defaultUrl + 'mob_user_profile');
    var response = await http.post(url, body: json.encode({'userName': userNameGlob}));
    userDetailsResponse = jsonDecode(response.body);
    print(userDetailsResponse);
    setState(() {
      isSignedIn = true;
    });
    if (userDetailsResponse["user_type"] == "employer") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => JobPost()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeJob()));
    }
  }

  @override
  void initState() {
    print('----------features check---------------');
    print(userDetailsResponse['urgent'].runtimeType);
    setState(() {
      urgentBalance = int.parse(userDetailsResponse['urgent']);
      featureBalance = int.parse(userDetailsResponse['featured']);
      highlightBalane = int.parse(userDetailsResponse['highlight']);
    });
    checkExceedsLimit();
    getPaymentDetails();
    citiesFetched();
    categoriesFetched();
    gettingAllCompanies();
    setState(() {
      categoryMain = (userDetailsResponse["main_cat"] == null)
          ? "Select Main Category"
          : userDetailsResponse["main_cat"];
      categorySub = (userDetailsResponse["sub_cat"] == null)
          ? "Select Sub Category"
          : userDetailsResponse["sub_cat"];
    });
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.red;
      }
      return Colors.grey;
    }

    return Scaffold(
      // backgroundColor: const Color(0xfff7f9fc),
      backgroundColor: Colors.white,
      endDrawer: SidemenuEmployer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        // backgroundColor: const Color(0xfff7f9fc),
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              bottom: 10,
              right: 10,
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          "Post a Job",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: const Color(0xff1d1d1d),
            fontWeight: FontWeight.w500,
            //fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
      ),
      body: isSpin
          ? Center(
              child: CupertinoActivityIndicator(
              animating: isSpin,
            ))
          : canPost
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.building,
                                color: Color(0xffdd312d),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Company Information",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "Company *",
                            style: formtext,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[350]!),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: EdgeInsets.only(left: 30, right: 20),
                                child: DropdownButton(
                                  value: compname,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  items: companies.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      compname = value!;

                                      // print(idMap[compname]);
                                    });
                                    if (compname == "[+] New Company" ||
                                        compname == 'Select a company') {
                                      setState(() {
                                        isNewCompany = true;
                                      });
                                    } else {
                                      setState(() {
                                        isNewCompany = false;
                                      });
                                    }
                                    print(isNewCompany);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.all(10),
                        //   child: TextFormField(
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(16),
                        //         borderSide:
                        //             BorderSide(color: Colors.black, width: 5),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(16),
                        //         borderSide:
                        //             BorderSide(color: Colors.black, width: 3),
                        //       ),
                        //       labelStyle: TextStyle(
                        //         fontFamily: 'Poppins',
                        //         fontSize: 15,
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //       // suffixStyle: TextStyle(fontSize: 15),

                        //       suffixIcon: DropdownButton(
                        //         value: compname,
                        //         icon: Icon(
                        //           Icons.arrow_drop_down,
                        //         ),
                        //         items: companies.map((String items) {
                        //           return DropdownMenuItem(
                        //             value: items,
                        //             child: Text(items),
                        //           );
                        //         }).toList(),
                        //         onChanged: (String? value) {
                        //           setState(() {});
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        if (isNewCompany)
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Company Name*",
                              style: formtext,
                            ),
                          ),
                        if (isNewCompany)
                          FormWidget(
                            onChangedText: (value) {
                              setState(() {
                                companyName = value;
                              });
                            },
                            // ic: '',
                          ),
                        if (isNewCompany)
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Logo",
                              style: formtext,
                            ),
                          ),
                        if (isNewCompany)
                          Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15, top: 15),
                                    child: Container(
                                      height: 50,
                                      width: 160,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          side: BorderSide(
                                              width: 1.0, color: const Color(0xffdd312d)),
                                          elevation: 5.0,
                                          primary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          selectFileComp();
                                        },
                                        child: Text(
                                          "Upload Logo",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            color: const Color(0xffdd312d),
                                            letterSpacing: 0.7000000000000001,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        "Use 200x200px size for better view.",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 17,
                                          color: Colors.grey,
                                          letterSpacing: 0.7000000000000001,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        if (isNewCompany)
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              "Company Description *",
                              style: formtext,
                            ),
                          ),
                        if (isNewCompany)
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: MarkdownTextInput(
                              (String value) =>
                                  setState(() => companyDescription = value),
                              companyDescription,
                              label: 'Company Description',
                              maxLines: 10,
                              actions: MarkdownType.values,
                              boxDecoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                border: Border.all(color: Colors.black, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                hintText: 'Company Description',
                                hintStyle: const TextStyle(
                                    color: Color.fromRGBO(63, 61, 86, 0.5)),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                              ),
                              // controller: controller,
                            ),
                          ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 10, bottom: 10),
                        //   child: TextFormField(
                        //     onChanged: (value) {
                        //       setState(() {
                        //         companyDescription = value;
                        //       });
                        //     },
                        //     keyboardType: TextInputType.multiline,
                        //     decoration: InputDecoration(
                        //         border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(16),
                        //           borderSide: BorderSide(color: Colors.black, width: 5),
                        //         ),
                        //         focusedBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(16),
                        //           borderSide: BorderSide(color: Colors.black, width: 3),
                        //         ),
                        //         labelStyle: TextStyle(
                        //           fontFamily: 'Poppins',
                        //           fontSize: 15,
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.w500,
                        //         )),
                        //     maxLines: 8,
                        //     minLines: 3,
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 25,
                                width: 22,
                                child: Icon(
                                  FontAwesomeIcons.suitcase,
                                  color: Color(0xffdd312d),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Job Details",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 15),
                        //   child: Center(
                        //     child: Container(
                        //       height: 50,
                        //       width: 250,
                        //       child: ElevatedButton(
                        //         style: ElevatedButton.styleFrom(
                        //           side: BorderSide(
                        //               width: 1.0, color: const Color(0xffdd312d)),
                        //           elevation: 10.0,
                        //           primary: Color(0xffdd312d),
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(8.0),
                        //           ),
                        //         ),
                        //         onPressed: () {},
                        //         child: Row(
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20),
                        //               child: SizedBox(
                        //                 height: 20,
                        //                 width: 20,
                        //                 child: SvgPicture.string(
                        //                   tick,
                        //                   allowDrawingOutsideViewBox: true,
                        //                 ),
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 10),
                        //               child: Text(
                        //                 "Choose Category",
                        //                 style: TextStyle(
                        //                   fontFamily: 'Poppins',
                        //                   fontSize: 17,
                        //                   color: Colors.white,
                        //                   letterSpacing: 0.7000000000000001,
                        //                 ),
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: const Color(0xffffffff),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: categoryMain,
                                iconSize: 24,
                                elevation: 16,
                                iconEnabledColor: Colors.grey,
                                style: const TextStyle(color: Color(0xff444444)),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    categoryMain = newValue!;
                                    categorySubList1.clear();
                                    isSpin = true;
                                    print(mainCatIdMap[categoryMain]);
                                  });
                                  setState(() {
                                    categorySub = 'Select Sub Category';
                                  });
                                  categorySubList.clear();
                                  categorySubList.add('Select Sub Category');
                                  // selectMainCatId();
                                  // print(categoryMain);
                                  // getMainCatId();

                                  getSubCatList();
                                },
                                items: categoryMainList1
                                    .map<DropdownMenuItem<String>>((String value) {
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
                            borderRadius: BorderRadius.circular(16.0),
                            color: const Color(0xffffffff),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.6),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: categorySub,
                                  iconEnabledColor: Colors.grey,
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Color(0xff444444)),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      categorySub = newValue!;
                                      // selectSubCatId();
                                    });
                                  },
                                  items: categorySubList1
                                      .map<DropdownMenuItem<String>>((String value) {
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

                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "Title *",
                            style: formtext,
                          ),
                        ),
                        FormWidget(
                          onChangedText: (value) {
                            title = value;
                          },
                          // ic: '',
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "Image",
                            style: formtext,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15, top: 15),
                                  child: Container(
                                    height: 50,
                                    width: 160,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(
                                            width: 1.0, color: const Color(0xffdd312d)),
                                        elevation: 5.0,
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        selectFileJob();
                                      },
                                      child: Text(
                                        "Upload Image",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: const Color(0xffdd312d),
                                          letterSpacing: 0.7000000000000001,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Use 200x200px size for better view.",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 17,
                                        color: Colors.grey,
                                        letterSpacing: 0.7000000000000001,
                                      ),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "Description *",
                            style: formtext,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: MarkdownTextInput(
                            (String value) => setState(() => description = value),
                            description,
                            label: 'Description',
                            maxLines: 10,
                            actions: MarkdownType.values,
                            boxDecoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintText: 'Description',
                              hintStyle:
                                  const TextStyle(color: Color.fromRGBO(63, 61, 86, 0.5)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                            ),
                            // controller: controller,
                          ),
                        ),

                        // Padding(
                        //   padding: EdgeInsets.only(top: 10, bottom: 10),
                        //   child: TextFormField(
                        //     onChanged: (value) {
                        //       setState(() {
                        //         description = value;
                        //       });
                        //     },
                        //     keyboardType: TextInputType.multiline,
                        //     decoration: InputDecoration(
                        //         border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(16),
                        //           borderSide: BorderSide(color: Colors.black, width: 5),
                        //         ),
                        //         focusedBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(16),
                        //           borderSide: BorderSide(color: Colors.black, width: 3),
                        //         ),
                        //         labelStyle: TextStyle(
                        //           fontFamily: 'Poppins',
                        //           fontSize: 15,
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.w500,
                        //         )),
                        //     maxLines: 8,
                        //     minLines: 3,
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "Job Type *",
                            style: formtext,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[350]!),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: EdgeInsets.only(left: 30, right: 20),
                                child: DropdownButton(
                                  value: jobTypeSelected,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  items: jobTypes
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      jobTypeSelected = value!;
                                    });

                                    setState(() {
                                      if (jobTypeSelected == "Full Time") {
                                        setState(() {
                                          jobTypeId = 4;
                                        });
                                      } else if (jobTypeSelected == "Part Time") {
                                        setState(() {
                                          jobTypeId = 5;
                                        });
                                      } else if (jobTypeSelected == "Temporary") {
                                        setState(() {
                                          jobTypeId = 6;
                                        });
                                      } else if (jobTypeSelected == "Permanent") {
                                        setState(() {
                                          jobTypeId = 7;
                                        });
                                      } else if (jobTypeSelected == "Internship") {
                                        setState(() {
                                          jobTypeId = 8;
                                        });
                                      } else if (jobTypeSelected == "Freelancer") {
                                        setState(() {
                                          jobTypeId = 9;
                                        });
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "Salary",
                            style: formtext,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 60,
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    salMin = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.black, width: 5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.black, width: 3),
                                  ),
                                  labelText: 'Min',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  suffix: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: MarkdownBody(
                                      data:
                                          (userDetailsResponse["currencyFormat"] == null)
                                              ? html2md.convert("&#36;")
                                              : html2md.convert(
                                                  userDetailsResponse["currencyFormat"]),
                                      styleSheet: MarkdownStyleSheet.fromTheme(
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
                                  suffixStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 35),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: 60,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        salMax = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 3),
                                      ),
                                      labelText: 'Max',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      suffix: Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: MarkdownBody(
                                          data: (userDetailsResponse["currencyFormat"] ==
                                                  null)
                                              ? html2md.convert("&#36;")
                                              : html2md.convert(
                                                  userDetailsResponse["currencyFormat"]),
                                          styleSheet: MarkdownStyleSheet.fromTheme(
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
                                      suffixStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 12),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[350]!),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: EdgeInsets.only(left: 30, right: 20),
                                child: DropdownButton(
                                  value: salarytypeSelected,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  items: salaryTypes.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      salarytypeSelected = value!;
                                    });

                                    if (salarytypeSelected == 'Per Hour Salary') {
                                      setState(() {
                                        salTypeId = 4;
                                      });
                                    } else if (salarytypeSelected == 'Per Day Salary') {
                                      setState(() {
                                        salTypeId = 5;
                                      });
                                    } else if (salarytypeSelected == 'Per Month Salary') {
                                      setState(() {
                                        salTypeId = 6;
                                      });
                                    } else if (salarytypeSelected == 'Per Year Salary') {
                                      setState(() {
                                        salTypeId = 7;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                fillColor: MaterialStateProperty.resolveWith(getColor),
                                value: isNegotiable,
                                onChanged: (bool? value) {
                                  setState(() {
                                    // isChecked = value!;
                                    isNegotiable = value!;
                                  });
                                }),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Negotiable", style: formtext)
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          child: Text(
                            "Phone Number",
                            style: formtext,
                          ),
                        ),
                        IntlPhoneField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: userDetailsResponse['country_code'],
                          onChanged: (phone) {
                            setState(() {
                              phoneNumber = phone.completeNumber;
                            });
                            print(phone.completeNumber);
                          },
                        ),
                        //FormWidget(ic: ''),

                        Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                fillColor: MaterialStateProperty.resolveWith(getColor),
                                value: isHidePhone,
                                onChanged: (bool? value) {
                                  setState(() {
                                    // isChecked = value!;
                                    isHidePhone = value!;
                                  });
                                }),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Hide from users", style: formtext)
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            print(selectedCity);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              "City *",
                              style: formtext,
                            ),
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 75,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Container(
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.all(Radius.circular(16)),
                              //   border: Border.all(color: Colors.black),
                              // ),
                              child: TypeAheadFormField<String?>(
                                textFieldConfiguration: TextFieldConfiguration(
                                    controller: controllercity,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 3),
                                      ),
                                      // hintText: "City",
                                      // hintStyle: TextStyle(
                                      //   fontFamily: 'Poppins',
                                      //   fontSize: 14,
                                      //   color: const Color(0xe5444444),
                                      // ),
                                    )
                                    // decoration: InputDecoration(
                                    //   border: OutlineInputBorder(
                                    //     borderRadius: BorderRadius.circular(16),
                                    //     borderSide: BorderSide(color: Colors.black, width: 5),
                                    //   ),
                                    //   focusedBorder: OutlineInputBorder(
                                    //     borderRadius: BorderRadius.circular(16),
                                    //     borderSide: BorderSide(color: Colors.black, width: 3),
                                    //   ),
                                    // ),
                                    ),
                                onSuggestionSelected: (String? suggestion) {
                                  controllercity.text = suggestion!;
                                  setState(() {
                                    int index =
                                        fetchedCities['cities'].indexOf(suggestion);
                                    print(index);
                                    city = suggestion;
                                    print(fetchedCities['city_id'][index]);
                                    selectedCityIndex = fetchedCities['city_id'][index];
                                  });
                                },
                                // validator:(value)=>
                                // value!=null && value.isEmpty ? 'Please select a city' : null,
                                // onSaved: (value)=>city=value!,
                                itemBuilder: (context, String? suggestion) => ListTile(
                                  title: Text(suggestion!),
                                ),
                                suggestionsCallback: (query) => _kOptions.where(
                                    (element) => element
                                        .toLowerCase()
                                        .contains(query.toLowerCase())),
                              ),

                              // Autocomplete<String>(
                              //   optionsBuilder: (TextEditingValue textEditingValue) {
                              //     if (textEditingValue.text == '') {
                              //       return const Iterable<String>.empty();
                              //     }
                              //     return _kOptions.where((String option) {
                              //       return option
                              //           .toLowerCase()
                              //           .contains(textEditingValue.text.toLowerCase());
                              //     });
                              //   },
                              //   onSelected: (String selection) {
                              //     debugPrint('You just selected $selection');
                              // setState(() {
                              //   int index = fetchedCities['cities'].indexOf(selection);
                              //   print(index);
                              //   city = selection;
                              //   print(fetchedCities['city_id'][index]);
                              //   selectedCityIndex = fetchedCities['city_id'][index];
                              // });
                              //   },
                              // ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 15),
                        //   child: Text(
                        //     "Application URL",
                        //     style: formtext,
                        //   ),
                        // ),
                        // FormWidget(
                        //   onChangedText: (value) {
                        //     setState(() {
                        //       applicationURL = value;
                        //     });
                        //   },
                        // ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "Tags",
                            style: formtext,
                          ),
                        ),
                        FormWidget(
                          onChangedText: (value) {
                            setState(() {
                              tags = value;
                            });
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Enter the tags separated by commas",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.bolt_outlined,
                                color: Color(0xffdd312d),
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Make your job premium (optional)",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 10, top: 15),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text("Free Job"),
                                  leading: Radio(
                                    value: 1,
                                    groupValue: val,
                                    onChanged: (value) {
                                      setState(() {
                                        val = value as int;
                                      });
                                    },
                                    activeColor: Colors.red,
                                  ),
                                ),
                                Text(
                                  "Your job will go live after check by reviewer",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                ListTile(
                                  title: Text("Premium"),
                                  leading: Radio(
                                    value: 2,
                                    groupValue: val,
                                    onChanged: (value) {
                                      setState(() {
                                        val = value as int;
                                      });
                                    },
                                    activeColor: Colors.red,
                                  ),
                                ),
                              ],
                            )),

                        Visibility(
                          visible: (val == 2),
                          child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isFeaturedheck,
                                      checkColor: Colors.white,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(getColor),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isFeaturedheck = value!;
                                        });
                                        if (featureBalance > 0) {
                                          if (isFeaturedheck) {
                                            setState(() {
                                              isFeaturedBalUsed = true;
                                            });
                                          } else {
                                            setState(() {
                                              isFeaturedBalUsed = false;
                                            });
                                          }
                                        } else {
                                          if (isFeaturedheck) {
                                            setState(() {
                                              price = price +
                                                  int.parse(fetchedGroupInfo[
                                                          "featured_project_fee"]
                                                      .toString()
                                                      .split(".")
                                                      .first);
                                            });
                                          } else {
                                            setState(() {
                                              price = price -
                                                  int.parse(fetchedGroupInfo[
                                                          "featured_project_fee"]
                                                      .toString()
                                                      .split(".")
                                                      .first);
                                            });
                                          }
                                        }
                                      },
                                    ),
                                    Text(
                                      "Featured",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: const Color(0xff132144),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Featured jobs attract higher-quality viewer and are displayed prominently in the Featured jobs section home page.",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: const Color(0xff132144),
                                      fontWeight: FontWeight.w300,
                                      height: 1.4166666666666667,
                                    ),
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: false),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, top: 10),
                                  child: Text(
                                    (featureBalance > 0)
                                        ? "Available feature jobs : $featureBalance"
                                        : "£${fetchedGroupInfo["featured_project_fee"]} for ${fetchedGroupInfo["featured_duration"]} days",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: const Color(0xff132144),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isUrgentCheckd,
                                      checkColor: Colors.white,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(getColor),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isUrgentCheckd = value!;
                                        });
                                        if (urgentBalance > 0) {
                                          if (isUrgentCheckd) {
                                            setState(() {
                                              isUrgentBalUsed = true;
                                            });
                                          } else {
                                            isUrgentBalUsed = false;
                                          }
                                        } else {
                                          if (isUrgentCheckd) {
                                            setState(() {
                                              price = price +
                                                  int.parse(fetchedGroupInfo[
                                                          "urgent_project_fee"]
                                                      .toString()
                                                      .split(".")
                                                      .first);
                                            });
                                          } else {
                                            setState(() {
                                              price = price -
                                                  int.parse(fetchedGroupInfo[
                                                          "urgent_project_fee"]
                                                      .toString()
                                                      .split(".")
                                                      .first);
                                            });
                                          }
                                        }
                                      },
                                    ),
                                    Text(
                                      "Urgent",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: const Color(0xff132144),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Make your job stand out and let viewer know that your job is time sensitive.",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: const Color(0xff132144),
                                      fontWeight: FontWeight.w300,
                                      height: 1.4166666666666667,
                                    ),
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: false),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, top: 10),
                                  child: Text(
                                    (urgentBalance > 0)
                                        ? "Available feature jobs : $urgentBalance"
                                        : "£${fetchedGroupInfo["urgent_project_fee"]} for ${fetchedGroupInfo["urgent_duration"]} days",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: const Color(0xff132144),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isHighiLightCheckd,
                                      checkColor: Colors.white,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(getColor),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isHighiLightCheckd = value!;
                                        });
                                        if (highlightBalane > 0) {
                                          if (isHighiLightCheckd) {
                                            setState(() {
                                              isHighlighBalUsed = true;
                                            });
                                          } else {
                                            setState(() {
                                              isHighlighBalUsed = false;
                                            });
                                          }
                                        } else {
                                          if (isHighiLightCheckd) {
                                            setState(() {
                                              price = price +
                                                  int.parse(fetchedGroupInfo[
                                                          "highlight_project_fee"]
                                                      .toString()
                                                      .split(".")
                                                      .first);
                                            });
                                          } else {
                                            setState(() {
                                              price = price -
                                                  int.parse(fetchedGroupInfo[
                                                          "highlight_project_fee"]
                                                      .toString()
                                                      .split(".")
                                                      .first);
                                            });
                                          }
                                        }
                                      },
                                    ),
                                    Text(
                                      "Highlight",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: const Color(0xff132144),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Make your job highlighted with border in listing search result page. Easy to focus.",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: const Color(0xff132144),
                                      fontWeight: FontWeight.w300,
                                      height: 1.4166666666666667,
                                    ),
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: false),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, top: 10),
                                  child: Text(
                                    (highlightBalane > 0)
                                        ? "Available feature jobs : $highlightBalane"
                                        : "£${fetchedGroupInfo["highlight_project_fee"]} for ${fetchedGroupInfo["highlight_duration"]} days",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: const Color(0xff132144),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        if (price > 0)
                          Center(
                            child: Text(
                              "Total $price.00 GRB",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: const Color(0xff132144),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
                          child: Container(
                            height: 50,
                            width: 350,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(width: 1.0, color: Colors.white),
                                elevation: 10.0,
                                primary: const Color(0xffdd312d),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {
                                print(markdownToHtml.markdownToHtml(description));
                                if (price > 0) {
                                  setState(() {
                                    isPaid = true;
                                  });
                                } else {
                                  setState(() {
                                    isPaid = false;
                                  });
                                }
                                if (categoryMain == "Select Main Category") {
                                  Fluttertoast.showToast(
                                      msg: "Please select a main category");
                                } else if (categorySub == "Select Main Category") {
                                  Fluttertoast.showToast(
                                      msg: "Please select a sub categoy");
                                } else if (title == "" || title.trim() == "") {
                                  Fluttertoast.showToast(
                                      msg: "Please enter the job title");
                                } else if (description == "" ||
                                    description.trim() == "") {
                                  Fluttertoast.showToast(
                                      msg: "Please enter the description");
                                } else if (city == "") {
                                  Fluttertoast.showToast(
                                      msg: "Please select the city from the list");
                                } else if (isNewCompany &&
                                    (companyName == "" ||
                                        companyName.trim() == "" ||
                                        companyName == null)) {
                                  Fluttertoast.showToast(
                                      msg: "Please enter company name");
                                } else {
                                  setState(() {
                                    isSpin = true;
                                  });
                                  (price > 0)
                                      ? makePayment(price: price.toString())
                                      : createPost();
                                }
                              },
                              child: Text(
                                (price > 0) ? "Pay & Post Job" : "Post Job",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  color: Colors.white,
                                  letterSpacing: 0.7000000000000001,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Adlimit(),
    );
  }

  Future<void> makePayment({required String price}) async {
    try {
      paymentIntentData =
          await createPaymentIntent(price, 'INR'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print('payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));
        createPost();
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Something went wrong. Try again later")));
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong. Try again later")));
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KlPvqSDvq8Arat4N4XXJhQGqDMagzVSLCwmcBgOz6O9FG4Z8awybgdwUJwVF1oclZmFN8xJMeXiRxTiXZhEhnVF002cmtfisS',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
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

String company =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><path d="M6 2h12a2 2 0 0 1 2 2v18H4V4a2 2 0 0 1 2-2zm0 18h4v-4h4v4h4V4H6v16zm7-14h3v3h-3V6zm-5 5h3v3H8v-3zm5 0h3v3h-3v-3zM8 6h3v3H8V6z" fill="#dd312d" fill-rule="nonzero"/></svg>';
String suitcase =
    // '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><path d="M19 6.5h-3v-1a3 3 0 0 0-3-3h-2a3 3 0 0 0-3 3v1H5a3 3 0 0 0-3 3v9a3 3 0 0 0 3 3h14a3 3 0 0 0 3-3v-9a3 3 0 0 0-3-3zm-9-1a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v1h-4zm10 13a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-5.05h3v1.05a1 1 0 0 0 2 0v-1.05h6v1.05a1 1 0 0 0 2 0v-1.05h3zm0-7H4v-2a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1z" fill="#dd312d"/></svg>';
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1.17em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1536"><rect x="0" y="0" width="1792" height="1536" fill="none" stroke="none" /><path d="M640 256h512V128H640v128zm-352 0v1280h-64q-92 0-158-66T0 1312V480q0-92 66-158t158-66h64zm1120 0v1280H384V256h128V96q0-40 28-68t68-28h576q40 0 68 28t28 68v160h128zm384 224v832q0 92-66 158t-158 66h-64V256h64q92 0 158 66t66 158z" fill="#dd312d"/></svg>';
String tick =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 15 15"><rect x="0" y="0" width="15" height="15" fill="none" stroke="none" /><g fill="none"><path d="M4 7.5L7 10l4-5m-3.5 9.5a7 7 0 1 1 0-14a7 7 0 0 1 0 14z" stroke="white"/></g></svg>';
