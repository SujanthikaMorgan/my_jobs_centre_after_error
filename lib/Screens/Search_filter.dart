// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../globalVariables.dart';
import 'allJobsFiltered.dart';

class Search_filter extends StatefulWidget {
  static const String idScreen = "SearchFilter";
  const Search_filter({Key? key}) : super(key: key);

  @override
  _Search_filterState createState() => _Search_filterState();
}

class _Search_filterState extends State<Search_filter> {
  RangeValues _currentRangeValues = RangeValues(0, 1000000);
  bool isFulltime = false;
  bool isPartTime = false;
  bool isTemprory = false;
  bool isPermenant = false;
  bool isInter = false;
  bool isFreelance = false;
//Salary
  bool isAnnual = false;
  bool isMonth = false;
  bool isDay = false;
  bool isHour = false;

  //PostedDay
  bool isToday = false;
  bool isLastThree = false;
  bool isLastWeek = false;
  bool isLastTwoWeeks = false;
  bool isAnyTime = false;

  //sort by
  bool isNewset = false;
  bool isName = false;
  bool isDate = false;
  bool isSalaryHigh = false;
  bool isSalaryLow = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      // constraints:
      //     BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: const Color(0xffffffff),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, right: 20, left: 20, bottom: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        jobType = 0;
                        salaryType = 0;
                        minSal = 0;
                        maxSal = 1000000;
                        postedDateFilter = 4;
                        sortBy = "";
                        isFulltime = false;
                        isPartTime = false;
                        isTemprory = false;
                        isPermenant = false;
                        isInter = false;
                        isFreelance = false;

                        isAnnual = false;
                        isMonth = false;
                        isDay = false;
                        isHour = false;

                        isToday = false;
                        isLastThree = false;
                        isLastWeek = false;
                        isLastTwoWeeks = false;
                        isAnyTime = false;

                        isNewset = false;
                        isName = false;
                        isDate = false;
                        isSalaryHigh = false;
                        isSalaryLow = false;
                        _currentRangeValues = RangeValues(0, 1000000);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Clear Filters',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: const Color(0xff191919),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        jobType = 0;
                        salaryType = 0;
                        minSal = 0;
                        maxSal = 1000000;
                        postedDateFilter = 4;
                        sortBy = "";
                        isFulltime = false;
                        isPartTime = false;
                        isTemprory = false;
                        isPermenant = false;
                        isInter = false;
                        isFreelance = false;

                        isAnnual = false;
                        isMonth = false;
                        isDay = false;
                        isHour = false;

                        isToday = false;
                        isLastThree = false;
                        isLastWeek = false;
                        isLastTwoWeeks = false;
                        isAnyTime = false;

