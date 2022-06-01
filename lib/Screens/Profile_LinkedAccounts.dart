// import 'package:adobe_jobcentre/Model/list_item.dart';
// import 'package:adobe_jobcentre/data/list_items.dart';
// import 'package:adobe_jobcentre/widget/List_Item_Widget.dart';
// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../globalVariables.dart';
import '../mysql.dart';
import 'addLinkedAccountPage.dart';
import 'model/list_item.dart';
import 'widget/List_Item_Widget.dart';

class Profile_LinkedAccounts extends StatefulWidget {
  static const String idScreen = "linkedAccount";
  const Profile_LinkedAccounts({Key? key}) : super(key: key);

  @override
  _Profile_LinkedAccountsState createState() => _Profile_LinkedAccountsState();
}

class _Profile_LinkedAccountsState extends State<Profile_LinkedAccounts> {
  final listKey = GlobalKey<AnimatedListState>();

  var db = new Mysql();
  var result;
  var columnName;

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
      if (userDetailsResponse["website"] != null) {
        items.add(ListItem(
          title: userDetailsResponse['name'],
          mail: userDetailsResponse['email'],
          image: "assets/images/webIcon.png",
          colName: 'website',
          isIcon: true,
        ));
        // print(row[0]);
        web = userDetailsResponse["website"];
      }
      if (userDetailsResponse["facebook"] != null) {
        items.add(ListItem(
          title: userDetailsResponse['name'],
          mail: userDetailsResponse['email'],
          image: "assets/images/fb.png",
          colName: 'website',
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
        twitter = userDetailsResponse["twitter"];
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
        gPlus = userDetailsResponse["googleplus"];
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
        insta = userDetailsResponse["instagram"];
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
        linkedIn = userDetailsResponse["linkedin"];
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
        youtube = userDetailsResponse["youtube"];
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
  }

  dbdeleteLinked() async {
    var urrr = Uri.parse(defaultUrl + 'mob_remove_linked_acc');

    var data = {
      'id': userDetailsResponse['id'],
      'col': columnName,
    };

    var response = await http.post(urrr, body: json.encode(data));
    print(response.body.toString());
    if (jsonDecode(response.body)['msg'] == 'Successfully Removed') {
      Fluttertoast.showToast(msg: "Removed");
    }
  }

  void removeItem(int index) {
    final removedItem = items[index];
    print(items[index].colName);
    if (items[index].colName == 'facebook') {
      setState(() {
        // fb = null;
        columnName = 'facebook';
      });
    } else if (items[index].colName == 'twitter') {
      setState(() {
        // twitter = null;
        columnName = 'twitter';
      });
    } else if (items[index].colName == 'gplus') {
      setState(() {
        // gPlus = null;
        columnName = 'googleplus';
      });
    } else if (items[index].colName == 'instagram') {
      setState(() {
        // insta = null;
        columnName = 'instagram';
      });
    } else if (items[index].colName == 'linkedIn') {
      setState(() {
        // linkedIn = null;
        columnName = 'linkedin';
      });
    } else if (items[index].colName == 'youtube') {
      setState(() {
        // youtube = null;
        columnName = 'youtube';
      });
    }
    dbdeleteLinked();
    items.removeAt(index);
    listKey.currentState!.removeItem(
      index,
      (context, animation) => ListItemWidget(
        item: removedItem,
        animation: animation,
        onClicked: () {
          dbdeleteLinked();
        },
      ),
      duration: Duration(milliseconds: 600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff7f9fc),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xff1d1d1d)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Linked Accounts',
          style: TextStyle(color: Color(0xff1D1D1D)),
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          color: Color(0xff1d1d1d),
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: AnimatedList(
        key: listKey,
        initialItemCount: items.length,
        itemBuilder: (context, index, animation) => ListItemWidget(
          item: items[index],
          animation: animation,
          onClicked: () => removeItem(index),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xffDD312D),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddLinkedAccountPage()));
        },
      ),
    );
  }
}





/*

$_GET['page']
$_GET['order']
$_GET['sort']
$_GET['limit']
$_GET['filter']
$_GET['budget']
$_GET['keywords']
$_GET['subcat']
isset($_GET['cat']
$_GET['custom']
$_GET['city']
$_GET['keywords']
$_GET['range1']
$_GET['city']
$_GET['location']
$_GET['placetype']
$_GET['placeid']

*/