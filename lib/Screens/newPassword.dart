// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class NewPasswordPage extends StatefulWidget {
  static const String idScreen = "newPassworPage";
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
              ),
              child: Column(
                children: [
                  Container(
                    child: Image(
                      image: NetworkImage(
                          'https://www.myjobscentre.com/storage/logo/classic-theme_logo.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      'New Password',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: const Color(0xffdd312d),
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Enter New Password',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: const Color(0xffdd312d),
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                      ),
                      child: TextField(
                        // maxLines: 2,

                        onChanged: (value) {},
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Icon(
                                Icons.lock,
                                color: Color(0xff444444),
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'New Password',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0x99444444),
                              fontWeight: FontWeight.w300,
                            )),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                      ),
                      child: TextField(
                        // maxLines: 2,

                        onChanged: (value) {},
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Icon(
                                Icons.lock,
                                color: Color(0xff444444),
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0x99444444),
                              fontWeight: FontWeight.w300,
                            )),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                        minHeight: 50,
                      ),
                      child: Container(
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
                            Navigator.pushNamed(
                                context, NewPasswordPage.idScreen);
                          },
                          child: Text(
                            "Reset Password",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
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
          ),
        ),
      ),
    );
  }
}
