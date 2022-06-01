// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_jobs_center/employer/employer%20screens/notselected.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/applicantsList_Widget.dart';
import 'package:my_jobs_center/employer/widget/endDrawer.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:http/http.dart' as http;

// import 'package:myjobscentre_employee/sidemenuEmployer.dart';
// import 'package:myjobscentre_employee/widget/applicantsList_Widget.dart';
// import 'package:myjobscentre_employee/widget/endDrawer.dart';

class Applicants extends StatefulWidget {
  static const String idScreen = "applicants";
  final String jobId;
  final String prodName;
  const Applicants({Key? key, required this.jobId, required this.prodName})
      : super(key: key);

  @override
  _ApplicantsState createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {
  Map pageData = {};
  int offset = 1;
  Map allJobs = {};
  var pendingJobsList = [];
  var shortListedJobsList = [];
  var rejectedListedJobsList = [];
  var blockedListedJobsList = [];
  bool isAllJobsEmpty = false;
  bool isSpin = true;
  int pendingCount = 0;
  int shortlistCount = 0;
  int notSelCount = 0;
  int blockedCount = 0;

  Future gettingAllJobseekers() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_all_jobs');
    var url = Uri.parse(defaultUrl + 'mob_user_applied');

    // Starting Web API Call.
    setState(() {
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['id'] = widget.jobId;
      pageData['country'] = userDetailsResponse['country_code'];
    });
    var response = await http.post(url, body: json.encode(pageData));
    try {
      allJobs = jsonDecode(response.body);
      print(allJobs);
      if (allJobs['pending'].length != 0) {
        allJobs['pending'].forEach((k, v) => pendingJobsList.add(Applied(k)));
        print("-------------------------------------------------");
        print(pendingJobsList);
        print("-------------------------------------------------");
        print('---------------pending----------------');
        print(allJobs['pending'][pendingJobsList[0].toString()]);
        print("-------------------------------------------------");
        print("pendinggggggggggggggggggggggggggggggggggg");
        print(allJobs["pending"]);
      }

      //---------------------selected---------

      if (allJobs['shortList'].length != 0) {
        allJobs['shortList'].forEach((k, v) => shortListedJobsList.add(Applied(k)));
      }

      //------------rejected-------------------
      if (allJobs['notSel'].length != 0) {
        allJobs['notSel'].forEach((k, v) => rejectedListedJobsList.add(Applied(k)));
      }

      //------------rejected-------------------
      if (allJobs['blocked'].length != 0) {
        allJobs['blocked'].forEach((k, v) => blockedListedJobsList.add(Applied(k)));
      }

      setState(() {
        pendingCount = allJobs['count_pen'];
        shortlistCount = allJobs['count_short'];
        notSelCount = allJobs['count_notSel'];
        blockedCount = allJobs['count_blocked'];
      });
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

  @override
  void initState() {
    gettingAllJobseekers();
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
          title: Column(
            children: [
              Text(
                "Applicants",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                widget.prodName,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  color: const Color(0xff1d1d1d),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )),
      body: isSpin
          ? Center(
              child: CupertinoActivityIndicator(
                animating: isSpin,
                radius: 20,
              ),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotSelected(
                                        recMap: (pendingJobsList.length != 0)
                                            ? allJobs['pending']
                                            : null,
                                        recList: pendingJobsList,
                                        title: 'Pending',
                                      )));
                        },
                        child: ApplicantsListWidget(
                          type: "Pending",
                          amount: pendingCount.toString(),
                          clr: Colors.white,
                          notify: " ",
                          userDetKeys: pendingJobsList,
                          userDetMap:
                              (pendingJobsList.length != 0) ? allJobs['pending'] : null,
                        ),
                      ),
                      // clr: Colors.blue.shade900,
                      // notify: "4 new"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotSelected(
                                        recMap: (rejectedListedJobsList.length != 0)
                                            ? allJobs['notSel']
                                            : null,
                                        recList: rejectedListedJobsList,
                                        title: 'Not Selected',
                                      )));
                        },
                        child: ApplicantsListWidget(
                          type: "Not Selected",
                          amount: notSelCount.toString(),
                          clr: Colors.white,
                          notify: " ",
                          userDetMap: (rejectedListedJobsList.length != 0)
                              ? allJobs['notSel']
                              : null,
                          userDetKeys: rejectedListedJobsList,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotSelected(
                                        recMap: (shortListedJobsList.length != 0)
                                            ? allJobs['shortList']
                                            : null,
                                        recList: shortListedJobsList,
                                        title: 'Shortlisted',
                                      )));
                        },
                        child: ApplicantsListWidget(
                          type: "Shortlisted",
                          amount: shortlistCount.toString(),
                          clr: Colors.white,
                          notify: " ",
                          userDetMap: (shortListedJobsList.length != 0)
                              ? allJobs['shortList']
                              : null,
                          userDetKeys: shortListedJobsList,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotSelected(
                                        recMap: (blockedListedJobsList.length != 0)
                                            ? allJobs['blocked']
                                            : null,
                                        recList: blockedListedJobsList,
                                        title: 'Blocked',
                                      )));
                        },
                        child: ApplicantsListWidget(
                          type: "Blocked",
                          amount: blockedCount.toString(),
                          clr: Colors.white,
                          notify: " ",
                          userDetKeys: blockedListedJobsList,
                          userDetMap: (blockedListedJobsList.length != 0)
                              ? allJobs['blocked']
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
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
