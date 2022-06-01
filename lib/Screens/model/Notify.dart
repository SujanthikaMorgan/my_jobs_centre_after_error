import 'package:adobe_xd/page_link.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_jobs_center/Screens/Component34.dart';
import 'package:my_jobs_center/Screens/data/notify_items.dart';
import 'package:my_jobs_center/Screens/model/notify_list.dart';
import 'package:my_jobs_center/Screens/widget/Notification_Widget.dart';

class Notify extends StatefulWidget {
  static const String idScreen = "Notify";
  const Notify({Key? key}) : super(key: key);

  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  final List<NotifyList> items = List.from(listItems);
  final listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      body: Stack(
        children: <Widget>[
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
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(size: 389.0, middle: 0.5),
                        Pin(size: 44.0, middle: 0.5),
                        child:
                            // Adobe XD layer: 'iPhone X/Status Bar…' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(startFraction: 0.036, endFraction: 0.0),
                              Pin(startFraction: 0.0, endFraction: 0.0),
                              child:
                                  // Adobe XD layer: 'Rectangle' (shape)
                                  Container(
                                decoration: BoxDecoration(),
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
          ),
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(size: 63.0, end: 0.0),
            child: Component34(),
          ),
          Pinned.fromPins(
            Pin(start: 16.0, end: 20.0),
            Pin(size: 25.0, start: 60.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 114.0, middle: 0.5083),
                  Pin(start: 0.0, end: 0.0),
                  child: Text(
                    'Notifications',
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
                  Pin(size: 9.3, start: 0.0),
                  Pin(size: 16.2, middle: 0.4549),
                  child: PageLink(
                    links: [
                      PageLinkInfo(),
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
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: AnimatedList(
              key: listKey,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) => NotificationWidget(
                item: items[index],
                animation: animation,
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 20.0, end: 20.0),
            Pin(size: 1.0, start: 158.5),
            child: SvgPicture.string(
              _svg_o2uim6,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 20.0, end: 20.0),
            Pin(size: 1.0, middle: 0.2616),
            child: SvgPicture.string(
              _svg_sh2gu,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 20.0, end: 20.0),
            Pin(size: 1.0, middle: 0.3339),
            child: SvgPicture.string(
              _svg_kakuiq,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 20.0, end: 20.0),
            Pin(size: 1.0, middle: 0.4075),
            child: SvgPicture.string(
              _svg_dv7nem,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 20.0, end: 20.0),
            Pin(size: 1.0, middle: 0.481),
            child: SvgPicture.string(
              _svg_n03wn6,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 20.0, end: 20.0),
            Pin(size: 1.0, middle: 0.5546),
            child: SvgPicture.string(
              _svg_gakqv2,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_y2pd49 =
    '<svg viewBox="0.0 0.0 14.0 14.0" ><path transform="translate(1.0, 1.17)" d="M 5.833333492279053 0 C 2.619166612625122 0 0 2.619166612625122 0 5.833333492279053 C 0 9.047499656677246 2.619166612625122 11.66666698455811 5.833333492279053 11.66666698455811 C 9.047499656677246 11.66666698455811 11.66666698455811 9.047499656677246 11.66666698455811 5.833333492279053 C 11.66666698455811 2.619166612625122 9.047499656677246 0 5.833333492279053 0 Z M 8.370834350585938 7.915833473205566 C 8.289167404174805 8.05583381652832 8.143333435058594 8.131667137145996 7.991666316986084 8.131667137145996 C 7.915833473205566 8.131667137145996 7.840000152587891 8.114166259765625 7.769999980926514 8.067500114440918 L 5.961666584014893 6.988333225250244 C 5.512500762939453 6.71999979019165 5.179999828338623 6.130833625793457 5.179999828338623 5.611666679382324 L 5.179999828338623 3.220000028610229 C 5.179999828338623 2.980833292007446 5.378333568572998 2.782500028610229 5.617499828338623 2.782500028610229 C 5.856666564941406 2.782500028610229 6.054999828338623 2.980833292007446 6.054999828338623 3.220000028610229 L 6.054999828338623 5.611666679382324 C 6.054999828338623 5.821666717529297 6.229999542236328 6.130833148956299 6.410833835601807 6.235833168029785 L 8.21916675567627 7.315000057220459 C 8.429166793823242 7.4375 8.499167442321777 7.705833435058594 8.370834350585938 7.915833473205566 Z" fill="#788198" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 14.0, 14.0)" d="M 0 0 L 14 0 L 14 14 L 0 14 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_n03wn6 =
    '<svg viewBox="20.0 405.5 350.0 1.0" ><path transform="translate(20.0, 405.5)" d="M 0 0 L 350 0" fill="none" fill-opacity="0.5" stroke="#788198" stroke-width="1" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_gakqv2 =
    '<svg viewBox="20.0 467.5 350.0 1.0" ><path transform="translate(20.0, 467.5)" d="M 0 0 L 350 0" fill="none" fill-opacity="0.5" stroke="#788198" stroke-width="1" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_sh2gu =
    '<svg viewBox="20.0 220.5 350.0 1.0" ><path transform="translate(20.0, 220.5)" d="M 0 0 L 350 0" fill="none" fill-opacity="0.5" stroke="#788198" stroke-width="1" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_kakuiq =
    '<svg viewBox="20.0 281.5 350.0 1.0" ><path transform="translate(20.0, 281.5)" d="M 0 0 L 350 0" fill="none" fill-opacity="0.5" stroke="#788198" stroke-width="1" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_dv7nem =
    '<svg viewBox="20.0 343.5 350.0 1.0" ><path transform="translate(20.0, 343.5)" d="M 0 0 L 350 0" fill="none" fill-opacity="0.5" stroke="#788198" stroke-width="1" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_o2uim6 =
    '<svg viewBox="20.0 158.5 350.0 1.0" ><path transform="translate(20.0, 158.5)" d="M 0 0 L 350 0" fill="none" fill-opacity="0.5" stroke="#788198" stroke-width="1" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_vaojpw =
    '<svg viewBox="16.0 64.0 9.3 16.2" ><path transform="translate(4.75, 57.81)" d="M 14.0435905456543 14.29483032226562 L 20.17609024047852 8.167134284973145 C 20.62966156005859 7.713561058044434 20.62966156005859 6.980021953582764 20.17609024047852 6.531252384185791 C 19.7225170135498 6.07767915725708 18.98897743225098 6.082482814788818 18.53540420532227 6.531252384185791 L 11.58770942687988 13.47483253479004 C 11.14854526519775 13.91399383544922 11.13893890380859 14.61802864074707 11.55408477783203 15.07159996032715 L 18.53060150146484 22.06252670288086 C 18.75704574584961 22.28896903991699 19.05622673034668 22.40013313293457 19.35060119628906 22.40013313293457 C 19.64497756958008 22.40013313293457 19.94415664672852 22.28896903991699 20.17060089111328 22.06252670288086 C 20.62417221069336 21.60895347595215 20.62417221069336 20.87541389465332 20.17060089111328 20.42664337158203 L 14.0435905456543 14.29483032226562 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