                        isNewset = false;
                        isName = false;
                        isDate = false;
                        isSalaryHigh = false;
                        isSalaryLow = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Icon(Icons.cancel_presentation_outlined),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Filter',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: const Color(0xff191919),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Job type',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: const Color(0xff191919),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        jobType = 4;
                        isFulltime = true;
                        isPartTime = false;
                        isTemprory = false;
                        isPermenant = false;
                        isInter = false;
                        isFreelance = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isFulltime ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 12,
                              color: isFulltime ? Colors.white : Color(0xff191919),
                            ),
                            Text(
                              'Full-time',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: isFulltime ? Colors.white : Color(0xff191919),
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        jobType = 5;
                        isFulltime = false;
                        isPartTime = true;
                        isTemprory = false;
                        isPermenant = false;
                        isInter = false;
                        isFreelance = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isPartTime ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 12,
                              color: isPartTime ? Colors.white : Color(0xff191919),
                            ),
                            Text(
                              'Part-time',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: isPartTime ? Colors.white : Color(0xff191919),
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        jobType = 6;
                        isFulltime = false;
                        isPartTime = false;
                        isTemprory = true;
                        isPermenant = false;
                        isInter = false;
                        isFreelance = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isTemprory ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 12,
                              color: isTemprory ? Colors.white : Color(0xff191919),
                            ),
                            Text(
                              'Temporary',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: isTemprory ? Colors.white : Color(0xff191919),
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        jobType = 9;
                        isFulltime = false;
                        isPartTime = false;
                        isTemprory = false;
                        isPermenant = false;
                        isInter = false;
                        isFreelance = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isFreelance ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 12,
                              color: isFreelance ? Colors.white : Color(0xff191919),
                            ),
                            Text(
                              'Freelancer',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: isFreelance ? Colors.white : Color(0xff191919),
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        jobType = 7;
                        isFulltime = false;
                        isPartTime = false;
                        isTemprory = false;
                        isPermenant = true;
                        isInter = false;
                        isFreelance = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isPermenant ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 12,
                              color: isPermenant ? Colors.white : Color(0xff191919),
                            ),
                            Text(
                              'Permanent',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: isPermenant ? Colors.white : Color(0xff191919),
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        jobType = 8;
                        isFulltime = false;
                        isPartTime = false;
                        isTemprory = false;
                        isPermenant = false;
                        isInter = true;
                        isFreelance = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isInter ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 12,
                              color: isInter ? Colors.white : Color(0xff191919),
                            ),
                            Text(
                              'Internship',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: isInter ? Colors.white : Color(0xff191919),
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Salary',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: const Color(0xff191919),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        salaryType = 7;
                        isAnnual = true;
                        isMonth = false;
                        isDay = false;
                        isHour = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isAnnual ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Annually',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: isAnnual ? Colors.white : Color(0xff191919),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        salaryType = 6;
                        isAnnual = false;
                        isMonth = true;
                        isDay = false;
                        isHour = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isMonth ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Month',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: isMonth ? Colors.white : Color(0xff191919),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        salaryType = 5;
                        isAnnual = false;
                        isMonth = false;
                        isDay = true;
                        isHour = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDay ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Day',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: isDay ? Colors.white : Color(0xff191919),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        salaryType = 4;
                        isAnnual = false;
                        isMonth = false;
                        isDay = false;
                        isHour = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isHour ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Hour',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: isHour ? Colors.white : Color(0xff191919),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: RangeSlider(
                activeColor: Color(0xff191919),
                values: _currentRangeValues,
                min: 0,
                max: 1000000, //maxSal = 10000000;
                divisions: 1000000,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                    minSal = _currentRangeValues.start.round();
                    maxSal = _currentRangeValues.end.round();
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Minimum Salary",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: const Color(0xff191919),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        minSal.toString(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: const Color(0xff191919),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        "Maximum Salary",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: const Color(0xff191919),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        maxSal.toString(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: const Color(0xff191919),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Sort By',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: const Color(0xff191919),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sortBy = "created_at";
                        isNewset = true;
                        isName = false;
                        isDate = false;
                        isSalaryHigh = false;
                        isSalaryLow = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isNewset ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Newest',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: isNewset ? Colors.white : Color(0xff191919),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sortBy = "title";
                        isNewset = false;
                        isName = true;
                        isDate = false;
                        isSalaryHigh = false;
                        isSalaryLow = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isName ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: isName ? Colors.white : Color(0xff191919),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sortBy = "date";
                        isNewset = false;
                        isName = false;
                        isDate = true;
                        isSalaryHigh = false;
                        isSalaryLow = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDate ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Date',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: isDate ? Colors.white : Color(0xff191919),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sortBy = "priceHL";
                        isNewset = false;
                        isName = false;
                        isDate = false;
                        isSalaryHigh = true;
                        isSalaryLow = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSalaryHigh ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Salary (high to low)',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: isSalaryHigh ? Colors.white : Color(0xff191919),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sortBy = "priceLH";
                        isNewset = false;
                        isName = false;
                        isDate = false;
                        isSalaryHigh = false;
                        isSalaryLow = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSalaryLow ? Color(0xff191919) : null,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(width: 0.5, color: const Color(0xff191919)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Salary (low to high)',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: isSalaryLow ? Colors.white : Color(0xff191919),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width - 125,
                        minHeight: 45,
                      ),
                      child: Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(width: 1.0, color: const Color(0xffdd312d)),
                            elevation: 10.0,
                            primary: const Color(0xffdd312d),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            // userLogin();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllJobsFiltered()));
                          },
                          child: Text(
                            "Show Jobs",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: const Color(0xfff7f9fc),
                              letterSpacing: 0.7000000000000001,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String _svg_j88nqa =
    '<svg viewBox="0.0 0.0 6.0 6.0" ><path  d="M 0.4585136771202087 6.042377471923828 C 0.3411702811717987 6.042377471923828 0.223826140165329 5.997612953186035 0.1342938244342804 5.908083915710449 C -0.04476460814476013 5.729019165039062 -0.04476460814476013 5.438706398010254 0.1342938244342804 5.259648323059082 L 5.259648323059082 0.134293869137764 C 5.438706398010254 -0.04476462304592133 5.729019165039062 -0.04476462304592133 5.908083915710449 0.134293869137764 C 6.087141990661621 0.3133584260940552 6.087141990661621 0.6036704182624817 5.908083915710449 0.782728910446167 L 0.782728910446167 5.908083915710449 C 0.693199634552002 5.997612953186035 0.5758570432662964 6.042377471923828 0.4585136771202087 6.042377471923828 Z" fill="#191919" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_ew9fy0 =
    '<svg viewBox="0.0 0.0 6.0 6.0" ><path  d="M 5.583863258361816 6.042377471923828 C 5.466519355773926 6.042377471923828 5.349177360534668 5.997612953186035 5.259648323059082 5.908083915710449 L 0.1342938244342804 0.782728910446167 C -0.04476460814476013 0.6036704182624817 -0.04476460814476013 0.3133584260940552 0.1342938244342804 0.134293869137764 C 0.3133584558963776 -0.04476462304592133 0.6036704778671265 -0.04476462304592133 0.782728910446167 0.134293869137764 L 5.908083915710449 5.259648323059082 C 6.087141990661621 5.438706398010254 6.087141990661621 5.729019165039062 5.908083915710449 5.908083915710449 C 5.818551063537598 5.997612953186035 5.701206207275391 6.042377471923828 5.583863258361816 6.042377471923828 Z" fill="#191919" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_mp =
    '<svg viewBox="0.0 0.0 6.0 6.0" ><path  d="M 0.4585136771202087 6.042377471923828 C 0.3411702811717987 6.042377471923828 0.223826140165329 5.997612953186035 0.1342938244342804 5.908083915710449 C -0.04476460814476013 5.729019165039062 -0.04476460814476013 5.438706398010254 0.1342938244342804 5.259648323059082 L 5.259648323059082 0.134293869137764 C 5.438706398010254 -0.04476462304592133 5.729019165039062 -0.04476462304592133 5.908083915710449 0.134293869137764 C 6.087141990661621 0.3133584260940552 6.087141990661621 0.6036704182624817 5.908083915710449 0.782728910446167 L 0.782728910446167 5.908083915710449 C 0.693199634552002 5.997612953186035 0.5758570432662964 6.042377471923828 0.4585136771202087 6.042377471923828 Z" fill="#f3f3f3" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_t5wuf =
    '<svg viewBox="0.0 0.0 6.0 6.0" ><path  d="M 5.583863258361816 6.042377471923828 C 5.466519355773926 6.042377471923828 5.349177360534668 5.997612953186035 5.259648323059082 5.908083915710449 L 0.1342938244342804 0.782728910446167 C -0.04476460814476013 0.6036704182624817 -0.04476460814476013 0.3133584260940552 0.1342938244342804 0.134293869137764 C 0.3133584558963776 -0.04476462304592133 0.6036704778671265 -0.04476462304592133 0.782728910446167 0.134293869137764 L 5.908083915710449 5.259648323059082 C 6.087141990661621 5.438706398010254 6.087141990661621 5.729019165039062 5.908083915710449 5.908083915710449 C 5.818551063537598 5.997612953186035 5.701206207275391 6.042377471923828 5.583863258361816 6.042377471923828 Z" fill="#f3f3f3" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_oqyfdq =
    '<svg viewBox="44.5 550.5 303.0 1.0" ><path transform="translate(44.5, 550.5)" d="M 0 0 L 303 0" fill="none" stroke="#e1e1e1" stroke-width="5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_a1em43 =
    '<svg viewBox="89.5 550.5 119.0 1.0" ><path transform="translate(89.5, 550.5)" d="M 0 0 L 119 0" fill="none" stroke="#132144" stroke-width="5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_fqzmbl =
    '<svg viewBox="0.0 0.0 16.0 16.0" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 1.78, 0.0)" d="M 0 1.259885907173157 C -2.211938898710741e-08 0.5640701055526733 0.5640705823898315 -2.211940497431897e-08 1.259886980056763 0 L 18.89829444885254 5.607099069493415e-07 C 19.5941104888916 5.8282927284381e-07 20.15818214416504 0.5640707612037659 20.15818214416504 1.259886622428894 C 20.15818214416504 1.955702900886536 19.5941104888916 2.519773006439209 18.89829444885254 2.519773006439209 L 1.259886503219604 2.519772529602051 C 0.5640702247619629 2.519772529602051 2.211940497431897e-08 1.955702304840088 0 1.259885907173157 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 0.0, 14.25)" d="M 0 1.259887933731079 C 2.211937299989586e-08 0.5640727281570435 0.5640707015991211 5.828293296872289e-07 1.259886980056763 5.607099069493415e-07 L 18.89829444885254 0 C 19.5941104888916 -2.21193658944685e-08 20.15818214416504 0.5640720725059509 20.15818214416504 1.259887218475342 C 20.15818214416504 1.955702662467957 19.5941104888916 2.519773006439209 18.89829444885254 2.519773006439209 L 1.259886384010315 2.519773721694946 C 0.5640701651573181 2.519773721694946 -2.211937299989586e-08 1.955703258514404 0 1.259887933731079 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_km8qzp =
    '<svg viewBox="0.0 0.0 15.0 15.0" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 1.67, 0.0)" d="M 3.746349364064372e-08 1.178499579429626 C 1.677297767344044e-08 0.5276322364807129 0.5276327133178711 1.677299366065199e-08 1.178500533103943 3.746352561506683e-08 L 17.67749786376953 5.619525609290577e-07 C 18.32836532592773 5.82643053803622e-07 18.85599899291992 0.5276328325271606 18.85599899291992 1.178500175476074 C 18.85599899291992 1.829367995262146 18.32836532592773 2.357000112533569 17.67749786376953 2.357000112533569 L 1.178500175476074 2.356999635696411 C 0.5276322960853577 2.356999635696411 5.815402559505856e-08 1.829367399215698 3.746349364064372e-08 1.178499579429626 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 0.0, 13.33)" d="M -3.746353627320786e-08 1.178500890731812 C -1.677303629321614e-08 0.5276340842247009 0.5276327133178711 -1.677299366065199e-08 1.178500533103943 -3.746352561506683e-08 L 17.67749786376953 -5.619525609290577e-07 C 18.32836532592773 -5.82643053803622e-07 18.85599899291992 0.5276334881782532 18.85599899291992 1.178500294685364 C 18.85599899291992 1.829367160797119 18.32836532592773 2.356999635696411 17.67749786376953 2.356999635696411 L 1.178499937057495 2.357000112533569 C 0.5276321768760681 2.357000112533569 -5.815403625319959e-08 1.829367756843567 -3.746353627320786e-08 1.178500890731812 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
