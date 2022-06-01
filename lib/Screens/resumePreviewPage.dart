// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:ffi';

import 'package:adobe_xd/page_link.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../employer/widget/endDrawer.dart';
import '../globalVariables.dart';
import '../mysql.dart';
import 'Add_Resume.dart';
import 'Component34.dart';
import 'My_Resumes.dart';
import 'Sidemenu.dart';
import 'widget/resumeNotSignedWidget.dart';

class ResumePreviewPage extends StatefulWidget {
  static const String idScreen = 'resumePreviewPage';
  const ResumePreviewPage({Key? key}) : super(key: key);

  @override
  _ResumePreviewPageState createState() => _ResumePreviewPageState();
}

class _ResumePreviewPageState extends State<ResumePreviewPage> {
  var dbResume = new Mysql();
  var resultResume;
  var resumesName = [];
  var resumeFile = [];
  Map userResumeDetResponse = {};

  @override
  void initState() {
    gettingResumeData();
  }

  Future gettingResumeData() async {
    var url = Uri.parse(defaultUrl + 'mob_my_resumes');

    var response =
        await http.post(url, body: json.encode({'id': userDetailsResponse['id']}));
    try {
      setState(() {
        userResumeDetResponse = jsonDecode(response.body);
      });
      print(userResumeDetResponse);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Sidemenu(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        elevation: 0,
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
          'My Resumes',
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
      body: Stack(
        children: [
          Container(
            child: isSignedIn
                ? SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Column(
                          children: [
                            for (int i = 0; i < userResumeDetResponse.length; i++)
                              GestureDetector(
                                onTap: () {
                                  if (userResumeDetResponse.values
                                          .elementAt(i)['filename']
                                          .endsWith("doc") ||
                                      userResumeDetResponse.values
                                          .elementAt(i)['filename']
                                          .endsWith("docx")) {
                                    launch(defaultUrl +
                                        'storage/resumes/${userResumeDetResponse.values.elementAt(i)['filename']}');
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => My_Resumes(
                                                resumePath: defaultUrl +
                                                    'storage/resumes/${userResumeDetResponse.values.elementAt(i)['filename']}'
                                                        .toString())));
                                  }
                                },
                                child: MyResumePreviewWidget(
                                  name: userResumeDetResponse.values.elementAt(i)['name'],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : ResumesNotSignedWidget(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              child: SizedBox(
                height: 60,
                child: (userDetailsResponse["user_type"] == 'user' ||
                        userDetailsResponse["user_type"] == null)
                    ? Component34()
                    : EndDrawer(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: isSignedIn
          ? FloatingActionButton(
              backgroundColor: Color(0xffdd312d),
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Add_Resume()));
              },
            )
          : SizedBox(),
    );
  }
}

class MyResumePreviewWidget extends StatelessWidget {
  final String name;
  const MyResumePreviewWidget({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.book_online_outlined),
              SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: const Color(0xff132144),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
