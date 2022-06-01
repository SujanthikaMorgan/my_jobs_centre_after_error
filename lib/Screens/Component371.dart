import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Component371 extends StatelessWidget {
  Component371({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromPins(
          Pin(size: 11.5, end: 0.0),
          Pin(size: 6.6, middle: 0.5863),
          child:
              // Adobe XD layer: 'ios-arrow-back' (shape)
              SvgPicture.string(
            _svg_hi574h,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromPins(
          Pin(start: 0.0, end: 15.5),
          Pin(start: 0.0, end: 0.0),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Text(
                'Search Job\nSearch Candidates\nSearch Companies',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 8,
                  color: const Color(0xff132144),
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

const String _svg_hi574h =
    '<svg viewBox="82.0 2.0 11.5 6.6" ><path transform="matrix(0.0, -1.0, 1.0, 0.0, 81.98, 8.59)" d="M 1.986209869384766 5.763458251953125 L 6.346855163574219 10.12069320678711 C 6.669376373291016 10.44321632385254 6.669376373291016 10.96481513977051 6.346855163574219 11.28392314910889 C 6.024332046508789 11.60644721984863 5.50273323059082 11.60303115844727 5.180210113525391 11.28392314910889 L 0.2399044036865234 6.346535682678223 C -0.0723724365234375 6.034260749816895 -0.07920360565185547 5.53364086151123 0.2159938812255859 5.211119651794434 L 5.176795959472656 0.2400646209716797 C 5.337812423706055 0.07904624938964844 5.55055046081543 1.9073486328125e-06 5.759872436523438 1.9073486328125e-06 C 5.969194412231445 1.9073486328125e-06 6.18193244934082 0.07904624938964844 6.342950820922852 0.2400646209716797 C 6.665472030639648 0.5625877380371094 6.665472030639648 1.084186553955078 6.342950820922852 1.403295516967773 L 1.986209869384766 5.763458251953125 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
