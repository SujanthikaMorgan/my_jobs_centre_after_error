// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/jobsWidget.dart';
import 'package:http/http.dart' as http;

import '../../Screens/HomeJob.dart';
import '../../globalVariables.dart';
import 'jobPost.dart';
import 'notificationEmployee.dart';

class PromotePage extends StatefulWidget {
  final String jobtype;
  final String title;
  final String description;
  // final String location;
  final String shortlisted;
  final String views;
  final String company;
  // final String type;
  final String date;
  final String minSal;
  final String maxSal;
  final String salType;
  final String img;
  final String jobID;
  final String city;
  final String country;
  final String link;
  final String mainCat;
  final String subCat;
  final bool isNegotiale;
  final String phone;
  final bool isHidePhone;
  final String tags;
  final String totalAplications;
  final String shortlistedAplicants;
  final String highlight;
  final String feature;
  final String urgent;

  const PromotePage(
      {Key? key,
      required this.jobtype,
      required this.title,
      required this.description,
      required this.shortlisted,
      required this.views,
      required this.company,
      required this.date,
      required this.minSal,
      required this.maxSal,
      required this.salType,
      required this.img,
      required this.jobID,
      required this.city,
      required this.country,
      required this.link,
      required this.mainCat,
      required this.subCat,
      required this.isNegotiale,
      required this.phone,
      required this.isHidePhone,
      required this.tags,
      required this.totalAplications,
      required this.shortlistedAplicants,
      required this.highlight,
      required this.feature,
      required this.urgent})
      : super(key: key);

  @override
  State<PromotePage> createState() => _PromotePageState();
}

class _PromotePageState extends State<PromotePage> {
  Map<String, dynamic>? paymentIntentData;
  bool isFeaturedheck = false;
  bool isUrgentCheckd = false;
  bool isHighiLightCheckd = false;
  int price = 0;
  Map fetchedGroupInfo = {};
  bool isSpin = true;
  bool isPaid = false;
  int urgentBalance = 0;
  int featureBalance = 0;
  int highlightBalane = 0;
  bool isUrgentBalUsed = false;
  bool isFeaturedBalUsed = false;
  bool isHighlighBalUsed = false;

