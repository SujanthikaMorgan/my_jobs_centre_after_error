// import 'package:adobe_jobcentre/Applied_Jobs.dart';
// import 'package:adobe_jobcentre/Component34.dart';
// import 'package:adobe_jobcentre/widget/favItemComponentWidget.dart';
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_jobs_center/Screens/HomeJob.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobExpanded extends StatefulWidget {
  static const String idScreen = "Job_Expanded";
  const JobExpanded({Key? key}) : super(key: key);

  @override
  _JobExpandedState createState() => _JobExpandedState();
}

class _JobExpandedState extends State<JobExpanded> {
  String salary = '50,000 £ - 55,000 £ Per Year';
  String company = 'Sauce Recruitment Ltd';
  String line = 'Looking for Senior Finance Analyst';
  String location = 'London,England';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      appBar: AppBar(
        backgroundColor: const Color(0xfff7f9fc),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: const Color(0xff132144),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeJob()),
            );
          },
        ),
        title: Text(
          'Job Detail',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: const Color(0xff132144),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Scrollbar(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 13, left: 10),
                                height: 75,
                                width: 75,
                                color: const Color(0xffffffff),
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: const Color(0xff707070),
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xffffffff),
                                    backgroundImage: const AssetImage(' '),
                                    radius: 30,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 8, bottom: 8),
                          child: Text(
                            company,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xff132144),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 8),
                          child: Text(
                            line,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xff132144),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text(
                              location,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: const Color(0xff132144),
                                fontWeight: FontWeight.w300,
                                height: 1.4166666666666667,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Full Time',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: const Color(0xff132144),
                                    fontWeight: FontWeight.w300,
                                    height: 1.4166666666666667,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.emoji_transportation,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Office',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: const Color(0xff132144),
                                    fontWeight: FontWeight.w300,
                                    height: 1.4166666666666667,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '30-08-21',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: const Color(0xff132144),
                                    fontWeight: FontWeight.w300,
                                    height: 1.4166666666666667,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.string(
                                  _svg_bs4zju,
                                  allowDrawingOutsideViewBox: true,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Easy job',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: const Color(0xff132144),
                                    fontWeight: FontWeight.w300,
                                    height: 1.4166666666666667,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: const Color(0xffffffff),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x14000000),
                                    offset: Offset(0, 0),
                                    blurRadius: 14,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                              'Salary',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                color: const Color(0xff132144),
                                              ),
                                              textHeightBehavior:
                                                  TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              textAlign: TextAlign.left,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 80, top: 10),
                                            child: Text(
                                              salary,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                color: const Color(0xffdd312d),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textHeightBehavior:
                                                  TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              textAlign: TextAlign.left,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, right: 260),
                                      child: Text(
                                        'Job Description',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: const Color(0xff132144),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Text(
                                        'Are you a recently/newly qualified finance analyst seeking an interesting and varied role? Love Music? This could be the role you have been looking for!!\n\nThis innovative and growing business works on an international landscape, supporting the music industry ensuring artists and publishers are represented and remunerated appropriately for their work.\n\nThe role of the Senior Finance Analyst will be to produce monthly management reporting packs for management and customers to ensure commercial optimisation for all parties. This will also involve extensive analysis on revenue and various non financial information for customers. You will also be involved in budgeting and regular forecasting.',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          color: const Color(0xff5d5d5d),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, right: 350),
                                      child: Text(
                                        'Role',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: const Color(0xff132144),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 15,
                                      ),
                                      child: Text.rich(
                                        TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            color: const Color(0xffdd312d),
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Preparing annual budgets and quarterly forecasts for publisher customer\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Lead commitments to major publisher customers for the distribution of online royalties, including reconciling system output and quality control checks.\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Support the Finance Director to develop opportunities for optimising existing business processes and mitigate the risk of service credits.\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Provide input and support the design, testing and implementation process for publisher bespoke requirements.\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Handling customer queries relating on monthly invoicing and distributions and attending regular customer face to face meetings.\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Completing reconciliations for distribution payable accounts and adhering to strict deadlines.\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Review of distribution schedules, completing specific checks and reconciliations to a high degree of accuracy.\nBuild strong relationships across the finance team and wider business.\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Supporting team in completion of external year end and internal audit requests',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                          ],
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, right: 300),
                                      child: Text(
                                        'The Person',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: const Color(0xff132144),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 15,
                                      ),
                                      child: Text.rich(
                                        TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            color: const Color(0xffdd312d),
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '• ',
                                            ),
                                            TextSpan(
                                              text:
                                                  ' A minimum of 3- 5 years’ experience within an analytical role\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '\n•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Newly Qualified accountant (CIMA, ACA, ACCA or equivalent)\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Excellent MS Excel skills with financial modelling skills\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Highly numerate and organised with excellent attention to detail\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Ability to work in a fast-paced, complex, challenging and rapidly growing/changing work environment; proven organization and prioritization skills\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Strong data gathering, analytical and reporting skills to solve problems and identify business opportunities, potential risks and impacts on the business\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Proven experience in first-class customer service and/or business partnering\n\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Able to work easily on own initiative but also in close conjunction with key individuals across different teams\n',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '•  ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Strong motivation to run a customer facing role',
                                              style: TextStyle(
                                                color: const Color(0xff5d5d5d),
                                              ),
                                            ),
                                          ],
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),

                                SizedBox(
                                  height: 100,
                                )
                              ],
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),

          SizedBox(
            height: 0,
          ),
          // Component34(),
        ],
      ),

      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width - 100,
              minHeight: 45,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 10.0,
                primary: Color(0xffDD312D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: () {
                // updateUserAlert();
              },
              child: Text(
                "Apply Now",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
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
const String _svg_q0xl5w =
    '<svg viewBox="0.0 0.0 14.1 14.1" ><path transform="translate(5.54, 4.55)" d="M 1.531081199645996 3.812162637710571 C 0.2732859253883362 3.812162637710571 -0.75 2.788876533508301 -0.75 1.531081438064575 C -0.75 0.2732861638069153 0.2732859253883362 -0.7499997615814209 1.531081199645996 -0.7499997615814209 C 2.788876533508301 -0.7499997615814209 3.812162160873413 0.2732861638069153 3.812162160873413 1.531081438064575 C 3.812162160873413 2.788876533508301 2.788876533508301 3.812162637710571 1.531081199645996 3.812162637710571 Z M 1.531081199645996 0.1341402530670166 C 0.7608065605163574 0.1341402530670166 0.1341399401426315 0.7608068585395813 0.1341399401426315 1.531081438064575 C 0.1341399401426315 2.301356077194214 0.7608065605163574 2.928022623062134 1.531081199645996 2.928022623062134 C 2.301355600357056 2.928022623062134 2.928022384643555 2.301356077194214 2.928022384643555 1.531081438064575 C 2.928022384643555 0.7608068585395813 2.301355600357056 0.1341402530670166 1.531081199645996 0.1341402530670166 Z" fill="#132144" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(2.3, 1.49)" d="M 4.772934913635254 -0.7499980926513672 C 5.984224319458008 -0.7499980926513672 7.166644096374512 -0.3803618550300598 8.102382659912109 0.2908241748809814 C 9.143568992614746 1.037639141082764 9.84991455078125 2.121683597564697 10.14506435394287 3.425759792327881 C 10.47185325622559 4.869324684143066 10.27812004089355 6.340976715087891 9.569239616394043 7.799806594848633 C 9.045441627502441 8.87775707244873 8.24919605255127 9.933897018432617 7.202632904052734 10.93889808654785 C 6.547604560852051 11.57112312316895 5.684730529785156 11.91972827911377 4.773765563964844 11.91972827911377 C 3.863214015960693 11.91972827911377 2.999049425125122 11.57138919830322 2.34045934677124 10.93887996673584 C 1.296172380447388 9.932429313659668 0.501795768737793 8.875350952148438 -0.02115502953529358 7.796469688415527 C -0.7293218374252319 6.335489273071289 -0.9227477312088013 4.862982749938965 -0.5960519909858704 3.419847965240479 C -0.2996590733528137 2.116926193237305 0.4067978858947754 1.034432768821716 1.447047710418701 0.2889376878738403 C 2.381913423538208 -0.3810285329818726 3.563071966171265 -0.7499980926513672 4.772934913635254 -0.7499980926513672 Z M 4.773765563964844 11.03558826446533 C 5.454459190368652 11.03558826446533 6.099279403686523 10.77504920959473 6.589436531066895 10.30196475982666 C 8.16590404510498 8.78809928894043 9.912056922912598 6.400897026062012 9.28273868560791 3.620948553085327 C 8.700255393981934 1.047317743301392 6.489292144775391 0.1341419368982315 4.772934913635254 0.1341419368982315 C 3.05926513671875 0.1341419368982315 0.8507071733474731 1.045896649360657 0.2661664187908173 3.615508317947388 C -0.362980842590332 6.394701957702637 1.380248308181763 8.785540580749512 2.953445672988892 10.30173969268799 C 3.445988178253174 10.77477836608887 4.092660427093506 11.03558826446533 4.773765563964844 11.03558826446533 Z" fill="#132144" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 14.15, 14.15)" d="M 0 0 L 14.146240234375 0 L 14.146240234375 14.146240234375 L 0 14.146240234375 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ivigmg =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(1.69, 1.69)" d="M 7.3125 -0.75 C 11.75817775726318 -0.75 15.375 2.866822242736816 15.375 7.3125 C 15.375 11.75817775726318 11.75817775726318 15.375 7.3125 15.375 C 2.866822242736816 15.375 -0.75 11.75817775726318 -0.75 7.3125 C -0.75 2.866822242736816 2.866822242736816 -0.75 7.3125 -0.75 Z M 7.3125 14.25 C 11.13785171508789 14.25 14.25 11.13785171508789 14.25 7.3125 C 14.25 3.487147808074951 11.13785171508789 0.375 7.3125 0.375 C 3.487147808074951 0.375 0.375 3.487147808074951 0.375 7.3125 C 0.375 11.13785171508789 3.487147808074951 14.25 7.3125 14.25 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(8.91, 5.82)" d="M 2.871969699859619 6.127584457397461 C 2.773899555206299 6.127584457397461 2.674578666687012 6.101931571960449 2.584244966506958 6.048022270202637 L 0.2592449486255646 4.6605224609375 C -0.3154800534248352 4.319954872131348 -0.7500001192092896 3.557332515716553 -0.7500001192092896 2.887499809265137 L -0.7500001192092896 -0.1874999552965164 C -0.7500001192092896 -0.4981574416160583 -0.4981575608253479 -0.7499999403953552 -0.1875000596046448 -0.7499999403953552 C 0.1231574416160583 -0.7499999403953552 0.3749999105930328 -0.4981574416160583 0.3749999105930328 -0.1874999552965164 L 0.3749999105930328 2.887499809265137 C 0.3749999105930328 3.16194748878479 0.5981924533843994 3.553695201873779 0.834262490272522 3.69358491897583 L 3.160754680633545 5.081977367401123 C 3.4275221824646 5.241172790527344 3.514724731445312 5.586487293243408 3.355522632598877 5.853255271911621 C 3.250234603881836 6.029688835144043 3.063514709472656 6.127584457397461 2.871969699859619 6.127584457397461 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path  d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_h1s31m =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(0.94, 16.69)" d="M 16.3125 0.375 L -0.1875 0.375 C -0.4981575012207031 0.375 -0.75 0.1231575012207031 -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 L 16.3125 -0.75 C 16.6231575012207 -0.75 16.875 -0.4981575012207031 16.875 -0.1875 C 16.875 0.1231575012207031 16.6231575012207 0.375 16.3125 0.375 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(15.02, 13.35)" d="M -0.1875 3.720016002655029 C -0.4981575012207031 3.720016002655029 -0.75 3.468173265457153 -0.75 3.157516002655029 L -0.75 -0.1874990016222 C -0.75 -0.4981564879417419 -0.4981575012207031 -0.7499989867210388 -0.1875 -0.7499989867210388 C 0.1231575012207031 -0.7499989867210388 0.375 -0.4981564879417419 0.375 -0.1874990016222 L 0.375 3.157516002655029 C 0.375 3.468173265457153 0.1231575012207031 3.720016002655029 -0.1875 3.720016002655029 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(13.39, 8.36)" d="M 1.462509751319885 -0.7499985694885254 C 2.68248987197876 -0.7499985694885254 3.6750168800354 0.2425289154052734 3.6750168800354 1.462508797645569 L 3.6750168800354 3.164978981018066 C 3.6750168800354 4.38495922088623 2.68248987197876 5.377486705780029 1.462509751319885 5.377486705780029 C 0.2425296902656555 5.377486705780029 -0.749997615814209 4.38495922088623 -0.749997615814209 3.164978981018066 L -0.749997615814209 1.462508797645569 C -0.749997615814209 0.2425289154052734 0.2425296902656555 -0.7499985694885254 1.462509751319885 -0.7499985694885254 Z M 1.462509751319885 4.252486705780029 C 2.062164783477783 4.252486705780029 2.550017356872559 3.764633655548096 2.550017356872559 3.164978981018066 L 2.550017356872559 1.462508797645569 C 2.550017356872559 0.8628541231155396 2.062164783477783 0.3750014305114746 1.462509751319885 0.3750014305114746 C 0.8628547191619873 0.3750014305114746 0.3750022053718567 0.8628541231155396 0.3750022053718567 1.462508797645569 L 0.3750022053718567 3.164978981018066 C 0.3750022053718567 3.764633655548096 0.8628547191619873 4.252486705780029 1.462509751319885 4.252486705780029 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(1.76, 2.45)" d="M 8.96251106262207 14.61749744415283 C 8.651845932006836 14.61749744415283 8.40001106262207 14.36565494537354 8.40001106262207 14.05499744415283 L 8.40001106262207 2.077512502670288 C 8.40001106262207 0.8841651678085327 7.899828910827637 0.3750050961971283 6.727526664733887 0.3750050961971283 L 2.055041074752808 0.3750050961971283 C 0.8774435520172119 0.3750050961971283 0.3749961256980896 0.8841651678085327 0.3749961256980896 2.077512502670288 L 0.3749961256980896 14.05499744415283 C 0.3749961256980896 14.36565494537354 0.1231611222028732 14.61749744415283 -0.1875038892030716 14.61749744415283 C -0.4981613755226135 14.61749744415283 -0.7500038743019104 14.36565494537354 -0.7500038743019104 14.05499744415283 L -0.7500038743019104 2.077512502670288 C -0.7500038743019104 0.2541651427745819 0.2461836189031601 -0.7499948740005493 2.055041074752808 -0.7499948740005493 L 6.727526664733887 -0.7499948740005493 C 8.531508445739746 -0.7499948740005493 9.52501106262207 0.2541651427745819 9.52501106262207 2.077512502670288 L 9.52501106262207 14.05499744415283 C 9.52501106262207 14.36565494537354 9.273168563842773 14.61749744415283 8.96251106262207 14.61749744415283 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(4.54, 6.38)" d="M 3.52501106262207 0.375 L -0.1875038892030716 0.375 C -0.4981613755226135 0.375 -0.7500038743019104 0.1231575012207031 -0.7500038743019104 -0.1875 C -0.7500038743019104 -0.4981575012207031 -0.4981613755226135 -0.75 -0.1875038892030716 -0.75 L 3.52501106262207 -0.75 C 3.835668563842773 -0.75 4.08751106262207 -0.4981575012207031 4.08751106262207 -0.1875 C 4.08751106262207 0.1231575012207031 3.835668563842773 0.375 3.52501106262207 0.375 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(4.54, 9.19)" d="M 3.52501106262207 0.375 L -0.1875038892030716 0.375 C -0.4981613755226135 0.375 -0.7500038743019104 0.1231575012207031 -0.7500038743019104 -0.1875 C -0.7500038743019104 -0.4981575012207031 -0.4981613755226135 -0.75 -0.1875038892030716 -0.75 L 3.52501106262207 -0.75 C 3.835668563842773 -0.75 4.08751106262207 -0.4981575012207031 4.08751106262207 -0.1875 C 4.08751106262207 0.1231575012207031 3.835668563842773 0.375 3.52501106262207 0.375 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(6.38, 13.88)" d="M -0.1875 3.1875 C -0.4981575012207031 3.1875 -0.75 2.935657501220703 -0.75 2.625 L -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 C 0.1231575012207031 -0.75 0.375 -0.4981575012207031 0.375 -0.1875 L 0.375 2.625 C 0.375 2.935657501220703 0.1231575012207031 3.1875 -0.1875 3.1875 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path  d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_t7ogaf =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(6.19, 1.69)" d="M -0.1875 2.625 C -0.4981575012207031 2.625 -0.75 2.373157501220703 -0.75 2.0625 L -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 C 0.1231575012207031 -0.75 0.375 -0.4981575012207031 0.375 -0.1875 L 0.375 2.0625 C 0.375 2.373157501220703 0.1231575012207031 2.625 -0.1875 2.625 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(12.19, 1.69)" d="M -0.1875 2.625 C -0.4981575012207031 2.625 -0.75 2.373157501220703 -0.75 2.0625 L -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 C 0.1231575012207031 -0.75 0.375 -0.4981575012207031 0.375 -0.1875 L 0.375 2.0625 C 0.375 2.373157501220703 0.1231575012207031 2.625 -0.1875 2.625 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(2.81, 7.0)" d="M 12.56250095367432 0.375 L -0.1875 0.375 C -0.4981575012207031 0.375 -0.75 0.1231575012207031 -0.75 -0.1875 C -0.75 -0.4981575012207031 -0.4981575012207031 -0.75 -0.1875 -0.75 L 12.56250095367432 -0.75 C 12.8731575012207 -0.75 13.12500095367432 -0.4981575012207031 13.12500095367432 -0.1875 C 13.12500095367432 0.1231575012207031 12.8731575012207 0.375 12.56250095367432 0.375 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(2.44, 2.81)" d="M 3.562500953674316 -0.75 L 9.5625 -0.75 C 10.98719215393066 -0.75 12.08790874481201 -0.3425626754760742 12.83407592773438 0.4609947204589844 C 13.52477931976318 1.204836845397949 13.875 2.248334884643555 13.875 3.562500953674316 L 13.875 9.9375 C 13.875 11.25166511535645 13.52477931976318 12.29516410827637 12.83407592773438 13.03900527954102 C 12.08790874481201 13.84256362915039 10.98719215393066 14.25000095367432 9.5625 14.25000095367432 L 3.562500953674316 14.25000095367432 C 2.137807846069336 14.25000095367432 1.037092208862305 13.84256362915039 0.290924072265625 13.03900527954102 C -0.3997793197631836 12.29516410827637 -0.75 11.25166511535645 -0.75 9.9375 L -0.75 3.562500953674316 C -0.75 2.248334884643555 -0.3997793197631836 1.204836845397949 0.290924072265625 0.4609947204589844 C 1.037092208862305 -0.3425626754760742 2.137807846069336 -0.75 3.562500953674316 -0.75 Z M 9.5625 13.12500095367432 C 10.66167068481445 13.12500095367432 11.48502063751221 12.83851528167725 12.00967502593994 12.2734956741333 C 12.5009183883667 11.74446773529053 12.75 10.95852756500244 12.75 9.9375 L 12.75 3.562500953674316 C 12.75 2.541472434997559 12.5009183883667 1.755532264709473 12.00967502593994 1.226505279541016 C 11.48502063751221 0.6614856719970703 10.66167068481445 0.375 9.5625 0.375 L 3.562500953674316 0.375 C 2.463330268859863 0.375 1.639980316162109 0.6614856719970703 1.115324974060059 1.226505279541016 C 0.6240816116333008 1.755532264709473 0.375 2.541472434997559 0.375 3.562500953674316 L 0.375 9.9375 C 0.375 10.95852756500244 0.6240816116333008 11.74446773529053 1.115324974060059 12.2734956741333 C 1.639980316162109 12.83851528167725 2.463330268859863 13.12500095367432 3.562500953674316 13.12500095367432 L 9.5625 13.12500095367432 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(0.0, 0.0)" d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(11.53, 10.03)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(11.53, 12.28)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(8.75, 10.03)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(8.75, 12.28)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(5.98, 10.03)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(5.98, 12.28)" d="M 0.2512435913085938 1 L 0.2445077896118164 1 C -0.1697101593017578 1 -0.5054922103881836 0.664210319519043 -0.5054922103881836 0.25 C -0.5054922103881836 -0.164210319519043 -0.1697101593017578 -0.5 0.2445077896118164 -0.5 L 0.2512435913085938 -0.5 C 0.6654605865478516 -0.5 1.001243114471436 -0.164210319519043 1.001243114471436 0.25 C 1.001243114471436 0.664210319519043 0.6654605865478516 1 0.2512435913085938 1 Z" fill="#788198" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_bs4zju =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(1.69, 2.13)" d="M 11.85610771179199 14.49562454223633 L 7.311108112335205 14.49562454223633 C 7.279746055603027 14.49562454223633 7.248995780944824 14.4930591583252 7.219031810760498 14.48812484741211 L 2.766107797622681 14.48812484741211 C 1.302332997322083 14.48812484741211 0.1848479807376862 13.95948791503906 -0.3805020451545715 12.99959278106689 C -0.9466395378112793 12.03835487365723 -0.8668545484542847 10.80273818969727 -0.1558320373296738 9.520364761352539 L 2.1843101978302 5.305102348327637 L 4.389655590057373 1.34447979927063 C 5.138440608978271 -0.005857706069946289 6.176140308380127 -0.7500001788139343 7.311108112335205 -0.7500001788139343 C 8.446076393127441 -0.7500001788139343 9.48377513885498 -0.005857706069946289 10.23304080963135 1.345342397689819 L 12.43777751922607 5.312369823455811 L 14.77790546417236 9.527603149414062 C 15.48819351196289 10.80865478515625 15.56731796264648 12.0436954498291 15.00085830688477 13.00547981262207 C 14.43489360809326 13.96641731262207 13.31806755065918 14.49562454223633 11.85610771179199 14.49562454223633 Z M 7.40318489074707 13.37062454223633 L 11.85610771179199 13.37062454223633 C 12.90340137481689 13.37062454223633 13.67596912384033 13.03818798065186 14.03149127960205 12.43454933166504 C 14.3875150680542 11.83006477355957 14.30323123931885 10.99151992797852 13.79416751861572 10.07338523864746 L 11.45431041717529 5.858647346496582 L 9.249438285827637 1.891379833221436 C 8.707112312316895 0.9133573174476624 8.01882266998291 0.3749998211860657 7.311108112335205 0.3749998211860657 C 6.6033935546875 0.3749998211860657 5.915103435516357 0.9133573174476624 5.373040199279785 1.890907287597656 L 3.167560338973999 5.85176944732666 L 0.827905535697937 10.06614685058594 C 0.318107932806015 10.98561000823975 0.2331629693508148 11.82472515106201 0.5888653993606567 12.42866992950439 C 0.9437730312347412 13.03126430511475 1.717000365257263 13.36312484741211 2.766107797622681 13.36312484741211 L 7.311108112335205 13.36312484741211 C 7.342470169067383 13.36312484741211 7.373220920562744 13.36569023132324 7.40318489074707 13.37062454223633 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(2.11, 10.23)" d="M 13.97199726104736 5.332549571990967 C 13.86056232452393 5.332549571990967 13.74805736541748 5.299539566040039 13.6498498916626 5.230770587921143 L 6.892484188079834 0.4991833567619324 L 0.1351191401481628 5.230770587921143 C -0.1193558275699615 5.408962249755859 -0.4701008498668671 5.34711742401123 -0.6482858657836914 5.092635154724121 C -0.8264783620834351 4.838160514831543 -0.7646332979202271 4.487415313720703 -0.5101508498191833 4.309230327606201 L 6.569849491119385 -0.6482695341110229 C 6.763550758361816 -0.7839070558547974 7.021417617797852 -0.7839070558547974 7.215118885040283 -0.6482695341110229 L 14.2951192855835 4.309230327606201 C 14.54960155487061 4.487415313720703 14.61144733428955 4.838160514831543 14.43325328826904 5.092635154724121 C 14.3238353729248 5.24890661239624 14.14930629730225 5.332549571990967 13.97199726104736 5.332549571990967 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(9.19, 2.44)" d="M -0.1875 8.167500495910645 C -0.4981575012207031 8.167500495910645 -0.75 7.915657043457031 -0.75 7.605000495910645 L -0.75 -0.1874998211860657 C -0.75 -0.4981573224067688 -0.4981575012207031 -0.7499998211860657 -0.1875 -0.7499998211860657 C 0.1231575012207031 -0.7499998211860657 0.375 -0.4981573224067688 0.375 -0.1874998211860657 L 0.375 7.605000495910645 C 0.375 7.915657043457031 0.1231575012207031 8.167500495910645 -0.1875 8.167500495910645 Z" fill="#788198" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path  d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
