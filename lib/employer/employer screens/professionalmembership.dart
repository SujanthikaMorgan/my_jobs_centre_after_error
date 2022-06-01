import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_jobs_center/employer/employer%20screens/paymentpage.dart';

class ProfessionalMembership extends StatelessWidget {
  const ProfessionalMembership({Key? key}) : super(key: key);

  featureAdd(feature, icon) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: SizedBox(
                width: 20,
                height: 20,
                child: SvgPicture.string(
                  icon,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  feature,
                  maxLines: 2,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 15),
                    child: Text(
                      'Professional',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      color: Colors.grey.shade300,
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 100),
                            child: Center(
                              child: Text(
                                '£15.00',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.red,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Center(
                              child: Text(
                                '/Monthly',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 15),
                    child: Text(
                      'Features of Professional',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  featureAdd('Ad Post Limit : 50', check),
                  featureAdd('Ad expiry in : 90 days', check),
                  featureAdd('Featured ad fee £10.00 for 20 days', check),
                  featureAdd('Urgent ad fee £10.00 for 20 days', check),
                  featureAdd('Highlight ad fee £10.00 for 20 days', check),
                  featureAdd('Top in search results and category', close),
                  featureAdd('Show ad on home page premium ad section', check),
                  featureAdd('Show ad on home page search result list', check),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 35),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width - 84,
                        minHeight: 45,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentPage()));
                          },
                          child: Text(
                            "Upgrade",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
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
        Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Swipe Right>>>',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  color: Colors.black,
                  letterSpacing: 0.7000000000000001,
                  fontWeight: FontWeight.w600),
            )),
      ],
    );
  }
}

String close =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1024 1024"><rect x="0" y="0" width="1024" height="1024" fill="none" stroke="none" /><path d="M685.4 354.8c0-4.4-3.6-8-8-8l-66 .3L512 465.6l-99.3-118.4l-66.1-.3c-4.4 0-8 3.5-8 8c0 1.9.7 3.7 1.9 5.2l130.1 155L340.5 670a8.32 8.32 0 0 0-1.9 5.2c0 4.4 3.6 8 8 8l66.1-.3L512 564.4l99.3 118.4l66 .3c4.4 0 8-3.5 8-8c0-1.9-.7-3.7-1.9-5.2L553.5 515l130.1-155c1.2-1.4 1.8-3.3 1.8-5.2z" fill="#cc2229"/><path d="M512 65C264.6 65 64 265.6 64 513s200.6 448 448 448s448-200.6 448-448S759.4 65 512 65zm0 820c-205.4 0-372-166.6-372-372s166.6-372 372-372s372 166.6 372 372s-166.6 372-372 372z" fill="#cc2229"/></svg>';
String check =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><g fill="none" stroke="#53ed5d" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><path d="M22 4L12 14.01l-3-3"/></g></svg>';
