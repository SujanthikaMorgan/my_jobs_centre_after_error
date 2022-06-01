// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_jobs_center/globalVariables.dart';

class ApplicantBrief extends StatelessWidget {
  final String imgPath;
  final String city;
  final String name;
  final Map? experienceMap;
  const ApplicantBrief(
      {Key? key,
      required this.imgPath,
      required this.city,
      required this.name,
      this.experienceMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
      child: Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          maxWidth: MediaQuery.of(context).size.width,
          minHeight: 135.h,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xfff7f9fc),
          ),
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 85.h,
                              width: 85.w,
                              child: Image(
                                image: NetworkImage(
                                  "$profImgLink${imgPath}",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: 12.w,
                                height: 12.h,
                                child: SvgPicture.string(
                                  tick,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              )
                            ],
                          ),
                          Text(
                            (city == "null") ? "No location provided" : city,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontSize: 11.sp,
                              color: const Color(0xff788198),
                              fontWeight: FontWeight.w400,
                              //height: 1.4166666666666667.h,
                            ),
                            textHeightBehavior:
                                const TextHeightBehavior(applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  color: Colors.blue.shade900,
                                  size: 20.sp,
                                ),
                                Text(
                                  " Great Match",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 13.sp,
                                    color: const Color(0xff788198),
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Column(
                              children: [
                                if (experienceMap != null)
                                  for (int i = 0; i < experienceMap!.length; i++)
                                    RichText(
                                      text: TextSpan(
                                          text:
                                              experienceMap!.values.elementAt(i)["title"],
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily: 'Poppins',
                                            fontSize: 13.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: " at " +
                                                  experienceMap!.values
                                                      .elementAt(i)["company"],
                                              style: TextStyle(
                                                decoration: TextDecoration.none,
                                                fontFamily: 'Poppins',
                                                fontSize: 12.sp,
                                                color: const Color(0xff788198),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ]),
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.star,
                        color: Color(0xfffbc02d),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const String tick =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><g fill="none"><path fill-rule="evenodd" clip-rule="evenodd" d="M10.054 2.344a3 3 0 0 1 3.892 0l1.271 1.084a1 1 0 0 0 .57.236l1.665.133a3 3 0 0 1 2.751 2.751l.133 1.666a1 1 0 0 0 .236.569l1.084 1.271a3 3 0 0 1 0 3.892l-1.084 1.271a1 1 0 0 0-.236.57l-.133 1.665a3 3 0 0 1-2.751 2.751l-1.666.133a1 1 0 0 0-.569.236l-1.271 1.084a3 3 0 0 1-3.892 0l-1.271-1.084a1 1 0 0 0-.57-.236l-1.665-.133a3 3 0 0 1-2.751-2.751l-.133-1.666a1 1 0 0 0-.236-.569l-1.084-1.271a3 3 0 0 1 0-3.892l1.084-1.271a1 1 0 0 0 .236-.57l.133-1.665a3 3 0 0 1 2.751-2.751l1.666-.133a1 1 0 0 0 .569-.236l1.271-1.084zm5.653 8.363a1 1 0 0 0-1.414-1.414L11 12.586l-1.293-1.293a1 1 0 0 0-1.414 1.414l2 2a1 1 0 0 0 1.414 0l4-4z" fill="blue"/></g></svg>';
