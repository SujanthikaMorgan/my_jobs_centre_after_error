// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChatWidgetSend extends StatelessWidget {
  final String msg;
  final String date;
  final String recd;
  final String seen;
  const ChatWidgetSend({
    Key? key,
    required this.msg,
    required this.date,
    required this.recd,
    required this.seen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
              bottomLeft: Radius.circular(5.0),
            ),
            // color: const Color(0xffdd312d),
            color: const Color(0xff259CF8),
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
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          color: const Color(0xffDEDEDE),
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5,
                        ),
                        child: Icon(
                          (recd == "1") ? Icons.done_all : Icons.check,
                          color: (seen == "1") ? Color(0xff51DBB7) : Colors.white,
                          size: 15,
                        ),
                      ),
                    ],
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
