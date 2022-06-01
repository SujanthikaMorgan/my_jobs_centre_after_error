// import 'package:adobe_jobcentre/widget/favItemComponentWidget.dart';
// import 'package:adobe_jobcentre/widget/socialLinksWidget.dart';
// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:my_jobs_center/Screens/jobDetails.dart';
import 'package:my_jobs_center/Screens/widget/favItemComponentWidget.dart';
import 'package:my_jobs_center/Screens/widget/socialLinksWidget.dart';
import 'package:my_jobs_center/globalVariables.dart';
import './Companies.dart';
import 'package:adobe_xd/page_link.dart';
import './Component351.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:http/http.dart' as http;

class Company_Expanded extends StatefulWidget {
  static const String idScreen = "CompanyExpand";

  final String compName;
  final String jobsPosted;
  final String description;
  final String logo;
  final String companyLink;
  final String? email;
  final String? website;
  final String? facebook;
  final String? twitter;
  final String? pinterest;
  final String? youtube;
  final String? instagram;
  final String? phone;
  final String? linkedin;
  final String companyId;
  const Company_Expanded(
      {required this.compName,
      required this.jobsPosted,
      required this.description,
      required this.logo,
      this.email,
      this.website,
      this.facebook,
      this.twitter,
      this.pinterest,
      this.youtube,
      this.instagram,
      this.phone,
      this.linkedin,
      required this.companyId,
      required this.companyLink});

  @override
  _Company_ExpandedState createState() => _Company_ExpandedState();
}

class _Company_ExpandedState extends State<Company_Expanded> {
  var favJobsIds = [];
  var prodAdId = [];
  var companyIDFav = [];
  var productNameFav = [];
  var cityIDFav = [];
  var countryIDFav = [];
  var createdAtFav = [];
  var prodTypeFav = [];
  var viewFav = [];
  var salMinFav = [];
  var salMaxFav = [];
  var descriptionFav = [];
  var salaryTypeFavID = [];
  var resultFavJobCompName = [];
  var resultFavSalaryType = [];
  var companyNameFav = [];
  var imageFav = [];
  var salaryTypeFavName = [];
  var resultFavJobType = [];
  var jobTypeFav = [];
  var resultFavCountry = [];
  var countryFav = [];
  var currencyFav = [];
  var resultFavCity = [];
  var cityFav = [];
  Map alljobs = {};
  Map alljobs1 = {};
  var allJobsList = [];

  bool isSpin = true;
  Map pageData = {};
  int offset = 1;
  List favIdsRec = [];
  Map favIdData = {};
  bool isAllJobsEmpty = false;
  Future gettingFavJobsIds() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_fav_jobs_ids');
    var url = Uri.parse(defaultUrl + 'mob_fav_jobs_ids');
    setState(() {
      favIdData['id'] = userDetailsResponse['id'];
    });

