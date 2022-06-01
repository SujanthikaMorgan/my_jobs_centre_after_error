// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, prefer_final_fields

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:my_jobs_center/employer/employer%20screens/jobPost.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/formwidget.dart';
import 'package:my_jobs_center/employer/widget/pallette.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:html2md/html2md.dart' as html2md;
import 'package:markdown/markdown.dart' as markdownToHtml;

class EditJobs extends StatefulWidget {
  final String mainCat;
  final String subCat;
  final String title;
  final String description;
  final String jobType;
  final String salary;
  final String minSal;
  final String maxSal;
  final String salType;
  final bool isNegotiable;
  final String phone;
  final bool isHidePhone;
  final String city;
  final String applicationURL;
  final String tags;
  final String jobId;

  const EditJobs(
      {Key? key,
      required this.mainCat,
      required this.subCat,
      required this.title,
      required this.description,
      required this.jobType,
      required this.salary,
      required this.minSal,
      required this.maxSal,
      required this.salType,
      required this.isNegotiable,
      required this.phone,
      required this.isHidePhone,
      required this.city,
      required this.applicationURL,
      required this.tags,
      required this.jobId})
      : super(key: key);

  @override
  _EditJobsState createState() => _EditJobsState();
}

class _EditJobsState extends State<EditJobs> {
  TextEditingController _titleController = TextEditingController(text: "");
  TextEditingController _descriptionController = TextEditingController(text: "");
  TextEditingController _minSalController = TextEditingController(text: "");
  TextEditingController _maxSalController = TextEditingController(text: "");
  TextEditingController _phoneController = TextEditingController(text: "");
  TextEditingController _cityController = TextEditingController(text: "");
  TextEditingController _tagsController = TextEditingController(text: "");
  TextEditingController _applicationURLController = TextEditingController(text: "");

  bool isChecked = false;
  bool value = false;
  int val = 0;
  String compname = '[+] New Company';
  var companies = ['[+] New Company'];
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
  String selectedCityIndex = "0";

