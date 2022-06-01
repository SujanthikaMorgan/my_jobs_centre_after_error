// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jobs_center/Screens/Chats_Expanded.dart';
import 'package:my_jobs_center/Screens/jobDetails.dart';
import 'package:my_jobs_center/Screens/widget/favItemComponentWidget.dart';
import 'package:my_jobs_center/employer/employer%20screens/membership.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/empUnlock.dart';
import 'package:my_jobs_center/employer/widget/empUnlockNoLimit.dart';
import 'package:my_jobs_center/employer/widget/endDrawer.dart';
import 'package:my_jobs_center/employer/widget/exp.dart';
import 'package:my_jobs_center/employer/widget/profileShowInitialWidget.dart';
import 'package:http/http.dart' as http;
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_svg/flutter_svg.dart';

import '../../globalVariables.dart';

class EmployerProfileDisplay extends StatefulWidget {
  final String userId;
  const EmployerProfileDisplay({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<EmployerProfileDisplay> createState() => _EmployerProfileDisplayState();
}

class _EmployerProfileDisplayState extends State<EmployerProfileDisplay> {
  bool isUnlocked = false;
  String chatLimit = "0";
  Map checkUnlockResponse = {};
  Map checkUnlockResponse1 = {};
  Map userDataDisplayResponse = {};
  bool isSpin = true;
  Map alljobs = {};
  Map alljobs1 = {};
  var allJobsList = [];
  Map pageData = {};
  int offset = 1;
  List favIdsRec = [];
  Map favIdData = {};
  bool isAllJobsEmpty = false;
  bool isScrolling = true;
  late ScrollController _controller;
  bool isDataLoadProgress = false;
  Map followResponse = {};
  bool isFollowing = false;
  followUser() async {
    setState(() {
      isFollowing = true;
    });
    var url = Uri.parse(defaultUrl + 'mob_follow_user');
    var response = await http.post(url,
        body: json.encode({
          "userId": userDetailsResponse['id'],
          "favUserId": widget.userId,
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
          "favUserId": widget.userId,
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
        body:
            json.encode({"id": userDetailsResponse['id'], "fav_user_id": widget.userId}));
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) > 0) {
        setState(() {
          isFollowing = true;
        });
      }
    }
  }

  Future getUserData() async {
    // print(widget.recMap[widget.recList[widget.index].toString()]['id'].toString());
    var url = Uri.parse(defaultUrl + 'mob_user_details');

    var response = await http.post(url, body: json.encode({"user_id": widget.userId}));
    setState(() {
      userDataDisplayResponse = jsonDecode(response.body);
    });

    print(userDataDisplayResponse);

    // setState(() {
    //   isUnlocked = checkUnlockResponse["isUnlocked"];
    //   if (!isUnlocked) {
    //     chatLimit = checkUnlockResponse["chat_credit"];
    //   }
    // });
  }

  Future checkUnlock() async {
    // print(widget.recMap[widget.recList[widget.index].toString()]['id'].toString());
    var url = Uri.parse(defaultUrl + 'mob_isChat_unlocked');

    var response = await http.post(url,
        body: json.encode({
          "user_id": userDetailsResponse['id'],
          "contact_id": widget.userId,
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
          "contact_id": widget.userId,
        }));
    checkUnlockResponse1 = jsonDecode(response.body);
    print(checkUnlockResponse1);
  }

  Future gettingFavJobsIds() async {
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

  Future gettingAllJobs() async {
    var url = Uri.parse(defaultUrl + 'mob_company_jobs');
    setState(() {
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['user_id'] = widget.userId;
    });
    var response = await http.post(url, body: json.encode(pageData));
    // var response = await http.post(url);
    try {
      alljobs = jsonDecode(response.body);
      print(alljobs);
      alljobs['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print(allJobsList);
      print(alljobs['all'][allJobsList[0].toString()]);
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

  Future gettingAllJobsLoop() async {
    var url = Uri.parse(defaultUrl + 'mob_company_jobs');
    setState(() {
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['user_id'] = widget.userId;
    });
    var response = await http.post(url, body: json.encode(pageData));

    try {
      alljobs1 = jsonDecode(response.body);
      print(alljobs1);

      alljobs1['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print(allJobsList);
      alljobs['all'].addAll(alljobs1['all']);
      print(alljobs['all'][allJobsList[0].toString()]);
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
    var url = Uri.parse(defaultUrl + 'mob_company_jobs');
    setState(() {
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['user_id'] = widget.userId;
    });
    var response = await http.post(url, body: json.encode(pageData));

    try {
      alljobs1 = jsonDecode(response.body);
      print(alljobs1);

      alljobs1['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print(allJobsList);
      alljobs['all'].addAll(alljobs1['all']);
      print(alljobs['all'][allJobsList[0].toString()]);
    } on FormatException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
    setState(() {
      isDataLoadProgress = false;
    });
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    getUserData().then((value) {
      checkIsFollowing().then((value) {
        setState(() {
          isSpin = false;
        });
      });
    });

    gettingFavJobsIds();
    gettingAllJobs();
    super.initState();
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
                  child: Column(
                    children: [
                      ProfileShowInitialWidget(
                        city: userDataDisplayResponse['city'].toString(),
                        country: userDataDisplayResponse['country'].toString(),
                        createdAt: userDataDisplayResponse['created_at'].toString(),
                        imagePath: userDataDisplayResponse['image'].toString(),
                        mainCat: userDataDisplayResponse['category'].toString(),
                        name: userDataDisplayResponse['name'].toString(),
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
                                color: isFollowing
                                    ? Colors.red.shade700
                                    : Colors.grey.shade800,
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
                                                  opponId:
                                                      userDataDisplayResponse['user_id']
                                                          .toString(),
                                                )));
                                  } else {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return EmpUnlock(
                                          balanceCount: chatLimit,
                                          imagePath:
                                              userDataDisplayResponse['image'].toString(),
                                          name:
                                              userDataDisplayResponse['name'].toString(),
                                          onPressedUnlock: () {
                                            if (chatLimit == "0") {
                                              Navigator.pop(context);
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return EmpUnlockNoLimit(
                                                    imagePath:
                                                        userDataDisplayResponse['image']
                                                            .toString(),
                                                    name: userDataDisplayResponse['name']
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
                                                      opponId: userDataDisplayResponse[
                                                              'user_id']
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
                            ),
                          ),
                        ],
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
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "Description",
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
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
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
                            data: html2md.convert(
                                userDataDisplayResponse['description'].toString()),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
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
                                              [allJobsList[i].toString()]['company_name'],
                                          title: alljobs['all'][allJobsList[i].toString()]
                                              ['product_name'],
                                          city: alljobs['all'][allJobsList[i].toString()]
                                              ['location'],
                                          country: alljobs['all']
                                                  [allJobsList[i].toString()]['country']
                                              .toString(),
                                          type: alljobs['all'][allJobsList[i].toString()]
                                                  ['product_type']
                                              .toString(),
                                          date: alljobs['all'][allJobsList[i].toString()]
                                                  ['created_at']
                                              .toString(),
                                          view: alljobs['all'][allJobsList[i].toString()]
                                              ['view'],
                                          minSal: alljobs['all']
                                              [allJobsList[i].toString()]['salary_min'],
                                          maxSal: alljobs['all']
                                              [allJobsList[i].toString()]['salary_max'],
                                          // currency: currencyFeat[i]
                                          //     .toString(),
                                          salType: alljobs['all']
                                              [allJobsList[i].toString()]['salary_type'],
                                          description: alljobs['all']
                                              [allJobsList[i].toString()]['description'],
                                          img: alljobs['all'][allJobsList[i].toString()]
                                              ['company_image'],
                                          idChat: alljobs['all']
                                              [allJobsList[i].toString()]['user_id'],
                                          jobID: alljobs['all'][allJobsList[i].toString()]
                                              ['id'],
                                          isFav: favIdsRec.contains(alljobs['all']
                                              [allJobsList[i].toString()]['id']),
                                          link: alljobs['all'][allJobsList[i].toString()]
                                              ['link'],
                                        )));
                          },
                          child: FavItemComponentWidget(
                            isFav: favIdsRec.contains(
                                alljobs['all'][allJobsList[i].toString()]['id']),
                            // isFav: (favJobsIdsAlready
                            //         .contains(prodAdIddFeat[i]))
                            //     ? true
                            //     : false,

                            city: alljobs['all'][allJobsList[i].toString()]['location']
                                .toString(),
                            country: alljobs['all'][allJobsList[i].toString()]['country']
                                .toString(),
                            date: alljobs['all'][allJobsList[i].toString()]['created_at']
                                .toString(),
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
                            // currency:
                            //     currencyFeat[i].toString(),
                            prodID: alljobs['all'][allJobsList[i].toString()]
                                ['product_type'],
                            msgId: alljobs['all'][allJobsList[i].toString()]['user_id'],
                            jobId: alljobs['all'][allJobsList[i].toString()]['id'],
                            feature: alljobs['all'][allJobsList[i].toString()]['featured']
                                .toString(),
                            highlight: alljobs['all'][allJobsList[i].toString()]
                                    ['highlight']
                                .toString(),
                            urgent: alljobs['all'][allJobsList[i].toString()]['urgent']
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

const String badge =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 512 512"><rect x="0" y="0" width="512" height="512" fill="none" stroke="none" /><path fill="red" d="M328.375 384l3.698 74.999l-75.862-52.719l-76.287 52.769L183.625 384h-32.039l-5.522 112h36.692l73.413-50.78L329.242 496h36.694l-5.522-112h-32.039z"/><path fill="red" d="M415.409 154.914l-2.194-48.054L372.7 80.933l-25.932-40.519l-48.055-2.2L256 16.093l-42.713 22.126l-48.055 2.2L139.3 80.933L98.785 106.86l-2.194 48.054l-22.127 42.714l22.127 42.715l2.2 48.053l40.509 25.927l25.928 40.52l48.055 2.195L256 379.164l42.713-22.126l48.055-2.195l25.928-40.52l40.518-25.923l2.195-48.053l22.127-42.715zm-31.646 76.949L382 270.377l-32.475 20.78l-20.78 32.475l-38.515 1.76L256 343.125l-34.234-17.733l-38.515-1.76l-20.78-32.475L130 270.377l-1.759-38.514l-17.741-34.235l17.737-34.228L130 124.88l32.471-20.78l20.78-32.474l38.515-1.76L256 52.132l34.234 17.733l38.515 1.76l20.78 32.474L382 124.88l1.759 38.515l17.741 34.233z"/></svg>';
