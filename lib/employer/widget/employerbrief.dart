import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployerBrief extends StatelessWidget {
  const EmployerBrief({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 135.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xfff7f9fc),
          ),
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 100.h,
                              width: 70.w,
                              child: const Image(
                                image: AssetImage(
                                  "assets/pro.jpg",
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "Michael Dowl",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.7,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.red,
                                  size: 18.sp,
                                ),
                                Text(
                                  " London, England",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 13.sp,
                                    color: const Color(0xff788198),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.7,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timelapse_rounded,
                                  color: Colors.red,
                                  size: 18.sp,
                                ),
                                Text(
                                  " Member Since: 20 Aug 2021",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 13.sp,
                                    color: const Color(0xff788198),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.7,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Share ",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.7,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Container(
                                  height: 15.h,
                                  width: 15.w,
                                  color: Colors.red,
                                  child: Center(
                                    child: Icon(
                                      Icons.mail,
                                      color: Colors.white,
                                      size: 10.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Container(
                                  height: 15.h,
                                  width: 15.w,
                                  // color: Colors.blue.shade900,
                                  child: SvgPicture.string(
                                    fb,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Container(
                                  height: 15.h,
                                  width: 15.w,
                                  // color: Colors.blue,
                                  child: SvgPicture.string(
                                    twitter,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Container(
                                  height: 15.h,
                                  width: 15.w,
                                  //color: Colors.blue.shade800,
                                  child: SvgPicture.string(
                                    linkedin,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Container(
                                  height: 15.h,
                                  width: 15.w,
                                  // color: Colors.red.shade800,
                                  child: SvgPicture.string(
                                    pinterest,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Container(
                                  height: 15.h,
                                  width: 15.w,
                                  //color: Colors.green,
                                  child: SvgPicture.string(
                                    whatsapp,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
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
          ),
        ),
      ),
    );
  }
}

const String fb =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="0.88em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 448 512"><rect x="0" y="0" width="448" height="512" fill="none" stroke="none" /><path d="M400 32H48A48 48 0 0 0 0 80v352a48 48 0 0 0 48 48h137.25V327.69h-63V256h63v-54.64c0-62.15 37-96.48 93.67-96.48c27.14 0 55.52 4.84 55.52 4.84v61h-31.27c-30.81 0-40.42 19.12-40.42 38.73V256h68.78l-11 71.69h-57.78V480H400a48 48 0 0 0 48-48V80a48 48 0 0 0-48-48z" fill="#0d47a1"/></svg>';
const String twitter =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1024 1024"><rect x="0" y="0" width="1024" height="1024" fill="none" stroke="none" /><path d="M880 112H144c-17.7 0-32 14.3-32 32v736c0 17.7 14.3 32 32 32h736c17.7 0 32-14.3 32-32V144c0-17.7-14.3-32-32-32zM727.3 401.7c.3 4.7.3 9.6.3 14.4c0 146.8-111.8 315.9-316.1 315.9c-63 0-121.4-18.3-170.6-49.8c9 1 17.6 1.4 26.8 1.4c52 0 99.8-17.6 137.9-47.4c-48.8-1-89.8-33-103.8-77c17.1 2.5 32.5 2.5 50.1-2a111 111 0 0 1-88.9-109v-1.4c14.7 8.3 32 13.4 50.1 14.1a111.13 111.13 0 0 1-49.5-92.4c0-20.7 5.4-39.6 15.1-56a315.28 315.28 0 0 0 229 116.1C492 353.1 548.4 292 616.2 292c32 0 60.8 13.4 81.1 35c25.1-4.7 49.1-14.1 70.5-26.7c-8.3 25.7-25.7 47.4-48.8 61.1c22.4-2.4 44-8.6 64-17.3c-15.1 22.2-34 41.9-55.7 57.6z" fill="#2196f3"/></svg>';
const String linkedin =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="0.88em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 448 512"><rect x="0" y="0" width="448" height="512" fill="none" stroke="none" /><path d="M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5c0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7c-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5c67.2 0 79.7 44.3 79.7 101.9V416z" fill="#1565c0"/></svg>';
const String pinterest =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="0.88em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 448 512"><rect x="0" y="0" width="448" height="512" fill="none" stroke="none" /><path d="M448 80v352c0 26.5-21.5 48-48 48H154.4c9.8-16.4 22.4-40 27.4-59.3c3-11.5 15.3-58.4 15.3-58.4c8 15.3 31.4 28.2 56.3 28.2c74.1 0 127.4-68.1 127.4-152.7c0-81.1-66.2-141.8-151.4-141.8c-106 0-162.2 71.1-162.2 148.6c0 36 19.2 80.8 49.8 95.1c4.7 2.2 7.1 1.2 8.2-3.3c.8-3.4 5-20.1 6.8-27.8c.6-2.5.3-4.6-1.7-7c-10.1-12.3-18.3-34.9-18.3-56c0-54.2 41-106.6 110.9-106.6c60.3 0 102.6 41.1 102.6 99.9c0 66.4-33.5 112.4-77.2 112.4c-24.1 0-42.1-19.9-36.4-44.4c6.9-29.2 20.3-60.7 20.3-81.8c0-53-75.5-45.7-75.5 25c0 21.7 7.3 36.5 7.3 36.5c-31.4 132.8-36.1 134.5-29.6 192.6l2.2.8H48c-26.5 0-48-21.5-48-48V80c0-26.5 21.5-48 48-48h352c26.5 0 48 21.5 48 48z" fill="#c62828"/></svg>';
const String whatsapp =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><path d="M12.043 6.925a4.985 4.985 0 0 0-4.98 4.979c-.001.94.263 1.856.761 2.649l.118.188l-.503 1.837l1.885-.494l.181.108a4.97 4.97 0 0 0 2.535.693h.001a4.986 4.986 0 0 0 4.979-4.978a4.946 4.946 0 0 0-1.456-3.522a4.946 4.946 0 0 0-3.521-1.46zm2.928 7.118c-.125.35-.723.668-1.01.711a2.044 2.044 0 0 1-.943-.059a8.51 8.51 0 0 1-.853-.315c-1.502-.648-2.482-2.159-2.558-2.26c-.074-.1-.61-.812-.61-1.548c0-.737.386-1.099.523-1.249a.552.552 0 0 1 .4-.186c.1 0 .199.001.287.005c.092.004.215-.035.336.257c.125.3.425 1.036.462 1.111c.037.074.062.162.013.262c-.05.101-.074.162-.15.25c-.074.088-.157.195-.224.263c-.075.074-.153.155-.066.305c.088.149.388.64.832 1.037c.572.51 1.055.667 1.204.743c.15.074.237.063.325-.038c.087-.101.374-.437.474-.586c.1-.15.199-.125.337-.076c.137.051.873.412 1.022.487c.148.074.249.112.287.175c.036.062.036.361-.088.711z" fill="#43a047"/><path d="M20 3H4a1 1 0 0 0-1 1v16a1 1 0 0 0 1 1h16a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1zm-7.96 14.896h-.002a5.98 5.98 0 0 1-2.862-.729L6 18l.85-3.104a5.991 5.991 0 0 1 5.19-8.983a5.95 5.95 0 0 1 4.238 1.757a5.95 5.95 0 0 1 1.751 4.237a5.998 5.998 0 0 1-5.989 5.989z" fill="#43a047"/></svg>';
