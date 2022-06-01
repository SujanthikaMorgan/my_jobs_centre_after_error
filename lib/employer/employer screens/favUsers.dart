import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/jobseekerPreviewWidget.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:http/http.dart' as http;

class FavUsers extends StatefulWidget {
  static const String idScreen = "favUsersPage";
  const FavUsers({Key? key}) : super(key: key);

  @override
  _FavUsersState createState() => _FavUsersState();
}

class _FavUsersState extends State<FavUsers> {
  Map pageData = {};
  int offset = 1;
  Map alljobs = {};
  Map alljobs1 = {};
  var allJobsList = [];
  bool isAllJobsEmpty = false;
  bool isSpin = true;
  List blockedIds = [];
  Future gettingAllJobseekers() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_all_jobs');
    var url = Uri.parse(defaultUrl + 'mob_fav_users');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    setState(() {
      pageData['id'] = userDetailsResponse['id'];
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
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
      print(error);
      setState(() {
        isAllJobsEmpty = true;
      });
    }

    setState(() {
      isSpin = false;
    });
  }

  Future gettingAllJobseekersLoop() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_all_jobs');
    var url = Uri.parse(defaultUrl + 'mob_fav_users');

    // Starting Web API Call.

    setState(() {
      pageData['id'] = userDetailsResponse['id'];
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      // pageData['country'] = userDetailsResponse['country_code'];
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
      gettingAllJobseekersLoopOnExecption();
    } catch (error) {
      print(error);
    }

    setState(() {
      isDataLoadProgress = false;
    });
  }

  Future gettingAllJobseekersLoopOnExecption() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_all_jobs');
    var url = Uri.parse(defaultUrl + 'mob_fav_users');

    // Starting Web API Call.

    setState(() {
      pageData['id'] = userDetailsResponse['id'];
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      // pageData['country'] = userDetailsResponse['country_code'];
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

    setState(() {
      isDataLoadProgress = false;
    });
  }

  Future getBlockedIds() async {
    var url = Uri.parse(defaultUrl + 'mob_check_blocked');
    var response = await http.post(url,
        body: json.encode({
          "userid": userDetailsResponse['id'],
        }));
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        blockedIds = jsonDecode(response.body) as List;
      });
    }
  }

  bool isScrolling = true;
  late ScrollController _controller;
  bool isDataLoadProgress = false;
  @override
  void initState() {
    gettingAllJobseekers();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        isDataLoadProgress = true;
        isScrolling = false;
        gettingAllJobseekersLoop();
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
    return Scaffold(
      backgroundColor: const Color(0xffedece8),
      endDrawer: SidemenuEmployer(),
      appBar: AppBar(
        backgroundColor: const Color(0xffedece8), // f7f9fc
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Color(0xff1d1d1d)),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Favourite Candidates",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: isSpin
          ? Center(
              child: CupertinoActivityIndicator(animating: isSpin),
            )
          : SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  for (int i = 0; i < allJobsList.length; i++)
                    JobSeekerPreviewWidget(
                      city: (alljobs['all'][allJobsList[i].toString()]['city'] == null)
                          ? " "
                          : alljobs['all'][allJobsList[i].toString()]['city'],
                      country:
                          (alljobs['all'][allJobsList[i].toString()]['country'] == null)
                              ? " "
                              : alljobs['all'][allJobsList[i].toString()]['country'],
                      createdAt: (alljobs['all'][allJobsList[i].toString()]
                                  ['created_at'] ==
                              null)
                          ? " "
                          : alljobs['all'][allJobsList[i].toString()]['created_at'],
                      description: (alljobs['all'][allJobsList[i].toString()]
                                  ['description'] ==
                              null)
                          ? " "
                          : alljobs['all'][allJobsList[i].toString()]['description'],
                      imagePath: alljobs['all'][allJobsList[i].toString()]['image'],
                      mainCat:
                          (alljobs['all'][allJobsList[i].toString()]['category'] == null)
                              ? ""
                              : alljobs['all'][allJobsList[i].toString()]['category'],
                      maxSal: (alljobs['all'][allJobsList[i].toString()]['salary_max'] ==
                              null)
                          ? " "
                          : alljobs['all'][allJobsList[i].toString()]['salary_max'],
                      minSal: (alljobs['all'][allJobsList[i].toString()]['salary_min'] ==
                              null)
                          ? " "
                          : alljobs['all'][allJobsList[i].toString()]['salary_min'],
                      name: (alljobs['all'][allJobsList[i].toString()]['name'] == null)
                          ? " "
                          : alljobs['all'][allJobsList[i].toString()]['name'],
                      // salType: alljobs['all'][allJobsList[i].toString()]['city'],
                      tagline:
                          (alljobs['all'][allJobsList[i].toString()]['tagline'] == null)
                              ? " "
                              : alljobs['all'][allJobsList[i].toString()]['tagline'],
                      experience: (alljobs['all'][allJobsList[i].toString()]
                                  ['experience'] ==
                              null)
                          ? []
                          : alljobs['all'][allJobsList[i].toString()]['experience'],
                      userId: alljobs['all'][allJobsList[i].toString()]['id'],
                      isBlocked: blockedIds
                          .contains(alljobs['all'][allJobsList[i].toString()]['id']),
                      userName: alljobs['all'][allJobsList[i].toString()]['username'],
                    )
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
