// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:adobe_xd/page_link.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:my_jobs_center/Screens/Component34.dart';
import 'package:my_jobs_center/Screens/Component371.dart';
import 'package:my_jobs_center/Screens/Search.dart';
import 'package:my_jobs_center/Screens/Search_filter.dart';
import 'package:my_jobs_center/Screens/Sidemenu.dart';
import 'package:my_jobs_center/Screens/allJobs.dart';
import 'package:my_jobs_center/Screens/allJobsSearch.dart';
import 'package:my_jobs_center/Screens/allJobsWithCats.dart';
import 'package:my_jobs_center/Screens/categoriesDisplay.dart';
import 'package:my_jobs_center/Screens/featuredJobsAll.dart';
import 'package:my_jobs_center/Screens/jobDetails.dart';
import 'package:my_jobs_center/Screens/searchWithLocation.dart';
import 'package:my_jobs_center/Screens/urgentJobAll.dart';
import 'package:my_jobs_center/Screens/widget/HighlightedJobsWidget.dart';
import 'package:my_jobs_center/Screens/widget/UrgentJobCategoryWidget.dart';
import 'package:my_jobs_center/Screens/widget/categoryItemWidget.dart';
import 'package:my_jobs_center/Screens/widget/favItemComponentWidget.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:my_jobs_center/mysql.dart';
import 'package:http/http.dart' as http;

class HomeJob extends StatefulWidget {
  static const String idScreen = "HomeJobs";
  const HomeJob({Key? key}) : super(key: key);

  @override
  _HomeJobState createState() => _HomeJobState();
}

class _HomeJobState extends State<HomeJob> {
  List<String> _kOptions = [];
  var dbUrgentJob = new Mysql();
  var dbHighlightJob = new Mysql();
  var dbFeaturedJob = new Mysql();
  var resultUrgentJob;
  var resultFeaturedJob;
  var resultUrgentJobType = [];
  var resultFeatJobType = [];
  var resultUrgentCountry = [];
  var resultFeatCountry = [];
  var resultUrgentCity = [];
  var resultFeatCity = [];
  var resultUrgentJobCompName = [];
  var resultFeatJobCompName = [];
  var resultFeatSalaryType = [];
  var resultUrgSalaryType = [];
  var resultFeatCurrency = [];
  var companyIDUrg = [];
  var companyName = [];
  var companyNameFeat = [];
  var productNameUrg = [];
  var cityIDUrg = [];
  var city = [];
  var cityFeat = [];
  var countryIDUrg = [];
  var country = [];
  var countryFeat = [];
  var countryFeatIdId = [];
  var createdAtUrg = [];
  var prodTypeUrg = [];
  var jobType = [];
  var jobTypeFeat = [];
  var imageUrg = [];
  var imageFeat = [];
  var salMinFeat = [];
  var salMaxFeat = [];
  var descriptionFeat = [];
  var salaryTypeFeatId = [];
  var salaryTypeFeatName = [];
  var salaryTypeUrgName = [];
  var currencyFeat = [];
  var currencyUrg = [];
  var viewUrg = [];
  var salMinUrg = [];
  var salMaxUrg = [];
  var descriptionUrg = [];
  var salaryTypeUrgId = [];
  var prodAdIddFeat = [];
  Map urgentJobs = {};
  var urgentJobsList = [];
  Map highlightedJobs = {};
  var highlightedJobsList = [];
  Map featuredJobs = {};
  var featuredJobsList = [];
  Map urgentJobsFeat = {};
  // var urgentJobsListFeat = [];
  // Map featuredJobsFeat = {};
  var featuredJobsListFeat = [];

  List colorList = [Color(0xffDD312D), Color(0xff132144), Color(0xffA3CB37)];
  bool isSpin = true;
  bool isSpin1 = true;
  Map pageData = {'limit': 8, 'offset': 1};
  // int offset = 1;
  Map alljobs = {};
  var allJobsList = [];
  bool isUrgentSpin = true;
  bool isAllSpin = true;
  bool isfeaturedSpin = true;
  List favIdsRec = [];
  Map favIdData = {};
  Map categoryDetailsResponse = {};
  Map mainCatMap = {};
  var mainCatMapKeys = [];
  List<String> categoryMainList1 = [];
  Map mainCatIdMap = {};
  Map mainCatImageMap = {};
  bool isUrgentEmpty = false;
  bool isFeaturedEmpty = false;
  bool isAllEmpty = false;
  String locationSearch = "";

