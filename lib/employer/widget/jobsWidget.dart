// ignore_for_file: avoid_unnecessary_containers, file_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jobs_center/Screens/jobDetails.dart';
import 'package:my_jobs_center/employer/employer%20screens/editJobs.dart';
import 'package:my_jobs_center/employer/employer%20screens/jobPost.dart';
import 'package:my_jobs_center/employer/employer%20screens/myJobDetailScreen.dart';
import 'package:my_jobs_center/employer/employer%20screens/promotePage.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

import '../employer screens/applicants.dart';

// import 'package:myjobscentre_employee/widget/menu.dart';

class JobsWidget extends StatefulWidget {
  static const String idScreen = "jobswidget";

  final String jobtype;
  final String title;
  final String description;
  // final String location;
  final String shortlisted;
  final String views;
  final String company;
  // final String type;
  final String date;
  final String minSal;
  final String maxSal;
  final String salType;
  final String img;
  final String jobID;
  final String city;
  final String country;
  final String link;
  final String mainCat;
  final String subCat;
  final bool isNegotiale;
  final String phone;
  final bool isHidePhone;
  final String tags;
  final String totalAplications;
  final String shortlistedAplicants;
  final String highlight;
  final String urgent;
  final String featured;
  final bool isDotsShow;

  const JobsWidget({
    Key? key,
    required this.jobtype,
    // required this.type,
    required this.company,
    required this.title,
    required this.date,
    required this.description,
    // required this.location,
    required this.shortlisted,
    required this.minSal,
    required this.maxSal,
    required this.salType,
    required this.img,
    required this.jobID,
    required this.views,
    required this.city,
    required this.country,
    required this.link,
    required this.mainCat,
    required this.subCat,
    required this.isNegotiale,
    required this.phone,
    required this.isHidePhone,
    required this.tags,
    required this.totalAplications,
    required this.shortlistedAplicants,
    required this.highlight,
    required this.urgent,
    required this.featured,
    required this.isDotsShow,
  }) : super(key: key);

