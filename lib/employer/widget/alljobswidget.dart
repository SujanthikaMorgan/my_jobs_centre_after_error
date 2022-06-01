import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllJobsWidget extends StatelessWidget {
  const AllJobsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100.h,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "Customer Assistant",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "West Minister Bridge Express, Tesco",
                            maxLines: 2,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              //height: 1.4166666666666667.h,
                            ),
                            textHeightBehavior: const TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.grey.shade700,
                                  size: 12.sp,
                                ),
                                Text(
                                  " Location",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Icon(
                                  Icons.timelapse_outlined,
                                  color: Colors.grey.shade700,
                                  size: 12.sp,
                                ),
                                Text(
                                  " 13 Days ago",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              width: 1.w, color: const Color(0xffdd312d)),
                          elevation: 5.0,
                          primary: const Color(0xfff7f9fc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Part Time",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            color: const Color(0xffdd312d),
                            letterSpacing: 0.7000000000000001,
                          ),
                        ),
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
