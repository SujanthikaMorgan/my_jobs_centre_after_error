import 'package:adobe_xd/pinned.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Component351.dart';

class HighilightedJobsWidget extends StatelessWidget {
  const HighilightedJobsWidget({
    required this.logo,
    required this.name,
    required this.jobs,
    required this.colorBg,
  });

  final String logo;
  final String name;
  final String jobs;
  final Color colorBg;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Container(
            // height: 127,
            width: 113,
            decoration: BoxDecoration(
              border: Border.all(
                color: colorBg,
              ),
              color: colorBg,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        // color: Color(0xff707070),
                        // height: 30,
                        // decoration: BoxDecoration(image: ),
                        child: Image(
                          height: 30,
                          image: NetworkImage(
                              "https://www.myjobscentre.com/storage/products/${logo}"),
                          // color: const Color(0xfff3f3f3),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        name,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        jobs + ' Jobs',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

const String _svg_bme130 =
    '<svg viewBox="-380.0 1374.7 47.9 47.9" ><path transform="translate(-380.0, 1375.0)" d="M 0 40.6427001953125 L 0 24.83767700195312 L 25.13120269775391 -0.2935253381729126 L 47.93605041503906 -0.2935253381729126 L 0 47.64252471923828 L 0 40.6427001953125 Z" fill="#dd312d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xlspp =
    '<svg viewBox="20.0 304.0 127.0 113.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="0" stdDeviation="8"/></filter></defs><path transform="translate(20.0, 304.0)" d="M 5 0 L 122 0 C 124.7614212036133 0 127 2.238576173782349 127 5 L 127 108 C 127 110.7614212036133 124.7614212036133 113 122 113 L 5 113 C 2.238576173782349 113 0 110.7614212036133 0 108 L 0 5 C 0 2.238576173782349 2.238576173782349 0 5 0 Z" fill="#a3cb37" stroke="none" stroke-width="0.05000000074505806" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_pt9xjt =
    '<svg viewBox="16.6 80.0 8.5 20.2" ><path transform="translate(-106.75, 0.0)" d="M 130.3666076660156 80.07009887695312 C 129.2938842773438 79.77210998535156 128.1826019287109 80.40020751953125 127.8844833374023 81.47305297851562 L 123.4041061401367 97.60207366943359 C 123.1061248779297 98.67491912841797 123.7342147827148 99.78620910644531 124.8070678710938 100.0841903686523 C 124.9875793457031 100.1343231201172 125.1691589355469 100.1582489013672 125.3477935791016 100.1582489013672 C 126.2308502197266 100.1582489013672 127.0413360595703 99.57357788085938 127.2891845703125 98.68123626708984 L 131.7695617675781 82.55221557617188 C 132.0675354003906 81.47950744628906 131.439453125 80.36808013916016 130.3666076660156 80.07009887695312 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_tv8ew =
    '<svg viewBox="0.0 80.0 10.8 20.2" ><path transform="translate(0.0, 0.0)" d="M 10.02565956115723 80.46522521972656 C 9.169476509094238 79.75312805175781 7.898241996765137 79.87006378173828 7.186414241790771 80.72624969482422 L 0.4659900963306427 88.80796051025391 C -0.1563212424516678 89.55634307861328 -0.1552459895610809 90.64236450195312 0.4686782658100128 91.389404296875 L 7.189102649688721 99.43671417236328 C 7.587892532348633 99.91426086425781 8.160741806030273 100.1606369018555 8.737622261047363 100.1606369018555 C 9.193401336669922 100.1606369018555 9.651735305786133 100.0068740844727 10.02888584136963 99.69195556640625 C 10.88358879089355 98.97824859619141 10.99783611297607 97.70674133300781 10.2841272354126 96.8521728515625 L 4.64071798324585 90.09451293945312 L 10.28681564331055 83.30460357666016 C 10.99864196777344 82.44828796386719 10.88170623779297 81.17705535888672 10.02565956115723 80.46522521972656 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jzph6d =
    '<svg viewBox="30.9 80.0 10.8 20.2" ><path transform="translate(-199.09, 0.0)" d="M 240.2836761474609 88.77164459228516 L 233.5632476806641 80.72447204589844 C 232.8495483398438 79.86977386474609 231.5780334472656 79.75566101074219 230.7234649658203 80.46936798095703 C 229.8687591552734 81.18307495117188 229.7546539306641 82.45458221435547 230.4683532714844 83.30915069580078 L 236.1117706298828 90.06680297851562 L 230.4656677246094 96.85671997070312 C 229.7537078857422 97.71289825439453 229.8706359863281 98.98413848876953 230.7266845703125 99.69596099853516 C 231.1033020019531 100.0092697143555 231.5602874755859 100.1619567871094 232.0147247314453 100.1619567871094 C 232.5930786132812 100.1619567871094 233.1672821044922 99.91437530517578 233.5659484863281 99.43480682373047 L 240.2863616943359 91.35308837890625 C 240.9086761474609 90.60457611083984 240.9075927734375 89.5185546875 240.2836761474609 88.77164459228516 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
