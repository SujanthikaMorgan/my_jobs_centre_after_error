import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:my_jobs_center/globalVariables.dart';

class Component61 extends StatefulWidget {
  Component61({
    Key? key,
  }) : super(key: key);

  @override
  _Component61State createState() => _Component61State();
}

class _Component61State extends State<Component61>
    with SingleTickerProviderStateMixin {
  int? groupValue = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.width*0.05,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.0025,),
        color: const Color(0xffffffff),
      ),
      child: CupertinoSlidingSegmentedControl(
          backgroundColor: Color(0xffffffff),
          thumbColor: Color(0xffdd312d),
          children: {
            0: Container(
              constraints: BoxConstraints(
                minHeight: 37,
                minWidth: isSignUpEmployer
                    ? MediaQuery.of(context).size.height * 0.2
                    : MediaQuery.of(context).size.height * 0.2 - 25,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.0025,),
              ),
              child: Center(
                child: Text(
                  'Employer',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: MediaQuery.of(context).size.width*0.035,
                    color: isSignUpEmployer
                        ? Color(0xffffffff)
                        : Color(0xff707070),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            1: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.width*0.05,
                minWidth: !isSignUpEmployer
                    ? MediaQuery.of(context).size.height * 0.2
                    : MediaQuery.of(context).size.height * 0.2 - 25,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.0025,),
              ),
              child: Center(
                child: Text(
                  'Job Seeker',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: MediaQuery.of(context).size.width*0.035,
                    color: !isSignUpEmployer
                        ? Color(0xffffffff)
                        : Color(0xff707070),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          },
          groupValue: groupValue,
          onValueChanged: (onValueChanged) {
            setState(() {
              groupValue = onValueChanged as int?;
              if (onValueChanged == 0) {
                setState(() {
                  isSignUpEmployer = true;
                  signupUserType = 'employer';
                });
              } else {
                setState(() {
                  isSignUpEmployer = false;
                  signupUserType = 'user';
                });
              }
            });
          }),
    );
  }
}
