// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/alljobswidget.dart';
import 'package:my_jobs_center/employer/widget/employerbrief.dart';
import 'package:my_jobs_center/employer/widget/endDrawer.dart';
// import 'package:myjobscentre_employee/sidemenuEmployer.dart';
// import 'package:myjobscentre_employee/widget/alljobswidget.dart';
// import 'package:myjobscentre_employee/widget/applicantbrief.dart';
// import 'package:myjobscentre_employee/widget/employerbrief.dart';
// import 'package:myjobscentre_employee/widget/endDrawer.dart';

class Employer extends StatefulWidget {
  static const String idScreen = "Employer";
  const Employer({Key? key}) : super(key: key);

  @override
  _EmployerState createState() => _EmployerState();
}

class _EmployerState extends State<Employer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff7f9fc),
        endDrawer: SidemenuEmployer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xffdd312d)),
          backgroundColor: const Color(0xfff7f9fc),
          elevation: 0,
          titleSpacing: 0,
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
                  EmployerBrief(),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Container(
                          width: 150.w,
                          height: 35.h,
                          color: Colors.grey.shade800,
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
                                "Follow",
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
                      Padding(
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
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 20,
                        right: 15,
                      ),
                      child: Text(
                        "Online Grammar and Writing Checker To Help You Deliver Impeccable, Mistake-free Writing. Grammarly Has a Tool For Just About Every Kind Of Writing You Do.About Every Kind Of Writing You Do.",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                          color: const Color(0xcc1d1d1d),
                          fontWeight: FontWeight.w400,
                          height: 1.4166666666666667.h,
                          letterSpacing: 0.3,
                        ),
                        textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent: false),
                        textAlign: TextAlign.justify,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 170.w,
                          height: 40.h,
                          color: Colors.grey.shade200,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 13, left: 50),
                            child: GestureDetector(
                              child: Text(
                                "All Jobs",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                        Container(
                          width: 170.w,
                          height: 40.h,
                          color: Colors.grey.shade200,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 13, left: 50),
                            child: GestureDetector(
                              child: Text(
                                "All Companies",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AllJobsWidget(),
                  AllJobsWidget(),
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
      ),
    );
  }
}
