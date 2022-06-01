// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../globalVariables.dart';
import 'Sidemenu.dart';
import 'allJobsSearch.dart';
import 'jobDetails.dart';
import 'widget/favItemComponentWidget.dart';

class SearchwithLocation extends StatefulWidget {
  static const String idScreen = "searchWithLocation";
  final String searchLocation;
  const SearchwithLocation({required this.searchLocation});

  @override
  _SearchwithLocationState createState() => _SearchwithLocationState();
}

class _SearchwithLocationState extends State<SearchwithLocation> {
  TextEditingController locationConroller = TextEditingController(text: "");
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
  var allJobsList = [];

  bool isSpin = true;
  Map pageData = {};
  int offset = 1;
  List favIdsRec = [];
  Map favIdData = {};
  bool isAllJobsSearchEmpty = false;

  //---------------urgent php------

  Future gettingFavJobsIds() async {
    var url = Uri.parse(defaultUrl + 'mob_fav_jobs_ids');
    setState(() {
      favIdData['id'] = userDetailsResponse['id'];
    });

    var response = await http.post(url, body: json.encode(favIdData));
    setState(() {
      favIdsRec = jsonDecode(response.body);
    });
    print("favIds");
    print(favIdsRec);
  }

  Future gettingAllJobs() async {
    var url = Uri.parse(defaultUrl + 'mob_search_with_location');
    setState(() {
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['keyword'] = widget.searchLocation;
    });
    try {
      var response = await http.post(url, body: json.encode(pageData));
      alljobs = jsonDecode(response.body);
      print(alljobs);

      alljobs['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print(allJobsList);
    } catch (error) {
      print(error);
      setState(() {
        isAllJobsSearchEmpty = true;
      });
    }
    setState(() {
      isSpin = false;
    });
  }

  Future gettingAllJobsLoop() async {
    var url = Uri.parse(defaultUrl + 'mob_search_with_location');
    setState(() {
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['keyword'] = widget.searchLocation;
    });
    var response = await http.post(url, body: json.encode(pageData));

    try {
      alljobs1 = jsonDecode(response.body);
      print(alljobs1);

      alljobs1['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print(allJobsList);
      alljobs['all'].addAll(alljobs1['all']);
    } on FormatException catch (e) {
      gettingAllJobsLoopOnExecption();
    } catch (error) {
      print(error);
    }
    setState(() {
      isDataLoadProgress = false;
    });
  }

  Future gettingAllJobsLoopOnExecption() async {
    var url = Uri.parse(defaultUrl + 'mob_search_with_location');

    setState(() {
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['keyword'] = widget.searchLocation;
    });
    var response = await http.post(url, body: json.encode(pageData));

    try {
      alljobs1 = jsonDecode(response.body);
      print(alljobs1);

      alljobs1['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print(allJobsList);
      alljobs['all'].addAll(alljobs1['all']);
    } on FormatException catch (e) {
      print(e);
    } catch (error) {
      print(error);
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
    setState(() {
      locationConroller.text = widget.searchLocation;
    });
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
            : SingleChildScrollView(
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
                                controller: locationConroller,
                                onChanged: (value) {
                                  setState(() {
                                    searchKeyword = value;
                                  });
                                },
                                onSubmitted: (value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllJobsSearch()));
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
                                                  [allJobsList[i].toString()]['location'],
                                              country: alljobs['all']
                                                  [allJobsList[i].toString()]['country'],
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
                                                  [allJobsList[i].toString()]['user_id'],
                                              jobID: alljobs['all']
                                                  [allJobsList[i].toString()]['id'],
                                              isFav: favIdsRec.contains(alljobs['all']
                                                  [allJobsList[i].toString()]['id']),
                                              link: alljobs['all']
                                                  [allJobsList[i].toString()]['link'],
                                            )));
                              },
                              child: FavItemComponentWidget(
                                isFav: favIdsRec.contains(
                                    alljobs['all'][allJobsList[i].toString()]['id']),
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
                                view: alljobs['all'][allJobsList[i].toString()]['view'],
                                img: alljobs['all'][allJobsList[i].toString()]
                                    ['company_image'],
                                salType: alljobs['all'][allJobsList[i].toString()]
                                    ['salary_type'],
                                prodID: alljobs['all'][allJobsList[i].toString()]
                                    ['product_type'],
                                msgId: alljobs['all'][allJobsList[i].toString()]
                                    ['user_id'],
                                jobId: alljobs['all'][allJobsList[i].toString()]['id'],
                                feature: alljobs['all'][allJobsList[i].toString()]
                                        ['featured']
                                    .toString(),
                                highlight: alljobs['all'][allJobsList[i].toString()]
                                        ['highlight']
                                    .toString(),
                                urgent: alljobs['all'][allJobsList[i].toString()]
                                        ['urgent']
                                    .toString(),
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
