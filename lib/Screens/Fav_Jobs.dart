// import 'package:adobe_jobcentre/Sidemenu.dart';
// import 'package:adobe_jobcentre/widget/favItemComponentWidget.dart';
// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:adobe_xd/page_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/Screens/Component34.dart';
import 'package:my_jobs_center/Screens/Job_Expanded.dart';
import 'package:my_jobs_center/Screens/Search.dart';
import 'package:my_jobs_center/Screens/Sidemenu.dart';
import 'package:my_jobs_center/Screens/allJobsSearch.dart';
import 'package:my_jobs_center/Screens/jobDetails.dart';
import 'package:my_jobs_center/Screens/widget/favItemComponentWidget.dart';
import 'package:my_jobs_center/Screens/widget/favJobNotSignMsgWidget.dart';
import 'package:my_jobs_center/employer/widget/endDrawer.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:my_jobs_center/markdownFile.dart';
import 'package:my_jobs_center/mysql.dart';
import 'package:http/http.dart' as http;

// import '../Search.dart';

class FavJobs extends StatefulWidget {
  static const String idScreen = "favJobsPage";
  const FavJobs({Key? key}) : super(key: key);

  @override
  _FavJobsState createState() => _FavJobsState();
}

class _FavJobsState extends State<FavJobs> {
  var dbFavJob = new Mysql();
  var resultFavJob;
  var resultFavJobProducts = [];
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
  Map appliedJobs = {};
  var appliedJobsList = [];
  Map pageData = {};
  int offset = 1;

  bool isSpin = true;
  bool isEmptyyFav = false;

