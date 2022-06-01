// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/Screens/Component34.dart';
import 'package:my_jobs_center/Screens/Sidemenu.dart';
import 'package:my_jobs_center/Screens/allJobsSearch.dart';
import 'package:my_jobs_center/Screens/jobDetails.dart';
import 'package:my_jobs_center/Screens/widget/favItemComponentWidget.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:http/http.dart' as http;

class AllJObsWithCats extends StatefulWidget {
  final String catId;
  final String? subcatId;
  const AllJObsWithCats({required this.catId, this.subcatId});

  @override
  _AllJObsWithCatsState createState() => _AllJObsWithCatsState();
}

class _AllJObsWithCatsState extends State<AllJObsWithCats> {
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
  Map alljobs = {};
  Map alljobs1 = {};
  // var urgentJobsListFeat = [];
  // Map featuredJobsFeat = {};
  var allJobsList = [];

  bool isSpin = true;
  Map pageData = {};
  int offset = 1;
  List favIdsRec = [];
  Map favIdData = {};
  bool isAllJobsSearchEmpty = false;

  //---------------urgent php------

  Future gettingFavJobsIds() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_fav_jobs_ids');
    var url = Uri.parse(defaultUrl + 'mob_fav_jobs_ids');
    setState(() {
      favIdData['id'] = userDetailsResponse['id'];
    });

