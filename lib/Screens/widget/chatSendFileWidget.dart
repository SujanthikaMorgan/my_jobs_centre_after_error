// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../My_Resumes.dart';

class ChatSendFileWidget extends StatefulWidget {
  final String date;
  final String title;
  final String path;
  final String recd;
  final String seen;

  const ChatSendFileWidget({
    Key? key,
    required this.date,
    required this.title,
    required this.path,
    required this.recd,
    required this.seen,
  }) : super(key: key);

  @override
  State<ChatSendFileWidget> createState() => _ChatSendFileWidgetState();
}

class _ChatSendFileWidgetState extends State<ChatSendFileWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          if (widget.title.endsWith("doc") || widget.title.endsWith("docx")) {
            launch(widget.path);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        My_Resumes(resumePath: widget.path.toString())));
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
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
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Icon(
                          Icons.book_online_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            widget.title + "\n(Tap to open file)",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.date,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: const Color(0xff9ca5bc),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                          ),
                          child: Icon(
                            (widget.recd == "1") ? Icons.done_all : Icons.check,
                            color:
                                (widget.seen == "1") ? Color(0xff51DBB7) : Colors.white,
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
      ),
    );
  }
}
