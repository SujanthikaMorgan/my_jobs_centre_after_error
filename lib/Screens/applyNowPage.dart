// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jobs_center/Screens/Sidemenu.dart';
import 'package:http/http.dart' as http;
import 'package:my_jobs_center/Screens/widget/applyJobsNotSignedWidget.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class ApplyNowPage extends StatefulWidget {
  static const String idScreen = "applyNowPage";
  final String jobId;
  final String productName;
  const ApplyNowPage({required this.jobId, required this.productName});

  @override
  _ApplyNowPageState createState() => _ApplyNowPageState();
}

class _ApplyNowPageState extends State<ApplyNowPage> {
  String resumeRadioGroupValue = "resume";
  String resumeRadioValue = "";
  Map userResumeDetResponse = {};

  File? file;
  Map resumeUploadResponse = {};
  Map data = {};
  String fileName = "";
  Dio dio = new Dio();
  var aplyJobResponse;
  Map applyJobMap = {};
  String resumeId = "";
  String jobMsg = "";
  final f = new DateFormat('yyyy-MM-dd hh:mm:ss');
  bool isUploadSuccess = false;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  // Future uploadResume() async {
  //   var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_add_resume');

  //   var response = await http.post(url, body: json.encode(data));
  //   resumeUploadResponse = jsonDecode(response.body);
  //   print(resumeUploadResponse);
  // }

  uploadFile() async {
    // String uploadurl = "http://10.0.2.2/myjobscenter/demo/mob_add_resume";
    String uploadurl = defaultUrl + "mob_add_resume";

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(file!.path, filename: basename(file!.path)
          //show only filename from path
          ),
      "name": fileName,
      "id": userDetailsResponse["id"]
      // "name": fileName,
    });

    print(formdata.fields);

    var response = await dio.post(
      uploadurl,
      data: formdata,
    );

    if (response.statusCode == 200) {
      print(response.toString());
      setState(() {
        isUploadSuccess = true;
      });
      //print response from server
    } else {
      print("Error during connection to server.");
    }
  }

  Future gettingResumeData() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_my_resumes');
    var url = Uri.parse(defaultUrl + 'mob_my_resumes');

    var response =
        await http.post(url, body: json.encode({'id': userDetailsResponse['id']}));
    try {
      setState(() {
        userResumeDetResponse = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
    print(userResumeDetResponse);
  }

  Future applyJob() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_apply_job');
    var url = Uri.parse(defaultUrl + 'mob_apply_job');

    var response = await http.post(url, body: json.encode(applyJobMap));
    setState(() {
      aplyJobResponse = jsonDecode(response.body);
    });
    print(aplyJobResponse);
    if (aplyJobResponse['msg'] == 'Successfully Applied') {
      Fluttertoast.showToast(msg: "Successfully Applied");
    }
  }

  @override
  void initState() {
    // dbCheckResume();
    gettingResumeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Sidemenu(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        elevation: 0,
        titleSpacing: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Apply Now',
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
      body: isSignedIn
          ? Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                  minWidth: MediaQuery.of(context).size.width),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "Message *",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 17,
                              color: const Color(0xff132144),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                jobMsg = value;
                              });
                            },
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Message',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: const Color(0xff707070),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            minLines: 10,
                            maxLines: 10,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Resumes *",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 17,
                              color: const Color(0xff132144),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          for (int i = 0; i < userResumeDetResponse.length; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  resumeRadioGroupValue = userResumeDetResponse.values
                                      .elementAt(i)['filename']
                                      .toString();
                                  resumeId = userResumeDetResponse.values
                                      .elementAt(i)['id']
                                      .toString();
                                });
                              },
                              child: Row(
                                children: [
                                  Radio(
                                    value: userResumeDetResponse.values
                                        .elementAt(i)['filename']
                                        .toString(),
                                    groupValue: resumeRadioGroupValue,
                                    onChanged: (value) {
                                      setState(() {
                                        resumeRadioGroupValue = value.toString();
                                        resumeId = userResumeDetResponse.values
                                            .elementAt(i)['id']
                                            .toString();
                                      });
                                      print(resumeRadioGroupValue);
                                    },
                                    activeColor: Colors.green,
                                  ),
                                  Text(userResumeDetResponse.values
                                      .elementAt(i)['name']
                                      .toString()),
                                ],
                              ),
                            ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                resumeRadioGroupValue = "Add New Resume";
                              });
                            },
                            child: Row(
                              children: [
                                Radio(
                                  value: "Add New Resume",
                                  groupValue: resumeRadioGroupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      resumeRadioGroupValue = value.toString();
                                    });
                                    print(resumeRadioGroupValue);
                                  },
                                  activeColor: Colors.green,
                                ),
                                Text("Add New Resume"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: (resumeRadioGroupValue == "Add New Resume"),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      minWidth: MediaQuery.of(context).size.width * 0.3,
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(
                                            width: 1.0, color: const Color(0xffdd312d)),
                                        elevation: 10.0,
                                        primary: const Color(0xfff7f9fc),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        print(userResumeDetResponse.length);
                                        selectFile()
                                            .then((value) => uploadFile())
                                            .then((value) {
                                          if (isUploadSuccess) {
                                            gettingResumeData()
                                                .then((value) => setState(() {
                                                      resumeRadioGroupValue =
                                                          userResumeDetResponse.values
                                                              .elementAt(
                                                                  userResumeDetResponse
                                                                          .length -
                                                                      1)['filename']
                                                              .toString();
                                                      resumeId = userResumeDetResponse
                                                          .values
                                                          .elementAt(userResumeDetResponse
                                                                  .length -
                                                              1)['id']
                                                          .toString();
                                                      isUploadSuccess = false;
                                                    }));
                                          } else {
                                            Fluttertoast.showToast(msg: "Upload failed");
                                          }
                                        });
                                      },
                                      child: Text(
                                        "Upload Resume",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: const Color(0xffdd312d),
                                          letterSpacing: 0.7000000000000001,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'Only pdf, doc, docx, rtf, rtx, ppt, pptx, jpeg, jpg, bmp, png file types allowed.',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 12,
                                        color: const Color(0xb2788198),
                                      ),
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                          minHeight: 40,
                        ),
                        child: Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              primary: Color(0xffDD312D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              if (jobMsg == "" || jobMsg == " " || jobMsg.trim() == "") {
                                Fluttertoast.showToast(msg: "Message is required");
                              } else if (resumeRadioGroupValue == "resume" ||
                                  resumeRadioGroupValue == "Add New Resume") {
                                Fluttertoast.showToast(msg: "Pleae select a resume");
                              } else {
                                setState(() {
                                  applyJobMap["userId"] = userDetailsResponse['id'];
                                  applyJobMap["jobId"] = widget.jobId;
                                  applyJobMap["resId"] = resumeId;
                                  applyJobMap["msg"] = jobMsg;
                                  applyJobMap["date"] = f.format(DateTime.now());
                                  applyJobMap["productName"] = widget.productName;

                                  // applyJobMap["jobId"] =
                                });
                                applyJob();
                              }

                              // setState(() {
                              //   data["file"] = file;
                              //   data["name"] = fileName;
                              // });
                              // // uploadResume();
                              // uploadFile();
                            },
                            child: Text(
                              "Apply Now",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                letterSpacing: 0.7000000000000001,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ApplyJobsNotSigned(),
    );
  }
}
