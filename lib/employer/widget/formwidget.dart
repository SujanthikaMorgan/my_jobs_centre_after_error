// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormWidget extends StatelessWidget {
  final IconData? ic;
  final TextEditingController? controller;
  final Function(String)? onChangedText;
  FormWidget({Key? key, this.ic, this.onChangedText, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: controller,
        onChanged: onChangedText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.black, width: 5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.black, width: 3),
          ),
          labelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          // suffixStyle: TextStyle(fontSize: 15),
          // suffixIconConstraints: BoxConstraints(
          //     minHeight: 25, minWidth: 25, maxHeight: 25, maxWidth: 25),
          suffixIcon: (ic != null)
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: Icon(ic),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
