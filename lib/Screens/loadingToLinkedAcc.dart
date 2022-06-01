// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_jobs_center/Screens/Profile_LinkedAccounts.dart';
import 'package:my_jobs_center/Screens/model/list_item.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:my_jobs_center/mysql.dart';

class LoadingToLinkedAcc extends StatefulWidget {
  const LoadingToLinkedAcc({Key? key}) : super(key: key);

  @override
  _LoadingToLinkedAccState createState() => _LoadingToLinkedAccState();
}

class _LoadingToLinkedAccState extends State<LoadingToLinkedAcc> {
  var db = new Mysql();
  var result;

  @override
  void initState() {
    if (items != null) {
      items.clear();
    }
    setSerLinkedAccounts();

    // _dbCheck();
  }

  setSerLinkedAccounts() {
    setState(() {
      if (userDetailsResponse["facebook"] != null) {
        items.add(ListItem(
          title: userDetailsResponse['name'],
          mail: userDetailsResponse['email'],
          image: "assets/images/fb.png",
          colName: 'facebook',
          isIcon: true,
        ));
        // print(row[0]);
        fb = userDetailsResponse["facebook"];
      }
      if (userDetailsResponse["twitter"] != null) {
        items.add(ListItem(
          title: userDetailsResponse['name'],
          mail: userDetailsResponse['email'],
          image: "assets/images/twitter.png",
          colName: 'twitter',
          isIcon: true,
        ));
        // print(row[0]);
        fb = userDetailsResponse["twitter"];
      }
      if (userDetailsResponse["googleplus"] != null) {
        items.add(ListItem(
          title: userDetailsResponse['name'],
          mail: userDetailsResponse['email'],
          image: "assets/images/gplus.jpg",
          colName: 'gplus',
          isIcon: true,
        ));
        // print(row[0]);
        fb = userDetailsResponse["googleplus"];
      }
      if (userDetailsResponse["instagram"] != null) {
        items.add(ListItem(
          title: userDetailsResponse['name'],
          mail: userDetailsResponse['email'],
          image: "assets/images/insta.jpg",
          colName: 'instagram',
          isIcon: true,
        ));
        // print(row[0]);
        fb = userDetailsResponse["instagram"];
      }
      if (userDetailsResponse["linkedin"] != null) {
        items.add(ListItem(
          title: userDetailsResponse['name'],
          mail: userDetailsResponse['email'],
          image: "assets/images/linkedIn.png",
          colName: 'linkedIn',
          isIcon: true,
        ));
        // print(row[0]);
        fb = userDetailsResponse["linkedin"];
      }
      if (userDetailsResponse["youtube"] != null) {
        items.add(ListItem(
          title: userDetailsResponse['name'],
          mail: userDetailsResponse['email'],
          image: "assets/images/youtube.png",
          colName: 'youtube',
          isIcon: true,
        ));
        // print(row[0]);
        fb = userDetailsResponse["youtube"];
      }
      items.add(
        ListItem(
          title: ' ',
          mail: ' ',
          image: "assets/images/white.png",
          colName: ' ',
          isIcon: false,
        ),
      );
    });
    Navigator.popAndPushNamed(context, Profile_LinkedAccounts.idScreen);
  }

  // void _dbCheck() {
  //   db.getConnection().then((value) async {
  //     result = await value.query(
  //       'select `facebook`,`twitter`,`googleplus`,`instagram`,`linkedin`,`youtube`,`name`,`email` from `job_user` where id =?',
  //       [userID],
  //     );
  //   }).then((value) {
  //     setUserDetails();
  //   }).then((value) =>
  //       Navigator.popAndPushNamed(context, Profile_LinkedAccounts.idScreen));
  // }

  setUserDetails() {
    print("Entered");
    for (var row in result) {
      setState(() {
        if (row[0] != null) {
          items.add(ListItem(
            title: row[6],
            mail: row[7],
            image: "assets/images/fb.png",
            colName: 'facebook',
            isIcon: true,
          ));
          print(row[0]);
          fb = row[0];
        }
        if (row[1] != null) {
          items.add(ListItem(
            title: row[6],
            mail: row[7],
            image: "assets/images/twitter.png",
            colName: 'twitter',
            isIcon: true,
          ));
          print(row[1]);
          twitter = row[1];
        }
        if (row[2] != null) {
          items.add(ListItem(
            title: row[6],
            mail: row[7],
            image: "assets/images/gplus.jpg",
            colName: 'gplus',
            isIcon: true,
          ));
          print(row[2]);
          gPlus = row[2];
        }
        if (row[3] != null) {
          items.add(ListItem(
            title: row[6],
            mail: row[7],
            image: "assets/images/insta.jpg",
            colName: 'instagram',
            isIcon: true,
          ));
          print(row[3]);
          insta = row[3];
        }
        if (row[4] != null) {
          items.add(ListItem(
            title: row[6],
            mail: row[7],
            image: "assets/images/linkedIn.png",
            colName: 'linkedIn',
            isIcon: true,
          ));
          print(row[4]);
          linkedIn = row[4];
        }
        if (row[5] != null) {
          items.add(ListItem(
            title: row[6],
            mail: row[7],
            image: "assets/images/youtube.png",
            colName: 'youtube',
            isIcon: true,
          ));
          print(row[5]);
          youtube = row[5]; //white
        }
      });
    }
    items.add(
      ListItem(
        title: ' ',
        mail: ' ',
        image: "assets/images/white.png",
        colName: ' ',
        isIcon: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading"),
        ),
      ),
    );
  }
}
