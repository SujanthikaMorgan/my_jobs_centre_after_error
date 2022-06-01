// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:my_jobs_center/Screens/Job_Expanded.dart';
import 'package:my_jobs_center/Screens/widget/favouriteNotSignedIn.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:my_jobs_center/mysql.dart';
import 'package:http/http.dart' as http;

class FavItemComponentWidget extends StatefulWidget {
  static const String idScreen = "favItemComponent";
  final String prodID;
  final bool isFav;
  final String title;
  final String minSal;
  final String maxSal;
  final String city;
  final String country;
  final String description;
  final String type;
  final String date;
  final String view;
  final String img;
  final String salType;
  final String msgId;
  final String jobId;
  final String urgent;
  final String highlight;
  final String feature;
  // final String currency;
  const FavItemComponentWidget({
    required this.isFav,
    required this.title,
    required this.minSal,
    required this.maxSal,
    required this.city,
    required this.country,
    required this.description,
    required this.type,
    required this.date,
    required this.view,
    required this.img,
    required this.salType,
    // required this.currency,
    required this.prodID,
    required this.msgId,
    required this.jobId,
    required this.urgent,
    required this.highlight,
    required this.feature,
  });

  @override
  _FavItemComponentWidgetState createState() => _FavItemComponentWidgetState();
}

class _FavItemComponentWidgetState extends State<FavItemComponentWidget> {
  bool isFavLoc = false;
  var dbFavAddRemove = new Mysql();
  Map favData = {};

  Future addFavs() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_add_favs');
    var url = Uri.parse(defaultUrl + 'mob_add_favs');

    // Starting Web API Call.

    var response = await http.post(url, body: json.encode(favData));

    if (response.body == 'Successfully sent') {
      print("success");
    }
  }

  Future removeFavs() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_remove_favs');
    var url = Uri.parse(defaultUrl + 'mob_remove_favs');

    // Starting Web API Call.

    var response = await http.post(url, body: json.encode(favData));

    if (response.body == 'Successfully removed') {
      print("success");
    }
  }

  @override
  void initState() {
    setState(() {
      isFavLoc = widget.isFav;
    });
  }

  addFavJob() {
    dbFavAddRemove.getConnection().then((value) async {
      await value.query('insert into job_favads (user_id,product_id) value (?,?)',
          [userID, widget.prodID]);
    });
  }

  removeFavJob() {
    dbFavAddRemove.getConnection().then((value) async {
      await value.query('delete from job_favads where (user_id=? and product_id=?)',
          [userID, widget.prodID]);
    });
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
                                  "https://www.myjobscentre.com/storage/products/${widget.img}",
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
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: const Color(0xff132144),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.minSal.toString() != "0" &&
                              widget.maxSal.toString() != "0")
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: MarkdownBody(
                                data: html2md.convert(
                                    '${widget.minSal} - ${widget.maxSal}  per ${widget.salType}'),
                              ),
                            ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text(
                                  widget.city + ' , ' + widget.country,
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
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (isSignedIn) {
                          setState(() {
                            isFavLoc = !isFavLoc;
                            favData['userId'] = userDetailsResponse["id"];
                            favData['prodId'] = widget.jobId;
                          });
                          if (isFavLoc) {
                            addFavs();
                          } else {
                            removeFavs();
                          }
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => FavouriteNotSignedIn()),
                            ),
                          );
                        }
                        // setState(() {
                        //   isFavLoc = !isFavLoc;
                        // });
                        // isFavLoc ? addFavJob() : removeFavJob();
                      },
                      child: Icon(
                        isFavLoc ? Icons.favorite : Icons.favorite_outline,
                        color: isFavLoc ? Color(0xffdd312d) : null,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print(html2md.convert(widget.description));
                          },
                          child: Text(
                            widget.description.replaceAll(
                                RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true),
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
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.type,
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
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.date,
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
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.view,
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
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    // left: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (widget.urgent == "1")
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 15,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffDD312D),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 5,
                                bottom: 5,
                              ),
                              child: Text(
                                "urgent",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  height: 1.4166666666666667,
                                ),
                                textHeightBehavior:
                                    TextHeightBehavior(applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      if (widget.feature == "1")
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 15,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff008000),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 5,
                                bottom: 5,
                              ),
                              child: Text(
                                "Featured",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  height: 1.4166666666666667,
                                ),
                                textHeightBehavior:
                                    TextHeightBehavior(applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      if (widget.highlight == "1")
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 15,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffFFA500),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 5,
                                bottom: 5,
                              ),
                              child: Text(
                                "highlight",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  height: 1.4166666666666667,
                                ),
                                textHeightBehavior:
                                    TextHeightBehavior(applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
