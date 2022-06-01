// ignore_for_file: avoid_unnecessary_containers, file_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_jobs_center/employer/employer%20screens/applicants.dart';
import 'package:my_jobs_center/employer/employer%20screens/job.dart';
import 'package:my_jobs_center/employer/employer%20screens/jobPostClosed.dart';
import 'package:my_jobs_center/employer/employer%20screens/jobPostExpired.dart';
import 'package:my_jobs_center/employer/employer%20screens/jobPostPending.dart';
import 'package:my_jobs_center/employer/employer%20screens/jobPostResubmitted.dart';
import 'package:my_jobs_center/employer/employer%20screens/notificationEmployee.dart';
import 'package:my_jobs_center/employer/employer%20screens/payment.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/categoryitem.dart';
import 'package:my_jobs_center/employer/widget/endDrawer.dart';
import 'package:my_jobs_center/employer/widget/jobsWidget.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:http/http.dart' as http;

class JobPost extends StatefulWidget {
  static const String idScreen = "jobsPost";
  const JobPost({Key? key}) : super(key: key);

  @override
  _JobPostState createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
  Map pageData = {};
  int offset = 1;
  Map myJobs = {};
  var myJobsList = [];
  bool isMyJobsEmpty = false;
  bool isSpin = true;
  Map myJobs1 = {};
  Future gettingAllJobs() async {
    var url = Uri.parse(defaultUrl + 'mob_my_jobs');

    // Starting Web API Call.
    setState(() {
      pageData["limit"] = 5;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
      pageData['id'] = userDetailsResponse['id'];
    });
    var response = await http.post(url, body: json.encode(pageData));
    // var response = await http.post(url);
    try {
      myJobs = jsonDecode(response.body);
      print(myJobs);

      myJobs['all'].forEach((k, v) => myJobsList.add(Applied(k)));
      print("-------------------------------------------------");
      print(myJobsList);
      print("-------------------------------------------------");

      // print(myJobs['all'][myJobsList[0].toString()]);
      print(myJobs['all'][myJobsList[0].toString()]);
      print("-------------------------------------------------");
    } catch (error) {
      print(error);
      setState(() {
        isMyJobsEmpty = true;
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
    var url = Uri.parse(defaultUrl + 'mob_my_jobs');

    // Starting Web API Call.

    setState(() {
      offset = offset + 1;
      pageData["limit"] = 4;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
      pageData['id'] = userDetailsResponse['id'];
    });
    var response = await http.post(url, body: json.encode(pageData));
    // var response = await http.post(url);

    try {
      myJobs1 = jsonDecode(response.body);
      print(myJobs1);

      myJobs1['all'].forEach((k, v) => myJobsList.add(Applied(k)));
      print("-------------------------------------------------");
      print(myJobsList);
      print("-------------------------------------------------");
      myJobs['all'].addAll(myJobs1['all']);
      print(myJobs['all'][myJobsList[0].toString()]);
      print("-------------------------------------------------");
    } on FormatException catch (e) {
      // gettingAllJobsLoopOnExecption();
    } catch (error) {
      print(error);
    }

    setState(() {
      isDataLoadProgress = false;
    });
  }

  Future gettingAllJobsLoopOnExecption() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_all_jobs');
    var url = Uri.parse(defaultUrl + 'mob_my_jobs');

    // Starting Web API Call.

    setState(() {
      offset = offset + 1;
      pageData["limit"] = 5;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
      pageData['id'] = userDetailsResponse['id'];
    });
    var response = await http.post(url, body: json.encode(pageData));
    // var response = await http.post(url);

    try {
      myJobs1 = jsonDecode(response.body);
      print(myJobs1);

      myJobs1['all'].forEach((k, v) => myJobsList.add(Applied(k)));
      print("-------------------------------------------------");
      print(myJobsList);
      print("-------------------------------------------------");
      myJobs['all'].addAll(myJobs1['all']);
      print(myJobs['all'][myJobsList[0].toString()]);
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

  bool isScrolling = true;
  late ScrollController _controller;
  bool isDataLoadProgress = false;

  @override
  void initState() {
    // gettingFavJobsIds();
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
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      endDrawer: SidemenuEmployer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        backgroundColor: const Color(0xfff7f9fc),
        elevation: 0,
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationEmployee()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              bottom: 10,
              right: 10,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(
                  Icons.notifications_outlined,
                  size: 20.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          "My Jobs",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.sp,
            color: const Color(0xff1d1d1d),
            fontWeight: FontWeight.w500,
            //fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          isSpin
              ? Center(
                  child: CupertinoActivityIndicator(
                    animating: isSpin,
                    radius: 25,
                  ),
                )
              : SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            SizedBox(width: 15.w),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobPost(),
                                  ),
                                );
                              },
                              child: CategoryItem(
                                  catDisplay: "Live", bgcolor: Colors.green.shade400),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobPostExpired(),
                                  ),
                                );
                              },
                              child: CategoryItem(
                                  catDisplay: "Expired", bgcolor: Colors.red.shade700),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobPostPending(),
                                  ),
                                );
                              },
                              child: CategoryItem(
                                  catDisplay: "Pending", bgcolor: Colors.orange.shade400),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobPostClosed(),
                                  ),
                                );
                              },
                              child: CategoryItem(
                                  catDisplay: "Closed", bgcolor: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobPostResubmitted(),
                                  ),
                                );
                              },
                              child: CategoryItem(
                                  catDisplay: "Resubmitted",
                                  bgcolor: Colors.blue.shade400),
                            ),
                            SizedBox(
                              width: 120.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Job()));
                              },
                              child: Text(
                                "Post a Job",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 17.sp,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                  // fontStyle: FontStyle.italic,
                                  height: 1.4166666666666667.h,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      isMyJobsEmpty
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.15),
                              child: Text(
                                "No active jobs found.",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 136, 133, 133),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  for (int i = 0; i < myJobsList.length; i++)
                                    JobsWidget(
                                      jobtype: myJobs['all'][myJobsList[i].toString()]
                                              ['product_type']
                                          .toString(),
                                      description: myJobs['all'][myJobsList[i].toString()]
                                              ['description']
                                          .toString(),
                                      city: myJobs['all'][myJobsList[i].toString()]
                                              ['location']
                                          .toString(),
                                      country: myJobs['all'][myJobsList[i].toString()]
                                              ['country']
                                          .toString(),
                                      shortlisted: myJobs['all'][myJobsList[i].toString()]
                                              ['product_type']
                                          .toString(),
                                      title: myJobs['all'][myJobsList[i].toString()]
                                              ['product_name']
                                          .toString(),
                                      views: myJobs['all'][myJobsList[i].toString()]
                                              ['view']
                                          .toString(),
                                      company: myJobs['all'][myJobsList[i].toString()]
                                              ['company_name']
                                          .toString(),
                                      date: myJobs['all'][myJobsList[i].toString()]
                                              ['created_at']
                                          .toString(),
                                      img: myJobs['all'][myJobsList[i].toString()]
                                              ['company_image']
                                          .toString(),
                                      jobID: myJobs['all'][myJobsList[i].toString()]
                                          ['id'],
                                      maxSal: myJobs['all'][myJobsList[i].toString()]
                                              ['salary_max']
                                          .toString(),
                                      minSal: myJobs['all'][myJobsList[i].toString()]
                                              ['salary_min']
                                          .toString(),
                                      salType: myJobs['all'][myJobsList[i].toString()]
                                              ['salary_type']
                                          .toString(),
                                      link: myJobs['all'][myJobsList[i].toString()]
                                              ['link']
                                          .toString(),
                                      isHidePhone: (myJobs['all']
                                                      [myJobsList[i].toString()]
                                                  ['hide_phone'] ==
                                              0)
                                          ? false
                                          : true,
                                      isNegotiale: (myJobs['all']
                                                      [myJobsList[i].toString()]
                                                  ['negotiable'] ==
                                              0)
                                          ? false
                                          : true,
                                      mainCat: myJobs['all'][myJobsList[i].toString()]
                                              ['category']
                                          .toString(),
                                      phone: '',
                                      subCat: myJobs['all'][myJobsList[i].toString()]
                                              ['sub_category']
                                          .toString(),
                                      tags: myJobs['all'][myJobsList[i].toString()]['tag']
                                          .toString(),
                                      shortlistedAplicants: myJobs['all']
                                                  [myJobsList[i].toString()]
                                              ['shortlisted_applicants']
                                          .toString(),
                                      totalAplications: myJobs['all']
                                                  [myJobsList[i].toString()]
                                              ['total_applicants']
                                          .toString(),
                                      featured: myJobs['all'][myJobsList[i].toString()]
                                              ['featured']
                                          .toString(),
                                      highlight: myJobs['all'][myJobsList[i].toString()]
                                              ['highlight']
                                          .toString(),
                                      urgent: myJobs['all'][myJobsList[i].toString()]
                                              ['urgent']
                                          .toString(),
                                      isDotsShow: true,
                                    ),
                                  isDataLoadProgress
                                      ? CupertinoActivityIndicator(
                                          radius: 15,
                                        )
                                      : SizedBox(),

                                  SizedBox(
                                    height: 35.h,
                                  ),

                                  // JobsWidget(
                                  //   jobtype: "Urgent",
                                  //   description: '',
                                  //   location: '',
                                  //   shortlisted: '',
                                  //   title: '',
                                  //   views: '',
                                  // ),
                                  // SizedBox(
                                  //   height: 5.h,
                                  // ),
                                  // JobsWidget(
                                  //   jobtype: "Urgent",
                                  //   description: '',
                                  //   location: '',
                                  //   shortlisted: '',
                                  //   title: '',
                                  //   views: '',
                                  // ),
                                ],
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
                child: EndDrawer(),
              ),
            ),
          ),
        ],
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
