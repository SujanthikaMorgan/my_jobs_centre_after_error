// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

import 'package:adobe_xd/page_link.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_jobs_center/Screens/Notifications.dart';
import 'package:my_jobs_center/Screens/Profile.dart';
import 'package:my_jobs_center/Screens/Sign_In.dart';
import 'package:my_jobs_center/Screens/chats.dart';
import 'package:my_jobs_center/employer/employer%20screens/favUsers.dart';
import 'package:my_jobs_center/employer/employer%20screens/jobPost.dart';
import 'package:my_jobs_center/employer/employer%20screens/jobseekers.dart';
import 'package:my_jobs_center/employer/employer%20screens/membership.dart';
import 'package:my_jobs_center/employer/employer%20screens/myCompany.dart';
import 'package:my_jobs_center/employer/employer%20screens/notificationEmployee.dart';
import 'package:my_jobs_center/employer/employer%20screens/paymentpage.dart';
import 'package:my_jobs_center/employer/employer%20screens/transactionsPage.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:page_transition/page_transition.dart';

class SidemenuEmployer extends StatefulWidget {
  static const String idScreen = "SideMenu";
  const SidemenuEmployer({Key? key}) : super(key: key);

  @override
  _SidemenuEmployerState createState() => _SidemenuEmployerState();
}

