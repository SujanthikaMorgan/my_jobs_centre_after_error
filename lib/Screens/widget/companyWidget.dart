// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompanyWidget extends StatelessWidget {
  final String logo;
  final String companyName;
  final String description;
  final String jobs;

  const CompanyWidget(
      {Key? key,
      required this.logo,
      required this.companyName,
      required this.description,
      required this.jobs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14000000),
            offset: Offset(0, 0),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              height: 75,
              width: 75,
              // color: const Color(0xff707070),
              child: Image(
                image: NetworkImage(
                  "https://www.myjobscentre.com/storage/products/$logo",
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text(
              companyName,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'Poppins',
                fontSize: 15,
                color: const Color(0xff1d1d1d),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              description.replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), ""),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'Poppins',
                fontSize: 10,
                color: const Color(0xff6a6a6a),
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
              maxLines: 3,
            ),
          ),
          // Padding(
          //     padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          //     child: Row(children: [
          //       SizedBox(
          //           width: 16.0,
          //           height: 16.0,
          //           child: Icon(
          //             Icons.location_on_outlined,
          //             size: 20,
          //           )
          //           // Adobe XD layer: 'vuesax/linear/send-2' (group)
          //           ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Text(
          //         "London, England",
          //         style: TextStyle(
          //           fontFamily: 'Poppins',
          //           fontSize: 10,
          //           color: const Color(0xff132144),
          //         ),
          //         textAlign: TextAlign.left,
          //       )
          //     ])),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              child: Row(children: [
                SizedBox(
                  width: 16.0,
                  height: 16.0,
                  child:
                      // Adobe XD layer: 'vuesax/linear/send-2' (group)
                      Stack(
                    children: <Widget>[
                      SizedBox(
                        width: 16.0,
                        height: 16.0,
                        child:
                            // Adobe XD layer: 'send-2' (group)
                            Stack(
                          children: <Widget>[
                            SizedBox(
                              width: 16.0,
                              height: 16.0,
                              child: SvgPicture.string(
                                _svg_a36iz5,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "$jobs jobs Posted",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    color: const Color(0xff132144),
                  ),
                  textAlign: TextAlign.left,
                )
              ])),
        ],
      ),
    );
  }
}

const String _svg_a36iz5 =
    '<svg viewBox="0.0 0.0 16.0 16.0" ><path transform="translate(2.33, 2.33)" d="M 9.636074066162109 -0.7500038146972656 C 10.51387405395508 -0.7500038146972656 11.20683288574219 -0.4330965876579285 11.64004707336426 0.1664568483829498 C 12.16855430603027 0.8978894948959351 12.23235988616943 1.98788321018219 11.8197135925293 3.235636472702026 L 9.932673454284668 8.896757125854492 C 9.603713989257812 9.885376930236816 9.211427688598633 10.65979671478271 8.766794204711914 11.19825649261475 C 8.155707359313965 11.93830299377441 7.551186561584473 12.09364414215088 7.151666164398193 12.09364414215088 C 6.752146244049072 12.09364414215088 6.147626399993896 11.93830299377441 5.536540031433105 11.19825649261475 C 5.091906547546387 10.65979671478271 4.699619770050049 9.885376930236816 4.3705735206604 8.896510124206543 L 3.889715909957886 7.453926086425781 L 2.446886539459229 6.972982883453369 C -0.1942128539085388 6.094163417816162 -0.7493873834609985 4.9776291847229 -0.7500002384185791 4.195736408233643 C -0.7506132125854492 3.413383007049561 -0.1965728849172592 2.295210123062134 2.446386814117432 1.411136627197266 L 8.106886863708496 -0.4756965637207031 C 8.652927398681641 -0.6577097773551941 9.167420387268066 -0.7500038146972656 9.636074066162109 -0.7500038146972656 Z M 7.151666164398193 11.09364414215088 C 7.633206367492676 11.09364414215088 8.367414474487305 10.43351078033447 8.983907699584961 8.580777168273926 L 10.87066078186035 2.920529842376709 C 11.17942714691162 1.986862778663635 11.16493988037109 1.216375946998596 10.82949352264404 0.7521234750747681 C 10.52962684631348 0.3371098935604095 10.01499366760254 0.2499961853027344 9.636074066162109 0.2499961853027344 C 9.275100708007812 0.2499961853027344 8.867000579833984 0.3250223696231842 8.423113822937012 0.4729830324649811 L 2.763113498687744 2.359649896621704 C 0.9097466468811035 2.979603052139282 0.2496195435523987 3.714229822158813 0.2499997317790985 4.194949626922607 C 0.2503799498081207 4.675176620483398 0.910706639289856 5.40791654586792 2.762866735458374 6.024216175079346 L 4.443112850189209 6.58430290222168 C 4.592413425445557 6.634069919586182 4.709573268890381 6.751229763031006 4.759339809417725 6.900529384613037 L 5.319340229034424 8.580530166625977 C 5.935919761657715 10.43351078033447 6.670126438140869 11.09364414215088 7.151666164398193 11.09364414215088 Z" fill="#132144" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path transform="translate(6.99, 6.96)" d="M -0.2500047981739044 2.643332481384277 C -0.377747118473053 2.643332481384277 -0.5054598450660706 2.594707012176514 -0.6030594110488892 2.497380256652832 C -0.7985928058624268 2.302386999130249 -0.7990328073501587 1.985806941986084 -0.604046106338501 1.790273666381836 L 1.782620549201965 -0.6030598282814026 C 1.977613806724548 -0.7985931038856506 2.294193744659424 -0.7990331649780273 2.489727258682251 -0.6040464639663696 C 2.68526029586792 -0.4090531468391418 2.685700654983521 -0.09247313439846039 2.490714073181152 0.1030602008104324 L 0.1040472239255905 2.49639368057251 C 0.006383940577507019 2.594327449798584 -0.1218251436948776 2.643332481384277 -0.2500047981739044 2.643332481384277 Z" fill="#132144" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /><path  d="M 0 0 L 16 0 L 16 16 L 0 16 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eib3lo =
    '<svg viewBox="0.0 0.0 7.3 7.3" ><path transform="translate(-136.0, -136.0)" d="M 139.6458435058594 136 C 137.6359405517578 136 136 137.6354217529297 136 139.6458435058594 C 136 141.65625 137.6359405517578 143.2916717529297 139.6458435058594 143.2916717529297 C 141.6557312011719 143.2916717529297 143.2916717529297 141.65625 143.2916717529297 139.6458435058594 C 143.2916717529297 137.6354217529297 141.6557312011719 136 139.6458435058594 136 Z M 139.6458435058594 141.2083282470703 C 138.7843780517578 141.2083282470703 138.0833435058594 140.5072937011719 138.0833435058594 139.6458435058594 C 138.0833435058594 138.7843780517578 138.7843780517578 138.0833435058594 139.6458435058594 138.0833435058594 C 140.5072937011719 138.0833435058594 141.2083282470703 138.7843780517578 141.2083282470703 139.6458435058594 C 141.2083282470703 140.5072937011719 140.5072937011719 141.2083282470703 139.6458435058594 141.2083282470703 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
