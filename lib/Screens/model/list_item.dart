import 'package:flutter/material.dart';

class ListItem {
  final String title;
  final String mail;
  final String image;
  final String colName;
  final bool isIcon;

  const ListItem(
      {required this.title,
      required this.mail,
      required this.image,
      required this.colName,
      required this.isIcon});
}