  Future gettingFavJobs() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_favourite_user');
    var url = Uri.parse(defaultUrl + 'mob_favourite_user');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    // var response = await http.post(urrr, body: json.encode(data));
    var response = await http.post(url,
        body: json.encode({
          'id': userDetailsResponse['id'],
          'userName': userDetailsResponse['username']
        }));
    try {
      appliedJobs = jsonDecode(response.body);
      appliedJobs.forEach((k, v) => appliedJobsList.add(Applied(k)));
      print(appliedJobsList);
      print(appliedJobs[appliedJobsList[0].toString()]);
    } catch (error) {
      print(error);
      setState(() {
        isEmptyyFav = true;
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

  @override
  void initState() {
    // dbCheckFavJobs();
    gettingFavJobs();
  }

  // void dbCheckFavJobs() {
  //   dbFavJob.getConnection().then((value) async {
  //     resultFavJob = await value.query(
  //       'select product_id from `job_favads` where user_id=? limit 10',
  //       [userID],
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

  // void getFavJobs() {
  //   dbFavJob
  //       .getConnection()
  //       .then((value) async {
  //         for (int i = 0; i < favJobsIds.length; i++) {
  //           var res = await value.query(
  //             'select company_id,product_name,city,country,created_at,product_type,view,salary_min,salary_max,description,salary_type,id from `job_product` where (status =? and id=?)',
  //             ['active', favJobsIds[i]],
  //           );
  //           resultFavJobProducts.add(res);
  //         }
  //       })
  //       .then((value) => setFavJobsDetails())
  //       .then((value) => checkfavJobRole())
  //       .then((value) => companyNameCheckFav())
  //       .then((value) => dbCheckJobContry())
  //       .then((value) => dbcheckFavJobCity());
  // }

  // setFavJobsDetails() {
  //   for (int i = 0; i < resultFavJobProducts.length; i++) {
  //     for (var row in resultFavJobProducts[i]) {
  //       setState(() {
  //         companyIDFav.add(row[0]);
  //         productNameFav.add(row[1]);
  //         cityIDFav.add(row[2]);
  //         countryIDFav.add(row[3]);
  //         var createdDateArr = row[4].toString().split(" ");
  //         createdAtFav.add(createdDateArr[0]);
  //         prodTypeFav.add(row[5]);
  //         viewFav.add(row[6]);
  //         salMinFav.add(row[7]);
  //         salMaxFav.add(row[8]);
  //         descriptionFav.add(row[9]);
  //         salaryTypeFavID.add(row[10]);
  //         prodAdId.add(row[11]);
  //       });
  //     }
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
  //   if (!resultFavCity.isEmpty) {
  //     if (resultFavCity[0].toString() == "()") {
  //       cityFav.add("a");
  //     } else {
  //       for (int i = 0; i < resultFavCity.length; i++) {
  //         for (var row in resultFavCity[i]) {
  //           setState(() {
  //             cityFav.add(row[0]);
  //           });
  //         }
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
            'Fav.Jobs',
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
        body: Stack(
          children: [
            Container(
              child: isSignedIn
                  ? isSpin
                      ? Center(
                          child: CupertinoActivityIndicator(
                            animating: isSpin,
                            radius: 25,
                          ),
                        )
                      : isEmptyyFav
                          ? Center(
                              child: Text(
                                "No Favourite Jobs",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: const Color(0xff132144),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20, top: 5),
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
                                                          builder: ((context) =>
                                                              AllJobsSearch(
                                                                searchTermRec:
                                                                    searchKeyword,
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
                                                  CupertinoIcons.search,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        for (int i = 0; i < appliedJobsList.length; i++)
                                          GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => MarkDownTest(
                                              //             description:
                                              //                 descriptionFav[i].toString())));
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => JobExpanded()));
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => JobDetailsScreen(
                                                    isApplyShow: true,
                                                    company: appliedJobs[
                                                                appliedJobsList[i]
                                                                    .toString()]
                                                            ['company_name']
                                                        .toString(),
                                                    title: appliedJobs[appliedJobsList[i]
                                                            .toString()]['product_name']
                                                        .toString(),
                                                    city: appliedJobs[appliedJobsList[i]
                                                            .toString()]['location']
                                                        .toString(),
                                                    country: appliedJobs[
                                                            appliedJobsList[i]
                                                                .toString()]['country']
                                                        .toString(),
                                                    type: appliedJobs[appliedJobsList[i]
                                                            .toString()]['product_type']
                                                        .toString(),
                                                    date: appliedJobs[appliedJobsList[i]
                                                            .toString()]['created_at']
                                                        .toString(),
                                                    view: appliedJobs[appliedJobsList[i]
                                                            .toString()]['view']
                                                        .toString(),
                                                    minSal: appliedJobs[appliedJobsList[i]
                                                            .toString()]['salary_min']
                                                        .toString(),
                                                    maxSal: appliedJobs[appliedJobsList[i]
                                                            .toString()]['salary_max']
                                                        .toString(),
                                                    // currency:
                                                    //     currencyFav[i].toString(),
                                                    salType: appliedJobs[
                                                                appliedJobsList[i]
                                                                    .toString()]
                                                            ['salary_type']
                                                        .toString(),
                                                    description: appliedJobs[
                                                            appliedJobsList[i]
                                                                .toString()]['desc']
                                                        .toString(),
                                                    img: appliedJobs[appliedJobsList[i]
                                                            .toString()]['company_image']
                                                        .toString(),
                                                    idChat: appliedJobs[appliedJobsList[i]
                                                            .toString()]['user_id']
                                                        .toString(),
                                                    jobID: appliedJobs[appliedJobsList[i]
                                                            .toString()]['id']
                                                        .toString(),
                                                    isFav: true,
                                                    link: appliedJobs[appliedJobsList[i]
                                                            .toString()]['link']
                                                        .toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: FavItemComponentWidget(
                                              isFav: true,
                                              // city: cityFav[i].toString(),
                                              city: appliedJobs[appliedJobsList[i]
                                                      .toString()]['location']
                                                  .toString(),
                                              // country: countryFav[i].toString(),
                                              country: appliedJobs[appliedJobsList[i]
                                                      .toString()]['country']
                                                  .toString(),
                                              // currency: currencyFav[i].toString(),
                                              // date: createdAtFav[i].toString(),
                                              date: appliedJobs[appliedJobsList[i]
                                                      .toString()]['created_at']
                                                  .toString(),
                                              // description: descriptionFav[i].toString(),
                                              description: appliedJobs[appliedJobsList[i]
                                                      .toString()]['desc']
                                                  .toString(),
                                              // img: imageFav[i].toString(),
                                              img: appliedJobs[appliedJobsList[i]
                                                      .toString()]['company_image']
                                                  .toString(),
                                              maxSal: appliedJobs[appliedJobsList[i]
                                                      .toString()]['salary_max']
                                                  .toString(),
                                              // maxSal: salMaxFav[i].toString(),
                                              minSal: appliedJobs[appliedJobsList[i]
                                                      .toString()]['salary_min']
                                                  .toString(),
                                              // minSal: salMinFav[i].toString(),
                                              salType: appliedJobs[appliedJobsList[i]
                                                      .toString()]['salary_type']
                                                  .toString(),
                                              // salType: salaryTypeFavName[i].toString(),
                                              title: appliedJobs[appliedJobsList[i]
                                                      .toString()]['product_name']
                                                  .toString(),
                                              // title: productNameFav[i].toString(),
                                              type: appliedJobs[appliedJobsList[i]
                                                      .toString()]['product_type']
                                                  .toString(),
                                              // type: jobTypeFav[i].toString(),
                                              view: appliedJobs[appliedJobsList[i]
                                                      .toString()]['view']
                                                  .toString(),
                                              // view: viewFav[i].toString(),
                                              prodID: appliedJobs[
                                                      appliedJobsList[i].toString()]['id']
                                                  .toString(),
                                              msgId: appliedJobs[appliedJobsList[i]
                                                      .toString()]['user_id']
                                                  .toString(),
                                              jobId: appliedJobs[
                                                      appliedJobsList[i].toString()]['id']
                                                  .toString(),
                                              feature: appliedJobs[appliedJobsList[i]
                                                      .toString()]['featured']
                                                  .toString(),
                                              highlight: appliedJobs[appliedJobsList[i]
                                                      .toString()]['highlight']
                                                  .toString(),
                                              urgent: appliedJobs[appliedJobsList[i]
                                                      .toString()]['urgent']
                                                  .toString(),
                                              // prodID: prodAdId[i].toString(),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                  : FavJobNotSignedMsgWidget(),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: SizedBox(
                  height: 60,
                  child: (userDetailsResponse["user_type"] == 'user' ||
                          userDetailsResponse["user_type"] == null)
                      ? Component34()
                      : EndDrawer(),
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
