// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/globalVariables.dart';

class EmpUnlockNoLimit extends StatefulWidget {
  final String imagePath;
  final String name;
  final void Function()? onPressedMembership;

  const EmpUnlockNoLimit({
    Key? key,
    required this.imagePath,
    required this.name,
    this.onPressedMembership,
  }) : super(key: key);

  @override
  _EmpUnlockNoLimitState createState() => _EmpUnlockNoLimitState();
}

class _EmpUnlockNoLimitState extends State<EmpUnlockNoLimit> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 8,
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: NetworkImage(
                  "$profImgLink${widget.imagePath}",
                ),
                height: 100,
                width: 100,
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'Unlock Chat and Call with ',
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Center(
            child: Text(
              widget.name,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'Sorry, your credit limit exceeded you have to upgrade your',
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.red.shade700,
                fontSize: 14,
                fontWeight: FontWeight.w300),
          ),
        ),
        GestureDetector(
          onTap: widget.onPressedMembership,
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              'Membership Plan',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.red.shade700,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              'Not Now',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.red.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 15.0),
        //   child: ConstrainedBox(
        //     constraints: BoxConstraints(
        //       minWidth: MediaQuery.of(context).size.width - 84,
        //       minHeight: MediaQuery.of(context).size.width * 0.13,
        //     ),
        //     child: Container(
        //       child: ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //           side: BorderSide(
        //               width: MediaQuery.of(context).size.width * 0.001,
        //               color: const Color(0xff1349a1)),
        //           elevation: MediaQuery.of(context).size.width * 0.1,
        //           primary: const Color(0xff1349a1),
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(
        //               MediaQuery.of(context).size.width * 0.01,
        //             ),
        //           ),
        //         ),
        //         onPressed: widget.onPressedUnlock,
        //         child: Text(
        //           "Unlock Chat and Call",
        //           style: TextStyle(
        //             fontFamily: 'Poppins',
        //             fontSize: MediaQuery.of(context).size.width * 0.04,
        //             color: const Color(0xfff7f9fc),
        //             letterSpacing: 0.7000000000000001,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 15.0),
        //   child: ConstrainedBox(
        //     constraints: BoxConstraints(
        //       minWidth: MediaQuery.of(context).size.width - 84,
        //       minHeight: MediaQuery.of(context).size.width * 0.13,
        //     ),
        //     child: Container(
        //       child: ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //           side: BorderSide(
        //               width: MediaQuery.of(context).size.width * 0.001,
        //               color: Colors.white),
        //           elevation: MediaQuery.of(context).size.width * 0.1,
        //           primary: Colors.white,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(
        //               MediaQuery.of(context).size.width * 0.01,
        //             ),
        //           ),
        //         ),
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //         child: Text(
        //           "Not now",
        //           style: TextStyle(
        //             fontFamily: 'Poppins',
        //             fontSize: MediaQuery.of(context).size.width * 0.04,
        //             color: const Color(0xff1349a1),
        //             letterSpacing: 0.7000000000000001,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
