// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:dio/dio.dart';

import '../globalVariables.dart';
import 'Profile.dart';

class ProfChangeImage extends StatefulWidget {
  static const String idScreen = "profileChangeImage";
  const ProfChangeImage({Key? key}) : super(key: key);

  @override
  _ProfChangeImageState createState() => _ProfChangeImageState();
}

class _ProfChangeImageState extends State<ProfChangeImage> {
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

    setState(() => file = File(path));
  }

  Future removeProfPic() async {
    var url = Uri.parse(defaultUrl + 'mob_remove_prof_pic');

    var response =
        await http.post(url, body: json.encode({"id": userDetailsResponse['id']}));
    profRemoveResponse = jsonDecode(response.body);
    print(profRemoveResponse);
  }

  Future uploadFile() async {
    String uploadurl = defaultUrl + "mob_change_prof_pic";

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(file!.path, filename: basename(file!.path)
          //show only filename from path
          ),
      // "name": fileName,
      "id": userDetailsResponse["id"],
      "username": userDetailsResponse["username"],
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
    );

    if (response.statusCode == 200) {
      print(response.toString());
      // setState(() {});
      //print response from server
    } else {
      print("Error during connection to server.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'Change Profile Picture',
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
      backgroundColor: const Color(0xfff7f9fc),
      body: Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: (file != null)
                      ? Image.file(file!)
                      : Image(
                          image: NetworkImage(
                            "https://myjobscentre.com/storage/profile/${userDetailsResponse["image"]}",
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 1.0, color: const Color(0xffdd312d)),
                        elevation: 10.0,
                        primary: const Color(0xfff7f9fc),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        selectFile();
                      },
                      child: Text(
                        "Upload Image",
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
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Use 150x150px image for perfect look. JPEG, JPG, PNG only allowed',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 12,
                      color: const Color(0xb2788198),
                    ),
                    textAlign: TextAlign.left,
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
                        setState(() {
                          data["file"] = file;
                          data["name"] = fileName;
                          // data["name"] = fileName;
                        });
                        // uploadResume();
                        uploadFile().then((value) =>
                            Navigator.popAndPushNamed(context, Profile.idScreen));
                      },
                      child: Text(
                        "Save",
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
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: 40,
                  ),
                  child: Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Color(0xff707070),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        removeProfPic().then((value) => Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => Profile())));
                      },
                      child: Text(
                        "Remove Image",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          letterSpacing: 0.7000000000000001,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
