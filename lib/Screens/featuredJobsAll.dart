// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:adobe_xd/page_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/Screens/Component34.dart';
import 'package:my_jobs_center/Screens/Search.dart';
import 'package:my_jobs_center/Screens/Sidemenu.dart';
import 'package:my_jobs_center/Screens/allJobsSearch.dart';
import 'package:my_jobs_center/Screens/jobDetails.dart';
import 'package:my_jobs_center/Screens/widget/favItemComponentWidget.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:my_jobs_center/mysql.dart';
import 'package:http/http.dart' as http;

class FeaturedJobsAll extends StatefulWidget {
  static const String idScreen = 'featuredJobsAll';
  const FeaturedJobsAll({Key? key}) : super(key: key);

  @override
  _FeaturedJobsAllState createState() => _FeaturedJobsAllState();
}

class _FeaturedJobsAllState extends State<FeaturedJobsAll> {
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
  Map urgentJobsFeat = {};
  Map urgentJobsFeat1 = {};
  // var urgentJobsListFeat = [];
  // Map featuredJobsFeat = {};
  var featuredJobsListFeat = [];

  bool isSpin = true;
  Map pageData = {};
  int offset = 1;
  List favIdsRec = [];
  Map favIdData = {};
  bool isFeaturedAllEmpty = false;
  //---------------featured php------

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

  Future gettingFeaturedJobs() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_featured');
    var url = Uri.parse(defaultUrl + 'mob_featured');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    setState(() {
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
    });

