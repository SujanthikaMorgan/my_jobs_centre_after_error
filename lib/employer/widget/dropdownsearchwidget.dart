import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/employer/widget/searchcity.dart';

class DropDownSearchWidget extends StatefulWidget {
  static const String idScreen = "dropdown";
  const DropDownSearchWidget({Key? key}) : super(key: key);

  @override
  State<DropDownSearchWidget> createState() => _DropDownSearchWidgetState();
}

class _DropDownSearchWidgetState extends State<DropDownSearchWidget> {
  var cities = ['matale', 'London', 'Kandy'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'City',
                suffixIcon: IconButton(
                    onPressed: () async {
                      final result = await showSearch(
                        context: context,
                        delegate: SearchCity(cities),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 20,
                    )),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
