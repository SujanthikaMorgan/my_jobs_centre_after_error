import 'package:flutter/material.dart';

class JobAlertItemWidget extends StatelessWidget {
  final String imgPath;
  final String name;
  final bool isFav;
  const JobAlertItemWidget({
    required this.imgPath,
    required this.name,
    required this.isFav,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isFav ? Color(0xffDD312D) : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 112,
      height: 87,
      // color: isFav ? Color(0xffDD312D) : Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: NetworkImage(
                imgPath,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 9,
                // color: const Color(0xff444444),
                color: isFav ? Colors.white : Color(0xff444444),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