  @override
  _JobsWidgetState createState() => _JobsWidgetState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _JobsWidgetState extends State<JobsWidget> {
  String dropdownval = ' ';
  var items = [
    " ",
    'Preview',
    'Edit',
    'Promote',
    'Duplicate',
    'Share',
    'Close the job',
    'Cancel'
  ];
  bool isDropVisible = false;

  bool isSpin = false;

  Future closeTheJob() async {
    setState(() {
      isSpin = true;
    });
    // var urrr = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_login');
    var urrr = Uri.parse(defaultUrl + 'mob_close_job');

    // Store all data with Param Name.
    var data = {'job_id': widget.jobID};

    // Starting Web API Call.
    var response = await http.post(urrr, body: json.encode(data));

    // Getting Server response into variable.
    print(response.body.toString());
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      setState(() {
        isSpin = false;
      });
      Fluttertoast.showToast(msg: "Sccessfully closed the Job");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => JobPost()));
    } else {
      setState(() {
        isSpin = false;
      });
      Fluttertoast.showToast(
          msg: "Something went wrong. (Error: ${response.statusCode})");
    }

    // If the Response Message is Matched.
    // if (jsonDecode(response.body)['msg'] == 'Login Matched') {}
  }

  Future duplicateTheJob() async {
    setState(() {
      isSpin = true;
    });
    // var urrr = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_login');
    var urrr = Uri.parse(defaultUrl + 'mob_duplicate_job');

    // Store all data with Param Name.
    var data = {
      'username': userNameGlob,
      'password': password_glob,
      'job_id': widget.jobID
    };

    // Starting Web API Call.
    var response = await http.post(urrr, body: json.encode(data));

    // Getting Server response into variable.
    print(response.body.toString());
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      setState(() {
        isSpin = false;
      });
      Fluttertoast.showToast(msg: "Sccessfully duplicated the Job");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => JobPost()));
    } else {
      setState(() {
        isSpin = false;
      });
      Fluttertoast.showToast(
          msg: "Something went wrong. (Error: ${response.statusCode})");
    }

    // If the Response Message is Matched.
    // if (jsonDecode(response.body)['msg'] == 'Login Matched') {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xfff7f9fc),
          ),
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 1, 12, 12),
          child: Column(
            children: [
              if (widget.isDotsShow)
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 15, minHeight: 15),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          // isExpanded: false,
                          // isDense: false,
                          value: dropdownval,
                          icon: Icon(
                            Icons.more_horiz,
                          ),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value == "Preview") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JobDetailsScreen(
                                            isApplyShow: false,
                                            company: widget.company,
                                            title: widget.title,
                                            city: widget.city,
                                            country: widget.country,
                                            type: widget.jobtype,
                                            date: widget.date,
                                            view: widget.views,
                                            minSal: widget.minSal,
                                            maxSal: widget.maxSal,
                                            salType: widget.salType,
                                            description: widget.description,
                                            img: widget.img,
                                            // idChat: idChat,
                                            jobID: widget.jobID, idChat: '', isFav: false,
                                            link: widget.link,
                                          )));
                            } else if (value == "Share") {
                              Share.share(widget.link);
                            } else if (value == "Edit") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditJobs(
                                            mainCat: widget.mainCat,
                                            subCat: widget.subCat,
                                            title: widget.title,
                                            description: widget.description,
                                            jobType: widget.jobtype,
                                            salary: widget.salType,
                                            minSal: widget.minSal,
                                            maxSal: widget.maxSal,
                                            salType: widget.salType,
                                            isNegotiable: widget.isNegotiale,
                                            phone: widget.phone,
                                            isHidePhone: widget.isHidePhone,
                                            city: widget.city,
                                            applicationURL: widget.link,
                                            tags: widget.tags,
                                            jobId: widget.jobID,
                                          )));
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => EditJobs()));
                            } else if (value == 'Close the job') {
                              closeTheJob();
                            } else if (value == 'Duplicate') {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text(
                                    "Are you sure you want to duplicate this job?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                    ),
                                    child: Text(
                                      'This will count as a new job',
                                      style: TextStyle(
                                        color: Colors.grey[850],
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        'CANCEL',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        duplicateTheJob();
                                      },
                                      child: Text(
                                        'DUPLICATE',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (value == 'Promote') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PromotePage(
                                    jobtype: widget.jobtype,
                                    company: widget.company,
                                    title: widget.title,
                                    date: widget.date,
                                    description: widget.description,
                                    shortlisted: widget.shortlisted,
                                    minSal: widget.minSal,
                                    maxSal: widget.maxSal,
                                    salType: widget.salType,
                                    img: widget.img,
                                    jobID: widget.jobID,
                                    views: widget.views,
                                    city: widget.city,
                                    country: widget.country,
                                    link: widget.link,
                                    mainCat: widget.mainCat,
                                    subCat: widget.subCat,
                                    isNegotiale: widget.isNegotiale,
                                    phone: widget.phone,
                                    isHidePhone: widget.isHidePhone,
                                    tags: widget.tags,
                                    totalAplications: widget.totalAplications,
                                    shortlistedAplicants: widget.shortlistedAplicants,
                                    feature: widget.featured,
                                    highlight: widget.highlight,
                                    urgent: widget.urgent,
                                  ),
                                ),
                              );
                            }
                            // setState(() {
                            //   isDropVisible = false;
                            // });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Applicants(
                                jobId: widget.jobID.toString(),
                                prodName: widget.title.toString(),
                              )));
                },
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
                                    height: 75.h,
                                    width: 75.w,
                                    child: Image(
                                      image: NetworkImage(
                                        "https://www.myjobscentre.com/storage/products/${widget.img}",
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
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    widget.title,
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: 'Poppins',
                                      fontSize: 16.sp,
                                      color: const Color(0xff132144),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
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
                                          textHeightBehavior: TextHeightBehavior(
                                              applyHeightToFirstAscent: false),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Spacer(),

                          // Visibility(
                          //   visible: !isDropVisible,
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       setState(() {
                          //         isDropVisible = true;
                          //       });
                          //     },
                          //     child: Icon(
                          //       Icons.more_horiz,
                          //     ),
                          //   ),
                          // ),

                          /* GestureDetector(
                            onTap: () {
                              menuItems;
                            },
                            child: const Icon(
                              Icons.more_horiz_sharp,
                            ),
                          ),
                        */
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (widget.city != "null" && widget.country != "null")
                                  ? widget.city + ", " + widget.country
                                  : (widget.city == "null" && widget.country == "null")
                                      ? " "
                                      : (widget.city == "null")
                                          ? widget.country
                                          : widget.city,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'Poppins',
                                fontSize: 13.sp,
                                color: const Color(0xcc1d1d1d),
                                fontWeight: FontWeight.w300,
                                height: 1.4166666666666667.h,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                widget.jobtype,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
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
                      Container(
                        decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.people_outline,
                                        size: 18.sp,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        "Shortlisted  ",
                                        style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontFamily: 'Poppins',
                                          fontSize: 13.sp,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4166666666666667.h,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        (widget.totalAplications == 'null')
                                            ? "0/0"
                                            : (widget.shortlistedAplicants == 'null')
                                                ? "0/${widget.totalAplications}"
                                                : "${widget.shortlistedAplicants}/${widget.totalAplications}",
                                        style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontFamily: 'Poppins',
                                          fontSize: 13.sp,
                                          color: const Color(0xff132144),
                                          fontWeight: FontWeight.w500,
                                          height: 1.4166666666666667.h,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.remove_red_eye_outlined,
                                        size: 18.sp,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        widget.views,
                                        style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontFamily: 'Poppins',
                                          fontSize: 13.sp,
                                          color: const Color(0xff132144),
                                          fontWeight: FontWeight.w500,
                                          height: 1.4166666666666667.h,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const String _svg_c4sj =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(6.85, 5.58)" d="M 2.152499914169312 5.055000305175781 C 0.55205237865448 5.055000305175781 -0.7500001192092896 3.752947568893433 -0.7500001192092896 2.152500152587891 C -0.7500001192092896 0.5520526170730591 0.55205237865448 -0.7499998807907104 2.152499914169312 -0.7499998807907104 C 3.752947568893433 -0.7499998807907104 5.054999828338623 0.5520526170730591 5.054999828338623 2.152500152587891 C 5.054999828338623 3.752947568893433 3.752947568893433 5.055000305175781 2.152499914169312 5.055000305175781 Z M 2.152499914169312 0.3750001490116119 C 1.172384858131409 0.3750001490116119 0.3749998509883881 1.172385096549988 0.3749998509883881 2.152500152587891 C 0.3749998509883881 3.132615089416504 1.172384858131409 3.930000305175781 2.152499914169312 3.930000305175781 C 3.132614850997925 3.930000305175781 3.929999828338623 3.132615089416504 3.929999828338623 2.152500152587891 C 3.929999828338623 1.172385096549988 3.132614850997925 0.3750001490116119 2.152499914169312 0.3750001490116119 Z" fill="#132144" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(2.72, 1.69)" d="M 6.277542114257812 -0.7499980926513672 C 7.818814754486084 -0.7499980926513672 9.323351860046387 -0.2796645164489746 10.51400661468506 0.5743680000305176 C 11.83883666992188 1.524632453918457 12.7376070022583 2.903995275497437 13.11316204071045 4.563332080841064 C 13.52897644042969 6.400157451629639 13.28246593475342 8.272720336914062 12.38047122955322 10.12896919250488 C 11.71397686004639 11.50057792663574 10.70081615447998 12.84443473815918 9.369146347045898 14.12322235107422 C 8.535671234130859 14.92767906188965 7.437732219696045 15.37125205993652 6.278599262237549 15.37125205993652 C 5.119992256164551 15.37125205993652 4.02040958404541 14.92801666259766 3.182404279708862 14.12319946289062 C 1.853629469871521 12.84256744384766 0.8428465127944946 11.49751663208008 0.1774319112300873 10.12472343444824 C -0.7236558198928833 8.265737533569336 -0.9697753190994263 6.392087459564209 -0.5540801286697388 4.555809497833252 C -0.1769429743289948 2.897942066192627 0.7219690084457397 1.520552635192871 2.045606851577759 0.571967601776123 C 3.235151529312134 -0.280512809753418 4.738084316253662 -0.7499980926513672 6.277542114257812 -0.7499980926513672 Z M 6.278599262237549 14.24625205993652 C 7.144729614257812 14.24625205993652 7.965214252471924 13.91473770141602 8.588899612426758 13.31277275085449 C 10.59483337402344 11.38649559020996 12.81667900085449 8.348964691162109 12.01591968536377 4.811694622039795 C 11.27475357055664 1.536947727203369 8.46147346496582 0.3750019073486328 6.277542114257812 0.3750019073486328 C 4.097029209136963 0.3750019073486328 1.286809325218201 1.535139560699463 0.543026328086853 4.80477237701416 C -0.2575151026248932 8.341081619262695 1.960609555244446 11.38323974609375 3.962382078170776 13.31248664855957 C 4.589104175567627 13.91439247131348 5.41194486618042 14.24625205993652 6.278599262237549 14.24625205993652 Z" fill="#132144" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 18.0, 18.0)" d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ivigmg =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(1.69, 1.69)" d="M 7.3125 -0.75 C 11.75817775726318 -0.75 15.375 2.866822242736816 15.375 7.3125 C 15.375 11.75817775726318 11.75817775726318 15.375 7.3125 15.375 C 2.866822242736816 15.375 -0.75 11.75817775726318 -0.75 7.3125 C -0.75 2.866822242736816 2.866822242736816 -0.75 7.3125 -0.75 Z M 7.3125 14.25 C 11.13785171508789 14.25 14.25 11.13785171508789 14.25 7.3125 C 14.25 3.487147808074951 11.13785171508789 0.375 7.3125 0.375 C 3.487147808074951 0.375 0.375 3.487147808074951 0.375 7.3125 C 0.375 11.13785171508789 3.487147808074951 14.25 7.3125 14.25 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(8.91, 5.82)" d="M 2.871969699859619 6.127584457397461 C 2.773899555206299 6.127584457397461 2.674578666687012 6.101931571960449 2.584244966506958 6.048022270202637 L 0.2592449486255646 4.6605224609375 C -0.3154800534248352 4.319954872131348 -0.7500001192092896 3.557332515716553 -0.7500001192092896 2.887499809265137 L -0.7500001192092896 -0.1874999552965164 C -0.7500001192092896 -0.4981574416160583 -0.4981575608253479 -0.7499999403953552 -0.1875000596046448 -0.7499999403953552 C 0.1231574416160583 -0.7499999403953552 0.3749999105930328 -0.4981574416160583 0.3749999105930328 -0.1874999552965164 L 0.3749999105930328 2.887499809265137 C 0.3749999105930328 3.16194748878479 0.5981924533843994 3.553695201873779 0.834262490272522 3.69358491897583 L 3.160754680633545 5.081977367401123 C 3.4275221824646 5.241172790527344 3.514724731445312 5.586487293243408 3.355522632598877 5.853255271911621 C 3.250234603881836 6.029688835144043 3.063514709472656 6.127584457397461 2.871969699859619 6.127584457397461 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path  d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_h1s31m =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(0.94, 16.69)" d="M 16.3125 0.375 L -0.1875 0.375 C -0.4981575012207031 0.375 -0.75 0.1231575012207031 -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 L 16.3125 -0.75 C 16.6231575012207 -0.75 16.875 -0.4981575012207031 16.875 -0.1875 C 16.875 0.1231575012207031 16.6231575012207 0.375 16.3125 0.375 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(15.02, 13.35)" d="M -0.1875 3.720016002655029 C -0.4981575012207031 3.720016002655029 -0.75 3.468173265457153 -0.75 3.157516002655029 L -0.75 -0.1874990016222 C -0.75 -0.4981564879417419 -0.4981575012207031 -0.7499989867210388 -0.1875 -0.7499989867210388 C 0.1231575012207031 -0.7499989867210388 0.375 -0.4981564879417419 0.375 -0.1874990016222 L 0.375 3.157516002655029 C 0.375 3.468173265457153 0.1231575012207031 3.720016002655029 -0.1875 3.720016002655029 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(13.39, 8.36)" d="M 1.462509751319885 -0.7499985694885254 C 2.68248987197876 -0.7499985694885254 3.6750168800354 0.2425289154052734 3.6750168800354 1.462508797645569 L 3.6750168800354 3.164978981018066 C 3.6750168800354 4.38495922088623 2.68248987197876 5.377486705780029 1.462509751319885 5.377486705780029 C 0.2425296902656555 5.377486705780029 -0.749997615814209 4.38495922088623 -0.749997615814209 3.164978981018066 L -0.749997615814209 1.462508797645569 C -0.749997615814209 0.2425289154052734 0.2425296902656555 -0.7499985694885254 1.462509751319885 -0.7499985694885254 Z M 1.462509751319885 4.252486705780029 C 2.062164783477783 4.252486705780029 2.550017356872559 3.764633655548096 2.550017356872559 3.164978981018066 L 2.550017356872559 1.462508797645569 C 2.550017356872559 0.8628541231155396 2.062164783477783 0.3750014305114746 1.462509751319885 0.3750014305114746 C 0.8628547191619873 0.3750014305114746 0.3750022053718567 0.8628541231155396 0.3750022053718567 1.462508797645569 L 0.3750022053718567 3.164978981018066 C 0.3750022053718567 3.764633655548096 0.8628547191619873 4.252486705780029 1.462509751319885 4.252486705780029 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(1.76, 2.45)" d="M 8.96251106262207 14.61749744415283 C 8.651845932006836 14.61749744415283 8.40001106262207 14.36565494537354 8.40001106262207 14.05499744415283 L 8.40001106262207 2.077512502670288 C 8.40001106262207 0.8841651678085327 7.899828910827637 0.3750050961971283 6.727526664733887 0.3750050961971283 L 2.055041074752808 0.3750050961971283 C 0.8774435520172119 0.3750050961971283 0.3749961256980896 0.8841651678085327 0.3749961256980896 2.077512502670288 L 0.3749961256980896 14.05499744415283 C 0.3749961256980896 14.36565494537354 0.1231611222028732 14.61749744415283 -0.1875038892030716 14.61749744415283 C -0.4981613755226135 14.61749744415283 -0.7500038743019104 14.36565494537354 -0.7500038743019104 14.05499744415283 L -0.7500038743019104 2.077512502670288 C -0.7500038743019104 0.2541651427745819 0.2461836189031601 -0.7499948740005493 2.055041074752808 -0.7499948740005493 L 6.727526664733887 -0.7499948740005493 C 8.531508445739746 -0.7499948740005493 9.52501106262207 0.2541651427745819 9.52501106262207 2.077512502670288 L 9.52501106262207 14.05499744415283 C 9.52501106262207 14.36565494537354 9.273168563842773 14.61749744415283 8.96251106262207 14.61749744415283 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(4.54, 6.38)" d="M 3.52501106262207 0.375 L -0.1875038892030716 0.375 C -0.4981613755226135 0.375 -0.7500038743019104 0.1231575012207031 -0.7500038743019104 -0.1875 C -0.7500038743019104 -0.4981575012207031 -0.4981613755226135 -0.75 -0.1875038892030716 -0.75 L 3.52501106262207 -0.75 C 3.835668563842773 -0.75 4.08751106262207 -0.4981575012207031 4.08751106262207 -0.1875 C 4.08751106262207 0.1231575012207031 3.835668563842773 0.375 3.52501106262207 0.375 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(4.54, 9.19)" d="M 3.52501106262207 0.375 L -0.1875038892030716 0.375 C -0.4981613755226135 0.375 -0.7500038743019104 0.1231575012207031 -0.7500038743019104 -0.1875 C -0.7500038743019104 -0.4981575012207031 -0.4981613755226135 -0.75 -0.1875038892030716 -0.75 L 3.52501106262207 -0.75 C 3.835668563842773 -0.75 4.08751106262207 -0.4981575012207031 4.08751106262207 -0.1875 C 4.08751106262207 0.1231575012207031 3.835668563842773 0.375 3.52501106262207 0.375 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(6.38, 13.88)" d="M -0.1875 3.1875 C -0.4981575012207031 3.1875 -0.75 2.935657501220703 -0.75 2.625 L -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 C 0.1231575012207031 -0.75 0.375 -0.4981575012207031 0.375 -0.1875 L 0.375 2.625 C 0.375 2.935657501220703 0.1231575012207031 3.1875 -0.1875 3.1875 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path  d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_t7ogaf =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(6.19, 1.69)" d="M -0.1875 2.625 C -0.4981575012207031 2.625 -0.75 2.373157501220703 -0.75 2.0625 L -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 C 0.1231575012207031 -0.75 0.375 -0.4981575012207031 0.375 -0.1875 L 0.375 2.0625 C 0.375 2.373157501220703 0.1231575012207031 2.625 -0.1875 2.625 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(12.19, 1.69)" d="M -0.1875 2.625 C -0.4981575012207031 2.625 -0.75 2.373157501220703 -0.75 2.0625 L -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 C 0.1231575012207031 -0.75 0.375 -0.4981575012207031 0.375 -0.1875 L 0.375 2.0625 C 0.375 2.373157501220703 0.1231575012207031 2.625 -0.1875 2.625 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(2.81, 7.0)" d="M 12.56250095367432 0.375 L -0.1875 0.375 C -0.4981575012207031 0.375 -0.75 0.1231575012207031 -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 L 12.56250095367432 -0.75 C 12.8731575012207 -0.75 13.12500095367432 -0.4981575012207031 13.12500095367432 -0.1875 C 13.12500095367432 0.1231575012207031 12.8731575012207 0.375 12.56250095367432 0.375 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(2.44, 2.81)" d="M 3.562500953674316 -0.75 L 9.5625 -0.75 C 10.98719215393066 -0.75 12.08790874481201 -0.3425626754760742 12.83407592773438 0.4609947204589844 C 13.52477931976318 1.204836845397949 13.875 2.248334884643555 13.875 3.562500953674316 L 13.875 9.9375 C 13.875 11.25166511535645 13.52477931976318 12.29516410827637 12.83407592773438 13.03900527954102 C 12.08790874481201 13.84256362915039 10.98719215393066 14.25000095367432 9.5625 14.25000095367432 L 3.562500953674316 14.25000095367432 C 2.137807846069336 14.25000095367432 1.037092208862305 13.84256362915039 0.290924072265625 13.03900527954102 C -0.3997793197631836 12.29516410827637 -0.75 11.25166511535645 -0.75 9.9375 L -0.75 3.562500953674316 C -0.75 2.248334884643555 -0.3997793197631836 1.204836845397949 0.290924072265625 0.4609947204589844 C 1.037092208862305 -0.3425626754760742 2.137807846069336 -0.75 3.562500953674316 -0.75 Z M 9.5625 13.12500095367432 C 10.66167068481445 13.12500095367432 11.48502063751221 12.83851528167725 12.00967502593994 12.2734956741333 C 12.5009183883667 11.74446773529053 12.75 10.95852756500244 12.75 9.9375 L 12.75 3.562500953674316 C 12.75 2.541472434997559 12.5009183883667 1.755532264709473 12.00967502593994 1.226505279541016 C 11.48502063751221 0.6614856719970703 10.66167068481445 0.375 9.5625 0.375 L 3.562500953674316 0.375 C 2.463330268859863 0.375 1.639980316162109 0.6614856719970703 1.115324974060059 1.226505279541016 C 0.6240816116333008 1.755532264709473 0.375 2.541472434997559 0.375 3.562500953674316 L 0.375 9.9375 C 0.375 10.95852756500244 0.6240816116333008 11.74446773529053 1.115324974060059 12.2734956741333 C 1.639980316162109 12.83851528167725 2.463330268859863 13.12500095367432 3.562500953674316 13.12500095367432 L 9.5625 13.12500095367432 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(0.0, 0.0)" d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(11.53, 10.03)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(11.53, 12.28)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(8.75, 10.03)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(8.75, 12.28)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(5.98, 10.03)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(5.98, 12.28)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_mzngu7 =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(6.5, 6.5)" d="M 2.497499942779541 -0.75 C 4.288177490234375 -0.75 5.744999885559082 0.7068225145339966 5.744999885559082 2.497499942779541 C 5.744999885559082 4.288177490234375 4.288177490234375 5.744999885559082 2.497499942779541 5.744999885559082 C 0.7068225145339966 5.744999885559082 -0.75 4.288177490234375 -0.75 2.497499942779541 C -0.75 0.7068225145339966 0.7068225145339966 -0.75 2.497499942779541 -0.75 Z M 2.497499942779541 4.619999885559082 C 3.667852401733398 4.619999885559082 4.619999885559082 3.667852401733398 4.619999885559082 2.497499942779541 C 4.619999885559082 1.327147364616394 3.667852401733398 0.375 2.497499942779541 0.375 C 1.327147364616394 0.375 0.375 1.327147364616394 0.375 2.497499942779541 C 0.375 3.667852401733398 1.327147364616394 4.619999885559082 2.497499942779541 4.619999885559082 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(1.85, 2.98)" d="M 7.151552677154541 12.78750038146973 C 4.335265159606934 12.78750038146973 1.671925187110901 11.13981056213379 -0.1555623412132263 8.266905784606934 C -0.9466097950935364 7.027597904205322 -0.9466097950935364 5.009902954101562 -0.1550898402929306 3.769853353500366 C 1.671925187110901 0.8976905345916748 4.335265159606934 -0.7499994039535522 7.151552677154541 -0.7499994039535522 C 9.967839241027832 -0.7499994039535522 12.631178855896 0.8976905345916748 14.45866775512695 3.770595788955688 C 15.24971485137939 5.009902954101562 15.24971485137939 7.027597904205322 14.4581937789917 8.267648696899414 C 12.631178855896 11.13981056213379 9.967839241027832 12.78750038146973 7.151552677154541 12.78750038146973 Z M 7.151552677154541 0.3750006258487701 C 4.7278151512146 0.3750006258487701 2.410457611083984 1.832730412483215 0.7936676740646362 4.374405384063721 C 0.2343251556158066 5.250712871551514 0.2343251556158066 6.786787986755371 0.7931951284408569 7.662353038787842 C 2.410457611083984 10.2047700881958 4.7278151512146 11.66250038146973 7.151552677154541 11.66250038146973 C 9.575289726257324 11.66250038146973 11.8926477432251 10.2047700881958 13.50943756103516 7.663095474243164 C 14.06877899169922 6.786787986755371 14.06877899169922 5.250712871551514 13.50990962982178 4.375147819519043 C 11.8926477432251 1.832730412483215 9.575289726257324 0.3750006258487701 7.151552677154541 0.3750006258487701 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 18.0, 18.0)" d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_kx30bu =
    '<svg viewBox="6.0 152.0 338.0 1.0" ><path transform="translate(6.0, 152.0)" d="M 0 0 L 338 0" fill="none" fill-opacity="0.6" stroke="#132144" stroke-width="0.6000000238418579" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_lodn6 =
    '<svg viewBox="8.9 14.0 15.7 13.8" ><path transform="translate(0.0, 0.0)" d="M 16.53636360168457 27.67778396606445 L 10.23385524749756 21.43274688720703 C 9.965662956237793 21.18370819091797 9.754940986633301 20.8963623046875 9.563375473022461 20.5898551940918 C 8.528921127319336 18.88492202758789 8.797113418579102 16.70107460021973 10.23385524749756 15.28348827362061 C 11.05758762359619 14.45975685119629 12.16866779327393 14 13.33721733093262 14 C 15.17624759674072 14 16.32564163208008 15.07276725769043 16.8045539855957 15.68577671051025 C 17.28346824645996 15.07276725769043 18.43286323547363 14 20.27189254760742 14 C 21.4404411315918 14 22.5515251159668 14.45975685119629 23.3752555847168 15.28348922729492 C 24.7928409576416 16.70107460021973 25.0801887512207 18.88492202758789 24.04573631286621 20.58985710144043 C 23.85416984558105 20.8963623046875 23.64344787597656 21.18370819091797 23.3752555847168 21.43274688720703 L 17.07274627685547 27.67778396606445 C 16.91949462890625 27.8310375213623 16.68961524963379 27.8310375213623 16.53636360168457 27.67778396606445 Z M 13.33721733093262 14.76626205444336 C 12.36023330688477 14.76626205444336 11.45987415313721 15.14939308166504 10.77023887634277 15.81987285614014 C 9.601688385009766 16.98842239379883 9.371809959411621 18.78913879394531 10.21469879150391 20.18756866455078 C 10.36795043945312 20.43660354614258 10.55951690673828 20.68563842773438 10.77023887634277 20.8963623046875 L 16.8045539855957 26.87320709228516 L 22.83887100219727 20.8963623046875 C 23.04959106445312 20.68564033508301 23.24115943908691 20.45576095581055 23.39441299438477 20.18756866455078 C 24.23730087280273 18.76998138427734 24.02657890319824 16.96926498413086 22.83887100219727 15.81987285614014 C 22.14923667907715 15.14939308166504 21.2297191619873 14.76626205444336 20.27189254760742 14.76626205444336 C 18.89262008666992 14.76626205444336 17.74322509765625 15.51336860656738 17.13021469116211 16.54782104492188 C 16.97696304321289 16.7968578338623 16.61298942565918 16.7968578338623 16.45973587036133 16.54782104492188 C 15.86588382720947 15.51336860656738 14.71648979187012 14.76626205444336 13.33721733093262 14.76626205444336 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