    var response = await http.post(url, body: json.encode(favIdData));
    try {
      setState(() {
        favIdsRec = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
    print("favIds");
    print(favIdsRec);
  }

  Future gettingAllJobs() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_jobs_with_cat');
    var url = Uri.parse(defaultUrl + 'mob_jobs_with_cat');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    setState(() {
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
      pageData['category'] = widget.catId;
      if (widget.subcatId != null) {
        pageData['sub_category'] = widget.subcatId;
      }
    });
    try {
      var response = await http.post(url, body: json.encode(pageData));
      // var response = await http.post(url);
      alljobs = jsonDecode(response.body);
      print(alljobs);

      alljobs['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print("-------------------------------------------------");
      print(allJobsList);
      print("-------------------------------------------------");

      print(alljobs['all'][allJobsList[0].toString()]);
      print("-------------------------------------------------");
    } catch (error) {
      print(error);
      setState(() {
        isAllJobsSearchEmpty = true;
      });
    }

    // print(appliedJobs);
    // print(appliedJobs
    //     .map((i, element) => MapEntry(i, print(appliedJobs[i].toString()))));
    setState(() {
      isSpin = false;
    });
  }

  Future gettingAllJobsLoop() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_all_jobs');
    var url = Uri.parse(defaultUrl + 'mob_jobs_with_cat');

    // Starting Web API Call.

    setState(() {
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
      pageData['category'] = widget.catId;
      if (widget.subcatId != null) {
        pageData['sub_category'] = widget.subcatId;
      }
    });
    var response = await http.post(url, body: json.encode(pageData));
    // var response = await http.post(url);

    try {
      alljobs1 = jsonDecode(response.body);
      print(alljobs1);

      alljobs1['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print("-------------------------------------------------");
      print(allJobsList);
      print("-------------------------------------------------");
      alljobs['all'].addAll(alljobs1['all']);
      print(alljobs['all'][allJobsList[0].toString()]);
      print("-------------------------------------------------");
    } on FormatException catch (e) {
      gettingAllJobsLoopOnExecption();
    } catch (error) {
      print(error);
    }
    // if (jsonDecode(response.body) == null) {
    //   print("null received");
    // } else {
    //   alljobs1 = jsonDecode(response.body);
    //   print(alljobs1);

    //   alljobs1['all'].forEach((k, v) => allJobsList.add(Applied(k)));
    //   print("-------------------------------------------------");
    //   print(allJobsList);
    //   print("-------------------------------------------------");
    //   alljobs['all'].addAll(alljobs1['all']);
    //   print(alljobs['all'][allJobsList[0].toString()]);
    //   print("-------------------------------------------------");
    // }

    setState(() {
      isDataLoadProgress = false;
    });
  }

  Future gettingAllJobsLoopOnExecption() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_all_jobs');
    var url = Uri.parse(defaultUrl + 'mob_jobs_with_cat');

    // Starting Web API Call.

    setState(() {
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
      pageData['category'] = widget.catId;
      if (widget.subcatId != null) {
        pageData['sub_category'] = widget.subcatId;
      }
    });
    var response = await http.post(url, body: json.encode(pageData));
    // var response = await http.post(url);

    try {
      alljobs1 = jsonDecode(response.body);
      print(alljobs1);

      alljobs1['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print("-------------------------------------------------");
      print(allJobsList);
      print("-------------------------------------------------");
      alljobs['all'].addAll(alljobs1['all']);
      print(alljobs['all'][allJobsList[0].toString()]);
      print("-------------------------------------------------");
    } on FormatException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
    // if (jsonDecode(response.body) == null) {
    //   print("null received");
    // } else {
    //   alljobs1 = jsonDecode(response.body);
    //   print(alljobs1);

    //   alljobs1['all'].forEach((k, v) => allJobsList.add(Applied(k)));
    //   print("-------------------------------------------------");
    //   print(allJobsList);
    //   print("-------------------------------------------------");
    //   alljobs['all'].addAll(alljobs1['all']);
    //   print(alljobs['all'][allJobsList[0].toString()]);
    //   print("-------------------------------------------------");
    // }

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
    gettingAllJobs();
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
                              if (isAllJobsSearchEmpty)
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.15),
                                  child: Text(
                                    "No Jobs Found",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: const Color(0xff1d1d1d),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              for (int i = 0; i < allJobsList.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => JobDetailsScreen(
                                                  isApplyShow: true,
                                                  company: alljobs['all']
                                                          [allJobsList[i].toString()]
                                                      ['company_name'],
                                                  title: alljobs['all']
                                                          [allJobsList[i].toString()]
                                                      ['product_name'],
                                                  city: alljobs['all']
                                                          [allJobsList[i].toString()]
                                                      ['location'],
                                                  country: alljobs['all']
                                                          [allJobsList[i].toString()]
                                                      ['country'],
                                                  type: alljobs['all']
                                                          [allJobsList[i].toString()]
                                                      ['product_type'],
                                                  date: alljobs['all']
                                                          [allJobsList[i].toString()]
                                                      ['created_at'],
                                                  view: alljobs['all']
                                                      [allJobsList[i].toString()]['view'],
                                                  minSal: alljobs['all']
                                                          [allJobsList[i].toString()]
                                                      ['salary_min'],
                                                  maxSal: alljobs['all']
                                                          [allJobsList[i].toString()]
                                                      ['salary_max'],
                                                  // currency: currencyFeat[i]
                                                  //     .toString(),
                                                  salType: alljobs['all']
                                                          [allJobsList[i].toString()]
                                                      ['salary_type'],
                                                  description: alljobs['all']
                                                          [allJobsList[i].toString()]
                                                      ['description'],
                                                  img: alljobs['all']
                                                          [allJobsList[i].toString()]
                                                      ['company_image'],
                                                  idChat: alljobs['all']
                                                          [allJobsList[i].toString()]
                                                      ['user_id'],
                                                  jobID: alljobs['all']
                                                      [allJobsList[i].toString()]['id'],
                                                  isFav: favIdsRec.contains(alljobs['all']
                                                      [allJobsList[i].toString()]['id']),
                                                  link: alljobs['all']
                                                              [allJobsList[i].toString()]
                                                          ['link']
                                                      .toString(),
                                                )));
                                  },
                                  child: FavItemComponentWidget(
                                    isFav: favIdsRec.contains(
                                        alljobs['all'][allJobsList[i].toString()]['id']),
                                    // isFav: (favJobsIdsAlready
                                    //         .contains(prodAdIddFeat[i]))
                                    //     ? true
                                    //     : false,

                                    city: alljobs['all'][allJobsList[i].toString()]
                                        ['location'],
                                    country: alljobs['all'][allJobsList[i].toString()]
                                        ['country'],
                                    date: alljobs['all'][allJobsList[i].toString()]
                                        ['created_at'],
                                    description: alljobs['all'][allJobsList[i].toString()]
                                        ['description'],
                                    maxSal: alljobs['all'][allJobsList[i].toString()]
                                        ['salary_max'],
                                    minSal: alljobs['all'][allJobsList[i].toString()]
                                        ['salary_min'],
                                    title: alljobs['all'][allJobsList[i].toString()]
                                        ['product_name'],
                                    type: alljobs['all'][allJobsList[i].toString()]
                                        ['product_type'],
                                    view: alljobs['all'][allJobsList[i].toString()]
                                        ['view'],
                                    img: alljobs['all'][allJobsList[i].toString()]
                                        ['company_image'],
                                    salType: alljobs['all'][allJobsList[i].toString()]
                                        ['salary_type'],
                                    // currency:
                                    //     currencyFeat[i].toString(),
                                    prodID: alljobs['all'][allJobsList[i].toString()]
                                        ['product_type'],
                                    msgId: alljobs['all'][allJobsList[i].toString()]
                                        ['user_id'],
                                    jobId: alljobs['all'][allJobsList[i].toString()]
                                        ['id'],
                                    feature: alljobs['all'][allJobsList[i].toString()]
                                        ['featured'],
                                    highlight: alljobs['all'][allJobsList[i].toString()]
                                        ['highlight'],
                                    urgent: alljobs['all'][allJobsList[i].toString()]
                                        ['urgent'],
                                  ),
                                ),
                              isDataLoadProgress
                                  ? CupertinoActivityIndicator(
                                      radius: 15,
                                    )
                                  : SizedBox(),
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
