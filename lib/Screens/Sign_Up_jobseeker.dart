// ignore_for_file: prefer_const_constructors, constant_identifier_names, unused_element, avoid_unnecessary_containers, file_names, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../employer/employer screens/jobPost.dart';
import '../globalVariables.dart';
import './Sign_In.dart';
import 'package:adobe_xd/page_link.dart';
import './Component61.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'Home.dart';
import 'HomeJob.dart';

class Sign_Up_jobseeker extends StatefulWidget {
  static const String idScreen = "Sign_Up_jobseeker";
  const Sign_Up_jobseeker({Key? key}) : super(key: key);

  @override
  _Sign_Up_jobseekerState createState() => _Sign_Up_jobseekerState();
}

class _Sign_Up_jobseekerState extends State<Sign_Up_jobseeker> {
  String countryName = "United Kingdom";

  bool isChecked = true;
  var fullName;
  var userName;
  var password;
  var email;
  Map registrationMap = {};
  bool isSpin = false;

  Future userSignup() async {
    var urrr = Uri.parse(defaultUrl + 'mob_signup');
    setState(() {
      isSpin = true;
    });
    var response = await http.post(urrr, body: json.encode(registrationMap));
    print(jsonDecode(response.body));
    if (jsonDecode(response.body) == 'Successfully updated') {
      Fluttertoast.showToast(msg: "Successfully registered");
      userLogin();
    } else if (jsonDecode(response.body) == 'invalid length') {
      setState(() {
        isSpin = false;
      });
      Fluttertoast.showToast(msg: "Username Length Must Betweeen 4 & 16");
    } else if (jsonDecode(response.body) == 'invalid chars') {
      setState(() {
        isSpin = false;
      });
      Fluttertoast.showToast(msg: "Invalid Characters Used For Username");
    } else if (jsonDecode(response.body) == 'Invalid email id') {
      setState(() {
        isSpin = false;
      });
      Fluttertoast.showToast(msg: "Email Id Invalid");
    } else if (jsonDecode(response.body) == 'Already used') {
      setState(() {
        isSpin = false;
      });
      Fluttertoast.showToast(msg: "Email Id Already Used");
    } else if (jsonDecode(response.body) == 'username unavailable') {
      setState(() {
        isSpin = false;
      });
      Fluttertoast.showToast(msg: "Username Unavailable. Try with Another Username");
    }
  }

