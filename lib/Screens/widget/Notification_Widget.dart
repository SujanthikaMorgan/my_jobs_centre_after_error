import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_jobs_center/Screens/model/notify_list.dart';

class NotificationWidget extends StatelessWidget {
  final NotifyList item;
  final Animation<double> animation;

  NotificationWidget({required this.item, required this.animation, Key? key})
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
              fontSize: 12,
              color: const Color(0xff132144),
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Text(
            item.time,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              color: const Color(0xcc788198),
            ),
          ),
          subtitle: Text(
            item.msg,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              color: const Color(0xcc1d1d1d),
            ),
          ),
        ),
      );
}
