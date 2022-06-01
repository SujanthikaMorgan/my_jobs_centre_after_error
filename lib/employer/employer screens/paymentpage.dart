// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/employer/employer%20screens/membership.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _value = false;
  int val = -1;
  featureAdd(detail, subdetail, Color clr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 15, top: 15),
            child: Text(
              detail,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            )),
        Padding(
          padding: EdgeInsets.only(right: 30, top: 10),
          child: Text(
            subdetail,
            style: TextStyle(
                fontFamily: 'Poppins',
                color: clr,
                fontSize: 18,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => MembershipPage()));
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.grey.shade300,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: Center(
                    child: Text(
                      'Package Summary',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: const Color(0xff1d1d1d),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                featureAdd('Membership', 'Basic', Colors.black),
                featureAdd('Start Date', '22-01-2023', Colors.black),
                featureAdd('Expiry Date', '22-02-2023', Colors.black),
                featureAdd('Total Cost', '£5.00 GBP', Colors.red),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    color: Colors.grey.shade300,
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Center(
                      child: Text(
                        'Payment Method',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: const Color(0xff1d1d1d),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 20),
                  child: ListTile(
                    title: Text(
                      "Credit/ Debit Card",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    leading: Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value as int;
                          _value = true;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                  ),
                ),
                _value == true
                    ? Padding(
                        padding: EdgeInsets.only(top: 15, left: 15),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'Card Number',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'MM/YYYY',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'CVV',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
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
                                  onPressed: () {},
                                  child: Text(
                                    "Confirm and Pay",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: const Color(0xfff7f9fc),
                                      letterSpacing: 0.7000000000000001,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
