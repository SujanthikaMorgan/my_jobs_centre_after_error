import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageList extends StatelessWidget {
  const ImageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 30.w,
      child: const Image(image: AssetImage("assets/join.jpg")),
    );
  }
}
