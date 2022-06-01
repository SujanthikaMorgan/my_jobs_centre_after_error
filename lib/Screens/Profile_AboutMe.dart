// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import '../globalVariables.dart';
import '../mysql.dart';
import './Profile.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:markdown/markdown.dart' as markdownToHtml;
import 'package:html2md/html2md.dart' as html2md;

class Profile_AboutMe extends StatefulWidget {
  static const String idScreen = "Profile_AboutMe";
  Profile_AboutMe({
    Key? key,
  }) : super(key: key);

  @override
  _Profile_AboutMe createState() => _Profile_AboutMe();
}

class _Profile_AboutMe extends State<Profile_AboutMe> {
  final formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  late TextEditingController _controller;

  String aboutMe = '';
  bool _isEnable = false;
  var db = new Mysql();
  var result;
  var name = ' ';
  var designation = ' ';
  var resultCatMainSelectedName;
  var categorySub = ' ';
  var image = 'default_user.png';
  Map aboutMeData = {};
  bool isAboutMeEnabled = false;
  Map userDetailsResponseAboutMe = {};

  @override
  void initState() {
    // _dbCheck();
    _controller = TextEditingController(
      text: userDetailsResponse["description"],
    );
    setState(() {
      aboutMe = html2md.convert(userDetailsResponse["description"]);
    });
  }

  Future updateAboutMePHP() async {
    var url = Uri.parse(defaultUrl + 'mob_update_user_aboutMe');
    var response = await http.post(url, body: json.encode(aboutMeData));
    userDetailsResponseAboutMe = jsonDecode(response.body);
    print(userDetailsResponseAboutMe);
    if (userDetailsResponseAboutMe['msg'] == 'Successfully updated') {
      Fluttertoast.showToast(msg: "Successfully updated");
      Navigator.popAndPushNamed(context, Profile.idScreen);
    }
  }

  void showKeyboard() {
    focusNode.requestFocus();
  }

