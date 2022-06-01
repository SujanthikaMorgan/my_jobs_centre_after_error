// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  final String imgPath;
  final String catDisplay;
  const CategoryItemWidget(
      {Key? key, required this.imgPath, required this.catDisplay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Column(
                children: [
                  Image(
                    image: NetworkImage(
                      imgPath,
                    ),
                    height: 15,
                    width: 15,
                  )
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  Text(
                    catDisplay,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: const Color(0xff444444),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
