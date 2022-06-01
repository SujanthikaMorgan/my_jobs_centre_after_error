import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UrgentJobCategoryWidget extends StatelessWidget {
  const UrgentJobCategoryWidget({
    required this.company,
    required this.jobrole,
    required this.location,
    required this.date,
    required this.type,
    required this.profImg,
  });

  final String company;
  final String jobrole;
  final String location;
  final String date;
  final String type;
  final String profImg;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Container(
            width: 260,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xfff7f9fc),
              ),
              color: const Color(0xfff7f9fc),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Container(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundColor: const Color(0xff707070),
                            backgroundImage: NetworkImage(
                              "https://www.myjobscentre.com/storage/products/${profImg}",
                            ),
                            radius: 35,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, right: 5),
                          child: Text(
                            company,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: const Color(0xff132144),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, right: 5),
                          child: Text(
                            jobrole,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: const Color(0xff132144),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 8, left: 1),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  size: 20,
                                  color: const Color(0xff132144),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 3),
                                child: Text(
                                  location,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: const Color(0xff132144),
                                    fontWeight: FontWeight.w300,
                                    height: 1.4166666666666667,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 2),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 8, left: 1, right: 5),
                                          child: Icon(
                                            Icons.calendar_today_outlined,
                                            size: 20,
                                            color: const Color(0xff132144),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                          ),
                                          child: Text(
                                            date,
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              color: const Color(0xff132144),
                                              fontWeight: FontWeight.w300,
                                              height: 1.4166666666666667,
                                            ),
                                            textHeightBehavior:
                                                TextHeightBehavior(
                                                    applyHeightToFirstAscent:
                                                        false),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:10),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 8, left: 10, right: 5),
                                      child: Icon(
                                        Icons.timelapse_outlined,
                                        size: 20,
                                        color: const Color(0xff132144),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, left: 3),
                                      child: Text(
                                        type,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: const Color(0xff132144),
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
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