  void dismissKeyboard() {
    focusNode.unfocus();
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
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
          'About me',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        child: CircleAvatar(
                          backgroundColor: const Color(0xff707070),
                          backgroundImage: NetworkImage(
                            "$profImgLink${userDetailsResponse["image"]}",
                          ),
                          radius: 35,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          userDetailsResponse["name"],
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: const Color(0xff132144),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Text(
                        (userDetailsResponse["sub_cat"] == null)
                            ? " "
                            : userDetailsResponse["sub_cat"],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: const Color(0xff788198),
                          // fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'About Me',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: const Color(0xff1d1d1d),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAboutMeEnabled = true;
                        });
                        showKeyboard();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(width: 1, color: Color(0xffDD312D)))),
                        child: Icon(
                          Icons.mode_edit,
                          color: Color(0xffDD312D),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x0f000000),
                      offset: Offset(0, 0),
                      blurRadius: 14,
                    ),
                  ],
                ),
                // child: TextFormField(
                //   autofocus: true,
                //   focusNode: focusNode,
                //   style: TextStyle(
                //     fontFamily: 'Poppins',
                //     fontSize: 16,
                //     color: const Color(0xff707070),
                //     fontWeight: FontWeight.w300,
                //   ),
                //   // autofocus: isAboutMeEnabled,
                //   controller: _controller,
                //   // key: formKey,
                //   // initialValue: aboutMe.toString(),
                //   decoration: InputDecoration(
                //     enabled: isAboutMeEnabled,
                //     border: InputBorder.none,
                //     hintText: 'AboutMe',
                //     hintStyle: TextStyle(
                //       fontFamily: 'Poppins',
                //       fontSize: 14,
                //       color: const Color(0xff707070),
                //       fontWeight: FontWeight.w300,
                //     ),
                //   ),
                //   minLines: 10,
                //   maxLines: 10,
                //   onChanged: (value) {
                //     setState(() {
                //       aboutMe = value;
                //     });
                //   },
                //   onSaved: (value) => setState(() => aboutMe = value!),
                // ),
                child: AbsorbPointer(
                  absorbing: !isAboutMeEnabled,
                  child: MarkdownTextInput(
                    (String value) => setState(() => aboutMe = value),
                    aboutMe,
                    label: 'Company Description',
                    maxLines: 10,
                    actions: MarkdownType.values,
                    boxDecoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      // border: Border.all(color: Colors.black, width: 1),
                      // borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    decoration: InputDecoration(
                      enabled: isAboutMeEnabled,
                      border: InputBorder.none,
                      hintText: 'AboutMe',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: const Color(0xff707070),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    // controller: controller,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
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
                      if (aboutMe.length < 10) {
                        Fluttertoast.showToast(msg: "Enter atleast 10 characters");
                      }
                      setState(() {
                        aboutMeData['id'] = userDetailsResponse['id'];
                        aboutMeData['aboutMe'] = markdownToHtml.markdownToHtml(aboutMe);
                      });
                      updateAboutMePHP();
                      // }
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
const String _svg_cqu3l =
    '<svg viewBox="1.7 15.4 14.6 1.1" ><path transform="translate(1.69, 15.38)" d="M 14.0625 1.125 L 0.5625 1.125 C 0.2549999952316284 1.125 0 0.8700000047683716 0 0.5625 C 0 0.2549999952316284 0.2549999952316284 0 0.5625 0 L 14.0625 0 C 14.36999988555908 0 14.625 0.2549999952316284 14.625 0.5625 C 14.625 0.8700000047683716 14.36999988555908 1.125 14.0625 1.125 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xp8yp4 =
    '<svg viewBox="8.9 1.5 6.5 6.5" ><path transform="translate(8.9, 1.5)" d="M 5.366496562957764 1.10535717010498 C 3.911496639251709 -0.3496428728103638 2.486495733261108 -0.3871428370475769 0.9939957857131958 1.10535717010498 L 0.08649574220180511 2.012857437133789 C 0.01149573922157288 2.087857246398926 -0.01850382797420025 2.207857370376587 0.0114961713552475 2.312857389450073 C 0.5814961791038513 4.300357341766357 2.171495914459229 5.89035701751709 4.158996105194092 6.460357189178467 C 4.188996315002441 6.467857360839844 4.218997001647949 6.475357532501221 4.248996734619141 6.475357532501221 C 4.331496715545654 6.475357532501221 4.406496047973633 6.445357322692871 4.466495990753174 6.385357856750488 L 5.366496562957764 5.47785758972168 C 6.108996391296387 4.742857456207275 6.468996047973633 4.030357360839844 6.468996047973633 3.310357332229614 C 6.47649621963501 2.567857265472412 6.116496562957764 1.847857117652893 5.366496562957764 1.10535717010498 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_e5b09 =
    '<svg viewBox="2.6 4.5 9.7 9.7" ><path transform="translate(2.62, 4.54)" d="M 9.087133407592773 4.109999656677246 C 8.869632720947266 4.00499963760376 8.659633636474609 3.899999856948853 8.457134246826172 3.779999971389771 C 8.292133331298828 3.682499885559082 8.134634017944336 3.577499866485596 7.977133750915527 3.464999914169312 C 7.84963321685791 3.382499694824219 7.69963264465332 3.262499570846558 7.557133197784424 3.142499685287476 C 7.54213285446167 3.134999513626099 7.489633083343506 3.089999914169312 7.429633140563965 3.029999971389771 C 7.182133197784424 2.819999933242798 6.904633522033691 2.550000190734863 6.657133102416992 2.25 C 6.634633541107178 2.235000133514404 6.597133636474609 2.182499647140503 6.544633865356445 2.114999771118164 C 6.469633102416992 2.024999856948853 6.342133522033691 1.874999642372131 6.229633331298828 1.702499628067017 C 6.139633655548096 1.589999556541443 6.034633636474609 1.424999952316284 5.937133312225342 1.259999871253967 C 5.81713342666626 1.057499885559082 5.712133407592773 0.8549997210502625 5.607133865356445 0.6449997425079346 C 5.502133846282959 0.4199997186660767 5.419633388519287 0.2025000154972076 5.344633102416992 0 L 0.6346337199211121 4.710000038146973 C 0.5371336936950684 4.807499885559082 0.4471335411071777 4.994999885559082 0.4246335625648499 5.122499942779541 L 0.019633574411273 7.994998931884766 C -0.05536642670631409 8.504999160766602 0.08713377267122269 8.98499870300293 0.4021337628364563 9.307498931884766 C 0.6721338033676147 9.569999694824219 1.047133445739746 9.712499618530273 1.452133417129517 9.712499618530273 C 1.542133331298828 9.712499618530273 1.632133722305298 9.704999923706055 1.722133636474609 9.689999580383301 L 4.602133750915527 9.284999847412109 C 4.737133502960205 9.262500762939453 4.924633979797363 9.172499656677246 5.014633655548096 9.074999809265137 L 9.724632263183594 4.364999771118164 C 9.514633178710938 4.289999961853027 9.3121337890625 4.207499504089355 9.087133407592773 4.109999656677246 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xuqqdp =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 18.0, 18.0)" d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
