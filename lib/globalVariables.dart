// ignore_for_file: prefer_typing_uninitialized_variables, file_names, unnecessary_this, prefer_is_empty

import 'package:my_jobs_center/Screens/model/list_item.dart';

List<ListItem> items = [];
var fb;
var web;
var twitter;
var gPlus;
var insta;
var linkedIn;
var youtube;
var userID = '';
String resumePath = '';
Map userDetailsResponse = {};
var userNameGlob = '';
String defaultUrl = 'https://www.myjobscentre.com/';
// String defaultUrl = 'http://10.0.2.2/myjobsupdated/';
bool isSignUpEmployer = true;
var signupUserType = "employer";
bool isSignedIn = false;
String profImgLink = "https://myjobscentre.com/storage/profile/";
// String profImgLink = "http://10.0.2.2/myjobscenter/demo/storage/profile/";

//For jobs search
int jobType = 0;
int salaryType = 0;
String postedDate = "";
String sortBy = "";
int minSal = 0;
int maxSal = 1000000;
String searchKeyword = "";
String username_glob = "";
String password_glob = "";
String selectedCity = "";
int postedDateFilter = 4;

extension CapExtension on String {
  String get inCaps =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}