  List<String> _kOptions = [];
  Map fetchedCities = {};

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
    subCatMapKeys.clear();
    subCatMap = categoryDetailsResponse["sub_cat"];
    subCatMap.forEach((k, v) => subCatMapKeys.add(Applied(k)));
    print(subCatMapKeys);

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
    print(widget.jobId);
    // String uploadurl = "http://10.0.2.2/myjobscenter/demo/mob_add_company";
    String uploadurl = defaultUrl + "mob_edit_job";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP
    FormData formdata = FormData.fromMap({
      "company_logo": (fileComp != null)
          ? await MultipartFile.fromFile(fileComp!.path,
              filename: basename(fileComp!.path)
              //show only filename from path
              )
          : null,
      "job_image": (fileJob != null)
          ? await MultipartFile.fromFile(fileJob!.path, filename: basename(fileJob!.path)
              //show only filename from path
              )
          : null,
      "user_id": userDetailsResponse['id'],
      "username": userDetailsResponse['username'],
      "job_id": widget.jobId,
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
      // "application_url": applicationURL,
      "city": selectedCityIndex,
      "tags": tags,
      "company_enable": true,
      "job_image_field": true,
      "submit": true,
      "title": title,
      "usernameG": username_glob,
      "passwordG": password_glob

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
      Navigator.pushReplacement(
          this.context, MaterialPageRoute(builder: (context) => JobPost()));

      // setState(() {});
      //print response from server
    } else {
      print("Error during connection to server.");
      print(response.statusMessage);
      setState(() {
        isSpin = false;
      });
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

  @override
  void initState() {
    citiesFetched().then((value) {
      setState(() {
        int initIndex = fetchedCities['cities'].indexOf(widget.city);
        selectedCityIndex = fetchedCities['city_id'][initIndex];
      });
    });

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

    setState(() {
      _titleController = TextEditingController(text: widget.title);
      _descriptionController =
          TextEditingController(text: html2md.convert(widget.description));
      _minSalController = TextEditingController(text: widget.minSal);
      _maxSalController = TextEditingController(text: widget.maxSal);
      _phoneController = TextEditingController(text: widget.phone);
      _cityController = TextEditingController(text: widget.city);
      _tagsController = TextEditingController(text: widget.tags);
      _applicationURLController = TextEditingController(text: widget.applicationURL);

      title = widget.title;
      description = html2md.convert(widget.description);
      minSal = int.parse(widget.minSal);
      maxSal = int.parse(widget.maxSal);
      phoneNumber = widget.phone;
      city = widget.city;
      tags = widget.tags;
      applicationURL = widget.applicationURL;
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
        backgroundColor: const Color(0xfff7f9fc),
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
          "Edit Job",
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
                radius: 20,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 15),
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
                      controller: _titleController,
                      onChangedText: (value) {
                        title = value;
                      },
                      // ic: '',
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10),
                    //   child: Text(
                    //     "Image",
                    //     style: formtext,
                    //   ),
                    // ),
                    // Row(
                    //   children: [
                    //     Column(
                    //       children: [
                    //         Padding(
                    //           padding: EdgeInsets.only(left: 15, top: 15),
                    //           child: Container(
                    //             height: 50,
                    //             width: 160,
                    //             child: ElevatedButton(
                    //               style: ElevatedButton.styleFrom(
                    //                 side: BorderSide(
                    //                     width: 1.0,
                    //                     color: const Color(0xffdd312d)),
                    //                 elevation: 10.0,
                    //                 primary: Colors.white,
                    //                 shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(8.0),
                    //                 ),
                    //               ),
                    //               onPressed: () {
                    //                 selectFileJob();
                    //               },
                    //               child: Text(
                    //                 "Upload Image",
                    //                 style: TextStyle(
                    //                   fontFamily: 'Poppins',
                    //                   fontSize: 16,
                    //                   color: const Color(0xffdd312d),
                    //                   letterSpacing: 0.7000000000000001,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     Expanded(
                    //       child: Column(
                    //         children: [
                    //           Padding(
                    //             padding: EdgeInsets.only(left: 20),
                    //             child: Text(
                    //               "Use 200x200px size for better view.",
                    //               style: TextStyle(
                    //                 fontFamily: 'Poppins',
                    //                 fontSize: 17,
                    //                 color: Colors.grey,
                    //                 letterSpacing: 0.7000000000000001,
                    //               ),
                    //               overflow: TextOverflow.visible,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // ),
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
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        ),
                        // controller: controller,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(10),
                    //   child: TextFormField(
                    //     controller: _descriptionController,
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
                      padding: EdgeInsets.all(12.0),
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
                              items:
                                  jobTypes.map<DropdownMenuItem<String>>((String value) {
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
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 60,
                              child: TextFormField(
                                controller: _minSalController,
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
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 35),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 60,
                              child: TextFormField(
                                controller: _maxSalController,
                                onChanged: (value) {
                                  setState(() {
                                    salMax = value;
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
                            ))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
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
                    // Padding(
                    //   padding: EdgeInsets.all(
                    //     12,
                    //   ),
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
                    //       suffixIcon: DropdownButton(
                    //         value: salarytype,
                    //         icon: Icon(
                    //           Icons.arrow_drop_down,
                    //         ),
                    //         items: types.map((String items) {
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
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "Phone Number",
                        style: formtext,
                      ),
                    ),
                    IntlPhoneField(
                      controller: _phoneController,
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

                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "City *",
                        style: formtext,
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
                                controller: _cityController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.black, width: 5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.black, width: 3),
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
                              _cityController.text = suggestion!;
                              setState(() {
                                int index = fetchedCities['cities'].indexOf(suggestion);
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
                            suggestionsCallback: (query) => _kOptions.where((element) =>
                                element.toLowerCase().contains(query.toLowerCase())),
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
                    // FormWidget(
                    //   controller: _cityController,
                    //   onChangedText: (value) {
                    //     setState(() {
                    //       city = value;
                    //     });
                    //   },
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 15),
                    //   child: Text(
                    //     "Application URL",
                    //     style: formtext,
                    //   ),
                    // ),
                    // FormWidget(
                    //   controller: _applicationURLController,
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
                      controller: _tagsController,
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
                              if (categoryMain == "Select Main Category") {
                                Fluttertoast.showToast(
                                    msg: "Please select a main category");
                              } else if (categorySub == "Select Main Category") {
                                Fluttertoast.showToast(
                                    msg: "Please select a sub categoy");
                              } else if (title == "" || title.trim() == "") {
                                Fluttertoast.showToast(msg: "Please enter the job title");
                              } else if (description == "" || description.trim() == "") {
                                Fluttertoast.showToast(
                                    msg: "Please enter the description");
                              } else if (city == "") {
                                Fluttertoast.showToast(
                                    msg: "Please select the city from the list");
                              } else {
                                setState(() {
                                  isSpin = true;
                                });
                                createPost();
                              }
                            },
                            child: Text(
                              "Post a Job",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                color: Colors.white,
                                letterSpacing: 0.7000000000000001,
                              ),
                            ),
                          ),
                        ))
                  ],
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

String company =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><path d="M6 2h12a2 2 0 0 1 2 2v18H4V4a2 2 0 0 1 2-2zm0 18h4v-4h4v4h4V4H6v16zm7-14h3v3h-3V6zm-5 5h3v3H8v-3zm5 0h3v3h-3v-3zM8 6h3v3H8V6z" fill="#dd312d" fill-rule="nonzero"/></svg>';
String suitcase =
    // '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><path d="M19 6.5h-3v-1a3 3 0 0 0-3-3h-2a3 3 0 0 0-3 3v1H5a3 3 0 0 0-3 3v9a3 3 0 0 0 3 3h14a3 3 0 0 0 3-3v-9a3 3 0 0 0-3-3zm-9-1a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v1h-4zm10 13a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-5.05h3v1.05a1 1 0 0 0 2 0v-1.05h6v1.05a1 1 0 0 0 2 0v-1.05h3zm0-7H4v-2a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1z" fill="#dd312d"/></svg>';
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1.17em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1536"><rect x="0" y="0" width="1792" height="1536" fill="none" stroke="none" /><path d="M640 256h512V128H640v128zm-352 0v1280h-64q-92 0-158-66T0 1312V480q0-92 66-158t158-66h64zm1120 0v1280H384V256h128V96q0-40 28-68t68-28h576q40 0 68 28t28 68v160h128zm384 224v832q0 92-66 158t-158 66h-64V256h64q92 0 158 66t66 158z" fill="#dd312d"/></svg>';
String tick =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 15 15"><rect x="0" y="0" width="15" height="15" fill="none" stroke="none" /><g fill="none"><path d="M4 7.5L7 10l4-5m-3.5 9.5a7 7 0 1 1 0-14a7 7 0 0 1 0 14z" stroke="white"/></g></svg>';