    var response = await http.post(url, body: json.encode(favIdData));
    try {
      setState(() {
        favIdsRec = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
    print("favIds");
    print(favIdsRec);
  }

  Future gettingAllJobs() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_all_jobs');
    var url = Uri.parse(defaultUrl + 'mob_company_jobs');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    setState(() {
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
      pageData['company_id'] = widget.companyId;
    });
    var response = await http.post(url, body: json.encode(pageData));
    // var response = await http.post(url);
    try {
      alljobs = jsonDecode(response.body);
      print(alljobs);

      alljobs['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print("-------------------------------------------------");
      print(allJobsList);
      print("-------------------------------------------------");

      print(alljobs['all'][allJobsList[0].toString()]);
      print("-------------------------------------------------");
    } catch (error) {
      print(error);
      setState(() {
        isAllJobsEmpty = true;
      });
    }

    // print(appliedJobs);
    // print(appliedJobs
    //     .map((i, element) => MapEntry(i, print(appliedJobs[i].toString()))));
    setState(() {
      isSpin = false;
    });
  }

  Future gettingAllJobsLoop() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_all_jobs');
    var url = Uri.parse(defaultUrl + 'mob_company_jobs');

    // Starting Web API Call.

    setState(() {
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
      pageData['company_id'] = widget.companyId;
    });
    var response = await http.post(url, body: json.encode(pageData));
    // var response = await http.post(url);

    try {
      alljobs1 = jsonDecode(response.body);
      print(alljobs1);

      alljobs1['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print("-------------------------------------------------");
      print(allJobsList);
      print("-------------------------------------------------");
      alljobs['all'].addAll(alljobs1['all']);
      print(alljobs['all'][allJobsList[0].toString()]);
      print("-------------------------------------------------");
    } on FormatException catch (e) {
      gettingAllJobsLoopOnExecption();
    } catch (error) {
      print(error);
    }
    // if (jsonDecode(response.body) == null) {
    //   print("null received");
    // } else {
    //   alljobs1 = jsonDecode(response.body);
    //   print(alljobs1);

    //   alljobs1['all'].forEach((k, v) => allJobsList.add(Applied(k)));
    //   print("-------------------------------------------------");
    //   print(allJobsList);
    //   print("-------------------------------------------------");
    //   alljobs['all'].addAll(alljobs1['all']);
    //   print(alljobs['all'][allJobsList[0].toString()]);
    //   print("-------------------------------------------------");
    // }

    setState(() {
      isDataLoadProgress = false;
    });
  }

  Future gettingAllJobsLoopOnExecption() async {
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_all_jobs');
    var url = Uri.parse(defaultUrl + 'mob_company_jobs');

    // Starting Web API Call.

    setState(() {
      offset = offset + 1;
      pageData["limit"] = 20;
      pageData['offset'] = offset;
      pageData['country'] = userDetailsResponse['country_code'];
      pageData['company_id'] = widget.companyId;
    });
    var response = await http.post(url, body: json.encode(pageData));
    // var response = await http.post(url);

    try {
      alljobs1 = jsonDecode(response.body);
      print(alljobs1);

      alljobs1['all'].forEach((k, v) => allJobsList.add(Applied(k)));
      print("-------------------------------------------------");
      print(allJobsList);
      print("-------------------------------------------------");
      alljobs['all'].addAll(alljobs1['all']);
      print(alljobs['all'][allJobsList[0].toString()]);
      print("-------------------------------------------------");
    } on FormatException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
    setState(() {
      isDataLoadProgress = false;
    });
  }

  bool isScrolling = true;
  late ScrollController _controller;
  bool isDataLoadProgress = false;
  @override
  void initState() {
    gettingFavJobsIds();
    gettingAllJobs();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        isDataLoadProgress = true;
        isScrolling = false;
        gettingAllJobsLoop();
        // getProducts();
      });
    } else {
      setState(() {
        isScrolling = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      appBar: AppBar(
          backgroundColor: const Color(0xfff7f9fc),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              'Companies',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                color: const Color(0xff1d1d1d),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    height: 75,
                    width: 75,
                    // color: const Color(0xff707070),

                    child: Image(
                      image: NetworkImage(
                        "https://www.myjobscentre.com/storage/products/${widget.logo}",
                      ),
                    ),
                    // child: CircleAvatar(
                    //   backgroundColor: const Color(0xffffffff),
                    //   backgroundImage: NetworkImage(
                    //     "https://www.myjobscentre.com/storage/products/${img}",
                    //   ),
                    //   radius: 15,
                    // ),
                  ),
                ),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 20),
                      child: Text(
                        widget.compName,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          color: const Color(0xff1d1d1d),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                    //   child: Text(
                    //     'Since 2020',
                    //     style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       fontSize: 12,
                    //       color: const Color(0xff1d1d1d),
                    //     ),
                    //     textAlign: TextAlign.left,
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${widget.jobsPosted} Jobs posted',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: const Color(0xff1d1d1d),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ]),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MarkdownBody(
                  data: html2md.convert(widget.description),
                ),
                SizedBox(
                  height: 20,
                ),
                SocialLink(
                  link: widget.companyLink,
                ),

                // Padding(
                //   padding: EdgeInsets.only(top: 10, left: 30),
                //   child: Text(
                //     'Jobs Posted',
                //     style: TextStyle(
                //       fontFamily: 'Poppins',
                //       fontSize: 18,
                //       color: Colors.black,
                //     ),
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Jobs Posted',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: const Color(0xff1d1d1d),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
                SingleChildScrollView(
                  controller: _controller,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            if (isAllJobsEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height * 0.15),
                                child: Text(
                                  "No Jobs Found For Your Country",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: const Color(0xff1d1d1d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            for (int i = 0; i < allJobsList.length; i++)
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => JobDetailsScreen(
                                                isApplyShow: true,
                                                company: alljobs['all']
                                                        [allJobsList[i].toString()]
                                                    ['company_name'],
                                                title: alljobs['all']
                                                        [allJobsList[i].toString()]
                                                    ['product_name'],
                                                city: alljobs['all']
                                                        [allJobsList[i].toString()]
                                                    ['location'],
                                                country: alljobs['all']
                                                        [allJobsList[i].toString()]
                                                    ['country'],
                                                type: alljobs['all']
                                                        [allJobsList[i].toString()]
                                                    ['product_type'],
                                                date: alljobs['all']
                                                        [allJobsList[i].toString()]
                                                    ['created_at'],
                                                view: alljobs['all']
                                                    [allJobsList[i].toString()]['view'],
                                                minSal: alljobs['all']
                                                        [allJobsList[i].toString()]
                                                    ['salary_min'],
                                                maxSal: alljobs['all']
                                                        [allJobsList[i].toString()]
                                                    ['salary_max'],
                                                // currency: currencyFeat[i]
                                                //     .toString(),
                                                salType: alljobs['all']
                                                        [allJobsList[i].toString()]
                                                    ['salary_type'],
                                                description: alljobs['all']
                                                        [allJobsList[i].toString()]
                                                    ['description'],
                                                img: alljobs['all']
                                                        [allJobsList[i].toString()]
                                                    ['company_image'],
                                                idChat: alljobs['all']
                                                        [allJobsList[i].toString()]
                                                    ['user_id'],
                                                jobID: alljobs['all']
                                                    [allJobsList[i].toString()]['id'],
                                                isFav: favIdsRec.contains(alljobs['all']
                                                    [allJobsList[i].toString()]['id']),
                                                link: alljobs['all']
                                                            [allJobsList[i].toString()]
                                                        ['link']
                                                    .toString(),
                                              )));
                                },
                                child: FavItemComponentWidget(
                                  isFav: favIdsRec.contains(
                                      alljobs['all'][allJobsList[i].toString()]['id']),
                                  // isFav: (favJobsIdsAlready
                                  //         .contains(prodAdIddFeat[i]))
                                  //     ? true
                                  //     : false,

                                  city: alljobs['all'][allJobsList[i].toString()]
                                          ['location']
                                      .toString(),
                                  country: alljobs['all'][allJobsList[i].toString()]
                                      ['country'],
                                  date: alljobs['all'][allJobsList[i].toString()]
                                      ['created_at'],
                                  description: alljobs['all'][allJobsList[i].toString()]
                                      ['description'],
                                  maxSal: alljobs['all'][allJobsList[i].toString()]
                                      ['salary_max'],
                                  minSal: alljobs['all'][allJobsList[i].toString()]
                                      ['salary_min'],
                                  title: alljobs['all'][allJobsList[i].toString()]
                                      ['product_name'],
                                  type: alljobs['all'][allJobsList[i].toString()]
                                      ['product_type'],
                                  view: alljobs['all'][allJobsList[i].toString()]['view'],
                                  img: alljobs['all'][allJobsList[i].toString()]
                                      ['company_image'],
                                  salType: alljobs['all'][allJobsList[i].toString()]
                                      ['salary_type'],
                                  // currency:
                                  //     currencyFeat[i].toString(),
                                  prodID: alljobs['all'][allJobsList[i].toString()]
                                      ['product_type'],
                                  msgId: alljobs['all'][allJobsList[i].toString()]
                                      ['user_id'],
                                  jobId: alljobs['all'][allJobsList[i].toString()]['id'],
                                  feature: alljobs['all'][allJobsList[i].toString()]
                                      ['featured'],
                                  highlight: alljobs['all'][allJobsList[i].toString()]
                                      ['highlight'],
                                  urgent: alljobs['all'][allJobsList[i].toString()]
                                      ['urgent'],
                                ),
                              ),
                            isDataLoadProgress
                                ? CupertinoActivityIndicator(
                                    radius: 15,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Component351(),
                // FavItemComponentWidget(isFav: false),
                // FavItemComponentWidget(isFav: false),
                SizedBox(
                  height: 10,
                ),
                // SocialLink(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

const String _svg_vaojpw =
    '<svg viewBox="16.0 64.0 9.3 16.2" ><path transform="translate(4.75, 57.81)" d="M 14.0435905456543 14.29483032226562 L 20.17609024047852 8.167134284973145 C 20.62966156005859 7.713561058044434 20.62966156005859 6.980021953582764 20.17609024047852 6.531252384185791 C 19.7225170135498 6.07767915725708 18.98897743225098 6.082482814788818 18.53540420532227 6.531252384185791 L 11.58770942687988 13.47483253479004 C 11.14854526519775 13.91399383544922 11.13893890380859 14.61802864074707 11.55408477783203 15.07159996032715 L 18.53060150146484 22.06252670288086 C 18.75704574584961 22.28896903991699 19.05622673034668 22.40013313293457 19.35060119628906 22.40013313293457 C 19.64497756958008 22.40013313293457 19.94415664672852 22.28896903991699 20.17060089111328 22.06252670288086 C 20.62417221069336 21.60895347595215 20.62417221069336 20.87541389465332 20.17060089111328 20.42664337158203 L 14.0435905456543 14.29483032226562 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bme130 =
    '<svg viewBox="-380.0 1374.7 47.9 47.9" ><path transform="translate(-380.0, 1375.0)" d="M 0 40.6427001953125 L 0 24.83767700195312 L 25.13120269775391 -0.2935253381729126 L 47.93605041503906 -0.2935253381729126 L 0 47.64252471923828 L 0 40.6427001953125 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_v141r =
    '<svg viewBox="23.0 4.0 1.3 4.0" ><path transform="translate(23.0, 4.0)" d="M 0 0 L 0 4 C 0.8047311305999756 3.661223411560059 1.328037977218628 2.873133182525635 1.328037977218628 2 C 1.328037977218628 1.126866698265076 0.8047311305999756 0.3387765288352966 0 0" fill="#000000" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ltg2cz =
    '<svg viewBox="315.7 17.3 15.3 11.0" ><path transform="translate(315.69, 17.33)" d="M 7.41510009765625 10.87290000915527 L 5.417099952697754 8.856900215148926 C 5.355900287628174 8.796600341796875 5.321700096130371 8.712900161743164 5.323500156402588 8.626500129699707 C 5.325300216674805 8.54010009765625 5.363100051879883 8.458200454711914 5.427000045776367 8.400600433349609 C 6.702300071716309 7.321500301361084 8.570700645446777 7.321500301361084 9.846000671386719 8.400600433349609 C 9.910799980163574 8.458200454711914 9.947700500488281 8.54010009765625 9.94950008392334 8.626500129699707 C 9.951300621032715 8.712900161743164 9.917099952697754 8.796600341796875 9.855899810791016 8.856900215148926 L 7.857900142669678 10.87290000915527 C 7.799400329589844 10.93230056762695 7.720200061798096 10.96560001373291 7.636500358581543 10.96560001373291 C 7.553699970245361 10.96560001373291 7.473600387573242 10.93230056762695 7.41510009765625 10.87290000915527 Z M 10.93050003051758 7.343100070953369 C 10.02780055999756 6.525900363922119 8.85420036315918 6.073200225830078 7.636500358581543 6.073200225830078 C 6.419700145721436 6.073200225830078 5.247000217437744 6.525900363922119 4.345200061798096 7.343100070953369 C 4.222800254821777 7.458300113677979 4.030200004577637 7.456500053405762 3.911400079727173 7.336800098419189 L 2.757600069046021 6.170400142669678 C 2.696400165557861 6.109200000762939 2.662199974060059 6.026400089263916 2.663100004196167 5.940000057220459 C 2.664000034332275 5.853600025177002 2.699100017547607 5.771699905395508 2.761199951171875 5.711400032043457 C 5.509799957275391 3.154500007629395 9.765900611877441 3.154500007629395 12.51360034942627 5.711400032043457 C 12.5757007598877 5.771699905395508 12.6117000579834 5.853600025177002 12.61260032653809 5.940000057220459 C 12.61350059509277 6.026400089263916 12.57929992675781 6.109200000762939 12.51900005340576 6.170400142669678 L 11.36430072784424 7.336800098419189 C 11.30341243743896 7.397687435150146 11.22391605377197 7.428067684173584 11.14436626434326 7.428062438964844 C 11.06752777099609 7.428057193756104 10.99063968658447 7.399701595306396 10.93050003051758 7.343100070953369 Z M 13.59000015258789 4.655700206756592 C 11.98350048065186 3.129300117492676 9.852300643920898 2.276999950408936 7.636500358581543 2.276999950408936 C 5.420700073242188 2.276999950408936 3.289499998092651 3.128400087356567 1.683000087738037 4.655700206756592 C 1.562399983406067 4.773600101470947 1.368900060653687 4.77180004119873 1.249199986457825 4.652100086212158 L 0.09360000491142273 3.485700130462646 C 0.0333000011742115 3.424499988555908 -0.0009000000427477062 3.342600107192993 0 3.257100105285645 C 0.0009000000427477062 3.171600103378296 0.03510000184178352 3.089699983596802 0.09630000591278076 3.029400110244751 C 4.310999870300293 -1.00980007648468 10.96110057830811 -1.00980007648468 15.17670059204102 3.029400110244751 C 15.23700046539307 3.089699983596802 15.2721004486084 3.171600103378296 15.2721004486084 3.257100105285645 C 15.27300071716309 3.342600107192993 15.23880004882812 3.424499988555908 15.17850017547607 3.485700130462646 L 14.02290058135986 4.652100086212158 C 13.96281909942627 4.712636947631836 13.88365459442139 4.743017196655273 13.80445384979248 4.743010520935059 C 13.72704887390137 4.743004322052002 13.64960861206055 4.713973522186279 13.59000015258789 4.655700206756592 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_renyrk =
    '<svg viewBox="293.7 17.7 17.0 10.7" ><path transform="translate(293.67, 17.67)" d="M 15.00030040740967 10.6668004989624 C 14.44770050048828 10.6668004989624 14.00040054321289 10.21860027313232 14.00040054321289 9.666900634765625 L 14.00040054321289 0.9999000430107117 C 14.00040054321289 0.4473000168800354 14.44770050048828 0 15.00030040740967 0 L 16.00020027160645 0 C 16.55190086364746 0 17.00010108947754 0.4473000168800354 17.00010108947754 0.9999000430107117 L 17.00010108947754 9.666900634765625 C 17.00010108947754 10.21860027313232 16.55190086364746 10.6668004989624 16.00020027160645 10.6668004989624 L 15.00030040740967 10.6668004989624 Z M 10.33290004730225 10.6668004989624 C 9.781200408935547 10.6668004989624 9.333000183105469 10.21860027313232 9.333000183105469 9.666900634765625 L 9.333000183105469 3.333600044250488 C 9.333000183105469 2.781000137329102 9.781200408935547 2.333699941635132 10.33290004730225 2.333699941635132 L 11.33370018005371 2.333699941635132 C 11.88539981842041 2.333699941635132 12.33360004425049 2.781000137329102 12.33360004425049 3.333600044250488 L 12.33360004425049 9.666900634765625 C 12.33360004425049 10.21860027313232 11.88539981842041 10.6668004989624 11.33370018005371 10.6668004989624 L 10.33290004730225 10.6668004989624 Z M 5.666399955749512 10.6668004989624 C 5.114700317382812 10.6668004989624 4.666500091552734 10.21860027313232 4.666500091552734 9.666900634765625 L 4.666500091552734 5.666399955749512 C 4.666500091552734 5.114700317382812 5.114700317382812 4.666500091552734 5.666399955749512 4.666500091552734 L 6.666300296783447 4.666500091552734 C 7.218900203704834 4.666500091552734 7.667099952697754 5.114700317382812 7.667099952697754 5.666399955749512 L 7.667099952697754 9.666900634765625 C 7.667099952697754 10.21860027313232 7.218900203704834 10.6668004989624 6.666300296783447 10.6668004989624 L 5.666399955749512 10.6668004989624 Z M 0.9999000430107117 10.6668004989624 C 0.4473000168800354 10.6668004989624 0 10.21860027313232 0 9.666900634765625 L 0 7.667099952697754 C 0 7.114500045776367 0.4473000168800354 6.666300296783447 0.9999000430107117 6.666300296783447 L 1.999800086021423 6.666300296783447 C 2.5524001121521 6.666300296783447 2.99970006942749 7.114500045776367 2.99970006942749 7.667099952697754 L 2.99970006942749 9.666900634765625 C 2.99970006942749 10.21860027313232 2.5524001121521 10.6668004989624 1.999800086021423 10.6668004989624 L 0.9999000430107117 10.6668004989624 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_h3rtnl =
    '<svg viewBox="8.6 12.7 22.9 14.6" ><path transform="translate(-100.92, -149.57)" d="M 117.5024108886719 171.0801086425781 L 121.0796737670898 171.0801086425781 C 120.451789855957 172.8552093505859 118.7510833740234 174.1279449462891 116.760383605957 174.1134185791016 C 114.3447570800781 174.0955963134766 112.3470153808594 172.1631011962891 112.2534255981445 169.7491149902344 C 112.152961730957 167.1616058349609 114.2288208007812 165.0242614746094 116.7942810058594 165.0242614746094 C 117.9674911499023 165.0242614746094 119.0380325317383 165.4713745117188 119.8450622558594 166.2037963867188 C 120.0363159179688 166.3772277832031 120.3270950317383 166.3784790039062 120.5152206420898 166.2013854980469 L 121.8291320800781 164.9650573730469 C 122.0346755981445 164.7716064453125 122.0353012084961 164.4448852539062 121.8303833007812 164.2509918212891 C 120.550537109375 163.0381774902344 118.8335800170898 162.2823791503906 116.9401473999023 162.2455902099609 C 112.9018630981445 162.1665344238281 109.4978790283203 165.4776306152344 109.4698333740234 169.5166931152344 C 109.4413146972656 173.5862121582031 112.7315521240234 176.8939514160156 116.7942810058594 176.8939514160156 C 120.7016296386719 176.8939514160156 123.893424987793 173.8346557617188 124.107177734375 169.9810638427734 C 124.1128005981445 169.9327087402344 124.1166305541992 168.2998199462891 124.1166305541992 168.2998199462891 L 117.5024871826172 168.2998199462891 C 117.2313919067383 168.2998199462891 117.0117111206055 168.5195617675781 117.0117111206055 168.7905883789062 L 117.0117111206055 170.5893402099609 C 117.0116271972656 170.8603668212891 117.2313919067383 171.0801086425781 117.5024108886719 171.0801086425781 L 117.5024108886719 171.0801086425781 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-291.85, -197.14)" d="M 321.1119995117188 216.0335998535156 L 321.1119995117188 214.2760314941406 C 321.1119995117188 214.0384521484375 320.9195861816406 213.8460083007812 320.6820373535156 213.8460083007812 L 319.2027893066406 213.8460083007812 C 318.9652404785156 213.8460083007812 318.7726745605469 214.0384521484375 318.7726745605469 214.2760314941406 L 318.7726745605469 216.0335998535156 L 317.0154724121094 216.0335998535156 C 316.7778930664062 216.0335998535156 316.5849914550781 216.2260131835938 316.5849914550781 216.4637756347656 L 316.5849914550781 217.9428100585938 C 316.5849914550781 218.1802368164062 316.7777404785156 218.3729553222656 317.0154724121094 218.3729553222656 L 318.7726745605469 218.3729553222656 L 318.7726745605469 220.1303100585938 C 318.7726745605469 220.3678894042969 318.965087890625 220.5604553222656 319.2027893066406 220.5604553222656 L 320.6820373535156 220.5604553222656 C 320.9195861816406 220.5604553222656 321.1119995117188 220.3678894042969 321.1119995117188 220.1303100585938 L 321.1119995117188 218.3729553222656 L 322.86962890625 218.3729553222656 C 323.1070251464844 218.3729553222656 323.2997436523438 218.1802368164062 323.2997436523438 217.9428100585938 L 323.2997436523438 216.4637756347656 C 323.2997436523438 216.2261657714844 323.1070251464844 216.0335998535156 322.86962890625 216.0335998535156 L 321.1119995117188 216.0335998535156 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_u16n0j =
    '<svg viewBox="8.6 14.6 22.9 10.8" ><path transform="translate(-100.92, -172.08)" d="M 120.3009719848633 192.0845794677734 C 120.3009719848633 195.0758361816406 117.8758163452148 197.5009918212891 114.8845672607422 197.5009918212891 C 111.8929214477539 197.5009918212891 109.4680023193359 195.0758361816406 109.4680023193359 192.0845794677734 C 109.4680023193359 189.0929412841797 111.8929214477539 186.6679992675781 114.8845672607422 186.6679992675781 C 117.8756637573242 186.6681823730469 120.3009719848633 189.0931091308594 120.3009719848633 192.0845794677734 L 120.3009719848633 192.0845794677734 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-243.25, -172.08)" d="M 274.7011108398438 192.0845794677734 C 274.7011108398438 195.0758361816406 272.2760314941406 197.5009918212891 269.2845764160156 197.5009918212891 C 266.2930908203125 197.5009918212891 263.8680114746094 195.0758361816406 263.8680114746094 192.0845794677734 C 263.8680114746094 189.0929412841797 266.2930908203125 186.6679992675781 269.2845764160156 186.6679992675781 C 272.2760314941406 186.6679992675781 274.7011108398438 189.0931091308594 274.7011108398438 192.0845794677734 L 274.7011108398438 192.0845794677734 Z" fill="#ca237b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_w9p1n =
    '<svg viewBox="0.0 0.0 22.9 22.9" ><path transform="translate(-109.47, -109.47)" d="M 129.2784881591797 109.4659957885742 L 112.5531311035156 109.4659957885742 C 110.8493041992188 109.4659957885742 109.4679794311523 110.8472442626953 109.4679794311523 112.551155090332 L 109.4679794311523 129.2765045166016 C 109.4679794311523 130.9804840087891 110.8492279052734 132.3616638183594 112.5531311035156 132.3616638183594 L 120.801872253418 132.3616638183594 L 120.8161697387695 124.1802673339844 L 118.6903915405273 124.1802673339844 C 118.4141311645508 124.1802673339844 118.1899108886719 123.9568405151367 118.1889877319336 123.6805801391602 L 118.1785888671875 121.0431594848633 C 118.1774978637695 120.7655944824219 118.4025726318359 120.5397338867188 118.6801452636719 120.5397338867188 L 120.8021774291992 120.5397338867188 L 120.8021774291992 117.991455078125 C 120.8021774291992 115.0342712402344 122.6082763671875 113.4240341186523 125.246223449707 113.4240341186523 L 127.4110717773438 113.4240341186523 C 127.6878662109375 113.4240341186523 127.9126358032227 113.6485748291016 127.9126358032227 113.9256057739258 L 127.9126358032227 116.1492691040039 C 127.9126358032227 116.4263076782227 127.688102722168 116.6508331298828 127.411376953125 116.6508331298828 L 126.0828094482422 116.6516189575195 C 124.648193359375 116.6516189575195 124.3702239990234 117.3332595825195 124.3702239990234 118.333869934082 L 124.3702239990234 120.5400466918945 L 127.5226364135742 120.5400466918945 C 127.8232574462891 120.5400466918945 128.0562286376953 120.802375793457 128.0206909179688 121.1004333496094 L 127.7081069946289 123.7378540039062 C 127.678337097168 123.990348815918 127.4641876220703 124.180419921875 127.2100601196289 124.180419921875 L 124.3844451904297 124.180419921875 L 124.3701400756836 132.3621368408203 L 129.2784271240234 132.3621368408203 C 130.9822387695312 132.3621368408203 132.3635559082031 130.9807281494141 132.3635559082031 129.2769012451172 L 132.3635559082031 112.551155090332 C 132.3636474609375 110.8473205566406 130.9823150634766 109.4659957885742 129.2784881591797 109.4659957885742 L 129.2784881591797 109.4659957885742 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-242.96, -283.09)" d="M 254.2977142333984 305.9894104003906 L 254.3119964599609 297.8080139160156 L 254.2770080566406 297.8080139160156 L 254.2770080566406 305.9894104003906 L 254.2977142333984 305.9894104003906 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_q84bc4 =
    '<svg viewBox="0.0 0.0 22.9 22.9" ><path transform="translate(-109.47, -109.47)" d="M 125.5429153442383 109.4680023193359 L 116.2886276245117 109.4680023193359 C 112.5276870727539 109.4680023193359 109.4680023193359 112.5276870727539 109.4680023193359 116.2886276245117 L 109.4680023193359 125.5429153442383 C 109.4680023193359 129.3037109375 112.5276870727539 132.3636169433594 116.288703918457 132.3636169433594 L 125.5430145263672 132.3636169433594 C 129.3037719726562 132.3636169433594 132.3637084960938 129.3038635253906 132.3637084960938 125.5429153442383 L 132.3637084960938 116.2886276245117 C 132.3636169433594 112.5276870727539 129.3038635253906 109.4680023193359 125.5429153442383 109.4680023193359 L 125.5429153442383 109.4680023193359 Z M 130.0603485107422 125.5429916381836 C 130.0603485107422 128.037841796875 128.037841796875 130.0603485107422 125.5429916381836 130.0603485107422 L 116.288703918457 130.0603485107422 C 113.7938613891602 130.0603485107422 111.7713623046875 128.037841796875 111.7713623046875 125.5429916381836 L 111.7713623046875 116.288703918457 C 111.7713623046875 113.7938613891602 113.7938613891602 111.7712860107422 116.288703918457 111.7712860107422 L 125.5429916381836 111.7712860107422 C 128.037841796875 111.7712860107422 130.0603485107422 113.7939453125 130.0603485107422 116.288703918457 L 130.0603485107422 125.5429916381836 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-174.68, -174.68)" d="M 186.1237182617188 180.2019958496094 C 182.8585510253906 180.2019958496094 180.2019958496094 182.8585510253906 180.2019958496094 186.1237182617188 C 180.2019958496094 189.3886413574219 182.8585510253906 192.0451965332031 186.1237182617188 192.0451965332031 C 189.3888854980469 192.0451965332031 192.0451965332031 189.3888549804688 192.0451965332031 186.1237182617188 C 192.0451965332031 182.8585510253906 189.3888854980469 180.2019958496094 186.1237182617188 180.2019958496094 L 186.1237182617188 180.2019958496094 Z M 186.1237182617188 189.7419128417969 C 184.1253662109375 189.7419128417969 182.5052795410156 188.1221618652344 182.5052795410156 186.1237182617188 C 182.5052795410156 184.1252746582031 184.1253662109375 182.5052795410156 186.1237182617188 182.5052795410156 C 188.1220703125 182.5052795410156 189.7419128417969 184.1251831054688 189.7419128417969 186.1237182617188 C 189.7419128417969 188.1220703125 188.1220703125 189.7419128417969 186.1237182617188 189.7419128417969 L 186.1237182617188 189.7419128417969 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_e3e7he =
    '<svg viewBox="8.6 10.5 22.9 19.0" ><path transform="translate(-100.91, -123.64)" d="M 131.9972839355469 136.3293762207031 C 131.4884643554688 136.5550689697266 130.9604949951172 136.7330474853516 130.4185333251953 136.8618011474609 C 131.0157318115234 136.2945404052734 131.4646301269531 135.5847778320312 131.7178344726562 134.7927398681641 C 131.7901611328125 134.5667114257812 131.5444793701172 134.3710174560547 131.34033203125 134.4921112060547 C 130.58642578125 134.9393768310547 129.7743988037109 135.2746124267578 128.9267425537109 135.4891357421875 C 128.877685546875 135.5016479492188 128.8270568847656 135.5078887939453 128.7760314941406 135.5078887939453 C 128.6214294433594 135.5078887939453 128.4716644287109 135.4506225585938 128.3533020019531 135.3465576171875 C 127.4515762329102 134.5517120361328 126.2915802001953 134.1139831542969 125.0872802734375 134.1139831542969 C 124.566032409668 134.1139831542969 124.0400161743164 134.1952362060547 123.5235366821289 134.35546875 C 121.9229888916016 134.851806640625 120.68798828125 136.1721801757812 120.3003311157227 137.801025390625 C 120.1550216674805 138.4118041992188 120.1157989501953 139.0235137939453 120.1834487915039 139.6185150146484 C 120.191032409668 139.6869506835938 120.1589279174805 139.734619140625 120.1390075683594 139.7569580078125 C 120.1038513183594 139.7961730957031 120.054313659668 139.8187408447266 120.0026779174805 139.8187408447266 C 119.9970474243164 139.8187408447266 119.9909591674805 139.8185119628906 119.9851684570312 139.8179779052734 C 116.4815826416016 139.4923400878906 113.3221206665039 137.8045349121094 111.0891494750977 135.0650787353516 C 110.9754943847656 134.9253082275391 110.7568969726562 134.9425048828125 110.6661148071289 135.0980377197266 C 110.2289199829102 135.8485107421875 109.9978332519531 136.7065582275391 109.9978332519531 137.5797729492188 C 109.9978332519531 138.9178161621094 110.53564453125 140.1789855957031 111.4694747924805 141.0984497070312 C 111.0767364501953 141.0052337646484 110.6965713500977 140.8585968017578 110.343376159668 140.662353515625 C 110.1724395751953 140.5675048828125 109.9623718261719 140.689697265625 109.9599380493164 140.8850708007812 C 109.9357223510742 142.8729705810547 111.0996398925781 144.6418762207031 112.8431396484375 145.4383544921875 C 112.8079833984375 145.4391479492188 112.7728271484375 145.439453125 112.7376708984375 145.439453125 C 112.4613418579102 145.439453125 112.1813354492188 145.4130401611328 111.9060363769531 145.3601684570312 C 111.7136154174805 145.3236694335938 111.5519714355469 145.5060119628906 111.6116638183594 145.6924285888672 C 112.1777496337891 147.4594573974609 113.6989135742188 148.7617950439453 115.5195465087891 149.0572662353516 C 114.0086975097656 150.0715637207031 112.2490005493164 150.6064910888672 110.4178237915039 150.6064910888672 L 109.8470458984375 150.6062622070312 C 109.6708755493164 150.6062622070312 109.5220489501953 150.7210083007812 109.4775161743164 150.8914031982422 C 109.4333801269531 151.0589752197266 109.5145568847656 151.2361755371094 109.6647033691406 151.3234405517578 C 111.728141784668 152.5243682861328 114.0819702148438 153.1589813232422 116.4723510742188 153.1589813232422 C 118.5648574829102 153.1589813232422 120.5222091674805 152.7439117431641 122.2900161743164 151.9247589111328 C 123.9107208251953 151.174072265625 125.3428268432617 150.1009368896484 126.5467300415039 148.7351531982422 C 127.6683731079102 147.4628143310547 128.5452575683594 145.994140625 129.1533813476562 144.3696136474609 C 129.73291015625 142.8214874267578 130.039306640625 141.1690673828125 130.039306640625 139.5919494628906 L 130.039306640625 139.5166473388672 C 130.039306640625 139.2634429931641 130.1537780761719 139.0251617431641 130.3536987304688 138.8627319335938 C 131.1119689941406 138.2469482421875 131.7724456787109 137.5222625732422 132.3163452148438 136.7086791992188 C 132.4600830078125 136.4939880371094 132.2335205078125 136.224609375 131.9972839355469 136.3293762207031 L 131.9972839355469 136.3293762207031 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_f4zfwr =
    '<svg viewBox="0.0 0.0 22.9 23.1" ><path transform="translate(-109.47, -108.28)" d="M 120.3556137084961 108.2893981933594 C 114.2595901489258 108.5794067382812 109.4490432739258 113.6562652587891 109.4674072265625 119.7590026855469 C 109.4730224609375 121.6177520751953 109.9217834472656 123.3722076416016 110.7135009765625 124.9226837158203 L 109.4981079101562 130.8222198486328 C 109.4324035644531 131.1414337158203 109.72021484375 131.4208831787109 110.0372543334961 131.3457336425781 L 115.8180999755859 129.9762115478516 C 117.3033447265625 130.7161407470703 118.9715423583984 131.1433258056641 120.7370071411133 131.1702575683594 C 126.9677124023438 131.2654876708984 132.1628723144531 126.3183135986328 132.3573303222656 120.0898590087891 C 132.5652923583984 113.4134674072266 127.0551452636719 107.9702606201172 120.3556137084961 108.2893981933594 L 120.3556137084961 108.2893981933594 Z M 127.2535095214844 126.0619812011719 C 125.5606079101562 127.7548675537109 123.3095092773438 128.6872863769531 120.9152069091797 128.6872863769531 C 119.5133361816406 128.6872863769531 118.1709899902344 128.3726959228516 116.9256820678711 127.7524566650391 L 116.1208343505859 127.3513488769531 L 112.5763168334961 128.1909637451172 L 113.3223266601562 124.5694122314453 L 112.9258422851562 123.7926177978516 C 112.2792739868164 122.5265045166016 111.9514617919922 121.1576080322266 111.9514617919922 119.7235412597656 C 111.9514617919922 117.3291778564453 112.8838806152344 115.0783233642578 114.5767822265625 113.3852691650391 C 116.2545852661133 111.7072906494141 118.5423278808594 110.7599639892578 120.9153747558594 110.7599639892578 C 123.3094329833984 110.7599639892578 125.5605239868164 111.6923675537109 127.25341796875 113.3852691650391 C 128.9463043212891 115.0781555175781 129.8787231445312 117.3292388916016 129.8787231445312 119.7233123779297 C 129.8788757324219 122.0964508056641 128.9313812255859 124.3841094970703 127.2535095214844 126.0619812011719 L 127.2535095214844 126.0619812011719 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-176.49, -178.25)" d="M 193.4964294433594 192.1759643554688 L 191.2789306640625 191.5393371582031 C 190.9875793457031 191.455810546875 190.6735229492188 191.5385437011719 190.4610900878906 191.7549438476562 L 189.9187622070312 192.3073120117188 C 189.690185546875 192.5404357910156 189.3432922363281 192.6152038574219 189.0406494140625 192.4927673339844 C 187.9916687011719 192.0682373046875 185.7850341796875 190.106201171875 185.2218322753906 189.1251220703125 C 185.0589904785156 188.8419799804688 185.0859680175781 188.4882507324219 185.28564453125 188.2296447753906 L 185.7589416503906 187.6172180175781 C 185.9443969726562 187.3773803710938 185.9834594726562 187.0549621582031 185.8608703613281 186.7776184082031 L 184.9280090332031 184.6676025390625 C 184.7045593261719 184.1622924804688 184.0587768554688 184.0151062011719 183.6368103027344 184.3719787597656 C 183.0179748535156 184.8955078125 182.28369140625 185.6907348632812 182.1945495605469 186.5719909667969 C 182.0371398925781 188.1256713867188 182.7035217285156 190.0840148925781 185.2228393554688 192.4356689453125 C 188.133544921875 195.1526794433594 190.4645385742188 195.5113525390625 191.9824523925781 195.143798828125 C 192.8432922363281 194.9354248046875 193.5312805175781 194.0996398925781 193.9651794433594 193.4151916503906 C 194.2613525390625 192.9482421875 194.0272827148438 192.3285522460938 193.4964294433594 192.1759643554688 L 193.4964294433594 192.1759643554688 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_dctma9 =
    '<svg viewBox="8.6 8.6 22.9 22.9" ><path transform="translate(-100.92, -100.91)" d="M 132.3586120605469 121.2504425048828 C 132.5452575683594 114.7176361083984 127.2575988769531 109.3735656738281 120.7451782226562 109.4683380126953 C 114.4771270751953 109.5593566894531 109.4200134277344 114.73583984375 109.4679870605469 121.0043487548828 C 109.50244140625 125.4960632324219 112.1237716674805 129.3713836669922 115.915641784668 131.2153778076172 C 116.1349411010742 131.3219299316406 116.388916015625 131.1559906005859 116.3796310424805 130.9123229980469 C 116.35205078125 130.1759033203125 116.3758697509766 129.3884124755859 116.523063659668 128.7555236816406 C 116.6683731079102 128.1323089599609 117.2372817993164 125.7220916748047 117.611572265625 124.1387939453125 C 117.7936935424805 123.3678588867188 117.8157272338867 122.5674743652344 117.669075012207 121.7891845703125 C 117.6208801269531 121.5337982177734 117.5861129760742 121.23388671875 117.5861129760742 120.9001312255859 C 117.5861129760742 119.2081756591797 118.5668106079102 117.9449768066406 119.7879791259766 117.9449768066406 C 120.8261108398438 117.9449768066406 121.3275146484375 118.7245025634766 121.3275146484375 119.6591949462891 C 121.3275146484375 120.7030944824219 120.66259765625 122.2640380859375 120.3197021484375 123.7107543945312 C 120.0329895019531 124.9217681884766 120.9271240234375 125.9095001220703 122.12158203125 125.9095001220703 C 124.2843933105469 125.9095001220703 125.9467315673828 123.6291198730469 125.9467315673828 120.3370819091797 C 125.9467315673828 117.4236450195312 123.853141784668 115.3867645263672 120.8639221191406 115.3867645263672 C 117.4017333984375 115.3867645263672 115.3693923950195 117.9835662841797 115.3693923950195 120.66748046875 C 115.3693923950195 121.7132568359375 115.7723541259766 122.8345794677734 116.275016784668 123.4441833496094 C 116.3743896484375 123.5647430419922 116.3890762329102 123.6705932617188 116.359619140625 123.7932586669922 C 116.267204284668 124.1776275634766 116.0619659423828 125.0040283203125 116.0215759277344 125.1731719970703 C 115.9685363769531 125.3959197998047 115.8451690673828 125.4431762695312 115.6147003173828 125.3361511230469 C 114.094856262207 124.6286468505859 113.1445465087891 122.4068450927734 113.1445465087891 120.6217651367188 C 113.1445465087891 116.7834167480469 115.9335327148438 113.2582550048828 121.184700012207 113.2582550048828 C 125.4059600830078 113.2582550048828 128.6864929199219 116.2662200927734 128.6864929199219 120.2863006591797 C 128.6864929199219 124.4798126220703 126.0420455932617 127.8550415039062 122.3718872070312 127.8550415039062 C 121.4020462036133 127.8550415039062 120.4777526855469 127.4585571289062 119.9345474243164 126.9213104248047 C 119.7672805786133 126.7560729980469 119.48486328125 126.8312835693359 119.4251708984375 127.0585632324219 C 119.2337646484375 127.7877044677734 118.9245529174805 128.9670867919922 118.8250122070312 129.3502807617188 C 118.645637512207 130.0403594970703 118.267448425293 130.8438720703125 117.8881378173828 131.5437164306641 C 117.7875137329102 131.7295837402344 117.8894653320312 131.9595031738281 118.0943145751953 132.0116119384766 C 119.0300903320312 132.2487945556641 120.0115051269531 132.3712158203125 121.0233764648438 132.3620758056641 C 127.0306396484375 132.3064575195312 132.1867370605469 127.2552947998047 132.3586120605469 121.2504425048828 L 132.3586120605469 121.2504425048828 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_pm5oh =
    '<svg viewBox="8.6 11.9 22.9 16.2" ><path transform="translate(-100.94, -140.43)" d="M 127.6357116699219 152.3329925537109 L 114.2530670166016 152.3329925537109 C 111.62744140625 152.3329925537109 109.4989929199219 154.4615173339844 109.4989929199219 157.0870666503906 L 109.4989929199219 163.7770690917969 C 109.4989929199219 166.4026794433594 111.6275177001953 168.5311279296875 114.2530670166016 168.5311279296875 L 127.6357116699219 168.5311279296875 C 130.2613372802734 168.5311279296875 132.3897705078125 166.4026184082031 132.3897705078125 163.7770690917969 L 132.3897705078125 157.0870666503906 C 132.3897857666016 154.4615173339844 130.2612609863281 152.3329925537109 127.6357116699219 152.3329925537109 L 127.6357116699219 152.3329925537109 Z M 124.4204864501953 160.7575225830078 L 118.1611022949219 163.7428436279297 C 117.9942321777344 163.8224487304688 117.8014984130859 163.7009582519531 117.8014984130859 163.5162048339844 L 117.8014984130859 157.3588562011719 C 117.8014984130859 157.1713562011719 117.9993133544922 157.0498657226562 118.1663360595703 157.1346435546875 L 124.4257202148438 160.3065948486328 C 124.6121215820312 160.40087890625 124.6087646484375 160.6678466796875 124.4204864501953 160.7575225830078 L 124.4204864501953 160.7575225830078 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
