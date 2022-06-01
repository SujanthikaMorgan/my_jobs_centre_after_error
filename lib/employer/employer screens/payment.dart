import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Screens/HomeJob.dart';
import '../../globalVariables.dart';
import 'jobPost.dart';

class Payment extends StatefulWidget {
  static const String idScreen = "Payment";
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.5,
            ),
            const Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: 40,
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Success!',
                style: TextStyle(
                    fontSize: 28, color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'You have Successfully completed the payment',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      width: MediaQuery.of(context).size.width * 0.001,
                      color: const Color(0xffdd312d)),
                  elevation: MediaQuery.of(context).size.width * 0.1,
                  primary: const Color(0xffdd312d),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.01,
                    ),
                  ),
                ),
                onPressed: () {
                  if (userDetailsResponse["user_type"] == "employer") {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => JobPost()));
                  } else {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomeJob()));
                  }
                },
                child: Text(
                  "Ok",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: const Color(0xfff7f9fc),
                    letterSpacing: 0.7000000000000001,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
