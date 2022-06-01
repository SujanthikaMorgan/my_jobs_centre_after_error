// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChatPreviewComponent extends StatefulWidget {
  final String userName;
  final String msg;
  final String image;
  final String time;
  final int unseen;
  const ChatPreviewComponent({
    Key? key,
    required this.userName,
    required this.msg,
    required this.image,
    required this.time,
    required this.unseen,
  }) : super(key: key);

  @override
  State<ChatPreviewComponent> createState() => _ChatPreviewComponentState();
}

class _ChatPreviewComponentState extends State<ChatPreviewComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            child: CircleAvatar(
                              backgroundColor: const Color(0xff707070),
                              backgroundImage: NetworkImage(
                                "https://myjobscentre.com/storage/profile/${widget.image}",
                              ),
                              radius: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 4),
                          child: Text(
                            widget.userName,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xff132144),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            widget.msg.length > 40
                                ? '${widget.msg.substring(0, 40)}...'
                                : widget.msg,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              color: const Color(0xff132144),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Visibility(
                          visible: (widget.unseen == 0) ? false : true,
                          child: Container(
                            width: 17.0,
                            height: 17.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xffdd312d),
                              // borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                widget.unseen.toString(),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        widget.time,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          color: const Color(0xff7f889f),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xff132144),
                      width: 0.5,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
