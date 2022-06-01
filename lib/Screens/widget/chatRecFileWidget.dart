// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../My_Resumes.dart';

class ChatRecFileWidget extends StatefulWidget {
  final String date;
  final String title;
  final String path;

  const ChatRecFileWidget({
    Key? key,
    required this.date,
    required this.title,
    required this.path,
  }) : super(key: key);

  @override
  State<ChatRecFileWidget> createState() => _ChatRecFileWidgetState();
}

class _ChatRecFileWidgetState extends State<ChatRecFileWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
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
                    child: Row(
                      children: [
                        Icon(
                          Icons.book_online_outlined,
                          // color: const Color(0xffffffff),
                          color: Colors.black,
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
                              // color: const Color(0xffffffff),
                              color: Colors.black,
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
                    child: Text(
                      widget.date,
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
      ),
    );
  }
}
