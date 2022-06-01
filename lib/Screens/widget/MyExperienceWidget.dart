import 'package:adobe_xd/pinned.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyExperienceWidget extends StatefulWidget {
  static const String idScreen = "MyExperienceWidget";
  final String title;
  final String comp;
  final String desc;
  const MyExperienceWidget(
      {Key? key, required this.title, required this.comp, required this.desc})
      : super(key: key);

  @override
  _MyExperienceWidgetState createState() => _MyExperienceWidgetState();
}

class _MyExperienceWidgetState extends State<MyExperienceWidget> {
  late TextEditingController _controllerExp;
  String jobrole = 'Manager';
  String company = 'AAAA';
  bool isExpEnabled = false;

  String Experience = 'I worked .............';
  @override
  void initState() {
    _controllerExp = TextEditingController(
      text: widget.desc,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          children: <Widget>[
            //name and image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: widget.title,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                        fontSize: 17,
                        color: const Color(0xff132144),
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: " - " + widget.comp,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: const Color(0xff788198),
                            fontWeight: FontWeight.w500,
                          ),
                          // textAlign: TextAlign.left,
                          // overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),

                  // child: Text(
                  //   widget.title,
                  //   style: TextStyle(
                  //     decoration: TextDecoration.none,
                  //     fontFamily: 'Poppins',
                  //     fontSize: 15,
                  //     color: const Color(0xff132144),
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  //   textAlign: TextAlign.left,
                  //   overflow: TextOverflow.clip,
                  // ),
                ),
                // Expanded(
                //   child: Text(
                //     widget.comp,
                //     style: TextStyle(
                //       decoration: TextDecoration.none,
                //       fontFamily: 'Poppins',
                //       fontSize: 15,
                //       color: const Color(0xff788198),
                //       fontWeight: FontWeight.w500,
                //     ),
                //     textAlign: TextAlign.left,
                //     overflow: TextOverflow.clip,
                //   ),
                // ),
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpEnabled = true;
                            });
                          },
                          child: Icon(
                            Icons.edit,
                            color: const Color(0xffdd312d),
                            size: 15,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 18.0,
                          height: 18.0,
                          child:
                              // Adobe XD layer: 'vuesax/bold/trash' (group)
                              Stack(
                            children: <Widget>[
                              SizedBox(
                                width: 18.0,
                                height: 18.0,
                                child:
                                    // Adobe XD layer: 'trash' (group)
                                    Stack(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      width: 18.0,
                                      height: 18.0,
                                      child: SvgPicture.string(
                                        _svg_ldex,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 5),
              child: Container(
                  height: 200,
                  width: 340,
                  color: Colors.white,
                  child: TextFormField(
                    controller: _controllerExp,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: const Color(0xff707070),
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      enabled: isExpEnabled,
                      border: InputBorder.none,
                      hintText: 'AboutMe',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: const Color(0xff707070),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    minLines: 13,
                    maxLines: 13,
                  )

                  // Text(
                  //   widget.desc,
                  // style: TextStyle(
                  //   fontFamily: 'Poppins',
                  //   fontSize: 12,
                  //   color: const Color(0xff707070),
                  //   fontWeight: FontWeight.w300,
                  // ),
                  //   textAlign: TextAlign.left,
                  // ),
                  ),
            ),
            // Column(
            //   children: <Widget>[
            //     Padding(
            //       padding: EdgeInsets.only(top: 10, left: 5),
            //       child: Container(
            //         height: 200,
            //         width: 340,
            //         color: Colors.white,
            //         child: Text(
            //           widget.desc,
            //           style: TextStyle(
            //             fontFamily: 'Poppins',
            //             fontSize: 12,
            //             color: const Color(0xff707070),
            //             fontWeight: FontWeight.w300,
            //           ),
            //           textAlign: TextAlign.left,
            //         ),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  /*Widget buildBasicListView() => ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(UrlImage),
              radius: 100,
            ),
            title: Text(
              name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: const Color(0xff132144),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
            subtitle: Text(
              Designation,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: const Color(0xff788198),
                // fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      );
*/
}

const String _svg_ldex =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="translate(1.68, 0.94)" d="M 14.1176815032959 2.985000133514404 C 12.91018104553223 2.865000009536743 11.70268058776855 2.775000095367432 10.48768138885498 2.707499980926514 L 10.48768138885498 2.699999809265137 L 10.32268142700195 1.724999904632568 C 10.21018218994141 1.034999847412109 10.04518127441406 0 8.290182113647461 0 L 6.32518196105957 0 C 4.577681541442871 0 4.412681102752686 0.9899999499320984 4.292681217193604 1.717499971389771 L 4.135181427001953 2.677500247955322 C 3.437681674957275 2.722500085830688 2.740181446075439 2.767500162124634 2.042681455612183 2.835000038146973 L 0.5126816630363464 2.985000133514404 C 0.1976817101240158 3.014999866485596 -0.02731834538280964 3.292500257492065 0.002681654412299395 3.600000143051147 C 0.0326816514134407 3.907500028610229 0.3026816248893738 4.132499694824219 0.6176815629005432 4.102499961853027 L 2.147681713104248 3.952499866485596 C 6.077681541442871 3.5625 10.03768253326416 3.712499856948853 14.01268196105957 4.110000133514404 C 14.03518295288086 4.110000133514404 14.0501823425293 4.110000133514404 14.07268238067627 4.110000133514404 C 14.35768127441406 4.110000133514404 14.60518169403076 3.892499923706055 14.63518238067627 3.600000143051147 C 14.65768241882324 3.292500257492065 14.43268203735352 3.014999866485596 14.1176815032959 2.985000133514404 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(3.32, 5.81)" d="M 11.10151100158691 0.2925002574920654 C 10.92151069641113 0.1050002574920654 10.67401123046875 0 10.41901111602783 0 L 0.9390113353729248 0 C 0.6840113401412964 0 0.4290114045143127 0.1050002574920654 0.256511390209198 0.2925002574920654 C 0.08401141315698624 0.4800002574920654 -0.01348869316279888 0.7349998950958252 0.001511306501924992 0.997499942779541 L 0.4665115475654602 8.692500114440918 C 0.5490115880966187 9.832500457763672 0.6540114283561707 11.25749969482422 3.271511554718018 11.25749969482422 L 8.086511611938477 11.25749969482422 C 10.70401096343994 11.25749969482422 10.80901145935059 9.840000152587891 10.89151191711426 8.692500114440918 L 11.35651111602783 1.005000114440918 C 11.37151145935059 0.7350001335144043 11.27401065826416 0.4800002574920654 11.10151100158691 0.2925002574920654 Z M 6.92401123046875 7.5 L 4.426511287689209 7.5 C 4.119011402130127 7.5 3.864011287689209 7.244999885559082 3.864011287689209 6.9375 C 3.864011287689209 6.630000114440918 4.119011402130127 6.375 4.426511287689209 6.375 L 6.92401123046875 6.375 C 7.231511116027832 6.375 7.48651123046875 6.630000114440918 7.48651123046875 6.9375 C 7.48651123046875 7.244999885559082 7.231511116027832 7.5 6.92401123046875 7.5 Z M 7.554011344909668 4.5 L 3.804011344909668 4.5 C 3.496511459350586 4.5 3.241511344909668 4.244999885559082 3.241511344909668 3.9375 C 3.241511344909668 3.630000114440918 3.496511459350586 3.375 3.804011344909668 3.375 L 7.554011344909668 3.375 C 7.86151123046875 3.375 8.116511344909668 3.630000114440918 8.116511344909668 3.9375 C 8.116511344909668 4.244999885559082 7.86151123046875 4.5 7.554011344909668 4.5 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 18.0, 18.0)" d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_e5b09 =
    '<svg viewBox="2.6 4.5 9.7 9.7" ><path transform="translate(2.62, 4.54)" d="M 9.087133407592773 4.109999656677246 C 8.869632720947266 4.00499963760376 8.659633636474609 3.899999856948853 8.457134246826172 3.779999971389771 C 8.292133331298828 3.682499885559082 8.134634017944336 3.577499866485596 7.977133750915527 3.464999914169312 C 7.84963321685791 3.382499694824219 7.69963264465332 3.262499570846558 7.557133197784424 3.142499685287476 C 7.54213285446167 3.134999513626099 7.489633083343506 3.089999914169312 7.429633140563965 3.029999971389771 C 7.182133197784424 2.819999933242798 6.904633522033691 2.550000190734863 6.657133102416992 2.25 C 6.634633541107178 2.235000133514404 6.597133636474609 2.182499647140503 6.544633865356445 2.114999771118164 C 6.469633102416992 2.024999856948853 6.342133522033691 1.874999642372131 6.229633331298828 1.702499628067017 C 6.139633655548096 1.589999556541443 6.034633636474609 1.424999952316284 5.937133312225342 1.259999871253967 C 5.81713342666626 1.057499885559082 5.712133407592773 0.8549997210502625 5.607133865356445 0.6449997425079346 C 5.502133846282959 0.4199997186660767 5.419633388519287 0.2025000154972076 5.344633102416992 0 L 0.6346337199211121 4.710000038146973 C 0.5371336936950684 4.807499885559082 0.4471335411071777 4.994999885559082 0.4246335625648499 5.122499942779541 L 0.019633574411273 7.994998931884766 C -0.05536642670631409 8.504999160766602 0.08713377267122269 8.98499870300293 0.4021337628364563 9.307498931884766 C 0.6721338033676147 9.569999694824219 1.047133445739746 9.712499618530273 1.452133417129517 9.712499618530273 C 1.542133331298828 9.712499618530273 1.632133722305298 9.704999923706055 1.722133636474609 9.689999580383301 L 4.602133750915527 9.284999847412109 C 4.737133502960205 9.262500762939453 4.924633979797363 9.172499656677246 5.014633655548096 9.074999809265137 L 9.724632263183594 4.364999771118164 C 9.514633178710938 4.289999961853027 9.3121337890625 4.207499504089355 9.087133407592773 4.109999656677246 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_cqu3l =
    '<svg viewBox="1.7 15.4 14.6 1.1" ><path transform="translate(1.69, 15.38)" d="M 14.0625 1.125 L 0.5625 1.125 C 0.2549999952316284 1.125 0 0.8700000047683716 0 0.5625 C 0 0.2549999952316284 0.2549999952316284 0 0.5625 0 L 14.0625 0 C 14.36999988555908 0 14.625 0.2549999952316284 14.625 0.5625 C 14.625 0.8700000047683716 14.36999988555908 1.125 14.0625 1.125 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xp8yp4 =
    '<svg viewBox="8.9 1.5 6.5 6.5" ><path transform="translate(8.9, 1.5)" d="M 5.366496562957764 1.10535717010498 C 3.911496639251709 -0.3496428728103638 2.486495733261108 -0.3871428370475769 0.9939957857131958 1.10535717010498 L 0.08649574220180511 2.012857437133789 C 0.01149573922157288 2.087857246398926 -0.01850382797420025 2.207857370376587 0.0114961713552475 2.312857389450073 C 0.5814961791038513 4.300357341766357 2.171495914459229 5.89035701751709 4.158996105194092 6.460357189178467 C 4.188996315002441 6.467857360839844 4.218997001647949 6.475357532501221 4.248996734619141 6.475357532501221 C 4.331496715545654 6.475357532501221 4.406496047973633 6.445357322692871 4.466495990753174 6.385357856750488 L 5.366496562957764 5.47785758972168 C 6.108996391296387 4.742857456207275 6.468996047973633 4.030357360839844 6.468996047973633 3.310357332229614 C 6.47649621963501 2.567857265472412 6.116496562957764 1.847857117652893 5.366496562957764 1.10535717010498 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xuqqdp =
    '<svg viewBox="0.0 0.0 18.0 18.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 18.0, 18.0)" d="M 0 0 L 18 0 L 18 18 L 0 18 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_zeifyo =
    '<svg viewBox="128.5 217.1 1.0 29.9" ><path transform="translate(128.5, 217.06)" d="M 0 0 L 0 29.8818359375" fill="none" fill-opacity="0.5" stroke="#dd312d" stroke-width="1" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
