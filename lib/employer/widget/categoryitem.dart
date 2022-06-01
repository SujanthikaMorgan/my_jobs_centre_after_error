import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  final String catDisplay;
  final Color bgcolor;
  const CategoryItem(
      {Key? key, required this.catDisplay, required this.bgcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: bgcolor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            catDisplay,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.7,
            ),
          ),
        ),
      ),
    );
  }
}
