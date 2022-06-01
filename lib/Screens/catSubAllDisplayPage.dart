// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/Screens/allJobsWithCats.dart';

class CatSubAllDisplayPage extends StatefulWidget {
  final Map subCatMap;
  final List subCategoryList;
  final Map subCatIdMap;
  final Map subCatImageMap;
  final String mainCatId;
  final String mainCatName;
  const CatSubAllDisplayPage(
      {Key? key,
      required this.subCatMap,
      required this.subCategoryList,
      required this.subCatIdMap,
      required this.subCatImageMap,
      required this.mainCatId,
      required this.mainCatName})
      : super(key: key);

  @override
  State<CatSubAllDisplayPage> createState() => _CatSubAllDisplayPageState();
}



class _CatSubAllDisplayPageState extends State<CatSubAllDisplayPage> {
  bool isSpin = false;
  String categorySubSel = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.mainCatName,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: const Color(0xff1d1d1d),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xffF9FAFF),
      ),
      body: isSpin
          ? Center(
              child: CupertinoActivityIndicator(
                animating: isSpin,
                radius: 15,
              ),
            )
          : Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 10,
                primary: false,
                shrinkWrap: true,
                children: [
                  for (int i = 0; i < widget.subCategoryList.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          categorySubSel = widget.subCategoryList[i];
                        });
                        // getSubCatList();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllJObsWithCats(
                                    catId: widget.mainCatId,
                                    subcatId: widget
                                        .subCatIdMap[widget.subCategoryList[i]]
                                        .toString())));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:  Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 112,
                        height: 87,
                        // color: isFav ? Color(0xffDD312D) : Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Text(
                                widget.subCategoryList[i],
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  // color: const Color(0xff444444),
                                  color: Color(0xff444444),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
    );
  }
}

class Applied {
  String recieved;

  Applied(this.recieved);

  @override
  String toString() {
    return '${this.recieved}';
  }
}