  Future userLogin() async {
    var urrr = Uri.parse(defaultUrl + 'mob_login');
    var data = {'email': email, 'password': password};
    var response1 = await http.post(urrr, body: json.encode(data));
    print(response1.body.toString());

    // If the Response Message is Matched.
    if (jsonDecode(response1.body)['msg'] == 'Login Matched') {
      userNameGlob = jsonDecode(response1.body)['username'];
      userID = jsonDecode(response1.body)['id'];
      gettingProfileData();
      setState(() {
        userNameGlob = email;
        password_glob = password;
        isSignedIn = true;
      });
      if (signupUserType == 'employer') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => JobPost()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeJob()));
      }
    } else {
      Fluttertoast.showToast(msg: 'Email and password missmatched');
    }
  }

  Future gettingProfileData() async {
    var url = Uri.parse(defaultUrl + 'mob_user_profile');
    var response2 = await http.post(url, body: json.encode({'userName': userNameGlob}));

    userDetailsResponse = jsonDecode(response2.body);
  }

  infoWidget(String text, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * 0.0025,
          ),
          color: const Color(0xffffffff),
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              userName = value;
            });
          },
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: const Color(0x99444444),
              fontWeight: FontWeight.w300,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.02,
              ),
              child: Icon(
                icon,
                color: Color(0xff444444),
              ),
            ),
          ),
        ),
      ),
    );
  }

  skipButton(String text, void Pressed) {
    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width - 84,
        minHeight: MediaQuery.of(context).size.width * 0.1,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
              width: MediaQuery.of(context).size.width * 0.003,
              color: const Color(0xffdd312d)),
          elevation: MediaQuery.of(context).size.width * 0.01,
          primary: const Color(0xfff7f9fc),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width * 0.01,
            ),
          ),
        ),
        onPressed: () {
          Pressed;
        },
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: const Color(0xffdd312d),
            letterSpacing: 0.7000000000000001,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      body: Container(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: isSpin
            ? Center(
                child: CupertinoActivityIndicator(
                  radius: 20,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.045,
                      ),
                      Container(
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.025,
                      ),
                      Text(
                        'Lets Create Your Account!',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: const Color(0xffdd312d),
                          fontWeight: FontWeight.w500,
                          height: MediaQuery.of(context).size.width * 0.0025,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.025,
                      ),
                      Component61(),
                      infoWidget('Full Name', Icons.person),
                      infoWidget('User Name', Icons.person),
                      infoWidget('Email Id', Icons.mail),
                      infoWidget('Password', Icons.lock),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.02,
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.0025,
                            ),
                            color: const Color(0xffffffff),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.008,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode:
                                      false, // optional. Shows phone code before the country name.
                                  onSelect: (Country country) {
                                    setState(() {
                                      countryName = country.name;
                                      // countryNameCode = country.countryCode;
                                    });
                                    // print(country.phoneCode);

                                    print('Select country: ${country.displayName}');
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.width * 0.08,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context).size.width * 0.01),
                                          child: CountryPickerUtils.getDefaultFlagImage(
                                              CountryPickerUtils.getCountryByName(
                                                  countryName)),
                                        ),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.width * 0.06,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context).size.width * 0.01),
                                          child: Text(countryName),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.width * 0.06,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width * 0.01),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.027,
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: const Color(0xffdd312d)),
                                    child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context).size.width * 0.003)),
                                      activeColor: const Color(0xffdd312d),
                                      focusColor: const Color(0xffdd312d),
                                      value: this.isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          this.isChecked = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'By clicking on “Register” button you are agree to our Terms & Condition',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: MediaQuery.of(context).size.width * 0.025,
                                      color: const Color(0xffdd312d),
                                    ),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.014,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width,
                            minHeight: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    width: MediaQuery.of(context).size.width * 0.001,
                                    color: const Color(0xffdd312d)),
                                elevation: MediaQuery.of(context).size.width * 0.1,
                                primary: const Color(0xffdd312d),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.01,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (!isChecked) {
                                  Fluttertoast.showToast(
                                      msg: "Terms and Conditions Not Accepted");
                                } else if (userName == null ||
                                    fullName == null ||
                                    email == null ||
                                    password == null) {
                                  Fluttertoast.showToast(msg: "All Feilds Are Required");
                                } else if (password.length < 4 || password.length > 21) {
                                  Fluttertoast.showToast(
                                      msg: "Password Length Must be Between 4 & 21");
                                } else {
                                  registrationMap['fullName'] = fullName;
                                  registrationMap['userName'] = userName;
                                  registrationMap['email'] = email;
                                  registrationMap['password'] = password;
                                  registrationMap['usertype'] = signupUserType;
                                  registrationMap['country'] = countryName;
                                  print(registrationMap);
                                  userSignup();
                                }
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  color: const Color(0xfff7f9fc),
                                  letterSpacing: 0.7000000000000001,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width - 84,
                              minHeight: MediaQuery.of(context).size.width * 0.1,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    width: MediaQuery.of(context).size.width * 0.003,
                                    color: const Color(0xffdd312d)),
                                elevation: MediaQuery.of(context).size.width * 0.01,
                                primary: const Color(0xfff7f9fc),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.01,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Home()));
                              },
                              child: Text(
                                'Skip >>',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  color: const Color(0xffdd312d),
                                  letterSpacing: 0.7000000000000001,
                                ),
                              ),
                            ),
                          )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.035,
                            bottom: MediaQuery.of(context).size.width * 0.02,
                          ),
                          child: PageLink(
                            links: [
                              PageLinkInfo(
                                ease: Curves.easeOut,
                                duration: 1.0,
                                pageBuilder: () => SignIn(),
                              ),
                            ],
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: MediaQuery.of(context).size.width * 0.028,
                                  color: const Color(0xff444444),
                                  height: MediaQuery.of(context).size.width * 0.002,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Already Have an Account ? ',
                                  ),
                                  TextSpan(
                                    text: 'Login Now!',
                                    style: TextStyle(
                                      color: const Color(0xffdd312d),
                                    ),
                                  ),
                                ],
                              ),
                              textHeightBehavior:
                                  TextHeightBehavior(applyHeightToFirstAscent: false),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

