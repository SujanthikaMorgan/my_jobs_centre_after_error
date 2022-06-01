// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../globalVariables.dart';
import '../mysql.dart';
import 'Profile.dart';

class Profile_Add_Experience extends StatefulWidget {
  static const String idScreen = "Profile_Add_Experience";

  @override
  _Profile_Add_Experience createState() => _Profile_Add_Experience();
}

class _Profile_Add_Experience extends State<Profile_Add_Experience> {
  final formKey = GlobalKey<FormState>();
  String isCurrentlyWork = "yes";

  var db = new Mysql();
  bool isSpin = false;
  String company = '';
  String city = '';
  String description = '';
  String title = '';
  String startDate = 'Start Date';
  String endDate = 'End Date';
  bool isWork = true;
  Map data = {};
  Map userDetailsResponseAddExp = {};

//----------------------Add Experience--------------------
  Future addExperience() async {
    var url = Uri.parse(defaultUrl + 'mob_add_experience');
    var response = await http.post(url, body: json.encode(data));
    userDetailsResponseAddExp = jsonDecode(response.body);
    print(userDetailsResponseAddExp);
    if (userDetailsResponseAddExp['msg'] == 'Success') {
      Fluttertoast.showToast(msg: "Successfully added");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Profile()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xfff7f9fc),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xff1d1d1d),
              )),
          title: Text(
            'Add Experience',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: const Color(0xff1d1d1d),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: const Color(0xfff7f9fc),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 42, right: 42, top: 20, bottom: 16),
                child: Container(
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: const Color(0xff444444),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42, right: 42, bottom: 16),
                child: Container(
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          company = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Company',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: const Color(0xff444444),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42, right: 42, bottom: 16),
                child: Container(
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          city = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'City',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: const Color(0xff444444),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42, right: 42, bottom: 16),
                child: Container(
                  color: Color(0xffFFFFFF),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextFormField(
                        onChanged: (value) {
                          description = value;
                        },
                        minLines: 10,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Describe your role',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: const Color(0xff444444),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42, right: 42, bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(1990, 1, 1),
                      maxTime: DateTime.now(),
                      onChanged: (date) {
                        setState(() {
                          startDate = DateFormat('yyyy-MM-dd').format(date);
                        });
                        print('change ${DateFormat('yyyy-MM-dd').format(date)}');
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: 50,
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 5),
                      child: Text(
                        '$startDate',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: const Color(0xff444444),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !isWork,
                child: Padding(
                  padding: const EdgeInsets.only(left: 42, right: 42, bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(1990, 1, 1),
                        maxTime: DateTime.now(),
                        onChanged: (date) {
                          setState(() {
                            endDate = DateFormat('yyyy-MM-dd').format(date);
                          });
                          print('change ${DateFormat('yyyy-MM-dd').format(date)}');
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.en,
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 50,
                      color: Color(0xffFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Text(
                          '$endDate',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: const Color(0xff444444),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42, right: 42, bottom: 16),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 50,
                  color: Color(0xffFFFFFF),
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(Color(0xffDD312D)),
                        value: isWork,
                        onChanged: (bool? value) {
                          setState(() {
                            isWork = value!;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Currently working Here",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: const Color(0xff444444),
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 84,
                  minHeight: 45,
                ),
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10.0,
                      primary: Color(0xffDD312D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onPressed: () {
                      if (city == '' ||
                          company == '' ||
                          description == '' ||
                          title == '' ||
                          startDate == 'Start Date' ||
                          (isWork == false && endDate == 'End Date')) {
                        Fluttertoast.showToast(msg: "Please Fill All Feilds");
                      } else if (description.length < 10) {
                        Fluttertoast.showToast(msg: "Too Short Description");
                      } else {
                        setState(() {
                          data['title'] = title;
                          data['company'] = company;
                          data['description'] = description;
                          data['city'] = city;
                          data['start_date'] = startDate;
                          if (endDate == 'End Date') {
                            data['end_date'] = null;
                          } else {
                            data['end_date'] = endDate;
                          }

                          data['currently_working'] = isWork;
                          data['id'] = userDetailsResponse['id'];
                        });
                        addExperience();
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: const Color(0xffffffff),
                        letterSpacing: 1.2000000000000002,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const String _svg_v141r =
    '<svg viewBox="23.0 4.0 1.3 4.0" ><path transform="translate(23.0, 4.0)" d="M 0 0 L 0 4 C 0.8047311305999756 3.661223411560059 1.328037977218628 2.873133182525635 1.328037977218628 2 C 1.328037977218628 1.126866698265076 0.8047311305999756 0.3387765288352966 0 0" fill="#000000" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ltg2cz =
    '<svg viewBox="315.7 17.3 15.3 11.0" ><path transform="translate(315.69, 17.33)" d="M 7.41510009765625 10.87290000915527 L 5.417099952697754 8.856900215148926 C 5.355900287628174 8.796600341796875 5.321700096130371 8.712900161743164 5.323500156402588 8.626500129699707 C 5.325300216674805 8.54010009765625 5.363100051879883 8.458200454711914 5.427000045776367 8.400600433349609 C 6.702300071716309 7.321500301361084 8.570700645446777 7.321500301361084 9.846000671386719 8.400600433349609 C 9.910799980163574 8.458200454711914 9.947700500488281 8.54010009765625 9.94950008392334 8.626500129699707 C 9.951300621032715 8.712900161743164 9.917099952697754 8.796600341796875 9.855899810791016 8.856900215148926 L 7.857900142669678 10.87290000915527 C 7.799400329589844 10.93230056762695 7.720200061798096 10.96560001373291 7.636500358581543 10.96560001373291 C 7.553699970245361 10.96560001373291 7.473600387573242 10.93230056762695 7.41510009765625 10.87290000915527 Z M 10.93050003051758 7.343100070953369 C 10.02780055999756 6.525900363922119 8.85420036315918 6.073200225830078 7.636500358581543 6.073200225830078 C 6.419700145721436 6.073200225830078 5.247000217437744 6.525900363922119 4.345200061798096 7.343100070953369 C 4.222800254821777 7.458300113677979 4.030200004577637 7.456500053405762 3.911400079727173 7.336800098419189 L 2.757600069046021 6.170400142669678 C 2.696400165557861 6.109200000762939 2.662199974060059 6.026400089263916 2.663100004196167 5.940000057220459 C 2.664000034332275 5.853600025177002 2.699100017547607 5.771699905395508 2.761199951171875 5.711400032043457 C 5.509799957275391 3.154500007629395 9.765900611877441 3.154500007629395 12.51360034942627 5.711400032043457 C 12.5757007598877 5.771699905395508 12.6117000579834 5.853600025177002 12.61260032653809 5.940000057220459 C 12.61350059509277 6.026400089263916 12.57929992675781 6.109200000762939 12.51900005340576 6.170400142669678 L 11.36430072784424 7.336800098419189 C 11.30341243743896 7.397687435150146 11.22391605377197 7.428067684173584 11.14436626434326 7.428062438964844 C 11.06752777099609 7.428057193756104 10.99063968658447 7.399701595306396 10.93050003051758 7.343100070953369 Z M 13.59000015258789 4.655700206756592 C 11.98350048065186 3.129300117492676 9.852300643920898 2.276999950408936 7.636500358581543 2.276999950408936 C 5.420700073242188 2.276999950408936 3.289499998092651 3.128400087356567 1.683000087738037 4.655700206756592 C 1.562399983406067 4.773600101470947 1.368900060653687 4.77180004119873 1.249199986457825 4.652100086212158 L 0.09360000491142273 3.485700130462646 C 0.0333000011742115 3.424499988555908 -0.0009000000427477062 3.342600107192993 0 3.257100105285645 C 0.0009000000427477062 3.171600103378296 0.03510000184178352 3.089699983596802 0.09630000591278076 3.029400110244751 C 4.310999870300293 -1.00980007648468 10.96110057830811 -1.00980007648468 15.17670059204102 3.029400110244751 C 15.23700046539307 3.089699983596802 15.2721004486084 3.171600103378296 15.2721004486084 3.257100105285645 C 15.27300071716309 3.342600107192993 15.23880004882812 3.424499988555908 15.17850017547607 3.485700130462646 L 14.02290058135986 4.652100086212158 C 13.96281909942627 4.712636947631836 13.88365459442139 4.743017196655273 13.80445384979248 4.743010520935059 C 13.72704887390137 4.743004322052002 13.64960861206055 4.713973522186279 13.59000015258789 4.655700206756592 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_renyrk =
    '<svg viewBox="293.7 17.7 17.0 10.7" ><path transform="translate(293.67, 17.67)" d="M 15.00030040740967 10.6668004989624 C 14.44770050048828 10.6668004989624 14.00040054321289 10.21860027313232 14.00040054321289 9.666900634765625 L 14.00040054321289 0.9999000430107117 C 14.00040054321289 0.4473000168800354 14.44770050048828 0 15.00030040740967 0 L 16.00020027160645 0 C 16.55190086364746 0 17.00010108947754 0.4473000168800354 17.00010108947754 0.9999000430107117 L 17.00010108947754 9.666900634765625 C 17.00010108947754 10.21860027313232 16.55190086364746 10.6668004989624 16.00020027160645 10.6668004989624 L 15.00030040740967 10.6668004989624 Z M 10.33290004730225 10.6668004989624 C 9.781200408935547 10.6668004989624 9.333000183105469 10.21860027313232 9.333000183105469 9.666900634765625 L 9.333000183105469 3.333600044250488 C 9.333000183105469 2.781000137329102 9.781200408935547 2.333699941635132 10.33290004730225 2.333699941635132 L 11.33370018005371 2.333699941635132 C 11.88539981842041 2.333699941635132 12.33360004425049 2.781000137329102 12.33360004425049 3.333600044250488 L 12.33360004425049 9.666900634765625 C 12.33360004425049 10.21860027313232 11.88539981842041 10.6668004989624 11.33370018005371 10.6668004989624 L 10.33290004730225 10.6668004989624 Z M 5.666399955749512 10.6668004989624 C 5.114700317382812 10.6668004989624 4.666500091552734 10.21860027313232 4.666500091552734 9.666900634765625 L 4.666500091552734 5.666399955749512 C 4.666500091552734 5.114700317382812 5.114700317382812 4.666500091552734 5.666399955749512 4.666500091552734 L 6.666300296783447 4.666500091552734 C 7.218900203704834 4.666500091552734 7.667099952697754 5.114700317382812 7.667099952697754 5.666399955749512 L 7.667099952697754 9.666900634765625 C 7.667099952697754 10.21860027313232 7.218900203704834 10.6668004989624 6.666300296783447 10.6668004989624 L 5.666399955749512 10.6668004989624 Z M 0.9999000430107117 10.6668004989624 C 0.4473000168800354 10.6668004989624 0 10.21860027313232 0 9.666900634765625 L 0 7.667099952697754 C 0 7.114500045776367 0.4473000168800354 6.666300296783447 0.9999000430107117 6.666300296783447 L 1.999800086021423 6.666300296783447 C 2.5524001121521 6.666300296783447 2.99970006942749 7.114500045776367 2.99970006942749 7.667099952697754 L 2.99970006942749 9.666900634765625 C 2.99970006942749 10.21860027313232 2.5524001121521 10.6668004989624 1.999800086021423 10.6668004989624 L 0.9999000430107117 10.6668004989624 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_vaojpw =
    '<svg viewBox="16.0 64.0 9.3 16.2" ><path transform="translate(4.75, 57.81)" d="M 14.0435905456543 14.29483032226562 L 20.17609024047852 8.167134284973145 C 20.62966156005859 7.713561058044434 20.62966156005859 6.980021953582764 20.17609024047852 6.531252384185791 C 19.7225170135498 6.07767915725708 18.98897743225098 6.082482814788818 18.53540420532227 6.531252384185791 L 11.58770942687988 13.47483253479004 C 11.14854526519775 13.91399383544922 11.13893890380859 14.61802864074707 11.55408477783203 15.07159996032715 L 18.53060150146484 22.06252670288086 C 18.75704574584961 22.28896903991699 19.05622673034668 22.40013313293457 19.35060119628906 22.40013313293457 C 19.64497756958008 22.40013313293457 19.94415664672852 22.28896903991699 20.17060089111328 22.06252670288086 C 20.62417221069336 21.60895347595215 20.62417221069336 20.87541389465332 20.17060089111328 20.42664337158203 L 14.0435905456543 14.29483032226562 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eq1nw =
    '<svg viewBox="322.2 230.7 11.6 6.6" ><path transform="matrix(0.0, -1.0, 1.0, 0.0, 315.97, 248.56)" d="M 13.24480438232422 11.97792625427246 L 17.62360382080078 7.602557182312012 C 17.94746780395508 7.27869176864624 17.94746780395508 6.754921436309814 17.62360382080078 6.434485912322998 C 17.29973793029785 6.110620498657227 16.77596664428711 6.114050388336182 16.45210266113281 6.434485912322998 L 11.4912281036377 11.39242172241211 C 11.17765140533447 11.7059965133667 11.17079162597656 12.20869922637939 11.46721839904785 12.53256416320801 L 16.44867324829102 17.52430725097656 C 16.61036109924316 17.68599319458008 16.8239860534668 17.76536750793457 17.03417778015137 17.76536750793457 C 17.24437141418457 17.76536750793457 17.4579963684082 17.68599319458008 17.61968421936035 17.52430725097656 C 17.94354820251465 17.20044136047363 17.94354820251465 16.67667007446289 17.61968421936035 16.35623359680176 L 13.24480438232422 11.97792625427246 Z" fill="#788198" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
