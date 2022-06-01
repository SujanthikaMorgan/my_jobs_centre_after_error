// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChatWidgetRecieved extends StatelessWidget {
  final String msg;
  final String date;
  const ChatWidgetRecieved({
    Key? key,
    required this.msg,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
            // minWidth: MediaQuery.of(context).size.width * 0.1,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
            ),
            // color: const Color(0xff132144),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    msg,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      // color: const Color(0xffffffff),
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    date,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: const Color(0xff9ca5bc),
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.left,
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
