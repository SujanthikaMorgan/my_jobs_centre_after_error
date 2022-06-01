// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_jobs_center/globalVariables.dart';

class ProfileShowInitialWidget extends StatefulWidget {
  final String imagePath;
  final String name;
  final String country;
  final String city;
  final String createdAt;
  final String mainCat;
  final bool isBlocked;
  const ProfileShowInitialWidget({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.country,
    required this.city,
    required this.createdAt,
    required this.mainCat,
    required this.isBlocked,
  }) : super(key: key);

  @override
  _ProfileShowInitialWidgetState createState() => _ProfileShowInitialWidgetState();
}

class _ProfileShowInitialWidgetState extends State<ProfileShowInitialWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 15,
        left: 10,
        right: 10,
      ),
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
                                  widget.isBlocked
                                      ? profImgLink + "default_user.png"
                                      : "$profImgLink${widget.imagePath}",
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
                                fontSize: 20,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                if (!widget.isBlocked)
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xffC61800),
                                    size: 20,
                                  ),
                                Text(
                                  widget.isBlocked
                                      ? ""
                                      : (widget.city == "null" &&
                                              widget.country == "null")
                                          ? "No location provided"
                                          : (widget.city == "null")
                                              ? widget.country
                                              : (widget.country == "null")
                                                  ? widget.city
                                                  : " " +
                                                      widget.city +
                                                      ' , ' +
                                                      widget.country,
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
                          ),
                          if (widget.mainCat != "null")
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  if (!widget.isBlocked)
                                    Icon(
                                      Icons.folder_outlined,
                                      color: Color(0xffC61800),
                                      size: 20,
                                    ),
                                  Text(
                                    widget.isBlocked ? "" : " " + widget.mainCat,
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
                            ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                if (!widget.isBlocked)
                                  Icon(
                                    Icons.access_time,
                                    color: Color(0xffC61800),
                                    size: 20,
                                  ),
                                Text(
                                  widget.isBlocked
                                      ? ""
                                      : " Member Since: " + widget.createdAt,
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
                          ),
                        ],
                      ),
                    ),
                    // Spacer(),
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
