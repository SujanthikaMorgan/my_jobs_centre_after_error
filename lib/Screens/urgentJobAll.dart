// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:adobe_xd/page_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../globalVariables.dart';
import '../mysql.dart';
import 'Component34.dart';
import 'Search.dart';
import 'Sidemenu.dart';
import 'allJobsSearch.dart';
import 'jobDetails.dart';
import 'widget/favItemComponentWidget.dart';

class UrgentJobsAll extends StatefulWidget {
  static const String idScreen = 'urgentJobsAll';
  const UrgentJobsAll({Key? key}) : super(key: key);

  @override
  _UrgentJobsAllState createState() => _UrgentJobsAllState();
}

class _UrgentJobsAllState extends State<UrgentJobsAll> {
  var dbFavJob = new Mysql();
  var resultFavJob;
  var resultFavJobProducts;
  var favJobsIds = [];
  var prodAdId = [];
  var companyIDFav = [];
  var productNameFav = [];
  var cityIDFav = [];
  var countryIDFav = [];
  var createdAtFav = [];
  var prodTypeFav = [];
  var viewFav = [];
  var salMinFav = [];
  var salMaxFav = [];
  var descriptionFav = [];
  var salaryTypeFavID = [];
  var resultFavJobCompName = [];
  var resultFavSalaryType = [];
  var companyNameFav = [];
  var imageFav = [];
  var salaryTypeFavName = [];
  var resultFavJobType = [];
  var jobTypeFav = [];
  var resultFavCountry = [];
  var countryFav = [];
  var currencyFav = [];
  var resultFavCity = [];
  var cityFav = [];
  Map urgentJobsUrgent = {};
  Map urgentJobsUrgent1 = {};
  // var urgentJobsListFeat = [];
  // Map featuredJobsFeat = {};
  var featuredJobsListUrgent = [];
  List favIdsRec = [];

  bool isSpin = true;

  Map pageData = {};
  Map favIdData = {};
  int offset = 1;
  bool isUrgentAllEmpty = false;

  //---------------urgent php------

  Future gettingFavJobsIds() async {
    var url = Uri.parse(defaultUrl + 'mob_fav_jobs_ids');
    setState(() {
      favIdData['id'] = userDetailsResponse['id'];
    });

    var response = await http.post(url, body: json.encode(favIdData));
    try {
      setState(() {
        favIdsRec = jsonDecode(response.body);
      });
      print("favIds");
    } catch (e) {
      // print(e);
    }
    print(favIdsRec);
  }

  Future gettingUrgentJobs() async {
    var url = Uri.parse(defaultUrl + 'mob_urgent');
    setState(() {
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
    });
    var response = await http.post(url, body: json.encode(pageData));
    urgentJobsUrgent = jsonDecode(response.body);

    try {
      urgentJobsUrgent['urgent']
          .forEach((k, v) => featuredJobsListUrgent.add(Applied(k)));
      print("Urgent length = ${urgentJobsUrgent['urgent'].length}");
    } catch (error) {
      print(error);
      setState(() {
        isUrgentAllEmpty = true;
      });
    }
    setState(() {
      isSpin = false;
    });
  }

  Future gettingAllJobsLoop() async {
    var url = Uri.parse(defaultUrl + 'mob_urgent');
    setState(() {
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
    });
    var response = await http.post(url, body: json.encode(pageData));

    try {
      urgentJobsUrgent1 = jsonDecode(response.body);
      print(urgentJobsUrgent1);

      urgentJobsUrgent1['urgent']
          .forEach((k, v) => featuredJobsListUrgent.add(Applied(k)));
      print(featuredJobsListUrgent);
      urgentJobsUrgent['urgent'].addAll(urgentJobsUrgent1['urgent']);
    } on FormatException catch (e) {
      gettingAllJobsLoopOnExecption();
    } on NoSuchMethodError catch (e) {
      print("finished");
    }

    setState(() {
      isDataLoadProgress = false;
    });
  }

  Future gettingAllJobsLoopOnExecption() async {
    var url = Uri.parse(defaultUrl + 'mob_urgent');
    setState(() {
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
    });
    var response = await http.post(url, body: json.encode(pageData));
    try {
      urgentJobsUrgent1 = jsonDecode(response.body);
      print(urgentJobsUrgent1);

      urgentJobsUrgent1['urgent']
          .forEach((k, v) => featuredJobsListUrgent.add(Applied(k)));
      print(featuredJobsListUrgent);
      urgentJobsUrgent['urgent'].addAll(urgentJobsUrgent1['urgent']);
    } on FormatException catch (e) {
      gettingAllJobsLoopOnExecption();
    } on NoSuchMethodError catch (e) {
      print("finished");
    }

    setState(() {
      isDataLoadProgress = false;
    });
  }

