import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Component34.dart';

class NotificationNew extends StatefulWidget {
  const NotificationNew({Key? key}) : super(key: key);

  @override
  _NotificationNewState createState() => _NotificationNewState();
}

class _NotificationNewState extends State<NotificationNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: const Color(0xff1d1d1d),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xfff7f9fc),
        centerTitle: true,
      ),
      body: Stack(
        children: [
         ListView.builder(
           itemCount: 3,
             itemBuilder: (BuildContext context, int index){
             return ListTile(
               leading: CircleAvatar(
                 radius: MediaQuery.of(context).size.width * 0.055,
                 backgroundImage: AssetImage('assets/join.jpg'),
               ),
               title: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                     'Chris Jacob',
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: MediaQuery.of(context).size.width * 0.045,
                       fontWeight: FontWeight.w400,
                     ),
                   ),
                   Text(
                     '9.43 a.m',
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: MediaQuery.of(context).size.width * 0.03,
                       fontWeight: FontWeight.w400,
                     ),
                   ),

                 ],
               ),
               subtitle: Text(
                 'Has selected you',
                 style: TextStyle(
                   color: Colors.grey.shade500,
                   fontSize: MediaQuery.of(context).size.width * 0.035,
                   fontWeight: FontWeight.w400,
                 ),
               ),
               onTap: (){

               },

             );
             }),

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              child: SizedBox(
                height: 60,
                child: Component34(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
