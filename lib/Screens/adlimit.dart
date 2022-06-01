import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/Screens/Sign_In.dart';
import 'package:my_jobs_center/Screens/Sign_Up_jobseeker.dart';

class Adlimit extends StatelessWidget {
  static const String idScreen = "NotifyWidget";
  const Adlimit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mainText = "You have reached the ad limit. Upgrade to continue.";


    return Container(
        color: Color(0xfff7f9fc),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                      color: Colors.black,
                    )),
              ),
              Padding(padding: EdgeInsets.only(top: 30,left: 10,right: 10),
              child:    ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 84,
                  minHeight: MediaQuery.of(context).size.width*0.1,
                ),
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                          width: MediaQuery.of(context).size.width*0.001, color: const Color(0xffdd312d)),
                      elevation: MediaQuery.of(context).size.width*0.05,
                      primary: const Color(0xffdd312d),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.01,),
                      ),
                    ),
                    onPressed: () {

                    },
                    child: Text(
                      "Check Payment Plans",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: MediaQuery.of(context).size.width*0.04,
                        color: const Color(0xfff7f9fc),
                        letterSpacing: 0.7000000000000001,
                      ),
                    ),
                  ),
                ),
              ),),

              SizedBox(
                height: 80,
              )
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