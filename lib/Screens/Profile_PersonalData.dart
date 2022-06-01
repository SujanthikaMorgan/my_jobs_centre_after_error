// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../globalVariables.dart';
import '../mysql.dart';
import './Profile.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'prof_changeImage.dart';

class Profile_PersonalData extends StatefulWidget {
  static const String idScreen = "Profile_PersonalData";
  const Profile_PersonalData({Key? key}) : super(key: key);

  @override
  _Profile_PersonalDataState createState() => _Profile_PersonalDataState();
}

class _Profile_PersonalDataState extends State<Profile_PersonalData> {
  var db = new Mysql();
  var result;
  var fullName = '';
  var userName = ' ';
  var email = ' ';
  var phone = ' ';
  var dob = '';
  var sex = ' ';
  var city = ' ';
  var address = ' ';
  String image = 'default_user.png';
  Map data = {};
  Map userDetailsResponsePersonalData = {};
  String countryName = userDetailsResponse['country'];
  Map fetchedCities = {};
  List<String> _kOptions = [];
  bool isSpin = true;
  List items = [];
  List citiesItem = [];
  TextEditingController controllercity = TextEditingController(text: "");

  late TextEditingController _controllerUserName;
  late TextEditingController _controllerFullName;
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerSex;
  late TextEditingController _controllerCity;
  late TextEditingController _controllerAddress;

  @override
  void initState() {
    citiesFetched().then((value) {
      setState(() {
        isSpin = false;
      });
    });
    // _dbCheckProfPersonal();
    _controllerUserName = TextEditingController(
      text: userDetailsResponse["username"],
    );
    _controllerFullName = TextEditingController(
      text: userDetailsResponse["name"],
    );
    _controllerEmail = TextEditingController(
      text: userDetailsResponse["email"],
    );
    _controllerPhone = TextEditingController(
      text: (userDetailsResponse["phone"] == null) ? "" : userDetailsResponse["phone"],
    );
    _controllerSex = TextEditingController(
      text: (userDetailsResponse["sex"] == null) ? "" : userDetailsResponse["sex"],
    );
    controllercity = TextEditingController(
      text: (userDetailsResponse["city"] == null) ? "" : userDetailsResponse["city"],
    );
    _controllerAddress = TextEditingController(
      text:
          (userDetailsResponse["address"] == null) ? "" : userDetailsResponse["address"],
    );
    setState(() {
      userName = userDetailsResponse['username'];
      fullName = userDetailsResponse["name"];
      email = userDetailsResponse["email"];
      phone = (userDetailsResponse["phone"] == null) ? "" : userDetailsResponse["phone"];
      sex = (userDetailsResponse["sex"] == null) ? "" : userDetailsResponse["sex"];
      city = (userDetailsResponse["city"] == null) ? "" : userDetailsResponse["city"];
      address =
          (userDetailsResponse["address"] == null) ? "" : userDetailsResponse["address"];
    });
  }

  //----------------------upateData--------------------
  Future updateProfileData() async {
    var url = Uri.parse(defaultUrl + 'mob_update_user_details');
    var response = await http.post(url, body: json.encode(data));
    userDetailsResponsePersonalData = jsonDecode(response.body);
    print(userDetailsResponsePersonalData);

    if (userDetailsResponse['msg'] == 'User Name Exist') {
      Fluttertoast.showToast(msg: "User Name already exist");
    } else if (userDetailsResponsePersonalData['msg'] == 'Length Error') {
      Fluttertoast.showToast(
          msg: "User Name Lenght shoould be between 4 - 16 characters");
    } else if (userDetailsResponsePersonalData['msg'] == 'Invalid Chars') {
      Fluttertoast.showToast(msg: "Invalid Characters Used");
    } else if (userDetailsResponsePersonalData['msg'] == 'Successfully updated') {
      Fluttertoast.showToast(msg: "Successfully updated");
      Navigator.popAndPushNamed(context, Profile.idScreen);
    }
  }

  Future citiesFetched() async {
    var url = Uri.parse(defaultUrl + 'mob_get_cities');
    var response = await http.post(url,
        body: json.encode({'country_code': userDetailsResponse['country_code']}));

    fetchedCities = jsonDecode(response.body);
    print(fetchedCities);
    setState(() {
      for (int i = 0; i < fetchedCities['cities'].length; i++) {
        _kOptions.add(fetchedCities['cities'][i]);
      }
    });

    citiesItem = _kOptions.toList();
    items = List.from(citiesItem);

    print(citiesItem);
  }

