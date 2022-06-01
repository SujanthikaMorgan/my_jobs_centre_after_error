// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/globalVariables.dart';

class EmpUnlock extends StatefulWidget {
  final String imagePath;
  final String name;
  final String balanceCount;
  final void Function()? onPressedUnlock;

  const EmpUnlock({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.balanceCount,
    this.onPressedUnlock,
  }) : super(key: key);

  @override
  _EmpUnlockState createState() => _EmpUnlockState();
}

class _EmpUnlockState extends State<EmpUnlock> {
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
            'Balance: ${widget.balanceCount} contacts left',
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.blueGrey,
                fontSize: 14,
                fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width - 84,
              minHeight: MediaQuery.of(context).size.width * 0.13,
            ),
            child: Container(
              color: const Color(0xff1349a1),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      width: MediaQuery.of(context).size.width * 0.001,
                      color: const Color(0xff1349a1)),
                  elevation: MediaQuery.of(context).size.width * 0.1,
                  primary: const Color(0xff1349a1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.01,
                    ),
                  ),
                ),
                // onPressed: widget.onPressedUnlock,
                onPressed: widget.onPressedUnlock,
                child: Text(
                  "Unlock Chat and Call",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: const Color(0xfff7f9fc),
                    letterSpacing: 0.7000000000000001,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width - 84,
              minHeight: MediaQuery.of(context).size.width * 0.13,
            ),
            child: Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      width: MediaQuery.of(context).size.width * 0.001,
                      color: Colors.white),
                  elevation: MediaQuery.of(context).size.width * 0.1,
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.01,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Not now",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: const Color(0xff1349a1),
                    letterSpacing: 0.7000000000000001,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
