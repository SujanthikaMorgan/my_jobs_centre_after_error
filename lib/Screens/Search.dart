// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/page_link.dart';
import './Component34.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Search_filter.dart';
import 'Sidemenu.dart';

class Search extends StatefulWidget {
  static const String idScreen = "Search";
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(start: 0.0, end: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff7f9fc),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 64.0, middle: 0.5),
            Pin(size: 25.0, start: 60.0),
            child: Text(
              'Search',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                color: const Color(0xff1d1d1d),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 102.0, start: 16.0),
            Pin(size: 20.0, middle: 0.1942),
            child: Text(
              'Recent Search',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: const Color(0xff1d1d1d),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 253.0, start: 16.0),
            Pin(size: 137.0, middle: 0.2631),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  // pageBuilder: () => Home_job(),
                ),
              ],
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 113,
                    runSpacing: 5,
                    children: [
                      {
                        'text': 'Technical Operations Specialist',
                      },
                      {
                        'text': 'video Editor/ Content writer',
                      },
                      {
                        'text': 'Fresh Graduates Required',
                      },
                      {
                        'text': 'Data entry , Office work',
                      },
                      {
                        'text': 'Office Assistant',
                      },
                      {
                        'text': 'Assistant Manager Administration',
                      }
                    ].map((itemData) {
                      final text = itemData['text'];
                      return SizedBox(
                        width: 188.0,
                        height: 17.0,
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                'text',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: const Color(0xff1d1d1d),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(size: 44.0, start: 0.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xfff7f9fc),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(startFraction: 0.0026, endFraction: 0.0),
                  Pin(startFraction: 0.0, endFraction: 0.0),
                  child:
                      // Adobe XD layer: 'Status_Bar_Black' (group)
                      Stack(
                    children: <Widget>[],
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 303.0, start: 16.0),
            Pin(size: 44.0, start: 100.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
                //Search icon
                Pinned.fromPins(
                  Pin(size: 20.3, start: 12.0),
                  Pin(size: 20.7, middle: 0.5155),
                  child:
                      // Adobe XD layer: 'search-2036105' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.8),
                        Pin(start: 0.0, end: 1.2),
                        child:
                            // Adobe XD layer: 'Ellipse 117' (shape)
                            SvgPicture.string(
                          _svg_j3mh8g,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 5.0, end: 0.0),
                        Pin(size: 5.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'Line 113' (shape)
                            SvgPicture.string(
                          _svg_dd8wkz,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 49.0, start: 45.0),
                  Pin(size: 20.0, middle: 0.5),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: const Color(0x80788198),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 44.0, end: 15.0),
            Pin(size: 44.0, start: 100.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
                //filter option
                Pinned.fromPins(
                    Pin(size: 24.0, middle: 0.5), Pin(size: 24.0, middle: 0.5),
                    child: PageLink(
                      links: [
                        PageLinkInfo(
                          ease: Curves.easeOut,
                          duration: 0.3,
                          pageBuilder: () => Search_filter(),
                        ),
                      ],
                      child:
                          // Adobe XD layer: 'vuesax/linear/setti…' (group)
                          Stack(
                        children: <Widget>[
                          Pinned.fromPins(
                            Pin(start: 0.0, end: 0.0),
                            Pin(start: 0.0, end: 0.0),
                            child:
                                // Adobe XD layer: 'setting-4' (group)
                                Stack(
                              children: <Widget>[
                                Pinned.fromPins(
                                  Pin(size: 7.5, end: 1.3),
                                  Pin(size: 1.5, middle: 0.2556),
                                  child:
                                      // Adobe XD layer: 'Vector' (shape)
                                      SvgPicture.string(
                                    _svg_m4raxr,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Pinned.fromPins(
                                  Pin(size: 5.5, start: 1.3),
                                  Pin(size: 1.5, middle: 0.2556),
                                  child:
                                      // Adobe XD layer: 'Vector' (shape)
                                      SvgPicture.string(
                                    _svg_shrnri,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Pinned.fromPins(
                                  Pin(size: 8.5, middle: 0.371),
                                  Pin(size: 8.5, start: 2.3),
                                  child:
                                      // Adobe XD layer: 'Vector' (shape)
                                      SvgPicture.string(
                                    _svg_wpfmhv,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Pinned.fromPins(
                                  Pin(size: 5.5, end: 1.3),
                                  Pin(size: 1.5, middle: 0.7444),
                                  child:
                                      // Adobe XD layer: 'Vector' (shape)
                                      SvgPicture.string(
                                    _svg_lct3q1,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Pinned.fromPins(
                                  Pin(size: 7.5, start: 1.3),
                                  Pin(size: 1.5, middle: 0.7444),
                                  child:
                                      // Adobe XD layer: 'Vector' (shape)
                                      SvgPicture.string(
                                    _svg_m58we6,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Pinned.fromPins(
                                  Pin(size: 8.5, middle: 0.629),
                                  Pin(size: 8.5, end: 2.3),
                                  child:
                                      // Adobe XD layer: 'Vector' (shape)
                                      SvgPicture.string(
                                    _svg_xk99s7,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Pinned.fromPins(
                                  Pin(start: 0.0, end: 0.0),
                                  Pin(start: 0.0, end: 0.0),
                                  child:
                                      // Adobe XD layer: 'Vector' (shape)
                                      SvgPicture.string(
                                    _svg_ivkmgw,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          //Footer
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(size: 63.0, end: 0.0),
            child: Component34(),
          ),
          //back Arrow
          Pinned.fromPins(
            Pin(size: 9.3, start: 16.0),
            Pin(size: 16.2, start: 64.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  // pageBuilder: () => Home_job(),
                ),
              ],
              child: Stack(
                children: <Widget>[
                  Pinned.fromPins(
                    Pin(start: 0.0, end: 0.0),
                    Pin(start: 0.0, end: 0.0),
                    child:
                        // Adobe XD layer: 'ios-arrow-back' (shape)
                        SvgPicture.string(
                      _svg_vaojpw,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //SideMenu DropDown
          Pinned.fromPins(Pin(size: 27.0, end: 20.0), Pin(size: 15.8, start: 66.1),
              child: PageLink(
                links: [
                  PageLinkInfo(
                    ease: Curves.easeOut,
                    duration: 0.3,
                    pageBuilder: () => Sidemenu(),
                  ),
                ],
                child:
                    // Adobe XD layer: 'Icon ionic-ios-menu' (group)
                    Stack(
                  children: <Widget>[
                    Pinned.fromPins(
                      Pin(start: 0.0, end: 0.0),
                      Pin(size: 2.3, start: 0.0),
                      child: SvgPicture.string(
                        _svg_uk7in,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Pinned.fromPins(
                      Pin(start: 0.0, end: 0.0),
                      Pin(size: 2.3, middle: 0.5),
                      child: SvgPicture.string(
                        _svg_wkrkwh,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Pinned.fromPins(
                      Pin(start: 0.0, end: 0.0),
                      Pin(size: 2.3, end: 0.0),
                      child: SvgPicture.string(
                        _svg_bueeyd,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              )),
        ],
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
const String _svg_j3mh8g =
    '<svg viewBox="0.0 0.0 19.5 19.5" ><path transform="translate(0.78, 0.78)" d="M 8.98900032043457 -0.75 C 14.35910034179688 -0.75 18.72800064086914 3.618900299072266 18.72800064086914 8.98900032043457 C 18.72800064086914 14.35910034179688 14.35910034179688 18.72800064086914 8.98900032043457 18.72800064086914 C 3.618900299072266 18.72800064086914 -0.75 14.35910034179688 -0.75 8.98900032043457 C -0.75 3.618900299072266 3.618900299072266 -0.75 8.98900032043457 -0.75 Z M 8.98900032043457 17.22800064086914 C 13.53200054168701 17.22800064086914 17.22800064086914 13.53200054168701 17.22800064086914 8.98900032043457 C 17.22800064086914 4.446000099182129 13.53200054168701 0.75 8.98900032043457 0.75 C 4.446000099182129 0.75 0.75 4.446000099182129 0.75 8.98900032043457 C 0.75 13.53200054168701 4.446000099182129 17.22800064086914 8.98900032043457 17.22800064086914 Z" fill="#788198" fill-opacity="0.4" stroke="none" stroke-width="1.5" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_dd8wkz =
    '<svg viewBox="15.3 15.7 5.0 5.0" ><path transform="translate(16.02, 16.49)" d="M 3.523993015289307 4.265001773834229 C 3.332356214523315 4.265001773834229 3.14075231552124 4.192038059234619 2.994349956512451 4.04601001739502 L -0.5296500325202942 0.5310100317001343 C -0.822920024394989 0.2384900450706482 -0.8235300183296204 -0.2363799512386322 -0.5310100317001343 -0.5296499729156494 C -0.2384900450706482 -0.822920024394989 0.2363800555467606 -0.8235298991203308 0.5296499729156494 -0.5310099720954895 L 4.05364990234375 2.983989953994751 C 4.346920013427734 3.276510000228882 4.347529888153076 3.75137996673584 4.055009841918945 4.044650077819824 C 3.908517837524414 4.19151782989502 3.716238975524902 4.265001773834229 3.523993015289307 4.265001773834229 Z" fill="#788198" fill-opacity="0.4" stroke="none" stroke-width="1.5" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_m4raxr =
    '<svg viewBox="443.3 193.8 7.5 1.5" ><path transform="translate(444.0, 194.5)" d="M 6 0.75 L -4.440892098500626e-16 0.75 C -0.4142099916934967 0.75 -0.75 0.4142099916934967 -0.75 0 C -0.75 -0.4142099916934967 -0.4142099916934967 -0.75 -4.440892098500626e-16 -0.75 L 6 -0.75 C 6.414209842681885 -0.75 6.75 -0.4142099916934967 6.75 0 C 6.75 0.4142099916934967 6.414209842681885 0.75 6 0.75 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_shrnri =
    '<svg viewBox="429.3 193.8 5.5 1.5" ><path transform="translate(430.0, 194.5)" d="M 4 0.75 L 0 0.75 C -0.4142099916934967 0.75 -0.75 0.4142099916934967 -0.75 0 C -0.75 -0.4142099916934967 -0.4142099916934967 -0.75 0 -0.75 L 4 -0.75 C 4.414209842681885 -0.75 4.75 -0.4142099916934967 4.75 0 C 4.75 0.4142099916934967 4.414209842681885 0.75 4 0.75 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_wpfmhv =
    '<svg viewBox="433.8 190.3 8.5 8.5" ><path transform="translate(434.5, 191.0)" d="M 3.5 -0.75 C 5.843460083007812 -0.75 7.75 1.156539916992188 7.75 3.5 C 7.75 5.843460083007812 5.843460083007812 7.75 3.5 7.75 C 1.156539916992188 7.75 -0.75 5.843460083007812 -0.75 3.5 C -0.75 1.156539916992188 1.156539916992188 -0.75 3.5 -0.75 Z M 3.5 6.25 C 5.016360282897949 6.25 6.25 5.016360282897949 6.25 3.5 C 6.25 1.983640193939209 5.016360282897949 0.75 3.5 0.75 C 1.983640193939209 0.75 0.75 1.983640193939209 0.75 3.5 C 0.75 5.016360282897949 1.983640193939209 6.25 3.5 6.25 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_lct3q1 =
    '<svg viewBox="445.3 204.8 5.5 1.5" ><path transform="translate(446.0, 205.5)" d="M 4 0.75 L 0 0.75 C -0.4142099916934967 0.75 -0.75 0.4142099916934967 -0.75 0 C -0.75 -0.4142099916934967 -0.4142099916934967 -0.75 0 -0.75 L 4 -0.75 C 4.414209842681885 -0.75 4.75 -0.4142099916934967 4.75 0 C 4.75 0.4142099916934967 4.414209842681885 0.75 4 0.75 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_m58we6 =
    '<svg viewBox="429.3 204.8 7.5 1.5" ><path transform="translate(430.0, 205.5)" d="M 6 0.75 L -4.440892098500626e-16 0.75 C -0.4142099916934967 0.75 -0.75 0.4142099916934967 -0.75 0 C -0.75 -0.4142099916934967 -0.4142099916934967 -0.75 -4.440892098500626e-16 -0.75 L 6 -0.75 C 6.414209842681885 -0.75 6.75 -0.4142099916934967 6.75 0 C 6.75 0.4142099916934967 6.414209842681885 0.75 6 0.75 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_xk99s7 =
    '<svg viewBox="437.8 201.3 8.5 8.5" ><path transform="translate(438.5, 202.0)" d="M 3.5 -0.75 C 5.843460083007812 -0.75 7.75 1.156539916992188 7.75 3.5 C 7.75 5.843460083007812 5.843460083007812 7.75 3.5 7.75 C 1.156539916992188 7.75 -0.75 5.843460083007812 -0.75 3.5 C -0.75 1.156539916992188 1.156539916992188 -0.75 3.5 -0.75 Z M 3.5 6.25 C 5.016360282897949 6.25 6.25 5.016360282897949 6.25 3.5 C 6.25 1.983640193939209 5.016360282897949 0.75 3.5 0.75 C 1.983640193939209 0.75 0.75 1.983640193939209 0.75 3.5 C 0.75 5.016360282897949 1.983640193939209 6.25 3.5 6.25 Z" fill="#788198" fill-opacity="0.5" stroke="none" stroke-width="1.5" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_ivkmgw =
    '<svg viewBox="428.0 188.0 24.0 24.0" ><path transform="translate(428.0, 188.0)" d="M 0 0 L 24 0 L 24 24 L 0 24 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vaojpw =
    '<svg viewBox="16.0 64.0 9.3 16.2" ><path transform="translate(4.75, 57.81)" d="M 14.0435905456543 14.29483032226562 L 20.17609024047852 8.167134284973145 C 20.62966156005859 7.713561058044434 20.62966156005859 6.980021953582764 20.17609024047852 6.531252384185791 C 19.7225170135498 6.07767915725708 18.98897743225098 6.082482814788818 18.53540420532227 6.531252384185791 L 11.58770942687988 13.47483253479004 C 11.14854526519775 13.91399383544922 11.13893890380859 14.61802864074707 11.55408477783203 15.07159996032715 L 18.53060150146484 22.06252670288086 C 18.75704574584961 22.28896903991699 19.05622673034668 22.40013313293457 19.35060119628906 22.40013313293457 C 19.64497756958008 22.40013313293457 19.94415664672852 22.28896903991699 20.17060089111328 22.06252670288086 C 20.62417221069336 21.60895347595215 20.62417221069336 20.87541389465332 20.17060089111328 20.42664337158203 L 14.0435905456543 14.29483032226562 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_uk7in =
    '<svg viewBox="4.5 10.1 27.0 2.3" ><path  d="M 30.375 12.375 L 5.625 12.375 C 5.006249904632568 12.375 4.5 11.86874961853027 4.5 11.25 L 4.5 11.25 C 4.5 10.63125038146973 5.006249904632568 10.125 5.625 10.125 L 30.375 10.125 C 30.99374961853027 10.125 31.5 10.63125038146973 31.5 11.25 L 31.5 11.25 C 31.5 11.86874961853027 30.99374961853027 12.375 30.375 12.375 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_wkrkwh =
    '<svg viewBox="4.5 16.9 27.0 2.3" ><path  d="M 30.375 19.125 L 5.625 19.125 C 5.006249904632568 19.125 4.5 18.61874961853027 4.5 18 L 4.5 18 C 4.5 17.38125038146973 5.006249904632568 16.875 5.625 16.875 L 30.375 16.875 C 30.99374961853027 16.875 31.5 17.38125038146973 31.5 18 L 31.5 18 C 31.5 18.61874961853027 30.99374961853027 19.125 30.375 19.125 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bueeyd =
    '<svg viewBox="4.5 23.6 27.0 2.3" ><path  d="M 30.375 25.875 L 5.625 25.875 C 5.006249904632568 25.875 4.5 25.36874961853027 4.5 24.75 L 4.5 24.75 C 4.5 24.13125038146973 5.006249904632568 23.625 5.625 23.625 L 30.375 23.625 C 30.99374961853027 23.625 31.5 24.13125038146973 31.5 24.75 L 31.5 24.75 C 31.5 25.36874961853027 30.99374961853027 25.875 30.375 25.875 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