  Future gettingProfileData() async {
    var url = Uri.parse(defaultUrl + 'mob_user_profile');
    var response = await http.post(url, body: json.encode({'userName': userNameGlob}));
    userDetailsResponse = jsonDecode(response.body);
    print(userDetailsResponse);
    setState(() {
      isSignedIn = true;
    });
    if (userDetailsResponse["user_type"] == "employer") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => JobPost()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeJob()));
    }
  }

  Future getPaymentDetails() async {
    var url = Uri.parse(defaultUrl + 'mob_get_post_payment_details');
    var response =
        await http.post(url, body: json.encode({"user_id": userDetailsResponse['id']}));

    fetchedGroupInfo = jsonDecode(response.body);
    print("mobile payment details");
    print(fetchedGroupInfo);
    print("mobile payment details ends ------------------------------");
  }

  Future promoteJob() async {
    var url = Uri.parse(defaultUrl + 'mob_promote_job');
    Map promotDataMap = {};
    setState(() {
      promotDataMap = {
        "featured": isFeaturedheck ? 1 : 0,
        "highlighted": isHighiLightCheckd ? 1 : 0,
        "urgent": isUrgentCheckd ? 1 : 0,
        "isPaid": isPaid ? 1 : 0,
        "amount": price,
        "group_id": fetchedGroupInfo['group_id'],
        "isUrgeBalUsed": isUrgentBalUsed ? 1 : 0,
        "isFeatBalUsed": isFeaturedBalUsed ? 1 : 0,
        "isHighBalUsed": isHighlighBalUsed ? 1 : 0,
        'payment_method_id': "2",
        'jobId': widget.jobID,
        'user_id': userDetailsResponse['id'],
      };
    });
    // print(widget.jobID);

    var response = await http.post(url, body: json.encode(promotDataMap));
    print(jsonDecode(response.body));
    print(response.statusCode);

    if (response.body == '"Successfully promoted"') {
      Fluttertoast.showToast(msg: "Success");
      gettingProfileData();
    } else {
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }

  @override
  void initState() {
    setState(() {
      urgentBalance = int.parse(userDetailsResponse['urgent']);
      featureBalance = int.parse(userDetailsResponse['featured']);
      highlightBalane = int.parse(userDetailsResponse['highlight']);
    });
    getPaymentDetails().then((value) {
      setState(() {
        isSpin = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.red;
      }
      return Colors.grey;
    }

    return Scaffold(
      // backgroundColor: const Color(0xfff7f9fc),
      backgroundColor: Colors.white,
      endDrawer: SidemenuEmployer(),
      appBar: AppBar(
        title: Text("Promote"),
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        // backgroundColor: const Color(0xfff7f9fc),
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              bottom: 10,
              right: 10,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: isSpin
          ? Center(
              child: CupertinoActivityIndicator(
              animating: isSpin,
              radius: 25,
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  JobsWidget(
                    jobtype: widget.jobtype,
                    company: widget.company,
                    title: widget.title,
                    date: widget.date,
                    description: widget.description,
                    shortlisted: widget.shortlisted,
                    minSal: widget.minSal,
                    maxSal: widget.maxSal,
                    salType: widget.salType,
                    img: widget.img,
                    jobID: widget.jobID,
                    views: widget.views,
                    city: widget.city,
                    country: widget.country,
                    link: widget.link,
                    mainCat: widget.mainCat,
                    subCat: widget.subCat,
                    isNegotiale: widget.isNegotiale,
                    phone: widget.phone,
                    isHidePhone: widget.isHidePhone,
                    tags: widget.tags,
                    totalAplications: widget.totalAplications,
                    shortlistedAplicants: widget.shortlistedAplicants,
                    featured: widget.feature,
                    highlight: widget.highlight,
                    urgent: widget.urgent,
                    isDotsShow: false,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      bottom: 20,
                      // left: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.urgent == "1")
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 15,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffDD312D),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Text(
                                  "urgent",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    height: 1.4166666666666667,
                                  ),
                                  textHeightBehavior:
                                      TextHeightBehavior(applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        if (widget.feature == "1")
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 15,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff008000),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Text(
                                  "Featured",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    height: 1.4166666666666667,
                                  ),
                                  textHeightBehavior:
                                      TextHeightBehavior(applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        if (widget.highlight == "1")
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 15,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffFFA500),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Text(
                                  "highlight",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    height: 1.4166666666666667,
                                  ),
                                  textHeightBehavior:
                                      TextHeightBehavior(applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    "Make your job premium ",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.feature != "1")
                        Row(
                          children: [
                            Checkbox(
                              value: isFeaturedheck,
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              onChanged: (bool? value) {
                                setState(() {
                                  isFeaturedheck = value!;
                                });
                                if (featureBalance > 0) {
                                  if (isFeaturedheck) {
                                    setState(() {
                                      isFeaturedBalUsed = true;
                                    });
                                  } else {
                                    setState(() {
                                      isFeaturedBalUsed = false;
                                    });
                                  }
                                } else {
                                  if (isFeaturedheck) {
                                    setState(() {
                                      price = price +
                                          int.parse(
                                              fetchedGroupInfo["featured_project_fee"]
                                                  .toString()
                                                  .split(".")
                                                  .first);
                                    });
                                  } else {
                                    setState(() {
                                      price = price -
                                          int.parse(
                                              fetchedGroupInfo["featured_project_fee"]
                                                  .toString()
                                                  .split(".")
                                                  .first);
                                    });
                                  }
                                }
                              },
                            ),
                            if (widget.feature != "1")
                              Text(
                                "Featured",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: const Color(0xff132144),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.visible,
                              ),
                          ],
                        ),
                      if (widget.feature != "1")
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "Featured jobs attract higher-quality viewer and are displayed prominently in the Featured jobs section home page.",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xff132144),
                              fontWeight: FontWeight.w300,
                              height: 1.4166666666666667,
                            ),
                            textHeightBehavior:
                                TextHeightBehavior(applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      if (widget.feature != "1")
                        Padding(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          child: Text(
                            (featureBalance > 0)
                                ? "Available feature jobs : $featureBalance"
                                : "£${fetchedGroupInfo["featured_project_fee"]} for ${fetchedGroupInfo["featured_duration"]} days",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: const Color(0xff132144),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      if (widget.urgent != "1")
                        Row(
                          children: [
                            Checkbox(
                              value: isUrgentCheckd,
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              onChanged: (bool? value) {
                                setState(() {
                                  isUrgentCheckd = value!;
                                });
                                if (urgentBalance > 0) {
                                  if (isUrgentCheckd) {
                                    setState(() {
                                      isUrgentBalUsed = true;
                                    });
                                  } else {
                                    isUrgentBalUsed = false;
                                  }
                                } else {
                                  if (isUrgentCheckd) {
                                    setState(() {
                                      price = price +
                                          int.parse(fetchedGroupInfo["urgent_project_fee"]
                                              .toString()
                                              .split(".")
                                              .first);
                                    });
                                  } else {
                                    setState(() {
                                      price = price -
                                          int.parse(fetchedGroupInfo["urgent_project_fee"]
                                              .toString()
                                              .split(".")
                                              .first);
                                    });
                                  }
                                }
                              },
                            ),
                            if (widget.urgent != "1")
                              Text(
                                "Urgent",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: const Color(0xff132144),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.visible,
                              ),
                          ],
                        ),
                      if (widget.urgent != "1")
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "Make your job stand out and let viewer know that your job is time sensitive.",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xff132144),
                              fontWeight: FontWeight.w300,
                              height: 1.4166666666666667,
                            ),
                            textHeightBehavior:
                                TextHeightBehavior(applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      if (widget.urgent != "1")
                        Padding(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          child: Text(
                            (urgentBalance > 0)
                                ? "Available feature jobs : $urgentBalance"
                                : "£${fetchedGroupInfo["urgent_project_fee"]} for ${fetchedGroupInfo["urgent_duration"]} days",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: const Color(0xff132144),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      if (widget.highlight != "1")
                        Row(
                          children: [
                            Checkbox(
                              value: isHighiLightCheckd,
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              onChanged: (bool? value) {
                                setState(() {
                                  isHighiLightCheckd = value!;
                                });
                                if (highlightBalane > 0) {
                                  if (isHighiLightCheckd) {
                                    setState(() {
                                      isHighlighBalUsed = true;
                                    });
                                  } else {
                                    setState(() {
                                      isHighlighBalUsed = false;
                                    });
                                  }
                                } else {
                                  if (isHighiLightCheckd) {
                                    setState(() {
                                      price = price +
                                          int.parse(
                                              fetchedGroupInfo["highlight_project_fee"]
                                                  .toString()
                                                  .split(".")
                                                  .first);
                                    });
                                  } else {
                                    setState(() {
                                      price = price -
                                          int.parse(
                                              fetchedGroupInfo["highlight_project_fee"]
                                                  .toString()
                                                  .split(".")
                                                  .first);
                                    });
                                  }
                                }
                              },
                            ),
                            if (widget.highlight != "1")
                              Text(
                                "Highlight",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: const Color(0xff132144),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.visible,
                              ),
                          ],
                        ),
                      if (widget.highlight != "1")
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "Make your job highlighted with border in listing search result page. Easy to focus.",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xff132144),
                              fontWeight: FontWeight.w300,
                              height: 1.4166666666666667,
                            ),
                            textHeightBehavior:
                                TextHeightBehavior(applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      if (widget.highlight != "1")
                        Padding(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          child: Text(
                            (highlightBalane > 0)
                                ? "Available feature jobs : $highlightBalane"
                                : "£${fetchedGroupInfo["highlight_project_fee"]} for ${fetchedGroupInfo["highlight_duration"]} days",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: const Color(0xff132144),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                    ],
                  ),
                  if (price > 0)
                    Center(
                      child: Text(
                        "Total $price.00 GRB",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: const Color(0xff132144),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
                    child: Container(
                      height: 50,
                      width: 350,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 1.0, color: Colors.white),
                          elevation: 10.0,
                          primary: const Color(0xffdd312d),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          if (!(isUrgentCheckd || isFeaturedheck || isHighiLightCheckd)) {
                            Fluttertoast.showToast(msg: "No options selected");
                          } else {
                            if (price > 0) {
                              setState(() {
                                isPaid = true;
                              });
                              makePayment(price: price.toString());
                            } else {
                              isPaid = false;
                              promoteJob();
                            }
                          }
                        },
                        child: Text(
                          "Pay and Promote",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: Colors.white,
                            letterSpacing: 0.7000000000000001,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> makePayment({required String price}) async {
    try {
      paymentIntentData =
          await createPaymentIntent(price, 'INR'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print('payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));
        promoteJob();
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Something went wrong. Try again later")));
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong. Try again later")));
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KlPvqSDvq8Arat4N4XXJhQGqDMagzVSLCwmcBgOz6O9FG4Z8awybgdwUJwVF1oclZmFN8xJMeXiRxTiXZhEhnVF002cmtfisS',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