  bool isScrolling = true;
  late ScrollController _controller;
  bool isDataLoadProgress = false;
  @override
  void initState() {
    gettingFavJobsIds();
    gettingFavJobsIds();
    gettingUrgentJobs();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        isDataLoadProgress = true;
        isScrolling = false;
        gettingAllJobsLoop();
        // getProducts();
      });
    } else {
      setState(() {
        isScrolling = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: Sidemenu(),
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
            'Urgent Jobs',
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
                  radius: 25,
                ),
              )
            : Stack(
                children: [
                  SingleChildScrollView(
                    controller: _controller,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Container(
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  color: Colors.white,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        searchKeyword = value;
                                      });
                                    },
                                    onSubmitted: (value) {
                                      if (searchKeyword != "" &&
                                          searchKeyword != null &&
                                          searchKeyword.trim() != null)
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) => AllJobsSearch(
                                                      searchTermRec: searchKeyword,
                                                    ))));
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: const Color(0x80788198),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              if (isUrgentAllEmpty)
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.15),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.height * 0.15),
                                    child: Text(
                                      "No Urgent Jobs Found For Your Country",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: const Color(0xff1d1d1d),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              for (int i = 0; i < featuredJobsListUrgent.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => JobDetailsScreen(
                                                  isApplyShow: true,
                                                  company: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['company_name'],
                                                  title: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['product_name'],
                                                  city: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['location'],
                                                  country: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['country'],
                                                  type: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['product_type'],
                                                  date: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['created_at'],
                                                  view: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['view'],
                                                  minSal: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['salary_min'],
                                                  maxSal: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['salary_max'],
                                                  salType: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['salary_type'],
                                                  description: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['desc'],
                                                  img: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['company_image'],
                                                  idChat: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['user_id'],
                                                  jobID: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['id'],
                                                  isFav: favIdsRec.contains(
                                                      urgentJobsUrgent['urgent'][
                                                          featuredJobsListUrgent[i]
                                                              .toString()]['id']),
                                                  link: urgentJobsUrgent['urgent'][
                                                      featuredJobsListUrgent[i]
                                                          .toString()]['link'],
                                                )));
                                  },
                                  child: FavItemComponentWidget(
                                    isFav: favIdsRec.contains(urgentJobsUrgent['urgent']
                                        [featuredJobsListUrgent[i].toString()]['id']),
                                    city: urgentJobsUrgent['urgent']
                                            [featuredJobsListUrgent[i].toString()]
                                        ['location'],
                                    country: urgentJobsUrgent['urgent']
                                        [featuredJobsListUrgent[i].toString()]['country'],
                                    date: urgentJobsUrgent['urgent']
                                            [featuredJobsListUrgent[i].toString()]
                                        ['created_at'],
                                    description: urgentJobsUrgent['urgent']
                                        [featuredJobsListUrgent[i].toString()]['desc'],
                                    maxSal: urgentJobsUrgent['urgent']
                                            [featuredJobsListUrgent[i].toString()]
                                        ['salary_max'],
                                    minSal: urgentJobsUrgent['urgent']
                                            [featuredJobsListUrgent[i].toString()]
                                        ['salary_min'],
                                    title: urgentJobsUrgent['urgent']
                                            [featuredJobsListUrgent[i].toString()]
                                        ['product_name'],
                                    type: urgentJobsUrgent['urgent']
                                            [featuredJobsListUrgent[i].toString()]
                                        ['product_type'],
                                    view: urgentJobsUrgent['urgent']
                                        [featuredJobsListUrgent[i].toString()]['view'],
                                    img: urgentJobsUrgent['urgent']
                                            [featuredJobsListUrgent[i].toString()]
                                        ['company_image'],
                                    salType: urgentJobsUrgent['urgent']
                                            [featuredJobsListUrgent[i].toString()]
                                        ['salary_type'],
                                    // currency:
                                    //     currencyFeat[i].toString(),
                                    prodID: urgentJobsUrgent['urgent']
                                            [featuredJobsListUrgent[i].toString()]
                                        ['product_type'],
                                    msgId: urgentJobsUrgent['urgent']
                                        [featuredJobsListUrgent[i].toString()]['user_id'],
                                    jobId: urgentJobsUrgent['urgent']
                                        [featuredJobsListUrgent[i].toString()]['id'],
                                    feature: urgentJobsUrgent['urgent']
                                                [featuredJobsListUrgent[i].toString()]
                                            ['featured']
                                        .toString(),
                                    highlight: urgentJobsUrgent['urgent']
                                                [featuredJobsListUrgent[i].toString()]
                                            ['highlight']
                                        .toString(),
                                    urgent: urgentJobsUrgent['urgent']
                                                [featuredJobsListUrgent[i].toString()]
                                            ['urgent']
                                        .toString(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      child: SizedBox(
                        height: 60,
                        child: Component34(),
                      ),
                    ),
                  ),
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
