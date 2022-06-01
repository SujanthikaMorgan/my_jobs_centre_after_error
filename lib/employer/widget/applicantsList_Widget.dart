// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_jobs_center/globalVariables.dart';

class ApplicantsListWidget extends StatelessWidget {
  final String type;
  final String amount;
  final Color clr;
  final String notify;
  final List? userDetKeys;
  final Map? userDetMap;

  const ApplicantsListWidget({
    Key? key,
    required this.type,
    required this.amount,
    required this.clr,
    required this.notify,
    this.userDetKeys,
    this.userDetMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 110.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    type,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 170),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: clr,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          notify,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  child: Text(
                    amount,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (userDetMap != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (userDetKeys!.length < 5)
                        for (int i = 0; i < userDetKeys!.length; i++)
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              child: Image(
                                  image: NetworkImage(
                                "$profImgLink${userDetMap![userDetKeys![i].toString()]['image']}",
                              )),
                            ),
                          ),
                      if (userDetKeys!.length > 4)
                        for (int i = 0; i < 3; i++)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              child: Image(
                                  image: NetworkImage(
                                "$profImgLink${userDetMap![userDetKeys![i].toString()]['image']}",
                              )),
                            ),
                          ),
                      if (userDetKeys!.length > 4)
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Container(
                              height: 40.h,
                              width: 40.w,
                              color: Colors.grey,
                              child: Center(
                                child: Text(
                                  "+${userDetKeys!.length - 4}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                    ],
                  ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
