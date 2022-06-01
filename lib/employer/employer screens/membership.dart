// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jobs_center/employer/employer%20screens/basicmembership.dart';
import 'package:my_jobs_center/employer/employer%20screens/businessmembership.dart';
import 'package:my_jobs_center/employer/employer%20screens/payment.dart';
import 'package:my_jobs_center/employer/employer%20screens/professionalmembership.dart';
import 'package:my_jobs_center/employer/widget/currentPlanPage.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:http/http.dart' as http;

import '../../Screens/HomeJob.dart';
import 'jobPost.dart';

class MembershipPage extends StatefulWidget {
  static const String idScreen = "Membership";
  const MembershipPage({Key? key}) : super(key: key);

  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  Map<String, dynamic>? paymentIntentData;
  Map membershipDataMap = {};
  Map currentPlanMap = {};
  bool isSpin = true;
  List screens = [];
  bool isShowCurrentPlan = false;

  Future gettingProfileData() async {
    var url = Uri.parse(defaultUrl + 'mob_user_profile');
    var response = await http.post(url, body: json.encode({'userName': userNameGlob}));
    userDetailsResponse = jsonDecode(response.body);
    print(userDetailsResponse);
    setState(() {
      isSignedIn = true;
    });

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Payment()));
  }

  Future fetchMembershipData() async {
    var url = Uri.parse(defaultUrl + 'mob_membership_details');

    var response = await http.get(url);

    membershipDataMap = jsonDecode(response.body);
    print(membershipDataMap.length);

    membershipDataMap.forEach((key, value) {
      print(value["title"]);
    });

    membershipDataMap.forEach((key, value) {
      screens.add(BasicMembership(
        title: value["title"],
        price: value["cost"],
        period: value["term"],
        adLimit: value["limit"],
        adExpires: value["duration"],
        featuredFee: value["featured_fee"],
        featuredPeriod: value["featured_duration"],
        urgentFee: value["urgent_fee"],
        urgentPeriod: value["urgent_duration"],
        highlightedFee: value["highlight_fee"],
        highlightedPeriod: value["highlight_duration"],
        isTopInSearch: value["top_search_result"],
        isShowPremiumSection: value["show_in_home_search"],
        isShowinHome: value["show_on_home"],
        chatLimit: value["chat_credit"],
        onPressed: () async {
          await makePayment(
            price: value["cost"].toString().split(".").first,
            paymentMethod: "2",
            upgradeId: value['id'],
          );
        },
      ));
    });
  }

  Future getCurrentPlan() async {
    var url = Uri.parse(defaultUrl + 'mob_get_current_plan');
    var response =
        await http.post(url, body: json.encode({'user_id': userDetailsResponse['id']}));
    currentPlanMap = jsonDecode(response.body);
    if (currentPlanMap["plan"] != null) {
      setState(() {
        isShowCurrentPlan = true;
      });
    } else {
      setState(() {
        isShowCurrentPlan = false;
      });
    }
  }

  Future sendPackageDetails({
    required String userId,
    required String paymentMethodId,
    required String upgradeId,
  }) async {
    Map sendingData = {
      "upgrade": upgradeId,
      "payment_method_id": paymentMethodId,
      "id": userId,
    };
    var url = Uri.parse(defaultUrl + 'mob_package_paid');

    // Starting Web API Call.

    try {
      var response = await http.post(url, body: json.encode(sendingData));
      print(response.statusCode);

      if (response.body == '"Successfully sent"') {
        print("success");
        // Fluttertoast.showToast(msg: "Successfully subscribed");
        gettingProfileData();
      } else {
        print("object");
        print(response.body);
        Fluttertoast.showToast(msg: "Something went wrong. Try again later");
      }
    } catch (e) {
      print("catch");
      print(e);
      Fluttertoast.showToast(msg: "Something went wrong. Try again later");
    }
  }

  @override
  void initState() {
    fetchMembershipData().then((value) {
      getCurrentPlan().then((value) {
        setState(() {
          isSpin = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Membership Plans",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: const Color(0xff1d1d1d),
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xfff7f9fc),
        body: isSpin
            ? Center(
                child: CupertinoActivityIndicator(
                  animating: isSpin,
                  radius: 25,
                ),
              )
            : isShowCurrentPlan
                ? CurrentPlanWidget(
                    currentPlan: currentPlanMap["plan"],
                    cost: currentPlanMap["cost"],
                    startDate: currentPlanMap["start_date"],
                    expireDate: currentPlanMap["expire_date"],
                    term: currentPlanMap["term"],
                    onPressed: () {
                      setState(() {
                        isShowCurrentPlan = false;
                      });
                    })
                : ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                    child: Swiper(
                      // layout: SwiperLayout.TINDER,
                      itemCount: screens.length,
                      itemWidth: MediaQuery.of(context).size.width,
                      // itemHeight: 1000,
                      itemBuilder: (context, index) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height,
                          ),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xfff7f9fc),
                              child: screens[index]),
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  Future<void> makePayment(
      {required String price,
      required String paymentMethod,
      required String upgradeId}) async {
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
      displayPaymentSheet(paymentMethodId: paymentMethod, upgradeId: upgradeId);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(
      {required String paymentMethodId, required String upgradeId}) async {
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
        paymentIntentData = null;
        sendPackageDetails(
            userId: userDetailsResponse['id'],
            paymentMethodId: paymentMethodId,
            upgradeId: upgradeId);
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
