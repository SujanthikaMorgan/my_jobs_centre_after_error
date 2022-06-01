// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jobs_center/Screens/Chats_Expanded.dart';
import 'package:my_jobs_center/Screens/jobDetails.dart';
import 'package:my_jobs_center/employer/employer%20screens/applicants.dart';
import 'package:my_jobs_center/employer/employer%20screens/appliedUsersProfile.dart';
import 'package:my_jobs_center/employer/employer%20screens/employerProfileDisplay.dart';
import 'package:my_jobs_center/employer/employer%20screens/job.dart';
import 'package:my_jobs_center/employer/widget/endDrawer.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../Screens/Component34.dart';

class NotificationEmployee extends StatefulWidget {
  const NotificationEmployee({Key? key}) : super(key: key);

  @override
  _NotificationEmployeeState createState() => _NotificationEmployeeState();
}

class _NotificationEmployeeState extends State<NotificationEmployee> {
  final format = DateFormat('yyyy-MM-dd hh:mm');
  bool isError = false;
  bool isSpin = true;
  List notificationMap = [];
  Map selectedProduct = {};
  String selectedProductName = "";

  Future getNotifications() async {
    var url = Uri.parse(defaultUrl + 'mob_notifications');
    try {
      var response =
          await http.post(url, body: json.encode({"user_id": userDetailsResponse['id']}));
      notificationMap = jsonDecode(response.body);
      print(notificationMap.length);
    } catch (e) {
      print(e.toString());
      setState(() {
        isError = true;
      });
      // if (e == "type 'Null' is not a subtype of type 'List<dynamic>'") {
      //   print("empty");
      // } else {
      //   Fluttertoast.showToast(msg: "Something went wrong");
      // }
    }
  }

  markNotiAsRead(String notId) async {
    var url = Uri.parse(defaultUrl + 'mob_mark_notification_read');
    try {
      var response = await http.post(url, body: json.encode({"not_id": notId}));
    } catch (e) {}
  }

  Future getJobTitile(String jobId) async {
    var url = Uri.parse(defaultUrl + 'mob_get_job_name');
    try {
      var response = await http.post(url, body: json.encode({"id": jobId}));
      selectedProduct = jsonDecode(response.body);
      print(selectedProduct);
      setState(() {
        selectedProductName = selectedProduct["all"]["product_name"];
        isSpin = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Applicants(
            jobId: jobId.toString(),
            prodName: selectedProductName.toString(),
          ),
        ),
      ).then((value) {
        setState(() {
          isSpin = false;
        });
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future getSingleUser(String userName) async {
    var url = Uri.parse(defaultUrl + 'mob_get_single_user');
    try {
      var response = await http.post(url, body: json.encode({"user_name": userName}));
      selectedProduct = jsonDecode(response.body);
      print(selectedProduct);
      setState(() {
        isSpin = false;
      });

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => AppliedUsersProfile(
      //       recMap: recMap,
      //       recList: recList,
      //       index: index,
      //       jobId: jobId,
      //       fromTitle: fromTitle,
      //     ),
      //   ),
      // );
    } catch (e) {
      setState(() {
        isError = true;
      });
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future getSingleJob(String jobId) async {
    var url = Uri.parse(defaultUrl + 'mob_get_single_job');
    try {
      var response = await http.post(url, body: json.encode({"id": jobId}));
      selectedProduct = jsonDecode(response.body);
      print(selectedProduct);
      setState(() {
        isSpin = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JobDetailsScreen(
            isApplyShow: false,
            company: selectedProduct["all"]["company_name"].toString(),
            title: selectedProduct["all"]["product_name"].toString(),
            city: selectedProduct["all"]["city"].toString(),
            country: selectedProduct["all"]["country"].toString(),
            type: selectedProduct["all"]["product_type"].toString(),
            date: selectedProduct["all"]["created_at"].toString(),
            view: selectedProduct["all"]["view"].toString(),
            minSal: selectedProduct["all"]["salary_min"].toString(),
            maxSal: selectedProduct["all"]["salary_max"].toString(),
            salType: selectedProduct["all"]["salary_type"].toString(),
            description: selectedProduct["all"]["description"],
            img: selectedProduct["all"]["company_image"],
            idChat: '',
            jobID: selectedProduct["all"]["id"],
            isFav: true,
            link: selectedProduct["all"]["link"],
          ),
        ),
      ).then((value) {
        setState(() {
          isSpin = false;
        });
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  @override
  void initState() {
    getNotifications().then((value) {
      setState(() {
        isSpin = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Notifications",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: const Color(0xff1d1d1d),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xfff7f9fc),
        centerTitle: true,
      ),
      body: isSpin
          ? Center(
              child: CupertinoActivityIndicator(
                radius: 25,
                animating: isSpin,
              ),
            )
          : isError
              ? Center(
                  child: Text(
                    "No Notifications are there",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Poppins',
                      fontSize: 15.sp,
                      color: const Color(0xcc1d1d1d),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    ListView.builder(
                        itemCount: notificationMap.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.055,
                              backgroundImage: NetworkImage(
                                  profImgLink + notificationMap[index]['profile_image']),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // 'Chris Jacob',
                                  notificationMap[index]['name'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context).size.width * 0.045,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  notificationMap[index]['created_at'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context).size.width * 0.03,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  notificationMap[index]['type'] == "FAV_USER"
                                      ? 'Added you to favourites'
                                      : notificationMap[index]['type'] == "SHORTLIST"
                                          ? 'Has shortlisted you'
                                          : notificationMap[index]['type'] ==
                                                  "APPLIED_JOBS"
                                              ? 'Has applied for the job'
                                              : notificationMap[index]['type'] ==
                                                      "NEW_MSG"
                                                  ? "Has sent you a message"
                                                  : "",
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: MediaQuery.of(context).size.width * 0.035,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                if (notificationMap[index]['seen'] == '0')
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.red.shade700,
                                  )
                              ],
                            ),
                            onTap: () {
                              markNotiAsRead(notificationMap[index]['id']);
                              if (notificationMap[index]['type'] == "APPLIED_JOBS") {
                                setState(() {
                                  isSpin = true;
                                });
                                getJobTitile(notificationMap[index]
                                    ['product_id']); //Need to find the user
                              } else if (notificationMap[index]['type'] == "SHORTLIST") {
                                setState(() {
                                  isSpin = true;
                                });
                                getSingleJob(notificationMap[index]['product_id']);
                              } else if (notificationMap[index]['type'] == "FAV_USER") {
                                setState(() {
                                  isSpin = true;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmployerProfileDisplay(
                                      userId: notificationMap[index]["user_id"],
                                    ),
                                  ),
                                ).then((value) {
                                  setState(() {
                                    isSpin = false;
                                  });
                                });
                              } else if (notificationMap[index]['type'] == "NEW_MSG") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Chats_Expanded(
                                              opponId: notificationMap[index]["user_id"],
                                            )));
                              }
                            },
                          );
                        }),
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
    );
  }
}
