// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_jobs_center/employer/employer%20screens/myCompany.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/formwidget.dart';
import 'package:my_jobs_center/employer/widget/pallette.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:path/path.dart';

class CreateCompany extends StatefulWidget {
  static const String idScreen = "CreateCompany";
  const CreateCompany({Key? key}) : super(key: key);

  @override
  _CreateCompanyState createState() => _CreateCompanyState();
}

class _CreateCompanyState extends State<CreateCompany> {
  String compName = "";
  String description = "";
  String city = "";
  String phone = "";
  String fax = "";
  String email = "";
  String web = "";
  String facebook = "";
  String twitter = "";
  String linkedIn = "";
  String pinterest = "";
  String youtube = "";
  String instagram = "";
  String fileNameDisp = "";

  String dropdownval = "Select City";
  List items = ['Select City'];

  File? file;
  Map profRemoveResponse = {};
  Map data = {};
  String fileName = "";
  Dio dio = new Dio();
  bool isSuccess = false;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      fileNameDisp = result.files.single.name;
    });

    setState(() => file = File(path));
  }

  Future createCompany() async {
    // String uploadurl = "http://10.0.2.2/myjobscenter/demo/mob_add_company";
    String uploadurl = defaultUrl + "mob_add_company";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(file!.path,
          filename: basename(file!.path)
          //show only filename from path
          ),
      "user_id": userDetailsResponse['id'],
      "username": userDetailsResponse['username'],
      "name": compName,
      "company_desc": description,
      "city": city,
      "phone": phone,
      "fax": fax,
      "email": email,
      "website": web,
      "facebook": facebook,
      "twitter": twitter,
      "linkedin": linkedIn,
      "pinterest": pinterest,
      "youtube": youtube,
      "instagram": instagram,

      // "name": fileName,
      // "id": userDetailsResponse["id"],
      // "username": userDetailsResponse["username"],
      // "name": fileName,
    });

    print(formdata.fields);

    var response = await dio.post(
      uploadurl,
      data: formdata,
      options: Options(
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
        // headers: headers,
      ),
      // onSendProgress: (int sent, int total) {
      //   String percentage = (sent / total * 100).toStringAsFixed(2);
      //   setState(() {
      //     progress = "$sent" +
      //         " Bytes of " "$total Bytes - " +
      //         percentage +
      //         " % uploaded";
      //     //update the progress
      //   });
      // },
    );

    if (response.statusCode == 200) {
      print(response.toString());
      print(response.data);
      // setState(() {});
      //print response from server
    } else {
      print("Error during connection to server.");
    }
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
          "Create New Company",
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Name *",
                      style: formtext,
                    ),
                  ),
                  FormWidget(
                    onChangedText: (value) {
                      setState(() {
                        compName = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Logo",
                      style: formtext,
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Container(
                                  height: 50,
                                  width: 160,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                          width: 1.0,
                                          color: const Color(0xffdd312d)),
                                      elevation: 10.0,
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      selectFile();
                                    },
                                    child: Text(
                                      "Upload Logo",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
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
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Use 200x200px size for better view.",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 17,
                                      color: Colors.grey,
                                      letterSpacing: 0.7000000000000001,
                                    ),
                                    // overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Visibility(
                      visible: (file != null),
                      child: Text(
                        fileNameDisp,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          color: Colors.grey,
                          letterSpacing: 0.7000000000000001,
                        ),
                        // overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Description *",
                      style: formtext,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                BorderSide(color: Colors.black, width: 5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                BorderSide(color: Colors.black, width: 3),
                          ),
                          labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          )),
                      maxLines: 8,
                      minLines: 3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "City",
                      style: formtext,
                    ),
                  ),
                  FormWidget(
                    // ic: '',
                    onChangedText: (value) {
                      setState(() {
                        city = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                        /* child: DropdownButton(
                         value: dropdownval,
                         icon: Icon(
                           Icons.more_horiz,
                         ),
                         items: items.map((String items) {
                           return DropdownMenuItem(
                             value: items,
                             child: Text(items),
                           );
                         }).toList(),
                         onChanged: (String? value) {
                           setState(() {});
                         },
                       ),*/
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Phone Number",
                      style: formtext,
                    ),
                  ),
                  FormWidget(
                    ic: FontAwesomeIcons.phoneAlt,
                    onChangedText: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Fax",
                      style: formtext,
                    ),
                  ),
                  FormWidget(
                    ic: FontAwesomeIcons.fax,
                    onChangedText: (value) {
                      fax = value;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Email Address",
                      style: formtext,
                    ),
                  ),
                  FormWidget(
                    ic: FontAwesomeIcons.envelope,
                    onChangedText: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Website",
                      style: formtext,
                    ),
                  ),
                  FormWidget(
                    ic: FontAwesomeIcons.link,
                    onChangedText: (value) {
                      setState(() {
                        value = web;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Facebook",
                      style: formtext,
                    ),
                  ),
                  FormWidget(
                    ic: FontAwesomeIcons.facebookF,
                    onChangedText: (value) {
                      setState(() {
                        facebook = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Twitter",
                      style: formtext,
                    ),
                  ),
                  FormWidget(
                    ic: FontAwesomeIcons.twitter,
                    onChangedText: (value) {
                      setState(() {
                        twitter = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "LinkedIn",
                      style: formtext,
                    ),
                  ),
                  FormWidget(
                    ic: FontAwesomeIcons.linkedinIn,
                    onChangedText: (value) {
                      setState(() {
                        linkedIn = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Pinterest",
                      style: formtext,
                    ),
                  ),
                  FormWidget(
                    ic: FontAwesomeIcons.pinterestP,
                    onChangedText: (value) {
                      setState(() {
                        pinterest = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Youtube",
                      style: formtext,
                    ),
                  ),
                  FormWidget(
                    ic: FontAwesomeIcons.youtube,
                    onChangedText: (value) {
                      setState(() {
                        youtube = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Instagram",
                      style: formtext,
                    ),
                  ),
                  FormWidget(
                    ic: FontAwesomeIcons.instagram,
                    onChangedText: (value) {
                      setState(() {
                        instagram = value;
                      });
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 10),
                      child: Container(
                        height: 50,
                        width: 350,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                width: 1.0, color: const Color(0xffdd312d)),
                            elevation: 10.0,
                            primary: const Color(0xffdd312d),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            // print(compName);
                            createCompany().then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyCompanies())));
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              color: Colors.white,
                              letterSpacing: 0.7000000000000001,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

String phn =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 32 32"><rect x="0" y="0" width="32" height="32" fill="none" stroke="none" /><path d="M26 29h-.17C6.18 27.87 3.39 11.29 3 6.23A3 3 0 0 1 5.76 3h5.51a2 2 0 0 1 1.86 1.26L14.65 8a2 2 0 0 1-.44 2.16l-2.13 2.15a9.37 9.37 0 0 0 7.58 7.6l2.17-2.15a2 2 0 0 1 2.17-.41l3.77 1.51A2 2 0 0 1 29 20.72V26a3 3 0 0 1-3 3zM6 5a1 1 0 0 0-1 1v.08C5.46 12 8.41 26 25.94 27a1 1 0 0 0 1.06-.94v-5.34l-3.77-1.51l-2.87 2.85l-.48-.06c-8.7-1.09-9.88-9.79-9.88-9.88l-.06-.48l2.84-2.87L11.28 5z" fill="gray"/></svg>';
String faxS =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 512 512"><rect x="0" y="0" width="512" height="512" fill="none" stroke="none" /><path fill="gray" d="M487.944 233.654L424 176.815V89.373L350.627 16H152v128H80a24.028 24.028 0 0 0-24 24v304a24.028 24.028 0 0 0 24 24h416V251.593a24.024 24.024 0 0 0-8.056-17.939zM152 464H88V176h64zM328 48h9.373L392 102.627V112h-64zm-144 0h112v96h96v72H184zm280 416H184V248h240v-28.371l40 35.557z"/><path fill="gray" d="M232 344h32v32h-32z"/><path fill="gray" d="M296 344h32v32h-32z"/><path fill="gray" d="M232 408h32v32h-32z"/><path fill="gray" d="M296 408h32v32h-32z"/><path fill="gray" d="M360 344h32v32h-32z"/><path fill="gray" d="M360 408h32v32h-32z"/><path fill="gray" d="M232 280h160v32H232z"/></svg>';
String mailS =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><g fill="none" stroke="gray" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><path d="M22 6l-10 7L2 6"/></g></svg>';
String linkS =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><g fill="none"><path d="M13.544 10.456a4.368 4.368 0 0 0-6.176 0l-3.089 3.088a4.367 4.367 0 1 0 6.177 6.177L12 18.177" stroke="gray" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/><path d="M10.456 13.544a4.368 4.368 0 0 0 6.176 0l3.089-3.088a4.367 4.367 0 1 0-6.177-6.177L12 5.823" stroke="gray" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></g></svg>';
String facebookS =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="0.49em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 486.037 1000"><rect x="0" y="0" width="486.037" height="1000" fill="none" stroke="none" /><path d="M124.074 1000V530.771H0V361.826h124.074V217.525C124.074 104.132 197.365 0 366.243 0C434.619 0 485.18 6.555 485.18 6.555l-3.984 157.766s-51.564-.502-107.833-.502c-60.9 0-70.657 28.065-70.657 74.646v123.361h183.331l-7.977 168.945H302.706V1000H124.074" fill="gray"/></svg>';
String twitterS =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 48 48"><rect x="0" y="0" width="48" height="48" fill="none" stroke="none" /><path d="M5 35.762c1.929 1.067 15.891 9.115 25.82 2.912c9.928-6.203 9.38-16.89 9.38-21.788c.9-1.884 2.8-2.842 2.8-7.942c-1.866 1.724-3.721 2.31-5.565 1.76c-1.806-2.754-4.291-3.973-7.456-3.655c-4.746.477-6.482 5.133-5.971 11.158c-7.318 3.7-13.056-2.683-16.014-7.503c-.988 3.796-1.94 8.354 0 13.395c1.294 3.362 4.405 6.203 9.331 8.526C12.332 35.33 8.224 36.377 5 35.762z" stroke="gray" stroke-width="4" stroke-linejoin="round" fill="none"/></svg>';
String linkedinS =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><path d="M20 22h-1.67a2 2 0 0 1-2-2v-5.37a.92.92 0 0 0-.69-.93a.84.84 0 0 0-.67.19a.85.85 0 0 0-.3.65V20a2 2 0 0 1-2 2H11a2 2 0 0 1-2-2v-5.46a6.5 6.5 0 1 1 13 0V20a2 2 0 0 1-2 2zm-4.5-10.31a3.73 3.73 0 0 1 .47 0a2.91 2.91 0 0 1 2.36 2.9V20H20v-5.46a4.5 4.5 0 1 0-9 0V20h1.67v-5.46a2.85 2.85 0 0 1 2.83-2.85zM6 22H4a2 2 0 0 1-2-2V10a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2zM4 10v10h2V10zm1-3a3 3 0 1 1 3-3a3 3 0 0 1-3 3zm0-4a1 1 0 1 0 1 1a1 1 0 0 0-1-1z" fill="gray"/></svg>';
String pinterestS =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><path d="M5.077 9.457c0-.778.136-1.513.404-2.199a5.63 5.63 0 0 1 1.121-1.802a7.614 7.614 0 0 1 1.644-1.329a7.513 7.513 0 0 1 2.002-.844a8.57 8.57 0 0 1 2.185-.281c1.139 0 2.199.241 3.182.721a6.021 6.021 0 0 1 2.391 2.094c.614.915.919 1.95.919 3.104c0 .692-.068 1.369-.207 2.031a8.28 8.28 0 0 1-.646 1.913a6.605 6.605 0 0 1-1.082 1.617a4.723 4.723 0 0 1-1.568 1.114a4.962 4.962 0 0 1-2.045.417c-.489 0-.977-.115-1.459-.346c-.482-.23-.828-.546-1.036-.951c-.073.281-.173.687-.306 1.218c-.128.53-.214.872-.252 1.027c-.04.154-.114.411-.222.767a5.183 5.183 0 0 1-.281.769l-.344.674a7.98 7.98 0 0 1-.498.838c-.181.262-.405.575-.672.935l-.149.053l-.099-.108c-.107-1.133-.162-1.811-.162-2.035c0-.663.079-1.407.235-2.233c.153-.825.395-1.862.72-3.109c.325-1.246.511-1.979.561-2.196c-.229-.467-.345-1.077-.345-1.827c0-.599.187-1.16.562-1.688c.376-.526.851-.789 1.427-.789c.441 0 .783.146 1.028.439c.246.292.366.66.366 1.109c0 .476-.158 1.165-.476 2.066c-.318.902-.476 1.575-.476 2.022c0 .453.162.832.486 1.129a1.68 1.68 0 0 0 1.179.449c.396 0 .763-.09 1.104-.271a2.46 2.46 0 0 0 .849-.733a6.123 6.123 0 0 0 1.017-2.225c.096-.422.17-.823.216-1.2c.049-.379.07-.737.07-1.077c0-1.247-.396-2.219-1.183-2.915c-.791-.696-1.821-1.042-3.088-1.042c-1.441 0-2.646.466-3.611 1.401c-.966.932-1.452 2.117-1.452 3.554c0 .317.048.623.139.919c.089.295.186.53.291.704c.104.171.202.338.291.492c.09.154.137.264.137.33c0 .202-.053.465-.16.79c-.111.325-.242.487-.4.487c-.015 0-.077-.011-.185-.034a2.21 2.21 0 0 1-.979-.605a3.17 3.17 0 0 1-.659-1.022a6.986 6.986 0 0 1-.352-1.169a4.884 4.884 0 0 1-.132-1.153z" fill="gray"/></svg>';
String youtubeS =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 32 32"><rect x="0" y="0" width="32" height="32" fill="none" stroke="none" /><path d="M16 6c-3.766 0-7.094.39-9.125.688c-1.68.246-3.035 1.511-3.344 3.187C3.27 11.301 3 13.387 3 16s.27 4.7.531 6.125c.309 1.676 1.664 2.945 3.344 3.188c2.04.296 5.379.687 9.125.687c3.746 0 7.086-.39 9.125-.688c1.68-.242 3.035-1.511 3.344-3.187c.261-1.43.531-3.52.531-6.125s-.266-4.695-.531-6.125c-.309-1.676-1.664-2.941-3.344-3.188C23.094 6.391 19.765 6 16 6zm0 2c3.633 0 6.879.371 8.844.656A1.966 1.966 0 0 1 26.5 10.25c.242 1.32.5 3.277.5 5.75c0 2.469-.258 4.43-.5 5.75a1.957 1.957 0 0 1-1.656 1.594C22.87 23.629 19.609 24 16 24c-3.61 0-6.875-.371-8.844-.656A1.962 1.962 0 0 1 5.5 21.75C5.258 20.43 5 18.477 5 16c0-2.48.258-4.43.5-5.75a1.962 1.962 0 0 1 1.656-1.594C9.117 8.371 12.367 8 16 8zm-3 2.281V21.72l1.5-.844l7-4L23 16l-1.5-.875l-7-4zm2 3.438L18.969 16L15 18.281z" fill="gray"/></svg>';
String instaS =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="50" height="50" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1024 1024"><rect x="0" y="0" width="1024" height="1024" fill="none" stroke="none" /><path d="M512 306.9c-113.5 0-205.1 91.6-205.1 205.1S398.5 717.1 512 717.1S717.1 625.5 717.1 512S625.5 306.9 512 306.9zm0 338.4c-73.4 0-133.3-59.9-133.3-133.3S438.6 378.7 512 378.7S645.3 438.6 645.3 512S585.4 645.3 512 645.3zm213.5-394.6c-26.5 0-47.9 21.4-47.9 47.9s21.4 47.9 47.9 47.9s47.9-21.3 47.9-47.9a47.84 47.84 0 0 0-47.9-47.9zM911.8 512c0-55.2.5-109.9-2.6-165c-3.1-64-17.7-120.8-64.5-167.6c-46.9-46.9-103.6-61.4-167.6-64.5c-55.2-3.1-109.9-2.6-165-2.6c-55.2 0-109.9-.5-165 2.6c-64 3.1-120.8 17.7-167.6 64.5C132.6 226.3 118.1 283 115 347c-3.1 55.2-2.6 109.9-2.6 165s-.5 109.9 2.6 165c3.1 64 17.7 120.8 64.5 167.6c46.9 46.9 103.6 61.4 167.6 64.5c55.2 3.1 109.9 2.6 165 2.6c55.2 0 109.9.5 165-2.6c64-3.1 120.8-17.7 167.6-64.5c46.9-46.9 61.4-103.6 64.5-167.6c3.2-55.1 2.6-109.8 2.6-165zm-88 235.8c-7.3 18.2-16.1 31.8-30.2 45.8c-14.1 14.1-27.6 22.9-45.8 30.2C695.2 844.7 570.3 840 512 840c-58.3 0-183.3 4.7-235.9-16.1c-18.2-7.3-31.8-16.1-45.8-30.2c-14.1-14.1-22.9-27.6-30.2-45.8C179.3 695.2 184 570.3 184 512c0-58.3-4.7-183.3 16.1-235.9c7.3-18.2 16.1-31.8 30.2-45.8s27.6-22.9 45.8-30.2C328.7 179.3 453.7 184 512 184s183.3-4.7 235.9 16.1c18.2 7.3 31.8 16.1 45.8 30.2c14.1 14.1 22.9 27.6 30.2 45.8C844.7 328.7 840 453.7 840 512c0 58.3 4.7 183.2-16.2 235.8z" fill="gray"/></svg>';
  //  '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1024 1024"><rect x="0" y="0" width="1024" height="1024" fill="none" stroke="none" /><path d="M512 306.9c-113.5 0-205.1 91.6-205.1 205.1S398.5 717.1 512 717.1S717.1 625.5 717.1 512S625.5 306.9 512 306.9zm0 338.4c-73.4 0-133.3-59.9-133.3-133.3S438.6 378.7 512 378.7S645.3 438.6 645.3 512S585.4 645.3 512 645.3zm213.5-394.6c-26.5 0-47.9 21.4-47.9 47.9s21.4 47.9 47.9 47.9s47.9-21.3 47.9-47.9a47.84 47.84 0 0 0-47.9-47.9zM911.8 512c0-55.2.5-109.9-2.6-165c-3.1-64-17.7-120.8-64.5-167.6c-46.9-46.9-103.6-61.4-167.6-64.5c-55.2-3.1-109.9-2.6-165-2.6c-55.2 0-109.9-.5-165 2.6c-64 3.1-120.8 17.7-167.6 64.5C132.6 226.3 118.1 283 115 347c-3.1 55.2-2.6 109.9-2.6 165s-.5 109.9 2.6 165c3.1 64 17.7 120.8 64.5 167.6c46.9 46.9 103.6 61.4 167.6 64.5c55.2 3.1 109.9 2.6 165 2.6c55.2 0 109.9.5 165-2.6c64-3.1 120.8-17.7 167.6-64.5c46.9-46.9 61.4-103.6 64.5-167.6c3.2-55.1 2.6-109.8 2.6-165zm-88 235.8c-7.3 18.2-16.1 31.8-30.2 45.8c-14.1 14.1-27.6 22.9-45.8 30.2C695.2 844.7 570.3 840 512 840c-58.3 0-183.3 4.7-235.9-16.1c-18.2-7.3-31.8-16.1-45.8-30.2c-14.1-14.1-22.9-27.6-30.2-45.8C179.3 695.2 184 570.3 184 512c0-58.3-4.7-183.3 16.1-235.9c7.3-18.2 16.1-31.8 30.2-45.8s27.6-22.9 45.8-30.2C328.7 179.3 453.7 184 512 184s183.3-4.7 235.9 16.1c18.2 7.3 31.8 16.1 45.8 30.2c14.1 14.1 22.9 27.6 30.2 45.8C844.7 328.7 840 453.7 840 512c0 58.3 4.7 183.2-16.2 235.8z" fill="gray"/></svg>';