  Map fetchedCities = {};
  List citiesItem = [];

//----------------------Urgent Jobs-----------------------
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
      mainCatImageMap[mainCatMap[mainCatMapKeys[i].toString()]["cat_name"]] =
          mainCatMap[mainCatMapKeys[i].toString()]["picture"];
    }
    categoryMainList1.sort();
    print("======================================");
    print(categoryMainList1);
    print("======================================");

    print(mainCatMap);
    print(mainCatIdMap);
    print(mainCatImageMap);
    print("====ssssss=====");
    print(mainCatMap.values.elementAt(0));
    print(mainCatIdMap.values.elementAt(0));
    print(mainCatImageMap.values.elementAt(0));
    print("====ssssss=====");
  }

  Future gettingFavJobsIds() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_fav_jobs_ids');
    var url = Uri.parse(defaultUrl + 'mob_fav_jobs_ids');
    setState(() {
      favIdData['id'] = userDetailsResponse['id'];
    });

    try {
      var response = await http.post(url, body: json.encode(favIdData));
      setState(() {
        favIdsRec = jsonDecode(response.body);
      });
      print("favIds");
      print(favIdsRec);
    } catch (e) {
      print(e);
    }
  }

  Future gettingUrgentJobs() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_home');
    var url = Uri.parse(defaultUrl + 'mob_home');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    // var response = await http.post(urrr, body: json.encode(data));
    setState(() {
      pageData['country'] = userDetailsResponse['country_code'];
    });

    var response = await http.post(url, body: json.encode(pageData));
    urgentJobs = jsonDecode(response.body);

    try {
      urgentJobs['urgent'].forEach((k, v) => urgentJobsList.add(Applied(k)));
      print(urgentJobsList);
    } catch (error) {
      setState(() {
        isUrgentEmpty = true;
      });
    }

    setState(() {
      isUrgentSpin = false;
    });
  }

  //============
  Future gettingFeaturedJobs() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_featured');
    var url = Uri.parse(defaultUrl + 'mob_featured');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    // var response = await http.post(urrr, body: json.encode(data));
    setState(() {
      pageData['country'] = userDetailsResponse['country_code'];
    });
    var response = await http.post(url, body: json.encode(pageData));
    urgentJobsFeat = jsonDecode(response.body);

    try {
      urgentJobsFeat['featured'].forEach((k, v) => featuredJobsListFeat.add(Applied(k)));
      print("-------------------------------------------------");
      print(featuredJobsListFeat);
      print("-------------------------------------------------");

      print(urgentJobsFeat['featured'][featuredJobsListFeat[0].toString()]);
      print("-------------------------------------------------");
    } catch (error) {
      setState(() {
        isFeaturedEmpty = true;
      });
    }
    setState(() {
      isfeaturedSpin = false;
    });
  }

  Future gettingAllJobs() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_all_jobs');
    var url = Uri.parse(defaultUrl + 'mob_all_jobs');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    setState(() {
      pageData['country'] = userDetailsResponse['country_code'];
    });

    var response = await http.post(url, body: json.encode(pageData));
    // var response = await http.post(url);
    alljobs = jsonDecode(response.body);

    try {
      print(alljobs);

      alljobs['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print("-------------------------------------------------");
      print(allJobsList);
      print("-------------------------------------------------");

      print(alljobs['all'][allJobsList[0].toString()]);
      print("-------------------------------------------------");
    } catch (error) {
      setState(() {
        isAllEmpty = true;
      });
    }

    setState(() {
      isAllSpin = false;
      isSpin = false;
    });
  }

  Future citiesFetched() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_cat_sal');
    var url = Uri.parse(defaultUrl + 'mob_get_cities');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    var response = await http.post(url,
        body: json.encode({'country_code': userDetailsResponse['country_code']}));

    fetchedCities = jsonDecode(response.body);
    print(fetchedCities);
    setState(() {
      for (int i = 0; i < fetchedCities['cities'].length; i++) {
        _kOptions.add(fetchedCities['cities'][i]);
      }
    });
    // print(_kOptions["cities"]);
    //city=_kOptions["cities"];

    citiesItem = _kOptions.toList();
    items = List.from(citiesItem);
    print(citiesItem);

    // Getting Server response into variable.
    // print(userDetailsResponse.body.toString());
    // Map a = jsonDecode(userDetailsResponse.body);
    // print(a["name"]);
  }

  @override
  void initState() {
    if (isSignedIn) {
      gettingFavJobsIds();
    }

    citiesFetched();
    gettingUrgentJobs();
    gettingFeaturedJobs();
    gettingAllJobs();
    categoriesFetched();

    // dbCheckFavJobsAlready();
    // _dbCheckUrgentJob();
    // dbCheckHighligh();
  }

  String searchValue = "Search Job";
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      endDrawer: Sidemenu(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        elevation: 0,
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (builder) {
                  return Search_filter();
                });
          },
          // links: [
          //   PageLinkInfo(
          //     ease: Curves.easeOut,
          //     duration: 0.3,
          //     pageBuilder: () => Search_filter(),
          //   ),
          // ],
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 16,
              bottom: 18,
              right: 13,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: const Color(0xffffffff),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  right: 5,
                  left: 5,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.string(
                          _svg_ozy0on,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                        SvgPicture.string(
                          _svg_e3a3,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                        SvgPicture.string(
                          _svg_d2t5xf,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                        SvgPicture.string(
                          _svg_d2t5xf,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        SvgPicture.string(
                          _svg_d2t5xf,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                        SvgPicture.string(
                          _svg_ef6t7,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                        SvgPicture.string(
                          _svg_wbikb8,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                        SvgPicture.string(
                          _svg_mowfr3,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        title: Text(
          "My Jobs Centre",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: const Color(0xff1d1d1d),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
        ),
        backgroundColor: const Color(0xfff7f9fc),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffF7F9FC),
      body:
          // (isSpin || isSpin1)
          // ? Center(
          //     child: CupertinoActivityIndicator(
          //       animating: (isSpin || isSpin1),
          //       radius: 25,
          //     ),
          //   )
          // :
          Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    // color: Colors.white,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 35),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchKeyword = value;
                          });
                        },
                        onSubmitted: (value) {
                          if (searchKeyword != "") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => AllJobsSearch(
                                        searchTermRec: searchKeyword,
                                      )),
                                ));
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: DropdownButton<String>(
                              value: searchValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 15,
                              // itemHeight: 20,
                              // elevation: 16,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                              underline: SizedBox(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  searchValue = newValue!;
                                });
                                if (searchKeyword != "") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => AllJobsSearch(
                                              searchTermRec: searchKeyword,
                                            )),
                                      ));
                                }
                              },
                              items: <String>[
                                'Search Job',
                                'Search Candidates',
                                'Search Companies'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            hintText: "Search",
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0x80788198),
                              fontWeight: FontWeight.w300,
                            ),
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              CupertinoIcons.search,
                              color: Colors.grey,
                              size: 20,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 4)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 20,
                //     right: 20,
                //   ),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: 75,
                //     child: Padding(
                //       padding: const EdgeInsets.all(10.0),
                //       child: Container(
                //         color: Colors.white,
                //         // decoration: BoxDecoration(
                //         //   borderRadius: BorderRadius.all(Radius.circular(16)),
                //         //   border: Border.all(color: Colors.black),
                //         // ),
                //         child: Autocomplete<String>(
                //           optionsBuilder: (TextEditingValue textEditingValue) {
                //             if (textEditingValue.text == '') {
                //               return const Iterable<String>.empty();
                //             }
                //             return _kOptions.where((String option) {
                //               return option.contains(textEditingValue.text.toLowerCase());
                //             });
                //           },
                //           onSelected: (String selection) {
                //             debugPrint('You just selected $selection');
                //             setState(() {
                //               locationSearch = selection;
                //             });
                //           },
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 35),
                        child: TypeAheadFormField<String?>(
                          textFieldConfiguration: TextFieldConfiguration(
                              // controller: controllercity,
                              decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Location",
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0x80788198),
                              fontWeight: FontWeight.w300,
                            ),
                            prefixIcon: Icon(
                              Icons.my_location,
                              color: Colors.grey,
                            ),
                            contentPadding: EdgeInsets.all(1),
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
                            setState(() {
                              locationSearch = suggestion!;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SearchwithLocation(searchLocation: locationSearch)),
                            );
                          },
                          // validator:(value)=>
                          // value!=null && value.isEmpty ? 'Please select a city' : null,
                          // onSaved: (value)=>city=value!,
                          itemBuilder: (context, String? suggestion) => ListTile(
                            title: Text(suggestion!),
                          ),
                          suggestionsCallback: (query) => _kOptions.where((element) =>
                              element.toLowerCase().contains(query.toLowerCase())),
                        )
                        // TextField(
                        //   onChanged: (value) {
                        //     setState(() {
                        //       locationSearch = value;
                        //     });
                        //   },
                        //   onSubmitted: (value) {
                        //     setState(() {
                        //       locationSearch = value;
                        //     });
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => SearchwithLocation(
                        //                 searchLocation: locationSearch)));
                        //   },
                        //   decoration: InputDecoration(
                        //     isDense: true,
                        //     contentPadding: EdgeInsets.all(1),
                        //     hintText: "Location",
                        //     hintStyle: TextStyle(
                        //       fontFamily: 'Poppins',
                        //       fontSize: 14,
                        //       color: const Color(0x80788198),
                        //       fontWeight: FontWeight.w300,
                        //     ),
                        // fillColor: Colors.white,
                        // prefixIcon: Icon(
                        //   Icons.my_location,
                        //   color: Colors.black,
                        // ),
                        //     suffixIcon: GestureDetector(
                        //       onTap: () {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => SearchwithLocation(
                        //                     searchLocation: locationSearch)));
                        //       },
                        //       child: Container(
                        //         child: Padding(
                        //           padding: const EdgeInsets.only(right: 20),
                        //           child: Icon(Icons.search, color: Colors.grey, size: 20),
                        //         ),
                        //       ),
                        //     ),
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide.none,
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        // ),
                        ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 20, bottom: 10, right: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Categories',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          //textAlign: TextAlign.left,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CategoriesDisplayPage()),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 20),
                                            child: Text(
                                              'See All',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 11,
                                                color: const Color(0xff788198),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              //textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Scrollbar(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (int i = 0; i < categoryMainList1.length; i++)
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AllJObsWithCats(
                                                            catId: mainCatIdMap[
                                                                    categoryMainList1[i]]
                                                                .toString(),
                                                          )));
                                            },
                                            child: CategoryItemWidget(
                                              catDisplay: categoryMainList1[i],
                                              imgPath:
                                                  mainCatImageMap[categoryMainList1[i]],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 270,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0xff132144),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 20, bottom: 10, right: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Urgent Jobs',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          //textAlign: TextAlign.left,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, UrgentJobsAll.idScreen);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 20),
                                            child: Text(
                                              'See All',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 11,
                                                color: const Color(0xff788198),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              //textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Scrollbar(
                                  child: isUrgentSpin
                                      ? Center(
                                          child: CupertinoActivityIndicator(
                                            radius: 15,
                                          ),
                                        )
                                      : isUrgentEmpty
                                          ? Padding(
                                              padding: const EdgeInsets.only(top: 70),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Text(
                                                  "No Urgent Jobs Found  For Your Country",
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: const Color(0xffffffff),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: <Widget>[
                                                  for (int i = 0;
                                                      i < urgentJobsList.length;
                                                      i++)
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                JobDetailsScreen(
                                                              isApplyShow: true,
                                                              company: urgentJobs[
                                                                              'urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['company_name']
                                                                  .toString(),
                                                              title: urgentJobs['urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['product_name']
                                                                  .toString(),
                                                              city: urgentJobs['urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['location']
                                                                  .toString(),
                                                              country: urgentJobs[
                                                                              'urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['country']
                                                                  .toString(),
                                                              type: urgentJobs['urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['product_type']
                                                                  .toString(),
                                                              date: urgentJobs['urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['created_at']
                                                                  .toString(),
                                                              view: urgentJobs['urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['view']
                                                                  .toString(),
                                                              minSal: urgentJobs['urgent']
                                                                          [urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['salary_min']
                                                                  .toString(),
                                                              maxSal: urgentJobs['urgent']
                                                                          [urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['salary_max']
                                                                  .toString(),
                                                              // currency: currencyUrg[i]
                                                              //     .toString(),
                                                              salType: urgentJobs[
                                                                              'urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['salary_type']
                                                                  .toString(),
                                                              description: urgentJobs[
                                                                              'urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['desc']
                                                                  .toString(),
                                                              img: urgentJobs['urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['company_image']
                                                                  .toString(),
                                                              idChat: urgentJobs['urgent']
                                                                          [urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['user_id']
                                                                  .toString(),
                                                              jobID: urgentJobs['urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['id']
                                                                  .toString(),
                                                              isFav: favIdsRec.contains(
                                                                  urgentJobs['urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['id']),
                                                              link: urgentJobs['urgent'][
                                                                          urgentJobsList[
                                                                                  i]
                                                                              .toString()]
                                                                      ['link']
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: UrgentJobCategoryWidget(
                                                        company: urgentJobs['urgent'][
                                                                    urgentJobsList[i]
                                                                        .toString()]
                                                                ['company_name']
                                                            .toString(),
                                                        date: urgentJobs['urgent'][
                                                                urgentJobsList[i]
                                                                    .toString()]
                                                            ['created_at'],
                                                        jobrole: urgentJobs['urgent'][
                                                                urgentJobsList[i]
                                                                    .toString()]
                                                            ['product_name'],
                                                        location: urgentJobs['urgent'][
                                                                    urgentJobsList[i]
                                                                        .toString()]
                                                                ['location'] +
                                                            ',' +
                                                            urgentJobs['urgent'][
                                                                    urgentJobsList[i]
                                                                        .toString()]
                                                                ['country'],
                                                        type: urgentJobs['urgent'][
                                                                urgentJobsList[i]
                                                                    .toString()]
                                                            ['product_type'],
                                                        profImg: urgentJobs['urgent'][
                                                                urgentJobsList[i]
                                                                    .toString()]
                                                            ['company_image'],
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0xffffffff),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 20, bottom: 10, right: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Featured Jobs',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: const Color(0xff132144),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          //textAlign: TextAlign.left,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, FeaturedJobsAll.idScreen);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 20),
                                            child: Text(
                                              'See All',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 11,
                                                color: const Color(0xff788198),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              //textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Scrollbar(
                                  child: isFeaturedEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.only(top: 70),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              "No Featured Jobs Found  For Your Country",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                color: const Color(0xff132144),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 20,
                                                //child: Component351(),
                                              ),
                                              for (int i = 0;
                                                  i < featuredJobsListFeat.length;
                                                  i++)
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (cntext) =>
                                                            JobDetailsScreen(
                                                          isApplyShow: true,
                                                          company: urgentJobsFeat[
                                                                      'featured'][
                                                                  featuredJobsListFeat[i]
                                                                      .toString()]
                                                              ['company_name'],
                                                          title: urgentJobsFeat[
                                                                      'featured'][
                                                                  featuredJobsListFeat[i]
                                                                      .toString()]
                                                              ['product_name'],
                                                          city: urgentJobsFeat['featured']
                                                                  [featuredJobsListFeat[i]
                                                                      .toString()]
                                                              ['location'],
                                                          country: urgentJobsFeat[
                                                                  'featured'][
                                                              featuredJobsListFeat[i]
                                                                  .toString()]['country'],
                                                          type: urgentJobsFeat['featured']
                                                                  [featuredJobsListFeat[i]
                                                                      .toString()]
                                                              ['product_type'],
                                                          date: urgentJobsFeat['featured']
                                                                  [featuredJobsListFeat[i]
                                                                      .toString()]
                                                              ['created_at'],
                                                          view: urgentJobsFeat['featured']
                                                              [featuredJobsListFeat[i]
                                                                  .toString()]['view'],
                                                          minSal: urgentJobsFeat[
                                                                      'featured'][
                                                                  featuredJobsListFeat[i]
                                                                      .toString()]
                                                              ['salary_min'],
                                                          maxSal: urgentJobsFeat[
                                                                      'featured'][
                                                                  featuredJobsListFeat[i]
                                                                      .toString()]
                                                              ['salary_max'],
                                                          // currency: currencyFeat[i]
                                                          //     .toString(),
                                                          salType: urgentJobsFeat[
                                                                      'featured'][
                                                                  featuredJobsListFeat[i]
                                                                      .toString()]
                                                              ['salary_type'],
                                                          description: urgentJobsFeat[
                                                                  'featured'][
                                                              featuredJobsListFeat[i]
                                                                  .toString()]['desc'],
                                                          img: urgentJobsFeat['featured'][
                                                                  featuredJobsListFeat[i]
                                                                      .toString()]
                                                              ['company_image'],
                                                          idChat: urgentJobsFeat[
                                                                  'featured'][
                                                              featuredJobsListFeat[i]
                                                                  .toString()]['user_id'],

                                                          isFav: favIdsRec.contains(
                                                              urgentJobsFeat['featured'][
                                                                  featuredJobsListFeat[i]
                                                                      .toString()]['id']),
                                                          jobID:
                                                              urgentJobsFeat['featured'][
                                                                  featuredJobsListFeat[i]
                                                                      .toString()]['id'],
                                                          link: urgentJobsFeat['featured']
                                                              [featuredJobsListFeat[i]
                                                                  .toString()]['link'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: FavItemComponentWidget(
                                                    isFav: favIdsRec.contains(
                                                        urgentJobsFeat['featured'][
                                                            featuredJobsListFeat[i]
                                                                .toString()]['id']),
                                                    // isFav: (favJobsIdsAlready
                                                    //         .contains(prodAdIddFeat[i]))
                                                    //     ? true
                                                    //     : false,

                                                    city: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['location'],
                                                    country: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['country'],
                                                    date: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['created_at'],
                                                    description:
                                                        urgentJobsFeat['featured'][
                                                            featuredJobsListFeat[i]
                                                                .toString()]['desc'],
                                                    maxSal: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['salary_max'],
                                                    minSal: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['salary_min'],
                                                    title: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['product_name'],
                                                    type: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['product_type'],
                                                    view: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['view'],
                                                    img: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['company_image'],
                                                    salType: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['salary_type'],
                                                    // currency:
                                                    //     currencyFeat[i].toString(),
                                                    prodID: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['product_type'],
                                                    msgId: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['user_id'],
                                                    jobId: urgentJobsFeat['featured'][
                                                        featuredJobsListFeat[i]
                                                            .toString()]['id'],
                                                    feature: urgentJobsFeat['featured'][
                                                            featuredJobsListFeat[i]
                                                                .toString()]['featured']
                                                        .toString(),
                                                    highlight: urgentJobsFeat['featured'][
                                                            featuredJobsListFeat[i]
                                                                .toString()]['highlight']
                                                        .toString(),
                                                    urgent: urgentJobsFeat['featured'][
                                                            featuredJobsListFeat[i]
                                                                .toString()]['urgent']
                                                        .toString(),
                                                    // salType: salaryTypeFeatName[i].toString(),
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0xffffffff),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 20, bottom: 10, right: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'All Jobs',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: const Color(0xff132144),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          //textAlign: TextAlign.left,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, AllJobsPage.idScreen);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 20),
                                            child: Text(
                                              'See All',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 11,
                                                color: const Color(0xff788198),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              //textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Scrollbar(
                                  child: isAllEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.only(top: 70),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              "No Jobs Found For Your Country",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                color: const Color(0xff132144),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 20,
                                                //child: Component351(),
                                              ),
                                              for (int i = 0; i < allJobsList.length; i++)
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                JobDetailsScreen(
                                                                  isApplyShow: true,
                                                                  company: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['company_name'],
                                                                  title: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['product_name'],
                                                                  city: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['location'],
                                                                  country: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['country'],
                                                                  type: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['product_type'],
                                                                  date: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['created_at'],
                                                                  view: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['view'],
                                                                  minSal: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['salary_min'],
                                                                  maxSal: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['salary_max'],
                                                                  // currency: currencyFeat[i]
                                                                  //     .toString(),
                                                                  salType: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['salary_type'],
                                                                  description: alljobs[
                                                                              'all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['description'],
                                                                  img: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['company_image'],
                                                                  idChat: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['user_id'],
                                                                  jobID: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['id'],
                                                                  isFav: favIdsRec
                                                                      .contains(alljobs[
                                                                                  'all'][
                                                                              allJobsList[
                                                                                      i]
                                                                                  .toString()]
                                                                          ['id']),
                                                                  link: alljobs['all'][
                                                                          allJobsList[i]
                                                                              .toString()]
                                                                      ['link'],
                                                                )));
                                                  },
                                                  child: FavItemComponentWidget(
                                                    isFav: favIdsRec.contains(alljobs[
                                                                'all']
                                                            [allJobsList[i].toString()]
                                                        ['id']),
                                                    // isFav: (favJobsIdsAlready
                                                    //         .contains(prodAdIddFeat[i]))
                                                    //     ? true
                                                    //     : false,

                                                    city: alljobs['all'][allJobsList[i]
                                                            .toString()]['location']
                                                        .toString(),
                                                    country: alljobs['all'][allJobsList[i]
                                                            .toString()]['country']
                                                        .toString(),
                                                    date: alljobs['all']
                                                            [allJobsList[i].toString()]
                                                        ['created_at'],
                                                    description: alljobs['all']
                                                            [allJobsList[i].toString()]
                                                        ['description'],
                                                    maxSal: alljobs['all']
                                                            [allJobsList[i].toString()]
                                                        ['salary_max'],
                                                    minSal: alljobs['all']
                                                            [allJobsList[i].toString()]
                                                        ['salary_min'],
                                                    title: alljobs['all']
                                                            [allJobsList[i].toString()]
                                                        ['product_name'],
                                                    type: alljobs['all']
                                                            [allJobsList[i].toString()]
                                                        ['product_type'],
                                                    view: alljobs['all']
                                                            [allJobsList[i].toString()]
                                                        ['view'],
                                                    img: alljobs['all']
                                                            [allJobsList[i].toString()]
                                                        ['company_image'],
                                                    salType: alljobs['all']
                                                            [allJobsList[i].toString()]
                                                        ['salary_type'],
                                                    // currency:
                                                    //     currencyFeat[i].toString(),
                                                    prodID: alljobs['all']
                                                            [allJobsList[i].toString()]
                                                        ['product_type'],
                                                    msgId: alljobs['all']
                                                            [allJobsList[i].toString()]
                                                        ['user_id'],
                                                    jobId: alljobs['all']
                                                        [allJobsList[i].toString()]['id'],
                                                    feature: alljobs['all'][allJobsList[i]
                                                            .toString()]['featured']
                                                        .toString(),
                                                    highlight: alljobs['all'][
                                                                allJobsList[i].toString()]
                                                            ['highlight']
                                                        .toString(),
                                                    urgent: alljobs['all'][allJobsList[i]
                                                            .toString()]['urgent']
                                                        .toString(),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
    ));
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

const String _svg_bme130 =
    '<svg viewBox="-380.0 1374.7 47.9 47.9" ><path transform="translate(-380.0, 1375.0)" d="M 0 40.6427001953125 L 0 24.83767700195312 L 25.13120269775391 -0.2935253381729126 L 47.93605041503906 -0.2935253381729126 L 0 47.64252471923828 L 0 40.6427001953125 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_d20892 =
    '<svg viewBox="0.0 0.0 19.5 19.5" ><path transform="translate(0.75, 0.75)" d="M 8.98900032043457 -0.75 C 14.35910034179688 -0.75 18.72800064086914 3.618900299072266 18.72800064086914 8.98900032043457 C 18.72800064086914 14.35910034179688 14.35910034179688 18.72800064086914 8.98900032043457 18.72800064086914 C 3.618900299072266 18.72800064086914 -0.75 14.35910034179688 -0.75 8.98900032043457 C -0.75 3.618900299072266 3.618900299072266 -0.75 8.98900032043457 -0.75 Z M 8.98900032043457 17.22800064086914 C 13.53200054168701 17.22800064086914 17.22800064086914 13.53200054168701 17.22800064086914 8.98900032043457 C 17.22800064086914 4.446000099182129 13.53200054168701 0.75 8.98900032043457 0.75 C 4.446000099182129 0.75 0.75 4.446000099182129 0.75 8.98900032043457 C 0.75 13.53200054168701 4.446000099182129 17.22800064086914 8.98900032043457 17.22800064086914 Z" fill="#788198" fill-opacity="0.4" stroke="none" stroke-width="1.5" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_mn60fm =
    '<svg viewBox="15.2 15.7 5.0 5.0" ><path transform="translate(15.99, 16.46)" d="M 3.523993015289307 4.265001773834229 C 3.332356214523315 4.265001773834229 3.14075231552124 4.192038059234619 2.994349956512451 4.04601001739502 L -0.5296500325202942 0.5310100317001343 C -0.822920024394989 0.2384900450706482 -0.8235300183296204 -0.2363799512386322 -0.5310100317001343 -0.5296499729156494 C -0.2384900450706482 -0.822920024394989 0.2363800555467606 -0.8235298991203308 0.5296499729156494 -0.5310099720954895 L 4.05364990234375 2.983989953994751 C 4.346920013427734 3.276510000228882 4.347529888153076 3.75137996673584 4.055009841918945 4.044650077819824 C 3.908517837524414 4.19151782989502 3.716238975524902 4.265001773834229 3.523993015289307 4.265001773834229 Z" fill="#788198" fill-opacity="0.4" stroke="none" stroke-width="1.5" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_mowfr3 =
    '<svg viewBox="8.3 3.1 4.1 1.0" ><path transform="translate(9.07, 3.89)" d="M 2.93181848526001 0.0681818425655365 L -0.3409090936183929 0.0681818425655365 C -0.5668418407440186 0.0681818425655365 -0.75 -0.1149763613939285 -0.75 -0.3409090936183929 C -0.75 -0.5668418407440186 -0.5668418407440186 -0.75 -0.3409090936183929 -0.75 L 2.93181848526001 -0.75 C 3.157751083374023 -0.75 3.340909242630005 -0.5668418407440186 3.340909242630005 -0.3409090936183929 C 3.340909242630005 -0.1149763613939285 3.157751083374023 0.0681818425655365 2.93181848526001 0.0681818425655365 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_ozy0on =
    '<svg viewBox="0.7 3.1 3.0 1.0" ><path transform="translate(1.43, 3.89)" d="M 1.840909123420715 0.0681818425655365 L -0.3409090936183929 0.0681818425655365 C -0.5668418407440186 0.0681818425655365 -0.75 -0.1149763613939285 -0.75 -0.3409090936183929 C -0.75 -0.5668418407440186 -0.5668418407440186 -0.75 -0.3409090936183929 -0.75 L 1.840909123420715 -0.75 C 2.066841840744019 -0.75 2.250000238418579 -0.5668418407440186 2.250000238418579 -0.3409090936183929 C 2.250000238418579 -0.1149763613939285 2.066841840744019 0.0681818425655365 1.840909123420715 0.0681818425655365 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_e3a3 =
    '<svg viewBox="3.1 1.2 4.6 4.6" ><path transform="translate(3.89, 1.98)" d="M 1.568181872367859 -0.75 C 2.84643292427063 -0.75 3.886363983154297 0.2899308502674103 3.886363983154297 1.568181872367859 C 3.886363983154297 2.84643292427063 2.84643292427063 3.886363983154297 1.568181872367859 3.886363983154297 C 0.2899308502674103 3.886363983154297 -0.75 2.84643292427063 -0.75 1.568181872367859 C -0.75 0.2899308502674103 0.2899308502674103 -0.75 1.568181872367859 -0.75 Z M 1.568181872367859 3.068181991577148 C 2.39528751373291 3.068181991577148 3.068181991577148 2.39528751373291 3.068181991577148 1.568181872367859 C 3.068181991577148 0.7410764694213867 2.39528751373291 0.0681818425655365 1.568181872367859 0.0681818425655365 C 0.7410764694213867 0.0681818425655365 0.0681818425655365 0.7410764694213867 0.0681818425655365 1.568181872367859 C 0.0681818425655365 2.39528751373291 0.7410764694213867 3.068181991577148 1.568181872367859 3.068181991577148 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_d2t5xf =
    '<svg viewBox="9.4 9.1 3.0 1.0" ><path transform="translate(10.16, 9.89)" d="M 1.840909123420715 0.0681818425655365 L -0.3409090936183929 0.0681818425655365 C -0.5668418407440186 0.0681818425655365 -0.75 -0.1149763613939285 -0.75 -0.3409090936183929 C -0.75 -0.5668418407440186 -0.5668418407440186 -0.75 -0.3409090936183929 -0.75 L 1.840909123420715 -0.75 C 2.066841840744019 -0.75 2.250000238418579 -0.5668418407440186 2.250000238418579 -0.3409090936183929 C 2.250000238418579 -0.1149763613939285 2.066841840744019 0.0681818425655365 1.840909123420715 0.0681818425655365 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_ef6t7 =
    '<svg viewBox="0.7 9.1 4.1 1.0" ><path transform="translate(1.43, 9.89)" d="M 2.93181848526001 0.0681818425655365 L -0.3409090936183929 0.0681818425655365 C -0.5668418407440186 0.0681818425655365 -0.75 -0.1149763613939285 -0.75 -0.3409090936183929 C -0.75 -0.5668418407440186 -0.5668418407440186 -0.75 -0.3409090936183929 -0.75 L 2.93181848526001 -0.75 C 3.157751083374023 -0.75 3.340909242630005 -0.5668418407440186 3.340909242630005 -0.3409090936183929 C 3.340909242630005 -0.1149763613939285 3.157751083374023 0.0681818425655365 2.93181848526001 0.0681818425655365 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_wbikb8 =
    '<svg viewBox="5.3 7.2 4.6 4.6" ><path transform="translate(6.07, 7.98)" d="M 1.568181872367859 -0.75 C 2.84643292427063 -0.75 3.886363983154297 0.2899308502674103 3.886363983154297 1.568181872367859 C 3.886363983154297 2.84643292427063 2.84643292427063 3.886363983154297 1.568181872367859 3.886363983154297 C 0.2899308502674103 3.886363983154297 -0.75 2.84643292427063 -0.75 1.568181872367859 C -0.75 0.2899308502674103 0.2899308502674103 -0.75 1.568181872367859 -0.75 Z M 1.568181872367859 3.068181991577148 C 2.39528751373291 3.068181991577148 3.068181991577148 2.39528751373291 3.068181991577148 1.568181872367859 C 3.068181991577148 0.7410764694213867 2.39528751373291 0.0681818425655365 1.568181872367859 0.0681818425655365 C 0.7410764694213867 0.0681818425655365 0.0681818425655365 0.7410764694213867 0.0681818425655365 1.568181872367859 C 0.0681818425655365 2.39528751373291 0.7410764694213867 3.068181991577148 1.568181872367859 3.068181991577148 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_eea0u =
    '<svg viewBox="0.0 0.0 13.1 13.1" ><path  d="M 0 0 L 13.09090995788574 0 L 13.09090995788574 13.09090995788574 L 0 13.09090995788574 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_x4xswt =
    '<svg viewBox="0.0 0.6 12.0 11.4" ><path transform="translate(-28.07, -26.41)" d="M 33.99225997924805 27.39100074768066 L 39.41500854492188 27.39100074768066 L 39.41500854492188 38.33049011230469 L 28.74799919128418 38.33049011230469 L 28.74799919128418 27.39100074768066 L 30.21694946289062 27.39100074768066" fill="#ecedf2" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-28.07, -26.41)" d="M 33.99225997924805 27.39100074768066 L 39.41500854492188 27.39100074768066 L 39.41500854492188 28.51572418212891 L 28.74799919128418 28.51572418212891 L 28.74799919128418 27.39100074768066 L 30.21694946289062 27.39100074768066" fill="#c6cad5" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.0, -8.69)" d="M 4.468077659606934 10.09768104553223 L 11.34463596343994 10.09768104553223 L 11.82364654541016 10.09768104553223 C 11.93167686462402 10.09768104553223 12.01926422119141 10.01011657714844 12.01926422119141 9.902063369750977 L 12.01926422119141 9.441617012023926 C 12.01926422119141 9.333586692810059 11.93169975280762 9.245999336242676 11.82364654541016 9.245999336242676 L 4.972341060638428 9.245999336242676 L 3.095845222473145 9.245999336242676 L 0.1986177414655685 9.245999336242676 C 0.09058807045221329 9.245999336242676 0.003000259399414062 9.333563804626465 0.003000259399414062 9.441617012023926 L 0.003000259399414062 9.90208625793457 C 0.003000259399414062 10.01011657714844 0.09056460112333298 10.09770393371582 0.1986177414655685 10.09770393371582 L 0.6776282787322998 10.09770393371582 L 3.264613628387451 10.09770393371582" fill="#525c66" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_t3nr5 =
    '<svg viewBox="2.6 1.2 2.8 2.8" ><path transform="translate(-109.96, -34.19)" d="M 115.2850723266602 36.3095703125 L 114.5261840820312 36.3095703125 C 114.4721603393555 36.3095703125 114.4283447265625 36.26577758789062 114.4283447265625 36.21172714233398 L 114.4283447265625 35.45284271240234 C 114.4283447265625 35.3988151550293 114.3845520019531 35.35499954223633 114.3304977416992 35.35499954223633 L 113.6584091186523 35.35499954223633 C 113.604377746582 35.35499954223633 113.5605621337891 35.3987922668457 113.5605621337891 35.45284271240234 L 113.5605621337891 36.21175003051758 C 113.5605621337891 36.26577758789062 113.5167694091797 36.30959320068359 113.4627151489258 36.30959320068359 L 112.7038345336914 36.30959320068359 C 112.6498107910156 36.30959320068359 112.6059875488281 36.35338592529297 112.6059875488281 36.40743637084961 L 112.6059875488281 37.07952880859375 C 112.6059875488281 37.1335563659668 112.649787902832 37.17737579345703 112.7038345336914 37.17737579345703 L 113.4627151489258 37.17737579345703 C 113.5167465209961 37.17737579345703 113.5605621337891 37.22116851806641 113.5605621337891 37.27521896362305 L 113.5605621337891 38.03410339355469 C 113.5605621337891 38.08812713623047 113.6043548583984 38.1319465637207 113.6584091186523 38.1319465637207 L 114.3304977416992 38.1319465637207 C 114.3845291137695 38.1319465637207 114.4283447265625 38.08815002441406 114.4283447265625 38.03410339355469 L 114.4283447265625 37.27521896362305 C 114.4283447265625 37.22119140625 114.4721374511719 37.17737579345703 114.5261840820312 37.17737579345703 L 115.2850723266602 37.17737579345703 C 115.3390960693359 37.17737579345703 115.3829116821289 37.13357925415039 115.3829116821289 37.07952880859375 L 115.3829116821289 36.40743637084961 C 115.3829116821289 36.35338592529297 115.3391189575195 36.3095703125 115.2850723266602 36.3095703125 Z" fill="#d81616" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_x9y4 =
    '<svg viewBox="0.0 0.0 9.4 2.5" ><path transform="translate(-302.34, -214.02)" d="M 309.59326171875 216.4936828613281 L 308.3981018066406 216.4936828613281 C 308.3168640136719 216.4936828613281 308.2509765625 216.4277801513672 308.2509765625 216.3465576171875 L 308.2509765625 214.1641387939453 C 308.2509765625 214.0828857421875 308.3168640136719 214.0170135498047 308.3981018066406 214.0170135498047 L 309.59326171875 214.0170135498047 C 309.6744995117188 214.0170135498047 309.7403869628906 214.0829162597656 309.7403869628906 214.1641387939453 L 309.7403869628906 216.3465576171875 C 309.7403869628906 216.4278106689453 309.6744995117188 216.4936828613281 309.59326171875 216.4936828613281 Z M 308.5452270507812 216.1994018554688 L 309.4461059570312 216.1994018554688 L 309.4461059570312 214.3112640380859 L 308.5452270507812 214.3112640380859 L 308.5452270507812 216.1994018554688 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-138.32, -214.02)" d="M 141.6342926025391 216.4936828613281 L 140.4391326904297 216.4936828613281 C 140.3578796386719 216.4936828613281 140.2920074462891 216.4277801513672 140.2920074462891 216.3465576171875 L 140.2920074462891 214.1641387939453 C 140.2920074462891 214.0828857421875 140.35791015625 214.0170135498047 140.4391326904297 214.0170135498047 L 141.6342926025391 214.0170135498047 C 141.7155456542969 214.0170135498047 141.7814178466797 214.0829162597656 141.7814178466797 214.1641387939453 L 141.7814178466797 216.3465576171875 C 141.7814178466797 216.4278106689453 141.7155151367188 216.4936828613281 141.6342926025391 216.4936828613281 Z M 140.5862579345703 216.1994018554688 L 141.4871368408203 216.1994018554688 L 141.4871368408203 214.3112640380859 L 140.5862579345703 214.3112640380859 L 140.5862579345703 216.1994018554688 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-384.35, -214.02)" d="M 393.572265625 216.4936828613281 L 392.3771057128906 216.4936828613281 C 392.2958374023438 216.4936828613281 392.22998046875 216.4277801513672 392.22998046875 216.3465576171875 L 392.22998046875 214.1641387939453 C 392.22998046875 214.0828857421875 392.2958679199219 214.0170135498047 392.3771057128906 214.0170135498047 L 393.572265625 214.0170135498047 C 393.6535034179688 214.0170135498047 393.7193908691406 214.0829162597656 393.7193908691406 214.1641387939453 L 393.7193908691406 216.3465576171875 C 393.7193908691406 216.4278106689453 393.6535034179688 216.4936828613281 393.572265625 216.4936828613281 Z M 392.5242309570312 216.1994018554688 L 393.4251098632812 216.1994018554688 L 393.4251098632812 214.3112640380859 L 392.5242309570312 214.3112640380859 L 392.5242309570312 216.1994018554688 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-220.33, -214.02)" d="M 225.61328125 216.4936828613281 L 224.4181213378906 216.4936828613281 C 224.3368835449219 216.4936828613281 224.27099609375 216.4277801513672 224.27099609375 216.3465576171875 L 224.27099609375 214.1641387939453 C 224.27099609375 214.0828857421875 224.3368988037109 214.0170135498047 224.4181213378906 214.0170135498047 L 225.61328125 214.0170135498047 C 225.6945343017578 214.0170135498047 225.7604064941406 214.0829162597656 225.7604064941406 214.1641387939453 L 225.7604064941406 216.3465576171875 C 225.7604064941406 216.4278106689453 225.6945190429688 216.4936828613281 225.61328125 216.4936828613281 Z M 224.5652618408203 216.1994018554688 L 225.4661254882812 216.1994018554688 L 225.4661254882812 214.3112640380859 L 224.5652618408203 214.3112640380859 L 224.5652618408203 216.1994018554688 L 224.5652618408203 216.1994018554688 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-56.31, -214.02)" d="M 57.65426254272461 216.4936828613281 L 56.45912933349609 216.4936828613281 C 56.37788009643555 216.4936828613281 56.3120002746582 216.4277801513672 56.3120002746582 216.3465576171875 L 56.3120002746582 214.1641387939453 C 56.3120002746582 214.0828857421875 56.37790298461914 214.0170135498047 56.45912933349609 214.0170135498047 L 57.6542854309082 214.0170135498047 C 57.73553466796875 214.0170135498047 57.80141448974609 214.0829162597656 57.80141448974609 214.1641387939453 L 57.80141448974609 216.3465576171875 C 57.80141448974609 216.4278106689453 57.73553466796875 216.4936828613281 57.65426254272461 216.4936828613281 Z M 56.60625839233398 216.1994018554688 L 57.50713348388672 216.1994018554688 L 57.50713348388672 214.3112640380859 L 56.60625839233398 214.3112640380859 L 56.60625839233398 216.1994018554688 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eet9u4 =
    '<svg viewBox="0.0 0.0 9.4 9.2" ><path transform="translate(-302.34, -332.76)" d="M 311.7103881835938 341.9450073242188 L 311.4161071777344 341.9450073242188 L 311.4161071777344 338.9072265625 L 308.5442810058594 338.9072265625 L 308.5442810058594 341.9450073242188 L 308.25 341.9450073242188 L 308.25 338.7601013183594 C 308.25 338.6788330078125 308.31591796875 338.6129760742188 308.3971252441406 338.6129760742188 L 311.563232421875 338.6129760742188 C 311.6444702148438 338.6129760742188 311.7103576660156 338.6788635253906 311.7103576660156 338.7601013183594 L 311.7103881835938 341.9450073242188 L 311.7103881835938 341.9450073242188 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-138.32, -332.77)" d="M 141.6342926025391 341.0906372070312 L 140.4391326904297 341.0906372070312 C 140.3578796386719 341.0906372070312 140.2920074462891 341.0247497558594 140.2920074462891 340.9435119628906 L 140.2920074462891 338.7611083984375 C 140.2920074462891 338.6798400878906 140.35791015625 338.6139831542969 140.4391326904297 338.6139831542969 L 141.6342926025391 338.6139831542969 C 141.7155456542969 338.6139831542969 141.7814178466797 338.6798706054688 141.7814178466797 338.7611083984375 L 141.7814178466797 340.9435119628906 C 141.7814178466797 341.0247497558594 141.7155151367188 341.0906372070312 141.6342926025391 341.0906372070312 Z M 140.5862579345703 340.7963562011719 L 141.4871368408203 340.7963562011719 L 141.4871368408203 338.9082336425781 L 140.5862579345703 338.9082336425781 L 140.5862579345703 340.7963562011719 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-220.33, -332.77)" d="M 225.61328125 341.0906372070312 L 224.4181213378906 341.0906372070312 C 224.3368835449219 341.0906372070312 224.27099609375 341.0247497558594 224.27099609375 340.9435119628906 L 224.27099609375 338.7611083984375 C 224.27099609375 338.6798400878906 224.3368988037109 338.6139831542969 224.4181213378906 338.6139831542969 L 225.61328125 338.6139831542969 C 225.6945343017578 338.6139831542969 225.7604064941406 338.6798706054688 225.7604064941406 338.7611083984375 L 225.7604064941406 340.9435119628906 C 225.7604064941406 341.0247497558594 225.6945190429688 341.0906372070312 225.61328125 341.0906372070312 Z M 224.5652618408203 340.7963562011719 L 225.4661254882812 340.7963562011719 L 225.4661254882812 338.9082336425781 L 224.5652618408203 338.9082336425781 L 224.5652618408203 340.7963562011719 L 224.5652618408203 340.7963562011719 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-56.31, -332.77)" d="M 57.65426254272461 341.0906372070312 L 56.45912933349609 341.0906372070312 C 56.37788009643555 341.0906372070312 56.3120002746582 341.0247497558594 56.3120002746582 340.9435119628906 L 56.3120002746582 338.7611083984375 C 56.3120002746582 338.6798400878906 56.37790298461914 338.6139831542969 56.45912933349609 338.6139831542969 L 57.6542854309082 338.6139831542969 C 57.73553466796875 338.6139831542969 57.80141448974609 338.6798706054688 57.80141448974609 338.7611083984375 L 57.80141448974609 340.9435119628906 C 57.80141448974609 341.0247497558594 57.73553466796875 341.0906372070312 57.65426254272461 341.0906372070312 Z M 56.60625839233398 340.7963562011719 L 57.50713348388672 340.7963562011719 L 57.50713348388672 338.9082336425781 L 56.60625839233398 338.9082336425781 L 56.60625839233398 340.7963562011719 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-302.34, -89.42)" d="M 309.59326171875 91.89573669433594 L 308.3981018066406 91.89573669433594 C 308.3168640136719 91.89573669433594 308.2509765625 91.829833984375 308.2509765625 91.74860382080078 L 308.2509765625 89.56613922119141 C 308.2509765625 89.48488616943359 308.3168640136719 89.41900634765625 308.3981018066406 89.41900634765625 L 309.59326171875 89.41900634765625 C 309.6744995117188 89.41900634765625 309.7403869628906 89.48490905761719 309.7403869628906 89.56613922119141 L 309.7403869628906 91.74855804443359 C 309.7403869628906 91.829833984375 309.6744995117188 91.89573669433594 309.59326171875 91.89573669433594 Z M 308.5452270507812 91.60144805908203 L 309.4461059570312 91.60144805908203 L 309.4461059570312 89.71328735351562 L 308.5452270507812 89.71328735351562 L 308.5452270507812 91.60144805908203 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-384.35, -89.42)" d="M 393.572265625 91.89573669433594 L 392.3771057128906 91.89573669433594 C 392.2958374023438 91.89573669433594 392.22998046875 91.829833984375 392.22998046875 91.74860382080078 L 392.22998046875 89.56613922119141 C 392.22998046875 89.48488616943359 392.2958679199219 89.41900634765625 392.3771057128906 89.41900634765625 L 393.572265625 89.41900634765625 C 393.6535034179688 89.41900634765625 393.7193908691406 89.48490905761719 393.7193908691406 89.56613922119141 L 393.7193908691406 91.74855804443359 C 393.7193908691406 91.829833984375 393.6535034179688 91.89573669433594 393.572265625 91.89573669433594 Z M 392.5242309570312 91.60144805908203 L 393.4251098632812 91.60144805908203 L 393.4251098632812 89.71328735351562 L 392.5242309570312 89.71328735351562 L 392.5242309570312 91.60144805908203 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ylo4hz =
    '<svg viewBox="4.1 6.0 1.3 1.0" ><path transform="translate(-226.45, -338.89)" d="M 231.7332458496094 345.7318115234375 L 230.5379943847656 345.7318115234375 L 230.5379943847656 345.4375305175781 L 231.5861206054688 345.4375305175781 L 231.5861206054688 344.885986328125 L 231.8804016113281 344.885986328125 L 231.8804016113281 345.5846557617188 C 231.8803863525391 345.6659240722656 231.8144989013672 345.7318115234375 231.7332458496094 345.7318115234375 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_am7fqj =
    '<svg viewBox="8.0 3.1 1.3 1.0" ><path transform="translate(-390.47, -217.21)" d="M 399.697998046875 221.1300506591797 L 398.5029907226562 221.1300506591797 L 398.5029907226562 220.8357696533203 L 399.5508422851562 220.8357696533203 L 399.5508422851562 220.2840118408203 L 399.8451232910156 220.2840118408203 L 399.8451232910156 220.98291015625 C 399.8451538085938 221.0641479492188 399.7792663574219 221.1300506591797 399.697998046875 221.1300506591797 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_r4yda1 =
    '<svg viewBox="8.0 0.1 1.3 1.0" ><path transform="translate(-390.47, -95.54)" d="M 399.697998046875 96.53604888916016 L 398.5029907226562 96.53604888916016 L 398.5029907226562 96.24176788330078 L 399.5508422851562 96.24176788330078 L 399.5508422851562 95.69000244140625 L 399.8451232910156 95.69000244140625 L 399.8451232910156 96.38889312744141 C 399.8451538085938 96.47016906738281 399.7792663574219 96.53604888916016 399.697998046875 96.53604888916016 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_l5ljp7 =
    '<svg viewBox="7.4 8.4 3.2 3.3" ><path transform="translate(-307.14, -336.45)" d="M 317.6860961914062 344.8819885253906 L 314.5199890136719 344.8819885253906 L 314.5199890136719 347.9442749023438 L 317.6860961914062 348.1895141601562 L 317.6860961914062 344.8819885253906 Z" fill="#a0d9f2" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_gwgmsl =
    '<svg viewBox="0.0 11.5 12.0 1.0" ><path transform="translate(0.0, -463.87)" d="M 11.65652561187744 475.3630065917969 L 0.3597390055656433 475.3630065917969 C 0.1610705107450485 475.3630065917969 0 475.5240783691406 0 475.7227172851562 L 0 476.2146911621094 L 12.01626396179199 476.2146911621094 L 12.01626396179199 475.7227172851562 C 12.01626396179199 475.5240783691406 11.85519409179688 475.3630065917969 11.65652561187744 475.3630065917969 Z" fill="#423e3e" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_buok0r =
    '<svg viewBox="0.0 0.0 2.1 2.1" ><path transform="translate(-325.87, -126.17)" d="M 326.1828918457031 127.9678039550781 C 325.7719421386719 127.5561752319336 325.7719421386719 126.8870315551758 326.1825256347656 126.4757308959961 C 326.5945129394531 126.0644226074219 327.2633056640625 126.0644226074219 327.6746215820312 126.4757308959961 C 328.0859069824219 126.8870315551758 328.0859069824219 127.5561752319336 327.6746215820312 127.9674530029297 L 327.6746215820312 127.9678039550781 C 327.2633666992188 128.3783874511719 326.5942077636719 128.3784332275391 326.1828918457031 127.9678039550781 Z" fill="#00c8c8" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rlried =
    '<svg viewBox="2.5 0.7 9.5 10.6" ><path transform="translate(-102.92, -29.39)" d="M 110.3212814331055 30.13389778137207 C 110.0965423583984 30.10921859741211 109.8696899414062 30.09506225585938 109.6387557983398 30.10380363464355 C 107.83837890625 30.168701171875 106.2611541748047 31.23848342895508 105.3853454589844 32.21833419799805 L 105.3849945068359 37.06089782714844 L 105.690544128418 37.09556198120117 C 106.611686706543 37.20060729980469 107.2492370605469 37.49348449707031 107.5860290527344 37.96656799316406 C 107.9581985473633 38.48945999145508 107.8589859008789 39.10263061523438 107.8198471069336 39.27841186523438 C 107.6894607543945 39.86231231689453 108.0337371826172 40.45673370361328 108.6235656738281 40.57033538818359 C 108.9569396972656 40.63420104980469 109.2920227050781 40.665771484375 109.6246948242188 40.665771484375 C 109.8589782714844 40.665771484375 110.0909576416016 40.64453887939453 110.3213043212891 40.61381149291992 C 112.9256134033203 40.26625823974609 114.9365005493164 38.05075836181641 114.9150543212891 35.35354614257812 C 114.8915252685547 32.4854736328125 112.5745391845703 30.38113975524902 110.3212814331055 30.13389587402344 Z" fill="#fabe2c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-308.59, -30.75)" d="M 320.59375 36.71567535400391 C 320.5702514648438 33.84757995605469 318.2532653808594 31.74324417114258 316 31.49600219726562 L 316 41.9759407043457 C 318.6043090820312 41.62836074829102 320.6152038574219 39.41288757324219 320.59375 36.71567535400391 Z" fill="#ff9100" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_s67rqr =
    '<svg viewBox="0.0 0.0 2.1 2.1" ><path transform="translate(-209.94, -95.1)" d="M 209.9727478027344 96.42287445068359 C 209.8231048583984 95.86710357666016 210.1494903564453 95.28373718261719 210.7184295654297 95.13162994384766 C 211.2787322998047 94.98160552978516 211.8592987060547 95.3153076171875 212.010009765625 95.8773193359375 C 212.1610107421875 96.43953704833984 211.8278198242188 97.01804351806641 211.2643127441406 97.16889190673828 C 210.6995391845703 97.32025146484375 210.1230773925781 96.98516082763672 209.9727478027344 96.42287445068359 Z" fill="#474f54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_drbwpm =
    '<svg viewBox="0.0 0.0 2.1 2.1" ><path transform="translate(-125.08, -179.93)" d="M 125.8637542724609 182.0066070556641 C 125.3017425537109 181.8558807373047 124.9673385620117 181.2763671875 125.1180419921875 180.7150421142578 C 125.2678070068359 180.1548614501953 125.8436431884766 179.8174133300781 126.4092864990234 179.9693603515625 C 126.9726486206055 180.1199645996094 127.3066558837891 180.697509765625 127.1553192138672 181.2609252929688 C 127.0040588378906 181.8260955810547 126.424446105957 182.1568298339844 125.8637542724609 182.0066070556641 Z" fill="#ff435b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_m31yyg =
    '<svg viewBox="0.0 0.0 2.1 2.1" ><path transform="translate(-356.9, -242.05)" d="M 357.6786499023438 244.1246337890625 C 357.1167602539062 243.9742279052734 356.7813110351562 243.3975219726562 356.9329528808594 242.8330535888672 C 357.0841369628906 242.268310546875 357.663818359375 241.9369506835938 358.2245178222656 242.0873718261719 C 358.7865295410156 242.2380981445312 359.1209411621094 242.8176116943359 358.97021484375 243.3789367675781 C 358.8196105957031 243.9423522949219 358.2406616210938 244.2758026123047 357.6786499023438 244.1246337890625 Z" fill="#99341f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_sl173 =
    '<svg viewBox="0.0 0.0 3.5 12.0" ><path transform="translate(-44.92, 0.0)" d="M 47.0546875 0.003997854422777891 C 46.18299865722656 0.003997854422777891 46 3.277677536010742 46 6.003997802734375 C 46 6.126528739929199 46.00154876708984 6.238958358764648 46.00248336791992 6.355560302734375 L 46.74704742431641 6.707122802734375 L 47.0546875 6.707122802734375 L 47.55271148681641 6.707122802734375 L 48.1070556640625 6.355560302734375 C 48.1079216003418 6.238912582397461 48.109375 6.128498077392578 48.109375 6.003997802734375 C 48.109375 3.277653932571411 47.92637634277344 0.003997802734375 47.0546875 0.003997802734375 Z" fill="#b35324" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-88.87, 0.0)" d="M 92.0523681640625 6.355560302734375 C 92.05323791503906 6.238912582397461 92.0546875 6.128498077392578 92.0546875 6.003997802734375 C 92.0546875 3.277677536010742 91.87168884277344 0.003997802734375 91 0.003997802734375 L 91 6.707122802734375 L 91.49802398681641 6.707122802734375 L 92.0523681640625 6.355560302734375 Z" fill="#99341f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-45.03, -264.65)" d="M 47.158203125 271.0039978027344 L 46.10599899291992 271.0039978027344 C 46.11856079101562 272.5587158203125 46.20767211914062 273.5800476074219 46.21268844604492 273.6740112304688 L 47.158203125 273.6740112304688 L 48.10371780395508 273.6740112304688 C 48.11295318603516 273.5023803710938 48.19894409179688 272.6260375976562 48.2105712890625 271.0039978027344 L 47.158203125 271.0039978027344 Z" fill="#fff7e6" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-88.87, -264.65)" d="M 92.0523681640625 271.0039978027344 L 91 271.0039978027344 L 91 273.6740112304688 L 91.94551849365234 273.6740112304688 C 91.95472717285156 273.5023498535156 92.04074096679688 272.6260070800781 92.0523681640625 271.0039978027344 Z" fill="#ffccb3" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.0, -352.54)" d="M 2.1328125 361.0039978027344 C 1.357242226600647 361.0039978027344 0.7265625 361.6346740722656 0.7265625 362.4102478027344 L 0.7265625 363.1133728027344 C 0.7265625 363.5009765625 0.3876093626022339 363.8399353027344 0 363.8399353027344 L 0 364.5430603027344 L 1.4296875 364.5430603027344 C 1.677445292472839 364.5430603027344 1.911796808242798 364.4923095703125 2.1328125 364.4135131835938 C 2.949492216110229 364.122314453125 3.5390625 363.32568359375 3.5390625 362.4102478027344 C 3.5390625 361.6346740722656 2.908382892608643 361.0039978027344 2.1328125 361.0039978027344 Z" fill="#474f54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-88.87, -352.54)" d="M 92.40625 362.4102478027344 C 92.40625 361.6346740722656 91.77557373046875 361.0039978027344 91 361.0039978027344 L 91 364.4135131835938 C 91.81668090820312 364.122314453125 92.40625 363.32568359375 92.40625 362.4102478027344 Z" fill="#32393f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_j2ya70 =
    '<svg viewBox="7.4 7.8 1.1 2.1" ><path transform="translate(-308.59, -323.24)" d="M 317.0546875 332.0586853027344 C 317.0546875 331.4761962890625 316.5824890136719 331.0039978027344 316 331.0039978027344 L 316 333.1133728027344 C 316.5824890136719 333.1133728027344 317.0546875 332.6411743164062 317.0546875 332.0586853027344 Z" fill="#ffe6cc" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_hl6xl =
    '<svg viewBox="0.9 3.5 10.3 4.3" ><path transform="translate(-37.49, -10.41)" d="M 45.43801116943359 18.14746856689453 L 41.86837005615234 14.57784938812256 L 38.75442886352539 17.69176864624023 L 38.40000152587891 17.33734512329102 L 41.86837005615234 13.86900043487549 L 45.43801116943359 17.43861770629883 L 48.374755859375 14.50189971923828 L 48.72917938232422 14.85632419586182 L 45.43801116943359 18.14746856689453 Z" fill="#cdd6e0" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_mhel9 =
    '<svg viewBox="0.0 0.0 3.2 7.2" ><path transform="translate(-329.22, -116.67)" d="M 329.966064453125 116.6669921875 L 329.2210083007812 116.6669921875 L 329.2210083007812 117.7919921875 L 329.966064453125 117.7919921875 C 330.683349609375 117.7919921875 331.266845703125 118.3755187988281 331.266845703125 119.0927734375 L 331.266845703125 121.4833984375 C 331.266845703125 122.2006530761719 330.683349609375 122.7841796875 329.966064453125 122.7841796875 L 329.2210083007812 122.7841796875 L 329.2210083007812 123.9091796875 L 329.966064453125 123.9091796875 C 331.3036499023438 123.9091796875 332.391845703125 122.8209762573242 332.391845703125 121.4833984375 L 332.391845703125 119.0927734375 C 332.391845703125 117.7551727294922 331.3036499023438 116.6669921875 329.966064453125 116.6669921875 Z" fill="#e2e9ee" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_nkm4po =
    '<svg viewBox="37.7 0.2 6.9 11.5" ><path transform="translate(-9.74, -91.88)" d="M 47.79833221435547 94.08300018310547 L 47.79833221435547 101.9727478027344 C 47.79833221435547 102.2366256713867 47.71812438964844 102.4942474365234 47.56833648681641 102.7114868164062 C 47.29639434814453 103.1059265136719 47.57872009277344 103.6435546875 48.05780792236328 103.6435546875 L 50.91010284423828 103.6435546875 L 50.93209075927734 103.6435546875 L 53.78438568115234 103.6435546875 C 54.26347351074219 103.6435546875 54.54582214355469 103.1059265136719 54.27388000488281 102.7115173339844 C 54.12408828735352 102.4942779541016 54.04388427734375 102.2366256713867 54.04388427734375 101.9727630615234 L 54.04388427734375 94.3154296875 L 47.79833221435547 94.08300018310547 Z" fill="#e2e9ee" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-23.74, -191.73)" d="M 61.80199813842773 196.3329925537109 L 68.04753112792969 196.3329925537109 L 68.04753112792969 200.4267578125 L 68.04753112792969 201.2939453125 C 68.04753112792969 201.8117065429688 67.62778472900391 202.2314453125 67.11003112792969 202.2314453125 L 62.73949813842773 202.2314453125 C 62.22174072265625 202.2314453125 61.80199813842773 201.8117065429688 61.80199813842773 201.2939453125 L 61.80199813842773 200.4267578125 L 61.80199813842773 196.3329925537109 Z" fill="#ffcd69" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-23.74, -9.77)" d="M 68.06022644042969 11.85897254943848 C 68.00862121582031 11.3822774887085 67.63069152832031 11.0168628692627 67.15267944335938 10.97941017150879 C 66.85931396484375 10.95641803741455 66.59034729003906 11.06118392944336 66.39492797851562 11.24366760253906 C 66.28102111816406 10.53855133056641 65.66976928710938 10.00000381469727 64.93251800537109 10.00000381469727 C 64.19517517089844 10.00000381469727 63.58390045166016 10.53866767883301 63.47008895874023 11.2438793182373 C 63.27466583251953 11.06127738952637 63.00567626953125 10.95644187927246 62.71223831176758 10.9793872833252 C 62.23416137695312 11.01676940917969 61.85615921020508 11.38220691680908 61.80455017089844 11.85897254943848 C 61.73979187011719 12.45735549926758 62.20683288574219 12.96337127685547 62.79209136962891 12.96337127685547 L 64.24137115478516 12.96337127685547 C 64.61473083496094 12.96337127685547 64.91742706298828 13.26604270935059 64.91742706298828 13.63942623138428 L 64.91742706298828 15.02481651306152 C 64.91742706298828 15.42025375366211 65.22745513916016 15.75452041625977 65.62275695800781 15.76534843444824 C 66.03286743164062 15.77659797668457 66.36886596679688 15.44748878479004 66.36886596679688 15.0399112701416 L 66.36886596679688 13.64486312866211 C 66.36886596679688 13.26290321350098 66.68252563476562 12.96023082733154 67.06448364257812 12.96332454681396 C 67.06723022460938 12.96334838867188 67.06999206542969 12.96334838867188 67.07273864746094 12.96334838867188 C 67.65794372558594 12.96337223052979 68.12501525878906 12.45735549926758 68.06022644042969 11.85897350311279 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ygk4xg =
    '<svg viewBox="0.0 0.0 10.2 12.0" ><path transform="translate(-37.49, 0.0)" d="M 45.07284545898438 2.500004291534424 L 44.5251579284668 2.500004291534424 C 44.55982208251953 2.36043381690979 44.57060241699219 2.214324474334717 44.55478286743164 2.068121194839478 C 44.49152374267578 1.483683824539185 44.01953887939453 1.026113510131836 43.43252563476562 0.9801291227340698 C 43.21167373657227 0.9628556966781616 42.99169158935547 1.005840063095093 42.79610443115234 1.101043224334717 C 42.69480895996094 0.8376057147979736 42.52891540527344 0.6006994247436523 42.311767578125 0.4140665233135223 C 42.00112915039062 0.1470430791378021 41.60416412353516 -3.814697265625e-06 41.19403076171875 -3.814697265625e-06 C 40.78387451171875 -3.814697265625e-06 40.38689422607422 0.14706651866436 40.07622909545898 0.4141134321689606 C 39.85907745361328 0.6007462739944458 39.6932373046875 0.837675929069519 39.59196472167969 1.101136922836304 C 39.39637756347656 1.005886912345886 39.17646026611328 0.962878942489624 38.95547103881836 0.9801055192947388 C 38.36836242675781 1.026043057441711 37.89630889892578 1.48361349105835 37.83304595947266 2.068121194839478 C 37.82810211181641 2.11391806602478 37.82587432861328 2.159691333770752 37.82601928710938 2.20527720451355 L 37.82578277587891 2.205066204071045 L 37.82578277587891 10.09480857849121 C 37.82578277587891 10.3121452331543 37.76058197021484 10.52160549163818 37.63720703125 10.70052719116211 C 37.46182250976562 10.95491790771484 37.44208526611328 11.28290271759033 37.58578491210938 11.55646514892578 C 37.72943115234375 11.83005046844482 38.01063537597656 11.99999618530273 38.31963348388672 11.99999618530273 L 41.17193222045898 11.99999618530273 C 41.17563629150391 11.99999618530273 41.17924499511719 11.99962139129639 41.18292236328125 11.99943447113037 C 41.18660354614258 11.99959754943848 41.19021606445312 11.99999618530273 41.19391632080078 11.99999618530273 L 44.04621124267578 11.99999618530273 C 44.3552131652832 11.99999618530273 44.63641357421875 11.83005046844482 44.78011322021484 11.55648803710938 C 44.92378234863281 11.28292560577393 44.90407180786133 10.95494079589844 44.72866821289062 10.70052719116211 C 44.62744140625 10.55371475219727 44.56544494628906 10.38632392883301 44.54641723632812 10.21091747283936 L 45.07284545898438 10.21091747283936 C 46.53965759277344 10.21091747283936 47.73300170898438 9.017573356628418 47.73300170898438 7.550761222839355 L 47.73300170898438 5.160136222839355 C 47.73300170898438 3.693346738815308 46.53965759277344 2.500003099441528 45.07284545898438 2.500003099441528 Z M 44.07131195068359 4.367176532745361 L 42.86475372314453 4.367176532745361 L 42.86475372314453 3.879230976104736 C 42.86475372314453 3.760168552398682 42.91130065917969 3.648418664932251 42.9958381652832 3.5645592212677 C 43.08300018310547 3.478098392486572 43.19979095458984 3.430754661560059 43.32403564453125 3.432067155838013 L 43.33425140380859 3.432113885879517 C 43.60181427001953 3.432113885879517 43.86028289794922 3.344012260437012 44.07133483886719 3.185715436935425 L 44.07133483886719 4.367176532745361 Z M 44.54006195068359 4.093754291534424 L 45.07284545898438 4.093754291534424 C 45.66086959838867 4.093754291534424 46.13925170898438 4.572137355804443 46.13925170898438 5.160161018371582 L 46.13925170898438 7.550785541534424 C 46.13925170898438 8.138809204101562 45.66086959838867 8.617192268371582 45.07284545898438 8.617192268371582 L 44.54006195068359 8.617192268371582 L 44.54006195068359 4.093754291534424 Z M 38.29907989501953 2.118582487106323 C 38.33873748779297 1.752231001853943 38.62368774414062 1.476254343986511 38.99203491210938 1.447449564933777 C 39.01279830932617 1.445832371711731 39.033447265625 1.445012092590332 39.05397796630859 1.445012092590332 C 39.24729156494141 1.445012092590332 39.42919158935547 1.516449689865112 39.57159423828125 1.649527788162231 C 39.63485336303711 1.708613634109497 39.72553253173828 1.728066802024841 39.80747222900391 1.700035572052002 C 39.88938522338867 1.672004342079163 39.94917297363281 1.601105928421021 39.96297836303711 1.515629410743713 C 40.06087493896484 0.909019947052002 40.57861328125 0.4687464833259583 41.19403076171875 0.4687464833259583 C 41.80936431884766 0.4687464833259583 42.32709503173828 0.9089261293411255 42.42506408691406 1.515418410301208 C 42.43886947631836 1.600871443748474 42.4986572265625 1.671746492385864 42.58055114746094 1.699801206588745 C 42.66243743896484 1.727832436561584 42.75312042236328 1.708426117897034 42.81639862060547 1.64936363697052 C 42.97396850585938 1.502223014831543 43.17972946166992 1.430551171302795 43.39591979980469 1.447449564933777 C 43.76419067382812 1.476301193237305 44.04909515380859 1.752277731895447 44.08875274658203 2.118582487106323 C 44.11251831054688 2.338168382644653 44.0452995300293 2.548590183258057 43.89942169189453 2.711082458496094 C 43.7554931640625 2.871418476104736 43.54950332641602 2.963387012481689 43.334228515625 2.963387012481689 L 43.327880859375 2.963363647460938 C 43.07772827148438 2.961301326751709 42.84230041503906 3.056645154953003 42.66572189331055 3.231793403625488 C 42.49179077148438 3.404316902160645 42.39600372314453 3.634262084960938 42.39600372314453 3.879254341125488 L 42.39600372314453 5.274277687072754 C 42.39600372314453 5.408058643341064 42.34317398071289 5.533144950866699 42.24724578857422 5.626496315002441 C 42.15135955810547 5.719754219055176 42.02487182617188 5.769043445587158 41.89066696166992 5.765457630157471 C 41.62744140625 5.758238792419434 41.41329193115234 5.531129360198975 41.41329193115234 5.259183883666992 L 41.41329193115234 3.873793363571167 C 41.41329193115234 3.371785402297974 41.00489044189453 2.963363409042358 40.50288391113281 2.963363409042358 L 39.05360412597656 2.963363409042358 C 38.83833312988281 2.963363409042358 38.63233947753906 2.871394634246826 38.48843383789062 2.711058855056763 C 38.34255981445312 2.548566579818726 38.27531433105469 2.338144779205322 38.29907989501953 2.118582248687744 Z M 40.94454193115234 4.367176532745361 L 38.29453277587891 4.367176532745361 L 38.29453277587891 3.168840408325195 C 38.50945281982422 3.337778091430664 38.77668762207031 3.432090282440186 39.05360412597656 3.432090282440186 L 40.50288391113281 3.432090282440186 C 40.74642181396484 3.432090282440186 40.94454193115234 3.630230903625488 40.94454193115234 3.873769998550415 L 40.94454193115234 4.367176532745361 Z M 44.36508178710938 11.33852100372314 C 44.30170440673828 11.45919990539551 44.18250274658203 11.53124713897705 44.04621124267578 11.53124713897705 L 41.19391632080078 11.53124713897705 C 41.19021224975586 11.53124713897705 41.18660354614258 11.5316219329834 41.18292236328125 11.53180885314941 C 41.17924499511719 11.53164577484131 41.17563629150391 11.53124713897705 41.17193222045898 11.53124713897705 L 38.31963348388672 11.53124713897705 C 38.18334579467773 11.53124713897705 38.06411743164062 11.45919990539551 38.00076675415039 11.33852100372314 C 37.93739318847656 11.21786403656006 37.94573593139648 11.07880973815918 38.02312469482422 10.96661376953125 C 38.12944030761719 10.8124418258667 38.20547103881836 10.64242649078369 38.24960327148438 10.46376323699951 C 38.45269012451172 10.63262939453125 38.7135009765625 10.73437213897705 38.99765777587891 10.73437213897705 L 40.12823486328125 10.73437213897705 C 40.25768280029297 10.73437213897705 40.36260986328125 10.62944221496582 40.36260986328125 10.49999713897705 C 40.36260986328125 10.37055110931396 40.25768280029297 10.26562213897705 40.12823486328125 10.26562213897705 L 38.99765777587891 10.26562213897705 C 38.60995483398438 10.26562213897705 38.29453277587891 9.950200080871582 38.29453277587891 9.562497138977051 L 38.29453277587891 4.835926055908203 L 40.94454193115234 4.835926055908203 L 40.94454193115234 5.25916051864624 C 40.94454193115234 5.782590389251709 41.36320495605469 6.219887256622314 41.87782287597656 6.233996391296387 C 41.88691711425781 6.234253883361816 41.89596557617188 6.234371185302734 41.90501022338867 6.234371185302734 C 42.15656280517578 6.234371185302734 42.39328384399414 6.138394355773926 42.57412719726562 5.962425708770752 C 42.76153564453125 5.780081748962402 42.86473083496094 5.535675525665283 42.86473083496094 5.274253845214844 L 42.86473083496094 4.835925579071045 L 44.0712890625 4.835925579071045 L 44.0712890625 9.562497138977051 C 44.0712890625 9.950200080871582 43.75586700439453 10.26562213897705 43.3681640625 10.26562213897705 L 42.23760986328125 10.26562213897705 C 42.10816955566406 10.26562213897705 42.00323486328125 10.37055110931396 42.00323486328125 10.49999713897705 C 42.00323486328125 10.62944221496582 42.10816955566406 10.73437213897705 42.23760986328125 10.73437213897705 L 43.36819076538086 10.73437213897705 C 43.65234375 10.73437213897705 43.91316223144531 10.63262939453125 44.11626815795898 10.46376323699951 C 44.16037750244141 10.6424503326416 44.23643493652344 10.81244277954102 44.34274291992188 10.96661376953125 C 44.42011260986328 11.07883262634277 44.42845916748047 11.21786403656006 44.36508178710938 11.33852100372314 Z M 47.26425170898438 7.550785541534424 C 47.26425170898438 8.759129524230957 46.28118896484375 9.742192268371582 45.07284545898438 9.742192268371582 L 44.54006195068359 9.742192268371582 L 44.54006195068359 9.085942268371582 L 45.07284545898438 9.085942268371582 C 45.91933822631836 9.085942268371582 46.60800170898438 8.39727783203125 46.60800170898438 7.550785541534424 L 46.60800170898438 5.160160541534424 C 46.60800170898438 4.313668251037598 45.91933822631836 3.625004053115845 45.07284545898438 3.625004053115845 L 44.54006195068359 3.625004053115845 L 44.54006195068359 2.968754053115845 L 45.07284545898438 2.968754053115845 C 46.28118896484375 2.968754053115845 47.26425170898438 3.951816558837891 47.26425170898438 5.160160541534424 L 47.26425170898438 7.550785541534424 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-181.58, -427.73)" d="M 185.2703704833984 438 C 185.2087249755859 438 185.1484985351562 438.0250854492188 185.1046752929688 438.0686645507812 C 185.0610656738281 438.1122436523438 185.0359954833984 438.1727294921875 185.0359954833984 438.234375 C 185.0359954833984 438.2960205078125 185.0610656738281 438.3565063476562 185.1046752929688 438.4000854492188 C 185.1484985351562 438.4436645507812 185.2087249755859 438.46875 185.2703704833984 438.46875 C 185.3322448730469 438.46875 185.3924865722656 438.4436645507812 185.4360656738281 438.4000854492188 C 185.4798889160156 438.3565063476562 185.5047454833984 438.2960205078125 185.5047454833984 438.234375 C 185.5047454833984 438.1727294921875 185.4798889160156 438.1122741699219 185.4360656738281 438.0686645507812 C 185.3924865722656 438.0250854492188 185.3322448730469 438 185.2703704833984 438 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_mwklm6 =
    '<svg viewBox="0.2 3.4 4.6 3.7" ><path transform="translate(-19.82, -21.65)" d="M 22.30766868591309 28.23077011108398 C 23.00597763061523 28.23077011108398 23.00597763061523 28.69230842590332 23.71328353881836 28.69230842590332 C 24.76743698120117 28.69230842590332 24.86713027954102 27.30769348144531 24.16974639892578 26.61538505554199 C 23.47236251831055 25.9230785369873 23.47143936157227 25 22.30766868591309 25 C 21.14389991760254 25 21.14389991760254 25.9230785369873 20.44559097290039 26.61538505554199 C 19.74728393554688 27.30769348144531 19.847900390625 28.69230842590332 20.90205383300781 28.69230842590332 C 21.60936164855957 28.69230842590332 21.60936164855957 28.23077011108398 22.30766868591309 28.23077011108398 Z" fill="#35495e" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jfx1mq =
    '<svg viewBox="0.2 0.0 13.4 12.0" ><path transform="translate(-0.77, 0.0)" d="M 14.38461589813232 4.18153715133667 C 14.38231372833252 4.642046451568604 14.32969379425049 5.100924491882324 14.22769260406494 5.549998760223389 C 13.7407693862915 7.767690658569336 12.00769233703613 10.60615158081055 7.692307949066162 11.99999809265137 C 3.376923084259033 10.60615158081055 1.64384651184082 7.767690658569336 1.156923294067383 5.54999828338623 C 1.054922461509705 5.100924015045166 1.002302408218384 4.642045974731445 1.000000238418579 4.181536674499512 C 1.000000238418579 1.943075299263 2.366154193878174 -1.9073486328125e-06 4.34615421295166 -1.9073486328125e-06 C 5.623288631439209 0.005161323584616184 6.838715553283691 0.5500088334083557 7.692307949066162 1.499998092651367 C 8.545900344848633 0.5500088334083557 9.761327743530273 0.005160368513315916 11.03846168518066 -1.9073486328125e-06 C 13.01846218109131 -1.9073486328125e-06 14.38461589813232 1.943075060844421 14.38461589813232 4.181536674499512 Z" fill="#df4d60" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-0.77, 0.0)" d="M 14.38461589813232 4.18153715133667 C 14.38231372833252 4.642046451568604 14.32969379425049 5.100924491882324 14.22769260406494 5.549998760223389 C 12.9907693862915 7.052306652069092 10.52846145629883 8.076921463012695 7.692307949066162 8.076921463012695 C 4.856153964996338 8.076921463012695 2.39384651184082 7.052306175231934 1.156923294067383 5.54999828338623 C 1.054922461509705 5.100924015045166 1.002302408218384 4.642045974731445 1.000000238418579 4.181536674499512 C 1.000000238418579 1.943075299263 2.366154193878174 -1.9073486328125e-06 4.34615421295166 -1.9073486328125e-06 C 5.623288631439209 0.005161323584616184 6.838715553283691 0.5500088334083557 7.692307949066162 1.499998092651367 C 8.545900344848633 0.5500088334083557 9.761327743530273 0.005160368513315916 11.03846168518066 -1.9073486328125e-06 C 13.01846218109131 -1.9073486328125e-06 14.38461589813232 1.943075060844421 14.38461589813232 4.181536674499512 Z" fill="#ff5364" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-9.23, -2.31)" d="M 12.2276725769043 3.547138214111328 C 12.11311912536621 3.547589302062988 12.01557445526123 3.463938236236572 11.99855518341064 3.350654602050781 C 11.98153686523438 3.23737096786499 12.05019664764404 3.128751277923584 12.15982627868652 3.095523118972778 C 12.36878871917725 3.031726360321045 12.58611297607422 2.999524354934692 12.80459594726562 2.999984741210938 C 12.93204593658447 2.999984741210938 13.03536510467529 3.1033034324646 13.03536510467529 3.230753898620605 C 13.03536510467529 3.358204364776611 12.93204593658447 3.461523056030273 12.80459594726562 3.461523056030273 C 12.63210582733154 3.461133480072021 12.46052360534668 3.486489772796631 12.29551887512207 3.536754131317139 C 12.27354717254639 3.543578147888184 12.25067901611328 3.547078609466553 12.2276725769043 3.547138690948486 Z" fill="#fb7b76" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-3.08, -3.84)" d="M 4.230769157409668 8.251214981079102 C 4.103318691253662 8.251214981079102 4 8.147895812988281 4 8.02044677734375 C 4 6.809599876403809 4.474461555480957 5.669138431549072 5.238307952880859 5.044676780700684 C 5.301965236663818 4.990966320037842 5.389625549316406 4.975725650787354 5.467675685882568 5.004798889160156 C 5.54572582244873 5.033871650695801 5.602053642272949 5.102746963500977 5.615060806274414 5.185013771057129 C 5.628067970275879 5.267281055450439 5.595735549926758 5.350173950195312 5.530461311340332 5.401907920837402 C 4.881076812744141 5.932908058166504 4.461538314819336 6.960753917694092 4.461538314819336 8.02044677734375 C 4.461538314819336 8.147895812988281 4.358219623565674 8.251214981079102 4.230769157409668 8.251214981079102 Z" fill="#fb7b76" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_di61e2 =
    '<svg viewBox="0.0 5.8 13.8 3.2" ><path transform="translate(0.0, -19.24)" d="M 3.230769872665405 28.23591995239258 C 3.139549016952515 28.23593139648438 3.056882381439209 28.18220901489258 3.01984691619873 28.09884262084961 L 2.295462369918823 26.46868896484375 L 2.053847074508667 26.95445823669434 C 2.014564037322998 27.03307342529297 1.934037685394287 27.08255386352539 1.846154808998108 27.08207321166992 L 0.2307701855897903 27.08207321166992 C 0.1033197939395905 27.08207321166992 9.5367431640625e-07 26.97875595092773 9.5367431640625e-07 26.85130500793457 C 9.5367431640625e-07 26.72385406494141 0.1033198013901711 26.62053489685059 0.2307701855897903 26.62053489685059 L 1.703539371490479 26.62053489685059 L 2.101154804229736 25.8250732421875 C 2.140390872955322 25.74455833435059 2.223250150680542 25.6945915222168 2.312770366668701 25.69745826721191 C 2.402144193649292 25.69942283630371 2.482343435287476 25.75283050537109 2.518616437911987 25.83453559875488 L 3.169385671615601 27.29899597167969 L 3.700154781341553 25.17984390258789 C 3.731847286224365 25.05706024169922 3.856672525405884 24.98285293579102 3.979678392410278 25.01366806030273 C 4.10268497467041 25.04448127746582 4.177783012390137 25.16877365112305 4.147846698760986 25.2919979095459 L 3.455538988113403 28.06122970581055 C 3.431607961654663 28.15666961669922 3.349792957305908 28.2264404296875 3.251769542694092 28.2349967956543 C 3.244791030883789 28.23567581176758 3.237781047821045 28.23598480224609 3.230769634246826 28.23591995239258 Z" fill="#ecf0f1" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-32.82, -19.23)" d="M 43.66369247436523 27.76907730102539 L 43.65261840820312 27.76907730102539 C 43.5574951171875 27.76442718505859 43.47499847412109 27.70182418823242 43.44492340087891 27.6114616394043 L 42.67461395263672 25.30377006530762 C 42.64856338500977 25.2254467010498 42.66627502441406 25.13917350769043 42.72107696533203 25.07744979858398 C 42.77588272094727 25.01572418212891 42.85945129394531 24.9879264831543 42.9403076171875 25.00452613830566 C 43.02116394042969 25.02112579345703 43.0870246887207 25.07959938049316 43.11307525634766 25.15792465209961 L 43.69530868530273 26.90138626098633 L 44.37677001953125 25.36792373657227 C 44.4154052734375 25.28432083129883 44.49905395507812 25.23074531555176 44.59115600585938 25.23061561584473 C 44.68392181396484 25.23231506347656 44.76665496826172 25.28940773010254 44.80115509033203 25.37553977966309 L 45.20454025268555 26.38446235656738 L 46.43292236328125 26.38446235656738 C 46.56037521362305 26.38446235656738 46.66369247436523 26.4877815246582 46.66369247436523 26.61523056030273 C 46.66369247436523 26.7426815032959 46.56037521362305 26.84600067138672 46.43292236328125 26.84600067138672 L 45.04830932617188 26.84600067138672 C 44.95393753051758 26.84607315063477 44.8690299987793 26.78867530822754 44.83392333984375 26.70107650756836 L 44.57546234130859 26.05492401123047 L 43.87461853027344 27.63223266601562 C 43.8375129699707 27.71550559997559 43.75485992431641 27.76913070678711 43.66369247436523 27.76907730102539 Z" fill="#ecf0f1" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ugeyvt =
    '<svg viewBox="0.0 0.0 3.7 4.5" ><path transform="translate(-136.0, -264.0)" d="M 136 264 L 136.4067840576172 264 L 136.4067840576172 264.4067993164062 L 136 264.4067993164062 L 136 264 Z M 136 264" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-167.19, -264.0)" d="M 168 264 L 168.4067840576172 264 L 168.4067840576172 264.4067993164062 L 168 264.4067993164062 L 168 264 Z M 168 264" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-198.37, -264.0)" d="M 200 264 L 200.4067840576172 264 L 200.4067840576172 264.4067993164062 L 200 264.4067993164062 L 200 264 Z M 200 264" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-136.0, -295.19)" d="M 136 296 L 136.4067840576172 296 L 136.4067840576172 296.4067687988281 L 136 296.4067687988281 L 136 296 Z M 136 296" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-167.19, -295.19)" d="M 168 296 L 168.4067840576172 296 L 168.4067840576172 296.4067687988281 L 168 296.4067687988281 L 168 296 Z M 168 296" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-198.37, -295.19)" d="M 200 296 L 200.4067840576172 296 L 200.4067840576172 296.4067687988281 L 200 296.4067687988281 L 200 296 Z M 200 296" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-229.56, -295.19)" d="M 232 296 L 232.4067840576172 296 L 232.4067840576172 296.4067687988281 L 232 296.4067687988281 L 232 296 Z M 232 296" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-260.75, -295.19)" d="M 264 296 L 264.4067993164062 296 L 264.4067993164062 296.4067687988281 L 264 296.4067687988281 L 264 296 Z M 264 296" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-136.0, -326.37)" d="M 136 328 L 136.4067840576172 328 L 136.4067840576172 328.4067687988281 L 136 328.4067687988281 L 136 328 Z M 136 328" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-167.19, -326.37)" d="M 168 328 L 168.4067840576172 328 L 168.4067840576172 328.4067687988281 L 168 328.4067687988281 L 168 328 Z M 168 328" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-198.37, -326.37)" d="M 200 328 L 200.4067840576172 328 L 200.4067840576172 328.4067687988281 L 200 328.4067687988281 L 200 328 Z M 200 328" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-229.56, -326.37)" d="M 232 328 L 232.4067840576172 328 L 232.4067840576172 328.4067687988281 L 232 328.4067687988281 L 232 328 Z M 232 328" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-260.75, -326.37)" d="M 264 328 L 264.4067993164062 328 L 264.4067993164062 328.4067687988281 L 264 328.4067687988281 L 264 328 Z M 264 328" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-136.0, -357.56)" d="M 136 360 L 136.4067840576172 360 L 136.4067840576172 360.4067687988281 L 136 360.4067687988281 L 136 360 Z M 136 360" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-167.19, -357.56)" d="M 168 360 L 168.4067840576172 360 L 168.4067840576172 360.4067687988281 L 168 360.4067687988281 L 168 360 Z M 168 360" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-198.37, -357.56)" d="M 200 360 L 200.4067840576172 360 L 200.4067840576172 360.4067687988281 L 200 360.4067687988281 L 200 360 Z M 200 360" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-229.56, -357.56)" d="M 232 360 L 232.4067840576172 360 L 232.4067840576172 360.4067687988281 L 232 360.4067687988281 L 232 360 Z M 232 360" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-260.75, -357.56)" d="M 264 360 L 264.4067993164062 360 L 264.4067993164062 360.4067687988281 L 264 360.4067687988281 L 264 360 Z M 264 360" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-136.0, -388.75)" d="M 136 392 L 136.4067840576172 392 L 136.4067840576172 392.4067993164062 L 136 392.4067993164062 L 136 392 Z M 136 392" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-167.19, -388.75)" d="M 168 392 L 168.4067840576172 392 L 168.4067840576172 392.4067993164062 L 168 392.4067993164062 L 168 392 Z M 168 392" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-198.37, -388.75)" d="M 200 392 L 200.4067840576172 392 L 200.4067840576172 392.4067993164062 L 200 392.4067993164062 L 200 392 Z M 200 392" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-229.56, -388.75)" d="M 232 392 L 232.4067840576172 392 L 232.4067840576172 392.4067993164062 L 232 392.4067993164062 L 232 392 Z M 232 392" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-260.75, -388.75)" d="M 264 392 L 264.4067993164062 392 L 264.4067993164062 392.4067993164062 L 264 392.4067993164062 L 264 392 Z M 264 392" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-136.0, -419.93)" d="M 136 424 L 136.4067840576172 424 L 136.4067840576172 424.4067687988281 L 136 424.4067687988281 L 136 424 Z M 136 424" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-167.19, -419.93)" d="M 168 424 L 168.4067840576172 424 L 168.4067840576172 424.4067687988281 L 168 424.4067687988281 L 168 424 Z M 168 424" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-198.37, -419.93)" d="M 200 424 L 200.4067840576172 424 L 200.4067840576172 424.4067687988281 L 200 424.4067687988281 L 200 424 Z M 200 424" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-229.56, -419.93)" d="M 232 424 L 232.4067840576172 424 L 232.4067840576172 424.4067687988281 L 232 424.4067687988281 L 232 424 Z M 232 424" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-260.75, -419.93)" d="M 264 424 L 264.4067993164062 424 L 264.4067993164062 424.4067687988281 L 264 424.4067687988281 L 264 424 Z M 264 424" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eyd1j1 =
    '<svg viewBox="0.2 2.4 12.0 9.6" ><path transform="translate(-389.83, -405.42)" d="M 400.6101684570312 417.2203369140625 C 400.273193359375 417.2203369140625 400 416.9471435546875 400 416.6101684570312 C 400 416.2732238769531 400.273193359375 416 400.6101684570312 416 C 400.9471435546875 416 401.2203369140625 416.2732238769531 401.2203369140625 416.6101684570312 C 401.2203369140625 416.9471435546875 400.9471435546875 417.2203369140625 400.6101684570312 417.2203369140625 Z M 400.6101684570312 416.4067993164062 C 400.4978332519531 416.4067993164062 400.4067687988281 416.4978637695312 400.4067687988281 416.6101684570312 C 400.4067687988281 416.7225036621094 400.4978332519531 416.8135681152344 400.6101684570312 416.8135681152344 C 400.7224731445312 416.8135681152344 400.8135681152344 416.7225036621094 400.8135681152344 416.6101684570312 C 400.8135681152344 416.4978637695312 400.7224731445312 416.4067993164062 400.6101684570312 416.4067993164062 Z M 400.6101684570312 416.4067993164062" fill="#6cbdbd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-421.02, -405.42)" d="M 432.6101684570312 417.2203369140625 C 432.273193359375 417.2203369140625 432 416.9471435546875 432 416.6101684570312 C 432 416.2732238769531 432.273193359375 416 432.6101684570312 416 C 432.9471130371094 416 433.2203369140625 416.2732238769531 433.2203369140625 416.6101684570312 C 433.2203369140625 416.9471435546875 432.9471130371094 417.2203369140625 432.6101684570312 417.2203369140625 Z M 432.6101684570312 416.4067993164062 C 432.4978332519531 416.4067993164062 432.4067687988281 416.4978637695312 432.4067687988281 416.6101684570312 C 432.4067687988281 416.7225036621094 432.4978332519531 416.8135681152344 432.6101684570312 416.8135681152344 C 432.7224731445312 416.8135681152344 432.8135375976562 416.7225036621094 432.8135375976562 416.6101684570312 C 432.8135375976562 416.4978637695312 432.7224731445312 416.4067993164062 432.6101684570312 416.4067993164062 Z M 432.6101684570312 416.4067993164062" fill="#6cbdbd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-405.42, -374.24)" d="M 416.6101684570312 385.2203369140625 C 416.2732238769531 385.2203369140625 416 384.9471130371094 416 384.6101684570312 C 416 384.273193359375 416.2732238769531 384 416.6101684570312 384 C 416.9471435546875 384 417.2203369140625 384.273193359375 417.2203369140625 384.6101684570312 C 417.2203369140625 384.9471130371094 416.9471435546875 385.2203369140625 416.6101684570312 385.2203369140625 Z M 416.6101684570312 384.4067687988281 C 416.4978637695312 384.4067687988281 416.4067993164062 384.4978332519531 416.4067993164062 384.6101684570312 C 416.4067993164062 384.7224731445312 416.4978637695312 384.8135375976562 416.6101684570312 384.8135375976562 C 416.7225036621094 384.8135375976562 416.8135681152344 384.7224731445312 416.8135681152344 384.6101684570312 C 416.8135681152344 384.4978332519531 416.7225036621094 384.4067687988281 416.6101684570312 384.4067687988281 Z M 416.6101684570312 384.4067687988281" fill="#6cbdbd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-7.8, -413.22)" d="M 8 425.0169372558594 L 9.016949653625488 424 L 10.03389835357666 425.0169372558594" fill="#b3b3b3" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-101.36, -93.56)" d="M 104 96 L 104.4067840576172 96 L 104.4067840576172 98.84745788574219 L 104 98.84745788574219 L 104 96 Z M 104 96" fill="#008fcf" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-288.47, -132.54)" d="M 296 136 L 296.4067687988281 136 L 296.4067687988281 139.4576263427734 L 296 139.4576263427734 L 296 136 Z M 296 136" fill="#008fcf" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-109.15, -124.75)" d="M 112 128 L 114.8474578857422 128 L 114.8474578857422 128.4067840576172 L 112 128.4067840576172 L 112 128 Z M 112 128" fill="#008fcf" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-109.15, -163.73)" d="M 112 168 L 116.6779632568359 168 L 116.6779632568359 168.4067840576172 L 112 168.4067840576172 L 112 168 Z M 112 168" fill="#008fcf" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-226.1, -148.14)" d="M 232 152 L 232.4067840576172 152 L 232.4067840576172 155.0508422851562 L 232 155.0508422851562 L 232 152 Z M 232 152" fill="#008fcf" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-163.73, -155.93)" d="M 168 160 L 168.4067840576172 160 L 168.4067840576172 161.2203369140625 L 168 161.2203369140625 L 168 160 Z M 168 160" fill="#008fcf" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-101.36, -192.32)" d="M 107.5411529541016 199.03076171875 L 106.7276000976562 198.2257385253906 L 106.033805847168 198.2257385253906 L 106.033805847168 197.3359069824219 L 103.9999084472656 197.3359069824219 L 103.9999084472656 204.3188934326172 L 109.2880401611328 204.3188934326172 L 109.2880401611328 199.03076171875 L 107.5411529541016 199.03076171875 Z M 107.5411529541016 199.03076171875" fill="#e6e6e6" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_scrda =
    '<svg viewBox="0.0 0.0 12.2 12.0" ><path transform="translate(-7.8, -272.88)" d="M 8 280 L 9.627119064331055 280 L 9.627119064331055 280.8135375976562 L 9.220338821411133 281.2203369140625 L 8.406780242919922 281.2203369140625 L 8 280.8135375976562 L 8 280 Z M 8 280" fill="#ffcd34" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-7.8, -241.69)" d="M 8 248.8135528564453 L 8.610169410705566 248 L 9.016949653625488 248 L 9.627119064331055 248.8135528564453" fill="#b3b3b3" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-335.25, -62.37)" d="M 345.0169677734375 64 L 344.2033996582031 64 C 344.091064453125 64 344 64.09107208251953 344 64.20339202880859 L 344 74.16949462890625 C 344 74.28181457519531 344.091064453125 74.37287902832031 344.2033996582031 74.37287902832031 L 345.0169677734375 74.37287902832031 C 345.1292724609375 74.37287902832031 345.2203369140625 74.28181457519531 345.2203369140625 74.16949462890625 L 345.2203369140625 64.20339202880859 C 345.2203369140625 64.09107208251953 345.1292724609375 64 345.0169677734375 64 Z M 344.447509765625 72.74576568603516 L 344.8135681152344 72.19657135009766 L 344.8135681152344 73.29495239257812 L 344.447509765625 72.74576568603516 Z M 344.7728576660156 66.64406585693359 L 344.4067993164062 67.19326019287109 L 344.4067993164062 66.09487915039062 L 344.7728576660156 66.64406585693359 Z M 344.447509765625 65.42372894287109 L 344.8135681152344 64.87453460693359 L 344.8135681152344 65.97292327880859 L 344.447509765625 65.42372894287109 Z M 344.4067993164062 68.53554534912109 L 344.7728576660156 69.08473968505859 L 344.4067993164062 69.63392639160156 L 344.4067993164062 68.53554534912109 Z M 344.4067993164062 70.97621917724609 L 344.7728576660156 71.52541351318359 L 344.4067993164062 72.07460784912109 L 344.4067993164062 70.97621917724609 Z M 344.447509765625 70.30507659912109 L 344.8135681152344 69.75588226318359 L 344.8135681152344 70.85426330566406 L 344.447509765625 70.30507659912109 Z M 344.447509765625 67.86439514160156 L 344.8135681152344 67.31520843505859 L 344.8135681152344 68.41358947753906 L 344.447509765625 67.86439514160156 Z M 344.6365966796875 64.40676879882812 L 344.4067993164062 64.75257110595703 L 344.4067993164062 64.40676879882812 L 344.6365966796875 64.40676879882812 Z M 344.4067993164062 73.41688537597656 L 344.7728576660156 73.96607971191406 L 344.4067993164062 73.96607971191406 L 344.4067993164062 73.41688537597656 Z M 344.4067993164062 73.41688537597656" fill="#ffcd34" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.0, -15.59)" d="M 8.338982582092285 16 L 0.2033898234367371 16 C 0.09106855094432831 16 0 16.09106826782227 0 16.20339012145996 L 0 17.01694869995117 C 0 17.12927055358887 0.09106855839490891 17.22033882141113 0.2033898234367371 17.22033882141113 L 8.338982582092285 17.22033882141113 C 8.45130443572998 17.22033882141113 8.542372703552246 17.12927055358887 8.542372703552246 17.01694869995117 L 8.542372703552246 16.20339012145996 C 8.542372703552246 16.09106826782227 8.45130443572998 16 8.338982582092285 16 Z M 3.050847291946411 16.4474983215332 L 3.600040435791016 16.81356048583984 L 2.501656770706177 16.81356048583984 L 3.050847291946411 16.4474983215332 Z M 1.830508470535278 16.7728443145752 L 1.281315207481384 16.40678215026855 L 2.379698991775513 16.40678215026855 L 1.830508470535278 16.7728443145752 Z M 3.721993207931519 16.40678215026855 L 4.820376873016357 16.40678215026855 L 4.271183967590332 16.7728443145752 L 3.721993207931519 16.40678215026855 Z M 5.491525173187256 16.44750022888184 L 6.040718078613281 16.81356048583984 L 4.942334651947021 16.81356048583984 L 5.491525173187256 16.44750022888184 Z M 6.162671089172363 16.40678215026855 L 7.261054992675781 16.40678215026855 L 6.711861610412598 16.7728443145752 L 6.162671089172363 16.40678215026855 Z M 0.4067901074886322 16.40678215026855 L 0.5492026805877686 16.40678215026855 L 1.159372210502625 16.81356239318848 L 0.4067891538143158 16.81356239318848 L 0.4067901074886322 16.40678215026855 Z M 8.135603904724121 16.81356239318848 L 7.383020877838135 16.81356239318848 L 7.993190288543701 16.40678215026855 L 8.135602951049805 16.40678215026855 L 8.135603904724121 16.81356239318848 Z M 8.135603904724121 16.81356239318848" fill="#ffcd34" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-389.83, -15.59)" d="M 401.8305053710938 16 L 400.2033996582031 16 C 400.091064453125 16 400 16.09106826782227 400 16.20339012145996 L 400 17.01694869995117 C 400 17.12927055358887 400.091064453125 17.22033882141113 400.2033996582031 17.22033882141113 L 401.8305053710938 17.22033882141113 C 401.9428405761719 17.22033882141113 402.0339050292969 17.12927055358887 402.0339050292969 17.01694869995117 L 402.0339050292969 16.20339012145996 C 402.0339050292969 16.09106826782227 401.9428405761719 16 401.8305053710938 16 Z M 400.9559631347656 16.40678024291992 L 400.4067687988281 16.77284049987793 L 400.4067687988281 16.40678024291992 L 400.9559631347656 16.40678024291992 Z M 401.0779113769531 16.81356048583984 L 401.6271057128906 16.4474983215332 L 401.6271057128906 16.81356048583984 L 401.0779113769531 16.81356048583984 Z M 401.0779113769531 16.81356048583984" fill="#ffcd34" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-15.59, -54.58)" d="M 16.61017036437988 61.08474731445312 C 16.27320671081543 61.08474731445312 16 60.81153869628906 16 60.47457504272461 L 16.40678024291992 60.47457504272461 C 16.40678024291992 60.58689880371094 16.49784851074219 60.6779670715332 16.61017036437988 60.6779670715332 C 16.72249031066895 60.6779670715332 16.81356048583984 60.58689880371094 16.81356048583984 60.47457504272461 C 16.81356048583984 60.36225509643555 16.72249031066895 60.27118682861328 16.61017036437988 60.27118682861328 C 16.49784851074219 60.27118682861328 16.40678024291992 60.18011856079102 16.40678024291992 60.06779479980469 L 16.40678024291992 56 L 16.81356048583984 56 L 16.81356048583984 59.89916229248047 C 17.09391403198242 59.99807357788086 17.26214790344238 60.28468704223633 17.21189880371094 60.57775497436523 C 17.16164779663086 60.87072372436523 16.90750885009766 61.08493804931641 16.61017036437988 61.08473968505859 Z M 16.61017036437988 61.08474731445312" fill="#008fcf" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-319.66, 0.0)" d="M 328 0 L 330.0339050292969 0 L 330.0339050292969 1.830508470535278 L 328 1.830508470535278 L 328 0 Z M 328 0" fill="#226c8a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-319.66, 0.0)" d="M 328 0 L 329.2203369140625 0 L 329.2203369140625 1.220338940620422 L 328 1.220338940620422 L 328 0 Z M 328 0" fill="#00c9dd" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.0, -444.41)" d="M 0 456 L 12.20338916778564 456 L 12.20338916778564 456.4067687988281 L 0 456.4067687988281 L 0 456 Z M 0 456" fill="#603813" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-319.66, 0.0)" d="M 328 1.220338940620422 C 328.6158142089844 1.097192764282227 329.0971984863281 0.6158313155174255 329.2203369140625 0 L 329.2203369140625 1.220338940620422 L 328 1.220338940620422 Z M 328 1.220338940620422" fill="#81d0d3" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_v141r =
    '<svg viewBox="23.0 4.0 1.3 4.0" ><path transform="translate(23.0, 4.0)" d="M 0 0 L 0 4 C 0.8047311305999756 3.661223411560059 1.328037977218628 2.873133182525635 1.328037977218628 2 C 1.328037977218628 1.126866698265076 0.8047311305999756 0.3387765288352966 0 0" fill="#000000" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ltg2cz =
    '<svg viewBox="315.7 17.3 15.3 11.0" ><path transform="translate(315.69, 17.33)" d="M 7.41510009765625 10.87290000915527 L 5.417099952697754 8.856900215148926 C 5.355900287628174 8.796600341796875 5.321700096130371 8.712900161743164 5.323500156402588 8.626500129699707 C 5.325300216674805 8.54010009765625 5.363100051879883 8.458200454711914 5.427000045776367 8.400600433349609 C 6.702300071716309 7.321500301361084 8.570700645446777 7.321500301361084 9.846000671386719 8.400600433349609 C 9.910799980163574 8.458200454711914 9.947700500488281 8.54010009765625 9.94950008392334 8.626500129699707 C 9.951300621032715 8.712900161743164 9.917099952697754 8.796600341796875 9.855899810791016 8.856900215148926 L 7.857900142669678 10.87290000915527 C 7.799400329589844 10.93230056762695 7.720200061798096 10.96560001373291 7.636500358581543 10.96560001373291 C 7.553699970245361 10.96560001373291 7.473600387573242 10.93230056762695 7.41510009765625 10.87290000915527 Z M 10.93050003051758 7.343100070953369 C 10.02780055999756 6.525900363922119 8.85420036315918 6.073200225830078 7.636500358581543 6.073200225830078 C 6.419700145721436 6.073200225830078 5.247000217437744 6.525900363922119 4.345200061798096 7.343100070953369 C 4.222800254821777 7.458300113677979 4.030200004577637 7.456500053405762 3.911400079727173 7.336800098419189 L 2.757600069046021 6.170400142669678 C 2.696400165557861 6.109200000762939 2.662199974060059 6.026400089263916 2.663100004196167 5.940000057220459 C 2.664000034332275 5.853600025177002 2.699100017547607 5.771699905395508 2.761199951171875 5.711400032043457 C 5.509799957275391 3.154500007629395 9.765900611877441 3.154500007629395 12.51360034942627 5.711400032043457 C 12.5757007598877 5.771699905395508 12.6117000579834 5.853600025177002 12.61260032653809 5.940000057220459 C 12.61350059509277 6.026400089263916 12.57929992675781 6.109200000762939 12.51900005340576 6.170400142669678 L 11.36430072784424 7.336800098419189 C 11.30341243743896 7.397687435150146 11.22391605377197 7.428067684173584 11.14436626434326 7.428062438964844 C 11.06752777099609 7.428057193756104 10.99063968658447 7.399701595306396 10.93050003051758 7.343100070953369 Z M 13.59000015258789 4.655700206756592 C 11.98350048065186 3.129300117492676 9.852300643920898 2.276999950408936 7.636500358581543 2.276999950408936 C 5.420700073242188 2.276999950408936 3.289499998092651 3.128400087356567 1.683000087738037 4.655700206756592 C 1.562399983406067 4.773600101470947 1.368900060653687 4.77180004119873 1.249199986457825 4.652100086212158 L 0.09360000491142273 3.485700130462646 C 0.0333000011742115 3.424499988555908 -0.0009000000427477062 3.342600107192993 0 3.257100105285645 C 0.0009000000427477062 3.171600103378296 0.03510000184178352 3.089699983596802 0.09630000591278076 3.029400110244751 C 4.310999870300293 -1.00980007648468 10.96110057830811 -1.00980007648468 15.17670059204102 3.029400110244751 C 15.23700046539307 3.089699983596802 15.2721004486084 3.171600103378296 15.2721004486084 3.257100105285645 C 15.27300071716309 3.342600107192993 15.23880004882812 3.424499988555908 15.17850017547607 3.485700130462646 L 14.02290058135986 4.652100086212158 C 13.96281909942627 4.712636947631836 13.88365459442139 4.743017196655273 13.80445384979248 4.743010520935059 C 13.72704887390137 4.743004322052002 13.64960861206055 4.713973522186279 13.59000015258789 4.655700206756592 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_renyrk =
    '<svg viewBox="293.7 17.7 17.0 10.7" ><path transform="translate(293.67, 17.67)" d="M 15.00030040740967 10.6668004989624 C 14.44770050048828 10.6668004989624 14.00040054321289 10.21860027313232 14.00040054321289 9.666900634765625 L 14.00040054321289 0.9999000430107117 C 14.00040054321289 0.4473000168800354 14.44770050048828 0 15.00030040740967 0 L 16.00020027160645 0 C 16.55190086364746 0 17.00010108947754 0.4473000168800354 17.00010108947754 0.9999000430107117 L 17.00010108947754 9.666900634765625 C 17.00010108947754 10.21860027313232 16.55190086364746 10.6668004989624 16.00020027160645 10.6668004989624 L 15.00030040740967 10.6668004989624 Z M 10.33290004730225 10.6668004989624 C 9.781200408935547 10.6668004989624 9.333000183105469 10.21860027313232 9.333000183105469 9.666900634765625 L 9.333000183105469 3.333600044250488 C 9.333000183105469 2.781000137329102 9.781200408935547 2.333699941635132 10.33290004730225 2.333699941635132 L 11.33370018005371 2.333699941635132 C 11.88539981842041 2.333699941635132 12.33360004425049 2.781000137329102 12.33360004425049 3.333600044250488 L 12.33360004425049 9.666900634765625 C 12.33360004425049 10.21860027313232 11.88539981842041 10.6668004989624 11.33370018005371 10.6668004989624 L 10.33290004730225 10.6668004989624 Z M 5.666399955749512 10.6668004989624 C 5.114700317382812 10.6668004989624 4.666500091552734 10.21860027313232 4.666500091552734 9.666900634765625 L 4.666500091552734 5.666399955749512 C 4.666500091552734 5.114700317382812 5.114700317382812 4.666500091552734 5.666399955749512 4.666500091552734 L 6.666300296783447 4.666500091552734 C 7.218900203704834 4.666500091552734 7.667099952697754 5.114700317382812 7.667099952697754 5.666399955749512 L 7.667099952697754 9.666900634765625 C 7.667099952697754 10.21860027313232 7.218900203704834 10.6668004989624 6.666300296783447 10.6668004989624 L 5.666399955749512 10.6668004989624 Z M 0.9999000430107117 10.6668004989624 C 0.4473000168800354 10.6668004989624 0 10.21860027313232 0 9.666900634765625 L 0 7.667099952697754 C 0 7.114500045776367 0.4473000168800354 6.666300296783447 0.9999000430107117 6.666300296783447 L 1.999800086021423 6.666300296783447 C 2.5524001121521 6.666300296783447 2.99970006942749 7.114500045776367 2.99970006942749 7.667099952697754 L 2.99970006942749 9.666900634765625 C 2.99970006942749 10.21860027313232 2.5524001121521 10.6668004989624 1.999800086021423 10.6668004989624 L 0.9999000430107117 10.6668004989624 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_uk7in =
    '<svg viewBox="4.5 10.1 27.0 2.3" ><path  d="M 30.375 12.375 L 5.625 12.375 C 5.006249904632568 12.375 4.5 11.86874961853027 4.5 11.25 L 4.5 11.25 C 4.5 10.63125038146973 5.006249904632568 10.125 5.625 10.125 L 30.375 10.125 C 30.99374961853027 10.125 31.5 10.63125038146973 31.5 11.25 L 31.5 11.25 C 31.5 11.86874961853027 30.99374961853027 12.375 30.375 12.375 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_wkrkwh =
    '<svg viewBox="4.5 16.9 27.0 2.3" ><path  d="M 30.375 19.125 L 5.625 19.125 C 5.006249904632568 19.125 4.5 18.61874961853027 4.5 18 L 4.5 18 C 4.5 17.38125038146973 5.006249904632568 16.875 5.625 16.875 L 30.375 16.875 C 30.99374961853027 16.875 31.5 17.38125038146973 31.5 18 L 31.5 18 C 31.5 18.61874961853027 30.99374961853027 19.125 30.375 19.125 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bueeyd =
    '<svg viewBox="4.5 23.6 27.0 2.3" ><path  d="M 30.375 25.875 L 5.625 25.875 C 5.006249904632568 25.875 4.5 25.36874961853027 4.5 24.75 L 4.5 24.75 C 4.5 24.13125038146973 5.006249904632568 23.625 5.625 23.625 L 30.375 23.625 C 30.99374961853027 23.625 31.5 24.13125038146973 31.5 24.75 L 31.5 24.75 C 31.5 25.36874961853027 30.99374961853027 25.875 30.375 25.875 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eib3lo =
    '<svg viewBox="0.0 0.0 7.3 7.3" ><path transform="translate(-136.0, -136.0)" d="M 139.6458435058594 136 C 137.6359405517578 136 136 137.6354217529297 136 139.6458435058594 C 136 141.65625 137.6359405517578 143.2916717529297 139.6458435058594 143.2916717529297 C 141.6557312011719 143.2916717529297 143.2916717529297 141.65625 143.2916717529297 139.6458435058594 C 143.2916717529297 137.6354217529297 141.6557312011719 136 139.6458435058594 136 Z M 139.6458435058594 141.2083282470703 C 138.7843780517578 141.2083282470703 138.0833435058594 140.5072937011719 138.0833435058594 139.6458435058594 C 138.0833435058594 138.7843780517578 138.7843780517578 138.0833435058594 139.6458435058594 138.0833435058594 C 140.5072937011719 138.0833435058594 141.2083282470703 138.7843780517578 141.2083282470703 139.6458435058594 C 141.2083282470703 140.5072937011719 140.5072937011719 141.2083282470703 139.6458435058594 141.2083282470703 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_i1dpgr =
    '<svg viewBox="0.0 0.0 25.0 25.0" ><path  d="M 23.95833206176758 11.45833301544189 L 21.81354141235352 11.45833301544189 C 21.33124923706055 7.120312213897705 17.87968635559082 3.668750047683716 13.54166603088379 3.186458110809326 L 13.54166603088379 1.041666626930237 C 13.54166603088379 0.4666666686534882 13.07499980926514 0 12.5 0 C 11.92499923706055 0 11.45833301544189 0.4666666686534882 11.45833301544189 1.041666626930237 L 11.45833301544189 3.186458110809326 C 7.120312213897705 3.668750047683716 3.668750047683716 7.120312213897705 3.186458110809326 11.45833301544189 L 1.041666626930237 11.45833301544189 C 0.4666666686534882 11.45833301544189 0 11.92499923706055 0 12.5 C 0 13.07499980926514 0.4666666686534882 13.54166603088379 1.041666626930237 13.54166603088379 L 3.186458110809326 13.54166603088379 C 3.668750047683716 17.87968635559082 7.120312213897705 21.33124923706055 11.45833301544189 21.81354141235352 L 11.45833301544189 23.95833206176758 C 11.45833301544189 24.53333282470703 11.92499923706055 25 12.5 25 C 13.07499980926514 25 13.54166603088379 24.53333282470703 13.54166603088379 23.95833206176758 L 13.54166603088379 21.81354141235352 C 17.87968826293945 21.33124923706055 21.33124923706055 17.87968635559082 21.81354141235352 13.54166603088379 L 23.95833206176758 13.54166603088379 C 24.53333282470703 13.54166603088379 25 13.07499980926514 25 12.5 C 25 11.92499923706055 24.53333282470703 11.45833301544189 23.95833206176758 11.45833301544189 Z M 12.5 19.79166603088379 C 8.479166984558105 19.79166603088379 5.208333015441895 16.52083206176758 5.208333015441895 12.5 C 5.208333015441895 8.479166984558105 8.479166984558105 5.208333015441895 12.5 5.208333015441895 C 16.52083206176758 5.208333015441895 19.79166603088379 8.479166984558105 19.79166603088379 12.5 C 19.79166603088379 16.52083206176758 16.52083206176758 19.79166603088379 12.5 19.79166603088379 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_j6wcet =
    '<svg viewBox="255.5 103.5 1.0 34.0" ><path transform="translate(255.5, 103.5)" d="M 0 0 L 0 34" fill="none" stroke="#c8ccd5" stroke-width="0.699999988079071" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_c4sj =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(6.85, 5.58)" d="M 2.152499914169312 5.055000305175781 C 0.55205237865448 5.055000305175781 -0.7500001192092896 3.752947568893433 -0.7500001192092896 2.152500152587891 C -0.7500001192092896 0.5520526170730591 0.55205237865448 -0.7499998807907104 2.152499914169312 -0.7499998807907104 C 3.752947568893433 -0.7499998807907104 5.054999828338623 0.5520526170730591 5.054999828338623 2.152500152587891 C 5.054999828338623 3.752947568893433 3.752947568893433 5.055000305175781 2.152499914169312 5.055000305175781 Z M 2.152499914169312 0.3750001490116119 C 1.172384858131409 0.3750001490116119 0.3749998509883881 1.172385096549988 0.3749998509883881 2.152500152587891 C 0.3749998509883881 3.132615089416504 1.172384858131409 3.930000305175781 2.152499914169312 3.930000305175781 C 3.132614850997925 3.930000305175781 3.929999828338623 3.132615089416504 3.929999828338623 2.152500152587891 C 3.929999828338623 1.172385096549988 3.132614850997925 0.3750001490116119 2.152499914169312 0.3750001490116119 Z" fill="#132144" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(2.72, 1.69)" d="M 6.277542114257812 -0.7499980926513672 C 7.818814754486084 -0.7499980926513672 9.323351860046387 -0.2796645164489746 10.51400661468506 0.5743680000305176 C 11.83883666992188 1.524632453918457 12.7376070022583 2.903995275497437 13.11316204071045 4.563332080841064 C 13.52897644042969 6.400157451629639 13.28246593475342 8.272720336914062 12.38047122955322 10.12896919250488 C 11.71397686004639 11.50057792663574 10.70081615447998 12.84443473815918 9.369146347045898 14.12322235107422 C 8.535671234130859 14.92767906188965 7.437732219696045 15.37125205993652 6.278599262237549 15.37125205993652 C 5.119992256164551 15.37125205993652 4.02040958404541 14.92801666259766 3.182404279708862 14.12319946289062 C 1.853629469871521 12.84256744384766 0.8428465127944946 11.49751663208008 0.1774319112300873 10.12472343444824 C -0.7236558198928833 8.265737533569336 -0.9697753190994263 6.392087459564209 -0.5540801286697388 4.555809497833252 C -0.1769429743289948 2.897942066192627 0.7219690084457397 1.520552635192871 2.045606851577759 0.571967601776123 C 3.235151529312134 -0.280512809753418 4.738084316253662 -0.7499980926513672 6.277542114257812 -0.7499980926513672 Z M 6.278599262237549 14.24625205993652 C 7.144729614257812 14.24625205993652 7.965214252471924 13.91473770141602 8.588899612426758 13.31277275085449 C 10.59483337402344 11.38649559020996 12.81667900085449 8.348964691162109 12.01591968536377 4.811694622039795 C 11.27475357055664 1.536947727203369 8.46147346496582 0.3750019073486328 6.277542114257812 0.3750019073486328 C 4.097029209136963 0.3750019073486328 1.286809325218201 1.535139560699463 0.543026328086853 4.80477237701416 C -0.2575151026248932 8.341081619262695 1.960609555244446 11.38323974609375 3.962382078170776 13.31248664855957 C 4.589104175567627 13.91439247131348 5.41194486618042 14.24625205993652 6.278599262237549 14.24625205993652 Z" fill="#132144" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 18.0, 18.0)" d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ivigmg =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(1.69, 1.69)" d="M 7.3125 -0.75 C 11.75817775726318 -0.75 15.375 2.866822242736816 15.375 7.3125 C 15.375 11.75817775726318 11.75817775726318 15.375 7.3125 15.375 C 2.866822242736816 15.375 -0.75 11.75817775726318 -0.75 7.3125 C -0.75 2.866822242736816 2.866822242736816 -0.75 7.3125 -0.75 Z M 7.3125 14.25 C 11.13785171508789 14.25 14.25 11.13785171508789 14.25 7.3125 C 14.25 3.487147808074951 11.13785171508789 0.375 7.3125 0.375 C 3.487147808074951 0.375 0.375 3.487147808074951 0.375 7.3125 C 0.375 11.13785171508789 3.487147808074951 14.25 7.3125 14.25 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(8.91, 5.82)" d="M 2.871969699859619 6.127584457397461 C 2.773899555206299 6.127584457397461 2.674578666687012 6.101931571960449 2.584244966506958 6.048022270202637 L 0.2592449486255646 4.6605224609375 C -0.3154800534248352 4.319954872131348 -0.7500001192092896 3.557332515716553 -0.7500001192092896 2.887499809265137 L -0.7500001192092896 -0.1874999552965164 C -0.7500001192092896 -0.4981574416160583 -0.4981575608253479 -0.7499999403953552 -0.1875000596046448 -0.7499999403953552 C 0.1231574416160583 -0.7499999403953552 0.3749999105930328 -0.4981574416160583 0.3749999105930328 -0.1874999552965164 L 0.3749999105930328 2.887499809265137 C 0.3749999105930328 3.16194748878479 0.5981924533843994 3.553695201873779 0.834262490272522 3.69358491897583 L 3.160754680633545 5.081977367401123 C 3.4275221824646 5.241172790527344 3.514724731445312 5.586487293243408 3.355522632598877 5.853255271911621 C 3.250234603881836 6.029688835144043 3.063514709472656 6.127584457397461 2.871969699859619 6.127584457397461 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path  d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_t7ogaf =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(6.19, 1.69)" d="M -0.1875 2.625 C -0.4981575012207031 2.625 -0.75 2.373157501220703 -0.75 2.0625 L -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 C 0.1231575012207031 -0.75 0.375 -0.4981575012207031 0.375 -0.1875 L 0.375 2.0625 C 0.375 2.373157501220703 0.1231575012207031 2.625 -0.1875 2.625 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(12.19, 1.69)" d="M -0.1875 2.625 C -0.4981575012207031 2.625 -0.75 2.373157501220703 -0.75 2.0625 L -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 C 0.1231575012207031 -0.75 0.375 -0.4981575012207031 0.375 -0.1875 L 0.375 2.0625 C 0.375 2.373157501220703 0.1231575012207031 2.625 -0.1875 2.625 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(2.81, 7.0)" d="M 12.56250095367432 0.375 L -0.1875 0.375 C -0.4981575012207031 0.375 -0.75 0.1231575012207031 -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 L 12.56250095367432 -0.75 C 12.8731575012207 -0.75 13.12500095367432 -0.4981575012207031 13.12500095367432 -0.1875 C 13.12500095367432 0.1231575012207031 12.8731575012207 0.375 12.56250095367432 0.375 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(2.44, 2.81)" d="M 3.562500953674316 -0.75 L 9.5625 -0.75 C 10.98719215393066 -0.75 12.08790874481201 -0.3425626754760742 12.83407592773438 0.4609947204589844 C 13.52477931976318 1.204836845397949 13.875 2.248334884643555 13.875 3.562500953674316 L 13.875 9.9375 C 13.875 11.25166511535645 13.52477931976318 12.29516410827637 12.83407592773438 13.03900527954102 C 12.08790874481201 13.84256362915039 10.98719215393066 14.25000095367432 9.5625 14.25000095367432 L 3.562500953674316 14.25000095367432 C 2.137807846069336 14.25000095367432 1.037092208862305 13.84256362915039 0.290924072265625 13.03900527954102 C -0.3997793197631836 12.29516410827637 -0.75 11.25166511535645 -0.75 9.9375 L -0.75 3.562500953674316 C -0.75 2.248334884643555 -0.3997793197631836 1.204836845397949 0.290924072265625 0.4609947204589844 C 1.037092208862305 -0.3425626754760742 2.137807846069336 -0.75 3.562500953674316 -0.75 Z M 9.5625 13.12500095367432 C 10.66167068481445 13.12500095367432 11.48502063751221 12.83851528167725 12.00967502593994 12.2734956741333 C 12.5009183883667 11.74446773529053 12.75 10.95852756500244 12.75 9.9375 L 12.75 3.562500953674316 C 12.75 2.541472434997559 12.5009183883667 1.755532264709473 12.00967502593994 1.226505279541016 C 11.48502063751221 0.6614856719970703 10.66167068481445 0.375 9.5625 0.375 L 3.562500953674316 0.375 C 2.463330268859863 0.375 1.639980316162109 0.6614856719970703 1.115324974060059 1.226505279541016 C 0.6240816116333008 1.755532264709473 0.375 2.541472434997559 0.375 3.562500953674316 L 0.375 9.9375 C 0.375 10.95852756500244 0.6240816116333008 11.74446773529053 1.115324974060059 12.2734956741333 C 1.639980316162109 12.83851528167725 2.463330268859863 13.12500095367432 3.562500953674316 13.12500095367432 L 9.5625 13.12500095367432 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(0.0, 0.0)" d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(11.53, 10.03)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(11.53, 12.28)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(8.75, 10.03)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(8.75, 12.28)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(5.98, 10.03)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(5.98, 12.28)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_lodn6 =
    '<svg viewBox="8.9 14.0 15.7 13.8" ><path transform="translate(0.0, 0.0)" d="M 16.53636360168457 27.67778396606445 L 10.23385524749756 21.43274688720703 C 9.965662956237793 21.18370819091797 9.754940986633301 20.8963623046875 9.563375473022461 20.5898551940918 C 8.528921127319336 18.88492202758789 8.797113418579102 16.70107460021973 10.23385524749756 15.28348827362061 C 11.05758762359619 14.45975685119629 12.16866779327393 14 13.33721733093262 14 C 15.17624759674072 14 16.32564163208008 15.07276725769043 16.8045539855957 15.68577671051025 C 17.28346824645996 15.07276725769043 18.43286323547363 14 20.27189254760742 14 C 21.4404411315918 14 22.5515251159668 14.45975685119629 23.3752555847168 15.28348922729492 C 24.7928409576416 16.70107460021973 25.0801887512207 18.88492202758789 24.04573631286621 20.58985710144043 C 23.85416984558105 20.8963623046875 23.64344787597656 21.18370819091797 23.3752555847168 21.43274688720703 L 17.07274627685547 27.67778396606445 C 16.91949462890625 27.8310375213623 16.68961524963379 27.8310375213623 16.53636360168457 27.67778396606445 Z M 13.33721733093262 14.76626205444336 C 12.36023330688477 14.76626205444336 11.45987415313721 15.14939308166504 10.77023887634277 15.81987285614014 C 9.601688385009766 16.98842239379883 9.371809959411621 18.78913879394531 10.21469879150391 20.18756866455078 C 10.36795043945312 20.43660354614258 10.55951690673828 20.68563842773438 10.77023887634277 20.8963623046875 L 16.8045539855957 26.87320709228516 L 22.83887100219727 20.8963623046875 C 23.04959106445312 20.68564033508301 23.24115943908691 20.45576095581055 23.39441299438477 20.18756866455078 C 24.23730087280273 18.76998138427734 24.02657890319824 16.96926498413086 22.83887100219727 15.81987285614014 C 22.14923667907715 15.14939308166504 21.2297191619873 14.76626205444336 20.27189254760742 14.76626205444336 C 18.89262008666992 14.76626205444336 17.74322509765625 15.51336860656738 17.13021469116211 16.54782104492188 C 16.97696304321289 16.7968578338623 16.61298942565918 16.7968578338623 16.45973587036133 16.54782104492188 C 15.86588382720947 15.51336860656738 14.71648979187012 14.76626205444336 13.33721733093262 14.76626205444336 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_w5a4i =
    '<svg viewBox="0.5 4.6 42.9 38.0" ><path transform="translate(0.0, 0.0)" d="M 25.48095321655273 35.14572143554688 C 25.17852210998535 34.66182708740234 24.57365608215332 34.35939407348633 24.02927589416504 34.48036956787109 C 23.36392402648926 34.60134124755859 22.69857025146484 34.66182708740234 21.97273063659668 34.66182708740234 C 15.74261474609375 34.66182708740234 10.72222805023193 29.45998001098633 11.02466106414795 23.16937637329102 C 11.2666072845459 17.54412651062012 15.86358642578125 13.00763320922852 21.42835235595703 12.7052001953125 C 27.71895790100098 12.40276908874512 32.92080307006836 17.42315292358398 32.92080307006836 23.65326881408691 C 32.92080307006836 26.37516593933105 31.95301818847656 28.79462814331055 30.31987953186035 30.73019790649414 C 29.95696067810059 31.15360450744629 29.8964729309082 31.81895637512207 30.19890594482422 32.30284881591797 L 33.34420776367188 37.74664306640625 C 33.88858795166016 38.6539421081543 35.21929168701172 38.6539421081543 35.70318603515625 37.74664306640625 L 43.08255004882812 24.92348670959473 C 43.56644439697266 24.07667350769043 43.56644439697266 23.04840278625488 43.08255004882812 22.20159149169922 L 33.70713043212891 5.991191387176514 C 33.22323608398438 5.144379615783691 32.31593704223633 4.600000381469727 31.34815216064453 4.600000381469727 L 12.59731483459473 4.600000381469727 C 11.62952899932861 4.600000381469727 10.72223091125488 5.144379615783691 10.23833847045898 5.991191864013672 L 0.8629195094108582 22.20159339904785 C 0.3790268898010254 23.04840660095215 0.3790268898010254 24.07667541503906 0.8629195094108582 24.92348861694336 L 10.23833847045898 41.19437789916992 C 10.72223091125488 42.04119110107422 11.62952899932861 42.5855712890625 12.59731483459473 42.5855712890625 L 27.41652488708496 42.5855712890625 C 28.44479751586914 42.5855712890625 29.11014747619629 41.43632507324219 28.62625694274902 40.52902603149414 L 25.48095321655273 35.14572143554688 Z" fill="#6666ff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-10.35, -9.01)" d="M 32.20427703857422 27.39999961853027 C 29.1799488067627 27.39999961853027 26.69999885559082 29.87994956970215 26.69999885559082 32.90427780151367 C 26.69999885559082 35.92860794067383 29.1799488067627 38.40855407714844 32.20427703857422 38.40855407714844 C 35.22860717773438 38.40855407714844 37.70855712890625 35.92860794067383 37.70855712890625 32.90427780151367 C 37.6480712890625 29.87994956970215 35.22860717773438 27.39999961853027 32.20427703857422 27.39999961853027 Z" fill="#6666ff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_o1b8u =
    '<svg viewBox="12.9 10.5 14.4 13.0" ><path transform="translate(-229.08, -185.54)" d="M 256.4140014648438 199.2021636962891 C 256.4140014648438 198.343505859375 256.3334350585938 197.4840698242188 256.1739501953125 196.649658203125 C 256.1019897460938 196.2719421386719 255.7712097167969 195.9989929199219 255.3872680664062 195.9989929199219 L 242.80078125 195.9989929199219 C 242.358154296875 195.9989929199219 242 196.3571472167969 242 196.7997741699219 L 242 201.6044464111328 C 242 202.0470581054688 242.358154296875 202.4052276611328 242.80078125 202.4052276611328 L 249.2586364746094 202.4052276611328 C 248.8562774658203 203.2197875976562 248.3017578125 203.9265441894531 247.6506195068359 204.5211486816406 L 252.1766204833984 209.0471496582031 C 254.7808074951172 206.5660705566406 256.4140014648438 203.0746765136719 256.4140014648438 199.2021636962891 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_nfkk7y =
    '<svg viewBox="2.4 0.0 20.3 10.7" ><path transform="translate(-42.28, 0.0)" d="M 55.94530487060547 6.406234741210938 C 57.51638031005859 6.406234741210938 59.01079559326172 6.905172824859619 60.26667785644531 7.849825382232666 C 60.58416748046875 8.088352203369141 61.03227996826172 8.059416770935059 61.31377410888672 7.775513648986816 L 64.73118591308594 4.358108997344971 C 64.88995361328125 4.199341297149658 64.97515869140625 3.98115611076355 64.96501159667969 3.756724119186401 C 64.95487213134766 3.532292604446411 64.85162353515625 3.322702169418335 64.67955780029297 3.178028106689453 C 62.23424530029297 1.128461480140686 59.13198089599609 3.814697265625e-06 55.94530487060547 3.814697265625e-06 C 51.25546264648438 3.814697265625e-06 47.11228942871094 2.383868932723999 44.66302490234375 6.003283500671387 L 49.36349105834961 10.70374870300293 C 50.48490142822266 8.17777156829834 53.00799560546875 6.406234741210938 55.94530487060547 6.406234741210938 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_y7twh8 =
    '<svg viewBox="2.4 16.6 19.4 10.7" ><path transform="translate(-42.28, -294.87)" d="M 55.94526672363281 322.2037353515625 C 59.00226593017578 322.2037353515625 61.81726837158203 321.1787414550781 64.09196472167969 319.4710998535156 L 59.48102569580078 314.8601684570312 C 58.42709350585938 315.45361328125 57.22251129150391 315.7975158691406 55.94526672363281 315.7975158691406 C 53.00795745849609 315.7975158691406 50.48486328125 314.0259704589844 49.36344909667969 311.5 L 44.66298675537109 316.2004699707031 C 47.11224746704102 319.8198547363281 51.25542449951172 322.2037353515625 55.94526672363281 322.2037353515625 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_snf98z =
    '<svg viewBox="0.0 7.5 6.5 12.4" ><path transform="translate(0.0, -132.78)" d="M 6.522822380065918 147.6026000976562 C 6.461482524871826 147.2247009277344 6.406229019165039 146.8441162109375 6.406229019165039 146.44921875 C 6.406229019165039 146.0543212890625 6.461483478546143 145.6737365722656 6.522822380065918 145.2958374023438 L 1.49798858165741 140.27099609375 C 0.5473037362098694 142.1277465820312 -1.9073486328125e-06 144.2239074707031 -1.9073486328125e-06 146.44921875 C -1.9073486328125e-06 148.6745300292969 0.5473037958145142 150.7706909179688 1.498041987419128 152.6273803710938 L 6.522822380065918 147.6026000976562 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_pc443t =
    '<svg viewBox="20.0 304.0 127.0 113.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="0" stdDeviation="8"/></filter></defs><path transform="translate(20.0, 304.0)" d="M 5 0 L 122 0 C 124.7614212036133 0 127 2.238576173782349 127 5 L 127 108 C 127 110.7614212036133 124.7614212036133 113 122 113 L 5 113 C 2.238576173782349 113 0 110.7614212036133 0 108 L 0 5 C 0 2.238576173782349 2.238576173782349 0 5 0 Z" fill="#132144" stroke="none" stroke-width="0.05000000074505806" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_lpx38t =
    '<svg viewBox="69.0 328.3 30.0 30.0" ><path transform="translate(69.0, 328.34)" d="M 14.99476528167725 10.543532371521 C 14.98182106018066 10.54347324371338 15.00765228271484 10.543532371521 14.99476528167725 10.543532371521 Z M 15.68399810791016 10.58576202392578 L 23.66519546508789 1.40398645401001 C 24.21619415283203 0.669887363910675 25.01665496826172 0.1875947117805481 25.92536163330078 0.043738704174757 C 26.85251998901367 -0.1029874309897423 27.78137588500977 0.1199425756931305 28.54077911376953 0.6718202233314514 C 29.30018043518066 1.223580598831177 29.79928398132324 2.038101196289062 29.94607162475586 2.965257883071899 C 30.09291458129883 3.892414808273315 29.86980819702148 4.821328639984131 29.31798934936523 5.580731868743896 L 20.71737861633301 15.48793792724609 C 21.00087356567383 17.28291511535645 20.45643424987793 19.18572807312012 19.08394432067871 20.56624031066895 C 16.88902854919434 22.77386856079102 14.41237354278564 23.07821655273438 12.06293773651123 23.07821655273438 C 8.761043548583984 23.07821655273438 6.133503913879395 21.09287452697754 6.023210525512695 21.00835227966309 C 5.688523292541504 20.75174140930176 5.517605781555176 20.33505249023438 5.575652599334717 19.9173641204834 C 5.633698463439941 19.49961853027344 5.911863327026367 19.1453685760498 6.30389404296875 18.98979759216309 C 8.00843620300293 18.31333351135254 8.418624877929688 17.13601112365723 8.937994003295898 15.6453800201416 C 9.326920509338379 14.52926635742188 9.767684936523438 13.26425743103027 10.83389377593994 12.24508285522461 C 11.98286819458008 11.14689254760742 13.46295738220215 10.54346942901611 14.99482440948486 10.54346942901611 C 15.2155294418335 10.54499340057373 15.46745300292969 10.55928516387939 15.68399810791016 10.58576011657715 Z M 18.0506534576416 11.4344310760498 C 18.41989707946777 11.66866588592529 18.76641845703125 11.9467716217041 19.08388710021973 12.2659969329834 L 19.08394432067871 12.26605606079102 C 19.32714080810547 12.51065731048584 19.54433059692383 12.77171802520752 19.73551368713379 13.04560852050781 L 27.44698143005371 4.1688232421875 C 27.61309623718262 3.922346830368042 27.67875671386719 3.626727104187012 27.63201522827148 3.331693649291992 C 27.58310699462891 3.022660732269287 27.41670036315918 2.751173496246338 27.16360473632812 2.567194700241089 C 26.91044998168945 2.383274555206299 26.60083198547363 2.308886528015137 26.29179954528809 2.357853412628174 C 25.98270606994629 2.406762361526489 25.71122169494629 2.573168992996216 25.52724075317383 2.826264619827271 L 18.0506534576416 11.4344310760498 Z M 17.42233657836914 13.91794013977051 C 16.76701927185059 13.25881385803223 15.9110279083252 12.89255619049072 15.01210403442383 12.88663959503174 C 14.07633781433105 12.88107585906982 13.16915416717529 13.25412940979004 12.45274448394775 13.93890953063965 C 11.79443836212158 14.5681037902832 11.49600696563721 15.42462062835693 11.15048313140869 16.4163818359375 C 10.74252033233643 17.5871467590332 10.26344966888428 18.96238899230957 9.039266586303711 20.04324340820312 C 9.855895042419434 20.40340805053711 10.91882610321045 20.7353458404541 12.06293773651123 20.7353458404541 C 14.25404834747314 20.7353458404541 15.91495418548584 20.43076324462891 17.42245483398438 18.91447639465332 C 18.79189872741699 17.53689002990723 18.79189872741699 15.29546642303467 17.42233657836914 13.91794109344482 Z M 28.81806564331055 10.1920919418335 C 28.17106437683105 10.1920919418335 27.64659881591797 10.71655750274658 27.64659881591797 11.36355781555176 L 27.64659881591797 19.68096542358398 C 27.70845222473145 21.23526954650879 29.9282054901123 21.23409461975098 29.98953056335449 19.68096542358398 L 29.98953056335449 11.36355972290039 C 29.98953056335449 10.7165584564209 29.46506690979004 10.19209289550781 28.81806564331055 10.19209289550781 Z M 28.81806564331055 24.13253784179688 C 28.17106437683105 24.13253784179688 27.64659881591797 24.65700531005859 27.64659881591797 25.30400276184082 C 27.64659881591797 26.59589576721191 26.59556007385254 27.64693641662598 25.30366706848145 27.64693641662598 L 4.685864448547363 27.64693641662598 C 3.39397144317627 27.64693641662598 2.342932224273682 26.59589576721191 2.342932224273682 25.30400276184082 L 2.342932224273682 4.686201572418213 C 2.342932224273682 3.394308805465698 3.39397144317627 2.34326958656311 4.685864448547363 2.34326958656311 L 19.38776397705078 2.34326958656311 C 20.94206619262695 2.281415939331055 20.94089317321777 0.0616636835038662 19.38776397705078 0.0003373859799467027 L 4.685864448547363 0.0003373859799467027 C 2.102078676223755 0.0003373859799467027 0 2.102416038513184 0 4.686201572418213 L 0 25.30400276184082 C 0 27.88778877258301 2.102078676223755 29.9898681640625 4.685864448547363 29.9898681640625 L 25.30366706848145 29.9898681640625 C 27.88745307922363 29.9898681640625 29.98953056335449 27.88778877258301 29.98953056335449 25.30400276184082 C 29.98953056335449 24.65700531005859 29.46506690979004 24.13253784179688 28.81806564331055 24.13253784179688 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xlspp =
    '<svg viewBox="20.0 304.0 127.0 113.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="0" stdDeviation="8"/></filter></defs><path transform="translate(20.0, 304.0)" d="M 5 0 L 122 0 C 124.7614212036133 0 127 2.238576173782349 127 5 L 127 108 C 127 110.7614212036133 124.7614212036133 113 122 113 L 5 113 C 2.238576173782349 113 0 110.7614212036133 0 108 L 0 5 C 0 2.238576173782349 2.238576173782349 0 5 0 Z" fill="#a3cb37" stroke="none" stroke-width="0.05000000074505806" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_pt9xjt =
    '<svg viewBox="16.6 80.0 8.5 20.2" ><path transform="translate(-106.75, 0.0)" d="M 130.3666076660156 80.07009887695312 C 129.2938842773438 79.77210998535156 128.1826019287109 80.40020751953125 127.8844833374023 81.47305297851562 L 123.4041061401367 97.60207366943359 C 123.1061248779297 98.67491912841797 123.7342147827148 99.78620910644531 124.8070678710938 100.0841903686523 C 124.9875793457031 100.1343231201172 125.1691589355469 100.1582489013672 125.3477935791016 100.1582489013672 C 126.2308502197266 100.1582489013672 127.0413360595703 99.57357788085938 127.2891845703125 98.68123626708984 L 131.7695617675781 82.55221557617188 C 132.0675354003906 81.47950744628906 131.439453125 80.36808013916016 130.3666076660156 80.07009887695312 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_tv8ew =
    '<svg viewBox="0.0 80.0 10.8 20.2" ><path transform="translate(0.0, 0.0)" d="M 10.02565956115723 80.46522521972656 C 9.169476509094238 79.75312805175781 7.898241996765137 79.87006378173828 7.186414241790771 80.72624969482422 L 0.4659900963306427 88.80796051025391 C -0.1563212424516678 89.55634307861328 -0.1552459895610809 90.64236450195312 0.4686782658100128 91.389404296875 L 7.189102649688721 99.43671417236328 C 7.587892532348633 99.91426086425781 8.160741806030273 100.1606369018555 8.737622261047363 100.1606369018555 C 9.193401336669922 100.1606369018555 9.651735305786133 100.0068740844727 10.02888584136963 99.69195556640625 C 10.88358879089355 98.97824859619141 10.99783611297607 97.70674133300781 10.2841272354126 96.8521728515625 L 4.64071798324585 90.09451293945312 L 10.28681564331055 83.30460357666016 C 10.99864196777344 82.44828796386719 10.88170623779297 81.17705535888672 10.02565956115723 80.46522521972656 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jzph6d =
    '<svg viewBox="30.9 80.0 10.8 20.2" ><path transform="translate(-199.09, 0.0)" d="M 240.2836761474609 88.77164459228516 L 233.5632476806641 80.72447204589844 C 232.8495483398438 79.86977386474609 231.5780334472656 79.75566101074219 230.7234649658203 80.46936798095703 C 229.8687591552734 81.18307495117188 229.7546539306641 82.45458221435547 230.4683532714844 83.30915069580078 L 236.1117706298828 90.06680297851562 L 230.4656677246094 96.85671997070312 C 229.7537078857422 97.71289825439453 229.8706359863281 98.98413848876953 230.7266845703125 99.69596099853516 C 231.1033020019531 100.0092697143555 231.5602874755859 100.1619567871094 232.0147247314453 100.1619567871094 C 232.5930786132812 100.1619567871094 233.1672821044922 99.91437530517578 233.5659484863281 99.43480682373047 L 240.2863616943359 91.35308837890625 C 240.9086761474609 90.60457611083984 240.9075927734375 89.5185546875 240.2836761474609 88.77164459228516 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

const String _svg_j88nqa =
    '<svg viewBox="0.0 0.0 6.0 6.0" ><path  d="M 0.4585136771202087 6.042377471923828 C 0.3411702811717987 6.042377471923828 0.223826140165329 5.997612953186035 0.1342938244342804 5.908083915710449 C -0.04476460814476013 5.729019165039062 -0.04476460814476013 5.438706398010254 0.1342938244342804 5.259648323059082 L 5.259648323059082 0.134293869137764 C 5.438706398010254 -0.04476462304592133 5.729019165039062 -0.04476462304592133 5.908083915710449 0.134293869137764 C 6.087141990661621 0.3133584260940552 6.087141990661621 0.6036704182624817 5.908083915710449 0.782728910446167 L 0.782728910446167 5.908083915710449 C 0.693199634552002 5.997612953186035 0.5758570432662964 6.042377471923828 0.4585136771202087 6.042377471923828 Z" fill="#191919" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_ew9fy0 =
    '<svg viewBox="0.0 0.0 6.0 6.0" ><path  d="M 5.583863258361816 6.042377471923828 C 5.466519355773926 6.042377471923828 5.349177360534668 5.997612953186035 5.259648323059082 5.908083915710449 L 0.1342938244342804 0.782728910446167 C -0.04476460814476013 0.6036704182624817 -0.04476460814476013 0.3133584260940552 0.1342938244342804 0.134293869137764 C 0.3133584558963776 -0.04476462304592133 0.6036704778671265 -0.04476462304592133 0.782728910446167 0.134293869137764 L 5.908083915710449 5.259648323059082 C 6.087141990661621 5.438706398010254 6.087141990661621 5.729019165039062 5.908083915710449 5.908083915710449 C 5.818551063537598 5.997612953186035 5.701206207275391 6.042377471923828 5.583863258361816 6.042377471923828 Z" fill="#191919" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_mp =
    '<svg viewBox="0.0 0.0 6.0 6.0" ><path  d="M 0.4585136771202087 6.042377471923828 C 0.3411702811717987 6.042377471923828 0.223826140165329 5.997612953186035 0.1342938244342804 5.908083915710449 C -0.04476460814476013 5.729019165039062 -0.04476460814476013 5.438706398010254 0.1342938244342804 5.259648323059082 L 5.259648323059082 0.134293869137764 C 5.438706398010254 -0.04476462304592133 5.729019165039062 -0.04476462304592133 5.908083915710449 0.134293869137764 C 6.087141990661621 0.3133584260940552 6.087141990661621 0.6036704182624817 5.908083915710449 0.782728910446167 L 0.782728910446167 5.908083915710449 C 0.693199634552002 5.997612953186035 0.5758570432662964 6.042377471923828 0.4585136771202087 6.042377471923828 Z" fill="#f3f3f3" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_t5wuf =
    '<svg viewBox="0.0 0.0 6.0 6.0" ><path  d="M 5.583863258361816 6.042377471923828 C 5.466519355773926 6.042377471923828 5.349177360534668 5.997612953186035 5.259648323059082 5.908083915710449 L 0.1342938244342804 0.782728910446167 C -0.04476460814476013 0.6036704182624817 -0.04476460814476013 0.3133584260940552 0.1342938244342804 0.134293869137764 C 0.3133584558963776 -0.04476462304592133 0.6036704778671265 -0.04476462304592133 0.782728910446167 0.134293869137764 L 5.908083915710449 5.259648323059082 C 6.087141990661621 5.438706398010254 6.087141990661621 5.729019165039062 5.908083915710449 5.908083915710449 C 5.818551063537598 5.997612953186035 5.701206207275391 6.042377471923828 5.583863258361816 6.042377471923828 Z" fill="#f3f3f3" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_oqyfdq =
    '<svg viewBox="44.5 550.5 303.0 1.0" ><path transform="translate(44.5, 550.5)" d="M 0 0 L 303 0" fill="none" stroke="#e1e1e1" stroke-width="5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_a1em43 =
    '<svg viewBox="89.5 550.5 119.0 1.0" ><path transform="translate(89.5, 550.5)" d="M 0 0 L 119 0" fill="none" stroke="#132144" stroke-width="5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_fqzmbl =
    '<svg viewBox="0.0 0.0 16.0 16.0" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 1.78, 0.0)" d="M 0 1.259885907173157 C -2.211938898710741e-08 0.5640701055526733 0.5640705823898315 -2.211940497431897e-08 1.259886980056763 0 L 18.89829444885254 5.607099069493415e-07 C 19.5941104888916 5.8282927284381e-07 20.15818214416504 0.5640707612037659 20.15818214416504 1.259886622428894 C 20.15818214416504 1.955702900886536 19.5941104888916 2.519773006439209 18.89829444885254 2.519773006439209 L 1.259886503219604 2.519772529602051 C 0.5640702247619629 2.519772529602051 2.211940497431897e-08 1.955702304840088 0 1.259885907173157 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 0.0, 14.25)" d="M 0 1.259887933731079 C 2.211937299989586e-08 0.5640727281570435 0.5640707015991211 5.828293296872289e-07 1.259886980056763 5.607099069493415e-07 L 18.89829444885254 0 C 19.5941104888916 -2.21193658944685e-08 20.15818214416504 0.5640720725059509 20.15818214416504 1.259887218475342 C 20.15818214416504 1.955702662467957 19.5941104888916 2.519773006439209 18.89829444885254 2.519773006439209 L 1.259886384010315 2.519773721694946 C 0.5640701651573181 2.519773721694946 -2.211937299989586e-08 1.955703258514404 0 1.259887933731079 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_km8qzp =
    '<svg viewBox="0.0 0.0 15.0 15.0" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 1.67, 0.0)" d="M 3.746349364064372e-08 1.178499579429626 C 1.677297767344044e-08 0.5276322364807129 0.5276327133178711 1.677299366065199e-08 1.178500533103943 3.746352561506683e-08 L 17.67749786376953 5.619525609290577e-07 C 18.32836532592773 5.82643053803622e-07 18.85599899291992 0.5276328325271606 18.85599899291992 1.178500175476074 C 18.85599899291992 1.829367995262146 18.32836532592773 2.357000112533569 17.67749786376953 2.357000112533569 L 1.178500175476074 2.356999635696411 C 0.5276322960853577 2.356999635696411 5.815402559505856e-08 1.829367399215698 3.746349364064372e-08 1.178499579429626 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 0.0, 13.33)" d="M -3.746353627320786e-08 1.178500890731812 C -1.677303629321614e-08 0.5276340842247009 0.5276327133178711 -1.677299366065199e-08 1.178500533103943 -3.746352561506683e-08 L 17.67749786376953 -5.619525609290577e-07 C 18.32836532592773 -5.82643053803622e-07 18.85599899291992 0.5276334881782532 18.85599899291992 1.178500294685364 C 18.85599899291992 1.829367160797119 18.32836532592773 2.356999635696411 17.67749786376953 2.356999635696411 L 1.178499937057495 2.357000112533569 C 0.5276321768760681 2.357000112533569 -5.815403625319959e-08 1.829367756843567 -3.746353627320786e-08 1.178500890731812 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
