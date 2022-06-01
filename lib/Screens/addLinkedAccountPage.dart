// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_jobs_center/Screens/Profile.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:http/http.dart' as http;

class AddLinkedAccountPage extends StatefulWidget {
  static const String idScreen = 'addLinkedAccountPage';
  const AddLinkedAccountPage({Key? key}) : super(key: key);

  @override
  _AddLinkedAccountPageState createState() => _AddLinkedAccountPageState();
}

class _AddLinkedAccountPageState extends State<AddLinkedAccountPage> {
  late TextEditingController _controllerWebsite;
  late TextEditingController _controllerFacebook;
  late TextEditingController _controllertwitter;
  late TextEditingController _controllerInstagram;
  late TextEditingController _controllerLinkedIn;
  late TextEditingController _controllerYoutube;
  var websiteLink;
  var facebookId;
  var twitterId;
  var instaId;
  var linkedInID;
  var youtubeLink;
  var gplusId;
  Map dataLinked = {};
  var responseAddLinkedAcc;

  //---------------------------add linked accounts----------------------
  Future addLinkedAccount() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_add_linked_acc');
    var url = Uri.parse(defaultUrl + 'mob_add_linked_acc');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    // var response = await http.post(urrr, body: json.encode(data));
    var response = await http.post(url, body: json.encode(dataLinked));
    responseAddLinkedAcc = jsonDecode(response.body);
    print(responseAddLinkedAcc);
    if (responseAddLinkedAcc['msg'] == 'Successfully updated') {
      Fluttertoast.showToast(msg: "Successfully updated");
      Navigator.popAndPushNamed(context, Profile.idScreen);
    }

    // setState(() {
    //   isSpin = false;
    // });

    // Getting Server response into variable.
    // print(userDetailsResponse.body.toString());
    // Map a = jsonDecode(userDetailsResponse.body);
    // print(a["name"]);
  }

  void initState() {
    // _dbCheckProfPersonal();
    _controllerWebsite = TextEditingController(
      text: (userDetailsResponse["website"] == null)
          ? ""
          : userDetailsResponse["website"],
    );
    _controllerFacebook = TextEditingController(
      text: (userDetailsResponse["facebook"] == null)
          ? ""
          : userDetailsResponse["facebook"],
    );
    _controllertwitter = TextEditingController(
      text: (userDetailsResponse["twitter"] == null)
          ? ""
          : userDetailsResponse["twitter"],
    );
    _controllerInstagram = TextEditingController(
      text: (userDetailsResponse["googleplus"] == null)
          ? ""
          : userDetailsResponse["googleplus"],
    );

    _controllerInstagram = TextEditingController(
      text: (userDetailsResponse["instagram"] == null)
          ? ""
          : userDetailsResponse["instagram"],
    );
    _controllerLinkedIn = TextEditingController(
      text: (userDetailsResponse["linkedin"] == null)
          ? ""
          : userDetailsResponse["linkedin"],
    );
    _controllerYoutube = TextEditingController(
      text: (userDetailsResponse["youtube"] == null)
          ? ""
          : userDetailsResponse["youtube"],
    );
    setState(() {
      websiteLink = (userDetailsResponse["website"] == null)
          ? ""
          : userDetailsResponse["website"];
      facebookId = (userDetailsResponse["facebook"] == null)
          ? ""
          : userDetailsResponse["facebook"];
      twitterId = (userDetailsResponse["twitter"] == null)
          ? ""
          : userDetailsResponse["twitter"];
      gplusId = (userDetailsResponse["googleplus"] == null)
          ? ""
          : userDetailsResponse["googleplus"];
      instaId = (userDetailsResponse["instagram"] == null)
          ? ""
          : userDetailsResponse["instagram"];
      linkedInID = (userDetailsResponse["linkedin"] == null)
          ? ""
          : userDetailsResponse["linkedin"];
      youtubeLink = (userDetailsResponse["youtube"] == null)
          ? ""
          : userDetailsResponse["youtube"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xff1d1d1d)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Profile",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: const Color(0xff1d1d1d),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xfff7f9fc),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 40,
            right: 40,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: _controllerWebsite,
                  onChanged: (value) {
                    setState(() {
                      websiteLink = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.link,
                      color: Colors.grey,
                    ),
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Website",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: _controllerFacebook,
                  onChanged: (value) {
                    setState(() {
                      facebookId = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Facebook",
                    prefixIcon: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: _controllertwitter,
                  onChanged: (value) {
                    setState(() {
                      twitterId = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Twitter",
                    prefixIcon: Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: _controllerInstagram,
                  onChanged: (value) {
                    setState(() {
                      instaId = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Instagram",
                    prefixIcon: Icon(
                      FontAwesomeIcons.instagram,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: _controllerLinkedIn,
                  onChanged: (value) {
                    setState(() {
                      linkedInID = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "LinkedIn",
                    prefixIcon: Icon(
                      FontAwesomeIcons.linkedinIn,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: _controllerYoutube,
                  onChanged: (value) {
                    setState(() {
                      youtubeLink = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Youtube",
                    prefixIcon: Icon(
                      FontAwesomeIcons.youtube,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width - 100,
                        minHeight: 45,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10.0,
                          primary: Color(0xffDD312D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            dataLinked['id'] = userDetailsResponse['id'];
                            if (websiteLink != "") {
                              dataLinked['website'] = websiteLink;
                            } else {
                              dataLinked['website'] = null;
                            }
                            if (facebookId != "") {
                              dataLinked['facebook'] = facebookId;
                            } else {
                              dataLinked['facebook'] = null;
                            }
                            if (twitterId != "") {
                              dataLinked['twitter'] = twitterId;
                            } else {
                              dataLinked['twitter'] = null;
                            }
                            if (instaId != "") {
                              dataLinked['instagram'] = instaId;
                            } else {
                              dataLinked['instagram'] = null;
                            }
                            if (linkedInID != "") {
                              dataLinked['linkedin'] = linkedInID;
                            } else {
                              dataLinked['linkedin'] = null;
                            }
                            if (youtubeLink != "") {
                              dataLinked['youtube'] = youtubeLink;
                            } else {
                              dataLinked['youtube'] = null;
                            }
                          });
                          // print(dataLinked);
                          addLinkedAccount();
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
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