const String _svg_yyg3 =
    '<svg viewBox="0.0 0.0 22.0 11.3" ><path  d="M 2.666666746139526 0 L 19.33333396911621 0 C 20.80609321594238 0 22 1.193907260894775 22 2.666666746139526 L 22 8.666666030883789 C 22 10.13942527770996 20.80609321594238 11.33333301544189 19.33333396911621 11.33333301544189 L 2.666666746139526 11.33333301544189 C 1.193907260894775 11.33333301544189 0 10.13942527770996 0 8.666666030883789 L 0 2.666666746139526 C 0 1.193907260894775 1.193907260894775 0 2.666666746139526 0 Z" fill="none" fill-opacity="0.35" stroke="#000000" stroke-width="1" stroke-opacity="0.35" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ffj51b =
    '<svg viewBox="23.0 3.7 1.3 4.0" ><path transform="translate(23.0, 3.67)" d="M 0 0 L 0 4 C 0.8047311305999756 3.661223411560059 1.328037977218628 2.873133182525635 1.328037977218628 2 C 1.328037977218628 1.126866698265076 0.8047311305999756 0.3387765288352966 0 0" fill="#000000" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_zdubr6 =
    '<svg viewBox="310.0 3.3 15.3 11.0" ><path transform="translate(310.0, 3.33)" d="M 7.667118072509766 10.99980068206787 C 7.583868026733398 10.99980068206787 7.502848148345947 10.96601009368896 7.444818019866943 10.90710067749023 L 5.438717842102051 8.884799957275391 C 5.37655782699585 8.824450492858887 5.342437744140625 8.740139961242676 5.345118045806885 8.653500556945801 C 5.346918106079102 8.567130088806152 5.384637832641602 8.48445987701416 5.448617935180664 8.426700592041016 C 6.068027973175049 7.903049945831299 6.855897903442383 7.61467981338501 7.667118072509766 7.61467981338501 C 8.478347778320312 7.61467981338501 9.266218185424805 7.903059959411621 9.885618209838867 8.426700592041016 C 9.949607849121094 8.48445987701416 9.98731803894043 8.567120552062988 9.989117622375488 8.653500556945801 C 9.990918159484863 8.740429878234863 9.956467628479004 8.824740409851074 9.894618034362793 8.884799957275391 L 7.889418125152588 10.90710067749023 C 7.831387996673584 10.96601009368896 7.750368118286133 10.99980068206787 7.667118072509766 10.99980068206787 Z M 11.18971824645996 7.451099872589111 C 11.10976791381836 7.451099872589111 11.03336811065674 7.420739650726318 10.97461795806885 7.365599632263184 C 10.06604766845703 6.544379711151123 8.891417503356934 6.092099666595459 7.667118072509766 6.092099666595459 C 6.443657875061035 6.092999935150146 5.269988059997559 6.545269966125488 4.36231803894043 7.365599632263184 C 4.303567886352539 7.420729637145996 4.227168083190918 7.451099872589111 4.147217750549316 7.451099872589111 C 4.064228057861328 7.451099872589111 3.986237764358521 7.418819904327393 3.927617788314819 7.360199928283691 L 2.768417596817017 6.189300060272217 C 2.706577777862549 6.127449989318848 2.673017740249634 6.045629978179932 2.673917770385742 5.958899974822998 C 2.674807786941528 5.871150016784668 2.709967613220215 5.789649963378906 2.772917747497559 5.729399681091309 C 4.106788158416748 4.489140033721924 5.845237731933594 3.806100130081177 7.668017864227295 3.806100130081177 C 9.490477561950684 3.806100130081177 11.229248046875 4.489140033721924 12.56401824951172 5.729399681091309 C 12.62696838378906 5.790549755096436 12.66212749481201 5.872049808502197 12.66301822662354 5.958899974822998 C 12.66391754150391 6.045629978179932 12.63035774230957 6.127449989318848 12.56851768493652 6.189300060272217 L 11.40931797027588 7.360199928283691 C 11.35068798065186 7.418819904327393 11.27270793914795 7.451099872589111 11.18971824645996 7.451099872589111 Z M 13.85911750793457 4.758299827575684 C 13.77818775177002 4.758299827575684 13.70179748535156 4.726979732513428 13.64401817321777 4.67009973526001 C 12.02446746826172 3.131530046463013 9.901827812194824 2.284200191497803 7.667118072509766 2.284200191497803 C 5.431828022003174 2.284200191497803 3.308867692947388 3.131530046463013 1.68931782245636 4.670109748840332 C 1.631547808647156 4.726969718933105 1.555147767066956 4.758299827575684 1.474217772483826 4.758299827575684 C 1.390907764434814 4.758299827575684 1.312917828559875 4.725699901580811 1.254617810249329 4.666500091552734 L 0.09361779689788818 3.496500015258789 C 0.03235779702663422 3.434340000152588 -0.0008822033414617181 3.352830171585083 1.779667218215764e-05 3.267000198364258 C 0.0009177966858260334 3.180460214614868 0.03511779755353928 3.099590063095093 0.09631779789924622 3.039300203323364 C 2.143527746200562 1.079370021820068 4.832218170166016 0 7.667118072509766 0 C 10.50233840942383 0 13.19070816040039 1.079380035400391 15.23701763153076 3.039300203323364 C 15.2982177734375 3.099590063095093 15.33241748809814 3.180460214614868 15.33331775665283 3.267000198364258 C 15.33421802520752 3.352830171585083 15.30097770690918 3.434340000152588 15.23971748352051 3.496500015258789 L 14.0787181854248 4.666500091552734 C 14.02041816711426 4.725699901580811 13.94242763519287 4.758299827575684 13.85911750793457 4.758299827575684 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_hdnkf0 =
    '<svg viewBox="288.0 3.7 17.0 10.7" ><path transform="translate(288.0, 3.67)" d="M 16.00020027160645 10.6668004989624 L 15.00029945373535 10.6668004989624 C 14.44894981384277 10.6668004989624 14.00039958953857 10.2182502746582 14.00039958953857 9.666900634765625 L 14.00039958953857 0.9999000430107117 C 14.00039958953857 0.4485500752925873 14.44894981384277 7.066725515869621e-08 15.00029945373535 7.066725515869621e-08 L 16.00020027160645 7.066725515869621e-08 C 16.55154991149902 7.066725515869621e-08 17.00010108947754 0.4485500752925873 17.00010108947754 0.9999000430107117 L 17.00010108947754 9.666900634765625 C 17.00010108947754 10.2182502746582 16.55154991149902 10.6668004989624 16.00020027160645 10.6668004989624 Z M 11.33369922637939 10.6668004989624 L 10.33290004730225 10.6668004989624 C 9.781549453735352 10.6668004989624 9.332999229431152 10.2182502746582 9.332999229431152 9.666900634765625 L 9.332999229431152 3.333600044250488 C 9.332999229431152 2.782249927520752 9.781549453735352 2.333699941635132 10.33290004730225 2.333699941635132 L 11.33369922637939 2.333699941635132 C 11.88504981994629 2.333699941635132 12.33360004425049 2.782249927520752 12.33360004425049 3.333600044250488 L 12.33360004425049 9.666900634765625 C 12.33360004425049 10.2182502746582 11.88504981994629 10.6668004989624 11.33369922637939 10.6668004989624 Z M 6.666300296783447 10.6668004989624 L 5.666399955749512 10.6668004989624 C 5.115049839019775 10.6668004989624 4.666500091552734 10.2182502746582 4.666500091552734 9.666900634765625 L 4.666500091552734 5.66640043258667 C 4.666500091552734 5.115050315856934 5.115049839019775 4.666500091552734 5.666399955749512 4.666500091552734 L 6.666300296783447 4.666500091552734 C 7.218140125274658 4.666500091552734 7.667099952697754 5.115050315856934 7.667099952697754 5.66640043258667 L 7.667099952697754 9.666900634765625 C 7.667099952697754 10.2182502746582 7.218140125274658 10.6668004989624 6.666300296783447 10.6668004989624 Z M 1.999799966812134 10.6668004989624 L 0.9998999834060669 10.6668004989624 C 0.4485500156879425 10.6668004989624 0 10.2182502746582 0 9.666900634765625 L 0 7.667100429534912 C 0 7.115260124206543 0.4485500156879425 6.666300296783447 0.9998999834060669 6.666300296783447 L 1.999799966812134 6.666300296783447 C 2.55115008354187 6.666300296783447 2.99970006942749 7.115260124206543 2.99970006942749 7.667100429534912 L 2.99970006942749 9.666900634765625 C 2.99970006942749 10.2182502746582 2.55115008354187 10.6668004989624 1.999799966812134 10.6668004989624 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_kg8qyg =
    '<svg viewBox="66.8 422.5 20.0 18.0" ><path transform="translate(66.75, 422.5)" d="M 14.93900012969971 0 C 16.28000068664551 0 17.56999969482422 0.5299999713897705 18.51899909973145 1.480999946594238 C 19.4689998626709 2.430000066757202 20 3.710000038146973 20 5.050000190734863 L 20 5.050000190734863 L 20 12.94999980926514 C 20 15.73999977111816 17.72999954223633 18 14.93900012969971 18 L 14.93900012969971 18 L 5.059999942779541 18 C 2.269000053405762 18 0 15.73999977111816 0 12.94999980926514 L 0 12.94999980926514 L 0 5.050000190734863 C 0 2.259999990463257 2.259000062942505 0 5.059999942779541 0 L 5.059999942779541 0 L 14.93900012969971 0 Z M 16.06999969482422 5.199999809265137 C 15.85999965667725 5.189000129699707 15.65999984741211 5.260000228881836 15.50899982452393 5.400000095367432 L 15.50899982452393 5.400000095367432 L 11 9 C 10.42000007629395 9.480999946594238 9.58899974822998 9.480999946594238 9 9 L 9 9 L 4.5 5.400000095367432 C 4.189000129699707 5.170000076293945 3.759000062942505 5.199999809265137 3.5 5.46999979019165 C 3.230000019073486 5.739999771118164 3.200000047683716 6.170000076293945 3.428999900817871 6.46999979019165 L 3.428999900817871 6.46999979019165 L 3.559999942779541 6.599999904632568 L 8.109999656677246 10.14999961853027 C 8.670000076293945 10.59000015258789 9.348999977111816 10.82999992370605 10.0600004196167 10.82999992370605 C 10.76900005340576 10.82999992370605 11.46000003814697 10.59000015258789 12.01900005340576 10.14999961853027 L 12.01900005340576 10.14999961853027 L 16.53000068664551 6.539999961853027 L 16.61000061035156 6.460000038146973 C 16.84900093078613 6.170000076293945 16.84900093078613 5.75 16.59900093078613 5.460000038146973 C 16.45999908447266 5.310999870300293 16.26899909973145 5.21999979019165 16.06999969482422 5.199999809265137 Z" fill="#444444" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_e1v2ig =
    '<svg viewBox="50.0 479.0 290.0 45.0" ><path transform="translate(50.0, 479.0)" d="M 5 0 L 285 0 C 287.7614135742188 0 290 2.238576173782349 290 5 L 290 40 C 290 42.76142501831055 287.7614135742188 45 285 45 L 5 45 C 2.238576173782349 45 0 42.76142501831055 0 40 L 0 5 C 0 2.238576173782349 2.238576173782349 0 5 0 Z" fill="#ffffff" stroke="none" stroke-width="0.05000000074505806" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rr4la =
    '<svg viewBox="70.0 387.0 14.0 18.7" ><path transform="translate(67.0, 387.0)" d="M 15.25000095367432 7 L 14.66666698455811 7 L 14.66666698455811 4.666666984558105 C 14.66666698455811 2.092999935150146 12.57366752624512 0 10.00000095367432 0 C 7.426333427429199 0 5.333333492279053 2.092999935150146 5.333333492279053 4.666666984558105 L 5.333333492279053 7 L 4.75 7 C 3.785555839538574 7 3.000000238418579 7.784777641296387 3.000000238418579 8.75 L 3.000000238418579 16.91666603088379 C 3.000000238418579 17.88188934326172 3.785555839538574 18.66666793823242 4.75 18.66666793823242 L 15.25000095367432 18.66666793823242 C 16.21444511413574 18.66666793823242 17 17.88188934326172 17 16.91666603088379 L 17 8.75 C 17 7.784777641296387 16.21444511413574 7 15.25000095367432 7 Z M 6.888888835906982 4.666666984558105 C 6.888888835906982 2.950888872146606 8.284222602844238 1.555555582046509 10.00000095367432 1.555555582046509 C 11.71577835083008 1.555555582046509 13.11111164093018 2.950889110565186 13.11111164093018 4.666666984558105 L 13.11111164093018 7 L 6.888888835906982 7 L 6.888888835906982 4.666666984558105 Z M 10.77777862548828 13.00600051879883 L 10.77777862548828 14.77777767181396 C 10.77777862548828 15.20711135864258 10.4301118850708 15.55555534362793 10.00000095367432 15.55555534362793 C 9.569889068603516 15.55555534362793 9.222222328186035 15.20711135864258 9.222222328186035 14.77777767181396 L 9.222222328186035 13.00600051879883 C 8.759444236755371 12.73611164093018 8.44444465637207 12.23988914489746 8.44444465637207 11.66666698455811 C 8.44444465637207 10.80877780914307 9.142111778259277 10.11111164093018 10.00000095367432 10.11111164093018 C 10.85788917541504 10.11111164093018 11.55555629730225 10.80877780914307 11.55555629730225 11.66666698455811 C 11.55555629730225 12.23988914489746 11.24055671691895 12.73611164093018 10.77777862548828 13.00600051879883 Z" fill="#444444" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lalr7h =
    '<svg viewBox="68.8 406.7 14.8 18.5" ><path transform="translate(68.75, 406.75)" d="M 5.409825801849365 12.53356552124023 C 6.741519927978516 12.42626476287842 8.079338073730469 12.42626476287842 9.411042213439941 12.53356552124023 C 10.13624286651611 12.57583808898926 10.85792827606201 12.66658020019531 11.57165813446045 12.80514526367188 C 13.11612987518311 13.11788845062256 14.12447261810303 13.62811756134033 14.55654048919678 14.45108985900879 C 14.88112258911133 15.09331798553467 14.88112258911133 15.85792255401611 14.55654048919678 16.50024223327637 C 14.12447261810303 17.32321548461914 13.15618324279785 17.86628150939941 11.55565547943115 18.14609527587891 C 10.84247970581055 18.28993225097656 10.12061023712158 18.38345146179199 9.395040512084961 18.4259090423584 C 8.722824096679688 18.5 8.050625801086426 18.5 7.370418548583984 18.5 L 6.14605188369751 18.5 C 5.889974594116211 18.46706962585449 5.641898632049561 18.45060539245605 5.401823997497559 18.45060539245605 C 4.676226615905762 18.41332817077637 3.954162120819092 18.32258605957031 3.241172313690186 18.17902565002441 C 1.696709036827087 17.88274765014648 0.6884062886238098 17.35605239868164 0.256275862455368 16.53317260742188 C 0.08945786207914352 16.21432495117188 0.001511523965746164 15.85819911956787 9.640166535973549e-05 15.49624824523926 C -0.003278486896306276 15.13198280334473 0.08200819045305252 14.77271270751953 0.2482737153768539 14.45108985900879 C 0.6724010109901428 13.62811756134033 1.68070650100708 13.09319019317627 3.241172313690186 12.80514526367188 C 3.957298040390015 12.66463756561279 4.681831836700439 12.57389545440674 5.409825801849365 12.53356552124023 Z M 7.402432918548584 -1.16350993509956e-13 C 10.08508968353271 -1.16350993509956e-13 12.25985717773438 2.236483573913574 12.25985717773438 4.995333194732666 C 12.25985717773438 7.754173278808594 10.08508968353271 9.99064826965332 7.402432918548584 9.99064826965332 C 4.719728946685791 9.99064826965332 2.544961929321289 7.754173278808594 2.544961929321289 4.995333194732666 C 2.544961929321289 2.236483573913574 4.719728946685791 -1.16350993509956e-13 7.402432918548584 -1.16350993509956e-13 Z" fill="#444444" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_yl49vr =
    '<svg viewBox="68.8 346.7 14.8 18.5" ><path transform="translate(68.75, 346.75)" d="M 5.409825801849365 12.53356552124023 C 6.741519927978516 12.42626476287842 8.079338073730469 12.42626476287842 9.411042213439941 12.53356552124023 C 10.13624286651611 12.57583808898926 10.85792827606201 12.66658020019531 11.57165813446045 12.80514526367188 C 13.11612987518311 13.11788845062256 14.12447261810303 13.62811756134033 14.55654048919678 14.45108985900879 C 14.88112258911133 15.09331798553467 14.88112258911133 15.85792255401611 14.55654048919678 16.50024223327637 C 14.12447261810303 17.32321548461914 13.15618324279785 17.86628150939941 11.55565547943115 18.14609527587891 C 10.84247970581055 18.28993225097656 10.12061023712158 18.38345146179199 9.395040512084961 18.4259090423584 C 8.722824096679688 18.5 8.050625801086426 18.5 7.370418548583984 18.5 L 6.14605188369751 18.5 C 5.889974594116211 18.46706962585449 5.641898632049561 18.45060539245605 5.401823997497559 18.45060539245605 C 4.676226615905762 18.41332817077637 3.954162120819092 18.32258605957031 3.241172313690186 18.17902565002441 C 1.696709036827087 17.88274765014648 0.6884062886238098 17.35605239868164 0.256275862455368 16.53317260742188 C 0.08945786207914352 16.21432495117188 0.001511523965746164 15.85819911956787 9.640166535973549e-05 15.49624824523926 C -0.003278486896306276 15.13198280334473 0.08200819045305252 14.77271270751953 0.2482737153768539 14.45108985900879 C 0.6724010109901428 13.62811756134033 1.68070650100708 13.09319019317627 3.241172313690186 12.80514526367188 C 3.957298040390015 12.66463756561279 4.681831836700439 12.57389545440674 5.409825801849365 12.53356552124023 Z M 7.402432918548584 -1.16350993509956e-13 C 10.08508968353271 -1.16350993509956e-13 12.25985717773438 2.236483573913574 12.25985717773438 4.995333194732666 C 12.25985717773438 7.754173278808594 10.08508968353271 9.99064826965332 7.402432918548584 9.99064826965332 C 4.719728946685791 9.99064826965332 2.544961929321289 7.754173278808594 2.544961929321289 4.995333194732666 C 2.544961929321289 2.236483573913574 4.719728946685791 -1.16350993509956e-13 7.402432918548584 -1.16350993509956e-13 Z" fill="#444444" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