    // Starting Web API Call.
    // var response = await http.post(urrr, body: json.encode(data));
    // var response = await http.post(url);
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
        isFeaturedAllEmpty = true;
      });
    }
    // print(appliedJobs);
    // print(appliedJobs
    //     .map((i, element) => MapEntry(i, print(appliedJobs[i].toString()))));
    setState(() {
      isSpin = false;
    });

    // Getting Server response into variable.
    // print(userDetailsResponse.body.toString());
    // Map a = jsonDecode(userDetailsResponse.body);
    // print(a["name"]);
  }

  Future gettingFeaturedJobsOnLoop() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_featured');
    var url = Uri.parse(defaultUrl + 'mob_featured');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};
    setState(() {
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
    });
    // Starting Web API Call.
    // var response = await http.post(urrr, body: json.encode(data));
    // var response = await http.post(url);
    var response = await http.post(url, body: json.encode(pageData));

    try {
      urgentJobsFeat1 = jsonDecode(response.body);

      urgentJobsFeat1['featured'].forEach((k, v) => featuredJobsListFeat.add(Applied(k)));
      print("-------------------------------------------------");
      print(featuredJobsListFeat);
      print("-------------------------------------------------");
      urgentJobsFeat['featured'].addAll(urgentJobsFeat1['featured']);
      print(urgentJobsFeat1['featured'][featuredJobsListFeat[0].toString()]);
      print("-------------------------------------------------");
    } on FormatException catch (e) {
      gettingFeaturedJobsOnLoopException();
    } on NoSuchMethodError catch (e) {
      print("finished");
    }

    // print(appliedJobs);
    // print(appliedJobs
    //     .map((i, element) => MapEntry(i, print(appliedJobs[i].toString()))));
    setState(() {
      isSpin = false;
    });

    // Getting Server response into variable.
    // print(userDetailsResponse.body.toString());
    // Map a = jsonDecode(userDetailsResponse.body);
    // print(a["name"]);
  }

  Future gettingFeaturedJobsOnLoopException() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_featured');
    var url = Uri.parse(defaultUrl + 'mob_featured');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};
    setState(() {
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
    });
    // Starting Web API Call.
    // var response = await http.post(urrr, body: json.encode(data));
    // var response = await http.post(url);
    var response = await http.post(url, body: json.encode(pageData));

    try {
      urgentJobsFeat1 = jsonDecode(response.body);

      urgentJobsFeat1['featured'].forEach((k, v) => featuredJobsListFeat.add(Applied(k)));
      print("-------------------------------------------------");
      print(featuredJobsListFeat);
      print("-------------------------------------------------");
      urgentJobsFeat['featured'].addAll(urgentJobsFeat1['featured']);

      print(urgentJobsFeat1['featured'][featuredJobsListFeat[0].toString()]);
      print("-------------------------------------------------");
    } on FormatException catch (e) {
      gettingFeaturedJobsOnLoop();
    } on NoSuchMethodError catch (e) {
      print("finished");
    }

    // print(appliedJobs);
    // print(appliedJobs
    //     .map((i, element) => MapEntry(i, print(appliedJobs[i].toString()))));
    setState(() {
      isSpin = false;
    });

    // Getting Server response into variable.
    // print(userDetailsResponse.body.toString());
    // Map a = jsonDecode(userDetailsResponse.body);
    // print(a["name"]);
  }

  bool isScrolling = true;
  late ScrollController _controller;
  bool isDataLoadProgress = false;

  @override
  void initState() {
    gettingFavJobsIds();
    gettingFeaturedJobs();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    // dbCheckFavJobsAlready();
    // getUrgJobs();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        isDataLoadProgress = true;
        isScrolling = false;
        gettingFeaturedJobsOnLoop();
        // getProducts();
      });
    } else {
      setState(() {
        isScrolling = true;
      });
    }
  }

  // void dbCheckFavJobs() {
  //   dbFavJob.getConnection().then((value) async {
  //     resultFavJob = await value.query(
  //       'select product_id from `job_favads` where user_id=? limit 10',
  //       ['5'],
  //     );
  //   }).then((value) {
  //     setFavJobsID();
  //   }).then((value) => getFavJobs());
  // }

  // setFavJobsID() {
  //   for (var row in resultFavJob) {
  //     setState(() {
  //       favJobsIds.add(row[0]);
  //     });
  //   }
  // }

  // void getUrgJobs() {
  //   dbFavJob
  //       .getConnection()
  //       .then((value) async {
  //         resultFavJobProducts = await value.query(
  //           'select company_id,product_name,city,country,created_at,product_type,view,salary_min,salary_max,description,salary_type,id from `job_product` where (status =? and featured=?) limit 20',
  //           ['active', '1'],
  //         );
  //         // resultFavJobProducts.add(res);
  //       })
  //       .then((value) => setFavJobsDetails())
  //       .then((value) => checkfavJobRole())
  //       .then((value) => companyNameCheckFav())
  //       .then((value) => dbCheckJobContry())
  //       .then((value) => dbcheckFavJobCity());
  // }

  // setFavJobsDetails() {
  //   for (var row in resultFavJobProducts) {
  //     setState(() {
  //       companyIDFav.add(row[0]);
  //       productNameFav.add(row[1]);
  //       cityIDFav.add(row[2]);
  //       countryIDFav.add(row[3]);
  //       var createdDateArr = row[4].toString().split(" ");
  //       createdAtFav.add(createdDateArr[0]);
  //       prodTypeFav.add(row[5]);
  //       viewFav.add(row[6]);
  //       salMinFav.add(row[7]);
  //       salMaxFav.add(row[8]);
  //       descriptionFav.add(row[9]);
  //       salaryTypeFavID.add(row[10]);
  //       prodAdId.add(row[11]);
  //     });
  //   }
  // }

  // void companyNameCheckFav() {
  //   dbFavJob.getConnection().then((value) async {
  //     for (int i = 0; i < companyIDFav.length; i++) {
  //       var res = await value.query(
  //         'select name,logo from `job_companies` where id=?',
  //         [companyIDFav[i]],
  //       );
  //       resultFavJobCompName.add(res);
  //     }
  //     for (int i = 0; i < salaryTypeFavID.length; i++) {
  //       var res = await value.query(
  //         'select title from `job_salary_type` where id=?',
  //         [salaryTypeFavID[i]],
  //       );
  //       resultFavSalaryType.add(res);
  //     }
  //   }).then((value) => setCompanyNameFav());
  // }

  // setCompanyNameFav() {
  //   for (int i = 0; i < resultFavJobCompName.length; i++) {
  //     if (resultFavJobCompName[i].toString() == "()") {
  //       setState(() {
  //         companyNameFav.add("Unknown");
  //         imageFav.add("default_user.png");
  //       });
  //     }
  //     for (var row in resultFavJobCompName[i]) {
  //       // print(row[0].toString());

  //       setState(() {
  //         if (row[0] != null) {
  //           companyNameFav.add(row[0]);
  //         } else {
  //           companyNameFav.add("Unknown");
  //         }

  //         if (row[1] != null) {
  //           imageFav.add(row[1]);
  //         } else {
  //           imageFav.add("default_user.png");
  //         }
  //       });
  //     }
  //   }

  //   for (int i = 0; i < resultFavSalaryType.length; i++) {
  //     for (var row in resultFavSalaryType[i]) {
  //       setState(() {
  //         salaryTypeFavName.add(row[0]);
  //       });
  //     }
  //   }
  // }

  // checkfavJobRole() {
  //   dbFavJob.getConnection().then((value) async {
  //     for (int i = 0; i < prodTypeFav.length; i++) {
  //       var res = await value.query(
  //         'select title from `job_product_type` where id=?',
  //         [prodTypeFav[i]],
  //       );
  //       resultFavJobType.add(res);
  //     }
  //   }).then((value) => setFavJobRole());
  // }

  // setFavJobRole() {
  //   for (int i = 0; i < resultFavJobType.length; i++) {
  //     for (var row in resultFavJobType[i]) {
  //       setState(() {
  //         jobTypeFav.add(row[0]);
  //       });
  //     }
  //   }
  // }

  // dbCheckJobContry() {
  //   dbFavJob.getConnection().then((value) async {
  //     for (int i = 0; i < countryIDFav.length; i++) {
  //       var res = await value.query(
  //         'select asciiname,currency_code from `job_countries` where code=?',
  //         [countryIDFav[i]],
  //       );
  //       resultFavCountry.add(res);
  //     }
  //   }).then((value) => setFavCountry());
  // }

  // setFavCountry() {
  //   for (int i = 0; i < resultFavCountry.length; i++) {
  //     for (var row in resultFavCountry[i]) {
  //       setState(() {
  //         countryFav.add(row[0]);
  //         currencyFav.add(row[1]);
  //       });
  //     }
  //   }
  // }

  // dbcheckFavJobCity() {
  //   dbFavJob.getConnection().then((value) async {
  //     for (int i = 0; i < cityIDFav.length; i++) {
  //       var res = await value.query(
  //         'select asciiname from `job_cities` where id=?',
  //         [cityIDFav[i]],
  //       );
  //       resultFavCity.add(res);
  //     }
  //     print(resultFavCity);
  //   }).then((value) => setFavCity());
  // }

  // setFavCity() {
  //   if (resultFavCity[0].toString() == "()") {
  //     cityFav.add("a");
  //   } else {
  //     for (int i = 0; i < resultFavCity.length; i++) {
  //       for (var row in resultFavCity[i]) {
  //         setState(() {
  //           cityFav.add(row[0]);
  //         });
  //       }
  //     }
  //   }
  //   setState(() {
  //     isSpin = false;
  //   });
  // }

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
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 25),
          //     child: PageLink(
          //       links: [
          //         PageLinkInfo(
          //           ease: Curves.easeOut,
          //           duration: 1.0,
          //           pageBuilder: () => Sidemenu(),
          //         ),
          //       ],
          //       child: Icon(
          //         Icons.menu_rounded,
          //         size: 25,
          //         color: const Color(0xffdd312d),
          //       ),
          //     ),
          //   ),
          // ],
          title: Text(
            'Featured Jobs',
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
                              if (isFeaturedAllEmpty)
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.15),
                                  child: Text(
                                    "No Featured Jobs Found For Your Country",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: const Color(0xff1d1d1d),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              for (int i = 0; i < featuredJobsListFeat.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JobDetailsScreen(
                                          isApplyShow: true,
                                          company: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['company_name'],
                                          title: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['product_name'],
                                          city: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['location'],
                                          country: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['country'],
                                          type: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['product_type'],
                                          date: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['created_at'],
                                          view: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['view'],
                                          minSal: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['salary_min'],
                                          maxSal: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['salary_max'],
                                          // currency: currencyFeat[i]
                                          //     .toString(),
                                          salType: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['salary_type'],
                                          description: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['desc'],
                                          img: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['company_image'],
                                          idChat: urgentJobsFeat['featured']
                                                  [featuredJobsListFeat[i].toString()]
                                              ['user_id'],
                                          jobID: urgentJobsFeat['featured']
                                              [featuredJobsListFeat[i].toString()]['id'],
                                          isFav: favIdsRec.contains(
                                              urgentJobsFeat['featured']
                                                      [featuredJobsListFeat[i].toString()]
                                                  ['id']),
                                          link: urgentJobsFeat['featured']
                                                      [featuredJobsListFeat[i].toString()]
                                                  ['link']
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: FavItemComponentWidget(
                                    isFav: favIdsRec.contains(urgentJobsFeat['featured']
                                        [featuredJobsListFeat[i].toString()]['id']),
                                    // isFav: (favJobsIdsAlready
                                    //         .contains(prodAdIddFeat[i]))
                                    //     ? true
                                    //     : false,

                                    city: urgentJobsFeat['featured']
                                        [featuredJobsListFeat[i].toString()]['location'],
                                    country: urgentJobsFeat['featured']
                                        [featuredJobsListFeat[i].toString()]['country'],
                                    date: urgentJobsFeat['featured']
                                            [featuredJobsListFeat[i].toString()]
                                        ['created_at'],
                                    description: urgentJobsFeat['featured']
                                        [featuredJobsListFeat[i].toString()]['desc'],
                                    maxSal: urgentJobsFeat['featured']
                                            [featuredJobsListFeat[i].toString()]
                                        ['salary_max'],
                                    minSal: urgentJobsFeat['featured']
                                            [featuredJobsListFeat[i].toString()]
                                        ['salary_min'],
                                    title: urgentJobsFeat['featured']
                                            [featuredJobsListFeat[i].toString()]
                                        ['product_name'],
                                    type: urgentJobsFeat['featured']
                                            [featuredJobsListFeat[i].toString()]
                                        ['product_type'],
                                    view: urgentJobsFeat['featured']
                                        [featuredJobsListFeat[i].toString()]['view'],
                                    img: urgentJobsFeat['featured']
                                            [featuredJobsListFeat[i].toString()]
                                        ['company_image'],
                                    salType: urgentJobsFeat['featured']
                                            [featuredJobsListFeat[i].toString()]
                                        ['salary_type'],
                                    // currency:
                                    //     currencyFeat[i].toString(),
                                    prodID: urgentJobsFeat['featured']
                                            [featuredJobsListFeat[i].toString()]
                                        ['product_type'],
                                    msgId: urgentJobsFeat['featured']
                                        [featuredJobsListFeat[i].toString()]['user_id'],
                                    jobId: urgentJobsFeat['featured']
                                        [featuredJobsListFeat[i].toString()]['id'],
                                    feature: urgentJobsFeat['featured']
                                        [featuredJobsListFeat[i].toString()]['featured'],
                                    highlight: urgentJobsFeat['featured']
                                        [featuredJobsListFeat[i].toString()]['highlight'],
                                    urgent: urgentJobsFeat['featured']
                                        [featuredJobsListFeat[i].toString()]['urgent'],
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
