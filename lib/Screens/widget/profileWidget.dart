// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/Screens/Sign_In.dart';
import 'package:my_jobs_center/Screens/Sign_Up_jobseeker.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mainText = "Your Profile will be shown here";

    return Container(
        color: Color(0xfff7f9fc),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50, left: 70),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Start hiring",
                      style: kHiring,
                    ),
                    Text(
                      " or ",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Apply for a job",
                      style: kApply,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, right: 250),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image(image: AssetImage("assets/images/logo.png")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, left: 20, right: 30),
                child: Text(mainText,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.none,
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Color(0xffdd312d),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 200, left: 70),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don\'t have an account? ",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontStyle: FontStyle.italic),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Sign_Up_jobseeker.idScreen);
                      },
                      child: Text(
                        "Sign Up Now!",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.none,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffdd312d),
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 80),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontStyle: FontStyle.italic),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignIn.idScreen);
                      },
                      child: Text(
                        "Log In!",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.none,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ));
  }
}

const TextStyle kHiring = TextStyle(
  fontFamily: 'Poppins',
  decoration: TextDecoration.none,
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Colors.green,
);

const TextStyle kApply = TextStyle(
  fontFamily: 'Poppins',
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w600,
  fontSize: 18,
  color: Color(0xffdd312d),
);
