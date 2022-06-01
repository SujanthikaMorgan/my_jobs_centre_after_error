// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:http/http.dart' as http;

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List transactions = [];
  bool isError = false;
  bool isSpin = true;
  Future getTransactions() async {
    var url = Uri.parse(defaultUrl + 'mob_transactions');
    try {
      var response =
          await http.post(url, body: json.encode({"user_id": userDetailsResponse['id']}));
      transactions = jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
      setState(() {
        isError = true;
      });
    }
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    getTransactions().then((value) {
      setState(() {
        isSpin = false;
      });
    });
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      endDrawer: SidemenuEmployer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        backgroundColor: const Color(0xfff7f9fc),
        elevation: 0,
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              bottom: 10,
              right: 10,
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          "Transaction",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: const Color(0xff1d1d1d),
            fontWeight: FontWeight.w500,
            //fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
      ),
      body: isSpin
          ? Center(
              child: CupertinoActivityIndicator(
                animating: isSpin,
                radius: 25,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Table(
                      border: TableBorder.all(
                          color: Colors.black, style: BorderStyle.solid, width: 2),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Job Title",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: const Color(0xcc1d1d1d),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Amount",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: const Color(0xcc1d1d1d),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Premium",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: const Color(0xcc1d1d1d),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Payment Method",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: const Color(0xcc1d1d1d),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Date",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: const Color(0xcc1d1d1d),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Status",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: const Color(0xcc1d1d1d),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        for (int i = 0; i < transactions.length; i++)
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  transactions[i]['product_name'].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: const Color(0xcc1d1d1d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  transactions[i]['amount'].toString() + ' GRB',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: const Color(0xcc1d1d1d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  transactions[i]['premium'].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: const Color(0xcc1d1d1d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  transactions[i]['payment_by'].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: const Color(0xcc1d1d1d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  transactions[i]['time'].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: const Color(0xcc1d1d1d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  transactions[i]['status'].toString(),
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: const Color(0xcc1d1d1d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                  if (transactions.isEmpty)
                    Center(
                      child: Text(
                        "No Notifications are there",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontSize: 15.sp,
                          color: const Color(0xcc1d1d1d),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
