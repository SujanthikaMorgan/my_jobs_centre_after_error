// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:my_jobs_center/Screens/model/list_item.dart';

class ListItemWidget extends StatelessWidget {
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  const ListItemWidget(
      {required this.item,
      required this.animation,
      required this.onClicked,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      SizeTransition(sizeFactor: animation, child: buildItem());

  Widget buildItem() => Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Image(image: AssetImage(item.image)),
          title: Text(
            item.title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              color: const Color(0xff132144),
            ),
          ),
          trailing: (item.isIcon)
              ? IconButton(
                  onPressed: onClicked,
                  icon: Icon(Icons.delete),
                  color: Color(0xffDD312D),
                )
              : SizedBox(),
          subtitle: Text(
            item.mail,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: const Color(0x99132144),
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      );
}