  onItemChanged(String value) {
    setState(() {
      citiesItem = items
          .where((string) => (string).toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: const Color(0xff1d1d1d),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xffF9FAFF),
      ),
      backgroundColor: const Color(0xfff7f9fc),
      body: isSpin
          ? Center(
              child: CupertinoActivityIndicator(
                animating: isSpin,
                radius: 25,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ProfChangeImage()));
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color(0xffDD312D),
                        radius: 37,
                        child: CircleAvatar(
                          backgroundColor: const Color(0xff707070),
                          backgroundImage: NetworkImage(
                            "$profImgLink${userDetailsResponse["image"]}",
                          ),
                          radius: 35,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              backgroundColor: const Color(0xffDD312D),
                              radius: 9,
                              child: Icon(
                                Icons.mode_edit,
                                color: Colors.white,
                                size: 9,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      bottom: 20,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Personal Information',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          color: const Color(0xff132144),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 25,
                    ),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 5),
                          child: TextFormField(
                            onChanged: (value) {
                              userName = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'User Name',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: const Color(0xe5444444),
                              ),
                              border: InputBorder.none,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 5,
                                  // right: 15,
                                ),
                                child: SvgPicture.string(
                                  user,
                                  allowDrawingOutsideViewBox: true,
                                  // fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            controller: _controllerUserName,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xe5444444),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 25,
                    ),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 5),
                          child: TextFormField(
                            onChanged: (value) {
                              fullName = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: const Color(0xe5444444),
                              ),
                              border: InputBorder.none,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 5,
                                  // right: 15,
                                ),
                                child: SvgPicture.string(
                                  user,
                                  allowDrawingOutsideViewBox: true,
                                  // fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            controller: _controllerFullName,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xe5444444),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 25,
                    ),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 5),
                          child: TextFormField(
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: const Color(0xe5444444),
                              ),
                              border: InputBorder.none,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 5,
                                ),
                                child: Icon(
                                  Icons.mail_rounded,
                                  color: Color(0xffDD312D),
                                ),
                              ),
                            ),
                            controller: _controllerEmail,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xe5444444),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 25,
                    ),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 5),
                          child: TextFormField(
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Phone",
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: const Color(0xe5444444),
                              ),
                              border: InputBorder.none,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 5,
                                  // right: 15,
                                ),
                                child: Icon(
                                  Icons.phone_in_talk_rounded,
                                  color: Color(0xffDD312D),
                                ),
                              ),
                            ),
                            controller: _controllerPhone,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xe5444444),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 25,
                    ),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: TextFormField(
                          onChanged: (value) {
                            sex = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Gender",
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xe5444444),
                            ),
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 5,
                                // right: 15,
                              ),
                              child: Icon(
                                Icons.female_rounded,
                                color: Color(0xffDD312D),
                              ),
                            ),
                          ),
                          controller: _controllerSex,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: const Color(0xe5444444),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      bottom: 20,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Address',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          color: const Color(0xff132144),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 25,
                    ),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: TypeAheadFormField<String?>(
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: controllercity,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "City",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: const Color(0xe5444444),
                                ),
                              )),
                          onSuggestionSelected: (String? suggestion) {
                            setState(() {
                              controllercity.text = suggestion!;
                              city = suggestion;
                            });
                          },
                          itemBuilder: (context, String? suggestion) => ListTile(
                            title: Text(suggestion!),
                          ),
                          suggestionsCallback: (query) => _kOptions.where((element) =>
                              element.toLowerCase().contains(query.toLowerCase())),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 25,
                    ),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: TextFormField(
                          onChanged: (value) {
                            address = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Address",
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xe5444444),
                            ),
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 5,
                                // right: 15,
                              ),
                              child: Icon(
                                Icons.flag,
                                color: Color(0xffDD312D),
                              ),
                            ),
                          ),
                          controller: _controllerAddress,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: const Color(0xe5444444),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 25,
                    ),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
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
                                    height: 40,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CountryPickerUtils.getDefaultFlagImage(
                                          CountryPickerUtils.getCountryByName(
                                              countryName)),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(countryName),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 40,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
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
                  SizedBox(
                    height: 30,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width - 84,
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
                          setState(() {
                            data["fullName"] = fullName;
                            data["email"] = email;
                            data['phone'] = phone;
                            data["sex"] = sex;
                            data["city"] = city;
                            data["address"] = address;
                            data["username"] = userName;
                            data['usernameP'] = userDetailsResponse['username'];
                            data['id'] = userDetailsResponse['id'];
                            data['country'] = countryName;
                          });
                          print(data);
                          updateProfileData();
                        },
                        child: Text(
                          "Update",
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
                  SizedBox(
                    height: 30,
                  ),
                ],
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
const String _svg_lbzjyj =
    '<svg viewBox="305.7 382.0 12.2 20.0" ><path transform="translate(305.7, 382.0)" d="M 9.5 5.159999847412109 L 1.5 1.700000047683716 L 1.5 0.75 C 1.5 0.3400000035762787 1.159999966621399 0 0.75 0 C 0.3400000035762787 0 0 0.3400000035762787 0 0.75 L 0 19.25 C 0 19.65999984741211 0.3400000035762787 20 0.75 20 C 1.159999966621399 20 1.5 19.65999984741211 1.5 19.25 L 1.5 15.29000091552734 L 9.720000267028809 11.22999954223633 C 9.720000267028809 11.22999954223633 9.720000267028809 11.22999954223633 9.730000495910645 11.22999954223633 C 11.39000034332275 10.36999988555908 12.28000068664551 9.260000228881836 12.23000049591064 8.090000152587891 C 12.18000030517578 6.920000076293945 11.21000003814697 5.880000114440918 9.5 5.159999847412109 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_t5ds72 =
    '<svg viewBox="300.0 380.0 24.0 24.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 324.0, 404.0)" d="M 0 0 L 24 0 L 24 24 L 0 24 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_dzpk4i =
    '<svg viewBox="319.0 224.7 14.8 18.5" ><path transform="translate(319.0, 224.75)" d="M 5.409825801849365 12.53356552124023 C 6.741519927978516 12.42626476287842 8.079338073730469 12.42626476287842 9.411042213439941 12.53356552124023 C 10.13624286651611 12.57583808898926 10.85792827606201 12.66658020019531 11.57165813446045 12.80514526367188 C 13.11612987518311 13.11788845062256 14.12447261810303 13.62811756134033 14.55654048919678 14.45108985900879 C 14.88112258911133 15.09331798553467 14.88112258911133 15.85792255401611 14.55654048919678 16.50024223327637 C 14.12447261810303 17.32321548461914 13.15618324279785 17.86628150939941 11.55565547943115 18.14609527587891 C 10.84247970581055 18.28993225097656 10.12061023712158 18.38345146179199 9.395040512084961 18.4259090423584 C 8.722824096679688 18.5 8.050625801086426 18.5 7.370418548583984 18.5 L 6.14605188369751 18.5 C 5.889974594116211 18.46706962585449 5.641898632049561 18.45060539245605 5.401823997497559 18.45060539245605 C 4.676226615905762 18.41332817077637 3.954162120819092 18.32258605957031 3.241172313690186 18.17902565002441 C 1.696709036827087 17.88274765014648 0.6884062886238098 17.35605239868164 0.256275862455368 16.53317260742188 C 0.08945786207914352 16.21432495117188 0.001511523965746164 15.85819911956787 9.640166535973549e-05 15.49624824523926 C -0.003278486896306276 15.13198280334473 0.08200819045305252 14.77271270751953 0.2482737153768539 14.45108985900879 C 0.6724010109901428 13.62811756134033 1.68070650100708 13.09319019317627 3.241172313690186 12.80514526367188 C 3.957298040390015 12.66463756561279 4.681831836700439 12.57389545440674 5.409825801849365 12.53356552124023 Z M 7.402432918548584 -1.16350993509956e-13 C 10.08508968353271 -1.16350993509956e-13 12.25985717773438 2.236483573913574 12.25985717773438 4.995333194732666 C 12.25985717773438 7.754173278808594 10.08508968353271 9.99064826965332 7.402432918548584 9.99064826965332 C 4.719728946685791 9.99064826965332 2.544961929321289 7.754173278808594 2.544961929321289 4.995333194732666 C 2.544961929321289 2.236483573913574 4.719728946685791 -1.16350993509956e-13 7.402432918548584 -1.16350993509956e-13 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_f91kyg =
    '<svg viewBox="319.0 276.7 14.8 18.5" ><path transform="translate(319.0, 276.75)" d="M 5.409825801849365 12.53356552124023 C 6.741519927978516 12.42626476287842 8.079338073730469 12.42626476287842 9.411042213439941 12.53356552124023 C 10.13624286651611 12.57583808898926 10.85792827606201 12.66658020019531 11.57165813446045 12.80514526367188 C 13.11612987518311 13.11788845062256 14.12447261810303 13.62811756134033 14.55654048919678 14.45108985900879 C 14.88112258911133 15.09331798553467 14.88112258911133 15.85792255401611 14.55654048919678 16.50024223327637 C 14.12447261810303 17.32321548461914 13.15618324279785 17.86628150939941 11.55565547943115 18.14609527587891 C 10.84247970581055 18.28993225097656 10.12061023712158 18.38345146179199 9.395040512084961 18.4259090423584 C 8.722824096679688 18.5 8.050625801086426 18.5 7.370418548583984 18.5 L 6.14605188369751 18.5 C 5.889974594116211 18.46706962585449 5.641898632049561 18.45060539245605 5.401823997497559 18.45060539245605 C 4.676226615905762 18.41332817077637 3.954162120819092 18.32258605957031 3.241172313690186 18.17902565002441 C 1.696709036827087 17.88274765014648 0.6884062886238098 17.35605239868164 0.256275862455368 16.53317260742188 C 0.08945786207914352 16.21432495117188 0.001511523965746164 15.85819911956787 9.640166535973549e-05 15.49624824523926 C -0.003278486896306276 15.13198280334473 0.08200819045305252 14.77271270751953 0.2482737153768539 14.45108985900879 C 0.6724010109901428 13.62811756134033 1.68070650100708 13.09319019317627 3.241172313690186 12.80514526367188 C 3.957298040390015 12.66463756561279 4.681831836700439 12.57389545440674 5.409825801849365 12.53356552124023 Z M 7.402432918548584 -1.16350993509956e-13 C 10.08508968353271 -1.16350993509956e-13 12.25985717773438 2.236483573913574 12.25985717773438 4.995333194732666 C 12.25985717773438 7.754173278808594 10.08508968353271 9.99064826965332 7.402432918548584 9.99064826965332 C 4.719728946685791 9.99064826965332 2.544961929321289 7.754173278808594 2.544961929321289 4.995333194732666 C 2.544961929321289 2.236483573913574 4.719728946685791 -1.16350993509956e-13 7.402432918548584 -1.16350993509956e-13 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_fz634 =
    '<svg viewBox="317.0 329.8 18.2 16.4" ><path transform="translate(317.0, 329.8)" d="M 13.60594272613525 0 C 14.82728099822998 0 16.00216865539551 0.4827062785625458 16.86648559570312 1.348845243453979 C 17.73171424865723 2.213162899017334 18.21533203125 3.378944158554077 18.21533203125 4.599371433258057 L 18.21533203125 4.599371433258057 L 18.21533203125 11.79442691802979 C 18.21533203125 14.3354663848877 16.14789199829102 16.393798828125 13.60594272613525 16.393798828125 L 13.60594272613525 16.393798828125 L 4.608479022979736 16.393798828125 C 2.066529512405396 16.393798828125 0 14.3354663848877 0 11.79442691802979 L 0 11.79442691802979 L 0 4.599371433258057 C 0 2.058332443237305 2.057421922683716 0 4.608479022979736 0 L 4.608479022979736 0 L 13.60594272613525 0 Z M 14.63601875305176 4.735986232757568 C 14.44475841522217 4.725967884063721 14.26260471343994 4.790632724761963 14.12507915496826 4.918139934539795 L 14.12507915496826 4.918139934539795 L 10.0184326171875 8.1968994140625 C 9.490187644958496 8.634978294372559 8.733340263366699 8.634978294372559 8.1968994140625 8.1968994140625 L 8.1968994140625 8.1968994140625 L 4.09844970703125 4.918139934539795 C 3.8152015209198 4.708663463592529 3.423571825027466 4.735986232757568 3.18768310546875 4.981893062591553 C 2.941776037216187 5.227799892425537 2.914453268051147 5.619430065155029 3.123018503189087 5.892659664154053 L 3.123018503189087 5.892659664154053 L 3.242329120635986 6.011059284210205 L 7.386316776275635 9.244280815124512 C 7.896346569061279 9.645018577575684 8.51475715637207 9.863602638244629 9.162312507629395 9.863602638244629 C 9.808045387268066 9.863602638244629 10.43738555908203 9.645018577575684 10.94650363922119 9.244280815124512 L 10.94650363922119 9.244280815124512 L 15.05497264862061 5.956413745880127 L 15.12783336639404 5.883552074432373 C 15.34550762176514 5.619430065155029 15.34550762176514 5.236907958984375 15.11781597137451 4.972785472869873 C 14.99121761322021 4.837081432342529 14.8172607421875 4.754201412200928 14.63601875305176 4.735986232757568 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_b5uhd =
    '<svg viewBox="11.0 4.7 4.3 4.3" ><path transform="translate(11.04, 4.67)" d="M 3.641667366027832 4.291666507720947 C 3.283334016799927 4.291666507720947 3.000000238418579 3.999999761581421 3.000000238418579 3.649999618530273 C 3.000000238418579 3.341666460037231 2.691666126251221 2.700000047683716 2.174999713897705 2.141666650772095 C 1.666666388511658 1.600000143051147 1.108333587646484 1.283333301544189 0.6416670083999634 1.283333301544189 C 0.2833336889743805 1.283333301544189 0 0.9916666150093079 0 0.6416666507720947 C 0 0.2916666567325592 0.2916670441627502 0 0.6416670083999634 0 C 1.475000381469727 0 2.349999666213989 0.4500001668930054 3.116666316986084 1.258333444595337 C 3.833333253860474 2.016666889190674 4.291666030883789 2.958333730697632 4.291666030883789 3.641666889190674 C 4.291666030883789 4 4.000000476837158 4.291666507720947 3.641667366027832 4.291666507720947 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_y3dgw5 =
    '<svg viewBox="11.0 1.7 7.3 7.3" ><path transform="translate(11.05, 1.67)" d="M 6.641665935516357 7.291666507720947 C 6.283332824707031 7.291666507720947 5.999999046325684 6.999999523162842 5.999999046325684 6.649999618530273 C 5.999999046325684 3.691666126251221 3.591666221618652 1.291666626930237 0.6416662335395813 1.291666626930237 C 0.2833329141139984 1.291666626930237 0 0.9999999403953552 0 0.6499999761581421 C 0 0.2999999821186066 0.2833335399627686 0 0.6333335041999817 0 C 4.300000190734863 0 7.283332824707031 2.983332872390747 7.283332824707031 6.649999618530273 C 7.283332824707031 6.999999523162842 6.991665840148926 7.291666507720947 6.641665935516357 7.291666507720947 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_y32o7 =
    '<svg viewBox="1.7 1.7 7.8 12.6" ><path transform="translate(1.67, 1.67)" d="M 7.541666507720947 10.79166603088379 L 5.999999523162842 12.33333206176758 C 5.674999713897705 12.65833282470703 5.158333301544189 12.65833282470703 4.824999809265137 12.34166622161865 C 4.733333110809326 12.25 4.641666889190674 12.16666603088379 4.549999713897705 12.07499980926514 C 3.691666841506958 11.20833301544189 2.916666507720947 10.30000019073486 2.224999904632568 9.350000381469727 C 1.541666746139526 8.399999618530273 0.9916666746139526 7.450000286102295 0.5916666984558105 6.508333683013916 C 0.2000000327825546 5.558333873748779 0 4.649999618530273 0 3.783333301544189 C 0 3.216666460037231 0.09999991208314896 2.674999952316284 0.2999998927116394 2.174999952316284 C 0.4999999105930328 1.666666626930237 0.8166666626930237 1.200000047683716 1.258333325386047 0.7833333611488342 C 1.791666746139526 0.2583333849906921 2.375 0 2.991666793823242 0 C 3.225000143051147 0 3.458333253860474 0.05000005662441254 3.666666746139526 0.1500000506639481 C 3.883333206176758 0.2500000596046448 4.075000286102295 0.4000000059604645 4.224999904632568 0.6166666746139526 L 6.158333301544189 3.341666698455811 C 6.308333396911621 3.550000190734863 6.416666507720947 3.741666793823242 6.491666316986084 3.924999952316284 C 6.566666603088379 4.099999904632568 6.608333587646484 4.275000095367432 6.608333587646484 4.433333396911621 C 6.608333587646484 4.633333206176758 6.550000190734863 4.833333015441895 6.433333396911621 5.024999618530273 C 6.324999809265137 5.216666221618652 6.166666030883789 5.416666507720947 5.966666221618652 5.616666316986084 L 5.333333015441895 6.274999618530273 C 5.241666316986084 6.366666316986084 5.199999809265137 6.475000381469727 5.199999809265137 6.608333587646484 C 5.199999809265137 6.675000190734863 5.208333492279053 6.733333110809326 5.225000381469727 6.799999713897705 C 5.250000476837158 6.866666316986084 5.275000095367432 6.916666030883789 5.291666984558105 6.966666221618652 C 5.441666603088379 7.241666316986084 5.699999809265137 7.600000381469727 6.066666126251221 8.033333778381348 C 6.441666126251221 8.466666221618652 6.841665744781494 8.908333778381348 7.274999618530273 9.350000381469727 C 7.358333110809326 9.433333396911621 7.449999332427979 9.516666412353516 7.533333301544189 9.600000381469727 C 7.866666316986084 9.925000190734863 7.874999523162842 10.45833301544189 7.541666507720947 10.79166603088379 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rlo507 =
    '<svg viewBox="8.0 11.7 10.3 6.6" ><path transform="translate(8.0, 11.7)" d="M 10.3083324432373 3.574999809265137 C 10.3083324432373 3.808333396911621 10.26666641235352 4.050000190734863 10.1833324432373 4.283333301544189 C 10.15833282470703 4.349999904632568 10.13333225250244 4.416666507720947 10.09999847412109 4.483333110809326 C 9.958332061767578 4.783333301544189 9.77500057220459 5.066667079925537 9.533333778381348 5.333333492279053 C 9.125 5.783333778381348 8.674999237060547 6.108334064483643 8.166666030883789 6.316667079925537 C 8.158331871032715 6.316667079925537 8.15000057220459 6.324999332427979 8.141666412353516 6.324999332427979 C 7.650000095367432 6.524999141693115 7.116666316986084 6.633333206176758 6.541666984558105 6.633333206176758 C 5.691667079925537 6.633333206176758 4.783332824707031 6.433333396911621 3.824999332427979 6.025000095367432 C 2.866665840148926 5.6166672706604 1.908332824707031 5.066667079925537 0.9583330154418945 4.375000476837158 C 0.6333330273628235 4.133334159851074 0.3083333373069763 3.891666173934937 0 3.633332967758179 L 2.72499942779541 0.908333420753479 C 2.958332777023315 1.083333492279053 3.166666030883789 1.216666340827942 3.341665983200073 1.308333039283752 C 3.3833327293396 1.324999690055847 3.433332681655884 1.349999666213989 3.491666316986084 1.374999642372131 C 3.558332920074463 1.399999618530273 3.624999523162842 1.408332943916321 3.699999570846558 1.408332943916321 C 3.841666221618652 1.408332943916321 3.949999332427979 1.358333706855774 4.041666030883789 1.266667008399963 L 4.674999713897705 0.6416670083999634 C 4.8833327293396 0.433333694934845 5.083333015441895 0.2750000357627869 5.274999618530273 0.1750000268220901 C 5.466666698455811 0.05833336338400841 5.658332347869873 0 5.866665840148926 0 C 6.024999141693115 0 6.191666603088379 0.0333334244787693 6.374999523162842 0.1083334237337112 C 6.558332920074463 0.1833334267139435 6.75 0.2916670143604279 6.958333492279053 0.433333694934845 L 9.716666221618652 2.391666412353516 C 9.933333396911621 2.541666507720947 10.08333301544189 2.716665983200073 10.17499923706055 2.924999237060547 C 10.25833225250244 3.1333327293396 10.3083324432373 3.341666460037231 10.3083324432373 3.574999809265137 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_uyhjkv =
    '<svg viewBox="0.0 0.0 20.0 20.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 20.0, 20.0)" d="M 0 0 L 20 0 L 20 20 L 0 20 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_c6i9o =
    '<svg viewBox="433.0 190.0 14.0 20.8" ><path transform="translate(433.0, 190.0)" d="M 14 7 C 14 3.130000114440918 10.86999988555908 0 7 0 C 3.130000114440918 0 0 3.130000114440918 0 7 C 0 10.61999988555908 2.740000009536743 13.59000015258789 6.25 13.96000003814697 L 6.25 16.25 L 4 16.25 C 3.589999914169312 16.25 3.25 16.59000015258789 3.25 17 C 3.25 17.40999984741211 3.589999914169312 17.75 4 17.75 L 6.25 17.75 L 6.25 20 C 6.25 20.40999984741211 6.590000152587891 20.75 7 20.75 C 7.409999847412109 20.75 7.75 20.40999984741211 7.75 20 L 7.75 17.75 L 10 17.75 C 10.40999984741211 17.75 10.75 17.40999984741211 10.75 17 C 10.75 16.59000015258789 10.40999984741211 16.25 10 16.25 L 7.75 16.25 L 7.75 13.96000003814697 C 11.26000022888184 13.59000015258789 14 10.61999988555908 14 7 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lh27u8 =
    '<svg viewBox="428.0 188.0 24.0 24.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 452.0, 212.0)" d="M 0 0 L 24 0 L 24 24 L 0 24 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_cu4nwg =
    '<svg viewBox="492.0 188.0 24.0 24.0" ><path transform="translate(492.0, 188.0)" d="M 0 0 L 24 0 L 24 24 L 0 24 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_v71b =
    '<svg viewBox="495.0 189.3 17.9 7.1" ><path transform="translate(495.04, 189.25)" d="M 13.71116638183594 2.309999942779541 L 13.71116638183594 0.75 C 13.71116638183594 0.3400000035762787 13.37116622924805 0 12.96116638183594 0 C 12.55116653442383 0 12.21116638183594 0.3400000035762787 12.21116638183594 0.75 L 12.21116638183594 2.25 L 5.711166858673096 2.25 L 5.711166858673096 0.75 C 5.711166858673096 0.3400000035762787 5.371166706085205 0 4.961166858673096 0 C 4.551167011260986 0 4.211166858673096 0.3400000035762787 4.211166858673096 0.75 L 4.211166858673096 2.309999942779541 C 1.51116681098938 2.559999942779541 0.2011666893959045 4.170000076293945 0.001166679081507027 6.559999942779541 C -0.01883332058787346 6.849999904632568 0.2211667001247406 7.090000152587891 0.5011667013168335 7.090000152587891 L 17.42116546630859 7.090000152587891 C 17.71116638183594 7.090000152587891 17.9511661529541 6.840000152587891 17.92116546630859 6.559999942779541 C 17.72116470336914 4.170000076293945 16.41116714477539 2.559999942779541 13.71116638183594 2.309999942779541 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_o0ijbw =
    '<svg viewBox="495.0 197.8 18.0 12.2" ><path transform="translate(495.0, 197.84)" d="M 17 0 L 1 0 C 0.449999988079071 0 0 0.449999988079071 0 1 L 0 7.159999847412109 C 0 10.15999984741211 1.5 12.15999984741211 5 12.15999984741211 L 13 12.15999984741211 C 16.5 12.15999984741211 18 10.15999984741211 18 7.159999847412109 L 18 1 C 18 0.449999988079071 17.54999923706055 0 17 0 Z M 6.210000038146973 8.369998931884766 C 6.159999847412109 8.409998893737793 6.110000610351562 8.460000038146973 6.060000419616699 8.489999771118164 C 6.000000476837158 8.529999732971191 5.940000057220459 8.559999465942383 5.880000114440918 8.579999923706055 C 5.820000171661377 8.609999656677246 5.759999752044678 8.629999160766602 5.699999809265137 8.639999389648438 C 5.62999963760376 8.649999618530273 5.570000171661377 8.659999847412109 5.5 8.659999847412109 C 5.369999885559082 8.659999847412109 5.239999771118164 8.630000114440918 5.119999885559082 8.579999923706055 C 4.989999771118164 8.529999732971191 4.889999866485596 8.459999084472656 4.789999961853027 8.369998931884766 C 4.610000133514404 8.179999351501465 4.5 7.920000076293945 4.5 7.659999847412109 C 4.5 7.399999618530273 4.610000133514404 7.140000820159912 4.789999961853027 6.950000762939453 C 4.889999866485596 6.860000610351562 4.989999771118164 6.789999961853027 5.119999885559082 6.739999771118164 C 5.299999713897705 6.659999847412109 5.5 6.640000343322754 5.699999809265137 6.680000305175781 C 5.759999752044678 6.690000534057617 5.820000171661377 6.709999561309814 5.880000114440918 6.739999771118164 C 5.940000057220459 6.759999752044678 6.000000476837158 6.789999961853027 6.060000419616699 6.829999923706055 C 6.110000610351562 6.869999885559082 6.159999847412109 6.910000801086426 6.210000038146973 6.950000762939453 C 6.389999866485596 7.140000820159912 6.5 7.399999618530273 6.5 7.659999847412109 C 6.5 7.920000076293945 6.389999866485596 8.179999351501465 6.210000038146973 8.369998931884766 Z M 6.210000038146973 4.869999885559082 C 6.019999980926514 5.049999713897705 5.760000228881836 5.159999847412109 5.5 5.159999847412109 C 5.239999771118164 5.159999847412109 4.980000019073486 5.049999713897705 4.789999961853027 4.869999885559082 C 4.610000133514404 4.679999828338623 4.5 4.420000076293945 4.5 4.159999847412109 C 4.5 3.899999856948853 4.610000133514404 3.639999866485596 4.789999961853027 3.449999809265137 C 5.070000171661377 3.169999837875366 5.510000228881836 3.079999685287476 5.880000114440918 3.239999771118164 C 6.010000228881836 3.289999723434448 6.119999885559082 3.359999895095825 6.210000038146973 3.449999809265137 C 6.389999866485596 3.639999866485596 6.5 3.899999856948853 6.5 4.159999847412109 C 6.5 4.420000076293945 6.389999866485596 4.679999828338623 6.210000038146973 4.869999885559082 Z M 9.710000038146973 8.369998931884766 C 9.520000457763672 8.549999237060547 9.260000228881836 8.659999847412109 9 8.659999847412109 C 8.739999771118164 8.659999847412109 8.479999542236328 8.549999237060547 8.289999961853027 8.369998931884766 C 8.109999656677246 8.179999351501465 8 7.920000076293945 8 7.659999847412109 C 8 7.399999618530273 8.109999656677246 7.140000820159912 8.289999961853027 6.950000762939453 C 8.659999847412109 6.580000877380371 9.340000152587891 6.580000877380371 9.710000038146973 6.950000762939453 C 9.890000343322754 7.140000820159912 10 7.399999618530273 10 7.659999847412109 C 10 7.920000076293945 9.890000343322754 8.179999351501465 9.710000038146973 8.369998931884766 Z M 9.710000038146973 4.869999885559082 C 9.659999847412109 4.909999847412109 9.610000610351562 4.949999809265137 9.560000419616699 4.989999771118164 C 9.5 5.029999732971191 9.440000534057617 5.059999942779541 9.380000114440918 5.079999923706055 C 9.319999694824219 5.110000133514404 9.260000228881836 5.129999160766602 9.199999809265137 5.139999389648438 C 9.130000114440918 5.149999618530273 9.069999694824219 5.159999847412109 9 5.159999847412109 C 8.739999771118164 5.159999847412109 8.479999542236328 5.049999713897705 8.289999961853027 4.869999885559082 C 8.109999656677246 4.679999828338623 8 4.420000076293945 8 4.159999847412109 C 8 3.899999856948853 8.109999656677246 3.639999866485596 8.289999961853027 3.449999809265137 C 8.380000114440918 3.359999895095825 8.489999771118164 3.289999723434448 8.619999885559082 3.239999771118164 C 8.989999771118164 3.079999685287476 9.430000305175781 3.169999837875366 9.710000038146973 3.449999809265137 C 9.890000343322754 3.639999866485596 10 3.899999856948853 10 4.159999847412109 C 10 4.420000076293945 9.890000343322754 4.679999828338623 9.710000038146973 4.869999885559082 Z M 13.20999908447266 8.369998931884766 C 13.01999950408936 8.549999237060547 12.76000022888184 8.659999847412109 12.5 8.659999847412109 C 12.23999977111816 8.659999847412109 11.97999954223633 8.549999237060547 11.78999996185303 8.369998931884766 C 11.60999965667725 8.179999351501465 11.5 7.920000076293945 11.5 7.659999847412109 C 11.5 7.399999618530273 11.60999965667725 7.140000820159912 11.78999996185303 6.950000762939453 C 12.15999984741211 6.580000877380371 12.83999919891357 6.580000877380371 13.20999908447266 6.950000762939453 C 13.38999938964844 7.140000820159912 13.5 7.399999618530273 13.5 7.659999847412109 C 13.5 7.920000076293945 13.38999938964844 8.179999351501465 13.20999908447266 8.369998931884766 Z M 13.20999908447266 4.869999885559082 C 13.15999889373779 4.909999847412109 13.10999965667725 4.949999809265137 13.05999946594238 4.989999771118164 C 12.99999904632568 5.029999732971191 12.94000053405762 5.059999942779541 12.88000011444092 5.079999923706055 C 12.81999969482422 5.110000133514404 12.76000022888184 5.129999160766602 12.69999980926514 5.139999389648438 C 12.63000011444092 5.149999618530273 12.5600004196167 5.159999847412109 12.5 5.159999847412109 C 12.23999977111816 5.159999847412109 11.97999954223633 5.049999713897705 11.78999996185303 4.869999885559082 C 11.60999965667725 4.679999828338623 11.5 4.420000076293945 11.5 4.159999847412109 C 11.5 3.899999856948853 11.60999965667725 3.639999866485596 11.78999996185303 3.449999809265137 C 11.89000034332275 3.359999895095825 11.98999977111816 3.289999723434448 12.11999988555908 3.239999771118164 C 12.30000019073486 3.159999847412109 12.5 3.140000343322754 12.69999980926514 3.180000305175781 C 12.76000022888184 3.190000295639038 12.81999969482422 3.209999799728394 12.88000011444092 3.239999771118164 C 12.94000053405762 3.259999752044678 12.99999904632568 3.289999961853027 13.05999946594238 3.329999923706055 C 13.10999965667725 3.369999885559082 13.15999889373779 3.409999847412109 13.20999908447266 3.449999809265137 C 13.38999938964844 3.639999866485596 13.5 3.899999856948853 13.5 4.159999847412109 C 13.5 4.420000076293945 13.38999938964844 4.679999828338623 13.20999908447266 4.869999885559082 Z" fill="#dd312d" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_m18f4 =
    '<svg viewBox="0.7 6.6 6.3 1.0" ><path transform="translate(0.73, 6.64)" d="M 6.069564819335938 0.485565185546875 L 0.2427825927734375 0.485565185546875 C 0.1100614368915558 0.485565185546875 0 0.3755037188529968 0 0.2427825927734375 C 0 0.1100614368915558 0.1100614368915558 0 0.2427825927734375 0 L 6.069564819335938 0 C 6.202285766601562 0 6.312347412109375 0.1100614368915558 6.312347412109375 0.2427825927734375 C 6.312347412109375 0.3755037188529968 6.202285766601562 0.485565185546875 6.069564819335938 0.485565185546875 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bd0u42 =
    '<svg viewBox="3.8 0.6 2.8 2.8" ><path transform="translate(3.84, 0.65)" d="M 2.3162522315979 0.477086991071701 C 1.688254594802856 -0.1509106457233429 1.07320511341095 -0.1670961380004883 0.4290219843387604 0.477086991071701 L 0.03733272477984428 0.8687763214111328 C 0.004961711820214987 0.9011473059654236 -0.007986505515873432 0.9529409408569336 0.004961898550391197 0.9982603788375854 C 0.2509815990924835 1.856092095375061 0.9372469782829285 2.542357444763184 1.795078754425049 2.788377285003662 C 1.808027148246765 2.791614532470703 1.82097589969635 2.794851541519165 1.833924293518066 2.794851541519165 C 1.869532465934753 2.794851541519165 1.90190315246582 2.781903266906738 1.927799940109253 2.756006479263306 L 2.3162522315979 2.364317178726196 C 2.636725187301636 2.047081232070923 2.792105913162231 1.739556431770325 2.792105913162231 1.428794741630554 C 2.795343160629272 1.108321785926819 2.639962434768677 0.7975599765777588 2.3162522315979 0.477086991071701 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rqyhm =
    '<svg viewBox="1.1 2.0 4.2 4.2" ><path transform="translate(1.13, 1.96)" d="M 3.922129154205322 1.773931264877319 C 3.828253269195557 1.728611946105957 3.737614870071411 1.683292508125305 3.650213003158569 1.63149893283844 C 3.578996658325195 1.58941662311554 3.511017560958862 1.544097185134888 3.443038463592529 1.495540738105774 C 3.388007640838623 1.459932565689087 3.323265314102173 1.408138751983643 3.261760711669922 1.356345295906067 C 3.25528621673584 1.353108048439026 3.232626676559448 1.333685636520386 3.206729888916016 1.307788848876953 C 3.099905490875244 1.217149972915649 2.980132818222046 1.100614428520203 2.873308420181274 0.97113037109375 C 2.863597393035889 0.9646561741828918 2.847411632537842 0.9419962763786316 2.82475209236145 0.9128624200820923 C 2.792381048202515 0.8740172386169434 2.737350225448608 0.8092751502990723 2.688793897628784 0.7348217964172363 C 2.649948596954346 0.686265230178833 2.604629039764404 0.6150491833686829 2.562546730041504 0.5438329577445984 C 2.510753154754639 0.4564312100410461 2.465433835983276 0.3690294027328491 2.420114517211914 0.2783905863761902 C 2.374795198440552 0.1812775433063507 2.339186906814575 0.08740173280239105 2.30681586265564 0 L 0.273916482925415 2.032899379730225 C 0.2318341583013535 2.074981689453125 0.1929888725280762 2.155909299850464 0.1832775771617889 2.21094012260437 L 0.008474115282297134 3.450749397277832 C -0.02389689721167088 3.670872449874878 0.03760811313986778 3.878046751022339 0.1735663563013077 4.017241954803467 C 0.2901020050048828 4.13054084777832 0.4519569277763367 4.19204568862915 0.6267603635787964 4.19204568862915 C 0.6656055450439453 4.19204568862915 0.7044509053230286 4.188808917999268 0.7432960867881775 4.182334423065186 L 1.986342906951904 4.00753116607666 C 2.044610738754272 3.997820138931274 2.125538349151611 3.958974599838257 2.164383411407471 3.916892290115356 L 4.197282791137695 1.883992791175842 C 4.106643676757812 1.851621747016907 4.019242286682129 1.81601357460022 3.922129154205322 1.773931264877319 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_msrs4l =
    '<svg viewBox="0.0 0.0 7.8 7.8" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 7.77, 7.77)" d="M 0 0 L 7.76904296875 0 L 7.76904296875 7.76904296875 L 0 7.76904296875 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vaojpw =
    '<svg viewBox="16.0 64.0 9.3 16.2" ><path transform="translate(4.75, 57.81)" d="M 14.0435905456543 14.29483032226562 L 20.17609024047852 8.167134284973145 C 20.62966156005859 7.713561058044434 20.62966156005859 6.980021953582764 20.17609024047852 6.531252384185791 C 19.7225170135498 6.07767915725708 18.98897743225098 6.082482814788818 18.53540420532227 6.531252384185791 L 11.58770942687988 13.47483253479004 C 11.14854526519775 13.91399383544922 11.13893890380859 14.61802864074707 11.55408477783203 15.07159996032715 L 18.53060150146484 22.06252670288086 C 18.75704574584961 22.28896903991699 19.05622673034668 22.40013313293457 19.35060119628906 22.40013313293457 C 19.64497756958008 22.40013313293457 19.94415664672852 22.28896903991699 20.17060089111328 22.06252670288086 C 20.62417221069336 21.60895347595215 20.62417221069336 20.87541389465332 20.17060089111328 20.42664337158203 L 14.0435905456543 14.29483032226562 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

String user =
    '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 16 16"><rect x="0" y="0" width="16" height="16" fill="none" stroke="none" /><path fill="#dd312d" d="M3 14s-1 0-1-1s1-4 6-4s6 3 6 4s-1 1-1 1H3zm5-6a3 3 0 1 0 0-6a3 3 0 0 0 0 6z"/></svg>';
String email =
    '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><path fill="#dd312d" d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5l-8-5V6l8 5l8-5v2z"/></svg>';
