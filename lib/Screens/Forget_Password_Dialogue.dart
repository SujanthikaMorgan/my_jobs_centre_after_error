// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter/services.dart';
import 'package:my_jobs_center/Screens/Sign_In.dart';
import 'package:my_jobs_center/Screens/newPassword.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import './Forget_Password.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Forget_Password_Dialogue extends StatefulWidget {
  static const String idScreen = "Forget_Password_Dialogue";
  const Forget_Password_Dialogue({Key? key}) : super(key: key);

  @override
  _Forget_Password_DialogueState createState() =>
      _Forget_Password_DialogueState();
}

class _Forget_Password_DialogueState extends State<Forget_Password_Dialogue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        elevation: 0,
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        backgroundColor: const Color(0xfff7f9fc),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xfff7f9fc),
      body: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 50,
              right: 50,
              top: 50,
            ),
            child: Column(
              children: [
                Container(
                  child: Image(
                      image: NetworkImage(
                          'https://www.myjobscentre.com/storage/logo/classic-theme_logo.png')),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: const Color(0xffdd312d),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xffe0f5d7),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: Text(
                            'Confirmation Mail Sent!',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xff6eb056),
                              fontWeight: FontWeight.w500,
                              height: 2.142857142857143,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 15,
                            right: 10,
                            left: 10,
                          ),
                          child: Text(
                            'Please check your email account for the forgot password details',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              color: const Color(0xff6eb056),
                              fontWeight: FontWeight.w300,
                              height: 1.5,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // OTPTextField(
                //   length: 4,
                //   width: MediaQuery.of(context).size.width,
                //   // fieldWidth: 20,

                //   style: TextStyle(fontSize: 17),
                //   otpFieldStyle: OtpFieldStyle(
                //     // backgroundColor: Colors.white,
                //     borderColor: Colors.grey,
                //     focusBorderColor: Colors.grey,
                //     // enabledBorderColor: Colors.white,
                //   ),

                //   textFieldAlignment: MainAxisAlignment.spaceAround,
                //   fieldStyle: FieldStyle.underline,
                //   onCompleted: (pin) {
                //     print("Completed: " + pin);
                //   },
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'Didn\'t received? ',
                //         style: TextStyle(
                //           fontFamily: 'Poppins',
                //           fontSize: 12,
                //           color: const Color(0xff707070),
                //         ),
                //         textAlign: TextAlign.left,
                //       ),
                //       Text(
                //         'Resend',
                //         style: TextStyle(
                //           fontFamily: 'Poppins',
                //           fontSize: 12,
                //           color: const Color(0xffdd312d),
                //         ),
                //         textAlign: TextAlign.left,
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      minHeight: 50,
                    ),
                    child: Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              width: 1.0, color: const Color(0xffdd312d)),
                          elevation: 10.0,
                          primary: const Color(0xffdd312d),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, SignIn.idScreen, (route) => false);
                        },
                        child: Text(
                          "Go to SignIn",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: const Color(0xfff7f9fc),
                            letterSpacing: 0.7000000000000001,
                          ),
                        ),
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

