// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jobs_center/Screens/Chats_Expanded.dart';
import 'package:my_jobs_center/employer/employer%20screens/membership.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/empUnlock.dart';
import 'package:my_jobs_center/employer/widget/empUnlockNoLimit.dart';
import 'package:my_jobs_center/employer/widget/endDrawer.dart';
import 'package:my_jobs_center/employer/widget/exp.dart';
import 'package:my_jobs_center/employer/widget/profileShowInitialWidget.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class AppliedUsersProfile extends StatefulWidget {
  final Map recMap;
  final List recList;
  final int index;
  final Map? experience;
  final String appliedId;
  final String fromTitle;
  const AppliedUsersProfile(
      {Key? key,
      required this.recMap,
      required this.recList,
      required this.index,
      this.experience,
      required this.appliedId,
      required this.fromTitle})
      : super(key: key);

  @override
  _AppliedUsersProfileState createState() => _AppliedUsersProfileState();
}

class _AppliedUsersProfileState extends State<AppliedUsersProfile> {
  File? file;
  Dio dio = new Dio();
  Map acceptResponse = {};
  Map rejectResponse = {};
  Map checkUnlockResponse = {};
  Map checkUnlockResponse1 = {};
  bool isUnlocked = false;
  String chatLimit = "0";
  bool showBottomSheet1 = false;
  bool showBottomSheet2 = false;
  Map followResponse = {};
  bool isFollowing = false;
  String jobUserId = "";
  String jobId = "";
  followUser() async {
    setState(() {
      isFollowing = true;
    });
    var url = Uri.parse(defaultUrl + 'mob_follow_user');
    var response = await http.post(url,
        body: json.encode({
          "userId": userDetailsResponse['id'],
          "favUserId": jobUserId,
          "isFollow": true
        }));
    print(response.body);
    if (response.statusCode != 200) {
      setState(() {
        isFollowing = false;
      });
      Fluttertoast.showToast(msg: "Failed following. Try again later");
    }
  }

  unfollowUser() async {
    setState(() {
      isFollowing = false;
    });
    var url = Uri.parse(defaultUrl + 'mob_follow_user');
    var response = await http.post(url,
        body: json.encode({
          "userId": userDetailsResponse['id'],
          "favUserId": jobUserId,
          "isFollow": false
        }));
    print(response.statusCode);
    if (response.statusCode != 200) {
      setState(() {
        isFollowing = true;
      });
      Fluttertoast.showToast(msg: "Failed following. Try again later");
    }
  }

