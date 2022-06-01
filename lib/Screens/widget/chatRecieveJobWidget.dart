// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../employer/employer screens/applicants.dart';
import '../../globalVariables.dart';
import '../appliedJobs.dart';

class ChatRecieveJob extends StatefulWidget {
  final String date;
  final String title;
  final String description;
  final String jobId;
  final String toWhere;
  final String msg;

  const ChatRecieveJob({
    Key? key,
    required this.date,
    required this.title,
    required this.description,
    required this.jobId,
    required this.toWhere,
    required this.msg,
  }) : super(key: key);

  @override
  State<ChatRecieveJob> createState() => _ChatRecieveJobState();
}

class _ChatRecieveJobState extends State<ChatRecieveJob> {
  Map jobData = {};
  Future gettingAllJobseekers() async {
    var url = Uri.parse(defaultUrl + 'mob_get_job_title_desc');
    var response = await http.post(url, body: json.encode({"job_id": widget.jobId}));
    try {
      setState(() {
        jobData = jsonDecode(response.body);
      });
    } catch (error) {
      print(error);
      Fluttertoast.showToast(msg: "Some products not available at the moment");
    }
  }

  @override
  void initState() {
    gettingAllJobseekers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          if (widget.toWhere == "applied") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AppliedJobsScreen()));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Applicants(
                          jobId: widget.jobId,
                          prodName: jobData['product_name'],
                        )));
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
              // minWidth: MediaQuery.of(context).size.width * 0.1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              ),
              // color: const Color(0xff132144),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.msg + '\n\n',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        // color: const Color(0xffffffff),
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      jobData.isEmpty ? widget.title : jobData['product_name'],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        // color: const Color(0xffffffff),
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      jobData.isEmpty
                          ? widget.description
                          : jobData['description'].replaceAll(
                              RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true),
                              ""),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        // color: const Color(0xffffffff),
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.date,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: const Color(0xff9ca5bc),
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
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
