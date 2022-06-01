// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_jobs_center/employer/employer%20screens/appliedUsersProfile.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/applicantbrief.dart';
import 'package:my_jobs_center/employer/widget/endDrawer.dart';
// import 'package:myjobscentre_employee/sidemenuEmployer.dart';
// import 'package:myjobscentre_employee/widget/applicantbrief.dart';
// import 'package:myjobscentre_employee/widget/endDrawer.dart';

class NotSelected extends StatefulWidget {
  static const String idScreen = "NotSelected";

  final Map? recMap;
  final List? recList;
  final String title;
  const NotSelected({
    Key? key,
    this.recMap,
    this.recList,
    required this.title,
  }) : super(key: key);

  @override
  _NotSelectedState createState() => _NotSelectedState();
}

class _NotSelectedState extends State<NotSelected> {
  @override
  void initState() {
    // print(widget.recMap![widget.recList![0].toString()]['user_id']);
    super.initState();
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
          widget.title,
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
                if (widget.recList != null)
                  for (int i = 0; i < widget.recList!.length; i++)
                    GestureDetector(
                      child: ApplicantBrief(
                        city: widget.recMap![widget.recList![i].toString()]['city']
                            .toString(),
                        imgPath: widget.recMap![widget.recList![i].toString()]['image']
                            .toString(),
                        name: widget.recMap![widget.recList![i].toString()]['name']
                            .toString(),
                        experienceMap: widget.recMap![widget.recList![i].toString()]
                            ['experience'],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppliedUsersProfile(
                                      recMap: widget.recMap!,
                                      recList: widget.recList!,
                                      index: i,
                                      experience:
                                          widget.recMap![widget.recList![i].toString()]
                                              ['experience'],
                                      appliedId: widget
                                          .recMap![widget.recList![i].toString()]["id"],
                                      fromTitle: widget.title,
                                    )));
                      },
                    ),
                if (widget.recMap == null)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "No Applicants",
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
                    ),
                  ),
                // GestureDetector(
                //   child: ApplicantBrief(),
                //   onTap: () {},
                // ),
                // GestureDetector(
                //   child: ApplicantBrief(),
                //   onTap: () {},
                // ),
                // GestureDetector(
                //   child: ApplicantBrief(),
                //   onTap: () {},
                // ),
                // GestureDetector(
                //   child: ApplicantBrief(),
                //   onTap: () {},
                // ),
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
