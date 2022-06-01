// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_jobs_center/employer/employer%20screens/applicantsdetails.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:html2md/html2md.dart' as html2md;

class JobSeekerPreviewWidget extends StatefulWidget {
  final String name;
  final String tagline;
  final String createdAt;
  final String description;
  final String mainCat;
  final String city;
  final String country;
  final String minSal;
  final String maxSal;
  // final String salType;
  final String imagePath;
  final experience;
  final String userId;
  final bool isBlocked;
  final String userName;
  const JobSeekerPreviewWidget({
    Key? key,
    required this.name,
    required this.tagline,
    required this.createdAt,
    required this.description,
    required this.mainCat,
    required this.city,
    required this.minSal,
    required this.imagePath,
    required this.maxSal,
    // required this.salType,
    required this.country,
    required this.experience,
    required this.userId,
    required this.isBlocked,
    required this.userName,
  }) : super(key: key);

  @override
  _JobSeekerPreviewWidgetState createState() => _JobSeekerPreviewWidgetState();
}

class _JobSeekerPreviewWidgetState extends State<JobSeekerPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 15,
        left: 10,
        right: 10,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ApplicantDetails(
                        city: widget.city,
                        country: widget.country,
                        createdAt: widget.createdAt,
                        imagePath: widget.imagePath,
                        mainCat: widget.mainCat,
                        name: widget.name,
                        description: widget.description,
                        experience: widget.experience,
                        userID: widget.userId,
                        userName: widget.userName,
                      )));
        },
        child: widget.isBlocked
            ? Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xfff7f9fc),
                  ),
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                      height: 75,
                                      width: 75,
                                      // color: const Color(0xff707070),

                                      child: Image(
                                        image: NetworkImage(
                                          profImgLink + "default_user.png",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      widget.name,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: Color(0xffC61800),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      " ",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: Color(0xff132144),
                                        // fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      // Icon(
                                      //   Icons.access_time,
                                      //   color: Color(0xffC61800),
                                      //   size: 20,
                                      // ),
                                      Text(
                                        " ",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: const Color(0xff132144),
                                          fontWeight: FontWeight.w300,
                                          height: 1.4166666666666667,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Spacer(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  " ",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: const Color(0xcc1d1d1d),
                                    fontWeight: FontWeight.w300,
                                    height: 1.4166666666666667,
                                  ),
                                  textHeightBehavior:
                                      TextHeightBehavior(applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xfff7f9fc),
                  ),
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                      height: 75,
                                      width: 75,
                                      // color: const Color(0xff707070),

                                      child: Image(
                                        image: NetworkImage(
                                          "$profImgLink${widget.imagePath}",
                                        ),
                                      ),
                                      // child: CircleAvatar(
                                      //   backgroundColor: const Color(0xffffffff),
                                      //   backgroundImage: NetworkImage(
                                      //     "https://www.myjobscentre.com/storage/products/${img}",
                                      //   ),
                                      //   radius: 15,
                                      // ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      widget.name,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: Color(0xffC61800),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      widget.tagline,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: Color(0xff132144),
                                        // fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: Color(0xffC61800),
                                        size: 20,
                                      ),
                                      Text(
                                        " Member Since: " + widget.createdAt,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: const Color(0xff132144),
                                          fontWeight: FontWeight.w300,
                                          height: 1.4166666666666667,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Spacer(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.description.replaceAll(
                                      RegExp(r"<[^>]*>",
                                          multiLine: true, caseSensitive: true),
                                      ""),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: const Color(0xcc1d1d1d),
                                    fontWeight: FontWeight.w300,
                                    height: 1.4166666666666667,
                                  ),
                                  textHeightBehavior:
                                      TextHeightBehavior(applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: Colors.grey))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 18,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  widget.city + ' , ' + widget.country,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: const Color(0xff132144),
                                                    fontWeight: FontWeight.w300,
                                                    height: 1.4166666666666667,
                                                  ),
                                                  textHeightBehavior: TextHeightBehavior(
                                                      applyHeightToFirstAscent: false),
                                                  textAlign: TextAlign.left,
                                                  // overflow: TextOverflow.fade,
                                                  // maxLines: 1,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.credit_card,
                                                size: 18,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 8),
                                                child:

                                                    // Text(
                                                    MarkdownBody(
                                                  data: html2md.convert(
                                                      '${widget.minSal} - ${widget.maxSal}  '),
                                                  // '${widget.minSal} - ${widget.maxSal}  per ${widget.salType}'),
                                                ),
                                                // style: TextStyle(
                                                //   fontFamily: 'Poppins',
                                                //   fontSize: 14,
                                                //   color: const Color(0xffdd312d),
                                                //   fontWeight: FontWeight.w500,
                                                // ),
                                                // textAlign: TextAlign.left,
                                                // maxLines: 1,
                                                // ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.folder_outlined,
                                                size: 18,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  widget.mainCat,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: const Color(0xff132144),
                                                    fontWeight: FontWeight.w300,
                                                    height: 1.4166666666666667,
                                                  ),
                                                  textHeightBehavior: TextHeightBehavior(
                                                      applyHeightToFirstAscent: false),
                                                  textAlign: TextAlign.left,
                                                  maxLines: 1,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