const String _svg_agkhb6 =
    '<svg viewBox="25.0 71.0 20.2 13.5" ><path transform="translate(17.12, 59.75)" d="M 15.21562480926514 11.51015663146973 C 15.57421875 11.86171913146973 15.57421875 12.4453125 15.22265625 12.80390644073486 L 10.95468711853027 17.0859375 L 27.21796798706055 17.0859375 C 27.71718597412109 17.0859375 28.125 17.49374961853027 28.125 18 C 28.125 18.50625038146973 27.71718788146973 18.9140625 27.21796798706055 18.9140625 L 10.95468711853027 18.9140625 L 15.22968673706055 23.19609451293945 C 15.58124923706055 23.5546875 15.57421779632568 24.13125038146973 15.22265529632568 24.48984527587891 C 14.86406135559082 24.84140777587891 14.29452991485596 24.84140777587891 13.93593692779541 24.48281478881836 L 8.142187118530273 18.64687728881836 C 8.142187118530273 18.64687728881836 8.142187118530273 18.64687728881836 8.142187118530273 18.64687728881836 C 8.06484317779541 18.56250190734863 8.001562118530273 18.47109603881836 7.952343463897705 18.35859680175781 C 7.903124809265137 18.24609756469727 7.882030963897705 18.12656593322754 7.882030963897705 18.00703430175781 C 7.882030963897705 17.76797103881836 7.973437309265137 17.54297256469727 8.142187118530273 17.36719131469727 L 13.93593692779541 11.53125381469727 C 14.28046894073486 11.16562461853027 14.85703086853027 11.15859413146973 15.21562480926514 11.51015663146973 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_yyg3 =
    '<svg viewBox="0.0 0.0 22.0 11.3" ><path  d="M 2.666666746139526 0 L 19.33333396911621 0 C 20.80609321594238 0 22 1.193907260894775 22 2.666666746139526 L 22 8.666666030883789 C 22 10.13942527770996 20.80609321594238 11.33333301544189 19.33333396911621 11.33333301544189 L 2.666666746139526 11.33333301544189 C 1.193907260894775 11.33333301544189 0 10.13942527770996 0 8.666666030883789 L 0 2.666666746139526 C 0 1.193907260894775 1.193907260894775 0 2.666666746139526 0 Z" fill="none" fill-opacity="0.35" stroke="#000000" stroke-width="1" stroke-opacity="0.35" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ffj51b =
    '<svg viewBox="23.0 3.7 1.3 4.0" ><path transform="translate(23.0, 3.67)" d="M 0 0 L 0 4 C 0.8047311305999756 3.661223411560059 1.328037977218628 2.873133182525635 1.328037977218628 2 C 1.328037977218628 1.126866698265076 0.8047311305999756 0.3387765288352966 0 0" fill="#000000" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_zdubr6 =
    '<svg viewBox="310.0 3.3 15.3 11.0" ><path transform="translate(310.0, 3.33)" d="M 7.667118072509766 10.99980068206787 C 7.583868026733398 10.99980068206787 7.502848148345947 10.96601009368896 7.444818019866943 10.90710067749023 L 5.438717842102051 8.884799957275391 C 5.37655782699585 8.824450492858887 5.342437744140625 8.740139961242676 5.345118045806885 8.653500556945801 C 5.346918106079102 8.567130088806152 5.384637832641602 8.48445987701416 5.448617935180664 8.426700592041016 C 6.068027973175049 7.903049945831299 6.855897903442383 7.61467981338501 7.667118072509766 7.61467981338501 C 8.478347778320312 7.61467981338501 9.266218185424805 7.903059959411621 9.885618209838867 8.426700592041016 C 9.949607849121094 8.48445987701416 9.98731803894043 8.567120552062988 9.989117622375488 8.653500556945801 C 9.990918159484863 8.740429878234863 9.956467628479004 8.824740409851074 9.894618034362793 8.884799957275391 L 7.889418125152588 10.90710067749023 C 7.831387996673584 10.96601009368896 7.750368118286133 10.99980068206787 7.667118072509766 10.99980068206787 Z M 11.18971824645996 7.451099872589111 C 11.10976791381836 7.451099872589111 11.03336811065674 7.420739650726318 10.97461795806885 7.365599632263184 C 10.06604766845703 6.544379711151123 8.891417503356934 6.092099666595459 7.667118072509766 6.092099666595459 C 6.443657875061035 6.092999935150146 5.269988059997559 6.545269966125488 4.36231803894043 7.365599632263184 C 4.303567886352539 7.420729637145996 4.227168083190918 7.451099872589111 4.147217750549316 7.451099872589111 C 4.064228057861328 7.451099872589111 3.986237764358521 7.418819904327393 3.927617788314819 7.360199928283691 L 2.768417596817017 6.189300060272217 C 2.706577777862549 6.127449989318848 2.673017740249634 6.045629978179932 2.673917770385742 5.958899974822998 C 2.674807786941528 5.871150016784668 2.709967613220215 5.789649963378906 2.772917747497559 5.729399681091309 C 4.106788158416748 4.489140033721924 5.845237731933594 3.806100130081177 7.668017864227295 3.806100130081177 C 9.490477561950684 3.806100130081177 11.229248046875 4.489140033721924 12.56401824951172 5.729399681091309 C 12.62696838378906 5.790549755096436 12.66212749481201 5.872049808502197 12.66301822662354 5.958899974822998 C 12.66391754150391 6.045629978179932 12.63035774230957 6.127449989318848 12.56851768493652 6.189300060272217 L 11.40931797027588 7.360199928283691 C 11.35068798065186 7.418819904327393 11.27270793914795 7.451099872589111 11.18971824645996 7.451099872589111 Z M 13.85911750793457 4.758299827575684 C 13.77818775177002 4.758299827575684 13.70179748535156 4.726979732513428 13.64401817321777 4.67009973526001 C 12.02446746826172 3.131530046463013 9.901827812194824 2.284200191497803 7.667118072509766 2.284200191497803 C 5.431828022003174 2.284200191497803 3.308867692947388 3.131530046463013 1.68931782245636 4.670109748840332 C 1.631547808647156 4.726969718933105 1.555147767066956 4.758299827575684 1.474217772483826 4.758299827575684 C 1.390907764434814 4.758299827575684 1.312917828559875 4.725699901580811 1.254617810249329 4.666500091552734 L 0.09361779689788818 3.496500015258789 C 0.03235779702663422 3.434340000152588 -0.0008822033414617181 3.352830171585083 1.779667218215764e-05 3.267000198364258 C 0.0009177966858260334 3.180460214614868 0.03511779755353928 3.099590063095093 0.09631779789924622 3.039300203323364 C 2.143527746200562 1.079370021820068 4.832218170166016 0 7.667118072509766 0 C 10.50233840942383 0 13.19070816040039 1.079380035400391 15.23701763153076 3.039300203323364 C 15.2982177734375 3.099590063095093 15.33241748809814 3.180460214614868 15.33331775665283 3.267000198364258 C 15.33421802520752 3.352830171585083 15.30097770690918 3.434340000152588 15.23971748352051 3.496500015258789 L 14.0787181854248 4.666500091552734 C 14.02041816711426 4.725699901580811 13.94242763519287 4.758299827575684 13.85911750793457 4.758299827575684 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_hdnkf0 =
    '<svg viewBox="288.0 3.7 17.0 10.7" ><path transform="translate(288.0, 3.67)" d="M 16.00020027160645 10.6668004989624 L 15.00029945373535 10.6668004989624 C 14.44894981384277 10.6668004989624 14.00039958953857 10.2182502746582 14.00039958953857 9.666900634765625 L 14.00039958953857 0.9999000430107117 C 14.00039958953857 0.4485500752925873 14.44894981384277 7.066725515869621e-08 15.00029945373535 7.066725515869621e-08 L 16.00020027160645 7.066725515869621e-08 C 16.55154991149902 7.066725515869621e-08 17.00010108947754 0.4485500752925873 17.00010108947754 0.9999000430107117 L 17.00010108947754 9.666900634765625 C 17.00010108947754 10.2182502746582 16.55154991149902 10.6668004989624 16.00020027160645 10.6668004989624 Z M 11.33369922637939 10.6668004989624 L 10.33290004730225 10.6668004989624 C 9.781549453735352 10.6668004989624 9.332999229431152 10.2182502746582 9.332999229431152 9.666900634765625 L 9.332999229431152 3.333600044250488 C 9.332999229431152 2.782249927520752 9.781549453735352 2.333699941635132 10.33290004730225 2.333699941635132 L 11.33369922637939 2.333699941635132 C 11.88504981994629 2.333699941635132 12.33360004425049 2.782249927520752 12.33360004425049 3.333600044250488 L 12.33360004425049 9.666900634765625 C 12.33360004425049 10.2182502746582 11.88504981994629 10.6668004989624 11.33369922637939 10.6668004989624 Z M 6.666300296783447 10.6668004989624 L 5.666399955749512 10.6668004989624 C 5.115049839019775 10.6668004989624 4.666500091552734 10.2182502746582 4.666500091552734 9.666900634765625 L 4.666500091552734 5.66640043258667 C 4.666500091552734 5.115050315856934 5.115049839019775 4.666500091552734 5.666399955749512 4.666500091552734 L 6.666300296783447 4.666500091552734 C 7.218140125274658 4.666500091552734 7.667099952697754 5.115050315856934 7.667099952697754 5.66640043258667 L 7.667099952697754 9.666900634765625 C 7.667099952697754 10.2182502746582 7.218140125274658 10.6668004989624 6.666300296783447 10.6668004989624 Z M 1.999799966812134 10.6668004989624 L 0.9998999834060669 10.6668004989624 C 0.4485500156879425 10.6668004989624 0 10.2182502746582 0 9.666900634765625 L 0 7.667100429534912 C 0 7.115260124206543 0.4485500156879425 6.666300296783447 0.9998999834060669 6.666300296783447 L 1.999799966812134 6.666300296783447 C 2.55115008354187 6.666300296783447 2.99970006942749 7.115260124206543 2.99970006942749 7.667100429534912 L 2.99970006942749 9.666900634765625 C 2.99970006942749 10.2182502746582 2.55115008354187 10.6668004989624 1.999799966812134 10.6668004989624 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