  Future checkIsFollowing() async {
    print(userDetailsResponse['id']);
    var url = Uri.parse(defaultUrl + 'mob_check_is_follow');
    var response = await http.post(url,
        body: json.encode({"id": userDetailsResponse['id'], "fav_user_id": jobUserId}));
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) > 0) {
        setState(() {
          isFollowing = true;
        });
      }
    }
  }

  Future shortListCandidate() async {
    var url = Uri.parse(defaultUrl + 'mob_shortlist_cand');

    var response = await http.post(url,
        body: json.encode({
          "id": widget.appliedId,
          "status": "1",
          "userId": userDetailsResponse['id'],
          "appliedUserId": jobUserId,
          "jobId": jobId
        }));
    acceptResponse = jsonDecode(response.body);
    print(acceptResponse);
    if (acceptResponse['msg'] == 'Success') {
      Fluttertoast.showToast(msg: "Successfully added");
    }
  }

  Future rejectCandidate() async {
    var url = Uri.parse(defaultUrl + 'mob_shortlist_cand');

    var response = await http.post(url,
        body: json.encode({
          "id": widget.appliedId,
          "status": "2",
          "userId": userDetailsResponse['id'],
        }));
    rejectResponse = jsonDecode(response.body);
    print(rejectResponse);
    if (rejectResponse['msg'] == 'Success') {
      Fluttertoast.showToast(msg: "Successfully added");
    }
  }

  Future checkUnlock() async {
    print(widget.recMap[widget.recList[widget.index].toString()]['user_id'].toString());
    var url = Uri.parse(defaultUrl + 'mob_isChat_unlocked');

    var response = await http.post(url,
        body: json.encode({
          "user_id": userDetailsResponse['id'],
          "contact_id": widget.recMap[widget.recList[widget.index].toString()]['user_id']
              .toString(),
        }));
    checkUnlockResponse = jsonDecode(response.body);
    print(checkUnlockResponse);

    setState(() {
      isUnlocked = checkUnlockResponse["isUnlocked"];
      if (!isUnlocked) {
        chatLimit = checkUnlockResponse["chat_credit"];
      }
    });
  }

  Future unlockChat() async {
    var url = Uri.parse(defaultUrl + 'mob_unlock_chat');

    var response = await http.post(url,
        body: json.encode({
          "user_id": userDetailsResponse['id'],
          "contact_id": widget.recMap[widget.recList[widget.index].toString()]['user_id']
              .toString(),
        }));
    checkUnlockResponse1 = jsonDecode(response.body);
    print(checkUnlockResponse1);
  }

  @override
  void initState() {
    print(widget.recMap[widget.recList[widget.index].toString()]['username'].toString());
    setState(() {
      jobUserId =
          widget.recMap[widget.recList[widget.index].toString()]['user_id'].toString();
      jobId = widget.recMap[widget.recList[widget.index].toString()]['job_id'].toString();
    });
    checkIsFollowing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      endDrawer: SidemenuEmployer(),
      appBar: AppBar(
        backgroundColor: const Color(0xfff7f9fc), // f7f9fc
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Color(0xff1d1d1d)),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Profile",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ProfileShowInitialWidget(
                  city: widget.recMap[widget.recList[widget.index].toString()]['city']
                      .toString(),
                  country: widget.recMap[widget.recList[widget.index].toString()]
                          ['country']
                      .toString(),
                  createdAt: widget.recMap[widget.recList[widget.index].toString()]
                          ['created_at']
                      .toString(),
                  imagePath: widget.recMap[widget.recList[widget.index].toString()]
                          ['image']
                      .toString(),
                  mainCat: widget.recMap[widget.recList[widget.index].toString()]
                          ['category']
                      .toString(),
                  name: widget.recMap[widget.recList[widget.index].toString()]['name']
                      .toString(),
                  isBlocked: false,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: GestureDetector(
                        onTap: () {
                          isFollowing ? unfollowUser() : followUser();
                        },
                        child: Container(
                          width: 150.w,
                          height: 35.h,
                          color: isFollowing ? Colors.red.shade700 : Colors.grey.shade800,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 25.sp,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                isFollowing ? "Following" : "Follow",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        checkUnlock().then(
                          (value) {
                            if (isUnlocked) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chats_Expanded(
                                            opponId: widget.recMap[widget
                                                    .recList[widget.index]
                                                    .toString()]['user_id']
                                                .toString(),
                                          )));
                            } else {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return EmpUnlock(
                                    balanceCount: chatLimit,
                                    imagePath: widget
                                        .recMap[widget.recList[widget.index].toString()]
                                            ['image']
                                        .toString(),
                                    name: widget
                                        .recMap[widget.recList[widget.index].toString()]
                                            ['name']
                                        .toString(),
                                    onPressedUnlock: () {
                                      if (chatLimit == "0") {
                                        Navigator.pop(context);
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return EmpUnlockNoLimit(
                                              imagePath: widget.recMap[widget
                                                      .recList[widget.index]
                                                      .toString()]['image']
                                                  .toString(),
                                              name: widget.recMap[widget
                                                      .recList[widget.index]
                                                      .toString()]['name']
                                                  .toString(),
                                              onPressedMembership: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MembershipPage()),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      } else {
                                        unlockChat().then((value) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Chats_Expanded(
                                                opponId: widget.recMap[widget
                                                        .recList[widget.index]
                                                        .toString()]['user_id']
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        });
                                      }
                                    },
                                  );
                                },
                              );
                            }
                          },
                        );

                        // checkUnlock();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Container(
                          width: 150.w,
                          height: 35.h,
                          color: Colors.red.shade700,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15.w,
                              ),
                              Text(
                                "Chat or Call",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.white,
                                size: 25.sp,
                              ),
                            ],
                          ),
                        ),
                        // onTap: (){
                        // showCupertinoModalPopup<void>(
                        //     context: context,
                        //     builder: (BuildContext context)=>
                        // CupertinoActionSheet(
                        //   actions: <CupertinoActionSheetAction>[
                        //     CupertinoActionSheetAction(
                        //         onPressed: (){
                        //
                        //         },
                        //         child: Column(
                        //           children: [
                        //             Padding(
                        //                 padding: EdgeInsets.only(
                        //                   left: 15,
                        //                   right: 15,
                        //                   top: 8,
                        //                child:ClipRect(
                        //                  borderRadius: BorderRadius.circular(8.0),
                        //                  child: Image.network(
                        //                    subject['images']['large'],
                        //                    height: 150.0,
                        //                    width: 100.0,
                        //                  ),
                        //                )
                        //                 ))
                        //           ],
                        //         ))
                        //   ],
                        // ));
                        // },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 15,
                  ),
                  child: MarkdownBody(
                    selectable: true,
                    styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                        textTheme: TextTheme(
                            bodyText2: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      color: const Color(0xcc1d1d1d),
                      fontWeight: FontWeight.w400,
                      height: 1.4166666666666667.h,
                    )))),
                    data: html2md.convert(widget
                        .recMap[widget.recList[widget.index].toString()]['description']
                        .toString()),
                  ),
                  // Text(
                  //   "Online Grammar and Writing Checker To Help You Deliver Impeccable, Mistake-free Writing. Grammarly Has a Tool For Just About Every Kind Of Writing You Do.About Every Kind Of Writing You Do.",
                  //   maxLines: 4,
                  //   overflow: TextOverflow.ellipsis,
                  // style: TextStyle(
                  //   decoration: TextDecoration.none,
                  //   fontFamily: 'Poppins',
                  //   fontSize: 13.sp,
                  //   color: const Color(0xcc1d1d1d),
                  //   fontWeight: FontWeight.w400,
                  //   height: 1.4166666666666667.h,
                  // ),
                  //   textHeightBehavior: const TextHeightBehavior(
                  //       applyHeightToFirstAscent: false),
                  //   textAlign: TextAlign.justify,
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 15,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    color: Colors.grey.shade300,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40.w,
                        ),
                        SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: SvgPicture.string(
                            badge,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          "Experiences",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontSize: 15.sp,
                            color: const Color(0xcc1d1d1d),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                if (widget.experience != null)
                  for (int i = 0; i < widget.experience!.length; i++)
                    Exp(
                      experience: widget.experience!.values.elementAt(i),
                    ),
                if (widget.experience == null)
                  Text(
                    "No experiences",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: const Color(0xff132144),
                      fontWeight: FontWeight.w300,
                      height: 1.4166666666666667,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                  ),
                // Exp(),
                if (widget.fromTitle != "Shortlisted")
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 40),
                    child: Row(
                      children: [
                        Container(
                          width: 150.w,
                          height: 35.h,
                          color: Colors.grey.shade200,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 50),
                            child: GestureDetector(
                              child: Text(
                                "Reject",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () {
                                rejectCandidate();
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 150.w,
                          height: 35.h,
                          color: Colors.green.shade400,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 50),
                            child: GestureDetector(
                              child: Text(
                                "Shortlist",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () {
                                shortListCandidate();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 100,
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

const String badge =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 512 512"><rect x="0" y="0" width="512" height="512" fill="none" stroke="none" /><path fill="red" d="M328.375 384l3.698 74.999l-75.862-52.719l-76.287 52.769L183.625 384h-32.039l-5.522 112h36.692l73.413-50.78L329.242 496h36.694l-5.522-112h-32.039z"/><path fill="red" d="M415.409 154.914l-2.194-48.054L372.7 80.933l-25.932-40.519l-48.055-2.2L256 16.093l-42.713 22.126l-48.055 2.2L139.3 80.933L98.785 106.86l-2.194 48.054l-22.127 42.714l22.127 42.715l2.2 48.053l40.509 25.927l25.928 40.52l48.055 2.195L256 379.164l42.713-22.126l48.055-2.195l25.928-40.52l40.518-25.923l2.195-48.053l22.127-42.715zm-31.646 76.949L382 270.377l-32.475 20.78l-20.78 32.475l-38.515 1.76L256 343.125l-34.234-17.733l-38.515-1.76l-20.78-32.475L130 270.377l-1.759-38.514l-17.741-34.235l17.737-34.228L130 124.88l32.471-20.78l20.78-32.474l38.515-1.76L256 52.132l34.234 17.733l38.515 1.76l20.78 32.474L382 124.88l1.759 38.515l17.741 34.233z"/></svg>';
