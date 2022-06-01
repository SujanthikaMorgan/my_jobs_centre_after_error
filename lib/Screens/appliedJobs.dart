// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_jobs_center/Screens/Component34.dart';
import 'package:my_jobs_center/Screens/allJobsSearch.dart';
import 'package:my_jobs_center/Screens/jobDetails.dart';
import 'package:my_jobs_center/Screens/widget/appliedJobWidget.dart';
import 'package:my_jobs_center/Screens/widget/connectWIdget.dart';
import 'package:my_jobs_center/Screens/widget/favItemComponentWidget.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:my_jobs_center/mysql.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_jobs_center/Screens/Search.dart';
import 'package:my_jobs_center/Screens/Sidemenu.dart';
import 'package:http/http.dart' as http;

class AppliedJobsScreen extends StatefulWidget {
  static const String idScreen = "AppliedJobsScreen";
  const AppliedJobsScreen({Key? key}) : super(key: key);

  @override
  _AppliedJobsScreenState createState() => _AppliedJobsScreenState();
}

class _AppliedJobsScreenState extends State<AppliedJobsScreen> {
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
  bool isAppliedEmpty = false;

  bool isSpin = true;
  List favIdsRec = [];
  Map favIdData = {};
  //--------------------------------PHP--------------------------

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
      print("favIds");
      print(favIdsRec);
    } catch (error) {
      print("object");
    }
  }

  Future gettingAppliedJobs() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_applied_jobs');
    var url = Uri.parse(defaultUrl + 'mob_applied_jobs');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    // var response = await http.post(urrr, body: json.encode(data));
    var response =
        await http.post(url, body: json.encode({'id': userDetailsResponse['id']}));

    try {
      appliedJobs = jsonDecode(response.body);
      appliedJobs.forEach((k, v) => appliedJobsList.add(Applied(k)));
      print(appliedJobsList);
      print(appliedJobs[appliedJobsList[0].toString()]);
    } catch (error) {
      setState(() {
        isAppliedEmpty = true;
      });
      print("object");
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

  // //---------------------fav Check--------------------
  // var dbFavJobAlready = new Mysql();
  // var resultFavJobAlready;
  // var favJobsIdsAlready = [];
  // void dbCheckFavJobsAlready() {
  //   dbFavJobAlready.getConnection().then((value) async {
  //     resultFavJobAlready = await value.query(
  //       'select product_id from `job_favads` where user_id=?',
  //       [userID],
  //     );
  //   }).then((value) {
  //     setFavJobsIDAlready();
  //   });
  // }

  // setFavJobsIDAlready() {
  //   for (var row in resultFavJobAlready) {
  //     setState(() {
  //       favJobsIdsAlready.add(row[0]);
  //     });
  //   }
  // }
  // //------------------------------------------------

  @override
  void initState() {
    if (isSignedIn) {
      gettingFavJobsIds();
    }

    gettingAppliedJobs();
    // print(appliedJobs);
    // dbCheckFavJobsAlready();
    // dbCheckFavJobs();
  }

  // void dbCheckFavJobs() {
  //   dbFavJob.getConnection().then((value) async {
  //     resultFavJob = await value.query(
  //       'select job_id from `job_user_applied` where user_id=? limit 10',
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
  //     print(resultFavJobCompName);
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
            'Applied Jobs',
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
                      : isAppliedEmpty
                          ? Center(
                              child: Text(
                                "No Jobs Applied",
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
                                                Navigator.pushNamed(
                                                    context, AllJobsSearch.idScreen);
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
                                        for (int i = 0; i < appliedJobsList.length; i++)
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => JobDetailsScreen(
                                                    isApplyShow: true,
                                                    company: appliedJobs[
                                                            appliedJobsList[i].toString()]
                                                        ['company_name'],
                                                    title: appliedJobs[appliedJobsList[i]
                                                        .toString()]['product_name'],
                                                    city: appliedJobs[appliedJobsList[i]
                                                            .toString()]['location']
                                                        .toString(),
                                                    country: appliedJobs[
                                                            appliedJobsList[i].toString()]
                                                        ['country'],
                                                    type: appliedJobs[appliedJobsList[i]
                                                        .toString()]['product_type'],
                                                    date: appliedJobs[appliedJobsList[i]
                                                        .toString()]['created_at'],
                                                    view: appliedJobs[appliedJobsList[i]
                                                        .toString()]['view'],
                                                    minSal: appliedJobs[appliedJobsList[i]
                                                        .toString()]['salary_min'],
                                                    maxSal: appliedJobs[appliedJobsList[i]
                                                        .toString()]['salary_max'],
                                                    // currency:
                                                    //     currencyFav[i].toString(),
                                                    salType: appliedJobs[
                                                            appliedJobsList[i].toString()]
                                                        ['salary_type'],
                                                    description: appliedJobs[
                                                            appliedJobsList[i].toString()]
                                                        ['desc'],
                                                    img: appliedJobs[appliedJobsList[i]
                                                        .toString()]['company_image'],
                                                    idChat: appliedJobs[appliedJobsList[i]
                                                        .toString()]['user_id'],
                                                    jobID: appliedJobs[appliedJobsList[i]
                                                        .toString()]['id'],
                                                    isFav: favIdsRec.contains(appliedJobs[
                                                            appliedJobsList[i].toString()]
                                                        ['id']),
                                                    link: appliedJobs[appliedJobsList[i]
                                                            .toString()]['link']
                                                        .toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: FavItemComponentWidget(
                                              // isFav: (favJobsIdsAlready.contains(prodAdId[i]))
                                              //     ? true
                                              //     : false,
                                              isFav: favIdsRec.contains(appliedJobs[
                                                  appliedJobsList[i].toString()]['id']),
                                              // city: cityFav[i].toString(),
                                              city: appliedJobs[appliedJobsList[i]
                                                      .toString()]['location']
                                                  .toString(),
                                              // country: countryFav[i].toString(),
                                              country: appliedJobs[appliedJobsList[i]
                                                  .toString()]['country'],
                                              // currency: currencyFav[i].toString(),
                                              // date: createdAtFav[i].toString(),
                                              date: appliedJobs[appliedJobsList[i]
                                                  .toString()]['created_at'],
                                              // description: descriptionFav[i].toString(),
                                              description: appliedJobs[
                                                  appliedJobsList[i].toString()]['desc'],
                                              // img: imageFav[i].toString(),
                                              img: appliedJobs[appliedJobsList[i]
                                                  .toString()]['company_image'],
                                              maxSal: appliedJobs[appliedJobsList[i]
                                                  .toString()]['salary_max'],
                                              // maxSal: salMaxFav[i].toString(),
                                              minSal: appliedJobs[appliedJobsList[i]
                                                  .toString()]['salary_min'],
                                              // minSal: salMinFav[i].toString(),
                                              salType: appliedJobs[appliedJobsList[i]
                                                  .toString()]['salary_type'],
                                              // salType: salaryTypeFavName[i].toString(),
                                              title: appliedJobs[appliedJobsList[i]
                                                  .toString()]['product_name'],
                                              // title: productNameFav[i].toString(),
                                              type: appliedJobs[appliedJobsList[i]
                                                  .toString()]['product_type'],
                                              // type: jobTypeFav[i].toString(),
                                              view: appliedJobs[
                                                  appliedJobsList[i].toString()]['view'],
                                              // view: viewFav[i].toString(),
                                              prodID: appliedJobs[
                                                  appliedJobsList[i].toString()]['id'],
                                              msgId: appliedJobs[appliedJobsList[i]
                                                  .toString()]['user_id'],
                                              jobId: appliedJobs[
                                                  appliedJobsList[i].toString()]['id'],
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
                                        SizedBox(
                                          height: 25,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                  : AppliedJobWidget(),
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