class _SidemenuEmployerState extends State<SidemenuEmployer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        SizedBox(
          height: 40.h,
        ),
        Center(
          child: Container(
            child: CircleAvatar(
              backgroundColor: const Color(0xff707070),
              backgroundImage: (userDetailsResponse["image"] == null)
                  ? NetworkImage(
                      "https://myjobscentre.com/storage/profile/default_user.png",
                    )
                  : NetworkImage(
                      "$profImgLink${userDetailsResponse["image"]}",
                    ),
              radius: 35,
            ),
          ),
        ),
        Center(
          child: Text(
            (userDetailsResponse['name'] == null) ? " " : userDetailsResponse['name'],
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.sp,
              color: const Color(0xff788198),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              PageTransition(
                child: JobPost(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 10, 30),
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.string(
                        _svg_w2a8p,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'My Jobs',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: const Color(0xff788198),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              PageTransition(
                child: Profile(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 30),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.string(
                      _svg_sp9wh5,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: const Color(0xff788198),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              PageTransition(
                child: NotificationEmployee(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 30),
              child: Row(
                children: [
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: Icon(
                      Icons.notifications_active_outlined,
                      color: Color(0xff788197),
                    ),
                    /* child: SvgPicture.string(
                        _svg_b9ek72,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),*/
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: const Color(0xff788198),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              PageTransition(
                child: ChatsPage(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 30),
              child: Row(
                children: [
                  SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.chat,
                        color: Color(0xff788197),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Chat',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: const Color(0xff788198),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              PageTransition(
                child: JobSeekersPreviewPage(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 30),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.string(
                      _svg_fapjk,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Job Seekers',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: const Color(0xff788198),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              PageTransition(
                child: MyCompanies(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 30),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      Icons.business,
                      color: Color(0xff788197),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'My Companies',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: const Color(0xff788198),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              PageTransition(
                child: FavUsers(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 30),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    height: 24,
                    child: SvgPicture.string(
                      users,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Fav.Users',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: const Color(0xff788198),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              PageTransition(
                child: MembershipPage(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 30),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      Icons.badge_outlined,
                      color: Color(0xff788197),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Membership',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: const Color(0xff788198),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              PageTransition(
                child: TransactionPage(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 30),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      Icons.business,
                      color: Color(0xff788197),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Transactions',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: const Color(0xff788198),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 30),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  userDetailsResponse = {};
                  isSignedIn = false;
                });
                Navigator.pushNamedAndRemoveUntil(
                    context, SignIn.idScreen, (route) => false);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      Icons.logout,
                      color: Color(0xffCC2229),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: const Color(0xffcc2229),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

const String _svg_vew2t8 =
    '<svg viewBox="17.5 2.8 1.0 3.0" ><path transform="translate(17.46, 2.78)" d="M 0 0 L 0 3.035897493362427 C 0.6107702851295471 2.778774738311768 1.007946848869324 2.180634498596191 1.007946848869324 1.517948746681213 C 1.007946848869324 0.8552629351615906 0.6107702851295471 0.2571226954460144 0 0" fill="#000000" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ouwq95 =
    '<svg viewBox="250.2 13.2 11.6 8.3" ><path transform="translate(250.23, 13.15)" d="M 5.627884387969971 8.252252578735352 L 4.111453533172607 6.722160339355469 C 4.065004348754883 6.676394462585449 4.039047241210938 6.612867832183838 4.040413379669189 6.547292709350586 C 4.041779518127441 6.481717109680176 4.070468902587891 6.419557571411133 4.118967533111572 6.375840663909912 C 5.086887359619141 5.556830883026123 6.504955291748047 5.556830883026123 7.472875595092773 6.375840663909912 C 7.522056579589844 6.419557571411133 7.550063133239746 6.481717109680176 7.55142879486084 6.547292709350586 C 7.55279541015625 6.612867832183838 7.526838302612305 6.676394462585449 7.480388641357422 6.722160339355469 L 5.963958263397217 8.252252578735352 C 5.919558525085449 8.297335624694824 5.859447479248047 8.322608947753906 5.795921325683594 8.322608947753906 C 5.733078002929688 8.322608947753906 5.672284603118896 8.297335624694824 5.627884387969971 8.252252578735352 Z M 8.295982360839844 5.573224544525146 C 7.610857009887695 4.952991008758545 6.7201247215271 4.609403133392334 5.795921325683594 4.609403133392334 C 4.872401237487793 4.609403133392334 3.982351779937744 4.952991008758545 3.297908544540405 5.573224544525146 C 3.205010175704956 5.660658836364746 3.058831691741943 5.659292221069336 2.968665599822998 5.568443298339844 L 2.092960834503174 4.683175563812256 C 2.046511650085449 4.636726379394531 2.020554780960083 4.573883056640625 2.021237850189209 4.508307933807373 C 2.021920919418335 4.442732334136963 2.048560857772827 4.380572319030762 2.095693111419678 4.334806442260742 C 4.18181037902832 2.394184827804565 7.412081718444824 2.394184827804565 9.497515678405762 4.334806442260742 C 9.544648170471191 4.380572319030762 9.57197093963623 4.442732334136963 9.572653770446777 4.508307933807373 C 9.573336601257324 4.573883056640625 9.547379493713379 4.636726379394531 9.501613616943359 4.683175563812256 L 8.625226020812988 5.568443298339844 C 8.579013824462891 5.614655017852783 8.518677711486816 5.637712955474854 8.458301544189453 5.637709140777588 C 8.399983406066895 5.637704849243164 8.34162712097168 5.616183757781982 8.295982360839844 5.573224544525146 Z M 10.31447505950928 3.533557415008545 C 9.095183372497559 2.375058889389038 7.477656841278076 1.728184819221497 5.795921325683594 1.728184819221497 C 4.114185810089111 1.728184819221497 2.496659278869629 2.374375820159912 1.277366995811462 3.533557415008545 C 1.185834646224976 3.623040437698364 1.038973212242126 3.621674299240112 0.9481239318847656 3.530824899673462 L 0.0710531547665596 2.645557403564453 C 0.02528699487447739 2.599107980728149 -0.0006699295481666923 2.536947965621948 1.314740893576527e-05 2.472055673599243 C 0.0006962243933230639 2.407163381576538 0.02665314823389053 2.345003366470337 0.07310238480567932 2.299237251281738 C 3.27195143699646 -0.7664121985435486 8.319208145141602 -0.7664121985435486 11.51873970031738 2.299237251281738 C 11.56450653076172 2.345003366470337 11.59114646911621 2.407163381576538 11.59114646911621 2.472055673599243 C 11.59182929992676 2.536947965621948 11.56587219238281 2.599107980728149 11.52010631561279 2.645557403564453 L 10.64303588867188 3.530824899673462 C 10.59743499755859 3.576771020889282 10.53735160827637 3.599828720092773 10.47723960876465 3.599823713302612 C 10.41849136352539 3.59981894493103 10.35971641540527 3.57778525352478 10.31447505950928 3.533557415008545 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_zcci6d =
    '<svg viewBox="233.5 13.4 12.9 8.1" ><path transform="translate(233.51, 13.41)" d="M 11.38484382629395 8.095828056335449 C 10.96543407440186 8.095828056335449 10.62594509124756 7.755655765533447 10.62594509124756 7.336929798126221 L 10.62594509124756 0.7588984966278076 C 10.62594509124756 0.3394892513751984 10.96543407440186 0 11.38484382629395 0 L 12.14374160766602 0 C 12.56246852874756 0 12.90264129638672 0.3394892513751984 12.90264129638672 0.7588984966278076 L 12.90264129638672 7.336929798126221 C 12.90264129638672 7.755655765533447 12.56246852874756 8.095828056335449 12.14374160766602 8.095828056335449 L 11.38484382629395 8.095828056335449 Z M 7.842406272888184 8.095828056335449 C 7.423680305480957 8.095828056335449 7.083508014678955 7.755655765533447 7.083508014678955 7.336929798126221 L 7.083508014678955 2.530117034912109 C 7.083508014678955 2.110707759857178 7.423680305480957 1.771218419075012 7.842406272888184 1.771218419075012 L 8.601987838745117 1.771218419075012 C 9.020713806152344 1.771218419075012 9.360886573791504 2.110707759857178 9.360886573791504 2.530117034912109 L 9.360886573791504 7.336929798126221 C 9.360886573791504 7.755655765533447 9.020713806152344 8.095828056335449 8.601987838745117 8.095828056335449 L 7.842406272888184 8.095828056335449 Z M 4.300652503967285 8.095828056335449 C 3.881926536560059 8.095828056335449 3.541754007339478 7.755655765533447 3.541754007339478 7.336929798126221 L 3.541754007339478 4.300652503967285 C 3.541754007339478 3.881926536560059 3.881926536560059 3.541754007339478 4.300652503967285 3.541754007339478 L 5.059551239013672 3.541754007339478 C 5.478960037231445 3.541754007339478 5.819132328033447 3.881926536560059 5.819132328033447 4.300652503967285 L 5.819132328033447 7.336929798126221 C 5.819132328033447 7.755655765533447 5.478960037231445 8.095828056335449 5.059551239013672 8.095828056335449 L 4.300652503967285 8.095828056335449 Z M 0.7588984966278076 8.095828056335449 C 0.3394892513751984 8.095828056335449 0 7.755655765533447 0 7.336929798126221 L 0 5.819132328033447 C 0 5.399723052978516 0.3394892513751984 5.059551239013672 0.7588984966278076 5.059551239013672 L 1.517796993255615 5.059551239013672 C 1.937206268310547 5.059551239013672 2.276695489883423 5.399723052978516 2.276695489883423 5.819132328033447 L 2.276695489883423 7.336929798126221 C 2.276695489883423 7.755655765533447 1.937206268310547 8.095828056335449 1.517796993255615 8.095828056335449 L 0.7588984966278076 8.095828056335449 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_bl9g6t =
    '<svg viewBox="0.0 0.0 14.8 14.8" ><path transform="translate(0.75, 0.75)" d="M 6.641651630401611 -0.75 C 10.71742057800293 -0.75 14.03330326080322 2.56588339805603 14.03330326080322 6.641651630401611 C 14.03330326080322 10.71742057800293 10.71742057800293 14.03330326080322 6.641651630401611 14.03330326080322 C 2.56588339805603 14.03330326080322 -0.75 10.71742057800293 -0.75 6.641651630401611 C -0.75 2.56588339805603 2.56588339805603 -0.75 6.641651630401611 -0.75 Z M 6.641651630401611 12.89484214782715 C 10.08967304229736 12.89484214782715 12.89484214782715 10.08967304229736 12.89484214782715 6.641651630401611 C 12.89484214782715 3.193630933761597 10.08967304229736 0.38846156001091 6.641651630401611 0.38846156001091 C 3.193630933761597 0.38846156001091 0.38846156001091 3.193630933761597 0.38846156001091 6.641651630401611 C 0.38846156001091 10.08967304229736 3.193630933761597 12.89484214782715 6.641651630401611 12.89484214782715 Z" fill="#788198" fill-opacity="0.4" stroke="none" stroke-width="1.5" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_mmh3e0 =
    '<svg viewBox="11.6 11.9 3.8 3.8" ><path transform="translate(12.32, 12.67)" d="M 2.493850708007812 3.056257247924805 C 2.348403215408325 3.056257247924805 2.202980756759644 3.000879764556885 2.091865301132202 2.890048265457153 L -0.5827605128288269 0.2222533226013184 C -0.8053448796272278 0.0002381503582000732 -0.805807888507843 -0.3601760268211365 -0.5837926864624023 -0.5827604532241821 C -0.3617775440216064 -0.8053448796272278 -0.001363292336463928 -0.8058077692985535 0.2212210446596146 -0.5837926864624023 L 2.895846605300903 2.084002256393433 C 3.118431329727173 2.306017398834229 3.118894100189209 2.666431665420532 2.896878957748413 2.889016151428223 C 2.78569507598877 3.000484943389893 2.639760494232178 3.056257247924805 2.493850708007812 3.056257247924805 Z" fill="#788198" fill-opacity="0.4" stroke="none" stroke-width="1.5" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_grz161 =
    '<svg viewBox="11.6 4.4 5.7 1.1" ><path transform="translate(12.32, 5.11)" d="M 4.373076915740967 0.38846156001091 L -0.1807692348957062 0.38846156001091 C -0.4951440095901489 0.38846156001091 -0.75 0.1336055397987366 -0.75 -0.1807692348957062 C -0.75 -0.4951440095901489 -0.4951440095901489 -0.75 -0.1807692348957062 -0.75 L 4.373076915740967 -0.75 C 4.687451362609863 -0.75 4.942307472229004 -0.4951440095901489 4.942307472229004 -0.1807692348957062 C 4.942307472229004 0.1336055397987366 4.687451362609863 0.38846156001091 4.373076915740967 0.38846156001091 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_uv39bg =
    '<svg viewBox="0.9 4.4 4.2 1.1" ><path transform="translate(1.7, 5.11)" d="M 2.855128288269043 0.38846156001091 L -0.1807692348957062 0.38846156001091 C -0.4951440095901489 0.38846156001091 -0.75 0.1336055397987366 -0.75 -0.1807692348957062 C -0.75 -0.4951440095901489 -0.4951440095901489 -0.75 -0.1807692348957062 -0.75 L 2.855128288269043 -0.75 C 3.169502973556519 -0.75 3.424359083175659 -0.4951440095901489 3.424359083175659 -0.1807692348957062 C 3.424359083175659 0.1336055397987366 3.169502973556519 0.38846156001091 2.855128288269043 0.38846156001091 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_egngll =
    '<svg viewBox="4.4 1.7 6.5 6.5" ><path transform="translate(5.11, 2.46)" d="M 2.475641012191772 -0.75 C 4.25426721572876 -0.75 5.701282024383545 0.6970149278640747 5.701282024383545 2.475641012191772 C 5.701282024383545 4.25426721572876 4.25426721572876 5.701282024383545 2.475641012191772 5.701282024383545 C 0.6970149278640747 5.701282024383545 -0.75 4.25426721572876 -0.75 2.475641012191772 C -0.75 0.6970149278640747 0.6970149278640747 -0.75 2.475641012191772 -0.75 Z M 2.475641012191772 4.562820434570312 C 3.626519680023193 4.562820434570312 4.562820434570312 3.626519680023193 4.562820434570312 2.475641012191772 C 4.562820434570312 1.32476282119751 3.626519680023193 0.38846156001091 2.475641012191772 0.38846156001091 C 1.32476282119751 0.38846156001091 0.38846156001091 1.32476282119751 0.38846156001091 2.475641012191772 C 0.38846156001091 3.626519680023193 1.32476282119751 4.562820434570312 2.475641012191772 4.562820434570312 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_sk6fcz =
    '<svg viewBox="13.1 12.7 4.2 1.1" ><path transform="translate(13.84, 13.46)" d="M 2.855128288269043 0.38846156001091 L -0.1807692348957062 0.38846156001091 C -0.4951440095901489 0.38846156001091 -0.75 0.1336055397987366 -0.75 -0.1807692348957062 C -0.75 -0.4951440095901489 -0.4951440095901489 -0.75 -0.1807692348957062 -0.75 L 2.855128288269043 -0.75 C 3.169502973556519 -0.75 3.424359083175659 -0.4951440095901489 3.424359083175659 -0.1807692348957062 C 3.424359083175659 0.1336055397987366 3.169502973556519 0.38846156001091 2.855128288269043 0.38846156001091 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_ynom2r =
    '<svg viewBox="0.9 12.7 5.7 1.1" ><path transform="translate(1.7, 13.46)" d="M 4.373076915740967 0.38846156001091 L -0.1807692348957062 0.38846156001091 C -0.4951440095901489 0.38846156001091 -0.75 0.1336055397987366 -0.75 -0.1807692348957062 C -0.75 -0.4951440095901489 -0.4951440095901489 -0.75 -0.1807692348957062 -0.75 L 4.373076915740967 -0.75 C 4.687451362609863 -0.75 4.942307472229004 -0.4951440095901489 4.942307472229004 -0.1807692348957062 C 4.942307472229004 0.1336055397987366 4.687451362609863 0.38846156001091 4.373076915740967 0.38846156001091 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_poymc3 =
    '<svg viewBox="7.4 10.1 6.5 6.5" ><path transform="translate(8.15, 10.81)" d="M 2.475641012191772 -0.75 C 4.25426721572876 -0.75 5.701282024383545 0.6970149278640747 5.701282024383545 2.475641012191772 C 5.701282024383545 4.25426721572876 4.25426721572876 5.701282024383545 2.475641012191772 5.701282024383545 C 0.6970149278640747 5.701282024383545 -0.75 4.25426721572876 -0.75 2.475641012191772 C -0.75 0.6970149278640747 0.6970149278640747 -0.75 2.475641012191772 -0.75 Z M 2.475641012191772 4.562820434570312 C 3.626519680023193 4.562820434570312 4.562820434570312 3.626519680023193 4.562820434570312 2.475641012191772 C 4.562820434570312 1.32476282119751 3.626519680023193 0.38846156001091 2.475641012191772 0.38846156001091 C 1.32476282119751 0.38846156001091 0.38846156001091 1.32476282119751 0.38846156001091 2.475641012191772 C 0.38846156001091 3.626519680023193 1.32476282119751 4.562820434570312 2.475641012191772 4.562820434570312 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_n340ly =
    '<svg viewBox="0.0 0.0 18.2 18.2" ><path  d="M 0 0 L 18.21538543701172 0 L 18.21538543701172 18.21538543701172 L 0 18.21538543701172 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_kg76x =
    '<svg viewBox="0.0 0.0 7.0 12.3" ><path transform="translate(-11.25, -6.19)" d="M 13.37034225463867 12.34205055236816 L 18.02475166320801 7.691286563873291 C 18.3690013885498 7.347036361694336 18.3690013885498 6.790298938751221 18.02475166320801 6.449694156646729 C 17.68050193786621 6.105443477630615 17.12376403808594 6.109089374542236 16.77951431274414 6.449694156646729 L 11.50639152526855 11.71969318389893 C 11.17307662963867 12.05300521850586 11.16578674316406 12.5873498916626 11.48087120056152 12.93159866333008 L 16.77586936950684 18.23753356933594 C 16.94773483276367 18.40939712524414 17.1748046875 18.4937686920166 17.39822769165039 18.4937686920166 C 17.62165069580078 18.4937686920166 17.84872055053711 18.40939712524414 18.02058601379395 18.23753356933594 C 18.36483573913574 17.89328384399414 18.36483573913574 17.33654594421387 18.02058601379395 16.99593925476074 L 13.37034225463867 12.34205055236816 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_hnitpf =
    '<svg viewBox="0.0 0.0 20.5 1.7" ><path transform="translate(-4.5, -10.12)" d="M 24.13846206665039 11.83269309997559 L 5.353846073150635 11.83269309997559 C 4.884230613708496 11.83269309997559 4.5 11.44846153259277 4.5 10.97884654998779 L 4.5 10.97884654998779 C 4.5 10.50923156738281 4.884230613708496 10.125 5.353846073150635 10.125 L 24.13846206665039 10.125 C 24.60807800292969 10.125 24.99230766296387 10.50923156738281 24.99230766296387 10.97884654998779 L 24.99230766296387 10.97884654998779 C 24.99230766296387 11.44846153259277 24.60807800292969 11.83269309997559 24.13846206665039 11.83269309997559 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_oiljjp =
    '<svg viewBox="0.0 5.1 20.5 1.7" ><path transform="translate(-4.5, -11.75)" d="M 24.13846206665039 18.58269119262695 L 5.353846073150635 18.58269119262695 C 4.884230613708496 18.58269119262695 4.5 18.19846153259277 4.5 17.72884750366211 L 4.5 17.72884750366211 C 4.5 17.25923156738281 4.884230613708496 16.875 5.353846073150635 16.875 L 24.13846206665039 16.875 C 24.60807800292969 16.875 24.99230766296387 17.25923156738281 24.99230766296387 17.72884750366211 L 24.99230766296387 17.72884750366211 C 24.99230766296387 18.19846153259277 24.60807800292969 18.58269119262695 24.13846206665039 18.58269119262695 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ed9hz =
    '<svg viewBox="0.0 10.2 20.5 1.7" ><path transform="translate(-4.5, -13.38)" d="M 24.13846206665039 25.33269309997559 L 5.353846073150635 25.33269309997559 C 4.884230613708496 25.33269309997559 4.5 24.94846153259277 4.5 24.47884750366211 L 4.5 24.47884750366211 C 4.5 24.00923156738281 4.884230613708496 23.625 5.353846073150635 23.625 L 24.13846206665039 23.625 C 24.60807800292969 23.625 24.99230766296387 24.00923156738281 24.99230766296387 24.47884750366211 L 24.99230766296387 24.47884750366211 C 24.99230766296387 24.94846153259277 24.60807800292969 25.33269309997559 24.13846206665039 25.33269309997559 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_v141r =
    '<svg viewBox="23.0 4.0 1.3 4.0" ><path transform="translate(23.0, 4.0)" d="M 0 0 L 0 4 C 0.8047311305999756 3.661223411560059 1.328037977218628 2.873133182525635 1.328037977218628 2 C 1.328037977218628 1.126866698265076 0.8047311305999756 0.3387765288352966 0 0" fill="#000000" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ltg2cz =
    '<svg viewBox="315.7 17.3 15.3 11.0" ><path transform="translate(315.69, 17.33)" d="M 7.41510009765625 10.87290000915527 L 5.417099952697754 8.856900215148926 C 5.355900287628174 8.796600341796875 5.321700096130371 8.712900161743164 5.323500156402588 8.626500129699707 C 5.325300216674805 8.54010009765625 5.363100051879883 8.458200454711914 5.427000045776367 8.400600433349609 C 6.702300071716309 7.321500301361084 8.570700645446777 7.321500301361084 9.846000671386719 8.400600433349609 C 9.910799980163574 8.458200454711914 9.947700500488281 8.54010009765625 9.94950008392334 8.626500129699707 C 9.951300621032715 8.712900161743164 9.917099952697754 8.796600341796875 9.855899810791016 8.856900215148926 L 7.857900142669678 10.87290000915527 C 7.799400329589844 10.93230056762695 7.720200061798096 10.96560001373291 7.636500358581543 10.96560001373291 C 7.553699970245361 10.96560001373291 7.473600387573242 10.93230056762695 7.41510009765625 10.87290000915527 Z M 10.93050003051758 7.343100070953369 C 10.02780055999756 6.525900363922119 8.85420036315918 6.073200225830078 7.636500358581543 6.073200225830078 C 6.419700145721436 6.073200225830078 5.247000217437744 6.525900363922119 4.345200061798096 7.343100070953369 C 4.222800254821777 7.458300113677979 4.030200004577637 7.456500053405762 3.911400079727173 7.336800098419189 L 2.757600069046021 6.170400142669678 C 2.696400165557861 6.109200000762939 2.662199974060059 6.026400089263916 2.663100004196167 5.940000057220459 C 2.664000034332275 5.853600025177002 2.699100017547607 5.771699905395508 2.761199951171875 5.711400032043457 C 5.509799957275391 3.154500007629395 9.765900611877441 3.154500007629395 12.51360034942627 5.711400032043457 C 12.5757007598877 5.771699905395508 12.6117000579834 5.853600025177002 12.61260032653809 5.940000057220459 C 12.61350059509277 6.026400089263916 12.57929992675781 6.109200000762939 12.51900005340576 6.170400142669678 L 11.36430072784424 7.336800098419189 C 11.30341243743896 7.397687435150146 11.22391605377197 7.428067684173584 11.14436626434326 7.428062438964844 C 11.06752777099609 7.428057193756104 10.99063968658447 7.399701595306396 10.93050003051758 7.343100070953369 Z M 13.59000015258789 4.655700206756592 C 11.98350048065186 3.129300117492676 9.852300643920898 2.276999950408936 7.636500358581543 2.276999950408936 C 5.420700073242188 2.276999950408936 3.289499998092651 3.128400087356567 1.683000087738037 4.655700206756592 C 1.562399983406067 4.773600101470947 1.368900060653687 4.77180004119873 1.249199986457825 4.652100086212158 L 0.09360000491142273 3.485700130462646 C 0.0333000011742115 3.424499988555908 -0.0009000000427477062 3.342600107192993 0 3.257100105285645 C 0.0009000000427477062 3.171600103378296 0.03510000184178352 3.089699983596802 0.09630000591278076 3.029400110244751 C 4.310999870300293 -1.00980007648468 10.96110057830811 -1.00980007648468 15.17670059204102 3.029400110244751 C 15.23700046539307 3.089699983596802 15.2721004486084 3.171600103378296 15.2721004486084 3.257100105285645 C 15.27300071716309 3.342600107192993 15.23880004882812 3.424499988555908 15.17850017547607 3.485700130462646 L 14.02290058135986 4.652100086212158 C 13.96281909942627 4.712636947631836 13.88365459442139 4.743017196655273 13.80445384979248 4.743010520935059 C 13.72704887390137 4.743004322052002 13.64960861206055 4.713973522186279 13.59000015258789 4.655700206756592 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_renyrk =
    '<svg viewBox="293.7 17.7 17.0 10.7" ><path transform="translate(293.67, 17.67)" d="M 15.00030040740967 10.6668004989624 C 14.44770050048828 10.6668004989624 14.00040054321289 10.21860027313232 14.00040054321289 9.666900634765625 L 14.00040054321289 0.9999000430107117 C 14.00040054321289 0.4473000168800354 14.44770050048828 0 15.00030040740967 0 L 16.00020027160645 0 C 16.55190086364746 0 17.00010108947754 0.4473000168800354 17.00010108947754 0.9999000430107117 L 17.00010108947754 9.666900634765625 C 17.00010108947754 10.21860027313232 16.55190086364746 10.6668004989624 16.00020027160645 10.6668004989624 L 15.00030040740967 10.6668004989624 Z M 10.33290004730225 10.6668004989624 C 9.781200408935547 10.6668004989624 9.333000183105469 10.21860027313232 9.333000183105469 9.666900634765625 L 9.333000183105469 3.333600044250488 C 9.333000183105469 2.781000137329102 9.781200408935547 2.333699941635132 10.33290004730225 2.333699941635132 L 11.33370018005371 2.333699941635132 C 11.88539981842041 2.333699941635132 12.33360004425049 2.781000137329102 12.33360004425049 3.333600044250488 L 12.33360004425049 9.666900634765625 C 12.33360004425049 10.21860027313232 11.88539981842041 10.6668004989624 11.33370018005371 10.6668004989624 L 10.33290004730225 10.6668004989624 Z M 5.666399955749512 10.6668004989624 C 5.114700317382812 10.6668004989624 4.666500091552734 10.21860027313232 4.666500091552734 9.666900634765625 L 4.666500091552734 5.666399955749512 C 4.666500091552734 5.114700317382812 5.114700317382812 4.666500091552734 5.666399955749512 4.666500091552734 L 6.666300296783447 4.666500091552734 C 7.218900203704834 4.666500091552734 7.667099952697754 5.114700317382812 7.667099952697754 5.666399955749512 L 7.667099952697754 9.666900634765625 C 7.667099952697754 10.21860027313232 7.218900203704834 10.6668004989624 6.666300296783447 10.6668004989624 L 5.666399955749512 10.6668004989624 Z M 0.9999000430107117 10.6668004989624 C 0.4473000168800354 10.6668004989624 0 10.21860027313232 0 9.666900634765625 L 0 7.667099952697754 C 0 7.114500045776367 0.4473000168800354 6.666300296783447 0.9999000430107117 6.666300296783447 L 1.999800086021423 6.666300296783447 C 2.5524001121521 6.666300296783447 2.99970006942749 7.114500045776367 2.99970006942749 7.667099952697754 L 2.99970006942749 9.666900634765625 C 2.99970006942749 10.21860027313232 2.5524001121521 10.6668004989624 1.999800086021423 10.6668004989624 L 0.9999000430107117 10.6668004989624 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_xexmbp =
    '<svg viewBox="0.0 0.0 12.4 20.9" ><path transform="translate(-7.0, -58.95)" d="M 7 62.44107818603516 L 7 76.39417266845703 C 7 78.31679534912109 8.568456649780273 79.88524627685547 10.49108123779297 79.88524627685547 L 15.92148303985596 79.88524627685547 C 17.84410667419434 79.88524627685547 19.41256332397461 78.31679534912109 19.41256332397461 76.39417266845703 L 19.41256332397461 74.13423919677734 C 19.41256332397461 73.75196838378906 19.10336875915527 73.44277191162109 18.72109603881836 73.44277191162109 C 18.33881759643555 73.44277191162109 18.02962303161621 73.75196838378906 18.02962303161621 74.13423919677734 L 18.02962303161621 76.39417266845703 C 18.02962303161621 77.557861328125 17.07955551147461 78.5079345703125 15.91586303710938 78.5079345703125 L 10.49108123779297 78.5079345703125 C 9.327387809753418 78.5079345703125 8.3773193359375 77.557861328125 8.3773193359375 76.39417266845703 L 8.3773193359375 62.44107818603516 C 8.3773193359375 61.27739334106445 9.327387809753418 60.32732009887695 10.49108123779297 60.32732009887695 L 15.92148303985596 60.32732009887695 C 17.08517646789551 60.32732009887695 18.03524398803711 61.27739334106445 18.03524398803711 62.44107818603516 L 18.03524398803711 64.70101165771484 C 18.03524398803711 65.08329010009766 18.34443855285645 65.39248657226562 18.72671508789062 65.39248657226562 C 19.10898971557617 65.39248657226562 19.41818428039551 65.08329010009766 19.41818428039551 64.70101165771484 L 19.41818428039551 62.44107818603516 C 19.41818428039551 60.51845932006836 17.8497257232666 58.95000457763672 15.92710208892822 58.95000457763672 L 10.49108123779297 58.95000457763672 C 8.568456649780273 58.95000457763672 7 60.51283264160156 7 62.44107818603516 Z" fill="#cc2229" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ebox62 =
    '<svg viewBox="5.8 5.1 16.0 10.8" ><path transform="translate(-200.55, -143.89)" d="M 216.3684844970703 159.5581207275391 C 216.5034027099609 159.6930541992188 216.6776733398438 159.760498046875 216.8575744628906 159.760498046875 C 217.0374755859375 159.760498046875 217.2117309570312 159.6930541992188 217.3466491699219 159.5581207275391 L 222.0632781982422 154.8415222167969 C 222.3331146240234 154.5716705322266 222.3331146240234 154.1388092041016 222.0632781982422 153.8689575195312 L 217.3466491699219 149.15234375 C 217.0768127441406 148.8825073242188 216.6439514160156 148.8825073242188 216.3740997314453 149.15234375 C 216.1042633056641 149.4221954345703 216.1042633056641 149.8550567626953 216.3740997314453 150.1249084472656 L 219.9158020019531 153.6665802001953 L 206.9914703369141 153.6665802001953 C 206.6092071533203 153.6665802001953 206.3000030517578 153.9757690429688 206.3000030517578 154.3580474853516 C 206.3000030517578 154.7403259277344 206.6092071533203 155.0495147705078 206.9914703369141 155.0495147705078 L 219.91015625 155.0495147705078 L 216.3684844970703 158.5911865234375 C 216.0986480712891 158.8554077148438 216.0986480712891 159.2939147949219 216.3684844970703 159.5581207275391 Z" fill="#cc2229" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xboiag =
    '<svg viewBox="260.2 878.6 25.0 24.0" ><path transform="translate(268.48, 888.71)" d="M 8.266453742980957 0.9951200485229492 L 0.1225600019097328 0.9951200485229492 C -0.3593374490737915 0.9951200485229492 -0.7500000596046448 0.6044573783874512 -0.7500000596046448 0.1225600019097328 C -0.7500000596046448 -0.3593374490737915 -0.3593374490737915 -0.7500000596046448 0.1225600019097328 -0.7500000596046448 L 8.266453742980957 -0.7500000596046448 C 8.748350143432617 -0.7500000596046448 9.139012336730957 -0.3593374490737915 9.139012336730957 0.1225600019097328 C 9.139012336730957 0.6044573783874512 8.748350143432617 0.9951200485229492 8.266453742980957 0.9951200485229492 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(260.92, 879.32)" d="M 16.41057777404785 23.24993896484375 C 16.01112365722656 23.25228118896484 15.62308216094971 23.13131904602051 15.28646469116211 22.90691757202148 L 10.32957744598389 19.6097354888916 L 5.93962574005127 19.6097354888916 C 3.990676403045654 19.6097354888916 2.318979740142822 18.96819686889648 1.105260133743286 17.75447654724121 C -0.1084590405225754 16.5407543182373 -0.75 14.86905670166016 -0.75 12.92010593414307 L -0.75 5.939627647399902 C -0.75 3.990677833557129 -0.1084590405225754 2.318980932235718 1.105260133743286 1.10526168346405 C 2.318979740142822 -0.1084577441215515 3.990676403045654 -0.7499988079071045 5.93962574005127 -0.7499988079071045 L 17.57375907897949 -0.7499988079071045 C 19.52270889282227 -0.7499988079071045 21.19440650939941 -0.1084577441215515 22.40812873840332 1.10526168346405 C 23.6218433380127 2.318980932235718 24.26338577270508 3.990677833557129 24.26338577270508 5.939627647399902 L 24.26338577270508 12.92010593414307 C 24.26338577270508 14.86905670166016 23.6218433380127 16.5407543182373 22.40812873840332 17.75447654724121 C 21.37967872619629 18.78292083740234 20.0224723815918 19.40053367614746 18.44631958007812 19.56512641906738 L 18.44631958007812 21.21524620056152 C 18.44631958007812 21.77896690368652 18.22360610961914 22.30116271972656 17.81922912597656 22.68562507629395 C 17.44200134277344 23.04425048828125 16.92856979370117 23.24993896484375 16.41057777404785 23.24993896484375 Z M 5.93962574005127 0.9951211214065552 C 2.935949325561523 0.9951211214065552 0.9951199293136597 2.935950756072998 0.9951199293136597 5.939627647399902 L 0.9951199293136597 12.92010593414307 C 0.9951199293136597 15.92378425598145 2.935949325561523 17.8646125793457 5.93962574005127 17.8646125793457 L 10.59327793121338 17.8646125793457 C 10.76523113250732 17.8646125793457 10.9333553314209 17.9154224395752 11.07653617858887 18.01065635681152 L 16.25373649597168 21.45438385009766 C 16.30488395690918 21.48848342895508 16.35593414306641 21.50480651855469 16.41056632995605 21.50481986999512 C 16.48439598083496 21.50481986999512 16.56149482727051 21.47344017028809 16.61679267883301 21.42086791992188 C 16.6735897064209 21.36686134338379 16.70119857788086 21.29960441589355 16.70119857788086 21.21524620056152 L 16.70119857788086 18.73717498779297 C 16.70119857788086 18.25527954101562 17.09185981750488 17.8646125793457 17.57375907897949 17.8646125793457 C 20.57743644714355 17.8646125793457 22.51826477050781 15.92378425598145 22.51826477050781 12.92010593414307 L 22.51826477050781 5.939627647399902 C 22.51826477050781 2.935950756072998 20.57743644714355 0.9951211214065552 17.57375907897949 0.9951211214065552 L 5.93962574005127 0.9951211214065552 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_pjqyx5 =
    '<svg viewBox="284.0 879.0 25.1 24.0" ><path transform="translate(284.0, 879.0)" d="M 18.81970977783203 0 L 6.273236751556396 0 C 2.509294748306274 0 0 2.509294748306274 0 6.273236751556396 L 0 13.80112075805664 C 0 17.5650634765625 2.509294748306274 20.0743579864502 6.273236751556396 20.0743579864502 L 11.29182529449463 20.0743579864502 L 16.87500762939453 23.78811264038086 C 17.70307350158691 24.34015846252441 18.81970977783203 23.75047302246094 18.81970977783203 22.74675750732422 L 18.81970977783203 20.0743579864502 C 22.58365058898926 20.0743579864502 25.09294700622559 17.5650634765625 25.09294700622559 13.80112075805664 L 25.09294700622559 6.273236751556396 C 25.09294700622559 2.509294748306274 22.58365058898926 0 18.81970977783203 0 Z M 16.93774032592773 11.06598949432373 L 8.155207633972168 11.06598949432373 C 7.64080286026001 11.06598949432373 7.214222431182861 10.63940906524658 7.214222431182861 10.12500476837158 C 7.214222431182861 9.610598564147949 7.64080286026001 9.184019088745117 8.155207633972168 9.184019088745117 L 16.93774032592773 9.184019088745117 C 17.4521427154541 9.184019088745117 17.87872505187988 9.610598564147949 17.87872505187988 10.12500476837158 C 17.87872505187988 10.63940906524658 17.4521427154541 11.06598949432373 16.93774032592773 11.06598949432373 Z" fill="#788198" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_c33cl =
    '<svg viewBox="15.7 1.0 4.5 8.8" ><path transform="translate(-349.78, -22.81)" d="M 369.2627868652344 32.66567230224609 C 368.8832397460938 32.66567230224609 368.5752868652344 32.35767364501953 368.5752868652344 31.97817039489746 C 368.5752868652344 29.34548187255859 367.550537109375 26.87139129638672 365.6896057128906 25.0096321105957 C 365.4210510253906 24.74107551574707 365.4210510253906 24.30567932128906 365.6896057128906 24.03712272644043 C 365.9581604003906 23.76856803894043 366.3935852050781 23.76856803894043 366.6622924804688 24.03712272644043 C 368.7825317382812 26.15821647644043 369.9502563476562 28.97890090942383 369.9502563476562 31.97817802429199 C 369.9502563476562 32.35768127441406 369.6422729492188 32.66567993164062 369.2627563476562 32.66567993164062 Z M 369.2627868652344 32.66567230224609" fill="#788198" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_l5t8ny =
    '<svg viewBox="0.0 1.0 4.5 8.8" ><path transform="translate(0.0, -22.83)" d="M 0.6875038146972656 32.68461608886719 C 0.308000385761261 32.68461608886719 0 32.37661361694336 0 31.99711418151855 C 0 28.99784469604492 1.167884111404419 26.17717742919922 3.288975238800049 24.05691719055176 C 3.557531595230103 23.78836059570312 3.993095397949219 23.78836059570312 4.261651039123535 24.05691719055176 C 4.53020715713501 24.32547187805176 4.53020715713501 24.76103782653809 4.261651039123535 25.02959251403809 C 2.399886846542358 26.89035224914551 1.375007629394531 29.36443328857422 1.375007629394531 31.99709892272949 C 1.375007629394531 32.37660217285156 1.067007064819336 32.68460083007812 0.6875038146972656 32.68460083007812 Z M 0.6875038146972656 32.68461608886719" fill="#788198" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_voz3s5 =
    '<svg viewBox="6.6 17.9 6.9 4.1" ><path transform="translate(-148.02, -398.12)" d="M 158.1055145263672 420.125 C 156.2098388671875 420.125 154.6679992675781 418.5831298828125 154.6679992675781 416.6874694824219 C 154.6679992675781 416.3079833984375 154.9759826660156 415.9999694824219 155.3554992675781 415.9999694824219 C 155.7349853515625 415.9999694824219 156.0429992675781 416.3079833984375 156.0429992675781 416.6874694824219 C 156.0429992675781 417.8251342773438 156.9678192138672 418.75 158.1055145263672 418.75 C 159.2430267333984 418.75 160.1680297851562 417.8251342773438 160.1680297851562 416.6874694824219 C 160.1680297851562 416.3079833984375 160.4760131835938 415.9999694824219 160.8555297851562 415.9999694824219 C 161.2350158691406 415.9999694824219 161.5430297851562 416.3079833984375 161.5430297851562 416.6874694824219 C 161.5430297851562 418.5831298828125 160.0011901855469 420.125 158.1055145263672 420.125 Z M 158.1055145263672 420.125" fill="#788198" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_fwa =
    '<svg viewBox="0.9 2.8 18.3 16.5" ><path transform="translate(-20.42, -61.25)" d="M 38.06147003173828 80.50055694580078 L 22.93638801574707 80.50055694580078 C 22.05166244506836 80.50055694580078 21.33209991455078 79.78099060058594 21.33209991455078 78.89643859863281 C 21.33209991455078 78.42696380615234 21.53653717041016 77.98251342773438 21.89321327209473 77.67719268798828 C 23.28735733032227 76.49923706054688 24.08211517333984 74.78703308105469 24.08211517333984 72.97295379638672 L 24.08211517333984 70.41713714599609 C 24.08211517333984 66.87890625 26.96053504943848 64.00048828125 30.49893188476562 64.00048828125 C 34.03716278076172 64.00048828125 36.91557312011719 66.87890625 36.91557312011719 70.41713714599609 L 36.91557312011719 72.97295379638672 C 36.91557312011719 74.78704833984375 37.7103385925293 76.49925994873047 39.09541702270508 77.67082977294922 C 39.46115493774414 77.98252868652344 39.66558837890625 78.42698669433594 39.66558837890625 78.89645385742188 C 39.66558837890625 79.781005859375 38.94602966308594 80.50057983398438 38.06147384643555 80.50057983398438 Z M 30.49892616271973 65.37547302246094 C 27.71853256225586 65.37547302246094 25.45711898803711 67.63688659667969 25.45711898803711 70.4171142578125 L 25.45711898803711 72.97292327880859 C 25.45711898803711 75.19203948974609 24.48460960388184 77.28762054443359 22.7896842956543 78.72037506103516 C 22.75762557983398 78.74790191650391 22.70710372924805 78.8048095703125 22.70710372924805 78.89645385742188 C 22.70710372924805 79.02099609375 22.81167221069336 79.12555694580078 22.93638229370117 79.12555694580078 L 38.06147003173828 79.12555694580078 C 38.18601226806641 79.12555694580078 38.29058074951172 79.02099609375 38.29058074951172 78.89645385742188 C 38.29058074951172 78.8048095703125 38.24022674560547 78.74790191650391 38.20984649658203 78.72222900390625 C 36.5130729675293 77.28762817382812 35.54056549072266 75.19205474853516 35.54056549072266 72.97292327880859 L 35.54056549072266 70.4171142578125 C 35.54056549072266 67.63688659667969 33.27915573120117 65.37547302246094 30.49892616271973 65.37547302246094 Z M 30.49892616271973 65.37547302246094" fill="#788198" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_gnh1wz =
    '<svg viewBox="9.4 0.0 1.4 4.1" ><path transform="translate(-209.27, 0.0)" d="M 219.3554992675781 4.125022888183594 C 218.9759979248047 4.125022888183594 218.6679992675781 3.817022323608398 218.6679992675781 3.437519073486328 L 218.6679992675781 0.6875038146972656 C 218.6679992675781 0.308000385761261 218.9759979248047 0 219.3554992675781 0 C 219.7349853515625 0 220.0429992675781 0.3080004155635834 220.0429992675781 0.6875038146972656 L 220.0429992675781 3.437519073486328 C 220.0429992675781 3.817022323608398 219.7349853515625 4.125022888183594 219.3554992675781 4.125022888183594 Z M 219.3554992675781 4.125022888183594" fill="#788198" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_yo =
    '<svg viewBox="204.8 553.0 24.5 21.9" ><path transform="translate(-476.25, 1668.0)" d="M 692.1575927734375 -1093.558471679688 C 691.1810913085938 -1094.411743164062 690.2514038085938 -1095.20458984375 689.4306030273438 -1095.903076171875 L 689.42431640625 -1095.908447265625 C 687.0006103515625 -1097.974853515625 684.904541015625 -1099.760375976562 683.4375 -1101.53076171875 C 681.7742919921875 -1103.537719726562 681.0003051757812 -1105.445678710938 681.0003051757812 -1107.537353515625 C 681.0003051757812 -1109.572265625 681.6996459960938 -1111.451416015625 682.9703979492188 -1112.830200195312 C 684.2601318359375 -1114.228881835938 686.0303955078125 -1115.000122070312 687.95458984375 -1115.000122070312 C 689.3964233398438 -1115.000122070312 690.7167358398438 -1114.544677734375 691.8786010742188 -1113.645629882812 C 692.3763427734375 -1113.260375976562 692.8370971679688 -1112.799682617188 693.250244140625 -1112.272216796875 C 693.663330078125 -1112.799682617188 694.1241455078125 -1113.261352539062 694.621826171875 -1113.645629882812 C 695.78369140625 -1114.544677734375 697.10400390625 -1115.000122070312 698.5458374023438 -1115.000122070312 C 700.4700317382812 -1115.000122070312 702.2394409179688 -1114.228881835938 703.530029296875 -1112.830200195312 C 704.8008422851562 -1111.452270507812 705.5001220703125 -1109.572265625 705.5001220703125 -1107.537353515625 C 705.5001220703125 -1105.445678710938 704.7252197265625 -1103.536865234375 703.06201171875 -1101.53076171875 C 701.595947265625 -1099.761352539062 699.500732421875 -1097.975708007812 697.0743408203125 -1095.907470703125 C 696.2966918945312 -1095.2451171875 695.3292236328125 -1094.420776367188 694.3419189453125 -1093.5576171875 C 694.0404052734375 -1093.29296875 693.6525268554688 -1093.147216796875 693.250244140625 -1093.147216796875 C 692.847900390625 -1093.147216796875 692.4600219726562 -1093.29296875 692.1575927734375 -1093.558471679688 Z M 684.3707885742188 -1111.537841796875 C 683.4258422851562 -1110.5126953125 682.9056396484375 -1109.091674804688 682.9056396484375 -1107.537353515625 C 682.9056396484375 -1105.89208984375 683.5220947265625 -1104.415283203125 684.9053955078125 -1102.74658203125 C 686.2662353515625 -1101.104125976562 688.3029174804688 -1099.368041992188 690.6618041992188 -1097.358276367188 L 690.6654052734375 -1097.355590820312 C 691.447509765625 -1096.688720703125 692.3268432617188 -1095.939086914062 693.2484130859375 -1095.135375976562 C 694.1951904296875 -1095.958862304688 695.1015014648438 -1096.731079101562 695.8377075195312 -1097.357421875 L 695.843994140625 -1097.36279296875 C 698.2001953125 -1099.37158203125 700.235107421875 -1101.10595703125 701.5950317382812 -1102.74658203125 C 702.9774169921875 -1104.415283203125 703.5939331054688 -1105.89306640625 703.5939331054688 -1107.537353515625 C 703.5939331054688 -1109.091674804688 703.07373046875 -1110.5126953125 702.1287231445312 -1111.537841796875 C 701.2034912109375 -1112.541381835938 699.930908203125 -1113.093872070312 698.5458374023438 -1113.093872070312 C 697.5350952148438 -1113.093872070312 696.6072387695312 -1112.772583007812 695.7872924804688 -1112.13818359375 C 695.0475463867188 -1111.566650390625 694.5309448242188 -1110.839477539062 694.2267456054688 -1110.330932617188 C 694.0197143554688 -1109.983520507812 693.654296875 -1109.775634765625 693.250244140625 -1109.775634765625 C 692.8461303710938 -1109.775634765625 692.480712890625 -1109.983520507812 692.2728271484375 -1110.330932617188 C 691.9695434570312 -1110.839477539062 691.4529418945312 -1111.565673828125 690.7122192382812 -1112.13818359375 C 689.892333984375 -1112.772583007812 688.9644165039062 -1113.093872070312 687.95458984375 -1113.093872070312 C 686.568603515625 -1113.093872070312 685.2960205078125 -1112.541381835938 684.3707885742188 -1111.537841796875 Z" fill="#788198" stroke="none" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lxodx6 =
    '<svg viewBox="251.0 208.0 26.2 23.1" ><path transform="translate(251.0, 207.97)" d="M 2.384999990463257 23.05170059204102 C 1.070100069046021 23.05170059204102 0 21.98159980773926 0 20.66670036315918 L 0 3.908699989318848 C 0 3.433500051498413 0.3861000239849091 3.047399997711182 0.861299991607666 3.047399997711182 L 7.668000221252441 3.047399997711182 L 7.668000221252441 2.384999990463257 C 7.668000221252441 1.070100069046021 8.738100051879883 0 10.05300045013428 0 L 16.14690017700195 0 C 17.46179962158203 0 18.53190040588379 1.070100069046021 18.53190040588379 2.384999990463257 L 18.53190040588379 3.047399997711182 L 25.34670066833496 3.047399997711182 C 25.84080123901367 3.050100088119507 26.16839981079102 3.383100032806396 26.19990158081055 3.915899991989136 L 26.19990158081055 3.922200202941895 L 26.19990158081055 20.66670036315918 C 26.19990158081055 21.98159980773926 25.12980079650879 23.05170059204102 23.81490135192871 23.05170059204102 L 2.384999990463257 23.05170059204102 Z M 1.72350001335144 20.66670036315918 C 1.72350001335144 21.03120040893555 2.02049994468689 21.32820129394531 2.384999990463257 21.32820129394531 L 23.81490135192871 21.32820129394531 C 24.17940139770508 21.32820129394531 24.47640037536621 21.03120040893555 24.47640037536621 20.66670036315918 L 24.47640037536621 9.218700408935547 L 23.45580101013184 12.2805004119873 C 23.13090133666992 13.25520038604736 22.22190093994141 13.91130065917969 21.19320106506348 13.91130065917969 L 17.00819969177246 13.91130065917969 L 17.00819969177246 14.5728006362915 C 17.00819969177246 15.04800033569336 16.62210083007812 15.43410015106201 16.14690017700195 15.43410015106201 L 10.05300045013428 15.43410015106201 C 9.577799797058105 15.43410015106201 9.191699981689453 15.04800033569336 9.191699981689453 14.5728006362915 L 9.191699981689453 13.91130065917969 L 5.006700038909912 13.91130065917969 C 3.978000164031982 13.91130065917969 3.069000005722046 13.25520038604736 2.744100093841553 12.2805004119873 L 1.72350001335144 9.218700408935547 L 1.72350001335144 20.66670036315918 Z M 10.91520023345947 13.71059989929199 L 15.28470039367676 13.71059989929199 L 15.28470039367676 12.38759994506836 L 10.91520023345947 12.38759994506836 L 10.91520023345947 13.71059989929199 Z M 16.14690017700195 10.66410064697266 C 16.62210083007812 10.66410064697266 17.00819969177246 11.051100730896 17.00819969177246 11.52630043029785 L 17.00819969177246 12.18780040740967 L 21.19320106506348 12.18780040740967 C 21.47850036621094 12.18780040740967 21.73050117492676 12.00600051879883 21.8213996887207 11.73510074615479 L 24.14249992370605 4.769999980926514 L 2.057399988174438 4.769999980926514 L 4.379400253295898 11.73510074615479 C 4.469399929046631 12.00600051879883 4.721400260925293 12.18780040740967 5.006700038909912 12.18780040740967 L 9.191699981689453 12.18780040740967 L 9.191699981689453 11.52630043029785 C 9.191699981689453 11.051100730896 9.577799797058105 10.66410064697266 10.05300045013428 10.66410064697266 L 16.14690017700195 10.66410064697266 Z M 9.391500473022461 2.384999990463257 L 9.391500473022461 3.047399997711182 L 16.80840110778809 3.047399997711182 L 16.80840110778809 2.384999990463257 C 16.80840110778809 2.02049994468689 16.51140022277832 1.72350001335144 16.14690017700195 1.72350001335144 L 10.05300045013428 1.72350001335144 C 9.68850040435791 1.72350001335144 9.391500473022461 2.02049994468689 9.391500473022461 2.384999990463257 Z" fill="#788198" stroke="none" stroke-width="0.20000000298023224" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_b9ek72 =
    '<svg viewBox="-3.9 0.0 19.6 25.6" ><path transform="translate(0.0, 0.0)" d="M 8.949978828430176 0.1795860379934311 L 8.944169998168945 0.1735946387052536 C 8.834506988525391 0.06066527962684631 8.683451652526855 -0.002516766544431448 8.526040077209473 -0.0007012947462499142 C 8.504616737365723 -0.001609088270924985 8.483011245727539 0.0002064988948404789 8.462313652038574 0.005290115717798471 L -0.9011886715888977 0.005290115717798471 C -2.568982124328613 0.005834802053868771 -3.920681715011597 1.357719659805298 -3.921592950820923 3.025694131851196 L -3.921592950820923 22.5420970916748 C -3.920685052871704 24.20989036560059 -2.568982124328613 25.56159210205078 -0.9011886715888977 25.56250190734863 L 12.6790189743042 25.56250190734863 C 14.3469934463501 25.56159400939941 15.69888019561768 24.20989036560059 15.69942474365234 22.5420970916748 L 15.69942474365234 7.155393123626709 C 15.69833469390869 7.001431465148926 15.63805675506592 6.853824615478516 15.53111934661865 6.743074417114258 L 8.949978828430176 0.1795860379934311 Z M 9.106845855712891 1.974290251731873 L 13.7304105758667 6.586053371429443 L 10.96545600891113 6.586053371429443 C 9.940197944641113 6.583148002624512 9.109749794006348 5.752699851989746 9.106843948364258 4.72744083404541 L 9.106845855712891 1.974290251731873 Z M 12.67900466918945 24.38911628723145 L -0.9012027382850647 24.38911628723145 C -1.926643848419189 24.38621139526367 -2.756729364395142 23.55576515197754 -2.759996652603149 22.53032302856445 L -2.759996652603149 3.013920545578003 C -2.756728649139404 1.988841772079468 -1.926643848419189 1.158393859863281 -0.9012027382850647 1.155126571655273 L 7.9450364112854 1.155126571655273 L 7.9450364112854 4.72746753692627 C 7.945943832397461 6.395260810852051 9.29782772064209 7.747146606445312 10.96543979644775 7.747871398925781 L 14.53778171539307 7.747871398925781 L 14.53778171539307 22.53035163879395 C 14.53687477111816 23.55669784545898 13.70533561706543 24.38823699951172 12.67898845672607 24.38914489746094 Z M 12.67900466918945 24.38911628723145" fill="#788198" stroke="#788198" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_iqp42 =
    '<svg viewBox="-0.3 15.0 8.4 1.2" ><path transform="translate(-73.4, -308.04)" d="M 73.63957977294922 324.2164306640625 L 80.87703704833984 324.2164306640625 C 81.19766998291016 324.2164306640625 81.45784759521484 323.9564514160156 81.45784759521484 323.6355895996094 C 81.45784759521484 323.3148193359375 81.19766998291016 323.0548095703125 80.87703704833984 323.0548095703125 L 73.63957977294922 323.0548095703125 C 73.31877136230469 323.0548095703125 73.05859375 323.3148193359375 73.05859375 323.6355895996094 C 73.05859375 323.9564514160156 73.31877136230469 324.2164306640625 73.63957977294922 324.2164306640625 Z M 73.63957977294922 324.2164306640625" fill="#788198" stroke="#788198" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_kuvw4s =
    '<svg viewBox="-0.3 19.4 12.5 1.2" ><path transform="translate(-73.4, -398.24)" d="M 84.9432373046875 417.656005859375 L 73.63999176025391 417.656005859375 C 73.31918334960938 417.656005859375 73.05900573730469 417.916015625 73.05900573730469 418.23681640625 C 73.05900573730469 418.5576171875 73.31918334960938 418.817626953125 73.63999176025391 418.817626953125 L 84.9432373046875 418.817626953125 C 85.26387023925781 418.817626953125 85.52423095703125 418.5576171875 85.52423095703125 418.23681640625 C 85.52423095703125 417.916015625 85.26387023925781 417.656005859375 84.9432373046875 417.656005859375 Z M 84.9432373046875 417.656005859375" fill="#788198" stroke="#788198" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_b2w46j =
    '<svg viewBox="0.4 4.1 4.3 4.3" ><path transform="translate(-89.25, -83.3)" d="M 91.81536865234375 91.61930847167969 C 92.99259185791016 91.61930847167969 93.94705200195312 90.6646728515625 93.94705200195312 89.48764038085938 C 93.94705200195312 88.31022644042969 92.99259185791016 87.35560607910156 91.81536865234375 87.35560607910156 C 90.63796997070312 87.35560607910156 89.68370056152344 88.31022644042969 89.68370056152344 89.48764038085938 C 89.68424224853516 90.66450500488281 90.63814544677734 91.618408203125 91.81536865234375 91.61930847167969 Z M 91.81536865234375 88.52320861816406 C 92.35096740722656 88.52320861816406 92.78526306152344 88.95748901367188 92.78526306152344 89.49327087402344 C 92.78526306152344 90.02886962890625 92.35097503662109 90.46315002441406 91.81536865234375 90.46315002441406 C 91.27960205078125 90.46315002441406 90.84531402587891 90.02886962890625 90.84531402587891 89.49327087402344 C 90.84621429443359 88.95803833007812 91.28014373779297 88.52410888671875 91.81536865234375 88.52320861816406 Z M 91.81536865234375 88.52320861816406" fill="#788198" stroke="#788198" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_h67t4d =
    '<svg viewBox="-0.3 8.7 5.8 3.9" ><path transform="translate(-73.4, -178.75)" d="M 73.63957977294922 191.4103088378906 C 73.95984649658203 191.4094085693359 74.21947479248047 191.1497802734375 74.22038269042969 190.8295135498047 L 74.22038269042969 190.3647155761719 C 74.22038269042969 189.4022827148438 75.00035858154297 188.6221160888672 75.96298217773438 188.6221160888672 C 76.92523956298828 188.6221160888672 77.70539093017578 189.4022827148438 77.70539093017578 190.3647155761719 L 77.70539093017578 190.8295135498047 C 77.70539093017578 191.1503295898438 77.96556091308594 191.4103088378906 78.28638458251953 191.4103088378906 C 78.60719299316406 191.4103088378906 78.8671875 191.1503295898438 78.8671875 190.8295135498047 L 78.8671875 190.3647155761719 C 78.8671875 188.7608337402344 77.56686401367188 187.4605102539062 75.96298217773438 187.4605102539062 C 74.35909271240234 187.4605102539062 73.05859375 188.7608337402344 73.05859375 190.3647155761719 L 73.05859375 190.8295135498047 C 73.05950164794922 191.1497802734375 73.31912231445312 191.4094085693359 73.63957977294922 191.4103088378906 Z M 73.63957977294922 191.4103088378906" fill="#788198" stroke="#788198" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_sp9wh5 =
    '<svg viewBox="0.0 0.0 19.1 23.7" ><path transform="translate(3.96, 0.75)" d="M 5.579109668731689 -0.75 C 9.068992614746094 -0.75 11.90821933746338 2.089225769042969 11.90821933746338 5.579109668731689 C 11.90821933746338 9.068992614746094 9.068992614746094 11.90821933746338 5.579109668731689 11.90821933746338 C 2.089225769042969 11.90821933746338 -0.75 9.068992614746094 -0.75 5.579109668731689 C -0.75 2.089225769042969 2.089225769042969 -0.75 5.579109668731689 -0.75 Z M 5.579109668731689 10.19084167480469 C 8.122031211853027 10.19084167480469 10.19084167480469 8.122031211853027 10.19084167480469 5.579109668731689 C 10.19084167480469 3.036188125610352 8.122031211853027 0.9673777222633362 5.579109668731689 0.9673777222633362 C 3.036188125610352 0.9673777222633362 0.9673777222633362 3.036188125610352 0.9673777222633362 5.579109668731689 C 0.9673777222633362 8.122031211853027 3.036188125610352 10.19084167480469 5.579109668731689 10.19084167480469 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(0.75, 2.66)" d="M 8.793102264404297 21.06502342224121 C 8.257845878601074 21.06502342224121 7.715433597564697 21.0506477355957 7.180533885955811 21.02229309082031 C 6.858792304992676 21.02225685119629 6.526326179504395 21.02069473266602 6.160334587097168 20.95373344421387 C 5.241678237915039 20.88898468017578 4.320933818817139 20.75439262390137 3.422356128692627 20.5534782409668 C 1.43290650844574 20.16352081298828 0.1428881287574768 19.38643074035645 -0.4121697843074799 18.24367141723633 C -0.4133605062961578 18.24122047424316 -0.4145398139953613 18.23876953125 -0.4156962037086487 18.23631858825684 C -0.6350625157356262 17.7735424041748 -0.750665009021759 17.25821304321289 -0.7500008940696716 16.74605941772461 C -0.7519129514694214 16.23862075805664 -0.6354861855506897 15.72443580627441 -0.4133147299289703 15.26344680786133 C -0.4115057587623596 15.259690284729 -0.4096624553203583 15.25594711303711 -0.4077962338924408 15.25222778320312 C 0.3320372998714447 13.77260494232178 2.301319599151611 13.16916847229004 3.411918163299561 12.9409236907959 C 4.329694747924805 12.7452507019043 5.268783092498779 12.61308002471924 6.203473567962646 12.54804515838623 C 7.056965827941895 12.47326755523682 7.924050807952881 12.4353494644165 8.780747413635254 12.4353494644165 C 9.637443542480469 12.4353494644165 10.5045223236084 12.4732666015625 11.3580150604248 12.54804420471191 C 12.29287052154541 12.61389636993408 13.2317008972168 12.74599838256836 14.14841842651367 12.940673828125 C 16.14916610717773 13.35152435302734 17.43706703186035 14.13420391082764 17.97656059265137 15.26705360412598 C 18.42549514770508 16.2111644744873 18.42549514770508 17.29359436035156 17.97676658630371 18.23725891113281 C 17.43252372741699 19.38010406494141 16.14519882202148 20.15916633605957 14.14998912811279 20.55339050292969 C 13.2330379486084 20.75681304931641 12.29324913024902 20.89252853393555 11.35648918151855 20.95682716369629 C 10.5077018737793 21.02862739562988 9.645323753356934 21.06502342224121 8.793102264404297 21.06502342224121 Z M 1.134333610534668 17.49684143066406 C 1.435081839561462 18.11062812805176 2.368274927139282 18.59823799133301 3.76280951499939 18.87014389038086 C 3.770698070526123 18.87169075012207 3.778563737869263 18.87332916259766 3.786395072937012 18.87509155273438 C 4.620525360107422 19.06216049194336 5.475893974304199 19.18624687194824 6.328743457794189 19.24390411376953 C 6.365931034088135 19.24641036987305 6.402923107147217 19.25134658813477 6.439468860626221 19.25867462158203 C 6.670375823974609 19.30491828918457 6.917449474334717 19.30491828918457 7.203530311584473 19.30491828918457 C 7.218917846679688 19.30491828918457 7.234294414520264 19.30532836914062 7.249659538269043 19.30615234375 C 7.761460304260254 19.33368873596191 8.28075122833252 19.3476448059082 8.793102264404297 19.3476448059082 C 9.599329948425293 19.3476448059082 10.41521072387695 19.3131160736084 11.21808528900146 19.24501609802246 C 11.2227897644043 19.24461364746094 11.22749614715576 19.24425888061523 11.23220157623291 19.24393844604492 C 12.0889778137207 19.18548011779785 12.94857215881348 19.0612678527832 13.78709888458252 18.87475776672363 C 13.79399108886719 18.87322425842285 13.80090618133545 18.87178230285645 13.80784511566162 18.87041854858398 C 15.20608711242676 18.59544372558594 16.13591003417969 18.10850143432617 16.42602157592773 17.49930191040039 C 16.65166091918945 17.02478981018066 16.65166091918945 16.47996711730957 16.42581558227539 16.0050106048584 C 16.13447952270508 15.3932466506958 15.22675323486328 14.91504764556885 13.80096435546875 14.62254524230957 C 13.79898357391357 14.62213230133057 13.7969913482666 14.62171936035156 13.79501056671143 14.62129688262939 C 12.95255661010742 14.44223117828369 12.0897798538208 14.32091617584229 11.23064422607422 14.26071548461914 C 11.22558403015137 14.2603588104248 11.22053623199463 14.25995922088623 11.21548557281494 14.25951290130615 C 10.40924644470215 14.18865299224854 9.590090751647949 14.15272808074951 8.780747413635254 14.15272808074951 C 7.971404075622559 14.15272808074951 7.152249336242676 14.18865299224854 6.346008777618408 14.25951290130615 C 6.340708255767822 14.25998210906982 6.335407257080078 14.26039505004883 6.330094814300537 14.26076030731201 C 5.47206974029541 14.32011413574219 4.609786033630371 14.44137096405029 3.767194986343384 14.62115859985352 C 3.764985084533691 14.6216287612915 3.762775421142578 14.62208652496338 3.760565757751465 14.62254524230957 C 2.415824174880981 14.89841556549072 1.433732390403748 15.41854858398438 1.131093621253967 16.0146369934082 C 1.023031115531921 16.24102783203125 0.9664342999458313 16.49308586120605 0.9673653841018677 16.74395179748535 C 0.9670466184616089 17.00542640686035 1.024766564369202 17.26420402526855 1.134333610534668 17.49684143066406 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_qxvlj =
    '<svg viewBox="932.3 3494.0 19.0 23.7" ><path transform="translate(932.35, 3494.0)" d="M 6.93797779083252 16.07400894165039 C 8.645845413208008 15.93639945983887 10.3615665435791 15.93639945983887 12.0694465637207 16.07400894165039 C 12.99949932098389 16.12822341918945 13.92504405975342 16.24459838867188 14.84038639068604 16.42230606079102 C 16.82113647460938 16.82339096069336 18.11431312561035 17.47774696350098 18.66842842102051 18.5331916809082 C 19.08469772338867 19.35683441162109 19.08469772338867 20.33742332458496 18.66842842102051 21.16118431091309 C 18.11431312561035 22.21662712097168 16.87250328063965 22.9130973815918 14.81986331939697 23.27194976806641 C 13.90523147583008 23.45641899108887 12.97945117950439 23.57635307312012 12.04892444610596 23.63080406188965 C 11.18682289123535 23.72582626342773 10.32474327087402 23.72582626342773 9.452392578125 23.72582626342773 L 7.882170677185059 23.72582626342773 C 7.553757190704346 23.68359184265137 7.235605716705322 23.66247749328613 6.92771577835083 23.66247749328613 C 5.997153282165527 23.61466979980469 5.071122169494629 23.4982967376709 4.156728744506836 23.31418228149414 C 2.175990343093872 22.9342155456543 0.882865309715271 22.25873947143555 0.328667938709259 21.20341491699219 C 0.1147276610136032 20.79449844360352 0.001938494737260044 20.33777809143066 0.0001236328826053068 19.87358283996582 C -0.004204584285616875 19.40641975402832 0.1051736176013947 18.94566535949707 0.3184053301811218 18.5331916809082 C 0.8623388409614563 17.47774696350098 2.155467510223389 16.79171752929688 4.156728744506836 16.42230606079102 C 5.075144290924072 16.24210739135742 6.004342079162598 16.125732421875 6.93797779083252 16.07400894165039 Z M 9.493451118469238 -1.16350993509956e-13 C 12.9338960647583 -1.16350993509956e-13 15.72298622131348 2.868238925933838 15.72298622131348 6.406400203704834 C 15.72298622131348 9.944549560546875 12.9338960647583 12.81277751922607 9.493451118469238 12.81277751922607 C 6.052944183349609 12.81277751922607 3.263855457305908 9.944549560546875 3.263855457305908 6.406400203704834 C 3.263855457305908 2.868238925933838 6.052944183349609 -1.16350993509956e-13 9.493451118469238 -1.16350993509956e-13 Z" fill="#788198" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_w2a8p =
    '<svg viewBox="818.4 3557.4 22.7 23.8" ><path transform="translate(819.12, 3558.12)" d="M 6.006711483001709 23.07560920715332 L 5.996971607208252 23.07557678222656 L 5.996971607208252 23.07558059692383 L 3.858051538467407 23.07558059692383 C 1.317161440849304 23.07558059692383 -0.7499985694885254 21.02082061767578 -0.7499985694885254 18.49518013000488 L -0.7497885227203369 8.762849807739258 C -0.7248212099075317 7.701093196868896 -0.2272096574306488 6.719107151031494 0.6157391667366028 6.067429065704346 L 7.877941608428955 0.2538684904575348 C 8.639638900756836 -0.393562525510788 9.610461235046387 -0.7500002384185791 10.61305141448975 -0.7500002384185791 C 11.5640811920166 -0.7500002384185791 12.49705123901367 -0.4248902499675751 13.24011135101318 0.1654297560453415 L 20.68891143798828 6.079909801483154 C 21.49626159667969 6.750289916992188 21.95930099487305 7.734609603881836 21.95930099487305 8.780479431152344 L 21.95930099487305 18.50511932373047 C 21.95930099487305 19.71143913269043 21.46621131896973 20.89160919189453 20.60647201538086 21.74300003051758 C 19.73870086669922 22.60234069824219 18.58610153198242 23.07559013366699 17.36098098754883 23.07559013366699 L 15.15690135955811 23.07555961608887 C 13.99116134643555 23.0671501159668 13.04291152954102 22.11631965637207 13.04308128356934 20.95602035522461 L 13.04308128356934 17.54254913330078 C 13.04308128356934 17.08613014221191 12.66659164428711 16.71479988098145 12.20383167266846 16.71479988098145 L 8.995471000671387 16.71479988098145 C 8.540341377258301 16.71765899658203 8.166251182556152 17.0889892578125 8.166261672973633 17.54253005981445 L 8.166261672973633 21.7160701751709 L 7.986644268035889 21.7160701751709 C 7.879605770111084 21.99564743041992 7.713686943054199 22.25265312194824 7.498111248016357 22.46508026123047 C 7.098781585693359 22.85874938964844 6.56908130645752 23.07560920715332 6.006711483001709 23.07560920715332 Z M 0.7500014305114746 8.789914131164551 L 0.7500014305114746 18.49518013000488 C 0.7500014305114746 20.1937198638916 2.144271373748779 21.57558059692383 3.858051538467407 21.57558059692383 L 6.006711483001709 21.57560920715332 C 6.17246150970459 21.57560920715332 6.328171253204346 21.51210021972656 6.44516134262085 21.39677047729492 C 6.56200122833252 21.28162956237793 6.626281261444092 21.12871932983398 6.626281261444092 20.96608924865723 L 6.626261234283447 20.2160701751709 L 6.666261672973633 20.2160701751709 L 6.666261672973633 17.54254913330078 C 6.666231632232666 16.26705932617188 7.709001541137695 15.22283935546875 8.990781784057617 15.21480941772461 L 12.20383167266846 15.21479988098145 C 13.49370098114014 15.21479988098145 14.54308128356934 16.25901985168457 14.54308128356934 17.54254913330078 L 14.54308128356934 20.95612907409668 C 14.54303169250488 21.29454612731934 14.82204818725586 21.57192230224609 15.16551685333252 21.57558059692383 L 17.36098098754883 21.57559013366699 C 18.18820190429688 21.57559013366699 18.96596145629883 21.25652885437012 19.55099105834961 20.67717933654785 C 20.13672065734863 20.09713935852051 20.45930099487305 19.32575035095215 20.45930099487305 18.50511932373047 L 20.45930099487305 8.780479431152344 C 20.45930099487305 8.184530258178711 20.19583892822266 7.622949123382568 19.73623085021973 7.238582611083984 L 12.30722141265869 1.340039730072021 C 11.82822132110596 0.9594997763633728 11.22661113739014 0.7499997615814209 10.61305141448975 0.7499997615814209 C 9.963431358337402 0.7499997615814209 9.334901809692383 0.981569766998291 8.843241691589355 1.402049779891968 L 8.824491500854492 1.417559742927551 L 1.536851406097412 7.251299858093262 C 1.053185939788818 7.623510837554932 0.7667160034179688 8.183956146240234 0.7500014305114746 8.789914131164551 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_fapjk =
    '<svg viewBox="38.5 -0.5 27.5 24.0" ><path transform="translate(-463.5, 1753.5)" d="M 512.127197265625 -1730.591186523438 C 511.3263854980469 -1731.37646484375 511.3263854980469 -1732.655395507812 512.127197265625 -1733.440795898438 L 515.3113403320312 -1736.5673828125 C 515.554931640625 -1736.806518554688 515.8802490234375 -1736.9384765625 516.2260131835938 -1736.9384765625 C 516.2543334960938 -1736.9384765625 516.2817993164062 -1736.937744140625 516.3101196289062 -1736.935302734375 L 516.7313232421875 -1737.348754882812 C 516.1372680664062 -1738.29541015625 515.7946166992188 -1739.366088867188 515.72705078125 -1740.483154296875 L 510.0628051757812 -1740.483154296875 L 510.0628051757812 -1739.528930664062 C 510.0628051757812 -1738.4951171875 509.2062377929688 -1737.654296875 508.1532287597656 -1737.654296875 C 507.1010131835938 -1737.654296875 506.2444763183594 -1738.4951171875 506.2444763183594 -1739.528930664062 L 506.2444763183594 -1740.542602539062 C 505.2700500488281 -1740.690673828125 504.3749694824219 -1741.113403320312 503.6543884277344 -1741.756713867188 L 503.6543884277344 -1735.170288085938 C 503.6543884277344 -1734.364868164062 504.3215637207031 -1733.709228515625 505.1427307128906 -1733.709228515625 L 510.7928161621094 -1733.709228515625 C 511.2485961914062 -1733.709228515625 511.6195068359375 -1733.345092773438 511.6195068359375 -1732.89697265625 C 511.6195068359375 -1732.449584960938 511.2485961914062 -1732.08544921875 510.7928161621094 -1732.08544921875 L 505.1427307128906 -1732.08544921875 C 503.4100036621094 -1732.08544921875 502.0002136230469 -1733.46923828125 502.0002136230469 -1735.170288085938 L 502.0002136230469 -1746.994750976562 C 502.0002136230469 -1748.696533203125 503.4100036621094 -1750.08056640625 505.1427307128906 -1750.08056640625 L 509.4530029296875 -1750.08056640625 L 509.4530029296875 -1750.986938476562 C 509.4530029296875 -1752.648559570312 510.8297729492188 -1754.000122070312 512.5223999023438 -1754.000122070312 L 516.967041015625 -1754.000122070312 C 518.6597290039062 -1754.000122070312 520.0364990234375 -1752.648559570312 520.0364990234375 -1750.986938476562 L 520.0364990234375 -1750.08056640625 L 524.3467407226562 -1750.08056640625 C 526.0794677734375 -1750.08056640625 527.4892578125 -1748.696533203125 527.4892578125 -1746.994750976562 L 527.4892578125 -1745.7041015625 C 527.4947509765625 -1745.69873046875 527.500244140625 -1745.693359375 527.5057373046875 -1745.687866210938 C 528.8118286132812 -1744.406616210938 529.5308227539062 -1742.703369140625 529.5308227539062 -1740.892822265625 C 529.5308227539062 -1739.0830078125 528.8118286132812 -1737.380493164062 527.5057373046875 -1736.098388671875 C 527.500244140625 -1736.092895507812 527.4947509765625 -1736.087524414062 527.4892578125 -1736.082153320312 L 527.4892578125 -1735.170288085938 C 527.4892578125 -1733.46923828125 526.0794677734375 -1732.08544921875 524.3467407226562 -1732.08544921875 L 518.1788330078125 -1732.08544921875 C 517.732421875 -1732.08544921875 517.3670654296875 -1732.434936523438 517.3521728515625 -1732.869995117188 L 515.0308227539062 -1730.591186523438 C 514.6426391601562 -1730.2099609375 514.1270751953125 -1730.000244140625 513.5785522460938 -1730.000244140625 C 513.0308227539062 -1730.000244140625 512.5153198242188 -1730.2099609375 512.127197265625 -1730.591186523438 Z M 513.2964477539062 -1732.29296875 C 513.22021484375 -1732.218139648438 513.1793212890625 -1732.122436523438 513.1793212890625 -1732.015991210938 C 513.1793212890625 -1731.909545898438 513.22021484375 -1731.813842773438 513.2964477539062 -1731.739013671875 C 513.3718872070312 -1731.664916992188 513.4724731445312 -1731.6240234375 513.5785522460938 -1731.6240234375 C 513.6854858398438 -1731.6240234375 513.7852172851562 -1731.664916992188 513.8607177734375 -1731.739013671875 L 515.7584228515625 -1733.601196289062 L 515.1934204101562 -1734.155151367188 L 513.2964477539062 -1732.29296875 Z M 518.590576171875 -1734.697387695312 C 518.6141357421875 -1734.33642578125 518.4805297851562 -1733.977661132812 518.2149658203125 -1733.716918945312 L 518.2070922851562 -1733.709228515625 L 524.3467407226562 -1733.709228515625 C 525.064208984375 -1733.709228515625 525.6653442382812 -1734.209838867188 525.804443359375 -1734.874877929688 C 524.826904296875 -1734.375854492188 523.7416381835938 -1734.11572265625 522.6218872070312 -1734.11572265625 C 521.3362426757812 -1734.11572265625 520.0953979492188 -1734.459106445312 519.0125732421875 -1735.111694335938 L 518.590576171875 -1734.697387695312 Z M 518.9072875976562 -1744.540161132812 C 517.9147338867188 -1743.565795898438 517.3685913085938 -1742.2705078125 517.3685913085938 -1740.8935546875 C 517.3685913085938 -1739.515747070312 517.9147338867188 -1738.220581054688 518.9072875976562 -1737.2470703125 C 519.9005737304688 -1736.27197265625 521.2191772460938 -1735.734985351562 522.6218872070312 -1735.734985351562 C 524.0238037109375 -1735.734985351562 525.3432006835938 -1736.27197265625 526.33642578125 -1737.2470703125 C 527.3297119140625 -1738.221313476562 527.8766479492188 -1739.5166015625 527.8766479492188 -1740.8935546875 C 527.8766479492188 -1742.269775390625 527.3297119140625 -1743.56494140625 526.33642578125 -1744.540161132812 C 525.3432006835938 -1745.514404296875 524.0245361328125 -1746.05126953125 522.6218872070312 -1746.05126953125 C 521.2191772460938 -1746.05126953125 519.9005737304688 -1745.514404296875 518.9072875976562 -1744.540161132812 Z M 508.1532287597656 -1739.278198242188 C 508.2884216308594 -1739.278198242188 508.3992004394531 -1739.381591796875 508.4078369140625 -1739.511962890625 L 507.8986206054688 -1739.511962890625 C 507.9080810546875 -1739.381591796875 508.0188598632812 -1739.278198242188 508.1532287597656 -1739.278198242188 Z M 507.8986206054688 -1741.99755859375 L 507.8986206054688 -1741.135009765625 L 508.4086303710938 -1741.135009765625 L 508.4086303710938 -1741.99755859375 C 508.4086303710938 -1742.135620117188 508.2938842773438 -1742.247436523438 508.1532287597656 -1742.247436523438 C 508.0125732421875 -1742.247436523438 507.8986206054688 -1742.135620117188 507.8986206054688 -1741.99755859375 Z M 510.0596618652344 -1742.107055664062 L 515.824462890625 -1742.107055664062 C 516.072021484375 -1743.465454101562 516.7289428710938 -1744.697509765625 517.7379760742188 -1745.687866210938 C 519.0424194335938 -1746.96923828125 520.775146484375 -1747.67431640625 522.6163330078125 -1747.67431640625 C 523.7518920898438 -1747.67431640625 524.8504638671875 -1747.408325195312 525.8350830078125 -1746.898315429688 L 525.8350830078125 -1746.994750976562 C 525.8350830078125 -1747.800903320312 525.1679077148438 -1748.45654296875 524.3467407226562 -1748.45654296875 L 505.1427307128906 -1748.45654296875 C 504.3215637207031 -1748.45654296875 503.6543884277344 -1747.800903320312 503.6543884277344 -1746.994750976562 L 503.6543884277344 -1745.4140625 C 503.6543884277344 -1743.875122070312 504.7639770507812 -1742.541381835938 506.2546691894531 -1742.194946289062 C 506.3560485839844 -1743.136108398438 507.1686096191406 -1743.871215820312 508.1532287597656 -1743.871215820312 C 509.1685180664062 -1743.871215820312 510.0014953613281 -1743.08984375 510.0596618652344 -1742.107055664062 Z M 511.1071472167969 -1750.986938476562 L 511.1071472167969 -1750.08056640625 L 518.38232421875 -1750.08056640625 L 518.38232421875 -1750.986938476562 C 518.38232421875 -1751.7529296875 517.7473754882812 -1752.376220703125 516.967041015625 -1752.376220703125 L 512.5223999023438 -1752.376220703125 C 511.7421264648438 -1752.376220703125 511.1071472167969 -1751.7529296875 511.1071472167969 -1750.986938476562 Z" fill="#788197" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_yp3jey =
    '<svg viewBox="13.5 9.1 10.5 14.9" ><path  d="M 14 9.090000152587891 L 22.81000137329102 10.84000015258789 C 23.52000045776367 10.98999977111816 24.00000190734863 11.59000015258789 24.00000190734863 12.30000019073486 L 24.00000190734863 22.5 C 24.00000190734863 23.32999992370605 23.33000183105469 24 22.50000190734863 24 L 13.50000190734863 24 C 13.78000164031982 24 14.00000190734863 23.78000068664551 14.00000190734863 23.5 L 14.00000190734863 23 L 22.50000190734863 23 C 22.7700023651123 23 23.00000190734863 22.78000068664551 23.00000190734863 22.5 L 23.00000190734863 12.30000019073486 C 23.00000190734863 12.07000064849854 22.84000205993652 11.86000061035156 22.6100025177002 11.8100004196167 L 14.00000286102295 10.11000061035156 L 14 9.090000152587891 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_m4nvhl =
    '<svg viewBox="13.5 8.7 10.8 15.6" ><path  d="M 13.70000267028809 8.724550247192383 L 22.86845207214355 10.54574966430664 C 23.71279144287109 10.7241096496582 24.30000305175781 11.44518089294434 24.30000305175781 12.29999923706055 L 24.30000305175781 22.5 C 24.30000305175781 23.49251937866211 23.49252319335938 24.29999923706055 22.50000190734863 24.29999923706055 L 13.50000190734863 24.29999923706055 L 13.50000190734863 23.70000076293945 C 13.61402130126953 23.70000076293945 13.70000267028809 23.61402130126953 13.70000267028809 23.5 L 13.70000267028809 22.70000076293945 L 22.50000190734863 22.70000076293945 C 22.60841178894043 22.70000076293945 22.70000076293945 22.6084098815918 22.70000076293945 22.5 L 22.70000076293945 12.29999923706055 C 22.70000076293945 12.20762062072754 22.63503265380859 12.12364768981934 22.54850196838379 12.10365104675293 L 13.70000267028809 10.35655975341797 L 13.70000267028809 8.724550247192383 Z M 22.50000190734863 23.70000076293945 C 23.16168212890625 23.70000076293945 23.70000076293945 23.16168022155762 23.70000076293945 22.5 L 23.70000076293945 12.29999923706055 C 23.70000076293945 11.72258949279785 23.31742095947266 11.25382041931152 22.74799156188965 11.13352012634277 L 14.30000114440918 9.455450057983398 L 14.30000114440918 9.863439559936523 L 22.67373275756836 11.51684951782227 C 23.03661155700684 11.59573936462402 23.30000305175781 11.92510032653809 23.30000305175781 12.29999923706055 L 23.30000305175781 22.5 C 23.30000305175781 22.94112014770508 22.94112205505371 23.29999923706055 22.50000190734863 23.29999923706055 L 14.30000114440918 23.29999923706055 L 14.30000114440918 23.5 C 14.30000114440918 23.56929969787598 14.29161643981934 23.63627624511719 14.27578163146973 23.70000076293945 L 22.50000190734863 23.70000076293945 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_oazfo =
    '<svg viewBox="17.0 14.0 3.0 1.0" ><path  d="M 19.5 14 C 19.78000068664551 14 20 14.22000026702881 20 14.5 C 20 14.77999973297119 19.78000068664551 15 19.5 15 L 17.5 15 C 17.21999931335449 15 17 14.77999973297119 17 14.5 C 17 14.22000026702881 17.21999931335449 14 17.5 14 L 19.5 14 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_d5c7jl =
    '<svg viewBox="16.7 13.7 3.6 1.6" ><path  d="M 17.5 13.69999980926514 L 19.5 13.69999980926514 C 19.94860076904297 13.69999980926514 20.29999923706055 14.05140018463135 20.29999923706055 14.5 C 20.29999923706055 14.94859981536865 19.94860076904297 15.30000019073486 19.5 15.30000019073486 L 17.5 15.30000019073486 C 17.05139923095703 15.30000019073486 16.70000076293945 14.94859981536865 16.70000076293945 14.5 C 16.70000076293945 14.05140018463135 17.05139923095703 13.69999980926514 17.5 13.69999980926514 Z M 19.5 14.69999980926514 C 19.6140193939209 14.69999980926514 19.70000076293945 14.61402034759521 19.70000076293945 14.5 C 19.70000076293945 14.38597965240479 19.6140193939209 14.30000019073486 19.5 14.30000019073486 L 17.5 14.30000019073486 C 17.3859806060791 14.30000019073486 17.29999923706055 14.38597965240479 17.29999923706055 14.5 C 17.29999923706055 14.61402034759521 17.3859806060791 14.69999980926514 17.5 14.69999980926514 L 19.5 14.69999980926514 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rzph70 =
    '<svg viewBox="17.0 17.0 3.0 1.0" ><path  d="M 19.5 17 C 19.78000068664551 17 20 17.21999931335449 20 17.5 C 20 17.78000068664551 19.78000068664551 18 19.5 18 L 17.5 18 C 17.21999931335449 18 17 17.78000068664551 17 17.5 C 17 17.21999931335449 17.21999931335449 17 17.5 17 L 19.5 17 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_mzngoy =
    '<svg viewBox="16.7 16.7 3.6 1.6" ><path  d="M 17.5 16.70000076293945 L 19.5 16.70000076293945 C 19.94860076904297 16.70000076293945 20.29999923706055 17.05139923095703 20.29999923706055 17.5 C 20.29999923706055 17.94860076904297 19.94860076904297 18.29999923706055 19.5 18.29999923706055 L 17.5 18.29999923706055 C 17.05139923095703 18.29999923706055 16.70000076293945 17.94860076904297 16.70000076293945 17.5 C 16.70000076293945 17.05139923095703 17.05139923095703 16.70000076293945 17.5 16.70000076293945 Z M 19.5 17.70000076293945 C 19.6140193939209 17.70000076293945 19.70000076293945 17.6140193939209 19.70000076293945 17.5 C 19.70000076293945 17.3859806060791 19.6140193939209 17.29999923706055 19.5 17.29999923706055 L 17.5 17.29999923706055 C 17.3859806060791 17.29999923706055 17.29999923706055 17.3859806060791 17.29999923706055 17.5 C 17.29999923706055 17.6140193939209 17.3859806060791 17.70000076293945 17.5 17.70000076293945 L 19.5 17.70000076293945 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_a6teh8 =
    '<svg viewBox="17.0 20.0 3.0 1.0" ><path  d="M 19.5 20 C 19.78000068664551 20 20 20.21999931335449 20 20.5 C 20 20.78000068664551 19.78000068664551 21 19.5 21 L 17.5 21 C 17.21999931335449 21 17 20.78000068664551 17 20.5 C 17 20.21999931335449 17.21999931335449 20 17.5 20 L 19.5 20 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_adtcca =
    '<svg viewBox="16.7 19.7 3.6 1.6" ><path  d="M 17.5 19.70000076293945 L 19.5 19.70000076293945 C 19.94860076904297 19.70000076293945 20.29999923706055 20.05139923095703 20.29999923706055 20.5 C 20.29999923706055 20.94860076904297 19.94860076904297 21.29999923706055 19.5 21.29999923706055 L 17.5 21.29999923706055 C 17.05139923095703 21.29999923706055 16.70000076293945 20.94860076904297 16.70000076293945 20.5 C 16.70000076293945 20.05139923095703 17.05139923095703 19.70000076293945 17.5 19.70000076293945 Z M 19.5 20.70000076293945 C 19.6140193939209 20.70000076293945 19.70000076293945 20.6140193939209 19.70000076293945 20.5 C 19.70000076293945 20.3859806060791 19.6140193939209 20.29999923706055 19.5 20.29999923706055 L 17.5 20.29999923706055 C 17.3859806060791 20.29999923706055 17.29999923706055 20.3859806060791 17.29999923706055 20.5 C 17.29999923706055 20.6140193939209 17.3859806060791 20.70000076293945 17.5 20.70000076293945 L 19.5 20.70000076293945 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_smhoph =
    '<svg viewBox="13.0 9.0 1.0 15.0" ><path  d="M 14 23.5 C 14 23.78000068664551 13.77999973297119 24 13.5 24 C 13.22000026702881 24 13 23.78000068664551 13 23.5 L 13 23 L 13 9.5 C 13 9.350000381469727 13.06999969482422 9.210000038146973 13.18000030517578 9.109999656677246 C 13.30000019073486 9.019999504089355 13.45000076293945 8.979999542236328 13.60000038146973 9.00999927520752 L 14 9.089999198913574 L 14 10.10999870300293 L 14 23 L 14 23.5 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_fyjf27 =
    '<svg viewBox="12.7 8.7 1.6 15.6" ><path  d="M 13.5 24.29999923706055 C 13.05140018463135 24.29999923706055 12.69999980926514 23.94859886169434 12.69999980926514 23.5 L 12.69999980926514 9.5 C 12.69999980926514 9.27180004119873 12.80140018463135 9.048739433288574 12.97819995880127 8.888019561767578 L 13 8.869999885559082 C 13.14815998077393 8.758879661560059 13.32131004333496 8.700149536132812 13.5007495880127 8.700149536132812 C 13.55364036560059 8.700149536132812 13.60682964324951 8.705419540405273 13.65882968902588 8.715829849243164 L 14.30000019073486 8.844059944152832 L 14.30000019073486 23.5 C 14.30000019073486 23.94859886169434 13.94859981536865 24.29999923706055 13.5 24.29999923706055 Z M 13.37150573730469 9.34181022644043 C 13.32590198516846 9.387560844421387 13.30000019073486 9.444526672363281 13.30000019073486 9.5 L 13.30000019073486 23.5 C 13.30000019073486 23.6140193939209 13.38597965240479 23.69999885559082 13.5 23.69999885559082 C 13.61402034759521 23.69999885559082 13.69999980926514 23.6140193939209 13.69999980926514 23.5 L 13.69999980926514 9.335935592651367 L 13.54117012023926 9.304169654846191 C 13.48386096954346 9.292706489562988 13.42427062988281 9.306221008300781 13.37150573730469 9.34181022644043 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lwen7r =
    '<svg viewBox="9.5 23.0 4.0 1.0" ><path  d="M 13 23 L 13 23.5 C 13 23.78000068664551 13.22000026702881 24 13.5 24 L 9.5 24 C 9.779999732971191 24 10 23.78000068664551 10 23.5 L 10 23 L 13 23 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_zcfvff =
    '<svg viewBox="9.5 22.7 4.0 1.6" ><path  d="M 9.699999809265137 22.70000076293945 L 13.30000019073486 22.70000076293945 L 13.30000019073486 23.5 C 13.30000019073486 23.6140193939209 13.38597965240479 23.70000076293945 13.5 23.70000076293945 L 13.5 24.29999923706055 L 9.5 24.29999923706055 L 9.5 23.70000076293945 C 9.614020347595215 23.70000076293945 9.699999809265137 23.6140193939209 9.699999809265137 23.5 L 9.699999809265137 22.70000076293945 Z M 12.69999980926514 23.29999923706055 L 10.30000019073486 23.29999923706055 L 10.30000019073486 23.5 C 10.30000019073486 23.56929969787598 10.2916145324707 23.63627624511719 10.27577972412109 23.70000076293945 L 12.72422027587891 23.70000076293945 C 12.7083854675293 23.63627624511719 12.69999980926514 23.56929969787598 12.69999980926514 23.5 L 12.69999980926514 23.29999923706055 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_djo0n =
    '<svg viewBox="8.0 5.0 3.0 1.0" ><path  d="M 10.5 5 C 10.77999973297119 5 11 5.21999979019165 11 5.5 C 11 5.78000020980835 10.77999973297119 6 10.5 6 L 8.5 6 C 8.220000267028809 6 8 5.78000020980835 8 5.5 C 8 5.21999979019165 8.220000267028809 5 8.5 5 L 10.5 5 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_czlp6w =
    '<svg viewBox="7.7 4.7 3.6 1.6" ><path  d="M 8.5 4.699999809265137 L 10.5 4.699999809265137 C 10.94859981536865 4.699999809265137 11.30000019073486 5.051400184631348 11.30000019073486 5.5 C 11.30000019073486 5.948599815368652 10.94859981536865 6.300000190734863 10.5 6.300000190734863 L 8.5 6.300000190734863 C 8.051400184631348 6.300000190734863 7.699999809265137 5.948599815368652 7.699999809265137 5.5 C 7.699999809265137 5.051400184631348 8.051400184631348 4.699999809265137 8.5 4.699999809265137 Z M 10.5 5.699999809265137 C 10.61402034759521 5.699999809265137 10.69999980926514 5.614019870758057 10.69999980926514 5.5 C 10.69999980926514 5.385980129241943 10.61402034759521 5.300000190734863 10.5 5.300000190734863 L 8.5 5.300000190734863 C 8.385979652404785 5.300000190734863 8.300000190734863 5.385980129241943 8.300000190734863 5.5 C 8.300000190734863 5.614019870758057 8.385979652404785 5.699999809265137 8.5 5.699999809265137 L 10.5 5.699999809265137 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_cpso =
    '<svg viewBox="8.0 8.0 3.0 1.0" ><path  d="M 11 8.5 C 11 8.779999732971191 10.77999973297119 9 10.5 9 L 8.5 9 C 8.220000267028809 9 8 8.779999732971191 8 8.5 C 8 8.220000267028809 8.220000267028809 8 8.5 8 L 10.5 8 C 10.77999973297119 8 11 8.220000267028809 11 8.5 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ai432v =
    '<svg viewBox="7.7 7.7 3.6 1.6" ><path  d="M 8.5 7.699999809265137 L 10.5 7.699999809265137 C 10.94859981536865 7.699999809265137 11.30000019073486 8.051400184631348 11.30000019073486 8.5 C 11.30000019073486 8.948599815368652 10.94859981536865 9.300000190734863 10.5 9.300000190734863 L 8.5 9.300000190734863 C 8.051400184631348 9.300000190734863 7.699999809265137 8.948599815368652 7.699999809265137 8.5 C 7.699999809265137 8.051400184631348 8.051400184631348 7.699999809265137 8.5 7.699999809265137 Z M 10.5 8.699999809265137 C 10.61402034759521 8.699999809265137 10.69999980926514 8.614020347595215 10.69999980926514 8.5 C 10.69999980926514 8.385979652404785 10.61402034759521 8.300000190734863 10.5 8.300000190734863 L 8.5 8.300000190734863 C 8.385979652404785 8.300000190734863 8.300000190734863 8.385979652404785 8.300000190734863 8.5 C 8.300000190734863 8.614020347595215 8.385979652404785 8.699999809265137 8.5 8.699999809265137 L 10.5 8.699999809265137 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jducm5 =
    '<svg viewBox="8.0 11.0 3.0 1.0" ><path  d="M 10.5 11 C 10.77999973297119 11 11 11.22000026702881 11 11.5 C 11 11.77999973297119 10.77999973297119 12 10.5 12 L 8.5 12 C 8.220000267028809 12 8 11.77999973297119 8 11.5 C 8 11.22000026702881 8.220000267028809 11 8.5 11 L 10.5 11 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_wswmdn =
    '<svg viewBox="7.7 10.7 3.6 1.6" ><path  d="M 8.5 10.69999980926514 L 10.5 10.69999980926514 C 10.94859981536865 10.69999980926514 11.30000019073486 11.05140018463135 11.30000019073486 11.5 C 11.30000019073486 11.94859981536865 10.94859981536865 12.30000019073486 10.5 12.30000019073486 L 8.5 12.30000019073486 C 8.051400184631348 12.30000019073486 7.699999809265137 11.94859981536865 7.699999809265137 11.5 C 7.699999809265137 11.05140018463135 8.051400184631348 10.69999980926514 8.5 10.69999980926514 Z M 10.5 11.69999980926514 C 10.61402034759521 11.69999980926514 10.69999980926514 11.61402034759521 10.69999980926514 11.5 C 10.69999980926514 11.38597965240479 10.61402034759521 11.30000019073486 10.5 11.30000019073486 L 8.5 11.30000019073486 C 8.385979652404785 11.30000019073486 8.300000190734863 11.38597965240479 8.300000190734863 11.5 C 8.300000190734863 11.61402034759521 8.385979652404785 11.69999980926514 8.5 11.69999980926514 L 10.5 11.69999980926514 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_nm9m3b =
    '<svg viewBox="8.0 14.0 3.0 1.0" ><path  d="M 10.5 14 C 10.77999973297119 14 11 14.22000026702881 11 14.5 C 11 14.77999973297119 10.77999973297119 15 10.5 15 L 8.5 15 C 8.220000267028809 15 8 14.77999973297119 8 14.5 C 8 14.22000026702881 8.220000267028809 14 8.5 14 L 10.5 14 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_f7wpsg =
    '<svg viewBox="7.7 13.7 3.6 1.6" ><path  d="M 8.5 13.69999980926514 L 10.5 13.69999980926514 C 10.94859981536865 13.69999980926514 11.30000019073486 14.05140018463135 11.30000019073486 14.5 C 11.30000019073486 14.94859981536865 10.94859981536865 15.30000019073486 10.5 15.30000019073486 L 8.5 15.30000019073486 C 8.051400184631348 15.30000019073486 7.699999809265137 14.94859981536865 7.699999809265137 14.5 C 7.699999809265137 14.05140018463135 8.051400184631348 13.69999980926514 8.5 13.69999980926514 Z M 10.5 14.69999980926514 C 10.61402034759521 14.69999980926514 10.69999980926514 14.61402034759521 10.69999980926514 14.5 C 10.69999980926514 14.38597965240479 10.61402034759521 14.30000019073486 10.5 14.30000019073486 L 8.5 14.30000019073486 C 8.385979652404785 14.30000019073486 8.300000190734863 14.38597965240479 8.300000190734863 14.5 C 8.300000190734863 14.61402034759521 8.385979652404785 14.69999980926514 8.5 14.69999980926514 L 10.5 14.69999980926514 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_j7jp8o =
    '<svg viewBox="3.0 14.0 3.0 1.0" ><path  d="M 6 14.5 C 6 14.77999973297119 5.78000020980835 15 5.5 15 L 3.5 15 C 3.220000028610229 15 3 14.77999973297119 3 14.5 C 3 14.22000026702881 3.220000028610229 14 3.5 14 L 5.5 14 C 5.78000020980835 14 6 14.22000026702881 6 14.5 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xi17f =
    '<svg viewBox="2.7 13.7 3.6 1.6" ><path  d="M 3.5 13.69999980926514 L 5.5 13.69999980926514 C 5.948599815368652 13.69999980926514 6.300000190734863 14.05140018463135 6.300000190734863 14.5 C 6.300000190734863 14.94859981536865 5.948599815368652 15.30000019073486 5.5 15.30000019073486 L 3.5 15.30000019073486 C 3.051400184631348 15.30000019073486 2.699999809265137 14.94859981536865 2.699999809265137 14.5 C 2.699999809265137 14.05140018463135 3.051400184631348 13.69999980926514 3.5 13.69999980926514 Z M 5.5 14.69999980926514 C 5.614020347595215 14.69999980926514 5.699999809265137 14.61402034759521 5.699999809265137 14.5 C 5.699999809265137 14.38597965240479 5.614020347595215 14.30000019073486 5.5 14.30000019073486 L 3.5 14.30000019073486 C 3.385980129241943 14.30000019073486 3.300000190734863 14.38597965240479 3.300000190734863 14.5 C 3.300000190734863 14.61402034759521 3.385980129241943 14.69999980926514 3.5 14.69999980926514 L 5.5 14.69999980926514 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bvvknn =
    '<svg viewBox="3.0 5.0 3.0 1.0" ><path  d="M 5.5 5 C 5.78000020980835 5 6 5.21999979019165 6 5.5 C 6 5.78000020980835 5.78000020980835 6 5.5 6 L 3.5 6 C 3.220000028610229 6 3 5.78000020980835 3 5.5 C 3 5.21999979019165 3.220000028610229 5 3.5 5 L 5.5 5 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_mv =
    '<svg viewBox="2.7 4.7 3.6 1.6" ><path  d="M 3.5 4.699999809265137 L 5.5 4.699999809265137 C 5.948599815368652 4.699999809265137 6.300000190734863 5.051400184631348 6.300000190734863 5.5 C 6.300000190734863 5.948599815368652 5.948599815368652 6.300000190734863 5.5 6.300000190734863 L 3.5 6.300000190734863 C 3.051400184631348 6.300000190734863 2.699999809265137 5.948599815368652 2.699999809265137 5.5 C 2.699999809265137 5.051400184631348 3.051400184631348 4.699999809265137 3.5 4.699999809265137 Z M 5.5 5.699999809265137 C 5.614020347595215 5.699999809265137 5.699999809265137 5.614019870758057 5.699999809265137 5.5 C 5.699999809265137 5.385980129241943 5.614020347595215 5.300000190734863 5.5 5.300000190734863 L 3.5 5.300000190734863 C 3.385980129241943 5.300000190734863 3.300000190734863 5.385980129241943 3.300000190734863 5.5 C 3.300000190734863 5.614019870758057 3.385980129241943 5.699999809265137 3.5 5.699999809265137 L 5.5 5.699999809265137 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_n47e8n =
    '<svg viewBox="3.0 8.0 3.0 1.0" ><path  d="M 5.5 8 C 5.78000020980835 8 6 8.220000267028809 6 8.5 C 6 8.779999732971191 5.78000020980835 9 5.5 9 L 3.5 9 C 3.220000028610229 9 3 8.779999732971191 3 8.5 C 3 8.220000267028809 3.220000028610229 8 3.5 8 L 5.5 8 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_aqw5kk =
    '<svg viewBox="2.7 7.7 3.6 1.6" ><path  d="M 3.5 7.699999809265137 L 5.5 7.699999809265137 C 5.948599815368652 7.699999809265137 6.300000190734863 8.051400184631348 6.300000190734863 8.5 C 6.300000190734863 8.948599815368652 5.948599815368652 9.300000190734863 5.5 9.300000190734863 L 3.5 9.300000190734863 C 3.051400184631348 9.300000190734863 2.699999809265137 8.948599815368652 2.699999809265137 8.5 C 2.699999809265137 8.051400184631348 3.051400184631348 7.699999809265137 3.5 7.699999809265137 Z M 5.5 8.699999809265137 C 5.614020347595215 8.699999809265137 5.699999809265137 8.614020347595215 5.699999809265137 8.5 C 5.699999809265137 8.385979652404785 5.614020347595215 8.300000190734863 5.5 8.300000190734863 L 3.5 8.300000190734863 C 3.385980129241943 8.300000190734863 3.300000190734863 8.385979652404785 3.300000190734863 8.5 C 3.300000190734863 8.614020347595215 3.385980129241943 8.699999809265137 3.5 8.699999809265137 L 5.5 8.699999809265137 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_nxn5 =
    '<svg viewBox="3.0 11.0 3.0 1.0" ><path  d="M 5.5 11 C 5.78000020980835 11 6 11.22000026702881 6 11.5 C 6 11.77999973297119 5.78000020980835 12 5.5 12 L 3.5 12 C 3.220000028610229 12 3 11.77999973297119 3 11.5 C 3 11.22000026702881 3.220000028610229 11 3.5 11 L 5.5 11 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_o9e89k =
    '<svg viewBox="2.7 10.7 3.6 1.6" ><path  d="M 3.5 10.69999980926514 L 5.5 10.69999980926514 C 5.948599815368652 10.69999980926514 6.300000190734863 11.05140018463135 6.300000190734863 11.5 C 6.300000190734863 11.94859981536865 5.948599815368652 12.30000019073486 5.5 12.30000019073486 L 3.5 12.30000019073486 C 3.051400184631348 12.30000019073486 2.699999809265137 11.94859981536865 2.699999809265137 11.5 C 2.699999809265137 11.05140018463135 3.051400184631348 10.69999980926514 3.5 10.69999980926514 Z M 5.5 11.69999980926514 C 5.614020347595215 11.69999980926514 5.699999809265137 11.61402034759521 5.699999809265137 11.5 C 5.699999809265137 11.38597965240479 5.614020347595215 11.30000019073486 5.5 11.30000019073486 L 3.5 11.30000019073486 C 3.385980129241943 11.30000019073486 3.300000190734863 11.38597965240479 3.300000190734863 11.5 C 3.300000190734863 11.61402034759521 3.385980129241943 11.69999980926514 3.5 11.69999980926514 L 5.5 11.69999980926514 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_kcrxj =
    '<svg viewBox="4.0 17.0 6.0 6.0" ><path  d="M 9 18.5 C 9 18.21999931335449 8.770000457763672 18 8.5 18 L 5.5 18 C 5.21999979019165 18 5 18.21999931335449 5 18.5 L 5 23 L 4 23 L 4 18.5 C 4 17.67000007629395 4.670000076293945 17 5.5 17 L 8.5 17 C 9.329999923706055 17 10 17.67000007629395 10 18.5 L 10 23 L 9 23 L 9 18.5 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jn0dqd =
    '<svg viewBox="3.7 16.7 6.6 6.6" ><path  d="M 5.5 16.70000076293945 L 8.5 16.70000076293945 C 9.492519378662109 16.70000076293945 10.30000019073486 17.50748062133789 10.30000019073486 18.5 L 10.30000019073486 23.29999923706055 L 8.699999809265137 23.29999923706055 L 8.699999809265137 18.5 C 8.699999809265137 18.3915901184082 8.608409881591797 18.29999923706055 8.5 18.29999923706055 L 5.5 18.29999923706055 C 5.385979652404785 18.29999923706055 5.300000190734863 18.3859806060791 5.300000190734863 18.5 L 5.300000190734863 23.29999923706055 L 3.699999809265137 23.29999923706055 L 3.699999809265137 18.5 C 3.699999809265137 17.50748062133789 4.507479667663574 16.70000076293945 5.5 16.70000076293945 Z M 9.699999809265137 22.70000076293945 L 9.699999809265137 18.5 C 9.699999809265137 17.83831977844238 9.161680221557617 17.29999923706055 8.5 17.29999923706055 L 5.5 17.29999923706055 C 4.838319778442383 17.29999923706055 4.300000190734863 17.83831977844238 4.300000190734863 18.5 L 4.300000190734863 22.70000076293945 L 4.699999809265137 22.70000076293945 L 4.699999809265137 18.5 C 4.699999809265137 18.05139923095703 5.051400184631348 17.70000076293945 5.5 17.70000076293945 L 8.5 17.70000076293945 C 8.941120147705078 17.70000076293945 9.300000190734863 18.05887985229492 9.300000190734863 18.5 L 9.300000190734863 22.70000076293945 L 9.699999809265137 22.70000076293945 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_zwy1j =
    '<svg viewBox="4.0 23.0 6.0 1.0" ><path  d="M 5 23 L 9 23 L 10 23 L 10 23.5 C 10 23.78000068664551 9.779999732971191 24 9.5 24 L 4.5 24 C 4.21999979019165 24 4 23.78000068664551 4 23.5 L 4 23 L 5 23 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jh4om =
    '<svg viewBox="3.7 22.7 6.6 1.6" ><path  d="M 3.699999809265137 22.70000076293945 L 10.30000019073486 22.70000076293945 L 10.30000019073486 23.5 C 10.30000019073486 23.94860076904297 9.948599815368652 24.29999923706055 9.5 24.29999923706055 L 4.5 24.29999923706055 C 4.051400184631348 24.29999923706055 3.699999809265137 23.94860076904297 3.699999809265137 23.5 L 3.699999809265137 22.70000076293945 Z M 9.699999809265137 23.29999923706055 L 4.300000190734863 23.29999923706055 L 4.300000190734863 23.5 C 4.300000190734863 23.6140193939209 4.385979652404785 23.70000076293945 4.5 23.70000076293945 L 9.5 23.70000076293945 C 9.614019393920898 23.70000076293945 9.699999809265137 23.6140193939209 9.699999809265137 23.5 L 9.699999809265137 23.29999923706055 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_negac =
    '<svg viewBox="0.0 0.2 14.0 23.8" ><path  d="M 1.75 0.2000000029802322 L 12.73999977111816 1.870000004768372 C 13.46999931335449 1.990000009536743 14 2.610000133514404 14 3.349999904632568 L 14 9.090000152587891 L 13.60000038146973 9.010000228881836 C 13.45000076293945 8.980000495910645 13.30000019073486 9.020000457763672 13.18000030517578 9.110000610351562 C 13.07000064849854 9.210000991821289 13 9.350000381469727 13 9.500000953674316 L 13 3.350000858306885 C 13 3.100000858306885 12.81999969482422 2.890000820159912 12.57999992370605 2.850000858306885 L 1.590000152587891 1.190000891685486 C 1.56000018119812 1.180000901222229 1.53000020980835 1.180000901222229 1.50000011920929 1.180000901222229 C 1.380000114440918 1.180000901222229 1.270000100135803 1.220000863075256 1.180000066757202 1.300000905990601 C 1.060000061988831 1.400000929832458 1 1.530000925064087 1 1.680000901222229 L 1 22.5 C 1 22.78000068664551 1.230000019073486 23 1.5 23 L 4 23 L 4 23.5 C 4 23.78000068664551 4.21999979019165 24 4.5 24 L 1.5 24 C 0.6700000166893005 24 0 23.32999992370605 0 22.5 L 0 1.680000305175781 C 0 1.240000247955322 0.1899999976158142 0.8200002908706665 0.5299999713897705 0.540000319480896 C 0.8700000047683716 0.2500003278255463 1.309999942779541 0.1300003230571747 1.75 0.2000003159046173 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_cgpkj4 =
    '<svg viewBox="-0.3 -0.1 14.6 24.4" ><path  d="M 1.505080223083496 -0.1194686889648438 C 1.602129936218262 -0.1194686889648438 1.700389862060547 -0.1116695404052734 1.79712963104248 -0.09626960754394531 L 12.78507041931152 1.573400497436523 C 13.66438961029053 1.717929840087891 14.30000019073486 2.464860916137695 14.30000019073486 3.350000381469727 L 14.30000019073486 9.455940246582031 L 13.54117012023926 9.304170608520508 C 13.48386001586914 9.292705535888672 13.42427062988281 9.306221008300781 13.37150573730469 9.341811180114746 C 13.32590198516846 9.387561798095703 13.30000019073486 9.444527626037598 13.30000019073486 9.500000953674316 L 12.69999980926514 9.500000953674316 L 12.69999980926514 3.350000381469727 C 12.69999980926514 3.248100280761719 12.6287899017334 3.162269592285156 12.53067970275879 3.145919799804688 L 1.511133193969727 1.479944229125977 C 1.507425308227539 1.479948043823242 1.503708839416504 1.480001449584961 1.5 1.480001449584961 C 1.451600074768066 1.480001449584961 1.413249969482422 1.494050979614258 1.37930965423584 1.524221420288086 L 1.37205982208252 1.53046989440918 C 1.321550369262695 1.572549819946289 1.300000190734863 1.617280960083008 1.300000190734863 1.680000305175781 L 1.300000190734863 22.5 C 1.300000190734863 22.6084098815918 1.391590118408203 22.70000076293945 1.5 22.70000076293945 L 4.300000190734863 22.70000076293945 L 4.300000190734863 23.5 C 4.300000190734863 23.61402130126953 4.385979652404785 23.70000076293945 4.5 23.70000076293945 L 4.5 24.30000114440918 L 1.5 24.30000114440918 C 0.5074796676635742 24.30000114440918 -0.3000001907348633 23.49252128601074 -0.3000001907348633 22.5 L -0.3000001907348633 1.680000305175781 C -0.3000001907348633 1.143772125244141 -0.06770515441894531 0.6445674896240234 0.3373804092407227 0.3099956512451172 C 0.6630849838256836 0.03304290771484375 1.077685356140137 -0.1194686889648438 1.505080223083496 -0.1194686889648438 Z M 13.69999980926514 8.724064826965332 L 13.69999980926514 3.350000381469727 C 13.69999980926514 2.760030746459961 13.27579975128174 2.262100219726562 12.69133949279785 2.166030883789062 L 1.704930305480957 0.4966011047363281 C 1.337836265563965 0.4382266998291016 0.9952878952026367 0.5374355316162109 0.7246799468994141 0.7682514190673828 L 0.7207098007202148 0.7715797424316406 C 0.4533395767211914 0.99176025390625 0.3000001907348633 1.322870254516602 0.3000001907348633 1.680000305175781 L 0.3000001907348633 22.5 C 0.3000001907348633 23.16168022155762 0.8383197784423828 23.70000076293945 1.5 23.70000076293945 L 3.724220275878906 23.70000076293945 C 3.708385467529297 23.63627624511719 3.699999809265137 23.56929969787598 3.699999809265137 23.5 L 3.699999809265137 23.30000114440918 L 1.5 23.30000114440918 C 1.058879852294922 23.30000114440918 0.6999998092651367 22.94112014770508 0.6999998092651367 22.5 L 0.6999998092651367 1.680000305175781 C 0.6999998092651367 1.439060211181641 0.7983951568603516 1.229026794433594 0.9845829010009766 1.072343826293945 C 1.128008842468262 0.9464874267578125 1.306105613708496 0.8800010681152344 1.5 0.8800010681152344 C 1.534990310668945 0.8800010681152344 1.590274810791016 0.8800029754638672 1.653580665588379 0.8961963653564453 L 12.62481021881104 2.553359985351562 C 13.01793956756592 2.618850708007812 13.30000019073486 2.953580856323242 13.30000019073486 3.350000381469727 L 13.30000019073486 8.725229263305664 C 13.41601181030273 8.695743560791016 13.53981113433838 8.69200325012207 13.65882968902588 8.71583080291748 L 13.69999980926514 8.724064826965332 Z" fill="#788198" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String users =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><g fill="none"><path d="M12 4.354a4 4 0 1 1 0 5.292M15 21H3v-1a6 6 0 0 1 12 0v1zm0 0h6v-1a6 6 0 0 0-9-5.197M13 7a4 4 0 1 1-8 0a4 4 0 0 1 8 0z" stroke="#788197" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></g></svg>';
